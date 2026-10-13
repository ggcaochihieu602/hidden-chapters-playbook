> LỊCH SỬ — không phải quy tắc hiện hành. Ver 2/START_HERE và chỉ đạo mới ưu tiên. Chỉ đọc phần được bước hiện tại trỏ tới.

# 01 — Quy tắc hiện hành

Cập nhật 26/09/2026 cho profile documentary mới: [quy trình kịch bản mẫu/reporter/âm thanh](07_DOCUMENTARY_PROFILE.md) bổ sung ngoại lệ reporter, chuỗi footage theo nghĩa câu và sound môi trường. Giữ nhịp cũ, hold màu/bố cục. Không áp ngược vào saved edit V005.

Các giá trị sau là mặc định theo sở thích người dùng cho documentary tương tự V005. Brief mới có thể ghi đè; luôn lưu lý do và phạm vi ghi đè.

Chỉ đạo bổ sung: học và lưu kinh nghiệm từ từng kịch bản người dùng cung cấp; reporter chỉ 1–2 đoạn/video, ưu tiên mở đầu, có cử chỉ theo ý câu và lời thoại riêng thay phần VO tương ứng. Khi brief không chỉ định bài nhạc cụ thể, chủ động lên cue, tìm/chọn và tải qua GetHinh theo ngân sách project. Prompt hành động và các nhóm query từ ảnh tham khảo ở [07](07_DOCUMENTARY_PROFILE.md).

## Nội dung và căn lời

- Dựng từ brief + script + VO + stock keywords. VO master quyết định thời gian; không ép VO vào timecode dự kiến hoặc tự tạo lại VO đã giao.
- Dịch ý script Việt và đối chiếu câu tiếng Anh thực sự được nói. Căn câu/cụm ý theo ASR, kiểm lại mốc từ/cụm từ quan trọng. Mỗi cảnh giữ `vo_span`, thời gian, nội dung cần thể hiện và lý do chọn nguồn.
- Đúng chương chưa đủ: hình cần đúng đối tượng/hành động/địa điểm/cơ chế của câu đang nói. Không lấy asset kế tiếp trong thư viện rồi gán ngẫu nhiên.
- Hoàn thành phim hợp lý quan trọng hơn xác minh vô hạn. Kiểm kỹ cảnh chứng minh cơ chế/địa danh; cảnh dẫn/bối cảnh có thể duyệt nhanh nếu không mâu thuẫn rõ. Ghi thiếu hụt và độ chắc chắn; không bịa evidence.

## Nguồn và nhịp dựng

- Phần chính: mỗi nguồn video/ảnh thật/ảnh AI dùng một lần. Khác crop, đổi tên, đổi encoding hay cắt range khác của cùng video không làm nó thành nguồn mới.
- Introduction: toàn video, ưu tiên hình đẹp/chất lượng tốt và khớp lời. Được tái sử dụng video chương sau làm teaser. Giữ video intro sẵn có nếu phù hợp; không xem ngoại lệ intro là quyền lặp ở phần chính.
- Mặc định video 50–60% **thời lượng**, phần còn lại là ảnh có motion. Đây là định hướng; ưu tiên nghĩa câu VO, không cố nhồi ảnh để đủ tỷ lệ. Không còn quota 2/3 ảnh thật, 1/3 AI.
- Video phù hợp được nối liên tiếp. Xen ảnh/video linh hoạt, tránh chuỗi ảnh dài khi nội dung không cần. **Không có giới hạn cứng hai cảnh cùng loại liên tiếp.**
- Video thường >3 giây và tối đa 10 giây/cảnh. Ảnh thật/AI tối đa 8 giây; có thể ngắn hơn tùy ý nghĩa. Nếu clip video chỉ 1–3 giây, mượn thời gian từ cảnh liền trước/sau mà vẫn giữ khớp lời. Montage teaser ngắn chỉ là ngoại lệ có chủ đích khi người dùng/brief yêu cầu, ghi rõ; không dùng để lách quy tắc chung.
- Độ dài file tải không bị giới hạn 10 giây: nguồn dài thì chọn range, nguồn ngắn có thể slow vừa phải với nội suy/motion blur nếu nhìn tự nhiên. Luôn kiểm source range và EOF.
- Khi slow video, ưu tiên optical flow đã kiểm bằng chuyển động thật. Có thể pre-render đoạn dùng bằng motion-compensated interpolation rồi đặt lại ở tốc độ 1x trong Kdenlive. Kiểm ít nhất đầu/giữa/cuối và các vùng có người, tay/chân, xe, tuyết, nước hoặc vật thể giao nhau; nếu có warping/ghosting thì đổi range, giảm mức slow hoặc thay nguồn. Không dùng lặp frame như một kết quả đạt chỉ vì hết giật theo timecode.
- Có thể cần hàng trăm nguồn. Số lượng không thay thế độ liên quan; tìm candidate dư nhưng chỉ tải theo thiếu hụt và hạn mức được cấp.

## Tìm và xác minh

- A làm nền cho nội dung chính, thực thể và cơ chế; B bổ sung câu dẫn, con người, hành động/góc nhìn thiếu. Tháp chi tiết ở file 02.
- Xem preview video trước tải khi có; xác nhận lại file tải. Xem nhiều thời điểm hoặc đoạn chuyển động khi hành động quan trọng. Thumbnail/title/keyword không phải bằng chứng đã xem video.
- Google là công cụ tìm, không phải nguồn quyền sử dụng ảnh. Lưu trang gốc, URL asset, tác giả, license/evidence; phân biệt nơi cung cấp asset và website trung gian tải.
- AI chỉ dùng cho giải thích phức tạp mà ảnh/video thật phù hợp không tìm được. Prompt gồm keyword, ngữ cảnh câu, mood, phong cách phim, cơ chế cần đúng. Không dùng AI làm chân dung lịch sử thật hoặc footage địa điểm thật.
- Ảnh mờ: ưu tiên tìm bản gốc tốt hơn. Nếu ảnh phải dùng trên timeline vẫn quá thấp chất lượng, dùng AI phục chế/tăng nét **trước khi nhập**; giữ ảnh gốc làm mốc, kiểm artefact, chữ, số người và chi tiết lịch sử/kỹ thuật, ghi bản gốc/bản tăng nét trong sổ nguồn. Không gọi ảnh upscale là chi tiết 4K gốc hay dùng chi tiết AI suy diễn làm bằng chứng lịch sử.

## Khung hình và motion

- Tất cả still có zoom/pan rất chậm. Scale cover trước, rồi mới motion; ảnh ngắn phải giảm biên độ để không chuyển động quá nhanh.
- Với kích thước nội dung sau crop/orientation `Sw,Sh`, canvas `Cw,Ch`: `s=max(Cw/Sw,Ch/Sh)`. Với `W=Sw*s,H=Sh*s`, giữ `Cw-W <= x <= 0`, `Ch-H <= y <= 0` suốt chuyển động. Thêm dư vừa đủ để pan; zoom-out vẫn cover ở cuối.
- Kiểm viền đen có sẵn trong pixel kể cả file 4K 16:9. Crop tới nội dung rồi cover, không kéo giãn. Bảo vệ chủ thể, mặt người và nhãn sơ đồ. Endpoint đúng chưa đủ nếu easing có cực trị giữa cảnh.

## Âm thanh

- Nhạc nền mặc định gain khoảng **−12 đến −15 dB**; xem peak/loudness theo thời gian của từng bài và nghe cùng VO. Bài/đoạn lớn chọn gần −15 dB hoặc giảm thêm khi cần. Đây là gain tương đối, không phải LUFS hay mức peak đích.
- Atmosphere thường khoảng **−8 đến −12 dB**; giảm tiếp nếu che lời. Dùng ducking theo vùng VO và fade hợp lý nếu cần; không chỉ đo file master rồi kết luận mọi câu đều rõ.
- Nhạc theo mood/chương/cue brief; tự tạo nhạc khi được cho phép. Nếu thay bài brief chỉ định bằng nhạc sinh, ghi rõ là thay thế.
- VO/music/ambient/SFX tách vai trò. Các cue cùng loại không overlap và processing tương thích dùng chung track; overlap hoặc routing khác mới thêm lane. Không tự cắt mất 1 frame để ép gọn track.
- Duy trì ambient phù hợp xuyên suốt phim, nhưng đổi theo không gian (gió ngoài trời, nước/cảng, công nghiệp, phòng trong nhà, đám đông/lễ hội). Thêm SFX khi hình thực sự có hành động tương ứng; có thể dùng audio gốc của stock sau khi nghe/kiểm không có lời hoặc nội dung lệch. Mọi cue ambient/SFX phải fade in và fade out. Preview GetHinh/Envato trước khi mua, rồi probe và kiểm file tải trước khi đặt timeline.

## Overlay

- Mọi text thêm vào dùng phong cách minimalist: chữ trắng, không stroke/outline. Trên nền tối dùng chữ trực tiếp với shadow nhẹ; trên nền sáng dùng chữ trắng trong box đen khoảng 50% opacity. Tránh icon trang trí nếu không mang thông tin.
- Fact/statistic mặc định đặt ở góc trái dưới như lower-third, căn trái cả hai dòng. Box phải tính từ cùng origin với text và có padding cân đều bốn phía; chỉ căn giữa khi bố cục cụ thể thật sự cần.
- LOCATION: tên địa điểm lớn, dòng phụ nhỏ nếu cần, thường ở lower-left và tránh subtitle. Nền phải tính theo **font/weight thật + padding**, không theo số ký tự hoặc chiều rộng cố định.
- KEY FACTS: tối đa một số liệu/ngày/sự kiện nổi bật mỗi chương theo mặc định, đúng mốc VO, hiện nhẹ ở lower-left hoặc giữa khi bố cục cho phép và tránh phụ đề. Có thể dùng dòng chính bold + dòng quy đổi/giải thích regular. Ngày viết rõ tháng tiếng Anh để tránh dd/mm mơ hồ.
- PEOPLE: ảnh thật đúng người, nguồn/credit/hash, tên và vai trò ngắn; card bên phải khoảng30%, giữ tỷ lệ mặt, không che nội dung chính vô ích.
- Tránh các card chồng nhau. SFX tùy brief; thử nghiệm overlay V005 **không thêm SFX mới**. Không suy rộng ngoại lệ này sang mọi brief.
- Thêm trên track riêng, khóa visual đã dựng khi sửa overlay. Đã có chỉnh tay: dùng file Kdenlive vừa lưu, không compile lại từ DB cũ.

## Introduction và reporter mở đầu

- Introduction dùng toàn video và cắt nhanh khoảng 3–5 giây/cảnh, chọn shot đẹp và giữ người xem từ các chương: cảnh quan, con người, lao động, đời sống/văn hóa/lễ hội khi script hỗ trợ. Không chọn chỉ vì clip đẹp nếu lệch ý VO.
- Reporter AI xuất hiện ở video đầu khi project yêu cầu. Reporter được giữ đủ thời gian để nói hết câu, là ngoại lệ có chủ đích của nhịp 3–5 giây. Reporter sở hữu đúng span lời đó; VO narrator không đọc chồng hoặc đọc lại.

## Những quy tắc cũ đã bỏ

| Cũ | Hiện hành |
|---|---|
| Footage dùng1–3lần | Một lần phần chính; intro ngoại lệ có ghi nhận |
| Tối đa hai cảnh cùng loại | Trộn linh hoạt, ưu tiên video |
| Chia cứng quota AI | Chỉ AI cho khoảng trống giải thích phức tạp |
| Nhạc −5…−8dB | Mặc định −12…−15dB và kiểm với VO |
| Scale gốc rồi pan | Cover/crop trước, motion trong biên an toàn |
| Tên track hiện là overlay đã hoạt động | Phải kiểm clip thực, import native, hình ở timestamp và lưu/nạp lại |
