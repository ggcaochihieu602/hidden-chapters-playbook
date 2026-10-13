# Tìm nguồn — chỉ mở trong bước 02

## Trước tháp: keyword file của toàn phim

Tạo STOCK FOOTAGE & MUSIC KEYWORDS.txt theo nội dung từng chương/vế, câu trước và câu sau; đọc [ví dụ Longyearbyen](CLAUSE_MATCHING.md). Theo tiêu đề/script/vế, video đúng thực thể/địa điểm/người/sự kiện trước. Thiếu video → Google Images tìm ảnh thật đúng đối tượng tại trang gốc → rồi mới nới rộng hành động/bối cảnh có lý do. Ý không định vị được mở rộng khi đã xác định cần như vậy, không gán cảnh khác thành thực địa. Không phải mọi chữ đều cần đúng một clip; chọn theo ý chính. Không thêm góc máy vào mọi query nếu không cần. Ghi replacement_level và match_reason, giữ provenance thật.

## Tháp keyword A + B

| Tầng | Query và mục đích | Điều kiện dùng |
|---|---|---|
| A1 | Tên thực thể + cơ chế/công trình | Hình chứng minh trực tiếp phải đúng nơi/đối tượng |
| A2 | Tên nơi + hành động/góc nhìn | Metadata + preview hỗ trợ cả địa điểm và động tác |
| A3 | Cùng vùng + cảnh quan/hạ tầng | Context tương thích, không gán landmark khác |
| A4 | Tư liệu lịch sử/bản vẽ đúng thực thể | Đúng năm/người/nhãn, có provenance |
| B1 | Hành động tại đúng nơi | Lấp góc thiếu của A |
| B2 | Hành động trong vùng tương thích | Context, không gọi là footage thực địa nếu không phải |
| B3 | Cận hành động không định vị | Không logo/kiến trúc/công nghệ trái lời |
| B4 | Minh họa cơ chế/số liệu cần giải thích | Chỉ khi làm rõ thông tin; không card cho mọi ý trừu tượng, không chứng minh sự kiện |

Các chuỗi sau là ví dụ mở rộng **sau tìm video và ảnh thật đúng đối tượng**, không mặc định cho mọi phim. Ví dụ Tristan: `Tristan da Cunha Calshot harbour cargo landing` → `remote island cargo transfer small boat` → `ship crane unloading cargo close up`. Factory: exact Tristan lobster factory trước → seafood processing/freezing interior tương thích. Lịch sử 1961–1963 dùng ảnh đúng sự kiện; không gán eruption nơi khác là Tristan. Người dùng cho phép footage hành động thay thế, không cho phép ghi sai nơi.

## Tìm theo chuỗi nghĩa câu

| Chức năng câu | Coverage cần tìm |
|---|---|
| Định vị | toàn cảnh → đối tượng → chi tiết |
| Hành động | chuẩn bị → thực hiện → kết quả |
| Cơ chế | hiện tượng → bộ phận → tương tác → kết quả |
| Nhân quả | tác nhân → quá trình → hệ quả đúng |
| So sánh | A/B có góc nhìn/quy mô tương xứng |
| Lịch sử | trước → bước ngoặt → sau |
| Đời sống | người → sinh hoạt → ảnh hưởng |

Chuỗi mô tả coverage, không ép ba cut hay ba clip đồng nghĩa. Một clip có thể chứa cả hành động/kết quả. Ghi usable range thấy hành động thật; cùng keyword không đủ.

## Nguồn và đường tải

GetHinh và Epidemic Sound **đã được người dùng đăng nhập sẵn trong trình duyệt tích hợp của Codex**. Khi đến bước sourcing, agent tự mở hoặc dùng lại tab của dịch vụ trong trình duyệt Codex, sử dụng phiên đăng nhập hiện có để tìm, preview, chọn và tải trong phạm vi công việc/ngân sách đã giao. Không hỏi lại đã đăng nhập chưa, không yêu cầu người dùng mở trang hoặc bấm tải thay. Chỉ báo blocker nếu đã tự mở và thực tế gặp phiên hết hạn, yêu cầu đăng nhập, lỗi truy cập hoặc thiếu quyền tải; ghi đúng lỗi và tiếp tục phần độc lập. Không yêu cầu cookies/token và không lấy việc mở trang làm bằng chứng đã tải file.

- Pexels API và Pixabay API: video theo đúng nhu cầu từng vế; API key riêng, không ghi trong prompt/ZIP/log. Envato Elements/Vecteezy: preview trên trang nguồn, đưa URL item vào GetHinh đã đăng nhập và chọn nguồn 1 xu khi đúng item có giá đó. Không giả mọi item luôn 1 xu. Google Images tìm **trang gốc ảnh** trước mở rộng khi thiếu video đúng đối tượng, không phải nhà cấp quyền ảnh. Không tự chuyển Storyblocks; audio music/SFX/ambience chỉ Epidemic, xem [provider](MEDIA_SOURCES.md).
- Thử một item cần thiết để xác nhận session/flow tải, sau đó batch. Mỗi trạng thái: candidate → preview-reviewed → download-approved → downloaded-verified → timeline-approved. Khi người dùng đã chỉ định GetHinh, mục đích và trần xu, agent tự bấm các bước tải trong trần đó; không yêu cầu người dùng bấm thay. Check file đĩa + probe; lịch sử/link download chưa chứng minh hoàn tất.
- File chậm/treo: kiểm Downloads, lịch sử và số dư trước retry. Nếu chưa ghi nhận lượt trừ xu hoặc có nút “Thử lại”, thực hiện “Thử lại” → “XÁC NHẬN VÀ DOWNLOAD”, đợi kết quả rồi bấm “Tải về”. Dùng tải lại item đã mua nếu có, tránh mua trùng. Không vượt CAPTCHA/đăng nhập/chặn bảo vệ.
- Sau mỗi lượt tải, giải mã và so sánh ít nhất một khung hình với preview cùng Envato ID, ngoài kiểm codec/duration/hash. Nếu GetHinh giao nhầm nội dung dù trang báo “Hoàn thành”, loại file khỏi nguồn phim, ghi xu thực trừ và bằng chứng, rồi dừng đơn tiếp theo tại provider cho đến khi nguyên nhân được làm rõ.
- Format: xem orientation/resolution của item trước mua; lọc ngang cho phim ngang. Probe lại file thực nhận và loại original dọc. Range review phải phát hiện cả video dọc lồng trong compilation ngang.
- Dedup provider ID/canonical source/hash, rồi xem duplicate thị giác. Giữ file gốc và derivative linkage; query đổi không tạo asset mới. Review cache chỉ dùng lại khi range/claim không đổi.
- Lưu rights source/author/license/evidence và geography. Source title/thumbnail không đủ review hành động. Preview unavailable phải ghi pending; xem temporal sample hoặc original rồi mới timeline-approved.
- Ngân sách giới hạn chi tiền; ưu tiên nhiều candidate miễn phí và đủ dự phòng semantically đúng. Không dùng quota số lượng thay độ liên quan.

Quay về [gate 02](../stages/02_SOURCE_BATCH.md).

## Ưu tiên nguồn — ver20
Áp dụng [MEDIA_SOURCES](MEDIA_SOURCES.md).
