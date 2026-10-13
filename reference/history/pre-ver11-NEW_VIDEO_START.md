# Bắt đầu video mới

Copy toàn bộ [NEW_VIDEO_PROMPT.txt](NEW_VIDEO_PROMPT.txt) vào chat mới, điền phần **THÔNG TIN VIDEO** và gửi kèm brief/script nếu có. Prompt luôn đọc [LATEST.json](Playbooks/LATEST.json), nên không cần thay số phiên bản mỗi lần playbook cập nhật.

Trên Codex hoặc môi trường có công cụ đọc file máy này, các đường dẫn ổ E sẽ được dùng trực tiếp. ChatGPT web thông thường không đọc được ổ E chỉ từ một đường dẫn: đính kèm ZIP playbook mới nhất được [LATEST.md](Playbooks/LATEST.md) chỉ tới cùng đầu vào cần thiết. ZIP có tài liệu và ảnh mẫu, không chứa kho Music/runtime/footage; chỉ gửi những file âm thanh/media được chọn khi đến bước cần chúng. Điều khiển Resolve cần kết nối công cụ trên máy, không chỉ đính kèm ZIP.

Đường dẫn thường dùng:

- [Quy tắc đầu ra](OUTPUT_RULES.md)
- [Kho Music](Music/README.md)
- [Catalog âm thanh](Music/catalog.csv)
- [Playbook mới nhất](Playbooks/LATEST.md)

Chỉ dùng prompt này khi muốn bắt đầu sản xuất. Nếu chỉ muốn nghiên cứu/kịch bản hoặc bàn giao project chưa xuất, sửa dòng **Phạm vi** trước khi gửi.
