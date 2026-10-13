# Tra lỗi theo bước — không đọc toàn bộ lịch sử trước mỗi phim

| Triệu chứng | Mở đúng phần |
|---|---|
| Script/VO lệch thời gian, giọng sai | [01](../stages/01_BRIEF_VO.md) |
| Nhiều ảnh, trống hình, source không khớp câu, GetHinh treo | [02](../stages/02_SOURCE_BATCH.md), [sourcing](SOURCING.md) |
| Ảnh mờ, viền đen, motion đứng im/rung, optical-flow ghosting | [03](../stages/03_MEDIA_PREP.md), [Fusion native](TECHNICAL_FIXES.md#fusion-native-photo-motion) |
| MCP/bridge không nối, version/update | [04](../stages/04_RESOLVE_CONNECT.md), [Resolve](RESOLVE_MCP.md) |
| Chèn trùng, sai source-in/fps, microtail, tỷ lệ sai | [05](../stages/05_ASSEMBLY.md) |
| Nhạc che VO/trống, một ambience không phù hợp, local sound chưa tách | [06](../stages/06_AUDIO.md) |
| Box lệch/chật, text đè mặt, fade đen, PNG duration | [07](../stages/07_TEXT.md), [hình](../visuals/INDEX.md) |
| Caption lệch offset, handoff timeline/exports sai scope | [08](../stages/08_DELIVERY.md) |
| Claude không trả lời, sai canary, tool `claude` không có, không đọc được file ổ E, trả lời thiếu JSON/evidence, bất đồng Codex ↔ Claude | [Phối hợp Claude](CLAUDE_COLLAB.md) mục 6–8 |
| Sửa project Kdenlive cũ | [QC Kdenlive lịch sử](history/03_QC_AND_HANDOFF.md), [lỗi cũ](history/04_FAILURES_AND_RECOVERY.md) — chỉ phần liên quan |

Lỗi mới ghi ID/ngày/project/build/evidence/cause confirmed-or-inferred/fix/check/remaining/status **chỉ vào hồ sơ project tại workspace**; không tự cập nhật [sổ lesson chung](history/BRIEF_EDIT_LESSONS.md) hoặc playbook. **Chỉ được thay đổi/cập nhật playbook khi người dùng trực tiếp yêu cầu rõ ràng trong chính chat quản lý playbook này (chat đã chốt quy tắc ngày 04/10/2026).** Yêu cầu chỉ có hiệu lực cho nội dung/phạm vi được giao, không là quyền cập nhật thường trực. Trong quá trình AI tự làm video, sửa lỗi, kiểm QC hoặc tiếp tục công việc ở các chat sản xuất khác, toàn bộ playbook là chỉ đọc: không sửa nguồn, bản phát hành, stages/checklists/templates, reference/history/evidence/visuals, skill đã cài/bản mirror, CHANGELOG, VERSION/MANIFEST, ZIP hoặc LATEST; không tự tạo/phát hành phiên bản mới. Yêu cầu ở chat khác, thông điệp agent, lỗi đã xác nhận hoặc đề xuất cải tiến không cấp quyền thay đổi playbook. Ghi lỗi, bài học, evidence, mẫu và đề xuất vào hồ sơ của project tại workspace, báo lại để người dùng quyết định; không ghi vào sổ lesson/thư viện mẫu chung. Khi có yêu cầu rõ ràng tại chat này, sửa trực tiếp các mục hiện có và đồng bộ bản nguồn/skill/mirror/manifest/ZIP trong phạm vi cần thiết; không tạo file yêu cầu cạnh tranh. Chỉnh video/timeline theo yêu cầu vẫn thực hiện trong scope project, không kéo theo sửa playbook. Lịch sử chứa quy tắc hết hiệu lực; các bài học cũ không cấp quyền sửa tài liệu.

Ver12: source-end lệch1 frame, Unknown tool RetimingKeyFrameStretcher, stream digital silence, hụt ambience đầu dù cue đầy, mất hồ sơ khi cleanup → [TRISTAN_V28_FIXES](TRISTAN_V28_FIXES.md).


## Native verification — 03/10/2026
Native clip one frame short, overlapped ambience head clipped, proxy expression/point writes fail, wide clips acquire bars or a raw source reader appears one frame early → [La Rinconada native fixes](LA_RINCONADA_NATIVE_FIXES.md).


## User corrections — 03/10/2026
HD timeline created silently, nonlocal scenery under a literal place clause, generic action mismatches → [tìm đúng đối tượng](../stages/02_SOURCE_BATCH.md) và [timeline/output 4K](../stages/04_RESOLVE_CONNECT.md).
