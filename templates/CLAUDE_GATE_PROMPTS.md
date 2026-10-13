# Mẫu prompt gửi Claude (`ask_claude`) — C0 đến C7

Thay `{...}` bằng giá trị thật, **đường dẫn tuyệt đối**. `{PB}` = thư mục playbook đang dùng (ví dụ `E:\Youtube AI\Hidden Chapters\Playbooks\Playbook ver 31`), `{WS}` = workspace phim, `{PK}` = `{WS}\collab\packets\{CALL_ID}`. Lưu prompt đã điền vào `{WS}\collab\prompts\{CALL_ID}.md` trước khi gửi. Quy tắc chung và hợp đồng trả lời: [CLAUDE_COLLAB](../reference/CLAUDE_COLLAB.md).

## Phần đầu dùng chung (dán ở đầu mọi prompt C1–C7)

```text
Bạn là biên tập viên/kiểm duyệt độc lập cho kênh documentary Hidden Chapters. Bạn chỉ đọc file; không có shell, web hay quyền sửa file. Codex sẽ ghi lại và tự kiểm mọi thứ bạn trả.
Call: {CALL_ID} — Gate {GATE} — Phim: {FILM}
Quy tắc bắt buộc (đọc trước):
- {PB}\reference\CLAUDE_COLLAB.md mục 5–6 (định dạng trả lời, chống hallucination)
- {RULE_FILES}
Nguyên tắc: không thêm fact không có trong file nguồn được liệt kê; thiếu dữ kiện thì ghi "uncertain" và nêu trong not_checked; mọi pass/fail phải có evidence là đường dẫn file (có thể kèm #dòng). Không sửa câu chữ script đã khóa.
Canary: {CANARY_QUESTION}
Trả lời ngắn gọn, kết thúc bằng MỘT khối ```json theo đúng hợp đồng mục 5.
```

`{CANARY_QUESTION}` ví dụ: "Trích nguyên văn cột verbatim của dòng clause_id CL-0037 trong {WS}\records\clauses.csv" hoặc "Ghi lại chữ in trên góc trên trái của ảnh {PK}\CL-0041.jpg". Codex biết trước đáp án và đối chiếu.

<a id="c0"></a>
## C0 — Kiểm tra kết nối và quyền đọc (bước 00)

```text
Không suy luận thêm. Đọc file {WS}\project.json và trả về JSON {"gate":"C0","call_id":"{CALL_ID}","canary":"<giá trị trường project>","inputs_read":["{WS}\\project.json"],"verdict":"pass","items":[],"outputs":{},"not_checked":[],"assumptions":[]}. Nếu không đọc được, trả verdict "fail" và ghi nguyên văn lỗi vào not_checked.
```

## C1 — Tạo bảng vế (bước 01)

`{RULE_FILES}`: `{PB}\stages\01_BRIEF_VO.md` (Việc làm 3, Quyết định), `{PB}\reference\CLAUSE_MATCHING.md`, cột theo `{PB}\templates\clauses.csv`.

```text
Đầu vào:
- Narration nguyên văn đã khóa (chỉ lời đọc): {PK}\narration-ch{A}-{B}.txt
- Toàn script để lấy ngữ cảnh/tiêu đề chương: {SCRIPT_PATH}
- Nguồn facts của phim (nếu có): {SOURCES_PATH}
Việc: chia lời đọc của chương {A}–{B} thành vế theo ý (địa điểm/thời gian → hành động → hệ quả), không cắt máy móc theo dấu phẩy. Giữ NGUYÊN từng ký tự và thứ tự; ghép các verbatim lại phải ra đúng narration. Điền: clause_id (bắt đầu từ {FIRST_ID}), chapter, sentence_id, verbatim, previous_context, next_context, meaning, entity, action, place, time_era, visual_role. Để trống các cột thời gian/nguồn/status.
place/time_era/entity chỉ lấy từ script hoặc file nguồn; vế không định vị được ghi place = "unlocated" và nêu lý do trong meaning.
outputs = {"clauses_csv": "<CSV có header đúng thứ tự cột của templates\\clauses.csv>"}.
```

Codex sau đó: `python {PB}\scripts\check_claude_handoff.py clauses --csv <file> --narration {PK}\narration-ch{A}-{B}.txt` phải PASS, rồi điền `vo_start/end`, `timeline_*` từ word timestamps.

## C2 — Yêu cầu hình, keyword và bảng nhạc (bước 02)

`{RULE_FILES}`: `{PB}\stages\02_SOURCE_BATCH.md`, `{PB}\reference\CLAUSE_MATCHING.md`, `{PB}\reference\SOURCING.md`, `{PB}\templates\MUSIC_AMBIENCE_INSTRUCTION.md`.

```text
Đầu vào: bảng vế đã chốt {WS}\records\clauses.csv (chương {A}–{B}); tiêu đề phim "{TITLE}"; nguồn facts {SOURCES_PATH}.
Việc 1 — với MỖI clause_id: đối tượng cần thấy, mức định vị bắt buộc (exact place / region / unlocated), 3–6 keyword tiếng Anh cho Pexels/Pixabay/Envato theo thứ tự ưu tiên (video đúng đối tượng → ảnh thật đúng đối tượng → bối cảnh mở rộng có lý do), điều cấm (nơi/thời kỳ dễ nhầm), và vế có thể dùng chung cảnh với vế kề.
Việc 2 — bảng music/ambience theo chương: cảm xúc, chất liệu âm nhạc/nhạc cụ/tiết tấu có liên hệ thật với vùng/cộng đồng (nêu lý do từ nguồn), từ khóa tìm trên Epidemic Sound, ambience cần có/tránh.
outputs = {"visual_brief_csv": "clause_id,subject,place_level,keywords,avoid,share_with,reason", "music_md": "<Markdown>"}.
```

## C3 — Duyệt nguồn theo vế (bước 02→03)

Codex tạo sheet bằng `{PB}\scripts\make_review_sheets.py clips` (3 khung đầu/giữa/cuối usable range ghép ngang, tên file = clause_id hoặc beat_id). Kèm `{PK}\index.csv`: id, clause_id, verbatim, previous_context, next_context, place, time_era, source_id, provider, query, sheet_path.

`{RULE_FILES}`: `{PB}\reference\CLAUSE_MATCHING.md`, `{PB}\stages\03_MEDIA_PREP.md` (Việc làm 1).

```text
Đầu vào: {PK}\index.csv và các ảnh sheet liệt kê trong đó (đọc từng ảnh).
Việc: với mỗi dòng, đánh giá hình có đúng NGHĨA vế (đối tượng, hành động, nơi, thời kỳ) và không dẫn ý vế kế tiếp sớm. Phát hiện watermark, chữ/ticker cháy trong hình, viền đen, sai thời kỳ (xe, trang phục, công trình), nơi khác bị dùng như bằng chứng. Chỉ kết luận về những gì nhìn thấy trên khung; không kết luận về chuyển động, âm thanh hay bản quyền.
status: pass | fail | uncertain; fix gợi ý loại hình/keyword thay thế (không bịa nguồn cụ thể).
```

## C4 — Kiểm ảnh AI (bước 03, quy tắc ver 32)

Codex tạo ảnh so sánh bằng `make_review_sheets.py pairs` (trái: original, phải: output AI). Kèm `{PK}\index.csv`: id, clause_id, verbatim, original_path, output_path, prompt.

`{RULE_FILES}`: `{PB}\stages\03_MEDIA_PREP.md` (Việc làm 3 — quy tắc xử lý ảnh ver 32).

```text
Đầu vào: {PK}\index.csv và các ảnh so sánh.
Theo ver 32, ảnh AI chỉ cần TƯƠNG ĐỐI HỢP LÝ. Không cần khớp ảnh gốc, không bắt lỗi nhỏ.
Chỉ đánh "fail" khi có LỖI LỚN thấy ngay khi xem cả khung ở tốc độ phim:
(1) không phải khung 16:9; (2) có viền đen/dải màu/blur bands; (3) kéo méo rõ; (4) sai hẳn chủ đề/không khí của vế (đọc cột verbatim); (5) chủ thể chính biến dạng rõ (ví dụ mặt người chính méo, cơ thể dị dạng nổi bật).
KHÔNG đánh fail vì: chữ giả/chữ vô nghĩa trên sách, biển, áo, biểu tượng; hình in trên quần áo; ngón tay; hoa văn; đồ vật phụ; chi tiết nền; khác ảnh gốc. Những điều này nếu muốn chỉ ghi vào issue kèm "minor - không sửa" và giữ status "pass".
Mỗi fail ghi tiêu chí số mấy.
```

## C5 — Kế hoạch intro, cue map và mốc title chương (bước 05)

Codex chuẩn bị: `{PK}\onsets.csv` (chapter_id, first_clause_id, first_vo_verbatim, vo_onset_s, timeline_frame — do script tính), `{PK}\pauses.csv`, `{PK}\scene-ledger-approved.csv`, `{PK}\audio-cues-draft.csv`, fps và intro dự kiến.

`{RULE_FILES}`: `{PB}\START_HERE.md` (Quy tắc xuyên suốt: intro, title chương, music), `{PB}\stages\05_ASSEMBLY.md`, `{PB}\stages\06_AUDIO.md`, `{PB}\stages\07_TEXT.md`.

```text
Việc 1 — intro 10–20s không VO: đề xuất 6–12 shot từ scene-ledger-approved.csv (chỉ dùng source_id có trong file), thứ tự, thời lượng gợi ý, lý do highlight; ghi shot nào là teaser tái dùng thân phim.
Việc 2 — soát: title mỗi chương đặt ĐÚNG timeline_frame của câu VO đầu chương, trên footage của chính chương; pause chuyển chương 3–5s không VO; cue nhạc riêng theo chương và nghe được qua pause; SFX hành động tập trung intro, không whoosh cho text. Chỉ ra dòng sai kèm file#dòng. Không tự tính lại frame — nếu nghi số sai, ghi uncertain và nêu phép kiểm Codex cần chạy.
outputs = {"intro_plan_csv": "order,source_id,in_s,out_s,reason,teaser_reuse"}.
```

## C6 — QC cuối trước bàn giao (bước 08)

Codex chuẩn bị (rút gọn, không gửi log thô): `{PK}\readback-summary.json` (project/timeline ID, fps, 3840×2160 timeline+output, danh sách item theo track: start/end frame, source path, kind), `{PK}\cue-map.csv`, `{PK}\clauses-final.csv`, `{PK}\scene-ledger-final.csv`, `{PK}\frames\` (khung native tại: onset mỗi title chương −1f/0/+12f, đầu/cuối intro, mỗi chuyển chương, ảnh có motion 0/50/100%), `{PK}\codex-selfcheck.md` (checklist 08 Codex đã tự đánh và phạm vi đã xem/nghe).

`{RULE_FILES}`: `{PB}\stages\08_DELIVERY.md` (Việc làm, Checklist), `{PB}\reference\OUTPUT_RULES.md`.

```text
Việc: kiểm từng mục checklist 08 dựa trên các file trên. Đối chiếu chéo: cue map ↔ readback (title có đúng frame onset, đúng track, không trước pause); scene-ledger ↔ readback (source/binding đúng vế, không gap, không lặp canonical source phần thân ngoài ngoại lệ teaser đã ghi); intro 10–20s không VO; độ phân giải 3840×2160. Đánh giá khung hình: title đè mặt/chữ, viền đen, crop mất chủ thể; text có dùng 1 trong 3 kiểu Chapter/Location/Annotation ({PB}\visuals\text-example-v32\*.png) và nhìn tương đối giống mẫu không (không bắt lỗi lệch nhỏ về cỡ chữ/vị trí).
Nêu riêng: mục Codex tự đánh pass nhưng evidence không đủ. Không kết luận về âm thanh/độ mượt chuyển động.
```

## C7 — Title, description, chapter timestamps (bước 08, khi được giao)

Codex chuẩn bị: `{PK}\chapters.csv` (chapter_id, title, start_hhmmss từ timeline cuối, tính cả intro/pause), SRT cuối, script đã khóa, file nguồn facts.

`{RULE_FILES}`: `{PB}\stages\08_DELIVERY.md` (Việc làm 5), `{PB}\reference\OUTPUT_RULES.md`.

```text
Việc: soạn 3 phương án title (tiếng Anh, ≤ 70 ký tự), 1 description (hook 2 câu, tóm tắt, danh sách chapter dùng ĐÚNG start_hhmmss trong chapters.csv, dòng đầu 00:00), credits nguồn nếu có trong file. Mọi fact phải có trong script/nguồn; liệt kê fact đã dùng kèm file#dòng trong items.
outputs = {"titles": ["", "", ""], "description_md": "<Markdown>"}.
```

Codex sau đó: `check_claude_handoff.py chapters --description <file> --chapters {PK}\chapters.csv` phải PASS.

## Codex phản biện (tối đa một lần cho mỗi gate)

```text
Call: {CALL_ID_MOI} — phản biện cho {CALL_ID_CU}. Mục {ITEM_ID}: bạn kết luận "{STATUS}" vì "{ISSUE}". Codex có evidence ngược lại: {EVIDENCE_PATHS} ({MO_TA_NGAN}). Xem lại đúng evidence này và trả lời giữ hay đổi kết luận, theo cùng hợp đồng JSON (items chỉ gồm mục này).
```
