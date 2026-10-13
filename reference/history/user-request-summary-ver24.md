# LƯU TRỮ — không dùng làm hướng dẫn hiện hành

Bản ghi từ ver 24, giữ để truy vết. Quy tắc hiện hành nằm trực tiếp trong START_HERE và các bước của bản chọn bằng LATEST.

# Yêu cầu dùng chung — cập nhật từ người dùng, 03/10/2026

Playbook này dùng cho nhiều video, không cố định một địa điểm, nhân vật hay chủ đề. Xác định yêu cầu từng phần từ tiêu đề, script đã chốt, vế VO và câu trước/sau. Các quyết định mới nhất dưới đây thay thế quy tắc cũ mâu thuẫn. Hồ sơ phim lưu trạng thái thực hiện; playbook không chứng minh phim đã hoàn thành.

## 1. Tư liệu đúng nội dung trước khi nới rộng
Từ tiêu đề/script, xác định chủ thể chính và thực thể cụ thể của từng vế: địa điểm, nhân vật, sự kiện, tổ chức, thời kỳ, hoạt động hoặc đối tượng. Tìm video đúng chủ thể/thực thể trước. Khi không có video phù hợp, tìm ảnh thật qua Google Images, theo tới trang gốc và kiểm chứng nội dung/nguồn, trước khi nới rộng keyword. Không mọi phần đều cần cùng địa điểm: cơ chế, ví dụ giả định hoặc chi tiết không định vị có thể dùng tư liệu tương thích nếu khớp đúng câu VO và không gợi nhận diện sai. Ghi query, kết quả phù hợp/không phù hợp, lý do nới rộng và provenance từng placement. Hình phải đúng lời đang nói tại đúng thời điểm xuất hiện; tỉ lệ video cao không bù cho sai nội dung.

## 2. Video trước, ảnh khi thiếu video, đồ họa khi cần
Ưu tiên video chuyển động phù hợp. Chỉ dùng ảnh khi đã tìm mà không có video phù hợp cho nội dung ấy. Bỏ trần video 50–70% từng áp dụng; không lấy số lượng ảnh/đồ họa làm mục tiêu. Đồ họa chỉ khi cần giải thích cơ chế hoặc số liệu; giảm thẻ khái niệm không cần thiết. Ngày tháng, nguồn, tên địa điểm/người thường là overlay ngắn. Giữ video 2–10 giây, ảnh tối đa 8 giây, không chia cùng ảnh liền nhau để lách hold; ảnh pan/zoom vẫn là ảnh. Tránh lặp canonical source ở thân phim, ghi ngoại lệ teaser intro.

## 3. Ảnh phù hợp: giữ, expand/nâng chất lượng khi cần
Không tạo lại mọi ảnh. Ảnh đã khớp script/style/chất lượng/khung thì giữ. Ảnh cần thiết nhưng sai tỷ lệ hoặc thấp chất lượng: tìm original tốt hơn khi có, sau đó dùng AI expand/outpaint và nâng chất lượng phù hợp khung 16:9. Giữ original, prompt, tool/model/run, hash và derivative lineage. So thực tế mặt, tay, chữ, số liệu, kiến trúc, địa hình và mép ghép; không pass vì prompt nói giữ nguyên hoặc vì đủ pixel. AI thay đổi nhận diện/nội dung thì loại, thử sửa có mục tiêu, phục hồi vùng gốc hoặc chọn nguồn đúng khác. Không bịa chi tiết lịch sử làm bằng chứng. Scale cover trước motion, pan/zoom đa dạng và không viền đen. 4K carrier không biến ảnh gốc thành tư liệu chụp 4K.

## 4. Style documentary và ảnh mẫu có file thật
Với đồ họa cần thiết, giữ nghĩa đã kiểm chứng nhưng làm thông tin dễ hiểu hơn: vật thể/bối cảnh liên quan, tỷ lệ, cutaway, chi tiết phóng lớn, so sánh hoặc ngữ cảnh địa lý khi có căn cứ. Tránh sơ đồ quá sơ sài như mẫu 1. Tham khảo mẫu 2–4 để chọn cách trình bày, không sao số liệu/địa điểm của mẫu sang video khác. Dùng ChatGPT/OpenAI image generator khi cần tạo/sửa bitmap; ưu tiên plate không chữ và nhãn editable trong Resolve. [Folder ảnh mẫu](../visuals/documentary-graphics/README.md) chứa cả bốn PNG gốc, [mẫu 1](../visuals/documentary-graphics/user-example-1.png), [mẫu 2](../visuals/documentary-graphics/user-example-2.png), [mẫu 3](../visuals/documentary-graphics/user-example-3.png), [mẫu 4](../visuals/documentary-graphics/user-example-4.png). Khi làm phần liên quan phải mở xem file mẫu. Folder, manifest hash và các liên kết phải có cả trong bản phát hành và ZIP.

## 5. Nguồn footage đã chọn
Bám tổ hợp Pexels API, Pixabay API, GetHinh cho Envato Elements/Vecteezy và nguồn ảnh/tư liệu gốc đã kiểm theo nội dung. Không tự chuyển sang Storyblocks hoặc nhà cung cấp khác chỉ vì có kết quả tìm. Giá/quyền tải/ngân sách phải kiểm ở item thật. Google Images chỉ là công cụ tìm; trang gốc mới cung cấp provenance và quyền dùng. Không đưa credential vào playbook, prompt, Git hoặc ZIP. [MEDIA_SOURCES](MEDIA_SOURCES.md).

## 6. Epidemic Sound cho toàn bộ audio
Nguồn nhạc nền, sound effect và ambience là Epidemic Sound, thay thế lựa chọn Envato trước đó. Kiểm kho Music để tái dùng nguồn Epidemic phù hợp; không tái dùng audio nguồn khác vì đã có sẵn. Tìm/preview/download qua session hợp lệ, kiểm quyền dùng project/kênh, lưu bản gốc và cue/provenance. Không tự chuyển sang Envato/AI/provider khác khi gặp blocker; ghi blocker và tiếp tục phần độc lập. Ghi ngân sách thật, không quy đổi subscription thành xu giả. Nhạc/ambience theo nội dung từng chương, lời rõ, action SFX tập trung intro.

## 7. Intro theo nội dung từng phim
Mở đầu 10–20 giây chỉ video + nhạc + SFX, không VO. Chọn highlight đại diện cho những điểm đặc sắc/quan trọng của toàn bộ nội dung đã chốt: cảnh quan, con người, hoạt động, vật thể, vấn đề hoặc xung đột phù hợp với phim; không bắt mọi phim có cùng danh sách cảnh. Có thể tái dùng footage ở phần thân làm teaser, ghi ngoại lệ. Nhạc intro chọn theo nội dung, bối cảnh, văn hóa/vùng/thời kỳ khi liên quan và sắc thái câu chuyện; không cố định vùng/địa điểm/genre. Tên track không tự chứng minh phù hợp văn hóa. Giữ VO đã chốt, đo thời gian intro thật và dời chapter/caption theo duration thực.

## 8. Timeline và output UHD 4K
Mặc định 3840×2160, tỷ lệ 16:9, trừ yêu cầu khác rõ ràng của người dùng. Đọc lại cả timeline/output native. Không tự hạ xuống 1080p vì preview, proxy, source hoặc performance. Nếu timeline trước tạo sai HD, giữ bản cũ và tạo timeline 4K mới, bảo toàn media/VO/timing/audio/manual edits/Fusion; kiểm bindings, chữ và khung native rồi lưu checkpoint. Không gọi mọi source là native 4K.

## 9. Phối hợp title, thumbnail, description
Khi người dùng đã yêu cầu chuyển thông tin sang chat phù hợp, dùng chat hiện có đúng vai trò. Gửi tiêu đề/chủ đề/script đã chốt, phạm vi facts, hướng hình, tình trạng timeline/source và thời gian chương đã đo. Không tạo chat mới hoặc gửi sang chat không được ủy quyền. Khi intro/timing thay đổi, chỉ gửi timestamps đã xác minh; không nói bản dựng hoàn tất khi còn sửa. Style thumbnail và đồ họa trong phim khác nhau.

## 10. Dừng an toàn và tiếp tục đúng scope
Khi quota 5 giờ còn khoảng 1–2%, lưu native project/checkpoint, cập nhật progress và việc còn dở rồi dừng; không tắt máy. Quota không đọc được thì ghi không xác định, không bịa phần trăm. Không dựng vòng polling/automation chỉ vì quy tắc này. Khi người dùng nói tiếp tục, làm tiếp việc đã giao, không dừng sau kế hoạch/acknowledgement; khi người dùng yêu cầu tạm dừng, dừng job riêng của nhiệm vụ, giữ file hoàn chỉnh và ghi phần chưa xong. Mặc định bàn giao timeline Resolve đã lưu/mở để review, không tự export toàn phim hay xuất bản.
