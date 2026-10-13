# 04 — Kiểm MCP/GitHub, kết nối và test đoạn nhỏ

## Đầu vào
**Chỉ vào bước này khi 03 đã đạt** (phim mới), hoặc phim đã có timeline/nhiệm vụ sửa trên timeline. Khi vào: nếu Resolve chưa mở, báo người dùng một câu để mở; trong lúc chờ không làm lại 01–03.
Project/timeline mục tiêu, fps/origin, prepared media và checkpoint. [Cài/khôi phục](../reference/RESOLVE_MCP.md).
## Việc làm
1. Đầu mỗi phiên MCP: `resolve_control(action="mcp_update_status", params={"force_check":true})`; ghi checked_at, installed/latest, release URL. Đọc changelog khi có update; kiểm tra tự động **không có nghĩa tự nâng ứng dụng/đổi server đang dựng**. Nếu cần cập nhật, checkpoint + chính thức installer + rollback/reconnect; không reset local edits.
2. Đọc project/timeline/version/fps/origin qua API. **Đọc lại timeline width/height và output width/height: mặc định đều 3840×2160, 16:9**, dùng custom timeline settings khi build yêu cầu. Proxy/preview/source nhỏ không cho phép hạ timeline. Nếu bản HD tạo sai, giữ nguyên bản cũ, tạo timeline 4K mới/copy bảo toàn VO/media/timing/audio/sửa tay/Fusion; so bindings và kiểm native crop/text sau chuyển, save checkpoint. Không dựng tiếp trên bản HD chưa sửa. Resolve mở không chứng minh bridge chạy. Free 21.0.x dùng Workspace → Scripts → resolve_bridge; build mới kiểm upstream, không suy compatibility. Không in token/config bí mật.
3. Import/readback nguồn: so số file yêu cầu với từng native clip/path/type, không lấy imported count làm đủ nguồn. Ảnh đánh số liên tiếp có thể bị Resolve ghép thành image sequence, JFIF có thể bị bỏ qua. Khi gặp thực tế: giữ original, tạo bản copy byte-identical trong folder riêng cho từng canonical asset, đặt extension JPEG phù hợp, so hash và import lại; đọc Type=Still cho từng ảnh. Chuyển các chuỗi tự ghép do agent vừa tạo, chưa dùng trong timeline, sang bin không dùng; không xóa clip/sửa tay của người dùng. Ghi alias→canonical ID để không tính bản copy là nguồn mới hoặc lách no-reuse.
4. Lưu UI state, **render preset/format/mode/marks trước frame capture**, và checkpoint. Smoke graph `Photo → PhotoMotion → MediaOut` cùng local frame range/hold theo [recipe 05](05_ASSEMBLY.md#motion-ảnh-bằng-fusion-native--quy-trình-tái-sử-dụng), test API keyframe/PNG duration trên build thực thay vì mặc định AddTake/Append thành công. Lưu UI state và checkpoint. Dùng timeline thử riêng cho 2–3 cảnh ở đầu vế đã đo: video, ảnh tĩnh có keyframe Zoom/Position native, text; kiểm motion bằng playback liên tục toàn shot và dải frame liên tiếp, không chỉ frame đầu/cuối; xác minh record/source-in/duration, origin và âm thanh. Test khoảng nhỏ một lần trên build/import path đang dùng, không lặp cho mọi clip nếu không đổi hành vi.
5. Xem frame/đoạn ngắn native ở mốc chuyển hình và text; so readback kế hoạch. API trả True không tự là đúng render. Khi test xong trở lại timeline/page/timecode người dùng; save checkpoint.
## Quyết định
Không xuất full để thử bridge. Không chạm project phim nếu nhiệm vụ chỉ cập nhật tài liệu; template thử trên timeline riêng. Frame capture có thể đổi render marks: set explicit range nếu render mẫu; không làm lúc render khác đang chạy.
## Đầu ra
Update record, native baseline và evidence smoke test hoặc blocker cụ thể.
## Checklist
- [ ] Kiểm GitHub đầu phiên, status thực: current/update_available/check_failed.
- [ ] Đọc được đúng native project/timeline/fps/origin; cả timeline và output 3840×2160 hoặc override rõ.
- [ ] Nếu sửa HD, bản cũ giữ nguyên và bản 4K mới có bindings/manual edits/Fusion đã kiểm.
- [ ] Readback imported file/path/type/count khớp nguồn; ảnh riêng là Still, alias giữ hash/canonical ID, chuỗi tự ghép không đưa vào dựng.
- [ ] Smoke test xác minh timestamp/source-in/frame count, không giả pass.
- [ ] Baseline/UI restored; không thay scope người dùng.
## Ví dụ
Một cut đặt tại đầu vế B phải xuất hiện ở frame kế hoạch, không chỉ có tên source B trong manifest. EndFrame convention phải đo trên build thật.
## Sửa lỗi
Connection refused → bridge chưa nghe; theo remediation, chuẩn bị nguồn/docs độc lập trong lúc chưa kết nối. Không retry dài liên tục. Mixed-fps lệch → đo source seconds/conform range. Handles cạn → index một lần và batch vừa phải.
## Tiếp tục
Đạt → [05](05_ASSEMBLY.md), hoặc quay lại stage đang làm nếu là phiên tiếp tục 06/07/08. Chi tiết: [native fixes](../reference/TECHNICAL_FIXES.md#resolve).

## Bài học bridge/native đã đo ở ver12
Trước so source endpoint hãy dùng source-time + media FPS để đối chiếu khi GetSourceEndFrame không nhất quán; đo smoke trên build thật. Xem [lỗi và evidence](../reference/TRISTAN_V28_FIXES.md#native-source-end-lệch-một-frame--đã-xác-nhận). Không đổi live server giữa batch.


## Native verification — 03/10/2026
Measured bridge proxy limits and source-reader precision: [LRN-04](../reference/LA_RINCONADA_NATIVE_FIXES.md#lrn-04-bridge-fusion-point-values-and-expressions), [LRN-07](../reference/LA_RINCONADA_NATIVE_FIXES.md#lrn-07-source-reader-floating-point-precision-and-media-tc).

## Bài học ingest Coober Pedy — 03/10/2026
44 ảnh yêu cầu chỉ thành37 native clips:4 chuỗi ghép từ10 ảnh đánh số liên tiếp,1 JFIF bỏ qua. Copy byte-identical11 file vào11 folder riêng, import đọc lại thành44 Still;4 chuỗi agent tạo được giữ trong bin không dùng. Video/audio/VO là review inputs, chưa phải timeline/prep/rights gate.
