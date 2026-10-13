# Lỗi đã đo và sửa — Tristan v28, 02/10/2026

Không lấy số cảnh, timecode hoặc mức dB của phim này làm mặc định phim khác. Các quan sát dưới thuộc Resolve Free 21.0.2.4 + bridge MCP 4.8.22. Evidence gốc ở hồ sơ Tristan v28; bản tóm tắt và frame được đóng gói ở đây.

## Native source end lệch một frame — đã xác nhận
`GetSourceEndFrame()` trả endpoint không nhất quán với một số media đã import: đoạn 168 frame trả 168, đoạn 118 frame trả 117. Nguyên nhân nội bộ API chưa xác định; không mặc định cộng/trừ 1 cho toàn bộ media. Cách kiểm đã đo: source-end-exclusive = SourceStartFrame + round((SourceEndTime − SourceStartTime) × media FPS). So timeline duration và prepared range; vẫn phải thử một đoạn trên build thật. 289 source bindings v28 khớp theo cách kiểm này. Source FPS khác timeline FPS phải giữ riêng.

## Fusion template cài được nhưng không chạy — đã xác nhận
Candidate dùng KeyFrameStretcher gây modal Unknown tool RetimingKeyFrameStretcher và ngăn bridge tiếp tục. File-installed không phải native-verified. Đã thay bằng graph TextPlus/transparent Background/Merge/Transform với XYPath và Bezier alpha, không KFS. 20 title center editable đã có native in/hold/out proof; bad candidate cũ được xóa đúng một file do project tạo. Không xóa thư viện template khác. Xem [frame v28](../visuals/TEXT_V28_NATIVE.md). Đây là biến thể native đã kiểm, chưa phải style được user duyệt làm mặc định.

## Audio có stream nhưng không có tín hiệu — đã xác nhận
Một số source factory/social có stream PCM nhưng thực sự digital silence. Cần đo selected range; không suy từ tên file/stream tồn tại. Đã thay ambience phù hợp và disable local-sound silence, giữ 16 local-source đoạn có tín hiệu. Nhạc/ambience có file phủ đủ chưa chứng minh mức nền liên tục: quiet head/tail và overlap có thể tạo chỗ hụt. Đã kiểm actual PCM sum của cue theo offset/loop/crossfade toàn duration, sửa 1s ambience đầu bằng texture thật cùng nguồn rồi kiểm lại. Một sample native Resolve 12s kiểm engine placement/peak; không báo đã nghe thủ công toàn phim. Threshold số trong evidence là phép đo phim này, không preset âm lượng chung.

## Dọn bản cũ cần bảo toàn cả hồ sơ — lỗi đã xác nhận
Relink mọi media dùng trong timeline mới sang vị trí được giữ, SHA-verify trước xóa; giữ cả source original/license/generation records và source-timeline của title lồng. Đồng thời phải copy đầy đủ word-map, clause/sentence map, pause map và hồ sơ nguồn **trước** xóa revision cũ. V28 đã giữ đầy đủ clause/sentence/final cut anchors nhưng thiếu copy full per-word archive, khiến archive đó bị xóa. Không dựng lại timestamps giả: hiện lưu rõ partial measured anchors; master Cao nguyên vẹn được giữ, có thể đo thêm từ cần dùng khi edit sau. QC/current profile phải kiểm tất cả record paths tồn tại, không chỉ media files. Old folder chứa nguồn hiện hành không được xóa nguyên folder.

## Tham số export/capture — đã xác nhận trên build này
Capture frame PNG chạy; JPG codec không khả dụng ở đường capture đã thử. SetRenderSettings với VideoQuality=2000 bị từ chối; phải đọc bool và chỉ dùng key/value đã được build nhận. Sample MP4 12s chạy với bộ setting còn lại. Pin MarkIn/Out explicit, sau sample trả range/target đúng và mở Edit. Không xuất full để chữa capture hoặc thử template.

## Bàn giao và ngoại lệ
V28: 289 cảnh, 69.58% video, không gap/offline, 29 animated cards, 19 ambience files; saved/open timeline, user review pending. Intro vẫn giữ 4 ảnh đúng địa điểm — ngoại lệ biên tập có ghi rõ, không coi all-video intro đã pass. Chi tiết mềm của ảnh tư liệu lịch sử không được nâng cấp thành bằng chứng hiện đại. Không export full.
