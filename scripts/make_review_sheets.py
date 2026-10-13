#!/usr/bin/env python3
"""Build small review images for Claude gates C3/C4 (Hidden Chapters playbook ver 31).

  clips  CSV columns: id,path,in_s,out_s  -> <out>/<id>.jpg = first|middle|last frame of the usable range
  pairs  CSV columns: id,original,processed -> <out>/<id>.jpg = original|processed side by side

Needs ffmpeg/ffprobe on PATH (or --ffmpeg). Writes only into --out; never touches sources.
Images are review proxies for meaning/facts checks only: they do not prove motion, audio, rights or native 4K.
"""
import argparse
import csv
import json
import os
import subprocess
import sys
import tempfile


def run(cmd):
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode != 0:
        raise RuntimeError(r.stderr.strip()[-600:])
    return r.stdout


def grab(ffmpeg, src, t, dst, height):
    run([ffmpeg, "-v", "error", "-y", "-ss", f"{max(t, 0):.3f}", "-i", src, "-frames:v", "1",
         "-vf", f"scale=-2:{height}", "-q:v", "3", dst])


def hstack(ffmpeg, inputs, dst, height):
    cmd = [ffmpeg, "-v", "error", "-y"]
    for i in inputs:
        cmd += ["-i", i]
    scaled = "".join(f"[{n}:v]scale=-2:{height},pad=iw+8:ih:0:0:white[v{n}];" for n in range(len(inputs)))
    labels = "".join(f"[v{n}]" for n in range(len(inputs)))
    cmd += ["-filter_complex", f"{scaled}{labels}hstack=inputs={len(inputs)}", "-frames:v", "1", "-q:v", "3", dst]
    run(cmd)


def do_clips(a, rows):
    out = []
    for r in rows:
        rid, src = r["id"].strip(), r["path"].strip()
        t0, t1 = float(r["in_s"]), float(r["out_s"])
        end = max(t0, t1 - 0.1)
        with tempfile.TemporaryDirectory() as tmp:
            frames = []
            for n, t in enumerate((t0 + 0.05, (t0 + t1) / 2, end)):
                f = os.path.join(tmp, f"{n}.jpg")
                grab(a.ffmpeg, src, t, f, a.height)
                frames.append(f)
            dst = os.path.join(a.out, f"{rid}.jpg")
            hstack(a.ffmpeg, frames, dst, a.height)
        out.append({"id": rid, "sheet": dst, "times_s": [round(t0 + 0.05, 3), round((t0 + t1) / 2, 3), round(end, 3)]})
    return out


def do_pairs(a, rows):
    out = []
    for r in rows:
        rid = r["id"].strip()
        dst = os.path.join(a.out, f"{rid}.jpg")
        hstack(a.ffmpeg, [r["original"].strip(), r["processed"].strip()], dst, a.height)
        out.append({"id": rid, "sheet": dst, "left": "original", "right": "processed"})
    return out


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("mode", choices=["clips", "pairs"])
    p.add_argument("--csv", required=True)
    p.add_argument("--out", required=True, help="packet folder, e.g. <ws>\\collab\\packets\\<call_id>")
    p.add_argument("--height", type=int, default=540)
    p.add_argument("--ffmpeg", default="ffmpeg")
    a = p.parse_args()
    os.makedirs(a.out, exist_ok=True)
    with open(a.csv, encoding="utf-8-sig", newline="") as fh:
        rows = list(csv.DictReader(fh))
    done, failed = [], []
    for r in rows:
        try:
            done += (do_clips if a.mode == "clips" else do_pairs)(a, [r])
        except Exception as exc:  # report and continue with the rest of the batch
            failed.append({"id": r.get("id"), "error": str(exc)})
    manifest = os.path.join(a.out, f"sheets-{a.mode}.json")
    with open(manifest, "w", encoding="utf-8") as fh:
        json.dump({"mode": a.mode, "sheets": done, "failed": failed}, fh, ensure_ascii=False, indent=2)
    print(json.dumps({"made": len(done), "failed": failed, "manifest": manifest}, ensure_ascii=False))
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()
