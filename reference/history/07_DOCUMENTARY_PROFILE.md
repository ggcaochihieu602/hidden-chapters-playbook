> LỊCH SỬ — không phải quy tắc hiện hành. Ver 2/START_HERE và chỉ đạo mới ưu tiên. Chỉ đọc phần được bước hiện tại trỏ tới.

# Quyết định: tiếp tục MP2, thêm profile documentary điều khiển qua chat

Ngày 26/09/2026. Yêu cầu mới của người dùng có ưu tiên hơn quy tắc V005 cũ khi bật profile này.

## Vì sao chưa tạo PR4

Khác biệt hiện tại là cách biên tập, lựa chọn cảnh và điều phối công cụ; không phải nhu cầu có một hệ lưu trữ, render hay xuất bản khác. MP2 đã có project, job, media library, timeline, Kdenlive, QC và YouTube scheduling. Tách app sẽ phải đồng bộ hai kho media, hai hệ trạng thái và hai nơi sửa lỗi. Chọn một lõi MP2, profile `documentary_reference_v1` bật riêng từng project. Có thể đặt tên giao diện sau, nhưng không fork toàn bộ code.

ChatGPT là nơi nhận yêu cầu và ra quyết định nội dung. MP2 lưu yêu cầu thành dữ liệu có revision/hash, thực thi các job cụ thể và báo tiến độ. Dashboard hiện có tiếp tục theo dõi project/job/render/đăng bài. API documentary bổ sung view kế hoạch + workflow + publication, không tạo một editor/UI mới.

Chỉ cân nhắc tách ứng dụng khi cần vận hành độc lập trên máy khác, quyền truy cập khác hoặc công nghệ render không dùng chung được; một format video khác chưa đủ lý do.

## Kịch bản: tái sử dụng prompt hiện tại

**Cập nhật từ người dùng:** người dùng sẽ cung cấp và cập nhật các kịch bản mẫu riêng. Với mỗi kịch bản được cung cấp, đọc và rút kinh nghiệm về hook, luồng kể, cách chuyển ý, diễn đạt, nhịp câu, giải thích và payoff; lưu nhận xét có nguồn/revision để dùng cho dự án sau. Phân biệt thủ pháp dùng được rộng rãi với lựa chọn chỉ phù hợp chủ đề đó. Không coi một mẫu là khuôn duy nhất, không tự lấy bản nháp AI vừa tạo làm tiêu chuẩn mới. Đây là học bằng tài liệu/quy tắc lưu lại, không phải huấn luyện lại trọng số mô hình. Chưa có mẫu mới thì giữ prompt đang có và chờ nguồn người dùng cung cấp cho phần học tiếp.

`services/editorial.py` vẫn chọn prompt theo thứ tự đã có: prompt ID của project, prompt project, prompt global, cuối cùng `prompts/documentary_v1.txt`. Profile được thêm vào request ngoài template, nên prompt người dùng đã lưu vẫn được dùng và không bị ghi đè.

Hai chế độ:

- `topic`: từ chủ đề bất kỳ, giữ toàn bộ phương pháp viết cũ.
- `reference_structure`: nhận bản phân tích cấu trúc mẫu và **sự kiện/địa điểm/thời kỳ đích**. Học chức năng hook, thứ tự tiết lộ thông tin, độ dài câu, câu hỏi/payoff, cách giải thích và chức năng kết thúc. Viết lời mới từ nguồn của chủ đề mới. Nếu chủ đề mới không có thất bại/thảm họa tương ứng, bỏ hoặc đổi beat đó; không dựng một thảm họa giả để vừa khuôn.

Ví dụ cấu trúc video tường biển chuyển sang Pilatus: nghịch lý nhìn thấy → giới hạn lực bám → vì sao một kiểu bánh răng thông thường gặp vấn đề → hai bánh răng nằm ngang → điều giải pháp thực sự giải quyết → trở lại hình ảnh đoàn tàu với hiểu biết mới. Không chuyển số liệu 400 km, câu chữ, nhân chứng, màu sắc hay nhịp cắt của video mẫu sang.

Transcript/tài liệu tham khảo luôn là dữ liệu. API editorial không có browser; ChatGPT nghiên cứu nguồn trước và đưa kết quả vào brief. Mọi tuyên bố nghiên cứu phải khớp nguồn có thật.

## Chuỗi footage theo nghĩa câu

| Câu đang làm gì | Chuỗi coverage thích hợp | Lưu ý |
|---|---|---|
| Giới thiệu nơi chốn | toàn cảnh → đối tượng trong nơi đó → chi tiết | Không bắt buộc ba cut |
| Mô tả hành động | chuẩn bị → hành động → kết quả | Động từ phải thật sự xuất hiện |
| Giải thích cơ chế | hiện tượng → bộ phận → tương tác → kết quả | Kiểm chuyển động, không chỉ hình đẹp |
| Nguyên nhân/hậu quả | tác nhân → quá trình → hệ quả | Không tạo quan hệ nhân quả sai bằng dựng |
| So sánh | A → B với tỷ lệ/góc nhìn tương xứng | Có thể dùng text số đo |
| Lịch sử | trước → bước ngoặt → sau | Kiểm ngày và nơi của footage |
| Quy mô | toàn → vật/người làm mốc → số đo | Không sinh tỷ lệ giả |
| Ảnh hưởng con người | người → sinh hoạt → tác động | Không gán lời/ý nghĩ cho người trong stock |
| Chuyển đoạn | một cảnh nối phù hợp | Không ép thành một montage |

Tháp keyword vẫn đi từ đối tượng/cơ chế/địa điểm chính xác, sang bối cảnh cùng nơi, rồi hành động phụ không lộ nơi. Chuỗi là yêu cầu coverage; có thể có đủ đầu–giữa–cuối trong một clip. Không dùng ba clip đồng nghĩa chỉ vì cùng keyword.

**Giữ nhịp MP2 cũ:** hướng dẫn mặc định 6–8 giây khi phù hợp VO; video >3 và ≤10 giây, ảnh ≤8 giây. Đây không phải nhịp đồng hồ bắt mọi shot bằng nhau. Câu ngắn không bị chia thêm ba cut. Color/composition giữ nguyên project, chưa áp preset giống video mẫu.

## Reporter và cơ chế AI

### Chỉ đạo mới: người kể chuyện thứ hai, tự nhiên và có mục đích

Các bổ sung playbook 1.2 dưới đây là hướng dẫn/prompt cho ChatGPT điều phối project. Các trường speaker/dialogue là quy ước của shot plan qua chat, chưa phải trường mới trong schema ScriptDocument/ProductionPlan của MP2; khi lưu API hiện có, ghi lựa chọn trong visual_brief/notes và chỉ gửi các trường schema hỗ trợ. Việc cập nhật skill không tự chứng minh một clip tự nhiên hơn đã được tạo hoặc nhạc mới đã tải.

Trong một video, mặc định chỉ chọn **1–2 đoạn reporter**, ưu tiên phần mở đầu để đặt câu hỏi, giới thiệu hiện tượng hoặc dẫn vào cơ chế. Không thêm một host cho mỗi chương. Một đoạn có thể gồm vài câu; tính theo lần xuất hiện liên tục, không theo số câu. Vẫn giữ nhịp dựng đã chốt.

Reporter thực sự nói phần lời của mình. Khi chọn câu từ script, chuyển nó thành lời dẫn trực tiếp, tự nhiên của reporter, bảo toàn sự kiện và ý nghĩa. Ghi rõ trong shot plan `speaker=reporter`, `reporter_dialogue`, câu gốc và vị trí nối với `speaker=main_narrator`; các nhãn này là dữ liệu đạo diễn, không phải chữ được đọc. Không để VO chính đọc lại/đè lên cùng lời khi reporter đang nói. Nếu VO master đã có, ghi đúng range thay bằng lời reporter và bảo toàn các đoạn còn lại. Nếu người dùng khóa script nguyên văn, giữ câu chữ và chỉ phân vai; không tự viết lại bản khóa.

Chọn hành động từ ý nghĩa câu và vật thể thực sự có trong khung hình:

- Mở đầu/định vị: cầm mic không logo, nhìn máy quay, chuyển trọng tâm nhẹ, một cử chỉ tay hỗ trợ ý đang nói. Không mặc định hai tay chắp trước bụng.
- Giải thích bánh xe/bánh răng: đứng hoặc ngồi xổm cạnh **đoàn tàu đứng yên**, vị trí/góc máy đủ thấy chi tiết; nhìn xuống bộ phận, dùng tay rảnh chỉ đúng chỗ khi nói đến nó rồi nhìn lại máy quay. Không bịa bộ phận hay chỉ vào vị trí ngoài khung hình.
- Mô tả địa hình/quy mô: xoay mắt/thân nhẹ về vật thể, chỉ vào vị trí đúng rồi trở lại người xem. Không dùng cùng một động tác cho mọi câu.

Mỗi clip ngắn ưu tiên một hành động chính và cử động nhỏ tự nhiên: hơi thở, nháy mắt, ánh nhìn, nhấn giọng/nhịp tay hợp lời. Nếu phải ngồi xuống mà thời gian không đủ, bắt đầu cảnh ở tư thế ngồi xổm; không nhồi đi bộ–ngồi–chỉ–đứng dậy vào 8 giây. Cập nhật ảnh ghép theo tư thế, mic, độ cao máy quay và đối tượng trước khi tạo video nếu cần; giữ nguyên identity/trang phục và bối cảnh đã khóa. Camera có thể theo chuyển động nhẹ khi có lý do, không bắt mọi cảnh đứng cứng trước máy.

**Khung prompt reporter dùng lại** (điền từ cảnh, không gửi nguyên dấu ngoặc):

```text
Use the attached reporter identity, location and composed scene references.
Preserve the same face, outfit, location and object geometry throughout.
Context: [exact script meaning and the visible object being explained].
Starting pose and blocking: [standing with microphone / already crouched beside the stationary train].
Primary action: [one purposeful action tied to an exact spoken phrase].
Gaze: [camera -> indicated component at the relevant words -> camera].
Prop continuity: [mic held consistently in one hand; the free hand points accurately].
Reporter says exactly: "[adapted reporter dialogue]".
Delivery: conversational, engaged and unhurried; natural breathing, blinks and small weight shifts.
Camera: [framing that shows both face and relevant component; stable or a small motivated follow].
Sound: reporter speech clearly dominant; [appropriate quiet scene ambience]; no overlapping narrator.
Avoid frozen posing, repetitive gesturing, wandering gaze, extra fingers, changing microphones,
pointing at the wrong component, obscuring the mechanism, face drift or invented machinery.
One continuous shot; [duration matched to dialogue and established MP2 pacing]. No baked-in captions.
```

Ví dụ chuyển lời: narrator “Two horizontal cogwheels engage opposite sides of the rack.” → reporter “Look at where these teeth meet the rack—one wheel on each side.” Chỉ dùng câu chỉ trỏ khi hình thật sự thể hiện đúng điểm ăn khớp. Với mẫu kỹ thuật, lời đơn giản hơn vẫn phải giữ đúng cơ chế.

Reporter: identity reference → script span có lý do cần host → background theo đúng ngữ cảnh → ảnh ghép → prompt mô tả vai trò từng ảnh → upload các ảnh thực tế → nhận media IDs → submit references-to-video → tải và kiểm. Lưu hash ảnh và prompt để cache không dùng nhầm nhân vật cũ. Nếu upload không xác nhận, không bỏ ảnh để âm thầm gửi text-only.

Reporter là nhân vật hư cấu dẫn chuyện. Background thử ở Alps là minh họa tổng quát; không chứng minh reporter đứng tại Pilatus. Pilot này không dùng mặt reporter trong video tham khảo. Khi địa hình/kiến trúc cụ thể quan trọng, nghiên cứu ảnh thật và duyệt địa lý trước khi tạo background.

Giữ giọng reporter ổn định là công việc riêng với giữ mặt: chốt voice reference/preset, tốc độ, accent và câu test. Pilot hiện mới dùng giọng do Flow sinh từ chỉ dẫn; chưa chứng minh đồng nhất giọng qua nhiều clip. Theo [Google Flow Help](https://support.google.com/flow/answer/16353334?hl=en), Ingredients có thể nhận visual references và voice references. Adapter MP2 mới nối ảnh, chưa nối voice reference.

Cơ chế: tìm stock phù hợp có giới hạn → ghi rõ chỗ thiếu → nghiên cứu nguồn kỹ thuật → chọn treatment tương thích đoạn phim (mô hình thực nghiệm/cutaway/photographic, không mặc định một màu) → prompt một tương tác rõ → generation → kiểm geometry/contact/direction/continuity theo thời gian. Không dùng một animation đẹp nhưng sai cơ khí làm bằng chứng. Cảnh Locher trước đây chưa được duyệt kỹ thuật vẫn giữ trạng thái đó.

## Text và sound

Text cue có loại location/fact/person, nội dung ngắn, mục đích, exact VO anchor và evidence. Chọn text để định vị, ghi mốc, giữ con số/khái niệm trong trí nhớ hoặc làm so sánh; không nhắc lại toàn bộ subtitle. Tránh chồng card và vùng phụ đề. Ghép timestamp sau khi có VO thực tế. Overlay API hiện có vẫn bảo toàn saved edit; bổ sung `max_facts_per_chapter` (mặc định 1 để tương thích, cho phép tăng có chủ đích tới 6). Không mặc định chèn thêm nhiều số liệu.

Âm thanh theo vật thể và hành động nhìn thấy: bánh tàu/đường ray, sóng biển, gió, mưa, tiếng máy, phòng kín. Ambience nối không gian; action SFX khớp thời điểm chuyển động. Chỉ dùng whoosh khi có lý do cụ thể, không dùng như dấu câu tự động. Nhạc nền thưa và không lấn lời; chọn thêm sau khi nghe VO/ambience, không dùng gain cố định làm bằng chứng mix đạt.

GetHinh là đường tìm/lấy nguồn người dùng cho phép; có thể tìm trên Envato rồi đưa URL item sang GetHinh. Lưu item/preview/quyền sử dụng; chỉ báo downloaded khi file thật có trên đĩa và probe đạt. API RapidAPI Envato và GetHinh website là hai đường khác nhau, không gọi việc một đường thành công là đường kia đã tích hợp. Kế hoạch sound mới tạo query/role/sync anchor; tải/chọn/mix vẫn dùng các đường audio hiện có và thao tác qua chat, chưa có adapter GetHinh tự động mới.

**Chỉ đạo tìm và tải nhạc:** nếu brief chỉ rõ bài/URL/file nhạc thì dùng chỉ định đó. Nếu brief không chỉ rõ, hoặc chỉ cho mood/keyword như ảnh người dùng cung cấp, ChatGPT chủ động lập kế hoạch nhạc theo script, tìm ứng viên, nghe preview khi công cụ hỗ trợ, chọn và **trực tiếp tải qua GetHinh** trong phạm vi ngân sách/quyền truy cập của project. Không dừng ở danh sách từ khóa hoặc bắt người dùng tự chọn bài. Không dùng ngân sách thử nghiệm cũ làm hạn mức cho mọi dự án; chỉ cần hỏi phần thông tin chi phí thực sự thiếu khi nó chặn bước trả phí. Nếu không nghe được, ghi rõ giới hạn duyệt và không khẳng định đã nghe.

Lập cue theo các khối ý/cảm xúc của script: vai trò âm nhạc, mật độ, năng lượng, nhạc cụ, có/không giai điệu, đoạn vào/ra dự kiến, keyword và lý do chọn. Một bài có thể đi qua nhiều câu/cảnh; không thay nhạc ở từng cut. Chọn ít bài phù hợp, nối/fade theo diễn biến và VO, giữ ambience/action SFX thành các lớp riêng. Sau tải, kiểm file giải mã/probe, lưu item URL, đường dẫn, hash, license/evidence, chi phí và cue dự kiến. Website báo đang tải chưa phải hoàn tất. Nếu GetHinh lỗi, ghi blocker cụ thể và giữ lựa chọn để tiếp tục; không gọi một đường tải khác là GetHinh.

Các nhóm trong **ảnh người dùng** là ví dụ xây keyword, không phải năm bài cố định hay yêu cầu mọi phim phải có piano/orchestra:

| Ngữ cảnh script | Hướng nhạc | Query mẫu |
|---|---|---|
| Mở đầu/kết suy ngẫm | Chậm, thoáng, piano khi phù hợp | `documentary cinematic piano instrumental`; `soft ambient piano reflective` |
| Cơ khí/núi cao chính xác | Đều, có cấu trúc, không kịch tính giả | `precision mechanical ambient instrumental`; `mountain engineering cinematic underscore` |
| Con người/nhịp sống | Ấm, nhẹ, nhịp con người | `warm ambient documentary human rhythm`; `gentle world instrumental market` |
| Công nghiệp/quy mô/khắc nghiệt | Rộng, kéo dài, ít giai điệu | `vast landscape ambient drone instrumental`; `industrial cinematic atmosphere instrumental` |
| Lịch sử/trường tồn | Trang trọng, chậm, có chiều sâu | `historic cinematic strings instrumental`; `dignified documentary orchestral ambient` |

Đổi query theo chính chủ đề/mạch cảm xúc đang dựng. Nhạc ambience vẫn là nhạc; tiếng tàu/gió/nước là âm thanh môi trường/hành động. Chọn và phối cả hai theo nhu cầu, không dùng lớp này thay thế máy móc lớp kia.

## API cho chat

- `PUT /api/v1/projects/{id}/documentary/config`: bật profile, chọn topic/reference, reporter. Không sửa global settings.
- `POST .../documentary/reference`: title + transcript → cấu trúc trừu tượng qua provider editorial đã cấu hình. Một request có chi phí nếu dùng API; cache như MP2.
- Script job hiện có tự nhận profile khi gọi `generate_script`.
- `GET .../documentary/planning-request`: prompt + schema sản xuất đầy đủ cho ChatGPT.
- `POST .../documentary/plan`: `{base_revision, plan}`; kiểm câu/VO anchor, giữ revision, chưa đánh dấu media đã làm.
- Search planner hiện có nhận plan hợp lệ cùng rules chuỗi; cache bỏ qua plan cũ khi script/profile thay đổi.
- `POST .../documentary/video`: đúng beat, purpose reporter/mechanism, prompt, paths ảnh, duration và credit_limit → một job `documentary_video`. Cơ chế cần research_sources và stock_search_gap. Reporter cần bật và có reference.
- `GET .../documentary`: config, policy, plan/stale, workflow và publication thật. Kế hoạch được tách khỏi trạng thái render/đăng bài.

Flow Kit API upload + reference submission được kiểm thử bằng HTTP mocks. Pilot tạo thật dùng UI Flow vì bridge từng lỗi quyền Google/CAPTCHA. Không coi readiness là một lần generation thành công. Chưa nghiệm thu production automation từ đầu đến cuối bằng brief thứ hai.

## Thứ tự phát triển tiếp

1. Dùng profile mới cho một project thật ngắn, chốt script và production plan qua chat; mọi lựa chọn và ngoại lệ được lưu lại.
2. Khóa voice reporter và thử 2–3 bối cảnh với cùng identity trước khi mở rộng nhiều host clip.
3. Nối stock gap/research/temporal QC vào fallback tự động; nâng duyệt video theo hành động cần thấy.
4. Nối cue text/audio đã duyệt vào timeline theo word timestamps, kiểm độ rõ VO và đồ thị loudness.
5. Đánh giá một phim hoàn chỉnh với brief chưa chuẩn bị riêng: độ đúng cảnh, công chỉnh tay, chi phí/ phút, số lần generation lại. Chỉ sau đó quyết định phần nào đáng tự động hóa thêm.

Publication dùng luồng duyệt/channel/artifact/time có sẵn; profile không tự đăng bài.
