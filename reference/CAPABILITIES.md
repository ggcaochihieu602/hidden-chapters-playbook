# Phạm vi đã kiểm — chỉ đọc khi cần xác định công cụ

DaVinci Resolve là editor cho workflow mới. Repo MCP đã được dùng thực tế trong Tristan: native timelines, imports/trims, VO/music/ambience, title assets, DRP/XML snapshots, readback và các đoạn xuất kiểm tra. Đây không chứng minh mọi API đúng trên mọi build hoặc một pipeline tự động hoàn toàn.

MP2 vẫn cung cấp phần catalog/brief/revision/analysis và các service sẵn có. Script dựng theo một phim không tự biến thành tính năng ứng dụng chung. Khi báo đã làm, có job/path/native evidence; không dùng code tồn tại hay HTTP mock làm bằng chứng live.

Kdenlive service và lỗi Qt/MLT là tham khảo sửa project cũ, không bắt phim Resolve mới đi qua Kdenlive. Tài liệu chi tiết cũ ở history; không chạy script hard-code V005/Longyearbyen cho phim mới.

Playbook là tài liệu + mẫu + tham chiếu hình và script kiểm cập nhật; không chứa runtime/model/media sản xuất/secrets. Source footage, working project và dependency paths nằm tại vị trí đã có.

Từ ver 31, Claude Code (gói Claude Pro) được Codex gọi qua MCP `claude` của Frenemy (`E:\Tool\frenemy`). `ask_claude` chỉ đọc: đọc được văn bản/CSV/JSON/PDF/ảnh theo đường dẫn; không shell, không web, không đọc video/audio, không nhớ giữa các lần gọi. Kết nối đã thử thực tế ngày 05/10/2026 (`FRENEMY_OK`, `FRENEMY_E2E_OK`); quyền đọc file trong workspace phim phải xác nhận bằng C0 ở mỗi phiên. Cách dùng: [CLAUDE_COLLAB](CLAUDE_COLLAB.md).
