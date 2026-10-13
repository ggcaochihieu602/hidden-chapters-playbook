# Lịch sử ver 10 — chỉ tra lỗi kỹ thuật

Quy tắc hiện hành ở START_HERE và stages của ver 11; lịch sử không được ghi đè chỉ đạo mới.

# 05 — Dựng hình theo lô trong Resolve

**Điều kiện:** gate 01–04 đạt; toàn phim có nguồn đã kiểm. Dựng dựa trên VO master và native project hiện hành.

1. Duplicate timeline/snapshot đã lưu. Tách V1 hình, V2 text, A1 VO, A2 music, A3 ambience, A4 intro SFX theo nhu cầu; không tạo một track cho mỗi cue.
2. Tạo một index native start-frame/source cho batch. Append clip theo semantic beat và source range; kiểm clip trả về trực tiếp. Không quét lại toàn timeline qua bridge cho từng clip (Tristan từng cạn socket sau hàng nghìn kết nối).
3. Video 2–10s; still ≤8s. Intro 100% video, thường 3–5s/cảnh; reporter được giữ hết câu nếu bật. Mỗi source một lần phần chính; intro teaser là ngoại lệ ghi riêng. Không chia cùng ảnh thành hai clip để lách giới hạn hold.
4. So sánh native source-in giây, record start/end, fps, speed, path với kế hoạch. Đầu/cuối API có thể khác theo version/import path; thử một clip rồi đọc lại số frame. Nếu sai, chỉ xóa lần chèn mới bị lỗi, không xóa cả track.
5. Sau từng batch, lưu project/DRP/XML ở **nơi làm việc cũ**, cập nhật manifest và source usage từ native. Retry dựa item ID/start/source để không chèn trùng. Không tin cờ `timeline_used:false` cũ.
6. Audit toàn timeline theo thời gian: không gap, coverage đúng VO, 50–70% moving video, tỷ lệ từng chương/cửa sổ 60s, không chuỗi ảnh dài vô cớ. Ghép compound các continuation cùng nguồn chỉ khi thực sự liên tục và tổng shot vẫn ≤10s; re-audit sau sửa.

**Checklist hoàn tất**
- [ ] V1 phủ đúng toàn VO; không gap/missing/offline media.
- [ ] Video-share thực 50–70%, không tính still-derived MP4 thành video.
- [ ] Mọi video shot 2–10s, cùng ảnh liên tiếp không vượt tổng 8s; nguồn không lặp trái phép.
- [ ] Đã kiểm source seconds và thứ tự thật, không chỉ file manifest.
- [ ] Readback native khớp, VO/chỉnh tay được bảo toàn, snapshot lưu xong.

**Nếu thiếu hình/sai nghĩa:** ghi deficit theo beat, quay lại bước 02/03 một đợt bổ sung. Các bước sau chỉ chuyển tiếp khi gate hình lại đạt.

**Gate 05 đạt → [06](../../../stages/06_AUDIO.md).**


## Kiểm quy ước frame trên build đang dùng

- Đo với append ngắn có rollback trước batch. Trên Resolve21.0.2.4 bridge, AppendToTimeline dùng endFrame EXCLUSIVE: start0/end90 tạo90frame. Đọc lại GetStart/GetEnd/GetDuration và source-time span; không trộn chỉ số source với timeline khi fps khác.
- Giữ ranh giới câu/vế/từ đã khóa và đối chiếu path/start/end native với plan sau thay nguồn. Việc duration khớp chưa chứng minh đúng source-in hoặc đúng nội dung.


## Thay hình sau khi khóa VO

- Giữ mốc start/end đã căn theo câu/vế/từ. Trên Resolve21.0.2.4, AddTake(pool,0,frames) → chọn take cuối → FinalizeTake giữ item/timing/properties; readback path/start/end sau mỗi batch. Cần xác minh trên build đang dùng trước áp dụng.
- Chỉ import derivative đã xem motion. Save/checkpoint; kiểm 349 cảnh, EOF và tất cả track âm thanh không đổi theo baseline project thực. Không để renderer ghi ledger cũ đè native/QC flag trong lúc batch render đang chạy.
