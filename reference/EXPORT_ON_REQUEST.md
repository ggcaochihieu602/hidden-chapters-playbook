# Xuất phim chỉ khi được người dùng yêu cầu

Mặc định công việc kết thúc ở timeline đã lưu/mở sẵn. Chỉ mở tài liệu này khi scope yêu cầu AI xuất file. Người dùng tự export không cần workflow AI full render.

1. Khóa timeline đúng tên/ID/phiên bản; mặc định timeline/output/export3840×2160 UHD 4K, 16:9, đọc setting native và giữ fps theo profile. Chỉ đổi resolution khi user yêu cầu rõ; không dùng timecode phim cũ.
2. Frame capture có thể đổi Deliver range; pin preset, explicit MarkIn/MarkOut/TargetDir/CustomName cho mỗi export, so requested frame count trước StartRendering. Không restart/dừng render khác.
3. Khi job complete, probe streams/duration/frame count/dimensions/fps/audio, decode EOF, sample đầu/giữa/cuối; record phạm vi đã xem/nghe thật. Complete metadata không chứng minh file đầy đủ.
4. Copy sản phẩm cuối đã kiểm đúng folder phim; keep previous version, thumbnail+prompt/SRT timeline khớp. DRP/cache/footage vẫn ở workspace. Không publish tự động.

Build quirks và evidence cũ: [ver10 delivery](history/ver10-stages/08_DELIVERY.md), chỉ tra lỗi cụ thể. Không ép full rerender cho sửa audio trừ khi nhiệm vụ thật là xuất bản file mới.
