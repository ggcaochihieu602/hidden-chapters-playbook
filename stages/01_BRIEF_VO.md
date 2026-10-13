# 01 — Script, master VO và thời gian từng vế

## Đầu vào
Script và/hoặc VO của chat phim; [project profile](../templates/project.json). Script đã chọn giữ nguyên câu chữ. Khi viết script mới, mở [motif](../reference/MOTIF.md): luận đề cảm xúc, giải thích đơn giản, viết theo cảnh dễ tìm footage.
## Việc làm
1. Ghi script/VO path, hash, language, voice, speed và override. Ưu tiên VO người dùng đã chọn. Nếu chưa có VO: American low 0.8 tiếng Anh, một master từ toàn script; không tạo lại từng câu và nối để đạt thời lượng.
2. Đo duration thật; ASR/forced alignment đối chiếu **script nguyên văn** tạo word/phrase timestamps. Không lấy tốc độ từ/s hoặc timecode ước lượng làm mốc cuối. Tên riêng/ngày ASR sai: giữ lời script, xác định mốc audio, chỉ rà vùng nghi vấn.
3. Chia câu dài thành 2–3 vế theo ý: địa điểm/thời gian → hành động → hệ quả. Giữ nguyên thứ tự và wording; ghi câu trước/sau, chapter, ý chính, thực thể, thời kỳ và vai trò hình. Dùng [bảng vế](../templates/clauses.csv) và [ví dụ](../reference/CLAUSE_MATCHING.md).
4. Ghi riêng `vo_start/end_seconds` và `timeline_start/end_frame`; timeline origin là offset Resolve, không cộng vào SRT. Lưu quyết định làm tròn frame và anchor thực của mỗi vế. Frame tính theo fps/origin trong profile, không cần mở Resolve; bước 04 đối chiếu lại native.
5. Lên kế hoạch **intro 10–20s không VO**, toàn video + music + SFX theo highlight của phim. Giữ nguyên master; đặt lời đầu tiên sau intro. Map VO→timeline cộng duration intro đo thực và các pause; tính lại hình/text/audio/caption/chapter khi đổi offset.
6. Lên kế hoạch nghỉ 3–5s khi chuyển chương: VO ngừng, nhạc+hình còn. Ưu tiên khoảng nghỉ tự nhiên đủ dài; nếu cần thêm, chia **cùng master** tại ranh giới chương và chèn khoảng không lời vào bản dựng, giữ file gốc. Tạo bảng offset rồi tính lại hình/text/audio/caption sau mỗi pause. Không tái tạo voice để lấy pause. Phim chỉ sửa một track thì không tự ripple toàn timeline.
## Quyết định
Không cắt máy móc theo dấu phẩy. Một vế ngắn có thể chia sẻ cảnh với vế tương thích để tránh shot dưới 2s; vẫn ghi anchor, và không đưa hình của ý kế tiếp sớm. Vế dài hơn 10s có cảnh phụ cùng ý, ưu tiên mốc cụm ý đo được. Reporter chỉ khi có chỉ đạo riêng, ngoài intro không VO mặc định; có stock backup, không đọc trùng span narrator; tra [reporter](../reference/AI_REPORTER.md).
## Đầu ra
Master VO đã chọn, word timestamps, clauses, chapter/pause map, hồ sơ nguồn và scope.
## Gate Claude C1 — bắt buộc
Sau khi có master VO và word timestamps: tách narration nguyên văn theo lô 1–2 chương vào packet, gọi C1 theo [mẫu](../templates/CLAUDE_GATE_PROMPTS.md). Claude tạo các cột ngữ nghĩa của bảng vế; Codex chạy `scripts/check_claude_handoff.py verdict` và `clauses --from-answer --narration ... --template templates/clauses.csv` — phải PASS (ghép verbatim đúng 100% narration). Sau đó **Codex** điền `vo_start/end_seconds`, `timeline_*` từ alignment bằng script, không lấy số từ Claude. FAIL wording → gọi lại một lần với dòng lệch; vẫn FAIL thì Codex tự chia lại đoạn lệch và ghi `codex_only`. Không qua C1 thì không sang tìm nguồn hàng loạt. [Quy tắc](../reference/CLAUDE_COLLAB.md).
## Checklist
- [ ] C1: bảng vế do Claude tạo đã qua `check_claude_handoff.py clauses` PASS; timing do Codex điền từ alignment.
- [ ] VO liền mạch, đúng preset/tốc độ hoặc override/file được giao.
- [ ] Tất cả vế có mốc thực và quan hệ ngữ cảnh; không còn anchor ước lượng chưa xử lý.
- [ ] Map VO→timeline gồm intro 10–20s không VO và pause/offset; caption/hình sẽ dùng cùng map.
- [ ] Không đổi script/voice âm thầm; progress lưu xong.
## Ví dụ
“In the middle of the day, along a valley beside Adventfjorden” là vế định vị Longyearbyen. “the streetlamps are already burning bright” là vế hành động/điểm bất thường; cảnh đèn sáng bắt đầu ở vế sau.
## Sửa lỗi
Alignment lạc tên riêng → đối chiếu script và vùng audio nhỏ. VO mới → vô hiệu binding cũ, không dời cảnh bằng tỷ lệ duration toàn phim. Thêm pause → cập nhật bảng offset, không chỉ kéo text/nhạc riêng.
## Tiếp tục
Gate 01 đạt → [02](02_SOURCE_BATCH.md). Tạo bảng keyword/music từ script trước khi tìm mở rộng.
