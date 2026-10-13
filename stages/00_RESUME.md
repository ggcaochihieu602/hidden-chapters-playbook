# 00 — Khởi tạo hoặc tiếp tục

## Đầu vào
Chat hiện hành, LATEST, workspace và trạng thái Resolve **chỉ khi** phim đã có timeline hoặc nhiệm vụ là sửa trên timeline; phim mới không kết nối Resolve ở bước này (Resolve bắt đầu từ 04, sau khi 03 đạt). Chỉ đạo mới > override đã chốt của phim > playbook hiện hành > lịch sử.
## Việc làm
Đọc `project.json` và `progress.json`; ghi script/VO đã chọn, stage, native checkpoint, pending deficits và scope. Với phim mới copy profile mẫu, điền đường file và giá trị mặc định; với phim cũ giữ preset/VO/timecode riêng đã chốt. Nếu hồ sơ chưa có thì dựng lại từ file và native state, không từ phỏng đoán lịch sử chat. Kiểm quota 5h tại ranh giới công việc bằng số đo thực (remaining = 100 − usedPercent); nếu không đọc được thì ghi unknown, không đoán. Khi còn 1–2%, lưu native checkpoint/progress, dừng việc đang làm và để máy chạy. Khi user tạm dừng, dừng job thuộc scope của mình, giữ file hoàn tất/partial và ghi next_action; không dừng process không liên quan. Cập nhật tài liệu không tự resume sản xuất đang pause.
## Quyết định
Chỉ áp thay đổi đúng yêu cầu hiện hành; cập nhật playbook không đồng nghĩa sửa media/VO phim cũ. Biết trước nhiệm vụ là lên kế hoạch, dựng, sửa âm thanh hay chỉ text. Bàn giao timeline là mặc định; export chỉ khi được yêu cầu cụ thể.
## Đầu ra
Hồ sơ phim, phạm vi được làm, baseline, stage cần tiếp tục và next_action.
## Gate Claude C0 (kết nối Claude, không liên quan Resolve)
Đầu mỗi chat sản xuất hoặc sau khi khởi động lại Codex: tạo `<workspace>\collab\` nếu chưa có, đọc `collab\claude-calls.csv` để biết gate nào `pending_claude`/`disputed`, rồi gọi C0 theo [mẫu](../templates/CLAUDE_GATE_PROMPTS.md#c0). C0 lỗi không chặn phần việc độc lập; ghi blocker và báo người dùng theo [CLAUDE_COLLAB mục 8](../reference/CLAUDE_COLLAB.md).
## Checklist
- [ ] C0 đạt hoặc blocker Claude đã ghi; gate Claude còn treo đã đưa vào next_action.
- [ ] Đúng phim/workspace, không ghi đè phim khác.
- [ ] Mặc định/override và ngân sách có nguồn từ người dùng.
- [ ] Checkpoint và phần chưa xong rõ; không gọi pending là hoàn tất.
- [ ] Pause/quota theo chỉ đạo mới nhất; save + stop khi cần, không shutdown.
- [ ] Quy tắc mới sửa đúng stage/checklist/template/skill; lịch sử không tham gia quyết định hiện hành.
## Ví dụ
Đổi nhạc: đọc 06 + hồ sơ cue và baseline; không tạo lại VO hoặc dựng lại hình. Đổi VO: vô hiệu timestamp/hình/text/caption bị ảnh hưởng rồi bắt đầu 01.
## Sửa lỗi
Ledger lệch native → đọc lại timeline, ghi discrepancy. Bridge chưa chạy → làm hồ sơ/nguồn độc lập, tra bước 04 khi cần.
## Tiếp tục
Lưu scope và next_action, mở đúng stage. Không nạp cả playbook/history.
