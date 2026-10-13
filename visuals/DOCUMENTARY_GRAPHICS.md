# Đồ họa giải thích documentary — dùng trong bước 03/07

## Quyết định có cần graphic trước khi chọn style

Ưu tiên video đúng nội dung; ảnh chỉ khi không có video phù hợp. **Chỉ graphic cho cơ chế hoặc số liệu cần giải thích**, không minh họa mọi câu bằng thẻ khái niệm. Tên/ngày/nguồn thường là overlay gọn trên cảnh. Chủ đề, tiêu đề và locked script từng phim quyết định nội dung; không cố định nơi, cảnh hoặc cơ chế mẫu. Artwork đã tạo là candidate, không bắt buộc dùng.

## Mở file mẫu thật

Bốn PNG gốc nằm trong [folder mẫu](documentary-graphics/README.md) và ZIP, hash tại SAMPLE_MANIFEST.json. Mở ảnh trước làm đồ họa: [mẫu 1](documentary-graphics/user-example-1.png) là card hai vòng tròn quá sơ sài cần tránh; [mẫu 2](documentary-graphics/user-example-2.png), [mẫu 3](documentary-graphics/user-example-3.png), [mẫu 4](documentary-graphics/user-example-4.png) là hướng documentary giàu thông tin: vật thể có texture, quan hệ/quy mô rõ, cutaway/inset, so sánh, vị trí địa lý khi có chứng cứ và label ngắn dễ đọc. Đây là style references, không facts hoặc stock được cấp quyền của phim; không nhập số liệu/ngày/địa lý của mẫu vào script khác.

## Giữ ảnh phù hợp, chỉ AI khi cần

Giữ ảnh hợp script/style. Nếu chỉ thiếu framing, expand/outpaint thay vì regenerate toàn cảnh. Ảnh cần thiết thấp chất lượng/sai tỷ lệ: tìm original tốt hơn nếu có, AI enhance/expand 16:9 khi cần; giữ chủ thể, original/prompt/provider/model/run/hash và lineage. So actual output với mặt/tay/chữ/công trình/địa hình/ranh giới. AI đổi facts thì phục hồi vùng gốc hoặc loại/đổi nguồn; không pass từ prompt/pixel count. 4K carrier không tự là chi tiết native 4K.

## Khi cần tạo illustration mới

Gửi công cụ ChatGPT/OpenAI image generation exact VO + ngữ cảnh trước/sau + factual source scope và mục đích giải thích. Tạo vật thể/quan hệ rõ hơn, không invent numbers/yield/dates/measurements/geometry/local geography. Giữ loại generated conceptual illustration và actual output review. Ưu tiên **textless plate + native editable labels/leader animation** ở Resolve; labelled preview và native proof là hai trạng thái riêng. Label xuất hiện theo đúng vế số liệu/cơ chế.

Tách style infographic, ordinary chapter/location title và thumbnail. Still-derived render vẫn là ảnh, ≤8s; đơn giản hóa nếu quá nhiều thông tin, không chia cùng ảnh liền nhau để lách hold. Cover trước motion và kiểm native đầu/giữa/cuối/cực trị sau đổi resolution/crop. [Media prep](../stages/03_MEDIA_PREP.md) · [Text/graphics](../stages/07_TEXT.md).
