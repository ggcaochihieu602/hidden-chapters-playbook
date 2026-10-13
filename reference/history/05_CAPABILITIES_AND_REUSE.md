> LỊCH SỬ — không phải quy tắc hiện hành. Ver 2/START_HERE và chỉ đạo mới ưu tiên. Chỉ đọc phần được bước hiện tại trỏ tới.

# 05 — MP2 thực hiện gì, ChatGPT thực hiện gì?

## Mức đã chứng minh đến 26/09/2026

| Thành phần | Trạng thái thực tế |
|---|---|
| Lưu brief/revision, binding, timeline compiler | Có service/API; V005 đã dùng với dữ liệu được agent chuẩn bị |
| Handoff Kdenlive/media/audio/profile | Có thực thi trong MP2; cần input/binding hợp lệ |
| Native overlay + audio packing | `services/kdenlive_overlays.py` và endpoint POST `/api/v1/projects/{id}/kdenlive/overlays`; V0056location/6facts/3people, audio16→5 |
| Location fit | Đã sửa đo font bằng Pillow11.1.0 + Arial Bold trên Windows; template cần font tương ứng khi chuyển máy |
| Hiểu brief, chọn sự kiện/nhân vật/nguồn, căn ý | ChatGPT/Codex + script/provider đã hỗ trợ; chưa chứng minh một job chung tự làm mọi brief |
| ASR/dịch/semantic binding | V005 dùng bước/script riêng và API ở một số khâu; không coi thành flow UI end-to-end |
| Sourcing Envato/GetHinh/PikLab | Browser/import tùy phiên; không có bằng chứng API Envato/Storyblocks hoàn chỉnh tự tải mọi nguồn |
| AI imagery và nhạc | V005 có công cụ/script bên ngoài MP2 rồi import; adapter/API tồn tại không chứng minh lần đó đã gọi qua UI |
| QC | Compiler/audit/sample/render/agent review; chưa tự động nghiệm thu nội dung30phút chỉ từ skill |
| Full render orchestration | Có engine/profile và script; trạng thái xuất từng bản phải xem file/log, không suy từ project assembled |

Không có số đo tin cậy cho “% công sức ChatGPT / MP2”. Phân biệt quyết định biên tập, code thực thi và tác vụ thủ công; lưu job/run/path để có thể đo về sau.

## Model và TwelveLabs

Default API editorial đã ghi trong cấu hình dự án gốc là OpenAI `gpt-5-mini`; mỗi lần chạy phải đọc cấu hình hiện tại (không in secret), lưu provider/model. Model Codex trong chat khác model MP2 gọi API; đổi model chat không tự đổi MP2.

Pilot V005: Pegasus1.5 qua temporal proxies toàn đoạn trước, rồi `gpt-5-mini` độc lập với sample~1fps;4clip, tổng59.794s,8provider calls. Cả hai phát hiện chính4/4, một action claim của TwelveLabs không phù hợp reference sample. V005 giữ OpenAI làm mặc định; không dùng TwelveLabs nếu chưa có lợi ích được chứng minh. Đây không phải benchmark toàn ngành hay bài test Marengo search. Tham khảo full report trong history.

## Bản đồ code trong repository MP2

- `backend/moneyprinter2/services/brief_workflow.py`: điều phối/nhập brief.
- `brief_stock.py`, `visual_review.py`, `footage_quality.py`, `footage_reuse.py`: nguồn, review và kiểm nguồn; kiểm code/config/job thật trước khi khẳng định áp dụng.
- `brief_timeline.py`, `brief_usage.py`: compile và thống kê.
- `kdenlive_handoff.py`, `kdenlive_brief_delivery.py`, `kdenlive_overlays.py`, `kdenlive_captions.py`: native project/delivery/graphics.
- `backend/moneyprinter2/routers/kdenlive_handoff.py`: overlay endpoint và handoff routes.
- `scripts/plan_v005_overlays.py`, `qc_v005_overlays.py`, các script `v005_r*`: ví dụ V005, **có tên/timestamp/ID hard-code**, không chạy nguyên xi cho project khác.
- `tests/test_kdenlive_overlays.py`: preservation, packing, fade alpha và reference ordering. Test pass không thay native import/review.

ZIP này không copy môi trường Python, kho model, credential, DB, nhạc/stock hay toàn bộ repository. Để chạy máy khác cần MP2 repository/runtime, FFmpeg/MLT/Kdenlive, font, assets và provider access hợp lệ. Tài liệu vẫn dùng độc lập để agent lập kế hoạch/triển khai tương tự.

## Cổng nghiệm thu tính tự động thật

Lấy một brief thứ hai chưa chuẩn bị sẵn → xử lý qua API/UI có log → không sửa DB hay viết binding hard-code theo từng câu → mở Kdenlive → kiểm đúng VO/nguồn/motion/audio/overlay/cost. Đến khi đạt mới gọi là workflow tự động tổng quát. Bộ này giúp tái lập quyết định và giảm làm lại; không thay thế cổng nghiệm thu đó.
