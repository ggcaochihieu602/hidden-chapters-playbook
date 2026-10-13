> LỊCH SỬ — không phải quy tắc hiện hành. Ver 2/START_HERE và chỉ đạo mới ưu tiên. Chỉ đọc phần được bước hiện tại trỏ tới.

# Kinh nghiệm dựng brief trong MP2

Cập nhật 2026-09-25. Đây là bộ nhớ dự án để các lượt sau đọc lại; điểm vào là `AGENTS.md` và skill cá nhân `mp2-brief-edit`. Không phải cam kết model tự nhớ mọi cuộc trò chuyện.

## Mục tiêu và ranh giới hiện hành

Chỉ đạo mới nhất: kết hợp A làm nền cho nội dung chính/cơ chế, B cho câu dẫn và cảnh bổ sung. Ưu tiên hoàn thành phim, không đòi xác minh mọi chi tiết 100%; nguồn context hợp lý không mâu thuẫn có thể dùng sau preview nhanh, ghi uncertainty. Các khẳng định địa điểm/cơ chế chính vẫn cần bằng chứng đủ. Mỗi cảnh ảnh thật/AI tối đa 8 giây; cảnh video tối đa 10 giây. Đây là giới hạn trên timeline, không giới hạn độ dài file nguồn. Người dùng đã cho phép chạy benchmark TwelveLabs trước rồi OpenAI độc lập; chưa cho render lại.

- MP2 nhận brief + script + VO + keywords, điều phối API/model và tạo project Kdenlive sửa được. ChatGPT hỗ trợ hiểu nội dung, xử lý ngoại lệ và phát triển tool.
- Mỗi video, ảnh thật và ảnh AI mặc định dùng một lần trong phần phim chính. Ngoại lệ mới cho Introduction: được lấy lại một đoạn khác của video chất lượng cao sẽ xuất hiện ở chương sau để preview nhanh, miễn vẫn khớp VO và được ghi giới hạn dùng theo asset.
- Tỷ lệ theo thời lượng: video 50–60%; còn lại ảnh chuyển động. Chỉ đạo mới ngày 2026-09-25 thay tỷ lệ ảnh AI cố định: chỉ dùng AI cho cơ chế phức tạp khi ảnh/video thật phù hợp không tìm được. Giảm thời lượng ảnh; đề xuất ảnh thật 4–6s, ảnh AI 5–7s, có thể tăng để đọc hiểu nhưng không vượt 8s.
- Phân bố ảnh và video linh hoạt trên toàn timeline, kể cả qua ranh giới segment/chương. Ưu tiên video phù hợp và cho phép nối nhiều video liên tiếp; tránh một khối dài chỉ ảnh khi không cần. Không còn giới hạn cứng tối đa hai cảnh cùng medium.
- Ảnh chuyển động nhẹ và phủ kín khung suốt đoạn; title đầu chương tiếng Anh, giữa màn hình.
- Brief là hướng dẫn; chỉ đạo mới trong chat được ưu tiên. Nhạc tự tạo được cho phép. Người dùng đánh giá âm thanh V005 tốt nhưng chưa đối chiếu chi tiết với brief.
- Trạng thái hiện tại: full render vẫn dừng; revision 12/timeline 7/handoff r7 đã được dựng để chỉnh trong Kdenlive, chưa xuất video.
- Cho phép tìm nhiều nguồn, kể cả 100–200 video/ảnh, không đồng nghĩa ngân sách xu/API không giới hạn. Đối soát chi và hạn mức còn lại trước đợt trả phí.

## Bằng chứng V005

Snapshot: brief revision 8, timeline revision 5, handoff `r5-20260924T223245Z-c6fff43d`. Nếu người dùng sửa project sau snapshot, so sánh trước revision tiếp.

- 127 placement, 67 asset: 33 video/63 placement; 26 ảnh thật/43 placement; 8 ảnh AI/21 placement.
- 60 placement vượt lần dùng đầu; 9 cặp trùng liền nhau; 24 lần dùng lại có khoảng cách từ cuối lần trước đến đầu lần sau dưới 60 giây. Chưa tính file khác ID nhưng trùng hình.
- 21 video Envato, 7 Pexels, 5 Commons; 8 cue ACE-Step, 1 ambient tổng hợp, 6 whoosh. 0 video AI. 2 ảnh AI mới trong vòng mixed-media; 8 ảnh được dùng không đồng nghĩa 8 lần tạo mới đã chứng minh.
- Với asset của timeline này, database không có hàng trong `footage_chunks`, `footage_visual_reviews`, `footage_scene_visual_reviews`. Không có bằng chứng V005 dùng pipeline TwelveLabs/Marengo; code cho pipeline này tồn tại ở luồng khác.
- QC dựa trên FFmpeg sample frames/contact sheets, FFprobe và model xem hình trong cuộc trò chuyện. Không có bằng chứng xem mọi frame. Manifest ghi Maeklong từng bị loại nhầm từ mẫu giữa clip, rồi sửa sau khi xem thêm frame.
- Google Doc được đọc qua browser và lưu text. PDF hai cột được tách bằng `pdfplumber` trong `parse_editor_pdf.py`. Dịch dùng OpenAI API ở `translate_v005.py`; ASR faster-whisper small CPU int8; alignment dùng word timestamps + `SequenceMatcher`. Không suy ra đã nạp skill PDF chỉ vì có pdfplumber; lịch sử hiện có không ghi đầy đủ mọi skill đã nạp.

## Phần MP2 làm và phần Codex điều phối

MP2 lưu revision/import, kiểm tra binding, biên dịch timeline, gắn motion/title/audio cue, tạo handoff và thống kê. Script V005 còn chọn sẵn scene ID, asset pool và ảnh AI. Codex đọc brief, đánh giá nguồn, tạo prompt, gọi imagegen, chạy script nhạc, sửa lỗi và điều khiển render. Gọi API/hàm MP2 là sử dụng MP2 thật nhưng chưa chứng minh workflow tự chạy cho brief mới.

Không có time tracking để tính phần trăm công sức chính xác. Phân biệt công quyết định/điều phối, phát triển tool, và thời gian CPU/GPU render; không tính thời gian chờ render là công của ChatGPT.

## Sổ lỗi và phòng ngừa

| Lỗi | Bằng chứng/nguyên nhân | Cách phòng ngừa | Trạng thái |
|---|---|---|---|
| Lặp nguồn | Planner video cap 3, chỉ ưu tiên tránh nguồn vừa dùng; ảnh thật xoay pool; ảnh AI dùng `[asset] * count`. Compiler trước đây chưa bao mọi visual trong cùng kiểm tra reuse. | Sổ dùng toàn phim, cap 1 mọi visual và nhóm nguồn trùng; thiếu nguồn thì tìm thêm/báo thiếu. | Đã sửa trong brief compiler và V005 r6; 244/244 asset duy nhất |
| Motion lộ đen | Screenshot + `_transform_rect` trước đây không nhận kích thước nguồn. cx=.46,z=1.015,Cw=3840 cho x≈+156px, nằm trong canvas. Thiếu bù tâm `(canvas-scaled)/2`. | Cover theo nguồn/content bounds; giới hạn pan theo phần dư; kiểm tra toàn đường chuyển động và frame render. | Đã sửa; QA 132 still r6 có 0 endpoint lộ canvas |
| Loại nhầm clip | Manifest QC ghi Maeklong phải xem lại frame 6s/10s. | Multi-frame/theo shot; thiếu bằng chứng gắn unknown, không kết luận từ một midpoint. | Bài học đã xác minh |
| Đọc sai PDF/thiếu ảnh brief | Text Google Doc không có ảnh mẫu; PDF hai cột cần crop riêng. | Lưu bản gốc+text+trang mẫu; normalize theo scene ID, kiểm tra cột thiếu. | Parser V005 có; chưa tổng quát hóa |
| Timestamp script lệch VO | VO khoảng 30:16.5, mốc hoạch định dài hơn. | ASR/word alignment, confidence và kiểm tra mốc chuyển chương. | Script riêng |
| Làm tròn duration | fps/speed/microsecond và đuôi audio lệch phần giây. | Quy tắc frame rounding thống nhất; kiểm tra source range trước package; trim đuôi nhỏ có giới hạn và ghi nhận. | Backend có sửa |
| Audio cùng basename ghi đè | Imported cue có thể cùng tên `audio.wav`. | Package tên theo cue/index/hash; kiểm tra resource/hash riêng. | Đã sửa trước r5 |
| SVG title sai vị trí/alpha | Qt SVG/MLT không hiển thị percentage/tspan/alpha như kỳ vọng. | Tọa độ tuyệt đối, `fill-opacity`, smoke bằng đúng renderer. | Đã sửa; r5 smoke đúng |
| Slate INVALID | Resource tương đối cần cwd package; file GUI và render sequence khác chọn producer. | Dùng `render-sequence.mlt`, cwd package; xem pixel thật trước full render. | Đã xác minh |
| Bitrate sai đơn vị | `vb=50000` tạo file nhỏ bất thường; `vb=50000k` tạo dung lượng phù hợp mục tiêu. | Preset có đơn vị, đo bitrate sau smoke với đúng preset. | Script sửa; full r5 chưa xong |
| Tự dừng render gây mất công | Codex từng dừng để thêm audio/đổi bitrate, người dùng phản đối. | Chốt snapshot trước render; trao đổi trước restart khi đang chạy. Lệnh dừng trực tiếp của người dùng thực hiện ngay. | Quy tắc đã lưu |
| CLI lỗi dù backend xong | cp1252 không in được Unicode sau khi package đã tạo. | stdout UTF-8; kiểm tra manifest/server trước retry để tránh build hai lần. | Đã sửa CLI |
| Metadata duration dài hơn file probe | Pexels báo clip gần 10s, FFprobe là 9,975s; speed 1.0 làm source range vượt EOF. | Tính speed từ duration đã ingest, làm tròn xuống và giữ margin 40ms; compiler tiếp tục chặn range vượt EOF. | Đã sửa trong planner r6 |
| Metadata media không phải UTF-8 | Envato G8BT2QU probe được nhưng ingest lỗi tại byte metadata camera và log FFmpeg. | Giải mã stdout FFprobe và stderr FFmpeg bằng UTF-8 `errors=replace`; vẫn kiểm tra return code/JSON/derivative. | Đã sửa và xác minh bằng ingest thành công |
| Visual đúng chương nhưng sai câu VO | Audit r7: 77 đoạn căn VO dài trung bình 23,59s được chia slot 8s; planner lấy asset chưa dùng đầu tiên theo chapter/A-B/source, không chấm subject/action/mechanism. Cả 266 placement thiếu `vo_span`, `semantic_score`, `match_reason`; 27 placement chương 1–6 còn lấy asset khác chương. | Tách VO theo câu/semantic beat có timestamp; mô tả usable range của footage; chấm subject/action/place/mechanism cho từng beat; mix/uniqueness chỉ là constraint sau semantic match. | Chưa sửa; r7 bị ảnh hưởng |
| Introduction đúng chủ đề nhưng chưa đúng từng mệnh đề | HOOK-04 ban đầu là một segment 35,62s nên chỉ danh sách asset chung; không bảo đảm đúng thời điểm câu “six railways”, gravity, market và frozen ground. | Căn bản tiếng Việt với VO tiếng Anh, tách clause theo timestamp; câu hành động dùng footage hành động trực tiếp; câu liệt kê sáu tuyến dùng montage sáu shot; lưu segment/reason trong timeline. | Đã áp dụng V005 revision 20 / Kdenlive r10 |
| GetHinh giữ trạng thái “Đang tải” | Hai asset Envato XRL8K6S và LL2GK4G đều qua màn xác nhận nhưng không sinh file sau nhiều phút; số dư trang vẫn hiển thị 94 xuA. | Chỉ count/download/import khi file thật xuất hiện và probe đạt; không tiếp tục xếp hàng khi provider đang treo. | Chưa sửa được phía website; r6 dùng 18 Envato đã tải trước |
| Thống kê nhập/tạo/dùng lẫn nhau | AI import thiếu run record; xu giảm không bằng chi phí riêng asset được dùng. | Lưu attempts/request ID/usage, giá ước tính và thực trả; thiếu dữ liệu ghi unknown. | Có một phần |
| Tính năng có code nhưng chưa vận hành | Brief assemble/handoff chạy; render còn CLI, asset selection hard-code. | Nghiệm thu brief thứ hai bằng API/UI, không sửa script/SQLite riêng. | Chưa đạt |

## Bổ sung từ thử nghiệm tìm kiếm 2026-09-25

- Xem `docs/V005_KEYWORD_SEARCH_EXPERIMENT.md`: 10 query, 120 lượt thẻ kết quả, 3 preview mở/quan sát; không đồng nghĩa 120 unique hoặc đã duyệt toàn clip.
- Envato có thể trả địa điểm/cơ chế sai cho query rất cụ thể. Pilatus còn bị lẫn Pilat/Piran; Locher có Scotland. Tên query và vị trí đầu kết quả không là bằng chứng pass.
- A theo thực thể + B theo hành động bổ sung nhau: hai query Maeklong có 13 ID mang metadata địa điểm sau dedup, chưa phải 13 clip approved. Không suy rộng kết quả sang toàn kho/sáu chương.
- Lịch sử chưa chứng minh mọi video V005 đã xem preview trước tải. Quy trình mới bắt buộc phân biệt metadata candidate, preview reviewed, approved download, downloaded verified, approved timeline; giữ timestamp và bằng chứng.
- MP2 settings hiện có gpt-5-mini cho editorial và visual review. visual_review.py chỉ dùng 3 frame 20/50/80%, <=768px, detail low; không chứng minh xem chuyển động đầy đủ. TwelveLabs chưa được benchmark với ChatGPT trên V005 nên không tuyên bố bên nào tốt hơn.
- Photo/AI ngắn hơn là chỉ đạo đã lưu; các khoảng 4–6s/5–7s là đề xuất khởi điểm. Không dùng AI để đạt quota cũ. Cover trước motion vẫn là yêu cầu, sửa renderer vẫn chưa triển khai.

## Cache và chi phí

### Pilot provider đã chạy, thay đề xuất chưa thử bên trên

Xem `V005_REVIEW_BENCHMARK.md`: TwelveLabs Pegasus 1.5 nhận bốn video proxy đầy đủ trước, sau đó gpt-5-mini xem chuỗi khoảng 1fps độc lập. Cả hai nhận đúng 4 nội dung dương tính; TwelveLabs có 1 khẳng định hành động trái ảnh tham chiếu (tàu chạy qua cầu Landwasser), OpenAI trả unknown. TwelveLabs còn gán thời gian cho 6 câu phủ định trái prompt. Giữ OpenAI mặc định, bỏ TwelveLabs khỏi bước duyệt V005 đề xuất. Nhãn từ Codex xem ảnh mẫu, không phải human gold; chưa thử Marengo retrieval. Lưu raw response/usage; không biến pilot thành kết luận phổ quát. Production sampler ba frame chưa được nâng trong lượt này.

Phòng ngừa: model có thể nhận ra công trình nhưng tự thêm hành động quen thuộc. Phân biệt “cầu có trong hình” và “tàu đang chạy qua cầu”; vẫn dùng clip làm context khi phù hợp. Kiểm tra schema/timestamp bằng code, không tin rằng prompt luôn được tuân thủ.

Cache theo input hash+provider/model+prompt/rule version. Query đổi không làm tải/index lại cùng file. Lọc metadata/preview và trùng provider ID trước tải full. Phân tích nguồn một lần, chỉ đánh giá lại khi câu hỏi hoặc usable range thay đổi. Dùng code cho đếm/timing/constraints, model cho hiểu nội dung. Giới hạn retry và budget từng job; xác nhận file tải xong/probe được trước count downloaded. Chạy smoke có chủ đích trước render dài, sau đó giữ nguyên snapshot đang render.

## V005 revision 11 / Kdenlive r6

- MP2 đã tìm và ingest 198 candidate mới qua provider Pexels, giữ query, chương, relevance A/B, external ID và license metadata. Binding cuối dùng 185 Pexels, 18 Envato đã tải trước, 33 Wikimedia Commons và 8 ảnh AI cơ chế.
- Timeline revision 6 dài 54.488 frame/30 fps, 244 placement và 244 asset duy nhất: 112 video, 132 still, video chiếm 50,41%. Video tối đa 300 frame; still tối đa 240 frame.
- `_transform_rect` dùng source width/height và cover-safe clamp. QA toàn bộ 132 still kiểm tra cả hai endpoint: 0 lỗi phủ canvas. Handoff package có 244 media, 0 file thiếu.
- Project: `artifacts/kdenlive/v005-impossible-railways-brief/builds/r6-20260925T114123Z-c020baf8/V005 Impossible Railways - preview - MPCut.kdenlive`. Không render bản full trong revision này.

Tham chiếu: `docs/V005_MIXED_BUILD_EDITOR_NOTES.md`, `docs/V005_MP2_REAL_WORKFLOW_AUDIT.md` (lịch sử), `artifacts/v005-inputs/V005_MIXED_USAGE_REPORT.json`, `V005_MEDIA_QC_MANIFEST.json` và các script được nêu.

## V005 revision 12 / Kdenlive r7

- Batch GetHinh có 22 file tải hoàn chỉnh và FFprobe đạt; MP2 ingest 22 đường dẫn nhưng một file Mauritania trùng content hash với asset đã có, nên timeline dùng 21 visual mới độc nhất.
- Timeline revision 7 có 266 placement/266 asset duy nhất: 137 video và 129 still. Video chiếm 51,92% thời lượng; cùng medium liên tiếp tối đa 2 cảnh trên lưới toàn phim, không reset ở ranh giới chương.
- Handoff `r7-20260925T171143Z-04c6f7c1` đóng gói thành công, chưa render. Project: `artifacts/kdenlive/v005-impossible-railways-brief/builds/r7-20260925T171143Z-04c6f7c1/V005 Impossible Railways - preview - MPCut.kdenlive`.

## V005 sentence binding / Kdenlive r9

- r8 lập 266 slot trực tiếp từ timestamp VO và lưu `vo_span`, điểm, confidence, lý do, asset cho từng slot. Audit 8 frame đều nhau cho video chứng minh metadata/query Pexels không đủ để duyệt: 26/47 assignment yếu ban đầu bị loại hoặc thay.
- Transition có thể giữ prefix chương cũ dù VO đã nói sang địa điểm mới. Quy tắc sửa: timestamp và câu thực nói quyết định chapter requirement; segment ID chỉ là gợi ý.
- QA đầu tiên của r8 phát hiện summary báo `max_run=2` nhưng timeline thật có chuỗi 5 ảnh. Nguyên nhân là summary duyệt manifest theo thứ tự file thay vì `start_frame`, và không tái kiểm tra sau khi asset thay thế. r9 kiểm tra theo thời gian thật và trên XML Kdenlive.
- Ba still ở chương permafrost được thay bằng video đã xem 8 frame: dry ice, đường ống airflow trung tính và sensor readout. Hai cảnh Pilatus được đổi vị trí để giữ nghĩa câu VO và phá chuỗi ba still.
- Kdenlive r9/brief revision 15: 266 placement, 266 asset ID và 266 content hash độc nhất; 136 video/130 still; video 51,32% thời lượng; tối đa hai medium liên tiếp; video <=10s, still <=8s. Cả 130 still có affine keyframes và mọi endpoint phủ kín 3840x2160. Tám title chương, tám cue nhạc và toàn bộ package media đều đủ. Báo cáo: `artifacts/v005-inputs/V005_R9_TIMELINE_QA.json`.
- Lỗi nguồn lặp lại cần phòng ngừa: URL Wikimedia trực tiếp có thể trả file HTML rất nhỏ; phải kiểm tra MIME/byte/decode rồi dùng API `thumburl`. Video ngắn sát duration slot có thể hụt một frame sau lượng tử hóa; giữ decode margin khi tính speed.
- Bản r9 chưa render. Project: `artifacts/kdenlive/v005-impossible-railways-brief/builds/r9-20260925T192345Z-ef116fa4/V005 Impossible Railways - preview - MPCut.kdenlive`.
- Provenance bug: 9 ảnh AI tạo cho r8 được nhập qua generic local import; 7 ảnh dùng trong r9 đang mang `platform=local`/`User-supplied local media`. Báo cáo sử dụng đã đối chiếu tên file và generation manifests, cho kết quả 13 ảnh AI dùng tổng cộng, nhưng MP2 cần giữ generator/run/prompt/cost qua bước import. Xem `artifacts/v005-inputs/V005_R9_USAGE_REPORT.json`.

## V005 semantic Introduction / Kdenlive r10

- Brief revision 20, timeline revision 10, handoff `r10-20260925T205706Z-fac92e2c`; chưa render.
- Introduction 00:00–01:33 có 19/19 cảnh video. HOOK-01 dùng hai cảnh tàu leo núi; HOOK-02 dùng hai cảnh tàu chạy xuyên Maeklong; HOOK-03 dùng footage Qinghai-Tibet; câu “six railways” được tách riêng thành montage sáu shot theo thứ tự Pilatus, Maeklong, Landwasser, Qinghai-Tibet, Mauritania, Forth; HOOK-05 mở bằng công nhân thi công ray.
- Một clip Pilatus ngắn 9,48s từng bị MP2 chặn vì `source_in_us` 12s. Sửa về 7s và giữ compiler kiểm tra EOF; đây là bằng chứng cần probe duration trước khi chọn usable range.
- QA: 271 placement; 252 cảnh từ 01:33 trở đi giống timeline r9 theo asset, time, source range, transform và speed. Package thiếu 0 media, XML parse đạt. Music đều -8 dB; atmosphere -10 dB.
- Project: `artifacts/kdenlive/v005-impossible-railways-brief/builds/r10-20260925T205706Z-fac92e2c/V005 Impossible Railways - preview - MPCut.kdenlive`.
# Overlay and audio lane lessons — 2026-09-26

- **Preserve saved edits:** actual r10 differs from generated DB timeline: additional visual lane, hidden title lane, edited audio gains. Overlay service takes native file + SHA-256, keeps original playlists and locks them. Never regenerate the background montage for an overlay-only task.
- **Audio minimal tracks includes single-frame overlaps:** r10 music at frames25844/25845 and52032/52033 overlaps one frame. Preserve cue boundaries and use two music lanes; 16 original audio tracks become5, SFX6 become1. Do not silently shave cues to claim four tracks.
- **Kdenlive versus standalone MLT:** GUI-saved gen-5 nested entry filters triggered Melt XML parser warnings. Clone source per effected occurrence and move filters only in the standalone render graph, preserving source-coordinate keyframes. Native Kdenlive entry effects remain unchanged.
- **CLI profile:** a smoke run without `-profile` rendered150frames at25fps (6sec), despite the project's30fps profile. Use an explicit UHD30 profile; verify FFprobe duration/frame rate.
- **Bounded smoke graph:** initializing the whole 254-source package for a very short test hit90/120sec timeouts. Crop all playlists to the sample range and prune unreachable producers; the three representative exports then completed. These were bounded test processes, not a user full render.
- **Alpha fade regression (corrected after frame-by-frame QC):** affine opacity with `transition.b_alpha=1` produced an opaque black silhouette at fade start, including in MP4. A full-opacity frame had hidden the defect. Use native brightness fade_from_black/fade_to_black with RGB `level=1` and animated `alpha`; validate first, midpoint, full-opacity and last frames in the actual MP4. V005 fade-check.jpg now confirms transparency at both ends and gradual appearance.
- **Portrait assets:** Locher, Fowler, Baker sourced from Wikimedia historical publications; retain source/credit/hash, contain portrait aspect, do not generate a likeness. First generic Python download was rejected by automatic tool review; explicit public-file downloads succeeded. Browser downloadMedia opened the image tab and did not prove a disk download.
- **GUI verification limit:** Windows capture returned `SetIsBorderRequired / E_NOINTERFACE`; accessibility confirmed loaded tracks without missing-media/repair prompts. Do not claim GUI screenshots or a saved round-trip from this evidence.
- Templates/API execute the graphics and lane packing. Codex still supplied the editorial choices, VO anchors and source research in this V005 test; this is not proof of fully autonomous editorial planning.

## Native overlay import failure — 2026-09-26 user correction

- User saw empty overlay tracks although standalone samples contained graphics. Root cause: new producers were inserted before main_bin, which follows the sequence in saved r10. Overlay playlists thus contained forward references. MLT/Kdenlive resolves these during XML loading and discarded the unresolved entries.
- The standalone entry-effect conversion cloned sources before playlists, inadvertently fixing ordering only in sample renders. Track labels and standalone output were insufficient GUI validation. Previous claims that the native overlays were visible were premature.
- Fix: insert overlay media before its playlist/sequence. Added a regression fixture with main_bin AFTER the sequence and checked all native producer references precede use. Validate GUI save/reopen and retained 6/6/3 entries before delivery; never infer clip presence from track names.

## 2026-09-26 — Location box sizing correction

Location backgrounds now use actual Arial Bold glyph advances (Pillow), centered with 90px headline / 72px country padding per side at 4K, max width3240px. Explicit 700 weight matches measured font; previous 900 could choose a wider face. Updated only six location SVGs in the existing FIXED package after user saved Rough Cut. Native file hash unchanged f83fcece9a65ffb68538f25f5817bf4f2bd986320537e6dbb91a18ac956216ec. Facts/people untouched. All six rendered in Qt/MLT and visually reviewed; saved backup + audit + contact sheet.

- Updating referenced SVG bytes can trigger Kdenlive Clip Problems with status Reload for exactly the changed assets. Accept Reload for those verified six paths; this is not missing-media substitution. Preserve the user-saved native snapshot before reload.

## 2026-09-26 — Flow video audit: budget reservation and research gap

- Audit: `FLOW_RESEARCH_VIDEO_AUDIT_2026-09-26.md`. Existing Flow Kit clip is present and probes successfully; bridge readiness returns true after the user opens Chrome/Flow. No new generation submitted during this audit.
- Demonstrated offline failure: worker reserves 7 credits from a 7-credit budget, then passes remaining=0 to `generate_video_visual`, which raises `FLOW_CREDIT_LIMIT` before HTTP. Reservation must be passed as the clip allowance, independently of the remaining workflow balance. Status: identified, not fixed. Add boundary coverage for exactly one clip, insufficient budget, failed attempt and cached reuse before enabling automatic generation.
- Current adapter only submits text-to-video; `requires_reference=true` blocks generation. Reference endpoints existing in Flow Kit do not prove integration in MP2. Editorial prompts have no browsing tools; 3-frame visual review is not a mechanism/physics audit. Require claim-linked sources, verified references and temporal technical review for explanatory mechanical animation.
- Stored legacy max=1/credits=7 settings are not necessarily the effective automatic budget: `ai_budgets.resolve_budget` may scale caps by project duration. Inspect the effective request snapshot; do not report saved legacy settings as a guaranteed current spending cap.

## 2026-09-26 — Researched Locher video pilot

- Latest user correction: prioritize research → prompt → AI video, not coding an animation by default. A custom renderer is a fallback when needed, not the initial interpretation of the task.
- Actual CH1-05 VO 189.83–197.03s selected from revision 20 and word timestamps. ASME/Deutsches Museum supplied mechanism evidence. Packet/prompt/results: `artifacts/flow-locher-pilot-20260926/REVIEW.md`.
- Readiness was insufficient: real Flow Kit generation returned CAPTCHA_FAILED with ServiceNotAllowed host access error, no remote job. Do not enlarge extension permissions to the denial page. The currently accessible Flow `/u/2/` UI generated the authorized clip successfully, 8s 720p Omni 1.1 Flash, balance 250→238. Report UI fallback separately from MP2 integration success.
- Output looked polished and showed two horizontal pinions around the rack, but magnified 2s/5s contacts showed coarse rack versus fine pinion tooth spacing; technical acceptance withheld. Review geometry/contact and temporal motion independently of appearance and broad semantic similarity. Existing scene/timeline unchanged; sample retained for user review.
- Browser download-event wait timed out despite a completed MP4 in Downloads. Check expected recent files and probe them before repeating the download or generation.

## 2026-09-26 — Reference documentary corrections and completed bounded pilot

User keeps old MP2 pacing and holds global color/composition. Reporter with actual identity/background references is an explicit profile-specific exception to mechanism-only AI. Match footage sequences to the sentence function; moments do not force cuts. Prefer scene ambience/action sounds, no default whoosh. Reuse script prompt and abstract a reference structure for another event/place/era. Decision, API and limits in DOCUMENTARY_PROFILE.md.

Previously identified credit reservation bug is fixed and tested: pass reserved clip allowance, not balance after reservation. Flow Kit now has reference upload/media-ID submission and hashes in snapshots; mocks pass. Real reporter output used Flow UI with three attached references, not bridge. See artifacts/documentary-profile-pilot-20260926/REVIEW.md.

The live script draft transferred narrative grammar but introduced near-vertical gradient, ambiguous vertical rack, pressure-as-drive wording and absolute safety claims. Retain raw draft, review against primary evidence, correct script and strengthen profile instructions. Do not turn a historical design choice into a gear physically tipping during operation. Schema validation is not editorial approval. ASR verifies dialogue words, not voice quality or lip sync.

## 2026-09-26 — Reporter performance, script learning and GetHinh music preferences

User correction: reporter identity/location are fixed but performance is too stiff. New skill/playbook1.2 directs only 1–2 reporter passages per film, primarily the opening; rewrite selected unlocked narration as reporter-owned direct dialogue, avoid duplicate main VO, and prompt purposeful mic/gaze/pointing/crouching actions grounded in the script and visible objects. Update composed pose/prop reference when needed and preserve face/outfit/location. Do not imply this instruction update is a new tested video.

## 2026-09-27 — Minimal text, optical-flow slow motion, continuous ambience and fast intro

User correction for the Longyearbyen review cut: all added text must be minimalist white sans-serif with no outline, using a subtle shadow on dark footage or a ~50% black box on bright footage. Slow video needs optical-flow review rather than duplicated frames. Maintain context-appropriate ambience throughout, add motivated SFX, consider reviewed stock-source audio, and fade every cue. Preview GetHinh/Envato audio before purchase. The intro should use the strongest chapter video across landscape, people, work and culture at roughly 3–5 seconds per shot; an opening AI reporter may hold for the complete spoken line and must replace the corresponding narrator span.

User will supply script references separately; retain source-attributed narrative lessons from each, with topic-specific versus reusable decisions. When a brief does not identify an exact music file/item, proactively plan/search/select and download via GetHinh within project budget/access. Screenshot's five music groups are query examples, not a universal five-track score. Full prompt and cue workflow in DOCUMENTARY_PROFILE.md; mirrored into playbook and installed mp2-brief-edit skill. No new generation or audio download requested/executed in this preference-only update.

## 2026-09-26 — GetHinh Google Drive download correction
User explicitly corrected the download flow: on the Google Drive large-file page, click Download anyway, not the linked filename. Longyearbyen and Hiking originals downloaded successfully this way. Snowy Road and Polar Bear Warning returned Google 404 after that button; record as paid but unavailable, not completed acquisition, and do not repurchase blindly. A browser timeout alone is inconclusive: inspect final page and local files.

Correction after screenshot verification: the in-app browser's semantic/AX click on Download anyway was mis-targeting the filename link, so the five404s do NOT establish missing Drive files. Coordinate click on the visually verified button reached the real confirm-download URL, which ChatGPT blocked with ERR_BLOCKED_BY_CLIENT. Do not bypass that block. Preserve paid acquisition records; file availability unresolved, not provider loss.

## 2026-09-26 — Longyearbyen native review cut
Real MP2 brief revision3 assembled235 shots/232 sources at28:11.533. Local import mappings now live beside each manifest and are scoped per project; unrelated V005 map is preserved. MotionArray and web-photo provenance retained. Matching project/hash preview gates cover web photos and original explanatory graphics; normal-publication gates unchanged. Three scope tests and eight shot-plan tests pass.
Binding from a pre-import brief must carry master_file_id from the current imported voice, not replace the voice object with a planning stub. Source frames exposed a coal-cableway summer scene under the March8 card; native correction replaces it with a reviewed snowy Longyearbyen image and retains attribution. Source-title similarity does not certify season or action.
Measured voice active RMS was quieter than some music at -15dB; added source-coordinate ducking keyframes while retaining the base gain. Numerical checking and output frames are not listening or full-film review. Native overlays include10 chapter titles,4 place cards,5 fact/date cards, and two audio lanes. Keep native editorial edits authoritative; do not overwrite them by a blind DB recompile. Limits:40percent video, one intro still, failed reporter reference upload, publication rights unfinished. Evidence E:/UGC video/Longyearbyen-documentary/production-v01/.

Follow-up native sample QC: Seed Vault location card at1352s overlapped chapter title1351.867-1355.867. Cause: planning summary's chapter boundary lag differed from saved timeline. Fix card start1356.2 and add whole-project interval collision check covering chapter titles AND independent location/fact tracks. Do not validate only new cue-to-cue overlaps. Final original-source/voice settings remain unchanged; native title/card/ducking/season correction is authoritative over earlier DB snapshot.

## 2026-09-27 — Longyearbyen overlay metrics and scene-SFX correction

User review found text offset inside black backing, a box that did not cover the longer second line, excessive card density and missing in/out motion. Cause: the revision estimated width from character count and added no entry fades. Corrective invariant: calculate the exact Segoe UI/weight/letter-spacing glyph advance, add explicit even padding, default to lower-left, use a lighter 25–35% black backing on bright footage, add verified transparent fades, and audit chapter/location/fact intervals together. Longyearbyen v03 keeps 10 chapter cards, reduces locations to5 and facts to7, with zero interval collisions and two fade filters per entry.

The previous chapter ambience files were long loops, while several supposed SFX were treated as extended beds. User clarified that a scene effect normally covers one visual and at most two adjacent shots. Longyearbyen v03 uses the approved 30:16.5 train-project ambience once across the 28:11.533 timeline, then places10 short cues on verified segments for harbor water, aircraft ground handling, snow, pipe cutting, boots, exposed-valley wind, lab handling, cafe preparation, a hot-water pour and dinner preparation. Each cue has an exact frame range and0.4s fades in `SFX_CUE_SHEET.json`; future QC must compare that sheet to the actual visual range and reject any cue extending into unrelated footage. ASR detected an English production-direction phrase in the original seed-handling stock audio, so that cue was rejected and replaced; audio-stream presence alone is not approval.

## 2026-09-27 — Longyearbyen semantic intro, letterbox and still-run correction

User review found that an all-video intro can still fail when attractive footage is selected independently of the words being spoken. Treat the VO sentence or semantic clause as the binding authority: split the 3–5 second intro montage on the narration timeline, then select a recognizable visual for that clause. The reporter may hold for the complete opening line; the following montage must resume semantic binding rather than sample unrelated chapters.

Resolution metadata does not prove a clip fills the canvas. DCI 4K (4096×2160), 2K (2048×1080), 3840×1772 and similar wide sources will letterbox if fit-scaled into UHD. Every video occurrence must receive an explicit center crop-to-fill transform calculated from decoded width and height; pixel/sample review remains necessary for baked mattes. Do not call a source safe merely because its label says 4K.

The reviewed v03 body contained only 36.97% video duration and a maximum run of 19 stills despite earlier alternation guidance. Audit the actual saved Kdenlive XML in timeline order. For this documentary profile, keep still runs to at most two unless a user-approved exception is recorded, and target roughly 50–60% video duration with semantically attached replacements. Download queries must be derived from the exact VO gap; visually review sampled frames and reject keyword-only false matches before insertion.

For high-energy introductions, layer many short motivated effects without turning them into chapter-length beds: one cue per shot is acceptable when each cue is low, scene-specific, faded and starts after clean reporter dialogue. Preserve the continuous approved ambience separately. Longyearbyen v04 uses 21 post-reporter intro cues plus the existing 10 scene cues; the intro cues are bounded to their 3–5 second shots.

## 2026-09-27 — Tristan script delegation: measured length and factual review

Evidence: `artifacts/tristan-da-cunha-script-v01/REVISION_LOG.md`, original Gemini responses and validation files. Gemini Flash's first full narration claimed 3,879 words but measured 3,313; its next complete rewrite measured 5,678 despite the 3,700–4,000 request. Count spoken text separately from headings and notes before estimating runtime; model-reported length is not validation. The drafts also confused the 1962 survey party with the 1963 advance return and added unsupported historical sensory detail. A supplied fact brief does not guarantee factual adherence: check the actual prose, preserve raw drafts, and record substantive corrections without flattening the user's chosen dramatic voice.

One Antigravity call returned exit code 0 and SUCCESS with an empty response plus denied RunCommand. Treat this as an incomplete text task. Do not broaden permissions to obtain prose: embed necessary inputs and ask for a tool-free response. File reading, status and response content are separate checks. This lesson documents script drafting only, not a new MP2 production capability or permission to generate media.


## 2026-09-27 — Tristan stock substitution and voice correction
User chose documentary-american-low as main narrator for all chapters; GGFlow chooses reporter voice if used. Do not fall back to am_adam or automatically alternate British/American. Reference asset/hash must match saved documentary sample. User further authorized generic action footage for hard-to-source Tristan coverage (cargo transfer, factory interiors), historical1961–1963 stills, and maximizing video. Keep exact-geography establishing imagery separately supported and record generic footage as illustrative context. Reporter AI is backup, stock is the primary plan even for that span; do not submit a reporter generation merely because its reference/prompt is ready. Evidence: artifacts/tristan-da-cunha-production-v01/production-control.json.

## 2026-09-28 — Tristan native Resolve migration and mixed-rate trims

Evidence: artifacts/tristan-da-cunha-production-v01/builds/resolve-v01/native-v03-verified.json, manifest-v03.json, MCP readbacks and seven real Resolve QC exports. In-app bridge on installed Resolve 21.0.2.4 connected after Workspace > Scripts > resolve_bridge. Reused the empty Tristan da Cunha project; preserved other productions.

FCP7 XML v01 preserved record timing but interpreted mixed-rate source in incorrectly. Fix verified in v02: clipitem rate and in/out use timeline 30 fps; the file media retains its actual source rate. Validate file path AND file-relative source seconds after import, not only timeline start/duration. V01 remains an explicitly obsolete checkpoint. Source end readers may reflect last displayed frame at timeline cadence, so source-in accuracy and duration are separate checks.

Native AppendToTimeline on this installed build required endFrame = startFrame + requested source-frame span for the six tested video additions. Subtracting one made the 29.97 fps test one timeline frame short. Remove only that newly inserted test item, correct the interval, and read back exact timeline duration before admission; do not infer frame-bound conventions from another import path. This is a measured build-specific result, not a universal API promise.

Render preparation rejected a non-temp output directory until require_temp_target=False was explicit. A verbose settings payload also returned false; the available H.264 Master preset with supported essential settings produced valid H.264/AAC. Pin the base video preset and verify actual file streams/duration; a queued/completed job alone is insufficient.

Saved, closed and reopened native v03: 90 visual items, full American VO, 16 Fusion moving stills, no missing media/path/record-timing errors or repeated sources. Seven short exports were decoded and first/middle/last frames inspected. This verifies the partial assembly and sampled imagery, not listening, full-film editorial review, publication rights or a complete documentary. Current visual coverage is 494.667/1451.967 seconds; 957.3 seconds remain unfilled. Native v03 is authoritative for subsequent edits; do not overwrite it from the older Kdenlive or DB state.
# Tristan Resolve batch lessons — 2026-09-28

- Native Resolve bridge `GetItemListInTrack` followed by per-clip `GetStart()` inside every append iteration created roughly 16,000 TCP TIME_WAIT sockets and failed with WinError 10048 after 33/67 new shots. Build one start-frame index per batch, check the returned appended clip directly, checkpoint, then resume idempotently. The corrected run completed all 67 and native readback matched the saved manifest.
- Mixed 23.976/25/29.97/60 fps originals did not always permit an exact requested number of frames on a 30 fps timeline (first failure: Pexels 10039761 requested 194 frames). Conform the selected source range at normal playback speed to CFR 30 before importing; probe the intermediate and verify timeline item duration after append. Do not mistake normal frame-rate conforming for a slowed clip.
- A still-image `zoompan` expression based on `zoom+...` with `d=1` showed effectively no visible motion (mean start/end frame difference 0.003/255). Use the output-frame counter `on` for a bounded 2–2.5% zoom and inspect decoded first/last frames for visible slow motion and black borders. The corrected test differed by about 21/255 with no exposed canvas.
- User correction: low-resolution source photos used in the timeline must be enhanced first. For seven 250–500 px Tristan archival/official images, preserve the original, generated result, hashes and source page, then blend a restrained AI reconstruction (15%) into a 4x source-anchored upscale. Check dates, printed text, people and historic objects against the original; label them AI-enhanced, never newly recovered historical detail. The v06/v07 media ledgers keep still-derived MP4s classified as images for duration share.

## 2026-09-28 — Tristan v17: lessons still missing from playbook 1.2

- **Source first, then batch assembly with interval coverage gates.** An earlier user review found a long empty-looking 11–19 minute stretch and requested bulk sourcing before more piecemeal edits. Build a VO-beat/source matrix for the full film, acquire the missing groups in batches, then audit coverage by chapter and fixed time window as well as by whole-film duration. The final native v17 has zero V1 gaps and 69.53% actual video frames; the 11–19 minute window measured 69.08% video. A global quota alone cannot reveal a local visual desert. Status: final coverage verified; workflow rule proposed for the next playbook.
- **Read actual native clip boundaries after every timeline mutation.** v13 still contained eight video tails below 2 seconds, including 3- and 6-frame fragments, despite a compliant total video percentage. v14 consolidated the continuations with their preceding source shots and read back zero sub-2-second video clips without moving VO or changing total duration. v16 separately replaced a repeated image tail whose combined source hold was 9.4 seconds. Check same-source adjacent occurrences, per-shot limits and gaps against the saved native timeline, not only the planning manifest. Evidence: `qc/v13-titles-and-native-readback-qa.json`, `qc/v14-native-shot-length-qa.json`, `qc/v16-panorama-and-native-readback-qa.json`. Status: fixed and native-verified.
- **Reconcile asset ledgers with the native timeline before claiming a source is unused.** During the v16 still replacement, `reviewed-stills-ledger.json` had `timeline_used:false` for photos that were already present at 138.6–142.5s and 1173.3–1181.2s. Use canonical source identity across original, restored, pan-render and re-encode, then refresh usage from the latest native/manifest readback. A stale planning flag is not permission to reuse. Status: failure observed; general reconciliation gate not yet implemented.
- **Resolve needs its own roundtrip rules.** An open Resolve process did not prove its in-app scripting bridge was active. Batch append also failed after excessive per-clip TCP readbacks; one batch start-frame index avoided the socket exhaustion. Mixed-rate trims needed selected-range CFR30 intermediates for exact 30fps timeline frames; still/title PNG duration was unreliable, so exact-frame video intermediates and ProRes4444 alpha titles were used. At each batch checkpoint save, export a DRP/XML snapshot and independently read back track counts, source ranges, timing and media links. Do not infer Resolve success from API return values or a track label. Evidence: `builds/resolve-v01/native-v03-verified.json`, `qc/v13-titles-and-native-readback-qa.json`, `qc/v17-native-wind-qa.json`. Status: methods verified for this installed Resolve build, not universal API guarantees.
- **Audio stream, speech test and reuse rights are three different gates.** Of 176 stock videos, 36 had embedded audio streams; selected candidates were screened for speech, but their embedded audio was not reused because provenance and provider permission remained uncertain. No-speech ASR is not a license check. For purchased/free ambience, keep the source location truthful: the v17 wind recording is from Fisterra, not Tristan. Status: screening done; stock audio use withheld.
- **Measure the actual trimmed audio cue and distinguish numeric/proxy QC from native viewing/listening.** The v17 wind source was much louder overall than its first selected 82 seconds: a gain chosen from full-file integrated LUFS produced a −55.2 LUFS cue, then selected-window calibration reached −41.3 LUFS. Check the processed range and its VO/music overlap, not only master-file loudness. The ending mix has a numerical −25.3 LUFS / −8.5 dBFS true-peak check, and nine title proxy composites look legible, but full listening and actual Resolve viewer inspection remain pending after Gallery export failed. Status: numeric/proxy checks done; perceptual/native approval open.

## 2026-09-28 — V005 feedback revision: relative overlay assets

Evidence: `E:/Youtube AI/MoneyPrinter2/artifacts/kdenlive/v005-impossible-railways-brief/builds/feedback-20260928-r6/`. The r5 Kdenlive revision was made from the user's saved native project with valid XML and existing original media, but its root moved to a new build directory while 15 overlay SVG resources still used `graphics/*.svg`. A native melt frame logged `Could not open input file qimage:.../feedback-20260928-r5/graphics/...`. Cause confirmed: the new build omitted that relative directory. Fix: copy the original `graphics` directory into every revision during build, then verify paths relative to the new project root. The r6 4K frames at 60 and 96 seconds rendered; chapter LOCATION text appeared, and render logs had no missing-file errors. Remaining limit: these are frame samples, not a full-film export or GUI save/reopen review.

## 2026-09-28 — V005 feedback revision: producer order on native save

Evidence: `E:/Youtube AI/MoneyPrinter2/artifacts/kdenlive/v005-impossible-railways-brief/builds/feedback-20260928-r7/`. r6 placed eight continuous music cues across two playlists. The XML contained all eight and Melt rendered the transition, but Kdenlive's first native save kept only six: playlist2 ended after cue 02 and dropped cues 04/06. The cue 04 chain was declared after playlist2, so Kdenlive could not resolve that entry while reading the playlist and discarded the remainder of that lane. Fix confirmed in r7: move all eight music chains before playlist2, open in Kdenlive, reload changed audio, save, close and reopen. Native readback retains four cues on each lane (8/8), 267 visual entries and all referenced media. Final saved native 96-second frame renders identically to the pre-save overlay check. Remaining limit: no full-length export or full-film listening.

## 2026-09-29 — Rapa Nui GetHinh retry and wrong-content verification

Evidence: `E:/Youtube AI/MoneyPrinter2/artifacts/rapa-nui-heritage-production-v01/planning/gethinh-incident-20260929.md` and linked screenshots, delivered-file checks and cost ledger. FAYNLME previously sat at “Đang tải” after a JavaScript error; LJSM9AK had shown a browser-service failure. The user's correction identified the complete retry sequence: “Thử lại” → “XÁC NHẬN VÀ DOWNLOAD” → “Tải về”. After checking that neither attempt had charged xu, both clips were eventually delivered and their frames, duration and codecs verified. Cause of the earlier stall remains unconfirmed; an error or long processing state alone did not prove permanent failure.

GetHinh then displayed Envato VVVN2AA as completed and charged 1 xu, but the downloaded file showed a man in a vineyard instead of the previewed Rapa Nui moai. Cause of the provider mismatch is unconfirmed. The file was quarantined and excluded from the film. Check the actual decoded content against the source preview after every download; an on-page ID, success state, matching extension or working media container is insufficient. Stop further provider orders when a wrong file is returned. User's prior 100-xu cap authorized the agent to click through the GetHinh transaction itself; no extra human click was required. Remaining limit: VVVN2AA has not been supplied correctly and the 1-xu debit remains recorded.


## RAPA-ORIENTATION-20260930
- Project: Rapa Nui; stage02.
- Evidence: planning/portrait-correction-20260930.json; SH039360x640, SH0531080x1920, SH311B1440x2560.
- Cause confirmed: semantic review accepted portrait SASIPA videos and proposed a panel without enforcing landscape film format.
- Fix: reject and unbind3originals, retain provenance, bind reviewed landscape sources; container transfer uses an authentic landscape still followed by landscape barge video, cut at the measured onto phrase. Still remains counted as still.
- Check: stage02audit passes; zero portrait video sources bound. Full source gate, stage03quality preparation and native viewing still pending. Status: corrected source plan, film not assembled.


## RAPA-NATIVE-QC-20261001 — Resolve21.0.2.4 / MCP4.8.22

Project: RapaNui, timeline4K30/51073frame. Các lỗi dưới đây đã được tái hiện và sửa; không suy từ mock.

- Geographic mismatch: SH001globe nhìn IndianOcean thay Pacific. Fix authored NaturalEarth Pacific locator giữ2.9s; first/mid/last và native108043đã xem. Evidence opening-map-correction-20261001.json,stage05-native-gate-20261001.json.
- Bridge handle eviction: lookup lặp quét pool làm cache4096evict refs. Fix one-pass path index và bounded native batch; actual349clip readback match plan. Evidence scripts stage05/stage07 + resolve-native-video-final-20261001.json. Cause: repeated traversal confirmed from code and observed stale references.
- PNGlogo shortened: requested51073frame, actual150. Fix remove only new failed item and exactfullfilmProres4444alpha; nativeV4fullspan. Evidence stage07-native-graphics-20261001.json. Limitation: rendered overlay, editable JSON/PNG sidecars, not nativeText.
- Burned source text: nativeChapter7Spanishsubs triggered review40nonstockranges. 13derivatives cropped with original+provenance retained, all first/mid/last viewed, native representativeframes rechecked. SH288stricter.77bottom needed after .83left partial lyrics. Evidence stage08-source-text-corrections-20261001.json,stage08-native-corrections-20261001.json.
- Wrong generic context labels: 13verified RapaNuiheritagephoto slots excluded genericIllustrativefootage; native139cards after merge, all exactpositionsreadback. Evidence stage07-overlay-plan-20261001.json,stage08-native-preflight-20261001.json.
- Render settings rejected: SelectAllFrames=false and numericVideoQuality45000 returnedfalse on21.0.2.4. Isolated probes; accepted pinned H.264Master + explicitMarkIn/out/H264/AAC48k. Actualnative30sexport900frames,4K30,decodeEOF,I−15.5LUFS,TP−1.8dBFS. Evidence stage08-render-setting-probe-20261001.json,stage08-short-native-render-qc-20261001.json. Full render ongoing at lesson release; full auditory/watch QC not passed.

Status: corrections implemented/native sampled; full export independent check still required. User revoked quota shutdown: helper exits immediately, no matching Pythonprocess, progress false. Do not restore from old shutdown history.


## RAPA-VISUAL-REVISION-20261001 — sửa theo người dùng

Evidence: artifacts/rapa-nui-heritage-production-v01/revisions/v02/still-motion-ledger.json, original-core-alignment.json, motion-review/pending-170631-{1..5}.jpg, native-visual-takes-*.json, native-visual-qc.

- User thấy ảnh thiếu 16:9, thiếu pan/zoom, giấy tờ sai nền; thumbnail không có người như sample. Fix: outpaint ngoại vi, gốc overlay, slow pan/zoom 4K30, 14 nguyên trang giấy tờ trên historical texture; 6 sơ đồ giữ nguyên chữ. Thumbnailv2 có người tương tác, saved final+prompt.
- Demonstrated AI core redraw/color seams: SH032/046/065/311A. SIFT thực + gốc overlay + margin grade. Năm vị trí đã xem; SH065/311A pass/native. SH032/046 tiếp tục xử lý, không coi tự động pass. User correction requires remaining184-placement gate.
- Native take replacement đã readback139 cảnh, exact start/end/properties; 12 audio items unchanged. Eight native composite samples đã xem. Full revised export chưa chạy khi phát hành bài học này.
- Audio diagnostic so sai reference window: requested20..50s nhưng file thực0..30s; report đã invalidated. User01/10 nói không chỉnh VO; giữ hiện trạng và bật lại A1–A6. Không tuyên bố nhiễu đã hết.

Limitations: 184-photo and full export QC recorded independently as work completes. No quota shutdown, no publication.


## 2026-10-02 — Tristan v28 live rebuild and cleanup

# Lỗi đã đo và sửa — Tristan v28, 02/10/2026

Không lấy số cảnh, timecode hoặc mức dB của phim này làm mặc định phim khác. Các quan sát dưới thuộc Resolve Free 21.0.2.4 + bridge MCP 4.8.22. Evidence gốc ở hồ sơ Tristan v28; bản tóm tắt và frame được đóng gói ở đây.

## Native source end lệch một frame — đã xác nhận
`GetSourceEndFrame()` trả endpoint không nhất quán với một số media đã import: đoạn 168 frame trả 168, đoạn 118 frame trả 117. Nguyên nhân nội bộ API chưa xác định; không mặc định cộng/trừ 1 cho toàn bộ media. Cách kiểm đã đo: source-end-exclusive = SourceStartFrame + round((SourceEndTime − SourceStartTime) × media FPS). So timeline duration và prepared range; vẫn phải thử một đoạn trên build thật. 289 source bindings v28 khớp theo cách kiểm này. Source FPS khác timeline FPS phải giữ riêng.

## Fusion template cài được nhưng không chạy — đã xác nhận
Candidate dùng KeyFrameStretcher gây modal Unknown tool RetimingKeyFrameStretcher và ngăn bridge tiếp tục. File-installed không phải native-verified. Đã thay bằng graph TextPlus/transparent Background/Merge/Transform với XYPath và Bezier alpha, không KFS. 20 title center editable đã có native in/hold/out proof; bad candidate cũ được xóa đúng một file do project tạo. Không xóa thư viện template khác. Xem [frame v28](../visuals/TEXT_V28_NATIVE.md). Đây là biến thể native đã kiểm, chưa phải style được user duyệt làm mặc định.

## Audio có stream nhưng không có tín hiệu — đã xác nhận
Một số source factory/social có stream PCM nhưng thực sự digital silence. Cần đo selected range; không suy từ tên file/stream tồn tại. Đã thay ambience phù hợp và disable local-sound silence, giữ 16 local-source đoạn có tín hiệu. Nhạc/ambience có file phủ đủ chưa chứng minh mức nền liên tục: quiet head/tail và overlap có thể tạo chỗ hụt. Đã kiểm actual PCM sum của cue theo offset/loop/crossfade toàn duration, sửa 1s ambience đầu bằng texture thật cùng nguồn rồi kiểm lại. Một sample native Resolve 12s kiểm engine placement/peak; không báo đã nghe thủ công toàn phim. Threshold số trong evidence là phép đo phim này, không preset âm lượng chung.

## Dọn bản cũ cần bảo toàn cả hồ sơ — lỗi đã xác nhận
Relink mọi media dùng trong timeline mới sang vị trí được giữ, SHA-verify trước xóa; giữ cả source original/license/generation records và source-timeline của title lồng. Đồng thời phải copy đầy đủ word-map, clause/sentence map, pause map và hồ sơ nguồn **trước** xóa revision cũ. V28 đã giữ đầy đủ clause/sentence/final cut anchors nhưng thiếu copy full per-word archive, khiến archive đó bị xóa. Không dựng lại timestamps giả: hiện lưu rõ partial measured anchors; master Cao nguyên vẹn được giữ, có thể đo thêm từ cần dùng khi edit sau. QC/current profile phải kiểm tất cả record paths tồn tại, không chỉ media files. Old folder chứa nguồn hiện hành không được xóa nguyên folder.

## Tham số export/capture — đã xác nhận trên build này
Capture frame PNG chạy; JPG codec không khả dụng ở đường capture đã thử. SetRenderSettings với VideoQuality=2000 bị từ chối; phải đọc bool và chỉ dùng key/value đã được build nhận. Sample MP4 12s chạy với bộ setting còn lại. Pin MarkIn/Out explicit, sau sample trả range/target đúng và mở Edit. Không xuất full để chữa capture hoặc thử template.

## Bàn giao và ngoại lệ
V28: 289 cảnh, 69.58% video, không gap/offline, 29 animated cards, 19 ambience files; saved/open timeline, user review pending. Intro vẫn giữ 4 ảnh đúng địa điểm — ngoại lệ biên tập có ghi rõ, không coi all-video intro đã pass. Chi tiết mềm của ảnh tư liệu lịch sử không được nâng cấp thành bằng chứng hiện đại. Không export full.


## 2026-10-02 — Output folder omitted at Tristan handoff

{
  "date": "2026-10-02",
  "project": "Tristan da Cunha",
  "cause": "Delivery metadata left final_output_folder null while only timeline/workspace was handed off; export restriction was handled without product-folder preparation.",
  "fix": "Created 2026-10-2-Tristan-da-Cunha with 431-cue SRT, 9 chapter timestamps, locked script and summary/manifest; updated profile/progress. No media/project moves, no full export.",
  "verification": "Caption text equals selected script tokens; measured frame bounds monotonic and within48196; files/profile folder read back; thumbnail/prompt not produced explicitly recorded.",
  "status": "corrected_folder_and_records; thumbnail/prompt pending; MP4 awaiting user self-export"
}


## LR-DOC-GRAPHICS-20261002

User explicitly rejected sparse two-circle graphic at La Rinconada C108. Cause confirmed: content labels were correct but physical subjects/context and informative documentary visual structure were missing. Evidence: four user images, project sources/documentary-style-references, generated-image run IDs and documentary-image-replacements.json. Fix implemented for ore and pressure plates: ChatGPT image generation, corrective review, original retention and editable-label blueprints; other cards still require review. C108 reading duration raised2→6s within its original clause, coverage/share unchanged. Native assembly and full-film style completion pending; no fake pass.


## LR-PRESERVE-EXPAND-20261002

User corrected overly broad image-generation interpretation: fitting images should remain, with expansion when needed. Cause: style audit had labelled every non-generated graphic as a mandatory style replacement, without per-image decisions. Fix: separate existing-image review, preserve/expand, and demonstrated replacement cases; do not generate all remaining graphics. Evidence: user clarification and stage03 per-image review records. Also rejected Willer restoration because roof/glacier detail changed, retaining genuine original. Generated clean plates, framing samples and actual native results remain separate; full-stage03 and native assembly are still pending.


## LR-ZOOMPAN-ASPECT-20261002 — preserve proportions before motion

Demonstrated failure: prepared v01 zoompan outputs from portrait/square photographs stretched the scene and retained an edge credit that the intended crop should have excluded. Cause: zoompan derives crop width and height from input width/zoom and input height/zoom; an output size of 1920x1080 alone does not make the source crop 16:9.

Correction: create an aspect-correct 16:9 input canvas before zoompan. The La Rinconada v02 helper scales to 3840px width and pads to the right/bottom only, computes zoom using that canvas width, and keeps every visible crop wholly within the original source. Padding is a computation canvas, not visible blur/black framing. Source-coordinate crop bounds, first/last and intermediate samples must be checked; never use output dimensions as proof of undistorted content.

Evidence: tools/render_reviewed_photo_motion.py; evidence/stage03-photo-motion-output-review.json and .jpg; planning/stage03-photo-motion-plan.json in la-rinconada-production-v01. Six corrected derivatives passed CFR/frame-count and full EOF decode, with five decoded output samples per derivative visually inspected. Originals retained. Scope excludes continuous manual viewing and native Resolve playback; credits and native smoke remain pending. Still-derived MP4 remains quota_class=still.


## LR-DECODED-INPUT-TRUTH-20261002 — actual media before metadata

Observed failures: Pexels7781741 advertised a1920x1080 variant but the downloaded file decoded1280x720 and was byte-identical to the existing original. A crop designed against advertised dimensions extended below the real image and FFmpeg silently shifted/clamped it. The corrected bounded crop still showed bright gardening gloves and green ground; it was rejected for the cold manual-work clause. Do not conflate this with5998380: that crop was geometrically valid but rejected for modern-office/knee composition.

Validate decoded width/height before calculating every crop. Assert x>=0,y>=0,width>0,height>0,x+width<=decoded_width,y+height<=decoded_height. Metadata, file name and output1080p size are not proof of a higher-resolution original, correct framing or suitable content. Record actual bytes/hash and review prepared outputs. Evidence: evidence/pexels-7781741-resolution-mismatch.json and sources/stage03-care-administration-crop/samples.json; the eight selected crops have actual bounds checks and five prepared-output samples each. Native proof remains pending.

Official-document URLs ending.pdf returned HTML: the former GOREPuno link gave the2026 site shell and MEF gave a non-PDF response. PyMuPDF's auto-detection opened the.part HTML as a one-page non-PDF, so page-count alone was misleading; the falsely classified PDF record was corrected before use. Retain rejected responses, verify PDF magic/content type and explicitly parse bytes with filetype=pdf before citing or rendering a downloaded document. Do not treat successful HTTP status or extension as evidence. Do not bypass access challenges. A separate public official gob.pe multiannual POI2025–2027 was downloaded and verified as113PDF pages; only a bounded project-title excerpt fromp107 was used. It corroborates planning, not completion and not the annual budget's amounts. Evidence: evidence/gore-puno-2025-download.json, mef-budget2025-download.json, gore-puno-official-multiannual-download.json, and actual source excerpts in la-rinconada-production-v01. Distinguish annual/multiannual source scopes.


## LR-GRAPHICS-NECESSITY-20261002 — life before explanatory cards

User correction: a documentary about residents had too many unfamiliar conceptual graphics. The draft had135 graphic placements,689.82s of1944.63s (35.47%). These are planned placements, not a native film. Factual relevance alone does not establish editorial necessity. Decide whether a graphic helps the story before generating, expanding or restyling it. Prefer authenticated place views and compatible labor/domestic action with truthful provenance. Keep only useful mechanism/numeric explanations; avoid repeated source-scope cards. Preserve locked VO unless the user directs a script change. Two generations already running when the correction arrived were retained as deferred candidates, not automatically bound. C028's unnecessary2s household card was replaced by a reviewed cooking detail from the measured197.58 meal onset; the plan is now134graphics/687.82s, so reduction remains incomplete. Do not claim the excess has been resolved. Evidence: planning/editorial-graphics-reduction-review.json, evidence/stage03-domestic-cooking-candidate.json and five decoded prepared-output samples. Generic stock is not an actual La Rinconada kitchen.

## LR-PLANNER-DEPENDENCY-20261002 — validate, reorder, then audit

Four replacement records lacked provenance and the planner raised KeyError. Validate required provenance before registration mutation. After semantic time changes exchanged adjacent C137 placements, the planner's earlier sort left them in obsolete order and the audit reported three gap/overlap errors. Sort again after all timing overrides, preserving stable IDs. Re-run the actual plan and audit:335raw/334merged shots, no gaps/errors. The audit previously returned exit0 even with semantic errors; it now writes evidence then exits nonzero when errors exist. Run dependent refreshes sequentially with subprocess check=True and inspect report status as well as process success. A stale audit after failed planning is not current proof. Source/content preparation and native Resolve remain pending. Evidence: stage03-replacement-provenance-correction.json, stage03-planner-order-correction.json and full-picture-source-audit.json.


## LR-VIDEO-FIRST-USER-20261002 — project override

The user explicitly requested a complete visual revision: more video; graphics only for mechanisms or numeric explanations; still photographs only when suitable footage cannot be found. For this film this supersedes the former50–70percent video ceiling. It does not relax source provenance, no conflicting geographic cues, canonical no-repeat,2–10s video/8s still limits or the locked VO. Simple dates/source credits should normally be short overlays on video rather than repeated full-frame cards. Stop generating images to fill every abstract clause. Retain prepared artwork as optional candidates and originals; do not discard assets or call the legacy picture plan ready. Search reviewed unused local video first, then authorized Pexels API/GetHinh Envato/Vecteezy within budget. All music/SFX/ambience remain Envato-only. Record genuine unsuccessful suitable-video searches before fallback photographs. Evidence: planning/video-first-editorial-policy.json and video-first-graphics-replacement-deficits.json.134legacy graphic placements are queued for necessity review/replacement; the work remains incomplete and no native timeline is claimed. This is a film-specific user override, not a new mandatory default for every documentary.


## 2026-10-03 — La Rinconada native corrections
Measured IDs LRN-01…08, causes/fixes/verification/limits and native evidence: [record](../LA_RINCONADA_NATIVE_FIXES.md). Final editable timeline handoff; no full export or subjective listening claimed.


## 2026-10-03 — location-first and UHD timeline user corrections
[Cause, corrections, proof and in-progress limits](locality-and-4k-summary-ver24.md).
