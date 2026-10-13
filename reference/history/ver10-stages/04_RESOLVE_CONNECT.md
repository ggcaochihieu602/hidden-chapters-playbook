# Lịch sử ver 10 — chỉ tra lỗi kỹ thuật

Quy tắc hiện hành ở START_HERE và stages của ver 11; lịch sử không được ghi đè chỉ đạo mới.

# 04 — Kiểm cập nhật và kết nối Resolve MCP

**Chạy trước mỗi phiên sử dụng MCP và sau khi đổi build/kết nối.** Chỉ đọc [hướng dẫn cài và khôi phục](../../RESOLVE_MCP.md) nếu chưa kết nối được hoặc cần cài mới.

1. Kiểm GitHub mới bằng `resolve_control(action="mcp_update_status", params={"force_check":true})`; ghi checked_at, installed/latest version, release URL và kết quả vào `progress.json` ở nơi làm việc. Kiểm một lần đầu phiên, không lặp trước mỗi clip. Nếu MCP chưa chạy, dùng [script kiểm độc lập](../../../scripts/check_resolve_update.py).
2. Đọc changelog khi có bản mới và phần README/install liên quan trước khi dùng hành vi mới. Kiểm tra cập nhật là tự động; không nâng cấp Resolve/đổi build đang dựng giữa chừng. Nếu cần cập nhật MCP, lưu checkpoint, kiểm local changes, dùng đường cập nhật chính thức có khả năng quay lại, rồi reconnect/test trước khi dựng.
3. Đọc phiên bản Resolve, Free/Studio, bridge trạng thái. Free 21.0.x dùng bridge trong `Workspace → Scripts → resolve_bridge`. Resolve đang mở không chứng minh bridge hoạt động. Compatibility 21.1+ phải kiểm tài liệu hiện hành.
4. Xác nhận đúng project/timeline theo tên và ID. Bảo toàn sửa tay, snapshot/DRP trước batch mới. Chỉ kiểm read-only khi task hiện tại là cập nhật tài liệu.

**Checklist hoàn tất**
- [ ] Đã kiểm GitHub đầu phiên; ghi rõ up_to_date/update_available/check_failed.
- [ ] Đọc được project, timeline và fps qua scripting; đúng project yêu cầu.
- [ ] Có snapshot baseline, không còn trạng thái connection guessed.
- [ ] Sau update/reconnect đã kiểm readback; chưa có thì không gọi connected.

**Nếu lỗi:** bridge down → dùng remediation của MCP, mở project và chạy bridge; hỏi user chỉ khi công cụ không thể thực hiện thao tác cần thiết. Trong lúc chờ chỉ làm phần chuẩn bị nguồn độc lập, không giả thành đã chỉnh timeline. Check update mất mạng → ghi `check_failed`, không gọi mới nhất; dùng bản đã kiểm trước nếu vẫn tương thích và ghi giới hạn.

**Gate 04 đạt → [05](../../../stages/05_ASSEMBLY.md).** Với phiên tiếp tục ở bước 06/07/08, đạt gate 04 rồi quay về bước đang làm.


## Batch qua bridge và giới hạn handles

- Đừng tìm từng clip bằng cách quét lại toàn media pool trong mỗi vòng lặp. Trên MCP4.8.22, cách này làm tăng handles và có thể đẩy reference đang dùng ra khỏi cache4096. Lập index một lần theo File Path/canonical ID, xử lý batch có giới hạn rồi đọc lại sau save.
- Chỉ dùng các phương thức SDK/bridge được công bố và trạng thái native; không dùng proxy constant chưa có bằng chứng. MCP nhận params theo schema, không tự thay bằng options.
