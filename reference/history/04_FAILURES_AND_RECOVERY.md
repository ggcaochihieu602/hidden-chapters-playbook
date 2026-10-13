> LỊCH SỬ — không phải quy tắc hiện hành. Ver 2/START_HERE và chỉ đạo mới ưu tiên. Chỉ đọc phần được bước hiện tại trỏ tới.

# 04 — Sổ lỗi đã gặp và cách tránh

Đây là lỗi/giới hạn quan sát trong V005; không mặc định mọi máy/nguồn đều gặp. Chi tiết gốc trong `history/BRIEF_EDIT_LESSONS.md` và các audit theo thời điểm.

| Lỗi/dấu hiệu | Nguyên nhân hoặc mức đã biết | Sửa và kiểm tra lần sau |
|---|---|---|
| Ít footage, lặp gần nhau, cảnh lều/chùa không ăn nhập | Quota nguồn thấp, context được gán quá rộng | Tăng nguồn theo scene deficit; dùng một lần phần chính; đúng nghĩa trước mix quota |
| Đúng chương nhưng sai câu VO | Gán tuần tự asset/chia đều segment | ASR + câu/cụm ý + evidence binding từng scene; xem range hành động |
| Hàng chục ảnh rồi hàng chục video | Allocator theo nhóm/chương và constraint mix đơn giản | Đánh nhịp toàn timeline, ưu tiên video, không hard cap hai medium |
| Ảnh lộ đen hai bên khi motion | Scale gốc/cover sai/thiếu bù tâm | Cover trước, clamp pan, kiểm0/25/50/75/100% và extrema |
| Nguồn16:9 vẫn có dải đen | Letterbox nằm trong pixel | Detect content bounds, crop rồi cover, kiểm subject/resolution |
| Video1s | Cut point theo timestamp nhỏ | Borrow thời gian cảnh cạnh, giữ >3s thường; ghi ngoại lệ teaser |
| Source_in lớn hơn clip9.48s | Chọn range từ giả định | Probe EOF trước compiler; sửa range thực, không tắt validation |
| Nhạc che VO | Gain cũ −5…−8dB, không xét peak | −12…−15dB làm điểm đầu, nghe theo peak, duck tiếp khi cần |
| Quá nhiều SFX/music tracks | Một cue một lane | Interval packing cùng role/processing, giữ overlap thật; V005 có hai overlap1frame nên cần2 music lanes |
| Provider báo tải nhưng không có file | Link/page/download history không chứng minh disk write | Kiểm folder+size+probe+đúng item; retry item đã mua, không mua trùng |
| ERR_BLOCKED_BY_CLIENT từ Codex | Client chặn host tải; quyền folder không đủ giải thích | Dùng flow/quyền/browser được hỗ trợ, không suy Edge hỏng hoặc bypass bảo vệ; báo đúng limit |
| Trang thường logout | Phiên đăng nhập hết hạn | Kiểm session, dùng quyền/tool hỗ trợ; cần user nếu auth/CAPTCHA không thể tự làm; không lưu password/cookie vào playbook |
| Wikimedia trả HTML thay ảnh | Direct-file URL/response không phải binary ảnh | Kiểm MIME/signature/decode, tìm URL nguồn/derivative hợp lệ; không import error page |
| AI ảnh nhập thành local/user supplied | Generic importer mất provenance | Reconcile generation manifest; giữ run/model/prompt/hash/cost ngay từ import |
| Gọi review mà tưởng xem hết video | Metadata/3frame bị suy rộng | Review nhiều sample/temporal proxy theo claim; ghi phạm vi và uncertainty; cache |
| TwelveLabs pilot không hơn OpenAI | 4 clip/59.794s thử nhỏ, có1 action claim không được reference hỗ trợ | V005 giữ OpenAI; không kết luận mọi TwelveLabs model/tác vụ kém. Whole-video Pegasus khác Marengo retrieval |
| XML overlay track có tên nhưng rỗng | Producer ghi sau playlist tham chiếu | Producer trước use; test saved-main-bin-after-sequence; native import và GUI save/reopen |
| Standalone render che lỗi native | Clone sources trước playlist vô tình sửa ordering | Kiểm riêng native nguyên gốc, không chỉ sample chuyển đổi |
| Fade lóe silhouette đen | Affine b_alpha=1 opacity giảm RGB nhưng silhouette còn | Brightness native fade_from_black/to_black, level1, alpha animated; kiểm cả đầu/giữa/cuối |
| SVG font/text box thừa hoặc thiếu | Ước lượng số ký tự; band quốc gia cố định; weight900 lệch font đo | Đo Arial Bold700 thật; box độc lập + padding; Qt/MLT review cả sáu mẫu dài/ngắn |
| SVG percentage/tspan sai vị trí | Hỗ trợ Qt SVG khác engine dự kiến | Tọa độ tuyệt đối, fill-opacity, render bằng Qt/MLT đang dùng |
| Thay SVG báo Clip Problems | Hash/size cache cũ | Kiểm đúng các path đã sửa, chọn Reload, save; không Replace bằng placeholder |
| Native entry effect khác plain Melt | Kdenlive gen5 import nested filter, Melt parser khác | Native giữ entry effect; render conversion clone riêng occurrence và source-time keys |
| 150frame thành6s thay vì5s | CLI mặc định25fps | Truyền profile30fps và probe thật; profile của brief mới phải được kiểm |
| Sample nhỏ khởi tạo quá lâu | Load hàng trăm source | Trim/prune sample graph; vẫn giữ test native độc lập |
| Timewarp resource hỏng sau Save | Prefix dạng ./0.85:E:/... | Chuẩn hóa speed prefix + warp_resource có test; không sửa tốc độ |
| GUI screenshot/click/SaveAs lỗi | E_NOINTERFACE, timeout, geometry/cache element lỗi | Refresh đúng window/modal, một retry hợp lý; AX chỉ chứng minh text, render chỉ chứng minh pixels; ghi limitation |
| Rebuild mất sửa tay | DB không chứa user-saved track/gain/cut | Snapshot actual saved native; scope patch nhỏ, so sánh protected edits, không regen montage |
| Báo thành công quá sớm | Track labels/tests/service existing bị coi là dùng thật | Evidence theo artifact/job/native/sample/full; sửa claim khi user phát hiện lỗi |

## Mẫu ghi lỗi mới

`ID · ngày · project/build · triệu chứng · evidence/path · cause confirmed/inferred · fix · verification · remaining limit · prevention · status`.
Chỉ thêm kiểm thử hồi quy khi ngăn một lỗi có ý nghĩa; không chạy full render nhiều lần chỉ để chứng minh sửa tài liệu/layout nhỏ.

## Longyearbyen — tải file, nguồn và âm thanh
Google Drive: kiểm nút Download anyway bằng ảnh chụp. Click semantic từng chọn nhầm tên file và tạo404 giả; click đúng sau đó bị trình duyệt chặn. Không coi404 này là mất file, không mua lại hoặc vượt chặn. Kiểm file trên đĩa và probe trước khi tính tải thành công.
Giữ bản đồ asset riêng theo project, metadata nguồn thật và voice.master_file_id khi save brief mới. Khi xem mẫu xuất, đối chiếu cả mùa/ánh sáng trong ảnh với câu VO. Gain nhạc -15dB không tự chứng minh lời dẫn nổi rõ; đo envelope và áp ducking khi cần. Phân biệt kiểm frame/mức âm với nghe/xem hết phim.

Overlay phải đối chiếu title chương từ file Kdenlive thực: mẫu Seed Vault từng chồng title dù planning summary cho mốc khác. Đã sửa bằng mốc kết thúc title1355.867s và card1356.2s. Kiểm mọi interval của title/location/fact trong native XML; vẫn xuất mẫu để thấy lỗi bố cục/fade.
