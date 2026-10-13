# 05 — Dựng hình hàng loạt theo đầu vế

## Đầu vào
01–04 đạt: clauses, VO→timeline map, prepared bindings toàn phim, native checkpoint. Không bắt đầu với timeline thiếu hình rồi vừa tìm vừa ghép từng đoạn.
## Việc làm
1. Duplicate timeline/checkpoint để giữ sửa tay, dùng timeline/output 4K đã kiểm ở 04. V1 hình, V2 text/đồ họa, A1 VO; audio ở 06 theo thứ tự track A1 VO → A2–A3 nhạc nền → A4 ambience → A5+ SFX/âm footage gốc. **Intro 10–20s chỉ video + music + SFX, không VO**. Dựng montage mở đầu tạo sức hút và hé lộ những nét đặc sắc nhất của toàn bộ nội dung đã chốt: cảnh quan, thiên nhiên, con người, văn hóa, hoạt động kinh tế và các vấn đề hoặc nghịch lý nổi bật sẽ được khai thác, tùy chủ đề từng phim. Chọn footage giàu sức gợi, có tác động thị giác mạnh, nối thành chuỗi highlight có nhịp điệu và cảm xúc thống nhất; ưu tiên những hình ảnh tiêu biểu giúp người xem cảm nhận bản sắc và tò mò về câu chuyện, không bắt mọi phim có cùng danh sách cảnh hoặc phải nhồi đủ mọi khía cạnh. Kết hợp SFX và ambience Epidemic phù hợp với hành động/không gian để tăng cảm giác chân thực, giữ đúng provenance; chuyển hình và âm nhạc tự nhiên sang phần kể chuyện có VO. Audio hiện trường gốc của footage tách sang track `Local sound effect` và để nghe được ở mức vừa phải (xem 06 mục 6). Được tái dùng footage thân phim làm teaser, ghi canonical và ngoại lệ intro. Đo duration thật, đặt lời đầu sau intro; map intro + pause áp dụng đồng bộ vào hình/text/audio/caption/chapter, giữ master nguồn.
2. Lập native/media-pool index một lần. Append các batch từ scene ledger: record anchor đầu vế, source-in/out đúng, path/source ID/canonical kind. Từ cue trả về, kiểm duration/binding; retry theo ID/start/source để không chèn trùng.
3. Footage mới ở đầu vế; cảnh phải diễn đạt ý đang được đọc, có nối nghĩa trước/sau. Không volcano khi VO chưa nói eruption; teaser chỉ khi intro được lên plan có chủ đích. Vế rất ngắn cùng ý có thể dùng chung shot ≥2s; vế dài thêm cảnh phụ tương thích trong shot limit.
4. Video 2–10s/cảnh, ảnh ≤8s/cảnh. Gate trước đặt ảnh: ảnh phải đúng 16:9 và đủ nét theo quy tắc xử lý ảnh ver 32 ở 03 (ảnh gốc đạt dùng trực tiếp; ảnh sai tỷ lệ/kém chất lượng dùng bản AI đã qua C4). Motion ảnh thực hiện **trực tiếp trong DaVinci Resolve**: đặt bản ảnh tĩnh đã chuẩn bị (ảnh gốc đạt, hoặc bản AI đúng tỷ lệ) lên timeline, keyframe Zoom hoặc Position trong Inspector/Fusion; giữ motion editable trong project. Không render sẵn pan/zoom thành MP4/MOV bằng FFmpeg zoompan hay công cụ ngoài để thay cho keyframe native. Mỗi ảnh một motion: pan trái/phải giữ Zoom và trục dọc cố định, hoặc zoom in/out giữ tâm cố định; chuyển động chậm nhưng nhìn thấy rõ, interpolation liên tục, không làm tròn vị trí theo pixel/frame. Tính cover/overscan cho toàn đường đi trước frame đầu, giữ chủ thể/chữ và không lộ vùng đen. Xem playback liên tục toàn shot ở tốc độ timeline và kiểm một dải frame liên tiếp để phát hiện rung/giật hoặc bước nhảy bất thường; ảnh đầu/giữa/cuối và metadata chỉ hỗ trợ kiểm crop, chưa chứng minh motion mượt. Ghi phạm vi đã xem và evidence native; chưa kiểm được thì ghi pending, không fallback sang motion render sẵn. Không chia cùng ảnh thành các clip liên tiếp để lách hold. Tránh lặp canonical source phần chính; teaser intro ghi ngoại lệ. Không đổi source count thành mục tiêu cứng.
5. Sau batch save, native readback path/start/end/source seconds/speed/fps; backup ở workspace. Không quét toàn pool/timeline cho từng clip, không giả progress dựa requested params.
6. Audit toàn khoảng hình, gồm pause chuyển chương: union intervals không gap/offline/EOF; video share đo theo source kind, ưu tiên video phù hợp; ảnh chỉ khi thiếu video phù hợp, không chuỗi ảnh vô cớ. Tỉ lệ dựa visible time và original kind, không chồng track tính gấp đôi. So native cut với clause map và evidence review đầu vào.
7. **Clip có viền đen sẵn (`black_bars: yes` ở 03):** khi đặt lên timeline, vào Inspector → Transform, đặt **Zoom** (X=Y) bằng giá trị `zoom` đã ghi; chỉnh Position Y (letterbox) hoặc X (pillarbox) nếu cần để giữ chủ thể/mặt người trong khung. Xem 1 frame: bốn mép không còn dải đen là đạt. Không kéo giãn méo hình, không dùng blur nền để che.

## Motion ảnh bằng Fusion native — quy trình tái sử dụng

Đây là cách triển khai ở bước 05, áp dụng theo ảnh, fps và thời lượng của từng phim; không phụ thuộc địa điểm. Hướng dẫn chi tiết, API đã đo và helper nằm trong [technical notes — Fusion native](../reference/TECHNICAL_FIXES.md#fusion-native-photo-motion).

1. Checkpoint trước khi sửa. Đọc clip ID, record start/end, duration thực, source range, Inspector properties và Fusion comps hiện có; giữ VO/audio/intro/sửa tay ngoài scope. Dùng ảnh gốc hoặc plate **tĩnh** đã review, aspect đúng khung; import từng ảnh và đọc lại path/type=Still. Không dùng frame của clip motion cũ nếu ảnh gốc phù hợp còn có; nếu phải lấy frame giữ crop/composite đã duyệt, ghi lineage và kiểm rằng PNG chỉ một frame, không còn motion.
2. Tạo graph native `Photo (ảnh tĩnh) → PhotoMotion (Transform) → MediaOut`. Trên clip ảnh mới có thể dùng MediaIn; khi cần giữ nguyên slot video cũ, dùng nguồn PNG tĩnh thay toàn bộ nhánh hình cũ trong Fusion, **không đặt Transform lên video đã bake motion**. MediaPool carrier có thể vẫn trỏ video cũ: ghi riêng carrier path và active photo path, không khai báo đã thay take nếu chưa thay.
3. Đo miền thời gian Fusion bằng smoke test. Với clip N frame và miền local 0-based đã kiểm, keyframe tại **0 và N−1**, giữ ảnh đủ N frame. Pan: keyframe `Center.X`, giữ `Center.Y` và `Size` cố định. Zoom: keyframe `Size`, giữ `Center`/`Pivot` cố định. Dùng native BezierSpline/XYPath với linear interpolation để có vận tốc đều; không làm tròn vị trí theo pixel. Không cộng thêm Dynamic Zoom, Inspector pan/zoom animate hoặc motion bake; kiểm properties hiện có để không tạo hai chuyển động.
4. Tính cover trước motion. Với plate đầy khung 16:9, tâm chuẩn hóa `(cx,cy)`, scale `s`, cần `cx−s/2≤0`, `cx+s/2≥1`, `cy−s/2≤0`, `cy+s/2≥1` trong suốt đường đi; source/crop/aspect khác phải tính lại. Ví dụ đã kiểm: zoom `1.03↔1.12`, tâm `(0.5,0.5)`; pan scale `1.12`, Y=`0.5`, X=`0.458↔0.542`. Đây là điểm khởi đầu tùy bố cục/thời lượng, **không preset bắt buộc**; kiểm chiều di chuyển trên hình thực, giữ chủ thể/chữ và margin ở endpoints/cực trị.
5. Import comp hoặc sửa native tools; đọc lại source PNG, node nối ra MediaOut, số comp, `Size/Center` tại 0/25/50/75/100% và keyframe/spline editable. Export `.comp` để lưu bằng chứng graph; xác minh ảnh vẫn là một frame được hold đủ, source path có thật, không EOF. Không overwrite Fusion chỉnh tay/graph khác; nếu clip có comp sẵn, checkpoint và sửa đúng nhánh hoặc tạo bản thử được bảo toàn.
6. Kiểm bằng native render/playback **toàn thời lượng mỗi shot**, cùng các frame liên tiếp; pan kiểm bước dịch trục X/Y, zoom kiểm scale/tâm và bước đổi hình liên tiếp. Có thể render proxy QC ở workspace, nhưng timeline/output vẫn 4K. Xem đầu/giữa/cuối để kiểm nội dung/crop/viền, không dùng sample rời để kết luận mượt. Đọc lại keyframes không thay cho nhìn/render thực. Ghi riêng numeric continuity, frame đã xem và playback đã xem; chưa playback thì ghi pending phần playback, không tự nhận đã xem.
7. Audit sau sửa: slot count, clip ID/start/end/duration và properties ngoài scope, toàn bộ audio/VO, intro, 4K/fps, coverage và captions không đổi khi chỉ sửa motion. Save project/export DRP ở workspace, mở timeline đúng; giữ bản gốc/media dependencies. Mẫu render phải có MarkIn/Out rõ; lưu và khôi phục render preset/format/mode và marks **trước cả frame capture**. Frame capture có thể để lại marks; không để lần full-export sau vô tình chỉ xuất một frame. Không full-export phim khi chưa được giao.

### API hạn chế: xử lý theo build thực

Resolve Free 21.0.2.4 + bridge đã gặp Inspector keyframe API không có, `AddTake(PNG)` lên carrier video trả False, `AppendToTimeline(PNG)` mặc định 120 frame dù yêu cầu thời lượng khác. Không retry hàng loạt hoặc đoán thành công: test một slot trên timeline thử; nếu gặp cùng lỗi, giữ nguyên carrier/record range và cho **native Fusion đọc PNG tĩnh** như bước 2. Build khác phải đo lại; đây không phải cớ dùng motion render ngoài. Với bridge này, ghi input point bằng list `[x,y]`, không gửi dict key `"1"/"2"` lấy từ readback; spline có thể cần import `.comp` thay vì Python index assignment không được proxy hỗ trợ. Luôn kiểm output native sau import, không coi True hoặc tên node là pass.

## Quyết định
Kế hoạch nội dung phải đạt trước dựng; API test chỉ đảm bảo việc đặt đúng. Khi thiếu/sai phát hiện sau dựng, gom deficits theo vế để source+prep một đợt rồi patch, không giữ cảnh sai vì đã dựng.
## Đầu ra
Timeline hình phủ kín, bindings/readback, coverage/video share theo chương và checkpoint.
## Gate Claude C5
Trước dựng hàng loạt: Codex tính bằng script bảng onset câu VO đầu mỗi chương, pause 3–5s và offset intro, rồi gửi kèm scene-ledger đã duyệt và cue nhạc nháp. Claude đề xuất danh sách shot intro 10–20s (chỉ từ nguồn đã duyệt) và soát cue map/mốc title chương theo quy tắc. Mọi frame/timecode do Codex tính lại; nếu Claude và script lệch nhau, script quyết, nhưng phải tìm ra vì sao lệch. [Quy tắc](../reference/CLAUDE_COLLAB.md) · [mẫu](../templates/CLAUDE_GATE_PROMPTS.md).
## Checklist
- [ ] C5: intro plan và cue map/mốc title đã được Claude soát; số frame do script Codex tính.
- [ ] Graph ảnh tĩnh → PhotoMotion → MediaOut đã đọc lại; keyframe local 0/N−1, active photo path và carrier path ghi riêng, không chồng motion cũ.
- [ ] Mỗi ảnh đúng một motion đã chọn; biên độ rõ, cover trước motion và không lộ đen toàn đường đi.
- [ ] Audio originals đầy đủ còn trong workspace/Media Pool; clip timeline giữ tên gốc, derivative ghi rõ cue/variant.
- [ ] Intro thực 10–20s chỉ video + nhạc + SFX, không VO; highlight tiêu biểu của toàn script, nhịp/cảm xúc thống nhất và chuyển tự nhiên sang VO; body reuse ghi ngoại lệ, mốc sau intro đã cập nhật.
- [ ] Toàn phim, cả pause, có hình liên tục; không slot thiếu/offline.
- [ ] Clip có viền đen sẵn đã Zoom lên trên timeline, không còn dải đen ở mép.
- [ ] Mốc đầu vế và source-in native khớp; không dẫn ý mới quá sớm.
- [ ] Ưu tiên video đúng vế; ảnh chỉ khi thiếu video phù hợp và có lý do; shots đạt giới hạn.
- [ ] Source lineage/uniqueness đúng; ảnh tĩnh + keyframe Zoom/Position native editable, crop/overscan và playback liên tục toàn shot đã kiểm, không rung/giật; không dùng motion bake làm đầu vào.
- [ ] Save và checkpoint hoàn tất, giữ VO/sửa tay ngoài scope.
## Ví dụ
Vế A định vị thung lũng: cảnh Longyearbyen đúng thời gian. Vế B đèn đã sáng: chuyển sang đèn/phố mùa tuyết phù hợp ở đầu B; không cắt theo keyword muộn hoặc chia đều thời lượng câu.
## Sửa lỗi
Lệch cut → kiểm origin/frame rounding/pause map trước kéo clip. Sai source-in mixed-fps → conform hoặc append convention đã đo. Thay hình đã khóa VO → giữ record range, kiểm take/readback và audio tracks không đổi.
## Tiếp tục
Gate hình đạt → [06](06_AUDIO.md). Lỗi API cụ thể: [technical notes](../reference/TECHNICAL_FIXES.md#resolve).


## Native verification — 03/10/2026
Mixed-FPS append and still EOF carriers: [LRN-01/02](../reference/LA_RINCONADA_NATIVE_FIXES.md#lrn-01-different-source-fps-and-native-durations). Apply a measured boundary correction once and read actual duration back; preserve the input range and correction separately.
