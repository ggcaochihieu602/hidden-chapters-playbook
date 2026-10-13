# Phối hợp Codex ↔ Claude — đọc ở bước 00 và tại mỗi gate C1–C7

Từ ver 31, **Codex là agent điều phối và thực thi** (tải, xử lý media, Resolve MCP, ghi hồ sơ). **Claude là người lập kế hoạch ngữ nghĩa và kiểm duyệt độc lập**, được Codex gọi qua MCP `claude` của Frenemy (`ask_claude`). Hai bên kiểm chéo nhau: Claude soát nghĩa/quy tắc trên sản phẩm của Codex; Codex soát cơ học (wording, số liệu, đường dẫn, timestamps) trên sản phẩm của Claude. Không bên nào được tự nhận "đạt" thay cho bên kia.

## 1. Kết nối đã cài trên máy này

- MCP `claude` trong `C:\Users\OS\.codex\config.toml` chạy `E:\Tool\frenemy\local\bridge-bootstrap.mjs` → `claude -p` (Claude Code native, gói Claude Pro, không dùng API key).
- `ask_claude`: **chỉ đọc**, tự chấp thuận. Claude đọc được file văn bản, CSV/JSON, PDF và **ảnh PNG/JPG** bằng đường dẫn; **không** có shell, không sửa file, không truy cập web, không đọc được video/audio.
- `ask_claude_write`: Claude được sửa file, mỗi lần cần người dùng duyệt. **Không dùng trong sản xuất**; Claude trả nội dung, Codex ghi file.
- Mỗi lần gọi là **một phiên mới, không nhớ gì**. Giới hạn: 10 phút/lần, ~2 MB trả lời, tối đa 4 lần gọi song song (dùng 1–2).
- Mọi tài khoản Codex dùng **chung một hạn mức Claude Pro**.

## 2. Phân vai

| Gate | Bước | Claude làm | Codex làm trước | Codex kiểm sau (bắt lỗi Claude) |
|---|---|---|---|---|
| C0 | 00 | Trả lời câu kiểm tra kết nối Claude/đọc file (không liên quan Resolve) | Gọi kiểm tra | Đối chiếu canary |
| C1 | 01 | **Tạo** bảng vế: chia vế, câu trước/sau, ý chính, thực thể, nơi, thời kỳ, vai trò hình | VO master, word timestamps, file narration nguyên văn | `check_claude_handoff.py clauses` (wording 100%, thứ tự); Codex điền `vo_start/end` từ alignment |
| C2 | 02 | **Tạo** yêu cầu hình + keyword theo từng vế; bảng music/ambience theo chương (lý do văn hóa/vùng) | C1 đã chốt, hồ sơ nguồn/facts của phim | Mỗi clause_id có đúng một dòng; keyword không chứa facts ngoài nguồn |
| C3 | 02→03 | **Duyệt** nguồn đã tải theo vế (frame đầu/giữa/cuối) | Tải nguồn, cắt usable range, tạo review sheet | Mỗi `fail` có evidence trỏ đúng sheet; mở lại sheet để xác nhận trước khi thay nguồn |
| C4 | 03 | **Kiểm ảnh AI, chỉ bắt lỗi lớn**: sai 16:9, viền, méo, sai chủ đề, chủ thể chính biến dạng rõ (ver 32: không kiểm khớp chi tiết, không bắt lỗi nhỏ như chữ giả, ký hiệu) | Tạo/mở rộng/nâng chất lượng ảnh bằng AI, tạo ảnh so sánh | Codex xem lại ảnh bị fail rồi tạo lại một lần |
| C5 | 05 | **Lập kế hoạch** intro 10–20s; **soát** cue map và mốc title chương theo onset | Bảng onset/pause/offset bằng script, scene-ledger đã duyệt | Codex tự tính lại frame bằng script; số của Claude chỉ là đề xuất |
| C6 | 08 | **QC cuối** theo checklist 08: readback, cue map, frame tại mốc rủi ro | Native readback, frame tại onset title/chuyển chương/intro, ledgers | Mỗi vi phạm Claude nêu được Codex xác minh trên native trước khi sửa |
| C7 | 08 | **Soạn** title, description, chapter timestamps | SRT/timeline cuối, bảng chương, nguồn facts | `check_claude_handoff.py chapters` + đối chiếu facts với script/nguồn |

Codex vẫn tự làm toàn bộ: alignment, tải nguồn, ffprobe/hash/ledger, AI image, Resolve MCP, audio Epidemic, ghi `progress.json`. Claude **không** gọi ngược Codex.

## 3. Thư mục trao đổi trong workspace phim

```
<film-workspace>\collab\
  claude-calls.csv          # sổ mọi lần gọi (mẫu: templates/claude-calls.csv)
  prompts\<call_id>.md      # prompt đã gửi, nguyên văn
  answers\<call_id>.md      # trả lời Claude, nguyên văn, không sửa
  packets\<call_id>\        # file chuẩn bị cho Claude: sheet ảnh, CSV trích, readback rút gọn
  accepted\                 # bản Codex đã kiểm và chấp nhận (sau đó mới chép vào records chính)
  disputes.md               # bất đồng còn lại sau 1 vòng phản biện
```

`call_id` = `<gate>-<yyyymmdd-hhmm>-<n>`, ví dụ `C3-20261006-1015-2`. Không ghi credential/token/cookie vào prompt hoặc packet.

## 4. Cách gọi (Codex)

1. Chuẩn bị packet nhỏ: chỉ file cần cho gate, trích đúng chương/lô. **Không** gửi footage, log dài, lịch sử chat hay toàn bộ playbook.
2. Viết prompt theo [mẫu gate](../templates/CLAUDE_GATE_PROMPTS.md): vai trò, **đường dẫn tuyệt đối**, quy tắc playbook liên quan (trích file + mục), việc cần làm, **canary**, định dạng trả lời. Lưu `prompts\<call_id>.md` rồi gửi đúng nội dung đó qua `ask_claude`.
3. Lưu trả lời nguyên văn vào `answers\<call_id>.md`, ghi dòng vào `claude-calls.csv`.
4. Chạy `scripts/check_claude_handoff.py verdict` (và `clauses`/`chapters` khi gate có) → ghi kết quả vào cột `codex_check`.
5. Chỉ dùng kết quả đã qua bước 4. Chép bản chấp nhận vào `collab\accepted\` rồi mới cập nhật records chính (`clauses.csv`, `scene-ledger.csv`, cue map…).

**Lô:** C1 ≤ 2 chương/lần; C3 ≤ 20 review sheet/lần; C4 ≤ 12 cặp ảnh/lần; C6 chia theo chương nếu packet lớn. Thời gian quá 10 phút → chia nhỏ lô.

## 5. Hợp đồng trả lời của Claude

Claude trả **một** khối ```json duy nhất ở cuối câu trả lời:

```json
{
  "gate": "C3",
  "call_id": "C3-20261006-1015-2",
  "canary": "<nguyên văn đoạn Codex yêu cầu trích>",
  "inputs_read": ["E:\\...\\packets\\C3-...\\CL-0012.jpg"],
  "verdict": "pass | fail | partial",
  "items": [
    {"id": "CL-0012", "status": "pass | fail | uncertain", "evidence": "đường dẫn file hoặc file#dòng", "issue": "", "fix": ""}
  ],
  "outputs": {},
  "not_checked": [],
  "assumptions": []
}
```

- `outputs`: với gate tạo nội dung (C1, C2, C5, C7), chứa nội dung file (CSV/Markdown dạng chuỗi). Codex ghi nguyên văn, không sửa ngầm.
- `uncertain` là kết quả hợp lệ. Claude **không** được đoán cho đủ: thiếu dữ kiện → `uncertain` + ghi vào `not_checked`.
- Mọi fact mới (tên, số, ngày, địa danh) phải trỏ tới file nguồn trong workspace. Fact không có nguồn → Codex đánh `unsourced` và loại.

## 6. Chống hallucination — luật cho cả hai bên

1. **Canary chứng minh đã đọc.** Mỗi prompt yêu cầu Claude trích nguyên văn một chi tiết cụ thể (ví dụ cột `verbatim` của dòng thứ N, hoặc chữ trên ảnh sheet thứ M). Sai canary → bỏ toàn bộ trả lời, gọi lại một lần; sai lần hai → gate `blocked_claude_read`.
2. **Không có bằng chứng thì không có kết luận.** Mục `fail`/`pass` thiếu `evidence` hợp lệ → coi như `uncertain`.
3. **Codex xác minh trước khi sửa.** Trước khi thay nguồn/sửa timeline theo Claude, Codex mở lại đúng evidence. Claude nhận xét sai → ghi `rejected_with_evidence` trong sổ, không sửa.
4. **Claude không chấm phần chưa được xem.** Ảnh chỉ chứng minh khung hình đã trích; Claude không kết luận chuyển động mượt, âm thanh hay quyền sử dụng. Các mục đó vẫn theo kiểm native/nghe của Codex và báo đúng phạm vi.
5. **Codex không tự đổi trạng thái gate thành `claude_pass`** khi Claude chưa trả lời, lỗi kết nối hoặc hết hạn mức. Tự kiểm của Codex ghi là `codex_only`.
6. **Một vòng phản biện.** Codex không đồng ý → gửi lại **một** lần kèm evidence. Còn bất đồng → ghi `disputes.md`, chọn phương án an toàn hơn theo playbook (giữ wording gốc, thay nguồn không chắc, không thêm fact) và báo người dùng lúc bàn giao. Không lặp Claude ↔ Codex.
7. **Wording và con số do script quyết.** Claude không sửa câu chữ script đã khóa; mọi phép tính frame/timecode do script của Codex tính.

## 7. Hạn mức và lỗi

- Ngân sách mềm: **≤ 20 lần gọi Claude/phim** (C0 1, C1 ≤4, C2 ≤2, C3 ≤6, C4 ≤3, C5 1, C6 ≤2, C7 1). Ghi số đã dùng trong `progress.json → claude_collab.calls_used`.
- `ask_claude` lỗi do timeout → chia lô, thử lại một lần. Do hạn mức/đăng nhập/không có tool `claude` → gate `pending_claude`, ghi lỗi nguyên văn, **tiếp tục phần độc lập**; gọi lại ở ranh giới bước kế tiếp.
- C1, C3 và C6 là **bắt buộc**: chưa qua thì không dựng hàng loạt (C1, C3) hoặc bàn giao phải ghi rõ "chưa qua Claude QC" (C6). C2, C4, C5, C7 nên chạy; bỏ qua phải ghi lý do.

## 8. C0 — kiểm tra đầu phiên

Mỗi chat sản xuất mới hoặc sau khi khởi động lại Codex: gọi `ask_claude` với prompt C0 trong [mẫu](../templates/CLAUDE_GATE_PROMPTS.md#c0). Đạt khi Claude trả đúng canary đọc từ `project.json` của phim (đường dẫn tuyệt đối trên ổ E).

Nếu Claude báo không đọc được file ngoài thư mục làm việc: ghi blocker `claude_cannot_read_workspace` và báo người dùng. Cách sửa (người dùng quyết định, Codex không tự sửa cấu hình): đặt thư mục làm việc của MCP `claude` là `E:\Youtube AI` (thêm `cwd` vào mục `[mcp_servers.claude]` nếu bản Codex hỗ trợ) hoặc thêm `E:\Youtube AI` vào `permissions.additionalDirectories` trong `C:\Users\OS\.claude\settings.json`; khởi động lại Codex rồi chạy lại C0.
