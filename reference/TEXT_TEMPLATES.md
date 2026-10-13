# Resolve title templates — nguồn và test (LỊCH SỬ)

**Từ 07/10/2026 dùng [TEXT_STYLE_V32](TEXT_STYLE_V32.md).** Các candidate dưới đây chỉ là hồ sơ cũ, không áp cho phim mới.

Đã tìm ngày 01/10/2026: [Mixkit Simple Dot Callout](https://mixkit.co/free-davinci-resolve-templates/simple-dot-callout-688/) (.comp), [license](https://mixkit.co/license/). [Blackmagic Fusion](https://www.blackmagicdesign.com/products/davinciresolve/fusion) hỗ trợ Text+, animation và reusable templates. Không phải template miễn phí nào cũng hợp documentary; tránh 3D/glitch/bounce quá mạnh.

ZIP gốc + .comp: `E:\Youtube AI\MoneyPrinter2\research\text-templates-2026-10-01\mixkit-688.zip` và folder `mixkit-688`. Đã giữ file publisher; chưa đóng ZIP đó vào gói playbook để phát tán lại.

Đã chuẩn bị/copy hai candidate .setting vào thư viện user:
`C:\Users\OS\AppData\Roaming\Blackmagic Design\DaVinci Resolve\Support\Fusion\Templates\Edit\Titles\Hidden Chapters`.
- `HC_Mixkit_Callout_Candidate.setting`: bản chuyển từ comp publisher thành macro editable heading/subheading/position; đổi font Muli thiếu sang Arial.
- `HC_Center_Slide_Candidate.setting`: tự tạo center slide/fade, no audio, Text+ dễ sửa, hold retiming; [source riêng](../templates/HC_Center_Slide_Candidate.setting).

**Status:** file installed; effect-library registration/native output **chưa xác minh**. Thử kết nối bị `WinError 10061` bridge connection refused. Không sửa title trên phim, không tự restart Resolve. [Record/hash](../evidence/text-template-install-2026-10-01.json).

## Thử khi bridge hoạt động
1. Save current UI/timeline, tạo timeline thử 5s trên nền footage đã kiểm; không đưa candidate thẳng vào phim.
2. Nếu Effects chưa refresh, import comp hoặc .setting bằng supported Fusion API; giữ installed/registered/load/render statuses riêng. Không tự chạy script lạ.
3. Đổi title ngắn/dài, center/safe area; kiểm font, alpha, padding, entrance/hold/exit ở native frames/đoạn nhỏ. Candidate dùng frame0–149 reference; kiểm retime/fps và số frame thật trước áp nhiều cues.
4. API graph/load thành công chưa chứng minh visible output; nếu render không hiện, dùng Text+ native hoặc alpha fallback đã kiểm. Giữ text editable source.
5. Restore current timeline/page/timecode, save test/evidence. Đạt thì lưu screenshots vào thư viện mẫu, ghi version/build/status; user bổ sung mẫu sau.
