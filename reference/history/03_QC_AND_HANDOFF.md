> LỊCH SỬ — không phải quy tắc hiện hành. Ver 2/START_HERE và chỉ đạo mới ưu tiên. Chỉ đọc phần được bước hiện tại trỏ tới.

# 03 — QC, bảo toàn chỉnh tay và bàn giao

## Preflight

- File tồn tại, không `.crdownload`/HTML giả ảnh, decode/probe được; duration, frame rate, orientation và range không vượt EOF.
- Timeline phủ VO theo frame; không gap/chồng vô ý; tên chapter và overlay căn đúng câu tiếng Anh.
- Sổ canonical source: không lặp phần chính; intro exception rõ. Tỷ lệ video tính theo thời gian. Video>3s/≤10s, still≤8s, ngoại lệ montage được ghi.
- Cover cả cảnh; không viền đen có sẵn/viền lộ do pan. Không crop mất ý, chữ hay khuôn mặt.
- Đếm riêng video stock, ảnh thật, ảnh AI, video AI, placement, downloaded/generated/used/rejected/failed. Đếm theo file/hash và generation record, không suy từ extension hoặc label import.

## Nội dung

- Chọn một số câu cơ chế/địa danh/hành động khó và kiểm hình đúng timestamp; xem đoạn chuyển động khi claim là hành động. Không coi toàn bộ phim đã review từ một contact sheet.
- Nghe intro, vùng nhạc peak, chuyển chương, nối loop và đoạn VO nhỏ. Gain âm lượng không đồng nghĩa đã duck theo VO; phát hiện clipping/che lời và ghi kết quả.
- Location: xem tên dài nhất/ngắn nhất, quốc gia dài/ngắn, nền đủ padding và cân giữa. Fact: đúng dữ kiện/mốc, không che subtitle. People: đúng người, aspect không biến dạng.
- Fade: xem frame đầu, giữa fade, full opacity, cuối; tránh silhouette đen. Kiểm bằng renderer thực.

## Kdenlive native — bắt buộc phân biệt với standalone render

1. Mọi producer phải xuất hiện trong XML trước playlist/tractor tham chiếu nó. `main_bin` có thể nằm SAU sequence trong file đã lưu.
2. Giữ clip identity/control UUID và bin linkage, đúng hai-playlist track structure, track counts/index và compositions. Khóa visual khi scope là overlay-only.
3. File gen5 có filters trong entry: Kdenlive hiểu; plain Melt cần conversion sang nguồn riêng khi test. Nhưng conversion có thể che lỗi native; phải có kiểm import trực tiếp native và lưu/nạp lại.
4. Track label hiện không chứng minh clip hiện. Kiểm đủ số entry/cue, range và hình thực tại location/fact/person. Khi công cụ chụp lỗi, ghi hạn chế; không bịa đã nhìn thấy GUI.
5. Với sửa project người dùng đã lưu: backup/hash trước. So sánh nguồn, in/out, duration/order, speed, transforms, effects, audio timing/gain. GUI có thể đổi ID/format hoặc `kdenlive:activeeffect` (UI selection), cần so sánh nội dung dựng, không chỉ raw bytes.
6. Asset-only sửa LOCATION: chỉ thay SVG tham chiếu; KEY FACTS/People/Rough Cut giữ nguyên. Kdenlive có thể báo Reload sáu file đổi hash; xác nhận đúng path rồi reload. Sau GUI save, kiểm lại protected playlists.
7. Khi lưu revision sang thư mục mới, liệt kê mọi `resource`/`warp_resource` tương đối từ root của project mới. Sao chép đúng asset sang cùng cấu trúc thư mục hoặc chuyển thành path tuyệt đối, rồi render thử một frame có overlay và rà log `Could not open input file`. XML hợp lệ và file tồn tại ở thư mục project cũ không đủ.
8. Sau khi đổi thứ tự clip hoặc chuyển clip giữa các playlist, xác nhận producer/chain đứng trước playlist đầu tiên tham chiếu nó trong thứ tự XML. Mở, lưu, đóng, mở lại bằng Kdenlive và so sánh số clip cùng source/in/out theo từng playlist; một Melt render thành công không phát hiện được clip Kdenlive bỏ khi import.

## Render

- Không dừng render đang chạy để áp sửa không được giao. Lệnh dừng của người dùng có hiệu lực; không tự khởi động full render lại.
- Trước full: kiểm disk/profile/output/path và một đoạn ngắn có rủi ro thật. MLT `melt` là engine có thể xuất project Kdenlive; nó không phải video thành phẩm. Báo rõ đang xuất bằng engine nào.
- CLI chỉ định profile đúng fps; FFprobe kiểm duration/fps/dimensions/codec/audio. Output4K không có nghĩa mọi nguồn4K.
- Sample graph có thể prune để giảm khởi tạo hàng trăm media, nhưng giữ thêm native import test tránh che lỗi thứ tự.
- MP4 interrupted/incomplete không phải thành phẩm. Báo tiến độ từ log/frame và ETA là ước tính.
- MLT XML consumer `all=0` serialize graph; `all=1` xử lý mọi frame trước khi serialize, không dùng nhầm cho test parse nhanh.

## Gói bàn giao mỗi project

- Project `.kdenlive` đúng phiên bản, mở sẵn, tên rõ; không còn dialog chắn.
- Media/profiles hoặc dependency manifest nói rõ những thư mục phải giữ.
- Scene bindings + query/review/source rights + AI provenance + audio cue map.
- Báo cáo chi phí actual/estimated/unknown tách biệt, gồm failed paid attempts.
- QC report: implemented/tested/native-opened/gui-roundtrip/sample-rendered/full-rendered/human-approved tách trạng thái. Danh sách chưa đạt và ảnh hưởng.
- Chỉ đưa link video hoàn chỉnh khi full export đã thành công. Nếu chỉ giao project, ghi chưa xuất.
