# Nguồn footage và âm thanh — dùng trong bước 02/06

## Truy cập GetHinh và Epidemic Sound

GetHinh và Epidemic Sound **đã được người dùng đăng nhập sẵn trong trình duyệt tích hợp của Codex**. Khi đến bước sourcing, agent tự mở hoặc dùng lại tab của dịch vụ trong trình duyệt Codex, sử dụng phiên đăng nhập hiện có để tìm, preview, chọn và tải trong phạm vi công việc/ngân sách đã giao. Không hỏi lại đã đăng nhập chưa, không yêu cầu người dùng mở trang hoặc bấm tải thay. Chỉ báo blocker nếu đã tự mở và thực tế gặp phiên hết hạn, yêu cầu đăng nhập, lỗi truy cập hoặc thiếu quyền tải; ghi đúng lỗi và tiếp tục phần độc lập. Không yêu cầu cookies/token và không lấy việc mở trang làm bằng chứng đã tải file.

GetHinh dùng cho footage Envato Elements/Vecteezy trong ngân sách video đã giao; audio tải trực tiếp từ Epidemic Sound cho từng phim, không có ngân sách GetHinh audio.

## Pixabay: thêm vào tổ hợp footage hiện có
Dùng Pixabay API cùng Pexels, Envato/Vecteezy/GetHinh và các nguồn tư liệu hiện có; không thay toàn bộ nguồn bằng Pixabay. Theo tiêu đề/script/vế: video đúng đối tượng trước; thiếu video thì Google Images → ảnh thật đúng đối tượng ở trang gốc trước khi mở rộng bối cảnh/hành động. Vế không cần định vị được mở rộng có lý do; ghi attempts/source scope. Không tự chuyển Storyblocks. Stock minh họa không được ghi thành bằng chứng thực địa.

API chính thức: https://pixabay.com/api/docs/ ; endpoint video `https://pixabay.com/api/videos/`. Key người dùng đã cung cấp được lưu mã hóa Windows DPAPI theo user tại `C:/Users/OS/.codex/secrets/pixabay-api-key.dpapi`; chỉ giải mã tại runtime trên tài khoản Windows này, không in key/request URL chứa key, không đưa vào JSON dự án, Git, prompt hay ZIP. Nếu đổi máy/user thì cần cấu hình lại credential.

Dùng helper [search_pixabay.ps1](../scripts/search_pixabay.ps1) với Query và CacheDirectory tại workspace phim. Ví dụ: `powershell -File search_pixabay.ps1 -Query "remote island ocean" -CacheDirectory "<film-workspace>/sources/pixabay-cache"`. Helper trả JSON metadata, không tải footage tự động. Preview candidate rồi tải URL của rendition trong `hits[].videos` phù hợp, ưu tiên ngang và độ phân giải cao có sẵn; probe/decode và xem usable range trước import. Lưu provider, id, pageURL, contributor, query, tags, retrieval date, rendition/size/dimensions/duration, file/hash, license evidence, match_reason và source range. Ghi Pixabay khi hiển thị kết quả tìm.

Cache kết quả ít nhất 24h; mặc định API 100 requests/60s, đọc rate-limit headers khi cần và dừng/backoff khi 429. Chỉ query theo nhu cầu phim và tải candidate đã chọn; không crawl hay systematic mass download. Tổng hợp đủ nguồn toàn phim vẫn áp dụng, nhưng không phải giấy phép tải hàng loạt toàn kho Pixabay. Giá GetHinh xu không áp cho API Pixabay; ghi chi phí thực tế, không bịa xu.

Kiểm chứng 03/10/2026: một query ocean, per_page=3, trả 3 video và URL rendition. Chưa tải/decode footage, chưa tích hợp adapter MoneyPrinter2. Đây là nguồn và công cụ sourcing của playbook.

## Epidemic Sound: nguồn cho toàn bộ nhạc/SFX/ambience
Epidemic Sound đã đăng nhập sẵn trên trình duyệt Codex; agent tự mở/dùng lại tab và sử dụng phiên đó. Mỗi phim tìm, nghe preview, chọn và tải mới **chỉ từ Epidemic Sound** cho toàn bộ background music, sound effect và ambience. Dùng session đăng nhập hợp lệ và chức năng preview/download được tài khoản cho phép. Không kiểm quyền/gói/subscription/kênh liên kết/safelist (tài khoản cá nhân của người dùng, tải được là dùng); chỉ báo thiếu quyền khi giao diện thực tế cho thấy vấn đề, không yêu cầu xác nhận đăng nhập trước khi mở trang. Không yêu cầu cookies/token và không tự mua/nâng subscription.

Tìm nhiều candidate theo bảng music/ambience từng chương; nghe preview, chọn và tải bản phù hợp. Ghi track/SFX ID, tên, tác giả, item URL, download date, định dạng/variant, file/hash, cue/source ranges. Không giả có ZIP hay stems: giữ tất cả variant thực sự được tải; nếu có ZIP thì giữ ZIP + toàn bộ folder giải nén. Giữ nguyên file audio gốc và mọi variant thực tải từ Epidemic trong workspace, import bản gốc đầy đủ vào Media Pool; không xóa sau khi dựng. **Giữ tên gốc tác phẩm/SFX và tác giả trên clip Media Pool/timeline**, không thay chỉ bằng mã M01/B01 hoặc tên chương. Nếu cần cue trim/loop/mix derivative, giữ tên gốc ở đầu tên clip, thêm cue/chương/variant sau, ghi mapping về original + ID/range/hash; cues và audio tracks vẫn riêng, không flatten toàn phim. Ưu tiên trim/gain/fade native khi khả dụng và đã kiểm; derivative có lý do vẫn phải giữ originals và tên nguồn. Giữ đường dẫn timeline ổn định.

Thiếu nội dung/quyền/truy cập: ghi blocker, không tự chuyển sang Envato/GetHinh, nguồn khác hoặc AI audio nếu chưa có yêu cầu mới của người dùng. Không dùng GetHinh để tải audio và không đặt ngân sách audio; sử dụng quyền tải hiện có của tài khoản Epidemic, không tự mua/nâng gói. Các quy tắc cue riêng theo chương, nhạc liên tục qua pause, VO rõ, action SFX chỉ intro và Local sound effect vẫn giữ.
