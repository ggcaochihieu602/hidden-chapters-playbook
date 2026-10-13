> LỊCH SỬ — không phải quy tắc hiện hành. Ver 2/START_HERE và chỉ đạo mới ưu tiên. Chỉ đọc phần được bước hiện tại trỏ tới.

# 02 — Quy trình thực hiện

## 1. Khởi động và đọc brief

1. Xác định yêu cầu: lập kế hoạch, dựng mới, sửa một phần, mở project hay xuất video. Không tự xuất full khi chỉ yêu cầu project.
2. Lưu brief/script/keyword/VO bản gốc cùng hash và phiên bản. Nếu URL không truy cập được, báo đúng phần chưa đọc; dùng bản local đã xác minh và ghi thời điểm.
3. Đọc cả chữ, bố cục bảng/cột và hình minh họa. PDF nhiều cột không được nối text theo thứ tự sai. Tool đọc tùy định dạng: Docs/browser/connector, DOCX parser + render khi cần, PDF extraction + trang ảnh. Không có một skill thần kỳ đã tự hiểu mọi brief.
4. Lập bảng yêu cầu: nội dung, nơi/thời kỳ, tỷ lệ, âm thanh, overlay, subtitle/logo, định dạng giao, nguồn, ngân sách, điều kiện dừng. Ghi riêng override trong chat.
5. Project cũ: chờ/lưu snapshot đã được người dùng lưu, hash + backup, dùng bản đó làm base. Nếu chưa lưu, giữ cửa sổ và bảo toàn thay đổi; không đóng ép.

## 2. Căn VO và lập scene ledger

- Probe duration/sample rate, giữ VO master. ASR có timestamp; đối chiếu script, dịch ý nếu khác ngôn ngữ. Pause/timecode trong script chỉ là dự kiến đến khi kiểm với VO.
- Chia thành câu/cụm ý: `scene_id,chapter_id,start,end,vo_span,entity,place,action,mechanism,era,mood,role,forbidden_substitutions`.
- Vai trò hình: evidence/chứng minh, explanation/giải thích, context/bối cảnh, transition/chuyển ý. Mỗi role có mức kiểm tương xứng.
- Dành nguồn đặc trưng cho câu khó trước, chọn shot range thể hiện đúng động tác rồi mới chia cảnh. Chốt cut point theo ý/cử động và nhịp nghe; không chia đều cả chương.

## 3. Hai hướng từ khóa kết hợp

| Tầng A — theo thực thể | Khi dùng | Cách xác minh |
|---|---|---|
| A1 tên chính xác + cơ chế/công trình | Câu nói trực tiếp về đối tượng | Preview đúng đối tượng/cơ chế, metadata nguồn, tránh landmark/công nghệ khác |
| A2 tên chính xác + hành động/góc nhìn | Người lên tàu, cabin, bảo trì tại đúng nơi | Hình/nguồn hỗ trợ đúng nơi, động tác và range dùng được |
| A3 cùng vùng + cảnh quan/hạ tầng | Câu tả vùng/hành trình | Không lấy landmark khác làm bằng chứng đối tượng chính |
| A4 tư liệu lịch sử/bản vẽ đúng thực thể | Lịch sử/nguyên lý | Kiểm năm, người, nhãn/cơ chế và provenance |

| Tầng B — theo ý/hành động | Khi dùng | Giới hạn |
|---|---|---|
| B1 hành động + đúng địa điểm | Lấp góc thiếu của A | Cùng tiêu chí exact-place |
| B2 hành động + vùng tương thích | Câu dẫn, trải nghiệm, bối cảnh | Ghi context, không khẳng định là địa điểm cụ thể |
| B3 hành động cận cảnh không định vị | Bàn tay, hành khách, kỹ sư kiểm tra | Không logo/kiến trúc/công nghệ trái câu |
| B4 ẩn dụ/khái niệm thị giác | Câu tổng kết/chuyển ý | Không dùng để chứng minh số liệu hay sự kiện |

Ví dụ Pilatus: A1 `Pilatus cogwheel railway Switzerland`, `Locher rack railway mechanism`; A2 `Pilatus railway passengers boarding`, `Pilatus driver cabin`; A3 `Lake Lucerne aerial`; B3 `rail engineer inspecting track close up`. Không nhầm tàu adhesion/cáp treo với Locher chỉ vì có chữ mountain railway.

Ảnh: cùng logic A+B, thêm `historical photograph`, `detail`, `engineering drawing`, `diagram`, `panorama` theo nhu cầu. Chỉ overlap1–2 từ keyword không đủ xếp hạng relevance.

Mỗi vòng: query → candidate metadata → preview → review theo scene → dedup → shortlist → download → probe/review file → import. Lưu query đã dùng và kết quả, tránh tìm lại không có lý do. Mặc định tìm vài biến thể có ích rồi chuyển sang ảnh thật/nguồn khác; chỉ đào sâu khi câu chính chưa có hình phù hợp.

## 4. Sourcing, tải và chi phí

- Ưu tiên nguồn cho phép của project và nguồn MP2 hiện có. Envato/Storyblocks chưa có API hoạt động thì import file hoặc browser được hỗ trợ. Gethinh/PikLab là kênh tải, không thay thế tên chủ nguồn Envato.
- Không tự giả định phiên login/browser download còn hoạt động. Thử một asset cần thiết, kiểm file hoàn tất ở thư mục cấu hình. Trang báo thành công/lịch sử tải/link sinh được chưa đủ.
- Lưu provider ID/canonical URL, downloader, file hash, source resolution/duration, rights evidence, số lần thử, cost estimate/actual, failed charge nếu có. Không ghi token/cookie/signed URL hết hạn vào gói chia sẻ.
- Nếu thất bại: đối chiếu file thật + lịch sử, dùng tải lại đã mua khi được phép, không liên tục mua lại; dừng hàng đợi khi provider treo. Không vòng qua chặn an toàn/DRM/login.
- Đồng nhất source theo provider ID/hash và xem lại duplicate thị giác. Xác nhận khác range trong cùng video vẫn là cùng nguồn.

## 5. AI và hình minh họa

- Tìm nguồn thật/bản vẽ đáng tin trước. Ghi scene thiếu và điều cần giải thích; tạo ít ảnh cần thiết.
- Prompt gồm VO span, subject, cơ chế, điểm không được sai, style/mood,16:9, vùng chừa label, camera/layout; tạo chữ/số/mũi tên qua overlay khi phù hợp thay vì tin chữ AI.
- Kiểm kỹ thuật, không giả ảnh tư liệu. Lưu model/provider/run ID/prompt hash/cost, trạng thái generated/imported/used/rejected. AI video chỉ tính khi có file sinh thực tế; pan ảnh AI không phải video AI sinh.

## 6. Dựng qua MP2

- Binding scene→asset→source in/out→reason; lưu vào revision được compiler hiểu. Dùng API/service thật và xác nhận job/artifact, không coi script riêng/SQL insert là tính năng tự động đã có.
- Lắp theo VO đã căn; sổ dùng nguồn toàn phim; kiểm tỷ lệ theo duration và nhịp xen ảnh/video. Intro toàn video, có thể preview nguồn sau.
- Motion cover-safe; overlay theo cue; nhạc theo chương, gain/ducking/fade đã nghe. Packing audio theo overlap và processing.
- Handoff `.kdenlive`, profile, assets, cue/source/cost/QC manifests. Nếu dùng absolute media dependencies thì ghi rõ không portable, giữ thư mục gốc.

## 7. Kiểm tra và bàn giao

Theo file03: technical preflight → vài đoạn rủi ro → import native Kdenlive → xác nhận từng loại overlay tại mốc → bảo toàn chỉnh tay → mở đúng bản. Full render chỉ khi được giao. Báo rõ mức đã kiểm, thiếu gì, số nguồn dùng và chi phí biết được. Cập nhật sổ lỗi và lesson sau phản hồi người dùng.
