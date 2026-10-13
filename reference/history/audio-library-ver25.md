# LƯU TRỮ — đã bỏ khỏi workflow hiện hành từ ver 26

# Kho Music — chỉ tái dùng audio Epidemic phù hợp

## Tra nguồn trước khi tìm mới

`E:\Youtube AI\Hidden Chapters\Music` có Background, Ambience, SoundEffects, Prepared; catalog: `catalog.csv`, `catalog.json`, usage `Projects/`, thiếu nguồn `MISSING_SOURCES.json`. Trước search/download, **lọc provider Epidemic Sound**, kiểm quyền project/kênh và nghe candidate phù hợp. Music/SFX/ambience trong phim đều Epidemic, gồm reuse; audio Envato/ACE/nguồn khác trong kho giữ lịch sử nhưng không chọn/bật theo policy hiện hành. Thiếu truy cập/quyền/nội dung ghi blocker + tiếp tục phần độc lập; không tự fallback hoặc mua gói.

Phối nguồn Epidemic cũ/mới theo script/mood/ranges, không ép tỷ lệ reuse hoặc số tác phẩm. Kiểm usage tránh lặp gần giữa phim. WAV/MP3/full/short/loop/gain variants cùng composition không phải bài mới. Prepared có gain/fade/loop: ưu tiên original để phối lại, giữ derivative/source mapping.

## Lưu bản gốc và variant thực

Copy nguồn mới đã kiểm vào Music, không move working files. Hash/probe, provider/item ID/URL, tác giả, retrieval date, license/entitlement evidence, project/cue/range/mood. Quyền download cũ không tự chứng minh coverage phim/kênh mới. Không đưa audio/credential vào ZIP playbook.

Giữ toàn bộ variant thực đã tải. Nếu có ZIP, giữ `Archives\<provider>\<canonical-ID>\original.zip` và **toàn folder giải nén**, gồm license/readme; dùng tên cũ nếu đã có. Nếu provider chỉ cấp từng file, ghi đúng file/format, không giả ZIP/stems hoặc coi không có ZIP là thiếu gói. Archive cũ thiếu ghi `archive_missing`, không mua lại vô cớ. Không xóa assets lịch sử để thực thi policy.

## Cue và chi phí

Music/ambience có file/cue riêng theo chương/diễn tiến; loop/trim có lineage, không flatten toàn phim thành bed duy nhất. Nhạc nghe được xuyên phim, qua intro 10–20s không VO và pause chương 3–5s. Ambience theo không gian/chương; action SFX tập trung intro, không whoosh text. Audio gốc footage tách vào `Local sound effect` giữ sync/provenance nhưng mute theo policy Epidemic-only; chỉ bật khi user thay yêu cầu.

Ghi actual cost đúng đơn vị. Trần audio 20 xu chỉ giới hạn hệ xu, không cho đổi provider hoặc giả quy đổi subscription. [Nguồn/quyền](MEDIA_SOURCES.md) · [Dựng âm thanh](../stages/06_AUDIO.md).
