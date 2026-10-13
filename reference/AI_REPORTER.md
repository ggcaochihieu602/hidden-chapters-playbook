# AI ảnh, phục chế, reporter — đọc khi có nhu cầu cụ thể

Ảnh tư liệu thật/bản gốc tốt hơn ưu tiên trước. Xử lý ảnh sai tỷ lệ/kém chất lượng theo quy tắc ver 32 trong [03](../stages/03_MEDIA_PREP.md): AI được tạo lại ảnh mới đúng 16:9, không cần giữ đúng chi tiết, không cần 4K; ảnh đúng tỷ lệ và đủ nét dùng trực tiếp. Prompt ảnh AI tạo mới hoàn toàn (không áp cho mở rộng/nâng chất lượng) bắt đầu bằng 3 dòng trong [AI_IMAGE_PROMPT_PREFIX](../templates/AI_IMAGE_PROMPT_PREFIX.txt). Ảnh AI ghi `ai_regenerated` trong ledger nội bộ. Không đặt nhãn/chữ/watermark "AI" lên hình hay video, trừ khi người dùng yêu cầu rõ. Chỉ dùng AI illustration cho cơ chế/số liệu cần giải thích sau khi ghi search gap.

Cơ chế cần nguồn kỹ thuật, prompt nêu tương tác cần thấy, sau sinh kiểm geometry/contact/direction theo thời gian. Video đẹp không chứng minh cơ chế đúng. Tạo chữ/số chính xác bằng overlay khi cần. Giữ model/provider/run ID/prompt hash/cost và trạng thái generated/imported/used/rejected.

Reporter là lựa chọn của project, mặc định không tự tạo nếu user chọn stock chính. Chỉ 1–2 lần nếu được yêu cầu, **ngoài intro 10–20s không VO mặc định**, trừ khi user đổi intro rõ ràng; giữ identity/background references đã khóa. Lời reporter thay đúng narrator span; script khóa thì giữ lời. Tư thế/cử chỉ gắn nghĩa câu: nhìn camera → chỉ vật thật → trở lại; một hành động chính, mic/face/outfit liên tục. Không thêm host mỗi chương hoặc đọc chồng VO.

Prompt tối thiểu: context + references + starting pose + action tied to exact phrase + gaze + prop continuity + exact dialogue + camera + ambience thấp + duration đủ lời + avoid face/hand/geometry drift + no baked captions. Kiểm lip-sync/voice/identity/action riêng, ASR chỉ kiểm lời.

Upload reference phải xác nhận trước generation; không âm thầm chuyển text-only khi reference fail. Dùng công cụ generation hiện có và ghi chi phí; không coi adapter/API tồn tại là clip đã tạo. Vẫn chuẩn bị stock thay thế cho toàn span reporter trong bước 02.
