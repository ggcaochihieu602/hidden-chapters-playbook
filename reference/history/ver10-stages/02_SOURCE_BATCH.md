# Lịch sử ver 10 — chỉ tra lỗi kỹ thuật

Quy tắc hiện hành ở START_HERE và stages của ver 11; lịch sử không được ghi đè chỉ đạo mới.

# 02 — Tìm và tải đủ nguồn toàn phim

**Đọc:** trang này + [tháp keyword, chuỗi cảnh và GetHinh](../../SOURCING.md). Chưa thao tác timeline hàng loạt.

1. Lập ma trận **toàn bộ beat** từ VO: nguồn cần, duration dùng được, exact-place hay generic context, nguồn chính/dự phòng, query đã thử, trạng thái. Ưu tiên những câu khó, lịch sử và hành động ít footage.
2. Tìm nhiều candidate theo tháp A+B và theo chuỗi; gom đợt video/ảnh theo nhu cầu toàn phim. Càng nhiều lựa chọn phù hợp càng tốt trong ngân sách và chất lượng; không biến số lượng thành lý do mua trùng hoặc lấy cảnh lệch nghĩa.
3. Xem preview/range → loại trùng provider ID/hash/nguồn gốc → tải lô có kiểm soát. Với GetHinh, xác nhận mỗi batch thật sự có file trước khi gửi tiếp. Ghi query, nguồn, license, hash, chi phí và usable range. Danh sách URL chưa được tính là footage sẵn sàng.
4. Mỗi beat phải có nguồn chính đã tải, giải mã được và đủ range. Các beat khó có phương án thay hợp lý được ghi. Bổ sung ảnh thật cho lịch sử; AI chỉ sau khi tìm nguồn thật phù hợp không được, theo [quy tắc AI](../../AI_REPORTER.md).
5. Tính kế hoạch video 50–70% trên **toàn thời lượng hình**, mục tiêu làm việc gần 60–65% để có dư địa chỉnh. Theo dõi từng chương và cửa sổ 60s để phát hiện vùng thiếu, không bắt intro giảm khỏi 100% video. Mỗi still, kể cả MP4 pan/zoom, vẫn tính ảnh.
6. Trước khi tìm âm thanh mới, tra `Hidden Chapters/Music/catalog.csv` và nghe các nguồn có sẵn theo [kho Music](../../AUDIO_LIBRARY.md); ghi nguồn chọn lại và các mood/range còn thiếu. Trong cùng bước sourcing, tìm **nhiều background music** theo các mood/cue của phim; lưu nhiều ứng viên để nghe/chọn. Tìm SFX cho intro; tìm ambience đủ các không gian xuyên phim. Tải các lựa chọn đã duyệt trong ngân sách, không phải mọi kết quả tìm được. Chi tiết lựa chọn/mix ở bước 06.

## Kiểm chiều khung hình trước tải và trước gán

- Ghi format phim đã duyệt. Với phim ngang, lọc Horizontal tại provider, xem width/height/orientation trên trang item trước khi mua/tải và probe original sau tải. Review đúng nội dung không thay kiểm format.
- Không dùng video dọc cho phim ngang khi người dùng không cho phép. Crop, đệm viền hoặc collage không biến một original dọc thành footage ngang phù hợp. Kiểm cả nội dung dọc lồng trong compilation ngang.
- Nếu lỗi mới được phát hiện, gỡ source khỏi slot, giữ original để truy vết, tìm nguồn ngang đúng nghĩa, căn lại điểm cắt theo VO và kiểm tỷ lệ video thật. Ảnh tư liệu thay thế vẫn tính ảnh; ghi rõ giới hạn thay thế.
- Audit nguồn bound phải chặn video portrait. Không dùng số lượng asset hay tỷ lệ video dự kiến để báo nguồn đã đủ.

**Checklist hoàn tất — cổng trước dựng hàng loạt**
- [ ] 100% beat có nguồn đã tải và review phù hợp; không còn slot chỉ có query/placeholder.
- [ ] Video dự kiến 50–70%; intro có video đầy đủ, kể cả phần reporter dự phòng.
- [ ] Đủ unique source/range cho nhịp 2–10s video, ≤8s ảnh; không cộng dồn cả duration file nguồn vào coverage.
- [ ] Đã tra kho Music trước tìm mới; chọn cũ/mới theo nhu cầu, kiểm cùng canonical track và lịch sử dùng.
- [ ] Có lựa chọn dự phòng cho cảnh khó; music shortlist, intro SFX và ambience đã lên kế hoạch.
- [ ] Cost ledger, download ledger và usage map khớp file trên đĩa.

**Sau khi dựng:** nếu thiếu hoặc preview phát hiện sai, ghi đúng beat/thời gian/lý do → quay lại batch sourcing chỉ cho deficit đó → kiểm lại gate 02/03 → patch bản dựng. Không vì tránh vòng lặp mà giữ cảnh sai. Không có số lượng mua tối thiểu bắt buộc.

**Gate 02 đạt → [03](../../../stages/03_MEDIA_PREP.md).** Nếu nguồn chưa đủ, tiếp tục bước 02; không dùng timeline rỗng như một bản dựng đã hoàn tất.
