> LỊCH SỬ — không phải quy tắc hiện hành. Ver 2/START_HERE và chỉ đạo mới ưu tiên. Chỉ đọc phần được bước hiện tại trỏ tới.

# 06 — Đầu vào và hồ sơ mỗi lần dựng

## Người dùng cung cấp

Tối thiểu: brief (file/link truy cập được), script, VO master. Nếu có: keywords theo chương, nguồn/nhạc mong muốn, asset sẵn có, logo/subtitle, profile đầu ra, ngân sách download/API, project Kdenlive đã lưu. Nếu mọi thứ nằm trong brief, agent tự trích rồi xác nhận phần thực sự còn thiếu; không hỏi lại thông tin đã có.

## Thư mục project đề xuất

```text
inputs/        brief/script/voice/keywords + hashes
planning/      constraints, VO alignment, scene requirements, query plan
sources/       catalog, reviews, license evidence, downloads manifest
generated/     AI/music generation manifests + retained outputs
builds/        versioned Kdenlive + profiles + dependencies
qc/            sampled frames/clips, audio notes, native import checks
reports/       usage/cost, limitations, handoff, lessons
```

Thư mục Downloads chỉ là nơi nhận tệp; import xong gắn provenance vào media catalog. Không coi tên file theo thứ tự tải là ID nội dung bền vững.

## Template kèm theo

- `project-intake.json`: mẫu ghi yêu cầu và ngân sách; **schema planning, không phải request API MP2**.
- `scene-ledger.csv`: mốc VO, role, constraints, chosen source/range và evidence.
- `asset-ledger.csv`: nguồn gốc, kênh tải, hash, review, license và usage.
- `cost-ledger.csv`: dịch vụ/model, attempt/job, unit/currency, actual/estimate/unknown.
- `qc-handoff.md`: checklist kết quả thực; không điền PASS khi chưa kiểm.

Mapping sang API phải lấy schema hiện tại của MP2/OpenAPI hoặc Pydantic model trong repository. `overlay-request.json` của V005 là ví dụ request đã chạy; các path/ID/timing của nó không có ý nghĩa với brief mới.

## Lưu tiến trình để tiếp tục ở chat khác

Cuối mỗi giai đoạn ghi: project ID, latest build và đường dẫn thực; hash base; việc đã làm với evidence; câu/quy tắc mới; budget used/remaining/unknown; job/session đang chạy; lệnh stop/render của user; next step cụ thể. Không gán đã hoàn thành nếu chỉ có kế hoạch.

## Cách cập nhật bộ quy trình

1. Chốt quy tắc mới vào file01, ghi những điều bị thay thế.
2. Ghi lỗi thật vào file04 hoặc lessons chi tiết, tách confirmed/inferred.
3. Cập nhật trạng thái implementation ở file05, không chỉ quảng bá khả năng.
4. Giữ evidence nhỏ (audit/JSON/ảnh mẫu) và cache phân tích, không kèm khóa/phiên đăng nhập vào ZIP.
5. Chạy `scripts/package_brief_edit_playbook.py`; kiểm manifest/ZIP, đồng bộ tài liệu tham chiếu vào skill cá nhân. Tên ZIP theo phiên bản, phát hành mới khi thay đổi đáng kể.
