# Tra kỹ thuật khi gặp lỗi — không là checklist mọi phim

## Media
EOF/source seconds/mixed-fps, historical zoompan diagnostics (superseded for photo motion), outpaint giữ gốc (đã thay bằng quy tắc ảnh ver 32 ở bước 03), document framing, seams và ticker source: [ghi chú ver10](history/ver10-stages/03_MEDIA_PREP.md). Dùng quy tắc hiện hành 03; không mặc định công thức AI blend/motion từ ví dụ cũ.
## Resolve
Trên Free21.0.2.4 bridge đã đo append endFrame exclusive; build khác phải smoke test. Index pool/timeline một lần để giảm handles/TCP. AddTake/FinalizeTake giữ record-range có evidence trên build đó; [assembly fixes](history/ver10-stages/05_ASSEMBLY.md). Số cảnh/timecode phim cũ chỉ là lịch sử, dùng count/baseline native phim hiện tại. [bridge guide](RESOLVE_MCP.md).

## Fusion native photo motion

Quy trình đang áp dụng: [bước 05 — graph, keyframes, cover, QC và preservation](../stages/05_ASSEMBLY.md#motion-ảnh-bằng-fusion-native--quy-trình-tái-sử-dụng). **Ưu tiên cách Fusion đã kiểm khi automation Inspector không hỗ trợ keyframe**, không fallback về FFmpeg zoompan.

Graph tối thiểu: nguồn `Photo` đọc ảnh tĩnh duy nhất → native `Transform` tên `PhotoMotion` → `MediaOut1`. `Size` nhận `BezierSpline` khi zoom; `Center` nhận `XYPath`, trục X nhận `BezierSpline`, Y cố định khi pan. Spline endpoint local 0/N−1, linear; giữ source một frame qua toàn shot. `.comp` importer có thể chuyển Loader thành MediaIn/MediaPool source; export graph thực phải còn PNG một frame, path đúng và output thật. Khác build cần smoke, không coi spelling node/source trong file mẫu là chứng minh binding native.

[Helper tạo comp](../scripts/build_native_photo_motion_comp.py) chỉ tạo `.comp` từ PNG tĩnh và tham số; không điều khiển Resolve, không render video, không import/mutate timeline tự động. [Mẫu ledger](../templates/native-photo-motion.json) lưu carrier/active photo/keyframes/cover/evidence cho từng phim. Copy helper/ledger vào workspace phim nếu cần; số liệu ví dụ không áp dụng cứng. Sau đó import ở clip đã checkpoint, đọc actual duration/properties/graph và kiểm render native theo 05.

Giới hạn **đã đo trên Free21.0.2.4 + bridge**, không khẳng định cho mọi version: Inspector keyframe method vắng; PNG AddTake lên video False; PNG Append không giữ requested length mà dùng default120f. Cách đã kiểm: giữ clip carrier có timing đúng và thay nhánh hình của comp bằng static PNG; all movement ở PhotoMotion editable. Native media-pool path carrier vẫn cũ, vì vậy manifest phải tách `native_carrier_path` và `active_photo_path`. Không claim đã replace PNG take. Existing comps/sửa tay phải bảo toàn, không bulk overwrite.

Point write qua proxy dùng `[x,y]`; readback có thể là `{"1":x,"2":y}`, không tái dùng dict này làm input. Nếu không ghi được spline qua Python index assignment, chuẩn bị comp file và ImportFusionComp; đọc lại FindTool/GetInput tại nhiều local frames, export actualcomp và render kiểm. Nguồn đã bake phải bị ngắt khỏi output, không chỉ thêm zoom/pan mới trên nó.

Kiểm motion: native full-shot CFR đúng fps/frame count; consecutive-frame differences phát hiện freeze/jump, phase correlation có thể đo pan jitter (kiểm trong vùng ảnh đủ texture, tránh overlay/fade). Ngưỡng tùy shot/fps/resolution; số liệu proxy không so trực tiếp với UHD. Zoom không dùng phép tịnh tiến để giả xác nhận mọi motion. Kết hợp nhìn playback và kiểm cover/keyframe; numeric pass không có nghĩa đã subjective watch. Full-shot samples/proxies và report ở workspace, không đưa vào folder thành phẩm.

Bằng chứng thực thi lần đầu, **lịch sử kết quả, không preset chung**: workspace `la-rinconada-production-v01`, tools `native_motion_comp_v07.py`, `apply_native_keyframes_v07.py`, `audit_native_keyframes_v07.py`; report `evidence/native-final-keyframes-v07.json`. 40 ảnh native, 40 full-shot proxy renders/5.887 frames đã numeric kiểm; bốn đoạn 2s UHD kiểm thêm. Chưa subjective playback toàn bộ 40 shot, phải giữ trạng thái này trong evidence; ảnh sample rời không thay phần playback. Chỉ motion/title đổi, audio/VO/intro/timing giữ nguyên, không xuất full phim.

## Audio
Trim ranges, canonical variants, music rests/floor, contribution và offset render sample: [audio history](history/ver10-stages/06_AUDIO.md). Các mức RMS/peak Tristan không là preset chung. Bed dài của v27 là lịch sử; user sau đó yêu cầu arrangement music/ambience riêng theo chapter, chưa coi v27 đạt yêu cầu này.
## Text
PNG trở về default hold, alpha ProRes4444, Fusion graph không bảo đảm render và glyph layout: [text fixes](history/ver10-stages/07_TEXT.md). Native proof mẫu ngắn thay full export để thử.

## Ver12 — native v28
[Source-end semantics, Fusion KFS modal, silent streams/actual audio sum, cleanup record preservation và render setting rejection](TRISTAN_V28_FIXES.md). Chỉ đọc phần liên quan khi gặp triệu chứng.


## LR-ZOOMPAN-ASPECT-20261002 — lịch sử phương pháp render ngoài đã thay thế

Demonstrated failure: prepared v01 zoompan outputs from portrait/square photographs stretched the scene and retained an edge credit that the intended crop should have excluded. Cause: zoompan derives crop width and height from input width/zoom and input height/zoom; an output size of 1920x1080 alone does not make the source crop 16:9.

Current rule (04/10/2026): animate static original/prepared images with editable Zoom/Position keyframes inside Resolve and verify continuous native playback for jitter; do not implement the following external-render workaround for new or revised photo motion. Historical correction: create an aspect-correct 16:9 input canvas before zoompan. The La Rinconada v02 helper scales to 3840px width and pads to the right/bottom only, computes zoom using that canvas width, and keeps every visible crop wholly within the original source. Padding is a computation canvas, not visible blur/black framing. Source-coordinate crop bounds, first/last and intermediate samples must be checked; never use output dimensions as proof of undistorted content.

Evidence: tools/render_reviewed_photo_motion.py; evidence/stage03-photo-motion-output-review.json and .jpg; planning/stage03-photo-motion-plan.json in la-rinconada-production-v01. Six corrected derivatives passed CFR/frame-count and full EOF decode, with five decoded output samples per derivative visually inspected. Originals retained. Scope excludes continuous manual viewing and native Resolve playback; credits and native smoke remain pending. Still-derived MP4 remains quota_class=still.


## LR-DECODED-INPUT-TRUTH-20261002 — actual media before metadata

Observed failures: Pexels7781741 advertised a1920x1080 variant but the downloaded file decoded1280x720 and was byte-identical to the existing original. A crop designed against advertised dimensions extended below the real image and FFmpeg silently shifted/clamped it. The corrected bounded crop still showed bright gardening gloves and green ground; it was rejected for the cold manual-work clause. Do not conflate this with5998380: that crop was geometrically valid but rejected for modern-office/knee composition.

Validate decoded width/height before calculating every crop. Assert x>=0,y>=0,width>0,height>0,x+width<=decoded_width,y+height<=decoded_height. Metadata, file name and output1080p size are not proof of a higher-resolution original, correct framing or suitable content. Record actual bytes/hash and review prepared outputs. Evidence: evidence/pexels-7781741-resolution-mismatch.json and sources/stage03-care-administration-crop/samples.json; the eight selected crops have actual bounds checks and five prepared-output samples each. Native proof remains pending.

Official-document URLs ending.pdf returned HTML: the former GOREPuno link gave the2026 site shell and MEF gave a non-PDF response. PyMuPDF's auto-detection opened the.part HTML as a one-page non-PDF, so page-count alone was misleading; the falsely classified PDF record was corrected before use. Retain rejected responses, verify PDF magic/content type and explicitly parse bytes with filetype=pdf before citing or rendering a downloaded document. Do not treat successful HTTP status or extension as evidence. Do not bypass access challenges. A separate public official gob.pe multiannual POI2025–2027 was downloaded and verified as113PDF pages; only a bounded project-title excerpt fromp107 was used. It corroborates planning, not completion and not the annual budget's amounts. Evidence: evidence/gore-puno-2025-download.json, mef-budget2025-download.json, gore-puno-official-multiannual-download.json, and actual source excerpts in la-rinconada-production-v01. Distinguish annual/multiannual source scopes.


## LR-GRAPHICS-NECESSITY-20261002 — life before explanatory cards

User correction: a documentary about residents had too many unfamiliar conceptual graphics. The draft had135 graphic placements,689.82s of1944.63s (35.47%). These are planned placements, not a native film. Factual relevance alone does not establish editorial necessity. Decide whether a graphic helps the story before generating, expanding or restyling it. Prefer authenticated place views and compatible labor/domestic action with truthful provenance. Keep only useful mechanism/numeric explanations; avoid repeated source-scope cards. Preserve locked VO unless the user directs a script change. Two generations already running when the correction arrived were retained as deferred candidates, not automatically bound. C028's unnecessary2s household card was replaced by a reviewed cooking detail from the measured197.58 meal onset; the plan is now134graphics/687.82s, so reduction remains incomplete. Do not claim the excess has been resolved. Evidence: planning/editorial-graphics-reduction-review.json, evidence/stage03-domestic-cooking-candidate.json and five decoded prepared-output samples. Generic stock is not an actual La Rinconada kitchen.

## LR-PLANNER-DEPENDENCY-20261002 — validate, reorder, then audit

Four replacement records lacked provenance and the planner raised KeyError. Validate required provenance before registration mutation. After semantic time changes exchanged adjacent C137 placements, the planner's earlier sort left them in obsolete order and the audit reported three gap/overlap errors. Sort again after all timing overrides, preserving stable IDs. Re-run the actual plan and audit:335raw/334merged shots, no gaps/errors. The audit previously returned exit0 even with semantic errors; it now writes evidence then exits nonzero when errors exist. Run dependent refreshes sequentially with subprocess check=True and inspect report status as well as process success. A stale audit after failed planning is not current proof. Source/content preparation and native Resolve remain pending. Evidence: stage03-replacement-provenance-correction.json, stage03-planner-order-correction.json and full-picture-source-audit.json.


## Native verification — 03/10/2026
Additional measured Resolve21/bridge observations: [La Rinconada native fixes](LA_RINCONADA_NATIVE_FIXES.md).
