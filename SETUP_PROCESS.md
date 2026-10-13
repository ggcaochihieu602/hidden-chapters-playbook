# SETUP PROCESS — cài Hidden Chapters lên máy mới

File này dùng cho **cả người dùng lẫn Codex**. Làm xong thì máy mới chạy được playbook giống máy gốc: Codex điều phối, gọi Claude qua Frenemy, dựng trên DaVinci Resolve qua MCP, tạo giọng bằng OmniVoice, lấy footage từ Pexels/Pixabay/GetHinh và nhạc từ Epidemic Sound.

Thời gian: khoảng 30–60 phút, phần lớn là chờ tải (riêng model OmniVoice khoảng 3 GB).

---

## 0. Bắt đầu: dán câu này vào Codex trên máy mới

Mở Codex, chọn (hoặc tạo) **một thư mục trống làm workspace**, ví dụ `E:\Youtube AI` (khuyên dùng đúng tên này nếu máy có ổ E). Gửi cho Codex:

```
Clone repo https://github.com/ggcaochihieu602/hidden-chapters-playbook.git vào thư mục "Hidden Chapters\Playbooks\Playbook ver 33" bên trong workspace này, rồi đọc file SETUP_PROCESS.md trong đó và làm theo phần "Hướng dẫn cho Codex". Dừng lại báo tôi ở mỗi bước cần tôi đăng nhập.
```

Repo để Private nên lần clone đầu có thể hiện cửa sổ **Connect to GitHub**: chọn **Sign in with your browser**, đăng nhập tài khoản `ggcaochihieu602`.

---

## Hướng dẫn cho Codex (đọc kỹ trước khi chạy)

- Làm **đúng thứ tự** các bước 1 → 7 dưới đây. Mỗi bước chạy script có sẵn trong thư mục `setup\`; không tự viết lại việc script đã làm.
- Chạy PowerShell bằng `powershell -NoProfile -ExecutionPolicy Bypass -File "<đường dẫn script>"`.
- Script đều chạy lại được nhiều lần; lỗi mạng hay thiếu tool thì sửa nguyên nhân rồi chạy lại cùng script.
- **Không bao giờ** in, đọc ra, lưu vào file thường hay đưa vào chat: API key, token, cookie, mật khẩu. Không mở file trong `.codex\secrets`.
- Bước nào ghi "NGƯỜI DÙNG LÀM" thì dừng, nói rõ cần làm gì, chờ người dùng báo xong rồi mới đi tiếp.
- Không tự cài phần mềm trả phí, không mua gói, không đổi cài đặt bảo mật Windows.
- Kết thúc bằng `setup\verify.ps1`; chỉ báo "xong" khi không còn dòng FAIL. Dòng WARN thì giải thích ngắn cho người dùng.
- Sau khi setup xong, các phim mới làm theo `Hidden Chapters\Playbooks\LATEST.json` → `START_HERE.md` như máy gốc.

---

## Bước 1 — Yêu cầu máy (NGƯỜI DÙNG kiểm)

- Windows 10/11, có `winget` (App Installer).
- Card NVIDIA (khuyên ≥ 8 GB VRAM) để OmniVoice chạy nhanh; không có GPU vẫn chạy được nhưng rất chậm.
- Ổ đĩa trống ≥ 40 GB.
- **DaVinci Resolve** (Studio hoặc bản free) đã cài. Tải ở trang Blackmagic Design.
- **Codex** (app desktop) đã cài và đăng nhập tài khoản ChatGPT.

## Bước 2 — Lấy playbook

Repo phải nằm đúng ở `<workspace>\Hidden Chapters\Playbooks\Playbook ver 33` (câu lệnh ở bước 0 đã làm việc này). Nếu lỡ clone chỗ khác, bước 3 sẽ tự chép về đúng chỗ.

## Bước 3 — Tạo cấu trúc thư mục và cấu hình (Codex chạy)

```
powershell -NoProfile -ExecutionPolicy Bypass -File "Hidden Chapters\Playbooks\Playbook ver 33\setup\setup.ps1"
```

Script này:

- tạo cây thư mục giống máy gốc (xem cuối file);
- chép các file playbook cần ở ngoài thư mục playbook: ảnh mẫu text, logo, mẫu thumbnail, `NEW_VIDEO_PROMPT.txt`, quy tắc thumbnail, `SCRIPT_IDEAL_RULES.md`, script OmniVoice, giọng mẫu `am_adam.wav`;
- nếu workspace không phải `E:\Youtube AI` mà máy có ổ E: tạo **junction** `E:\Youtube AI` → workspace (và `E:\Tool` → `<workspace>\Tool`), để mọi đường dẫn trong playbook dùng được nguyên văn;
- nếu máy không có ổ E: ghi **bảng đổi đường dẫn** vào `<workspace>\AGENTS.md` và `LOCAL_PATHS.json` (Codex tự đọc `AGENTS.md`);
- cài skill `mp2-brief-edit` cho Codex và `LATEST.json`;
- thêm vào `%USERPROFILE%\.codex\config.toml`: tin cậy workspace và MCP `davinci-resolve` (có bản sao lưu `config.toml.bak-hc-setup`).

## Bước 4 — Cài công cụ (Codex chạy)

```
powershell -NoProfile -ExecutionPolicy Bypass -File "Hidden Chapters\Playbooks\Playbook ver 33\setup\install_tools.ps1"
```

Thêm `-ResolveFree` nếu dùng **DaVinci Resolve bản free**.

Script cài (bỏ qua cái đã có):

- Git, Node.js LTS, Python 3.12, FFmpeg (qua winget);
- Claude Code (trình cài chính thức) và Codex CLI;
- DaVinci Resolve MCP (clone `samuelgursky/davinci-resolve-mcp` vào `MoneyPrinter2\research\`, tạo venv, cài thư viện; với `-ResolveFree` cài thêm bridge chạy trong app);
- Frenemy (clone `noblehacks/frenemy` vào `Tool\frenemy`, chạy `install.ps1` để Codex gọi được Claude). Phần này cần đã đăng nhập Claude Code và Codex CLI; nếu chưa, script báo SKIP, làm bước 5 rồi chạy lại script;
- OmniVoice: venv `.voice-venv` (PyTorch CUDA 12.8 + `omnivoice==0.2.1`) và model `k2-fsa/OmniVoice` vào `data\models\omnivoice`.

## Bước 5 — Đăng nhập và cấu hình (NGƯỜI DÙNG LÀM)

Codex dừng ở đây, đưa danh sách này cho người dùng, chờ báo xong từng mục:

1. **Claude Code:** mở PowerShell, gõ `claude`, đăng nhập tài khoản Claude (gói Pro/Max). Thoát bằng `/exit`.
2. **Codex CLI:** gõ `codex`, đăng nhập ChatGPT (nếu chưa).
3. **Epidemic Sound** và **GetHinh:** mở **trình duyệt tích hợp trong Codex**, đăng nhập cả hai trang. Playbook dùng thẳng phiên đăng nhập này, không kiểm gói hay quyền.
4. **API key Pixabay và Pexels:** nhấp đúp `Hidden Chapters\Playbooks\Playbook ver 33\setup\set_api_keys.bat`, dán từng key khi được hỏi (gõ ẩn). Key được mã hoá theo tài khoản Windows, không lưu dạng chữ. Lấy key tại pixabay.com/api/docs và pexels.com/api.
5. **DaVinci Resolve:**
   - Bản **Studio**: Preferences → System → General → **External scripting using = Local**, lưu, khởi động lại Resolve.
   - Bản **free**: khởi động lại Resolve, mở một project, chọn **Workspace → Scripts → resolve_bridge** (bridge đã được bước 4 cài với `-ResolveFree`).
6. Sau khi xong 1–2: Codex chạy lại `setup\install_tools.ps1` một lần để cài Frenemy (nếu bước 4 báo SKIP).
7. **Khởi động lại Codex** để nạp MCP mới (`davinci-resolve`, `claude`) và skill.

## Bước 6 — Kiểm tra (Codex chạy)

```
powershell -NoProfile -ExecutionPolicy Bypass -File "Hidden Chapters\Playbooks\Playbook ver 33\setup\verify.ps1"
```

Phải hết FAIL. Sau đó Codex chạy 4 phép thử nhỏ, mỗi cái một lần:

1. **Claude:** gọi `ask_claude` với câu "Trả lời đúng một từ: FRENEMY_OK" → phải nhận `FRENEMY_OK`.
2. **Resolve MCP:** mở Resolve, gọi tool đọc danh sách project/timeline hiện tại → trả về không lỗi.
3. **OmniVoice:** tạo 1 câu thử ("Every story begins with a question.") theo mẫu request trong `<workspace>\AGENTS.md`, ghi ra `<workspace>\.tmp\voice-test.wav`, kiểm file có độ dài > 1 giây.
4. **Pixabay/Pexels:** chạy `scripts\search_pixabay.ps1 -Query "ocean"` và `scripts\search_pexels.ps1 -Query "ocean"` → có kết quả JSON (không in key).

Báo người dùng kết quả từng mục bằng một dòng.

## Bước 7 — Làm phim đầu tiên

Mở `Hidden Chapters\NEW_VIDEO_START.md`. Copy `Hidden Chapters\NEW_VIDEO_PROMPT.txt` vào một chat Codex mới, gửi kèm script. Từ đây mọi thứ chạy theo playbook như máy gốc.

---

## Cập nhật bản mới về sau

- Máy nào cũng chỉ cần nhấp đúp `Hidden Chapters\Playbooks\Playbook ver 33\tools\update.bat` (tự `git pull` rồi cài lại skill).
- Sửa playbook trên máy nào thì đẩy lên bằng `tools\push.bat`.

## Cấu trúc thư mục sau setup

```
<workspace>\                         (máy gốc: E:\Youtube AI)
├─ AGENTS.md                         bảng đường dẫn + hướng dẫn cho Codex (tự tạo)
├─ LOCAL_PATHS.json                  đường dẫn thực trên máy này (tự tạo)
├─ .voice-venv\                      Python cho OmniVoice
├─ data\models\omnivoice\            model + voice-presets\am_adam.wav
├─ Tool\frenemy\                     cầu nối Codex → Claude
├─ Hidden Chapters\
│  ├─ Playbooks\
│  │  ├─ LATEST.json, LATEST.md
│  │  └─ Playbook ver 33\            repo GitHub này
│  ├─ Text example\                  3 mẫu text Chapter / Location / Annotation
│  ├─ Claude script\, Script sample\, Template Studies\
│  ├─ NEW_VIDEO_PROMPT.txt, NEW_VIDEO_START.md, OUTPUT_RULES.md, AI_THUMBNAIL_PROMPT_RULES.md
│  ├─ logo.png, logo overlay.png, 4k Icon.png, Thumb Sample1-3.jpg
│  └─ YYYY-M-D-Ten-Phim\             mỗi phim một thư mục (Codex tạo khi làm phim)
└─ MoneyPrinter2\
   ├─ AGENTS.md
   ├─ artifacts\script-ideal\SCRIPT_IDEAL_RULES.md   (workspace sản xuất từng phim cũng nằm trong artifacts\)
   ├─ research\davinci-resolve-mcp\  MCP + venv
   ├─ scripts\omni_voice_worker.py
   └─ Downloads\, docs\
```

Không mang sang máy mới: app MoneyPrinter2 đầy đủ, thư viện nhạc cũ trong `Hidden Chapters\Music` (nhạc giờ tải mới từ Epidemic cho từng phim), các phim cũ, giọng mẫu `Cao_voice`. Cần thì chép tay.

## Lỗi thường gặp

| Hiện tượng | Cách xử lý |
|---|---|
| `running scripts is disabled` | Luôn chạy bằng `powershell -ExecutionPolicy Bypass -File ...` hoặc file `.bat` có sẵn |
| `winget` không có | Cài "App Installer" từ Microsoft Store rồi chạy lại |
| Frenemy báo SKIP | Đăng nhập `claude` và `codex` (bước 5), mở terminal mới, chạy lại `install_tools.ps1` |
| `ask_claude` không có trong Codex | Khởi động lại Codex; kiểm `config.toml` có `[mcp_servers.claude]` |
| Resolve MCP không thấy Resolve | Resolve phải đang mở; bản Studio bật External scripting = Local; bản free bật Workspace → Scripts → resolve_bridge |
| OmniVoice báo CUDA False | Cập nhật driver NVIDIA; vẫn chạy CPU được nhưng chậm |
| Đường dẫn `E:\Youtube AI` không tồn tại | Máy không có ổ E: Codex dùng bảng đổi đường dẫn trong `<workspace>\AGENTS.md` |
| Clone repo hỏi đăng nhập | Chọn Sign in with your browser, đăng nhập GitHub `ggcaochihieu602` |
