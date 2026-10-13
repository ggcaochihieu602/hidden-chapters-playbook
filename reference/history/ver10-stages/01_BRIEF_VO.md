# Lịch sử ver 10 — chỉ tra lỗi kỹ thuật

Quy tắc hiện hành ở START_HERE và stages của ver 11; lịch sử không được ghi đè chỉ đạo mới.

# 01 — Khóa đầu vào, căn lời

**Đọc:** trang này; motif chỉ khi đang viết script cộng đồng xa xôi: [motif](../../MOTIF.md). Với script đã duyệt, giữ câu chữ.

**Đầu vào:** brief/script, VO nếu đã có, project đang dựng, chỉ đạo mới và ngân sách. Không hỏi lại phần chat đã chốt.

1. Ghi phiên bản/hash của brief/script/VO, ngôn ngữ, editor, fps/resolution và folder thành phẩm theo [quy tắc đầu ra](../../OUTPUT_RULES.md). Dùng schema hiện hành khi lưu MP2; planning JSON không tự là API payload.
2. Đọc bảng/cột và hình của brief đúng thứ tự. Ghi yêu cầu + override, ngân sách video/music/SFX/AI riêng; actual/estimated/unknown tách biệt. Không dùng ngân sách Tristan làm mặc định.
3. Nếu cần tạo VO, dùng preset đã chọn và hash mẫu giọng. Với Tristan: documentary-american-low kể chính; reporter là phương án 2, Flow tự chọn giọng reporter. Phim mới kế thừa chỉ khi user/profile xác định. Nghe mẫu trước batch VO; giữ master khi đã duyệt.
4. Đếm từ nói thực, không tin số từ model tự báo. Probe VO, căn script bằng ASR/word timestamps. Kiểm chỗ tên riêng, ngày và đổi chương. Duration thật của VO quyết định timeline.
5. Tạo scene ledger theo câu/cụm ý: start/end, vo_span, nơi/thời kỳ, đối tượng, hành động, vai trò evidence/context/explanation/transition, điều không được thay thế.
6. Reporter chỉ 1–2 lần khi bật. Có stock dự phòng cho cả span reporter; lời reporter thay span narrator, không đọc trùng. Tra [AI/reporter](../../AI_REPORTER.md) đúng lúc cần.

**Checklist hoàn tất**
- [ ] Có bản khóa và hash, preset giọng đúng; không tự viết lại VO đã giao.
- [ ] Toàn VO có beat/timestamp, chapter boundaries dựa lời thật.
- [ ] Ghi 50–70% video; video 2–10s; still ≤8s; intro SFX; ambience toàn phim.
- [ ] Có ngân sách, nơi làm việc và nơi đầu ra riêng; lưu `progress.json`.

**Lỗi thường gặp:** script số từ sai → đo lại spoken text; ASR nhầm tên → đối chiếu script, không sửa audio theo transcript sai; VO import mất media ID → dùng bản binding hiện hành. Chưa có VO đúng thì chưa chốt nguồn theo timecode giả định.

**Gate 01 đạt → [02](../../../stages/02_SOURCE_BATCH.md).**
