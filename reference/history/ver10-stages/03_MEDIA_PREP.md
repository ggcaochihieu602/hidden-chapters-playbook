# Lịch sử ver 10 — chỉ tra lỗi kỹ thuật

Quy tắc hiện hành ở START_HERE và stages của ver 11; lịch sử không được ghi đè chỉ đạo mới.

# 03 — Chuẩn bị và kiểm media trước khi dựng

**Đầu vào:** nguồn đã tải và scene ledger. Chỉ xử lý media được chọn/dự phòng hữu ích; giữ originals.

1. Probe codec/fps/duration/resolution/orientation; decode sample. Loại HTML giả ảnh, file chưa tải xong, watermark preview. Source range phải nằm trong EOF có margin giải mã.
2. Với nguồn khác fps, ưu tiên trim native đúng source seconds. Nếu exact-frame append sai trên Resolve đang dùng, conform **range đã chọn** sang CFR timeline fps ở tốc độ bình thường; probe số frame rồi thử một cảnh. Không nhầm conform với slow motion.
3. Ảnh quá nhỏ/mờ: tìm bản gốc tốt hơn trước; nếu vẫn phải dùng, AI làm nét trước khi vào timeline. Giữ original, bản phục chế, model/prompt/hash. So sánh mặt/chữ/số/chi tiết lịch sử, giảm mức tái tạo nếu bịa chi tiết. Không đặt 15% blend thành công thức bắt buộc cho mọi ảnh.
4. Cover theo content bounds rồi zoom/pan nhẹ. Ảnh ngắn giảm biên độ để giữ tốc độ chậm. Kiểm 0/25/50/75/100% và điểm cực trị. Nguồn 4K vẫn có thể chứa viền đen trong pixel; crop rồi cover, không kéo méo.
5. Slow video dùng optical flow khi cần và kiểm người/tay/chân/vật giao nhau/nước. Ghosting → đổi range, giảm slow hoặc thay nguồn. Không đạt chỉ vì duration đúng.
6. Khi pre-render ảnh/title, giữ metadata `original_media_kind=still`, canonical source và source→derivative mapping. Một PNG tạo MOV/MP4 vẫn là ảnh cho video-share và uniqueness.

**Checklist hoàn tất**
- [ ] Nguồn/range decode được, không vượt EOF; source seconds/fps rõ.
- [ ] Ảnh thấp chất lượng đã xử lý và đối chiếu gốc.
- [ ] Motion nhìn thấy nhưng chậm, cover toàn cảnh, không crop mất chủ thể.
- [ ] Derivative map/hash đầy đủ; không ghi đè original.

**Sửa lỗi tại bước này:** zoompan `d=1` nhưng gần như đứng im → dùng bộ đếm output frame `on` và xem đầu/cuối; duration đúng mà source-in sai → kiểm quy ước fps/source seconds; motion lộ đen → tính cover/crop trước, giới hạn đường pan.

**Gate 03 đạt → [04](../../../stages/04_RESOLVE_CONNECT.md).**


## Range có phụ đề/ticker sẵn trong nguồn

- Review đầu/giữa/cuối range đủ lớn để đọc phần chữ; kiểm cả ticker tin tức, lyrics và inset thông dịch. Metadata landscape hoặc watermark không chứng minh range sạch.
- Nếu chữ nguồn đè caption/nhãn phim, ưu tiên range hoặc nguồn sạch. Crop có chủ đích chỉ dùng khi giữ đủ người, hành động, công cụ và ngữ cảnh; giữ original và ghi tỷ lệ crop. Không tự xóa attribution nguồn.
- Chuẩn hóa derivative cùng fps, số frame và source-in của bản thay; xem lại crop đầu/giữa/cuối rồi thay đúng vị trí native, không ripple. Source canonical không đổi vì làm derivative.
- Map/globe phải kiểm đúng bán cầu, bờ biển và tọa độ trong frame thật. Tên file/query không chứng minh địa lý. Map authored ghi riêng với video hiện trường.


## Ảnh 16:9, bảo toàn tư liệu và chuyển động

- Ảnh photographic thiếu tỉ lệ: ưu tiên AI mở rộng phần nền ngoại vi; giữ ảnh gốc/provenance/prompt/output. Không sinh thêm người, moai, chữ, kiến trúc hoặc chứng cứ lịch sử. Outpaint phải được xem đối chiếu gốc; prompt giữ nguyên không chứng minh model đã làm đúng.
- Nếu AI thay mặt/chữ/chi tiết gốc: ghép ảnh gốc bất biến lên nền trong video, kiểm registration thực hoặc đặt center bằng geometry đã biết. Không gán inliers giả cho composition thủ công. AI bị từ chối: không lặp nguyên request; có thể tạo riêng nền trung tính rồi ghép gốc, ghi giới hạn và kiểm kết quả.
- Kiểm đường nối màu trời/biển/đất ở 0/25/50/75/100%; global color match có thể chưa đủ. Video margin grade/feather có thể sửa nhưng chỉ công nhận sau xem. Không mở rộng cơ thể, giày, kiến trúc hay văn bản ngoài phạm vi gốc rồi dùng như tư liệu.
- Giấy tờ/công văn/sơ đồ: không outpaint nội dung. Đặt nguyên trang lên historical texture với shadow nhẹ, giữ tiêu đề/dấu/số/chữ trong mọi frame. Sơ đồ đầy chữ có thể đứng yên để đọc rõ.
- Ảnh đúng tỉ lệ vẫn cần cover rồi zoom lớn hơn frame và slow pan/zoom rõ nhưng chậm, theo thời lượng. Xuất ảnh thành MP4 không đổi loại media hay canonical ID.
