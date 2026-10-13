# Hidden Chapters — vị trí sản phẩm cuối và tài nguyên dùng chung

Quyết định của người dùng ngày 28/09/2026. Áp dụng cho mọi project Hidden Chapters sau này.

- Gốc đầu ra: `E:\Youtube AI\Hidden Chapters`.
- Mỗi phim dùng **một thư mục** `YYYY-M-D-Ten-Phim`, cùng dạng với `2026-8-28-Longyearbyen`. Nếu thư mục project đã tồn tại, dùng lại đúng tên; không sửa ngày hoặc tạo thư mục thứ hai. Với project mới, ghi ngày tạo thư mục theo giờ địa phương một lần trong hồ sơ, không đổi theo từng lần xuất.
- Folder thành phẩm chỉ chứa đầu ra cuối đã kiểm và được giao: MP4, SRT, thumbnail được chọn + prompt tương ứng; description/chapter timestamps/credits hoặc gói nội dung đăng tải cuối chỉ khi được giao. Không mặc định giữ tất cả phiên bản thumbnail/prompt; bản nháp, ứng viên, phiên bản cũ lưu tại workspace, trừ khi người dùng yêu cầu giao nhiều phương án. Không lưu hồ sơ kỹ thuật, file theo dõi hay tài liệu nội bộ trong folder thành phẩm, kể cả dưới thư mục con. Tên thông thường: `<Slug>.mp4`, `<Slug>-thumbnail-vN.png` hoặc `.jpg`, `<Slug>-thumbnail-vN-prompt.txt`, `<Slug>-EN.srt`; giữ tên caption hiện hữu nếu đã chốt, ví dụ `captions.en_US.srt`.
- Chỉ xuất/copy **sản phẩm cuối đã kiểm** vào đây. Caption và thumbnail final có thể giao trước video; báo riêng file nào còn thiếu. Không đưa rough cut, footage, cache, proxy, VO nguồn, `.drp`, `.kdenlive` hoặc các bản dựng vào thư mục thành phẩm. Giữ tất cả chúng tại vị trí làm việc hiện có. Không chuyển media làm đứt liên kết timeline.
- Tài nguyên kênh giữ nguyên tại gốc: `logo.png`, `logo overlay.png`, `4k Icon.png`, `Thumb Sample1.jpg`, `Thumb Sample2.jpg`, `Thumb Sample3.jpg`. Dùng đúng file hiện có; không tạo lại logo nếu chưa được yêu cầu. Ba thumbnail là mẫu bố cục/phong cách, không phải bằng chứng địa lý.
- Toàn bộ playbook ở `E:\Youtube AI\Hidden Chapters\Playbooks`. Tên ngắn: `Playbook ver N` và `Playbook ver N.zip`; bản mới chọn bằng pointer. Đọc `LATEST.md`/`LATEST.json` để chọn bản mới nhất; không đoán theo thời gian sửa file.
- Mỗi project ghi `playbook_version` và đường dẫn bản đã dùng trong hồ sơ ở thư mục làm việc. Bản cũ giữ nguyên để tra; thay đổi playbook giữa phim phải ghi override. Không cần copy playbook vào từng thư mục video.
- Khi giao lại file cuối đã tồn tại, giữ bản trước trong nơi làm việc hoặc đổi hậu tố phiên bản có chủ đích; không ghi đè im lặng. Kiểm file đích tồn tại, mở/giải mã được, caption khớp final và prompt đi cùng đúng thumbnail.

Mẫu đã kiểm ngày 04/10/2026: `E:\Youtube AI\Hidden Chapters\2026-8-28-Longyearbyen` có đúng 4 file: `Longyearbyen.mp4`, `captions.en_US.srt`, `Longyearbyen-thumbnail-v1.png`, `Longyearbyen-thumbnail-v1-prompt.txt`. Dùng cấu trúc gọn này làm chuẩn; không bắt đổi tên file mẫu.


## Audio trong workspace phim

Music/SFX/ambience chọn và tải mới từ Epidemic Sound cho từng video. Lưu bản tải gốc, variant và hồ sơ nguồn/quyền/cue tại workspace của phim; [nguồn âm thanh](MEDIA_SOURCES.md).

## Scope bàn giao — 01/10/2026

AI dựng đến timeline đã lưu và mở sẵn cho người dùng xem/góp ý; người dùng tự export. Không tự xuất full, kể cả chỉ sửa audio. Các tên MP4/SRT/thumbnail trên là quy tắc lưu **khi sản phẩm được giao**, không tự mở rộng scope. Không coi thiếu MP4 là task timeline chưa hoàn tất.

## Folder sản phẩm phải được đăng ký trước bàn giao — 02/10/2026
Khi bàn giao timeline, tạo hoặc dùng lại đúng một folder `YYYY-M-D-Ten-Phim` dưới Hidden Chapters và ghi `final_output_folder` vào project profile tại workspace. Việc chưa được phép export MP4 không phải lý do bỏ qua folder này; folder có thể trống khi chưa có thành phẩm. Folder thành phẩm chỉ chứa đầu ra cuối đã kiểm và được giao: MP4, SRT, thumbnail được chọn + prompt tương ứng; description/chapter timestamps/credits hoặc gói nội dung đăng tải cuối chỉ khi được giao. Không mặc định giữ tất cả phiên bản thumbnail/prompt; bản nháp, ứng viên, phiên bản cũ lưu tại workspace, trừ khi người dùng yêu cầu giao nhiều phương án. Không lưu hồ sơ kỹ thuật, file theo dõi hay tài liệu nội bộ trong folder thành phẩm, kể cả dưới thư mục con. Project/progress/delivery JSON, DELIVERY-MANIFEST, summary/README-REVIEW, native QC/readback/revision/checkpoint, DRP/XML, ledger, log, ghi chú biên tập, danh sách title ứng viên, script/VO/footage/audio/cache/proxy và backup lưu tại workspace của phim. Summary/manifest tại workspace ghi sản phẩm thực có, sản phẩm còn thiếu và đường dẫn folder thành phẩm; báo ngắn trong chat, không tạo thêm file báo cáo trong folder thành phẩm. Không giả MP4/thumbnail/prompt hoặc tự mở rộng sang export/generate. Caption/mốc chương nếu được giao dùng timeline hiện hành, gồm duration intro thực và chapter-pause offsets; cập nhật khi người dùng sửa timing. Giữ nguồn và liên kết media nguyên vẹn. Yêu cầu cập nhật tài liệu không tự cho phép dọn/xóa/di chuyển file project hiện có.

Checklist bổ sung: `final_output_folder` khác null và folder tồn tại; từng file bên trong là thành phẩm được giao; không có hồ sơ kỹ thuật/bản nháp/bản cũ. Summary/manifest/progress/delivery/QC/checkpoint lưu tại workspace, khớp file thực; sản phẩm còn thiếu được báo riêng trong chat.
