# Ver 33 — 12/10/2026: phát hành mới, gộp toàn bộ chỉnh sửa ver 32 r1–r10

Nội dung giống ver 32 bản r10; tạo thành bản mới để Codex đọc từ đầu, không lẫn với các bản vá giữa chừng. Tóm tắt các quy tắc đã có trong bản này:
- Ảnh: chỉ cần đúng tỷ lệ 16:9; AI được tạo lại ảnh, đổi chi tiết; chỉ nâng chất lượng ảnh kém, không cần 4K; ảnh tương đối hợp lý là đạt, không sửa lỗi nhỏ.
- Không bao giờ gắn nhãn "AI" trên phim.
- Text chỉ dùng 3 mẫu Chapter / Location / Annotation (reference/TEXT_STYLE_V32.md).
- Prompt ảnh AI tạo lại hoàn toàn bắt đầu bằng 3 dòng trong templates/AI_IMAGE_PROMPT_PREFIX.txt (không áp cho mở rộng/nâng chất lượng).
- Track audio: A1 VO, A2–A3 nhạc nền, A4 ambience, A5 SFX, A6+ Local sound effect.
- Âm gốc footage tách sang Local sound effect, bật nghe được, nhỏ hơn VO.
- Footage có viền đen sẵn: phát hiện ở 02/03, Zoom trong Inspector khi lên timeline (05).
- Resolve chỉ kết nối từ bước 04, sau khi 03 đạt.
- Phối hợp Codex ↔ Claude qua Frenemy (gate C0–C7).
- **Mới ở ver 33:** bỏ việc kiểm quyền tài khoản Epidemic/GetHinh (gói, subscription, kênh liên kết, safelist, license). Người dùng đã đăng nhập đúng tài khoản cá nhân; tải được là dùng.
Ghi chú "(ver 32)" trong các quy tắc là mốc ra đời của quy tắc, vẫn áp dụng ở ver 33.

# Cập nhật ver 32 (r10) — 12/10/2026: chỉ kết nối Resolve từ bước 04

Theo yêu cầu trực tiếp của người dùng: bước 00–03 không đòi mở Resolve, không kiểm bridge, không tạo timeline. Khi 03 đạt, Codex báo người dùng mở Resolve rồi mới làm 04. Ngoại lệ: phim đã có timeline hoặc việc chỉ sửa trên timeline. Làm rõ C0 là kiểm kết nối Claude, không phải Resolve. Sửa START_HERE, stage 00/01/03/04, NEW_VIDEO_PROMPT, PROJECT_DEFAULTS, CLAUDE_COLLAB, skill.

# Cập nhật ver 32 (r9) — 11/10/2026: bật âm gốc footage; xử lý viền đen có sẵn

Theo yêu cầu trực tiếp của người dùng:
- Âm gốc footage tách khỏi video sang track `Local sound effect` (A6+), **bật nghe được** (bỏ chính sách mute), chỉnh âm lượng vừa phải: dưới VO đỉnh khoảng −24 đến −18 dBFS, intro/nghỉ chương khoảng −18 đến −12 dBFS, fade ngắn ở điểm cắt, tắt đoạn có tiếng nói/nhạc/ồn xấu. Tương đối hợp lý là đạt.
- Footage 16:9 có viền đen sẵn (letterbox/pillarbox): kiểm ở 02/03 (nhìn frame hoặc ffmpeg cropdetect), ghi zoom = max(W/w, H/h) × 1.02, đặt Zoom trong Inspector khi lên timeline ở 05 (03 mục 8, 05 mục 7).
Sửa START_HERE, stage 02/03/05/06/08, MUSIC_AMBIENCE_INSTRUCTION, NEW_VIDEO_PROMPT, PROJECT_DEFAULTS, skill.

# Cập nhật ver 32 (r8) — 11/10/2026: thứ tự audio track trong Resolve

Theo yêu cầu trực tiếp của người dùng: A1 `VO` → A2 `Music 1`, A3 `Music 2` (nhạc nền) → A4 `Ambience` → A5 `SFX` (Epidemic thêm vào) → A6+ `Local sound effect` (âm tách từ footage gốc). Thay track gợi ý cũ ở stage 06; thêm vào START_HERE, stage 05/08, NEW_VIDEO_PROMPT, PROJECT_DEFAULTS, skill. Chính sách mute âm footage giữ nguyên. Đồng thời ghi nhận chỉnh sửa stage 01 (motif khi viết script mới) đã có trên máy từ 07/10/2026.

# Cập nhật ver 32 (r7) — 08/10/2026: thu hẹp phạm vi phần mở đầu prompt ảnh

Theo yêu cầu trực tiếp của người dùng: 3 dòng mở đầu (AI_IMAGE_PROMPT_PREFIX) chỉ áp cho ảnh AI tạo lại hoàn toàn/tạo mới; không áp cho ảnh chỉ mở rộng khung hoặc nâng chất lượng từ ảnh gốc, không áp cho prompt video.

# Cập nhật ver 32 (r6) — 08/10/2026: phần mở đầu bắt buộc cho prompt ảnh AI

Theo yêu cầu trực tiếp của người dùng: mọi prompt tạo ảnh AI bắt đầu bằng đúng 3 dòng trong `templates/AI_IMAGE_PROMPT_PREFIX.txt` (Sony A7R IV… / Leica Summilux… / IMG_9854.CR2…). Không áp cho prompt video. Sửa START_HERE, stage 03, NEW_VIDEO_PROMPT, AI_REPORTER, PROJECT_DEFAULTS, skill; thêm file prefix.

# Cập nhật ver 32 (r5) — 07/10/2026: viết lại quy tắc text dạng thẻ

Theo yêu cầu người dùng: viết quy tắc sao cho Codex dễ hiểu, không quá khắt khe. TEXT_STYLE_V32 viết lại thành 3 thẻ (Dùng khi / Trông như thế nào / Số tham khảo / Bảng animation theo giây / KHÔNG ĐƯỢC), thêm 3 ảnh hướng dẫn có chú thích `*-guide.jpg`. Bỏ yêu cầu so frame vào/giữ/ra; chỉ cần xem nhanh, tương đối giống mẫu là đạt. Thêm `reference/RULE_FORMAT.md` (cách viết quy tắc mới). Sửa stage 07, START_HERE, TEXT_DEFAULTS, CLAUDE_GATE_PROMPTS (C6).

# Cập nhật ver 32 (r4) — 07/10/2026: style text mới theo mẫu người dùng

Theo yêu cầu trực tiếp của người dùng: mọi text trong phim dùng 3 mẫu Chapter / Location / Annotation tại `E:\Youtube AI\Hidden Chapters\Text example` (bản sao `visuals/text-example-v32/`), có animation vào/ra dựng native trong DaVinci Resolve. Thêm `reference/TEXT_STYLE_V32.md` (vị trí, cỡ chữ, màu, opacity đo từ mẫu; công thức animation; 3 Fusion Title template HC_*_v32; kiểm frame native so với mẫu). Thay TEXT_DEFAULTS; style cũ v27/v28/center slide/Mixkit chuyển sang lịch sử. Sửa START_HERE, stage 07, NEW_VIDEO_PROMPT (mục 14), CLAUDE_GATE_PROMPTS (C6), PROJECT_DEFAULTS, skill.

# Cập nhật ver 32 (r3) — 06/10/2026: cấm nhãn "AI illustration" trên hình

Câu "ảnh AI không dùng làm bằng chứng tư liệu hay chú thích như ảnh chụp thật" thêm ở r1 quá mơ hồ khiến Codex tự gắn chữ "AI illustration" lên ảnh trong phim. Đã sửa: `ai_regenerated` chỉ ghi trong ledger nội bộ; tuyệt đối không đặt nhãn/chữ/watermark AI lên hình hay video trừ khi người dùng yêu cầu rõ. Thêm mục kiểm ở stage 07 và 08. Sửa START_HERE, stages 03/07/08, NEW_VIDEO_PROMPT, AI_REPORTER, PROJECT_DEFAULTS, skill.

# Cập nhật ver 32 (r2) — 06/10/2026: ảnh AI chỉ cần tương đối hợp lý

Theo yêu cầu trực tiếp của người dùng: Codex đang sửa quá nhiều chi tiết nhỏ (chữ giả trên sách, chữ trong biểu tượng, hình in trên áo). Từ nay ảnh AI chỉ cần tương đối hợp lý. C4 chỉ đánh fail khi có lỗi lớn thấy ngay (sai 16:9, viền/dải màu, kéo méo, sai hẳn chủ đề, chủ thể chính biến dạng rõ). Lỗi nhỏ chỉ ghi chú, Codex không sửa. Tạo lại tối đa một lần; lần hai còn lỗi nhỏ thì dùng luôn. Sửa trực tiếp trong ver 32: START_HERE, stage 03, NEW_VIDEO_PROMPT, CLAUDE_GATE_PROMPTS (C4), CLAUDE_COLLAB, PROJECT_DEFAULTS, skill, VERSION.

# Quy tắc xử lý ảnh mới — ver 32 — 06/10/2026

Theo yêu cầu trực tiếp của người dùng (phiên Claude Cowork, 06/10/2026), thay quy tắc ảnh của ver 30–31 vì công cụ ảnh có sẵn của Codex (image_gen) luôn vẽ lại toàn bộ ảnh, nên yêu cầu "giữ đúng mọi chi tiết thật" không đạt được và tạo vòng lặp sửa không kết thúc:

- Ảnh sai tỷ lệ: AI được mở rộng hoặc **tạo lại ảnh mới** đúng 16:9; **được phép thay đổi chi tiết**, không cần khớp ảnh gốc. Chỉ yêu cầu đúng tỷ lệ, đúng chủ đề vế, không viền/dải màu/blur, không méo, không lỗi AI rõ. Lệch nhỏ (≤~5%) thì crop nhẹ.
- Nâng chất lượng **chỉ cho ảnh kém chất lượng**; **không yêu cầu 4K**, kích thước mặc định của công cụ AI là đạt.
- Ảnh đúng tỷ lệ và đủ nét: dùng trực tiếp, không bắt buộc qua AI.
- Một bản đạt cho mỗi ảnh, không lặp vòng sửa chi tiết. Ảnh AI ghi `ai_regenerated`, không dùng làm bằng chứng tư liệu; chữ/số cần chính xác dùng overlay native.
- C4 đổi thành kiểm tỷ lệ/viền/méo/lỗi AI rõ/đúng chủ đề, không kiểm khớp chi tiết.
- Sửa: START_HERE, stages 03/05/08, NEW_VIDEO_PROMPT, PROJECT_DEFAULTS, STOCK_FOOTAGE_MUSIC_KEYWORDS, AI_REPORTER, TECHNICAL_FIXES, CLAUDE_COLLAB, CLAUDE_GATE_PROMPTS (C4), skill `mp2-brief-edit`, templates progress/project. Quy tắc motion, nguồn, audio, 4K timeline/output và bàn giao giữ nguyên.
- Phim đang làm dở (Coober Pedy): ảnh còn chờ xử lý theo quy tắc mới; ảnh đã đạt theo quy tắc cũ giữ nguyên, không cần làm lại.

# Phối hợp Codex ↔ Claude — ver 31 — 05/10/2026

Theo yêu cầu trực tiếp của người dùng (phiên Claude Cowork, 05/10/2026): thêm workflow để Codex điều phối sản xuất và gọi Claude qua MCP `claude` của Frenemy (`ask_claude`, chỉ đọc) ở các việc Claude làm tốt hơn, đồng thời hai bên kiểm chéo để chống hallucination.

- Mới: `reference/CLAUDE_COLLAB.md` (phân vai, gate C0–C7, thư mục `collab` trong workspace, hợp đồng trả lời JSON, 7 luật chống hallucination, hạn mức và xử lý lỗi, kiểm C0), `templates/CLAUDE_GATE_PROMPTS.md` (mẫu prompt từng gate + phản biện), `templates/claude-calls.csv` (sổ gọi), `scripts/check_claude_handoff.py` (verdict/canary/evidence, wording vế 100%, chapter timestamps), `scripts/make_review_sheets.py` (sheet 3 khung theo vế, ảnh original|AI).
- Gate: C1 chia vế (bắt buộc), C2 yêu cầu hình/keyword/nhạc, C3 duyệt nguồn theo vế (bắt buộc trước dựng hàng loạt), C4 kiểm facts ảnh AI, C5 intro/cue map/mốc title, C6 QC cuối (bắt buộc hoặc báo chưa qua), C7 title/description.
- Sửa: START_HERE (mục phối hợp, cột Gate Claude), stages 00/01/02/03/05/08 (mục Gate + checklist), progress/project/PROJECT_DEFAULTS (`claude_collab`, sửa `playbook_path` cũ trỏ ver 28), STEP_CHECKLIST, NEW_VIDEO_PROMPT (mục 13), ERROR_INDEX, CAPABILITIES, skill `mp2-brief-edit`.
- Không đổi quy tắc dựng/nguồn/audio/4K/bàn giao của ver 30. Không sửa timeline hay media phim nào. Script mới đã chạy thử với dữ liệu mẫu (PASS/FAIL đúng dự kiến); chưa chạy trên phim thật.

# Cập nhật xử lý mọi ảnh — 04/10/2026

Theo yêu cầu trực tiếp của người dùng trong chat quản lý playbook: thay điều kiện AI khi cần bằng AI expand đúng tỷ lệ + nâng chất lượng bắt buộc cho mọi ảnh trước import/timeline, kể cả ảnh đủ nét/đúng tỷ lệ. Original giữ đối chiếu; timeline dùng output đã kiểm facts/chất lượng. Loại wording cho phép dùng ảnh gốc trực tiếp, đồng bộ checklist/native-motion instructions/template/skill. Không thực hiện xử lý ảnh hoặc sửa timeline phim trong lần cập nhật tài liệu này.

# Cập nhật quyền sửa playbook — 04/10/2026

Theo yêu cầu trực tiếp tại chat quản lý playbook, thay hướng dẫn tự cập nhật sau lỗi và thêm mẫu: chỉ yêu cầu rõ ràng từ người dùng tại chính chat này cấp quyền sửa trong scope được giao; sản xuất tự động/chat khác chỉ đọc playbook, ghi lỗi/bài học/mẫu tại workspace project. Áp dụng cả nguồn, skill/mirror, lịch sử, assets, metadata, ZIP và LATEST. Không sửa timeline phim.

# Cập nhật recipe Fusion trực tiếp ver 30 — 04/10/2026

Theo yêu cầu người dùng, lưu cách đã thực thi keyframe Fusion native thành quy trình dùng chung ở bước05: graph ảnh tĩnh→PhotoMotion→MediaOut, keyframe/spline0/N−1, hold/crop/overscan, giữ record range và graph chỉnh tay, workaround API đo theo build, carrier/active photo path riêng, QC cả shot và scope nhìn/numeric trung thực. Thêm helper tạo comp thuần/ledger được bước chính liên kết; đồng bộ entry/03/04/05/checklist/defaults/progress/skill/technical index, ZIP/hashes. Không tiếp tục sửa video hoặc full-export trong lần cập nhật tài liệu này.

# Cập nhật trực tiếp ver 30 — 04/10/2026

Theo yêu cầu người dùng, sửa các mục hiện có: title chương bắt đầu đúng onset câu VO đầu trên footage của chương, không xuất hiện sớm trong pause. Motion ảnh dùng keyframe Zoom/Position native editable trong Resolve, thay render ngoài/zoompan; kiểm playback liên tục và dải frame liên tiếp, không coi sample rời là bằng chứng mượt. Đồng bộ entry/stages/checklists/templates/skill, đánh dấu workaround zoompan cũ là lịch sử. Không thêm file yêu cầu riêng hoặc sửa timeline phim.

# Playbook ver 30 — 04/10/2026

Theo yêu cầu người dùng, đối chiếu trực tiếp folder 2026-8-28-Longyearbyen (4 file MP4/SRT/thumbnail/prompt). Sửa quy tắc đầu ra và bàn giao hiện có, bỏ sự mơ hồ về nơi lưu summary/manifest: mọi hồ sơ kỹ thuật/nội bộ ở workspace; folder thành phẩm chỉ chứa đầu ra cuối được giao và thumbnail được chọn cùng prompt, các phiên bản nháp/cũ ở workspace. Đồng bộ entry, checklist, templates và skill; sửa tên SRT ví dụ theo file thực. Không dọn/xóa/di chuyển file phim hoặc resume production.

# Ver 29 — 2026-10-04

Sửa trực tiếp quy tắc motion: một motion mỗi ảnh, biên độ rõ hơn, cover trước chuyển động và kiểm toàn đường đi. Giữ đầy đủ audio Epidemic và tên gốc trên Media Pool/timeline; derivative có tên nguồn + cue/variant và mapping.

# Cập nhật ver 28 — 04/10/2026

Theo yêu cầu người dùng, sửa trực tiếp các mục intro hiện có trong ver 28: montage highlight 10–20s chỉ video/nhạc/SFX, không VO; nhấn mạnh hình ảnh tiêu biểu, nhịp/cảm xúc và chuyển vào lời dẫn. Làm rõ nhạc phù hợp văn hóa địa phương/cộng đồng bằng chất liệu/nhạc cụ/tiết tấu có liên hệ đã kiểm; đồng bộ checklist, template và skill. Giữ ngoại lệ tái dùng footage thân phim, timing map và policy audio Epidemic. Không thêm file yêu cầu riêng, không tiếp tục sản xuất phim.

# Playbook ver28 — 03/10/2026

History only. Added measured still-import count/type checks and hash-identical per-asset alias repair to native stage, progress template and skill.44 requested photos became37 clips through automatic sequences/JFIF skip; corrected to44 separate Still clips. No new financial, publication or deletion authorization.

# Playbook ver 27 — 03/10/2026

History only. GetHinh and Epidemic Sound are user-confirmed signed in inside Codex. Integrated direct instructions into entry, source references, sourcing/audio stages, templates and skill to independently open/reuse those browser sessions without asking login confirmation. Actual access/login/rights failures remain reportable. This documentation update did not perform sourcing or test the live sessions.

# Playbook ver 26 — 03/10/2026

History only. Removed shared Music-library lookup/reuse/copy workflow and the audio budget from active instructions, templates and skills. Each video selects/downloads fresh Epidemic music/SFX/ambience into its own workspace. GetHinh budget remains 100 xu for video only. Original audio files and prior releases are retained.

# Playbook ver25 — 03/10/2026

Change history only; current instructions are START_HERE, stages and their references/templates.

Integrates the10shared user decisions directly into existing sections/checklists/templates/installed and portable skills. Removes active routing to USER_REQUIREMENTS and LOCALITY_AND_4K; keeps their ver24text in history. Resolves actual stale50–70%video ceiling, ACE/audio fallback, unrestricted Music reuse and broaden-before-photo order. Intro10–20s/noVO, generic subject/culture, AI when needed, file-backed samples, native4K, packaging scope and quota save/stop all live in the relevant steps. All prior releases/sample originals preserved. Production remains paused; no media/native edits in this release.

# Playbook ver 25 — 03/10/2026

Final consistency check removes three remaining old video50–70% checklist requirements from stages05/08. Same10shared user requirements and four original samples as ver23; no production edits in this document release. Keeps23unchanged.

# Playbook ver 25 — 03/10/2026

Chuẩn hóa 10 yêu cầu mới thành playbook dùng chung, sourcing/intro theo tiêu đề/script từng phim; không cố định địa điểm. Video-first không trần50–70%, đồ họa cơ chế/số liệu, AI expand/enhance có đối chiếu. Toàn bộ audio Epidemic thay lựa chọn Envato cũ. Giữ4K native/output, nguồn Pexels/Pixabay/GetHinh, phối hợp packaging theo authorization, quota1–2% checkpoint+dừng không shutdown. Bốn ảnh mẫu gốc lưu trong folder có link+hash và đóng gói ZIP. Sửa template version/resolution stale; giữ bản22 và mọi bản cũ.

# Playbook ver 25 — 03/10/2026

Adds explicit global UHD 4K timeline/output default, preserving HD baseline during correction, locality-first video/photo sourcing before keyword expansion, and the La Rinconada 10–20s culturally suitable no-VO intro override. Records demonstrated locality/format failures; production revision is in progress.

# Playbook ver 21 — 03/10/2026

Adds measured La Rinconada native fixes: mixed-rate append duration, PNG EOF carriers, alternating ambience tracks, safe Fusion point/expression writes, cover framing, precise source readers, and final native versus listening scope. Records Epidemic-only audio and video-first as this film’s user overrides; existing global defaults and older releases are preserved. Refreshes native editable chapter/location/fact reference examples from the verified timeline.

# Playbook ver 20 — 03/10/2026

Adds Pixabay API and Epidemic Sound as the primary new audio source, with private DPAPI credential handling and provenance. Original ver20 release retained unchanged.

# Playbook ver 19 — 02/10/2026

Records the La Rinconada video-first user override: essential mechanism/numeric graphics only; photographs after suitable-video search fails. Full revision pending.

# Playbook ver 18 — 02/10/2026

Reduces unnecessary explanatory cards before styling; records provenance validation, final chronological sort and semantic audit failure exits. Native work and editorial reduction remain pending.

# Playbook ver 17 — 02/10/2026

Records advertised-versus-decoded source mismatch, bounded-crop safeguards and HTML responses masquerading as official PDFs. Keeps preserve/expand-first and aspect-correct motion rules.

# Playbook ver 16 — 02/10/2026

Records demonstrated non-16:9 zoompan distortion, aspect-correct input canvas repair and actual output review limits. Preserves ver15 keep/expand-first policy.

# Playbook ver 15 — 02/10/2026

User clarified preserve/expand-first image preparation: retain fitting images; expand only when frame coverage needs it; reserve regeneration for demonstrated content/style defects. Removes an inferred blanket replacement queue. No automatic quality pass; original/geography/provenance checks remain.

# Playbook ver 14 — 02/10/2026

Record user-selected documentary infographics: replace sparse abstract cards with informative textured illustrations/cutaways/insets, retain verified facts and native editable labels. Preserve examples2–4 as style-only references and example1 as rejected style. Generated, blueprint and native-verified states remain separate. Older releases preserved.

# Playbook ver 13 — 02/10/2026

Bổ sung gate đăng ký folder sản phẩm và summary/manifest trước bàn giao timeline, kể cả chưa export. Ghi rõ output thiếu, không tự coi đã có thumbnail/MP4. Sửa thiếu folder ở Tristan v28; giữ ver12 nguyên vẹn.

# Playbook ver 12 — 02/10/2026

Bổ sung lỗi đã đo khi dựng Tristan v28: source-end raw không nhất quán, clean Fusion graph thay KeyFrameStretcher lỗi, kiểm digital silence và actual PCM cue sum, bảo toàn full timing records trước cleanup. Thêm native PNG text in/hold/out/chapter/date và editable graph; style center là native-verified variant, chưa user-approved default. Giữ phạm vi saved/open timeline, không full export. Ver11 không thay đổi; giọng/budget/ratio mặc định không đổi.

# Playbook ver 11 — 01/10/2026

Tách ba lớp: trang điều phối, execution files cho từng bước, profile riêng phim. Bổ sung stage00 resume. Bỏ preset/số cảnh phim cũ khỏi quy tắc điều phối; giữ evidence kỹ thuật ở reference/history.

Mặc định American low0.8 English; 100 xu video +20 xu audio chung. Master VO liền mạch, measured clause anchors, ngữ cảnh câu trước/sau, map chapter pauses. Keyword/instruction riêng toàn phim trước sourcing mở rộng. Quy tắc video50–70% toàn phim, không chương toàn ảnh; chọn ảnh theo nội dung rồi AI chuẩn bị, overscan và motion4kiểu.

Music/ambience cue/file riêng theo diễn tiến chapter, không giới hạn số bài trong budget, quiet head-tail overlap/loop; pause3–5s chỉ ngừng VO. ZIP/full extracted audio variants giữ trong shared library. Local sound effect tách audio video đúng track.

QC đầu vào trước timeline + small native smoke + readback/targeted check sau dựng. Bàn giao timeline saved/open, không full export nếu chưa yêu cầu. SRT theo timeline cuối/pause map. Text defaults chapter/location/fact là frame từ existing Resolve export; template candidates downloaded/file-installed nhưng bridge refused nên native-test pending, không giả pass.

Không chỉnh timeline/audio/VO Tristan trong lần cập nhật tài liệu này. Ver27 single ambience/flattened musical foundation là evidence lịch sử, chưa đạt yêu cầu mới chapter arrangement. Giữ ver10 và toàn file working nguyên chỗ. Prompt bắt đầu phim mới và skill mirror cập nhật cùng scope.

# Playbook ver 10 — 01/10/2026

Nhạc theo diễn tiến script; bảng mood chỉ tham khảo. Kiểm actual audible music xuyên phim, nền hòa âm/loop có crossfade, peak không làm mất cả cue, và contribution trong export native. Evidence Tristan v27; ghi rõ nghe thủ công còn pending. Giữ ver9.

# Playbook ver 9 — 01/10/2026

Ảnh outpaint16:9 bảo toàn gốc, kiểm seams/body continuation, historical texture giấy tờ, slow pan/zoom, native source-take swaps giữ mốc VO, thumbnail có người theo sample, và QC audio đúng export window. Giữ ver8 và original media.

# Playbook ver 8 — 01/10/2026

Native Resolve QC lessons from RapaNui: geography in actual frames, source burned captions, provenance labels, exclusive append endpoints, bridge handle indexing, full-duration alpha overlays and measured render keys/range/output checks. Fix stale hardcoded output version. No changes to ratio, shot duration or sourcing budget. Preserve ver7 unchanged.

# Playbook ver 7 — 30/09/2026

- Bổ sung kiểm chiều khung hình tại stage02: format phim → bộ lọc provider → metadata item → probe original → review nội dung → gán. Video dọc không được thay thành ngang bằng crop/pad/collage khi người dùng không cho phép.
- Rapa Nui: gỡ ba source Instagram SASIPA dọc; thay bằng nguồn ngang và ảnh tư liệu đúng thao tác, ảnh vẫn tính ảnh. Thêm assertion orientation trong audit.
- Giữ ver6 nguyên vẹn; các quy tắc tỷ lệ video, timing, nguồn, ngân sách và editor không đổi.

# Playbook ver 6 — 29/09/2026

- GetHinh: khi đã có chỉ định và trần xu từ người dùng, agent tự hoàn thành chuỗi tải; lượt treo được kiểm tra số dư/lịch sử trước khi “Thử lại” → “XÁC NHẬN VÀ DOWNLOAD” → “Tải về”. Một trạng thái “Đang tải” kéo dài không đủ chứng minh thất bại vĩnh viễn.
- Giao nhầm file VVVN2AA dù trang báo hoàn tất: giải mã và đối chiếu khung hình với preview sau mỗi tải. Ghi xu thực trừ và loại nguồn sai, dừng đơn kế tiếp để tránh lặp lỗi. Bài học Rapa Nui ngày 29/09/2026.
- Giữ mọi quy tắc biên tập của ver 5; bản ver 5 được bảo toàn.

## Ver 5 — 28/09/2026

- Khi thay thứ tự/track của clip trong Kdenlive XML, mọi producer/chain phải đứng trước playlist đầu tiên tham chiếu nó. Nếu không, Kdenlive có thể bỏ clip chưa khai báo và các clip phía sau trên cùng playlist khi mở/lưu, trong khi Melt sample vẫn render. Sau save/reopen phải đếm lại clip theo từng playlist và so sánh nguồn, in/out. Bài học V005 feedback r6→r7.
- Giữ quy tắc của ver 4 về đóng gói SVG tương đối; ver 4 được bảo toàn.

## Ver 4

- Khi tạo revision của project Kdenlive cũ, sao chép toàn bộ asset có đường dẫn tương đối (đặc biệt `graphics/*.svg`) vào gốc revision hoặc đổi sang đường dẫn tuyệt đối có kiểm chứng. XML parse và sự tồn tại của file gốc chưa chứng minh project mới render được. Kiểm một frame qua engine Kdenlive và rà log thiếu media trước khi mở bàn giao. Bài học từ V005 feedback r5→r6.
- Giữ nguyên toàn bộ quy tắc và kho Music của ver 3; bản ver 3 được bảo toàn.

## Ver 3

- Thêm kho Music dùng chung, kiểm kho trước khi search/tải music/SFX/ambience mới.
- Phối nguồn cũ với mới theo mood/range, tránh lặp; không đặt quota reuse cứng.
- Giữ original; bản sao kho có hash/probe/provenance, phân loại original/Prepared và canonical track.
- Catalog nhập từ Train-V005, Longyearbyen, Tristan; thiếu nguồn được báo riêng.
- Giữ quy tắc ver 2 về 8 bước, tỷ lệ video, SFX intro, ambience và output. Ver 2 bảo toàn trong thư viện.

## Ver 20 — 03/10/2026
Thêm Pixabay API vào tổ hợp footage; lưu credential riêng bằng DPAPI, query thật đã thành công. Epidemic Sound là nguồn chính cho music/SFX/ambience mới; giữ library-first, cue theo chương và phạm vi intro SFX. Bổ sung helper query/cache 24h, provenance, chi phí và trạng thái kiểm chứng; giữ ver19.
