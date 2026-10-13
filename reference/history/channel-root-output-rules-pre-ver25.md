# Hidden Chapters — vị trí sản phẩm cuối và tài nguyên dùng chung

Quyết định của người dùng ngày 28/09/2026. Áp dụng cho mọi project Hidden Chapters sau này.

- Gốc đầu ra: `E:\Youtube AI\Hidden Chapters`.
- Mỗi phim dùng **một thư mục** `YYYY-M-D-Ten-Phim`, cùng dạng với `2026-8-28-Longyearbyen`. Nếu thư mục project đã tồn tại, dùng lại đúng tên; không sửa ngày hoặc tạo thư mục thứ hai. Với project mới, ghi ngày tạo thư mục theo giờ địa phương một lần trong hồ sơ, không đổi theo từng lần xuất.
- Trong thư mục phim: `<Slug>.mp4` (video cuối), `<Slug>-thumbnail-vN.png` hoặc `.jpg`, `<Slug>-thumbnail-vN-prompt.txt`, `<Slug>-EN.srt` (caption đúng timeline xuất). Có thể thêm `<Slug>-description.txt`, chapter timestamps và credits khi được giao.
- Chỉ xuất/copy **sản phẩm cuối đã kiểm** vào đây. Caption và thumbnail final có thể giao trước video; báo riêng file nào còn thiếu. Không đưa rough cut, footage, cache, proxy, VO nguồn, `.drp`, `.kdenlive` hoặc các bản dựng vào thư mục thành phẩm. Giữ tất cả chúng tại vị trí làm việc hiện có. Không chuyển media làm đứt liên kết timeline.
- Tài nguyên kênh giữ nguyên tại gốc: `logo.png`, `logo overlay.png`, `4k Icon.png`, `Thumb Sample1.jpg`, `Thumb Sample2.jpg`, `Thumb Sample3.jpg`. Dùng đúng file hiện có; không tạo lại logo nếu chưa được yêu cầu. Ba thumbnail là mẫu bố cục/phong cách, không phải bằng chứng địa lý.
- Toàn bộ playbook ở `E:\Youtube AI\Hidden Chapters\Playbooks`. Tên ngắn: `Playbook ver N` và `Playbook ver N.zip`; bản mới chọn bằng pointer. Đọc `LATEST.md`/`LATEST.json` để chọn bản mới nhất; không đoán theo thời gian sửa file.
- Mỗi project ghi `playbook_version` và đường dẫn bản đã dùng trong hồ sơ ở thư mục làm việc. Bản cũ giữ nguyên để tra; thay đổi playbook giữa phim phải ghi override. Không cần copy playbook vào từng thư mục video.
- Khi giao lại file cuối đã tồn tại, giữ bản trước trong nơi làm việc hoặc đổi hậu tố phiên bản có chủ đích; không ghi đè im lặng. Kiểm file đích tồn tại, mở/giải mã được, caption khớp final và prompt đi cùng đúng thumbnail.

Mẫu hiện hữu: `E:\Youtube AI\Hidden Chapters\2026-8-28-Longyearbyen` có `Longyearbyen.mp4`, `Longyearbyen-thumbnail-v1.png`, `Longyearbyen-thumbnail-v1-prompt.txt`, `Longyearbyen-EN.srt`.


## Kho Music dùng chung — cập nhật 28/09/2026

`E:\Youtube AI\Hidden Chapters\Music` lưu Background, Ambience, SoundEffects và Prepared. **Kiểm catalog và nghe nguồn phù hợp trong kho trước khi search/tải music, SFX hoặc ambience mới.** Phối nhạc cũ với nhạc mới để đủ mood và tránh lặp trong phim dài; không ấn định tỷ lệ cũ/mới, không ép dùng lại nguồn không hợp. Xem lịch sử cue để tránh lặp cùng đoạn hoặc cùng bài quá gần giữa các phim.

Đây là ngoại lệ lưu bản sao tài nguyên dùng chung bên cạnh folder thành phẩm: original audio, footage và working project vẫn giữ nguyên chỗ cũ. Khi nhập kho, copy + hash + probe, giữ source/license/generation record và canonical track ID. WAV/MP3, short/full, loop/gain variants không phải các bài độc lập. Prepared có gain/fade/loop rồi; ưu tiên original để phối lại.

Nhạc/SFX mới sau khi tải và kiểm được bổ sung vào kho cùng provenance; ghi usage project/cue/range/mood vào sổ. Quyền dùng của lần tải cũ không tự chứng minh đã có chứng nhận cho phim mới. SFX mặc định ở intro, ambience xuyên phim vẫn giữ theo quy tắc hiện hành.


## ZIP và tất cả biến thể — cập nhật 01/10/2026

Lưu `Music\Archives\<provider>\<canonical-ID>\original.zip` **và toàn bộ folder giải nén** (hoặc giữ tên ZIP/folder có sẵn). Copy vào kho, không move working files. Full/loop/short/stinger/WAV/MP3 và license/readme đi cùng canonical composition; catalog có zip_path/extracted_folder/variant khi thêm nguồn mới. Không dùng chỉ MP3 full rồi bỏ loop ZIP.

Nguồn cũ chưa tìm thấy ZIP: ghi `archive_missing`, giữ file audio đã có; không giả đã lưu cả bộ hoặc mua lại vô cớ. Chỉ tải lại từ item/quyền sẵn có nếu cần và được phép. Prepared dành cho loop/gain/fade của cue; giữ source range/lineage. File/cue riêng theo chương và nhiều layer nếu phù hợp, không quy định số bài tối đa. Ngân sách mặc định audio **20 xu combined**; reusable rights kiểm cho project mới.

Nghỉ chapter 3–5s vẫn có music+hình, chỉ dừng VO. Ambience theo nội dung chương/không gian; không mặc định một ambience piece là đủ mọi phim. Local audio từ video ở track Local sound effect.


## Scope bàn giao — 01/10/2026

AI dựng đến timeline đã lưu và mở sẵn cho người dùng xem/góp ý; người dùng tự export. Không tự xuất full, kể cả chỉ sửa audio. Các tên MP4/SRT/thumbnail trên là quy tắc lưu **khi sản phẩm được giao**, không tự mở rộng scope. Không coi thiếu MP4 là task timeline chưa hoàn tất.
