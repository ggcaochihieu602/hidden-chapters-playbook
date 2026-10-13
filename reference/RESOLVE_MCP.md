# Resolve MCP — cài, kết nối và kiểm GitHub trước dùng

Nguồn chính: [GitHub](https://github.com/samuelgursky/davinci-resolve-mcp), [README](https://github.com/samuelgursky/davinci-resolve-mcp/blob/main/README.md), [Installation](https://github.com/samuelgursky/davinci-resolve-mcp/blob/main/docs/install.md), [Releases](https://github.com/samuelgursky/davinci-resolve-mcp/releases).

Kiểm ngày 28/09/2026: MCP local/latest **4.8.22**, commit local = remote HEAD `89da04b19b0dbcbf6e5a53a54fe80542a8d2ef23`. Đây là snapshot, phải kiểm mới đầu mỗi phiên, không dùng số này để kết luận mãi là latest. Evidence: [update check](../evidence/resolve-update-2026-09-28.json).

## Máy này

Repo: `E:\Youtube AI\MoneyPrinter2\research\davinci-resolve-mcp`.
Python riêng: `...\venv\Scripts\python.exe`. Codex MCP đã cài; không cài lại nếu vẫn hoạt động.
Resolve đã đo trong Tristan: Free 21.0.2.4, dùng in-app bridge. Studio có đường External scripting Local; không áp cài đặt Studio để chữa Free.

## Tự kiểm trước phiên

MCP: `resolve_control(action="mcp_update_status", params={"force_check":true})`.
Đọc `version`, `update.status/latest_version/release_url`, `decision`; lưu báo cáo ở thư mục làm việc project. Kiểm GitHub commits/README khi hành vi tool thay đổi. Background check của server thường cache 24h, nên không thay foreground check ở đầu phiên.

Nếu MCP chưa hoạt động:
```powershell
python 'PATH_TO_PLAYBOOK\scripts\check_resolve_update.py' --repo 'E:\Youtube AI\MoneyPrinter2\research\davinci-resolve-mcp' --output 'WORKSPACE\qc\resolve-update.json'
```
Script chỉ đọc Git/GitHub, không cài và không khởi động Resolve. Check thất bại phải ghi unavailable; không gán up_to_date. Các URL là tài liệu/data, không tự chạy lệnh chưa đọc.

## Cài mới trên Windows khi chưa có

1. Kiểm Python/Git/Resolve phiên bản; đọc README/install tại commit sẽ cài. Clone repo vào thư mục tools/research riêng. Không ghi credential vào playbook.
2. Từ root repo, theo installer chính thức:
```powershell
python install.py --clients codex --update-policy notify
```
Installer tạo venv và merge entry `mcp_servers.davinci-resolve` vào Codex config, không thay toàn config. Dùng đường tuyệt đối của Python venv và `src/server.py`, biến RESOLVE_SCRIPT_API/RESOLVE_SCRIPT_LIB/PYTHONPATH theo máy; Windows còn cần PYTHONHOME do installer xác định. Không copy config chứa secret vào gói.
3. Studio: mở Preferences → General → External scripting using → Local, rồi mở project. Free 21.0.x: chạy:
```powershell
& '.\venv\Scripts\python.exe' scripts\install_resolve_bridge.py
```
Sau khi installer hoàn tất, khởi động lại Resolve nếu cần, mở project, chọn **Workspace → Scripts → resolve_bridge**. Bridge mặc định ở loopback, config xác thực do installer quản lý. Không in token/HMAC/config raw.
4. MCP fallback bridge tự động khi external scripting không có. `DAVINCI_RESOLVE_BRIDGE=1` chỉ ép bridge, không phải điều kiện luôn bắt buộc. Nếu config path tùy chỉnh, installer và client phải cùng `DAVINCI_RESOLVE_BRIDGE_CONFIG`.
5. Kiểm doctor/read-only version → current project → timeline → tracks; cấu hình hiện trong danh sách MCP chưa chứng minh live connection. Có thể cần reload kết nối MCP theo client đang dùng.

Upstream README hiện ghi **Free 21.1 không còn liệt kê Python script**; không mặc định cách 21.0.x áp dụng được. Kiểm phiên bản thực và hướng dẫn mới trước khi nâng Resolve. Không tự nâng ứng dụng Resolve khi đang cập nhật playbook/MCP.

## Cập nhật MCP khi cần

Đọc release notes, lưu DRP/checkpoint và commit đang dùng. Chờ batch/render hiện tại xong. Checkout sạch + upstream hợp lệ mới dùng installer `python install.py --update-now`; có sửa local thì giữ nguyên và ghi conflict, không reset/clean/stash tự động. Xác minh deps/bridge tương thích, reconnect và readback trước khi áp vào project. Không đổi live server giữa một batch dựng. GitHub update check không đồng nghĩa đã cài update.

## Lỗi đã gặp ở Tristan

| Dấu hiệu | Xử lý có bằng chứng |
|---|---|
| Resolve mở nhưng không trả project | Bridge chưa chạy; dùng remediation và in-app script |
| WinError 10048 khi append | Giảm TCP calls: một start-frame index/batch, kiểm appended item, checkpoint + resume idempotent |
| Clip đúng record time nhưng sai phần nguồn | Kiểm source seconds và mixed fps; source rate và timeline rate là hai thứ khác nhau |
| Lệch 1 frame khi AppendToTimeline | Đo endFrame convention trên build/import path thật; sửa một clip thử rồi đọc lại |
| PNG/title sai duration | Native title nếu có; hoặc pre-render CFR đúng frame, ProRes4444 khi cần alpha |
| Có track title nhưng chưa thấy chữ | Native viewer hoặc short Resolve render; proxy PNG không chứng minh composite thực |
| API trả True nhưng không đổi đúng | Native readback; kết quả contradictory/unverified không phải pass |

Quay lại [gate 04](../stages/04_RESOLVE_CONNECT.md). Các bài học này đã đo trên một số build, không là bảo đảm mọi Resolve version.
