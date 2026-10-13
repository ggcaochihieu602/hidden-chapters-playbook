# 06 — Music, ambience và local sound theo câu chuyện

## Đầu vào
Timeline hình/VO đã khóa, chapter/pause map, [instruction](../templates/MUSIC_AMBIENCE_INSTRUCTION.md), audio shortlist tải mới cho phim và [nguồn Epidemic](../reference/MEDIA_SOURCES.md).
## Việc làm
1. Epidemic Sound đã đăng nhập sẵn trong trình duyệt Codex: tự mở hoặc dùng lại tab và thao tác trên phiên hiện có, không hỏi lại đăng nhập hoặc nhờ người dùng bấm tải. Chỉ báo lỗi đăng nhập/truy cập/quyền tải sau khi thực tế gặp lỗi. Mỗi phim chọn và tải mới toàn bộ music/SFX/ambience **chỉ từ Epidemic Sound**. **Không kiểm quyền/gói/subscription/kênh liên kết/safelist**: người dùng đã đăng nhập đúng tài khoản cá nhân, tải được là dùng; chỉ báo lỗi khi thực tế không tải được. Nghe candidate trước chọn; dùng session/download hợp lệ, lưu originals và hồ sơ nguồn tại workspace phim. Chọn nhạc từ nội dung thực từng chương/chuyển biến: mục đích cảm xúc, nhịp, nhạc cụ, độ dày, chỗ dành cho VO. Mẫu tham khảo chỉ gợi ý; không gán nhóm mood cũ cho mọi chương. Số tác phẩm theo nội dung cần dựng; không đặt ngân sách audio hoặc dùng GetHinh để tải audio.
2. Chương 3–5 phút có thể dùng một bản phù hợp + loop đoạn có nhạc. Chương dài/đổi diễn tiến dùng nhiều cue. Tìm và tải các bài Epidemic mới theo mood/range và chuyển biến của phim. Variant WAV/MP3/full/loop của cùng composition không tính bài khác.
3. Tìm Epidemic theo keyword/story instruction từng cue; ưu tiên instrumental để dành chỗ cho VO. Lưu track/SFX ID, item URL, tác giả, download date, bản tải gốc/hash/format/variant và source ranges. Intro 10–20s không VO: Nhạc intro cần phù hợp với bản sắc văn hóa của địa phương hoặc cộng đồng được đề cập và sắc thái câu chuyện. Khi tìm trên Epidemic Sound, ưu tiên chất liệu âm nhạc, nhạc cụ hoặc tiết tấu có liên hệ thực sự với khu vực; kiểm bối cảnh/vùng/thời kỳ và nghe preview, ghi lý do phù hợp vào cue record. Không chọn chỉ dựa trên nhãn phong cách chung chung hoặc tên track, không cố định địa điểm/genre cho mọi phim. Kết hợp SFX và ambience Epidemic phù hợp với hành động/không gian để tăng cảm giác chân thực, giữ đúng provenance; chuyển hình và âm nhạc tự nhiên sang phần kể chuyện có VO. Audio hiện trường gốc của footage tách sang track `Local sound effect` và để nghe được ở mức vừa phải (xem 06 mục 6). Thiếu quyền/truy cập/nội dung → blocker + việc độc lập; không fallback Envato/ACE/AI/provider khác.
4. Music **nghe được xuyên phim**. Kiểm waveform/quiet intro/outro và musical rests sau trim/duck. Cho track sau bắt đầu sớm, overlap/crossfade qua phần nhỏ quá; loop chọn đoạn sustain đúng nhịp/hòa âm, nối mềm. Clip phủ kín hoặc tín hiệu khác 0 chưa chứng minh có nhạc phù hợp nghe được. Không nâng ambience để giả có music.
5. Giữ **file/cue music và ambience riêng theo chương/nội dung**, có thể nhiều nguồn/lớp cho một chương. Giữ nguyên file audio gốc và mọi variant thực tải từ Epidemic trong workspace, import bản gốc đầy đủ vào Media Pool; không xóa sau khi dựng. **Giữ tên gốc tác phẩm/SFX và tác giả trên clip Media Pool/timeline**, không thay chỉ bằng mã M01/B01 hoặc tên chương. Nếu cần cue trim/loop/mix derivative, giữ tên gốc ở đầu tên clip, thêm cue/chương/variant sau, ghi mapping về original + ID/range/hash; cues và audio tracks vẫn riêng, không flatten toàn phim. Ưu tiên trim/gain/fade native khi khả dụng và đã kiểm; derivative có lý do vẫn phải giữ originals và tên nguồn. Không thay toàn bộ arrangement bằng một flattened bed chung. Ambience chọn theo môi trường câu chuyện: biển/gió, cảng, làng, nhà/xưởng… Có bed xuyên phim khi hợp nhưng chuyển/thêm layer theo chương/cảnh; không ép một coastal piece cho tất cả.
6. Tách/detach audio của clip video sang track **`Local sound effect`**, giữ record/source-in/duration sync với video. Trên track video không để lại audio (unlink/detach rồi đặt audio sang `Local sound effect`). Ghi sync/provenance. Âm gốc footage **phải nghe được**, chỉnh âm lượng tương đối hợp lý: dưới VO nhỏ hơn VO rõ rệt (đỉnh khoảng −24 đến −18 dBFS, chỉ tạo cảm giác hiện trường, không che lời); ở intro và nghỉ chương không VO có thể to hơn (đỉnh khoảng −18 đến −12 dBFS) nhưng không lấn nhạc. Fade 0,2–0,5s đầu/cuối mỗi clip để không giật khi cắt cảnh. Đoạn footage có tiếng người nói, nhạc có sẵn, gió ù hoặc tiếng ồn xấu → hạ hẳn hoặc tắt riêng đoạn đó. Nghe nhanh vài chỗ, tương đối hợp lý là đạt. Không gọi âm footage là Epidemic hoặc tự thay bằng audio AI. Không trộn local audio vào VO/music/ambience. Action SFX chủ động chỉ intro; không thêm whoosh cho text.
7. **Thứ tự audio track trong DaVinci Resolve (bắt buộc):** A1 `VO` → A2 `Music 1` → A3 `Music 2` (hai track nhạc nền, dùng xen kẽ để overlap/crossfade giữa các cue) → A4 `Ambience` → A5 trở đi là sound effect: trước là `SFX` (SFX Epidemic thêm vào), sau đó `Local sound effect` (âm thanh tách từ chính footage gốc, thêm track nếu cần).

   | Track | Tên | Nội dung |
   |---|---|---|
   | A1 | `VO` | Giọng đọc (master VO) |
   | A2 | `Music 1` | Nhạc nền (cue lẻ) |
   | A3 | `Music 2` | Nhạc nền (cue chẵn, để overlap/crossfade với A2) |
   | A4 | `Ambience` | Âm thanh môi trường Epidemic; chuyển cảnh bằng fade trên cùng track, kiểm đầu clip trước khi nối |
   | A5 | `SFX` | Sound effect Epidemic thêm vào (intro, hành động) |
   | A6+ | `Local sound effect` | Âm thanh gốc tách từ footage, đúng sync với video, **nghe được**, nhỏ hơn VO |

   Đặt đúng tên track như bảng. Không tạo một track mỗi cue; đặt tên file/cue/chapter rõ để sửa được. Âm lượng `Local sound effect` theo mục 6 (nghe được, không mute).
8. Nghỉ giữa chương 3–5s không VO: hình và nhạc tiếp tục, có thể nhạc nâng nhẹ rồi duck khi lời trở lại. Kiểm nghe các chuyển/loop cùng VO, peak/clipping và lời rõ; thông số đo hỗ trợ, không biến floor của phim cũ thành preset mọi phim.
## Quyết định
Không bắt đổi bài mỗi cảnh; chuyển khi cảm xúc/không gian đổi. Không giữ outro gần im lặng tạo “trống nhạc”. Không giới hạn số ambience; nhiều layer phải có lý do và tránh ù/che VO. Epidemic ambience chọn minh họa môi trường không tự là field recording tại địa điểm của phim; provenance phải đúng.
## Đầu ra
Source/derivative files riêng, cue arrangement theo chương, native audio readback và hồ sơ nguồn và cue của phim. Giữ originals và mọi variant Epidemic thực đã tải; có ZIP thì giữ ZIP + full folder, không giả ZIP/stems. Audio nguồn khác từ dự án cũ giữ như lịch sử, loại khỏi lựa chọn đang bật.
## Checklist
- [ ] Tất cả music/SFX/ambience Epidemic; ID/file/hash/ranges thật, nguồn tải mới cho phim.
- [ ] Keyword/mood bám script; intro không VO 10–20s, nhạc hợp văn hóa địa phương/cộng đồng; đã nghe và ghi liên hệ chất liệu/nhạc cụ/tiết tấu với khu vực, không chỉ dựa tên track/nhãn genre; chuyển tự nhiên sang VO.
- [ ] Toàn duration có music nghe được + ambience phù hợp, kể cả pause.
- [ ] Loop/transitions/quiet head-tail xử lý; VO rõ, không clipping.
- [ ] Thứ tự track đúng: A1 VO, A2–A3 nhạc nền, A4 ambience, A5 SFX, A6+ Local sound effect (âm footage gốc).
- [ ] Âm gốc footage đã tách khỏi video, nằm ở `Local sound effect` đúng sync, nghe được và nhỏ hơn VO; SFX intro, text không whoosh.
- [ ] Các cue/file riêng dễ thay; không báo mix dài là nhiều tác phẩm riêng.
- [ ] Originals, variants và hồ sơ tải Epidemic nằm trong workspace phim; không có ngân sách audio hoặc đơn tải GetHinh audio.
## Ví dụ
Chương bến cảng: nhạc chờ đợi/nhịp công việc + nước/gió/cẩu phù hợp. Chương sơ tán: căng thẳng tiết chế → xa nhà trầm; chương hồi hương chuyển hy vọng rồi khó khăn đời sống nếu script có, không vui toàn chương.
## Sửa lỗi
Timeline có clips nhưng nghe trống → kiểm musical rests/duck/gain trong range thực, chọn loop/cue khác/overlap. Chỉ một ambience cả phim → lập cue không gian từng chương. Nhiều file nhưng cùng track variants → ghi canonical và chọn theo nhu cầu, không gọi là nhiều bài mới.
## Tiếp tục
Gate 06 đạt → [07](07_TEXT.md); sửa âm thanh không đồng nghĩa export full. [Lỗi mix/render](../reference/TECHNICAL_FIXES.md#audio).

## Kiểm stream và nền tổng thực
Đo selected range để phân biệt có audio stream với có tín hiệu; disable local source digital silence. Nếu cần kiểm floor liên tục, cộng PCM cue theo offset/crossfade/loop thực, không chỉ union file ranges hay full-source loudness. Kết hợp native sample; ghi đúng phạm vi nghe. [Bài học](../reference/TRISTAN_V28_FIXES.md#audio-có-stream-nhưng-không-có-tín-hiệu--đã-xác-nhận).

## Native verification — 03/10/2026
Do not append crossfading ambience beds to one occupied track without verifying their full source heads. Ambience now has a single track (A4): butt-join with fades and verify full source heads instead of stacking beds. [LRN-03/06](../reference/LA_RINCONADA_NATIVE_FIXES.md#lrn-03-ambience-overlap-on-the-same-track). Numerical cue-sum QC must be distinguished from native bus rendering and subjective listening.
