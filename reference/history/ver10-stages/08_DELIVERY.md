# Lịch sử ver 10 — chỉ tra lỗi kỹ thuật

Quy tắc hiện hành ở START_HERE và stages của ver 11; lịch sử không được ghi đè chỉ đạo mới.

# 08 — QC cuối, xuất và sắp sản phẩm

**Đọc:** [quy tắc đầu ra](../../OUTPUT_RULES.md) + [mẫu thumbnail/logo](../../../visuals/INDEX.md#thumbnail-va-logo). Chỉ sau gate 01–07; nếu tiếp tục phim cũ, dùng evidence đã có và rà phần bị thay đổi.

1. Native preflight: đúng project/timeline/fps, không missing/gap/EOF, source-in đúng, video 50–70%, mọi video 2–10s, still ≤8s, uniqueness/crop/motion đạt. Đọc source lineage, không suy media kind từ extension.
2. Xem/nghe phim theo từng chương, ghi phạm vi thực sự đã review. Kiểm câu địa danh/cơ chế/hành động khó, chữ/fade/caption, nhạc peak/VO nhỏ, ambience đổi không gian, intro SFX. Đo peak/LUFS hỗ trợ nghe; không thay cho nghe.
3. Xuất ngắn vài đoạn rủi ro bằng Resolve, kiểm frame/audio. Full render theo phạm vi user đã giao; nếu chỉ yêu cầu project thì dừng ở project. Không dừng/restart render đang chạy để áp sửa ngoài yêu cầu.
4. Export master vào nơi làm việc hoặc đường final đã xác định; chỉ công nhận final khi file đầy đủ, probe/decode đạt duration/fps/dimensions/codec/audio và sample đầu/giữa/cuối. Lưu DRP/XML/manifest trong nơi làm việc hiện có.
5. Tạo caption `.srt` từ **VO và timeline cuối**, không lấy timecode script dự kiến. Kiểm offset 01:00:00:00 của Resolve: SRT cho file xuất bắt đầu ở 00:00:00, không mang offset timeline. Caption không vượt EOF; spot-check intro/giữa/cuối và tên riêng.
6. Thumbnail final + đúng prompt đi kèm; đọc mẫu tại gốc `Hidden Chapters`, dùng `4k Icon.png`/logo có sẵn theo brief. Không áp chữ trắng không outline của phim lên thumbnail vì mẫu thumbnail có phong cách riêng. Description/chapter/credits cùng folder nếu được giao. Kiểm quyền/attribution trước phát hành; không tự publish chỉ vì xuất xong.
7. Copy/export các sản phẩm đã kiểm vào **một folder** `Hidden Chapters\YYYY-M-D-Ten-Phim`. Dùng folder sẵn có nếu có; giữ tên/date. Không chuyển footage, VO, cache, project hay backup. Ghi [delivery manifest](../../../templates/delivery.json) trong hồ sơ làm việc với đường final, hash, playbook version và trạng thái từng deliverable.

**Checklist bàn giao**
- [ ] Final MP4 đã xuất hoàn tất; không giao file interrupted như thành phẩm.
- [ ] Thumbnail final + prompt khớp; caption theo đúng mốc final; đủ sản phẩm được yêu cầu.
- [ ] Đúng folder/tên; các path nguồn và bản dựng không đổi.
- [ ] QC nói rõ native/sample/full/listened/user-reviewed; các phần chưa đạt còn được ghi.
- [ ] Chi phí actual/estimated/unknown, quyền dùng và credits đầy đủ.
- [ ] `progress.json` hoàn tất, `playbook_version` đúng bản đã dùng, nguồn bài học mới được lưu.

Nếu chỉ giao project: ghi rõ chưa full export, chưa tạo giả `<Slug>.mp4`; thư mục final không chứa rough cut. Nếu một đầu ra đang thiếu, tiếp tục phần được giao cho đến khi đủ hoặc báo blocker cụ thể.


## Render range và settings đã đo

- Frame capture có thể đổi Deliver range. Trước MỖI short/full export, pin preset rồi set MarkIn/MarkOut/TargetDir/CustomName, đọc lại job và so với expectedframes trước start. Không capture frame native trong lúc full render.
- Trên Resolve21.0.2.4, SelectAllFrames=false và VideoQuality=45000 bị SetRenderSettings từ chối. Không retry nguyên batch sai; đo từng key và giữ recipe được build này chấp nhận. H.264Master + explicit3840x2160/30fps/AAC48k + MarkIn108000/MarkOut159072 cho RapaNui51073frame. Đây là evidence của build/project cụ thể, không phải mốc cho phim khác.
- Job Complete không đủ. Verify output trước xóa job; probe actualframes/duration/codec/audio, decode EOF và đo loudness file native. Ghi rõ phạm vi xem/nghe thật. Không đánh dấu auditory QC passed khi phiên không có audio input.


## Revision và phạm vi QC

- Thumbnail theo sample có người tiền cảnh thì brief phải có người tương tác tiền cảnh; xem kết quả thực, giữ bản cũ và prompt đi kèm. Thumbnail composite không dùng làm bằng chứng lịch sử.
- Native capture phải cho thấy full-frame, chủ thể/chữ, logo và frame motion. Rerender bản full sau sửa source; bản full cũ không chứng minh revision đã xuất.
- Audio export có thể không khớp requested range hoặc thiếu video dù job metadata nói có: probe stream và đối chiếu lời thực tại đầu file trước so tín hiệu. So sai cửa sổ không chứng minh nhiễu. Khi user nói không chỉnh VO nữa, ghi quyết định và tiếp tục hình; không đánh dấu lỗi nghe đã sửa khi chưa có nghe xác nhận.
