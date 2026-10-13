# La Rinconada — measured native fixes, 03 October 2026

Project/build: Resolve Free 21.0.2.4, MCP 4.8.22, timeline `6113cfbc-6bc7-4f95-a950-22d67bd82d55`, 24fps. These observations apply to the tested build and operations; do not transplant this film’s timecodes, source IDs or count into another film.

## LRN-01: different source FPS and native durations
Evidence: native checkpoint, `resolve/native-manifest.json` and `tools/fix_native_mixed_fps.py` in the film workspace. 54 native items initially shortened by one timeline frame after append. Correct the measured append boundary once, read duration/start/end back, and preserve the requested versus corrected source bounds. Do not rerun the corrective increment on already repaired clips. Final readback: 327 placements, zero gaps and zero timeline binding mismatches. Source-frame end conventions differ across rates; do not infer timeline duration from an unqualified raw source-end value.

## LRN-02: long PNG still plates
Resolve imported a still with a short default duration. A prepared CFR plate with sufficient EOF length carried the original image and editable Fusion labels; classification remained still. Preserve original/provenance. Plate render completion is not native proof: inspect native frames and actual end/duration.

## LRN-03: ambience overlap on the same track
Evidence: `evidence/native-ambience-overlap-correction.json`, `native-final-audio-audit.json`. Appending overlapping beds to the same A3 caused the next bed’s first 96 frames to be displaced/clipped. Alternate A3/A7 for fades and assert each full start/end against the plan. Final eight beds occupy their intended ranges; all active music/SFX/ambience is Epidemic Sound by this film’s explicit override. Original detached footage sound is preserved on disabled A5.

## LRN-04: bridge Fusion point values and expressions
Evidence: `native-graphic-contrast-fix.json`, exported native comps, 19 final graphic frames and 42 title in/hold/out frames. A point reader returns numeric-string keys; passing that dictionary to SetInput did not change the center. Write points as `[x,y]`, then read back and inspect. This bridge proxy also does not support Python attribute/index writes to inputs; the attempted expression batch failed. On the tested build, Tool.SaveSettings → bounded edit of that tool’s Blend expression → Tool.LoadSettings preserved graph connections and produced verified fades. Keep the settings backup and validate input links afterward. Item indexes in the MCP locator are zero-based. Do not assume a successful JSON response proves a native effect.

## LRN-05: cover and semantic crops
Evidence: `native-cover-correction.json`, 75 head/middle/tail native frames; `native-anonymous-care-crop.json`, three native care frames. Sources slightly wider than 16:9 acquired bars with default fit. Native cover zoom was measured from source DAR and adjusted slightly; the changed regions were then inspected. A face-bearing generic family clip was replaced by a reviewed bounded crop of hands/fabric so it does not identify people as local residents. Source identity/provenance and VO/timing were preserved. Recheck action, borders and critical labels at crop extrema; no universal crop percentage.

## LRN-06: measured quiet music passages
Evidence: `arranged-audio-measurements.json`, exact enabled native cue ranges. Quiet entrance material and a cue boundary left avoidable low-energy spans. M01 now enters at a reviewed interior source range; M11 begins four seconds earlier, with intended fades. A brief interior musical rest remains natural. Numerical PCM summing gives a sample peak around −1.99dBFS; this is not native bus measurement, true-peak certification or subjective listening. Log the actual listening scope and leave the user’s final listening review explicit.

## LRN-07: source-reader floating-point precision and media TC
Evidence: `native-source-start-quantization.json`, `native-final-qc-20261003.json`. Eleven non-zero-TC files showed raw GetSourceStartFrame one below the requested value. Independently normalize GetSourceStartTime by the media Start TC and exact source FPS, then round: all eleven match the requested source start. Cause is inferred to be precision/truncation; do not “repair” an already correct placement solely from the raw reader. Non-drop-frame parsing was confirmed for these files. A different drop-frame regime requires its own correct parser. File-relative frame counts and TC seconds must not be mixed.

## LRN-08: current records must follow native changes
Evidence: final native/audio reports, 21-cue Epidemic usage record, project profile and refreshed DRP. Early project metadata still named an old timeline and Envato-only audio; scene/asset rows retained planning-only statuses. Synchronize actual source/derivative path, native bindings, track status, superseded overrides and verified cue ranges after edits. Retain historical acquisitions and rights limitations. Record the actual downloaded sources and cues without claiming unused items were placed or listened to. Self-checks are not permission gates; saved/open timeline handoff does not require a full-film export.

## Evidence and limits
Working root: `E:/Youtube AI/MoneyPrinter2/artifacts/la-rinconada-production-v01`. Final report is `evidence/native-final-qc-20261003.json`; 139 affected native frames were rendered and viewed (cover75/title42/graphic19/care3), with earlier input reviews retained. No full-film watch/render or subjective audio listening is claimed. Examples below are native snapshots of this film, not newly approved global defaults.

- [Native chapter](../visuals/la-rinconada-native/chapter.jpg)
- [Native location](../visuals/la-rinconada-native/location.jpg)
- [Native fact/mechanism](../visuals/la-rinconada-native/fact.jpg)
