# 07 — Chapter, location, fact/date có animation

## Đầu vào
Timeline/cue map đã ổn, dữ kiện có nguồn. **Mở 3 ảnh mẫu Chapter/Location/Annotation** trong [thư viện text](../visuals/TEXT_DEFAULTS.md) và đọc [TEXT_STYLE_V32](../reference/TEXT_STYLE_V32.md) — đây là style bắt buộc cho mọi text từ 07/10/2026. Khi cần graphic cơ chế/số liệu, mở cả [bốn PNG gốc](../visuals/documentary-graphics/README.md) và [hướng documentary](../visuals/DOCUMENTARY_GRAPHICS.md); không chỉ đọc mô tả. PNG giữ trong folder này và ZIP, SHA256 tại SAMPLE_MANIFEST.json.
## Việc làm
1. Chỉ dựng graphic khi cần giải thích **cơ chế hoặc số liệu**; ngày/nguồn/tên là overlay gọn, không card cho mọi vế. Graphic nhiều thông tin rõ vật thể/quan hệ/cutaway/so sánh theo mẫu 2/3/4, tránh hai vòng tròn trống mẫu 1; không lấy facts/địa lý từ mẫu áp cho phim. Ưu tiên plate không chữ + label native editable, actual plate review trước import. Chapter và location là ưu tiên cho title cues. **Title từng chương xuất hiện trên footage của câu VO đầu tiên của chính chương đó**, bắt đầu tại onset VO thực đã đo và quy đổi theo fps timeline, gồm intro/pause offsets. Entrance animation bắt đầu ở mốc này, không pre-roll trong pause 3–5s trước chương, không đặt title trên footage chương trước hoặc thẻ title riêng. Ghi chapter ID, câu/vế VO đầu, footage binding và start frame vào cue map; khi timing đổi cập nhật title cùng map và kiểm native trước onset/tại onset/in/hold/out. Chapter làm đúng mẫu Chapter trong [TEXT_STYLE_V32](../reference/TEXT_STYLE_V32.md) (box xám đậm bán trong suốt góc dưới trái, tên chương IN HOA đậm + `CHAPTER 0N`).
2. **Location** (tên nơi thật, footage đúng nơi): mẫu Location — ghim cam + thanh cam + box trắng ngà góc trên phải, `Tên nơi, Quốc gia`. **Annotation** (địa danh/công trình chính, ngày/năm, fact/số liệu ngắn cần nhấn): mẫu Annotation — chữ trắng IN HOA giữa màn hình + dòng phụ, không box. Chỉ dùng 3 kiểu Chapter/Location/Annotation; không dùng center slide, lower-left v27 hay template Mixkit cũ. Kiểm không che mặt/chủ thể.
3. Mọi text có **animation vào/ra làm trong DaVinci Resolve** đúng công thức trong [TEXT_STYLE_V32](../reference/TEXT_STYLE_V32.md), không whoosh. Location/Annotation neo đầu vế liên quan; ghi source fact/date, wording và duration. Annotation dùng thưa theo nội dung, không quota; không lặp toàn câu VO.
4. Dựng 3 Fusion Title template `HC_Chapter_v32`, `HC_Location_v32`, `HC_Annotation_v32` (Text+ editable, ô nhập Title/Subtitle, hold co giãn, vào/ra cố định), thử một lần trên timeline test, xem nhanh một frame lúc giữ so với ảnh mẫu — tương đối giống là dùng được, không cần đo đạc. Đo glyph/font/padding/line breaks, nhất là tên dài, trên native timeline/output 3840×2160; sau đổi resolution kiểm fit/Fusion lại, filename không chứng minh 4K. Các dòng cùng alignment, box bao dòng dài nhất. Nếu native title có lỗi có thể alpha MOV đủ frame, giữ text JSON/PNG và báo rendered graphic không native editable.
5. Template tải: lưu publisher/license/ZIP, kiểm dependencies/fonts/build, cài folder riêng không ghi đè. Test trên timeline nhỏ với mốc vào/hold/ra bằng frame/đoạn ngắn native, rồi restore timeline người dùng. File install, registered và render-verified là ba trạng thái khác nhau.
6. Lưu screenshots các style đang dùng, sample/setting/prompt và project/source/timestamp/hash/status **tại workspace/profile của phim**. Template mới đạt chỉ cập nhật hồ sơ project; không tự thêm vào visuals/thư viện mẫu/playbook chung. Chỉ cập nhật thư viện chung khi người dùng yêu cầu rõ ràng trong chat quản lý playbook đã chốt ngày 04/10/2026. Logo theo profile; 4K icon không tự đưa vào mọi cảnh, dùng thumbnail theo brief.
## Quyết định
Không áp style thumbnail lên text phim. Không chồng location/chapter/fact/caption; tên địa danh cụ thể không gắn lên stock khác nơi như chứng cứ. Chưa bridge thì ghi pending native-test, không đổi title phim bằng ứng viên chưa xem.
## Đầu ra
Text cues, title assets dễ chỉnh, native samples và thư viện mẫu có provenance.
## Checklist
- [ ] Không có nhãn/chữ/watermark "AI illustration", "AI generated" hay tương tự trên bất kỳ ảnh nào, trừ khi người dùng yêu cầu rõ.
- [ ] Mọi text dùng 1 trong 3 kiểu Chapter/Location/Annotation, nhìn tương đối giống ảnh mẫu.
- [ ] Title chương bắt đầu đúng onset câu VO đầu tiên trên footage chương đó; không xuất hiện trong pause/chương trước; chapter/VO/footage/start frame đã đối chiếu native. Location đúng mốc vế.
- [ ] Mọi text có animation, không whoosh, glyph/caption/safe area rõ.
- [ ] Kiểm native ở vào/hold/ra, dài/ngắn; không chỉ comp metadata.
- [ ] Graphic chỉ cơ chế/số liệu cần thiết, bốn ảnh mẫu thật đã mở; plate/facts/native label đạt.
- [ ] Samples lưu tại workspace/profile phim; playbook/thư viện mẫu chung giữ chỉ đọc nếu chưa có yêu cầu rõ ràng tại chat quản lý playbook; không gọi candidate là approved.
## Ví dụ
Năm/ngày lớn dùng Annotation (dòng 1 là năm, dòng 2 là ngữ cảnh ngắn), vào bằng fade + scale nhẹ, giữ ≥3s, fade ra. Tên thành phố dùng Location. Tên nơi dài giảm vừa đủ/tách dòng, không cắt chữ để giữ preset cỡ font.
## Sửa lỗi
Fusion không render dù graph đúng → [native fixes](../reference/TECHNICAL_FIXES.md#text); native frame proof, không tuyên bố pass từ node graph. PNG default duration → alpha MOV đã probe và readback đúng span.
## Tiếp tục
Đạt → [08](08_DELIVERY.md). Thử mẫu mới độc lập không làm mất timeline phim hiện hành.

## Native center variant đã thử ở ver12 (lịch sử, đã thay bằng TEXT_STYLE_V32)
[Frame vào/hold/ra và graph editable](../visuals/TEXT_V28_NATIVE.md). Candidate KeyFrameStretcher không được build đã đo nhận; cài được không chứng minh chạy được. Clean graph flat có native proof. Chỉ đổi default style khi user chọn; giữ chapter baseline dịu.


## Native verification — 03/10/2026
Native point-list and expression writes, black backing placement and label-specific VO reveal: [LRN-04](../reference/LA_RINCONADA_NATIVE_FIXES.md#lrn-04-bridge-fusion-point-values-and-expressions). Inspect in/hold/out; keep dated source qualifications short and attached to the relevant shot rather than adding a redundant full-frame card.
