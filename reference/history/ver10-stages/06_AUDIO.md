# Lịch sử ver 10 — chỉ tra lỗi kỹ thuật

Quy tắc hiện hành ở START_HERE và stages của ver 11; lịch sử không được ghi đè chỉ đạo mới.

# 06 — Background music, ambience xuyên phim, SFX intro

**Quy tắc mới 28/09/2026:** tìm nhiều background music; **SFX chỉ cần tìm/dựng cho chương đầu (intro)**. Các chương còn lại dùng ambience background xuyên phim cùng nhạc phù hợp; không mặc định thêm action SFX mỗi chương.

1. Đầu tiên đọc [kho Music](../../AUDIO_LIBRARY.md), lọc catalog theo mood/role và nghe đúng range. Dùng shortlist bước 02, kết hợp nhạc đã có với nhạc mới; chỉ tìm thêm cho mood/năng lượng/range còn thiếu hoặc cần tránh lặp. Không coi các file short/full/MP3/WAV của cùng bài là nhiều bài mới. Tạo nhiều lựa chọn music theo hook/căng thẳng/đời sống/lịch sử/kết; ví dụ 3–5 preview mỗi mood là điểm bắt đầu, không phải hạn ngạch mua. Nghe preview, chọn/tải trực tiếp qua GetHinh trong ngân sách; lưu cue + range + lý do. Nhiều lựa chọn không buộc đổi bài ở từng cảnh.
2. Ambience phủ toàn phim: biển/gió/cảng/phòng/đời sống phù hợp không gian, mức thấp, crossfade giữa không gian. Một file ambience đã được user chỉ định có thể làm bed dài; tránh loop nghe lộ hoặc tiếng không hợp hình. Không trình bày recording nơi khác như âm thanh thực địa Tristan.
3. SFX intro bám hành động thật, thường một shot, tối đa hai shot liền kề cùng hành động; fade hai đầu. Giữ sạch lời reporter. Ngoài intro không cần săn SFX riêng, trừ yêu cầu cụ thể mới.
4. VO rõ nhất. Gain music −12…−15dB chỉ là điểm bắt đầu tương đối; đo/nghe **đúng source window đã cắt**, sau xử lý và trong mix với VO. Không áp LUFS của cả file nguồn cho mọi đoạn. Duck/fade theo chỗ lời nhỏ, nhạc peak, chuyển chương và cuối phim.
5. Kiểm audio gốc stock riêng: track audio có thật không, có im lặng/lời/nhạc lạ không, provenance/quyền dùng có đủ không. ASR không phát hiện lời chưa chứng minh audio dùng được. Dùng nguồn dedicated đã kiểm nếu chưa rõ.
6. Cue không overlap cùng role/processing dùng chung lane; overlap thật cần lane riêng. Giữ timing chính xác, không cắt mất 1 frame để ép gọn.

Sau lựa chọn, ghi project/cue/range/mood và asset_id kho vào cue sheet. Âm thanh mới có file nguồn/probe/provenance đạt phải được copy vào Music; giữ original và đường timeline cũ nguyên trạng.

**Checklist hoàn tất**
- [ ] Đã kiểm Music trước search mới, có ghi lựa chọn reuse/new và kiểm lặp.
- [ ] Có nhiều lựa chọn music đã review và cue lựa chọn rõ, trong ngân sách.
- [ ] Ambience phủ suốt hình/VO; khoảng im lặng có chủ ý phải ghi lý do.
- [ ] Action SFX chỉ ở intro, khớp range hình, fade in/out.
- [ ] Đo cue trim + mix, nghe VO nhỏ/nhạc peak/loop/transition/ending; không clipping/che lời.
- [ ] License/attribution và chi phí đúng; ghi phạm vi đã nghe, không gọi numerical QC là nghe xong.

**Gate 06 đạt → [07](../../../stages/07_TEXT.md).**


## Instruction theo script và nhạc nghe được xuyên phim — 01/10/2026

- Ảnh/bảng mood tham khảo chỉ là gợi ý. Đọc script thực tế, nhận ra chuyển biến và lập bảng instruction trước khi tạo nhạc: mốc VO, sự kiện/cảm xúc, nhạc cụ, nhịp, diễn tiến, khoảng dành cho lời và prompt. Một chương có thể cần nhiều cue; không gán một nhóm nhạc chung cho mọi tình huống. Ví dụ hồi hương có thể đi tiếp sang mất mùa/thu nhập thấp, nên không mặc định nhạc chiến thắng hoặc vui ở cả chương.
- Khi dùng ACE, tạo nhạc theo bảng riêng của phim. Giữ lyrics=[Instrumental], prompt không lời, WAV gốc, model/seed/task ID và các trường tempo/key/duration. Không nhập VO hoặc script làm lời bài hát. Nhạc AI không phải âm thanh thực địa.
- Clip phủ kín timeline chưa chứng minh có nhạc nghe được: bản sinh có thể kết sớm, nghỉ hoặc nhỏ gần bằng im lặng. Kiểm waveform/mức từng cửa sổ ngắn sau trim/duck và trong bản xuất. Nếu user yêu cầu nhạc luôn có, bổ sung cue/độ dài hoặc loop có crossfade; dùng nền nhạc hòa âm phù hợp để bù các khoảng nghỉ, giữ ambience ở track riêng. Fade mở/kết phải có chủ ý.
- Chọn đoạn loop có nhạc thật, duy trì hòa âm, làm mềm điểm nối và biến thể hợp lý. Giữ phiên bản chưa loop và không đếm loop/biến thể gain thành tác phẩm mới. Có thể fit nhẹ bằng atempo giữ cao độ; ghi source range/tỷ lệ thực, không kéo dài quá mức.
- Đừng hạ toàn cue theo một peak hiếm đến mức nhạc mất nghe. Normalize theo cửa sổ thực, kiểm dynamic/peak, xử lý transient vừa phải và duck để VO rõ. Mức nhạc/floor là quyết định cho từng phim, không lấy con số Tristan làm preset bắt buộc cho mọi phim.
- Thay nhạc trên bản native có checkpoint, bảo toàn hình/VO/sửa tay; đọc lại range và track sau save. Cần kiểm cả contribution của nhạc trong export thực, không chỉ file WAV standalone. Đo kỹ thuật không thay thế nghe cảm xúc/chuyển nhạc/độ rõ lời.

**Evidence Tristan v27:** 15 cue theo diễn tiến truyện + 4 nguồn nền nhạc kéo dài; 10 bản ACE bổ sung. Loop 2s, chuyển cue 4s, kiểm music RMS từng giây; mức thấp nhất phần thân −44.56dBFS, không còn cửa sổ dưới ngưỡng kiểm −46dBFS. VO/hình/ambience/local sound readback giữ đúng; export 47,236 frame và contribution nhạc native đã kiểm. Chưa nghe thủ công toàn bộ phim. Tham chiếu: `E:/Youtube AI/MoneyPrinter2/artifacts/tristan-da-cunha-production-v01/music-ace-v27/` (`music-instruction.md`, `arrangement.json`, `native-readback.json`, `rendered-music-integration.json`, `qc-final.json`, `correction-record.json`).
