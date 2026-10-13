# Lịch sử ver 10 — chỉ tra lỗi kỹ thuật

Quy tắc hiện hành ở START_HERE và stages của ver 11; lịch sử không được ghi đè chỉ đạo mới.

# 07 — Chữ, đồ họa, logo

**Bắt buộc mở ảnh đối chiếu:** [location](../../../visuals/overlays/longyearbyen-location-100s.png), [fact/date](../../../visuals/overlays/longyearbyen-fact-638s.png). Tra [index hình](../../../visuals/INDEX.md) để biết nguồn và phạm vi đã kiểm. Ảnh thumbnail không phải mẫu text trong phim.

1. Text trong phim: trắng, sans-serif, không outline. Lower-left cho location/fact; chapter theo bố cục project đã chốt. Nền tối: chữ + shadow nhẹ; nền sáng: box đen thường 25–35%, tăng gần 50% nếu cần đọc rõ.
2. Đo font/weight/glyph thật; hai dòng cùng origin căn trái, box bao hết dòng dài nhất và padding đều. Bảo vệ mặt/chủ thể, vùng caption và logo. Không ước chiều rộng bằng số ký tự.
3. Text thưa, neo đúng lời nói: tên nơi, một fact/date quan trọng mỗi chương theo mặc định. Không nhắc cả câu VO. Ngày ghi tháng tiếng Anh; fact cần nguồn. Audit title/location/fact/caption cùng nhau để tránh chồng hoặc mật độ quá dày.
4. Mỗi card fade trong suốt in/out; xem đầu/giữa/cuối fade trong renderer thực. Native title nếu chỉnh được; khi PNG duration không ổn, pre-render ProRes4444 alpha đúng số frame rồi đọc lại duration. Giữ nguồn text/prompt để sửa, ghi rendered graphic không phải text native editable.
5. Logo dùng `logo overlay.png` ở thư mục kênh khi yêu cầu/profile có watermark; đối chiếu final sample, không tự đặt icon 4K lên mọi cảnh. 4K icon dành cho thumbnail khi phù hợp đầu ra.

**Checklist hoàn tất**
- [ ] Đã mở ảnh mẫu và frame thật của project, không chỉ đọc text mô tả.
- [ ] Nội dung/mốc VO đúng, không chồng card/caption/mặt.
- [ ] Box/glyph/padding/fade đạt ở renderer Resolve, cả tên ngắn và dài.
- [ ] Native readback đủ cue và timing; giữ V1/VO/music đã kiểm.

**Lỗi:** GUI/Gallery export thất bại → dùng short native render hoặc xem viewer được hỗ trợ; proxy composite chỉ kiểm layout sơ bộ, chưa đạt native gate. Screenshot contact sheet không chứng minh xem hết phim.

**Gate 07 đạt → [08](../../../stages/08_DELIVERY.md).**


## Thời lượng ảnh/logo và nhãn theo provenance

- PNG có thể trở về thời lượng mặc định dù append yêu cầu dài: đo native duration, không tin requested endFrame. RapaNui: PNGlogo yêu cầu51073 nhưng thực nhận150frame. Nếu API không kéo được đúng span, dùng alpha video đã probe đủ frame và đọc lại cảfilm.
- Rendered alpha cards giữ JSON/PNG gốc để sửa; báo rõ chúng không phải native editable Text. Kiểm alpha/fade đầu/giữa/cuối và native composite.
- Nhãn Illustrative footage phụ thuộc nội dung/provenance thực tế. Không áp nhãn generic hàng loạt lên ảnh RapaNui đã xác minh chỉ vì provider là Pexels; nhãn archive/date/affiliation phải đọc đúng từ nguồn.
