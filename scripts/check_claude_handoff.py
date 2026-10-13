#!/usr/bin/env python3
"""Codex-side mechanical checks for Claude handoffs (Hidden Chapters playbook ver 31).

Subcommands
  verdict   Validate the JSON block in a saved Claude answer (contract in reference/CLAUDE_COLLAB.md).
  clauses   Verify a clause CSV reproduces the locked narration exactly, in order.
  chapters  Verify chapter timestamps in a description match the chapter table.

Exit code 0 = PASS, 1 = FAIL, 2 = usage/input error. Prints a JSON report to stdout.
Read-only: never edits inputs. Standard library only.
"""
import argparse
import csv
import json
import os
import re
import sys
import unicodedata

STATUSES = {"pass", "fail", "uncertain"}
VERDICTS = {"pass", "fail", "partial"}
REQUIRED = ["gate", "call_id", "canary", "inputs_read", "verdict", "items", "outputs", "not_checked", "assumptions"]


def report(ok, **data):
    data["result"] = "PASS" if ok else "FAIL"
    print(json.dumps(data, ensure_ascii=False, indent=2))
    sys.exit(0 if ok else 1)


def read_text(path):
    with open(path, encoding="utf-8-sig") as fh:
        return fh.read()


def norm(text):
    """Normalize only typography/whitespace; words and punctuation order must still match."""
    text = unicodedata.normalize("NFC", text)
    for a, b in {"‘": "'", "’": "'", "“": '"', "”": '"', "–": "-", "—": "-",
                 "…": "...", " ": " "}.items():
        text = text.replace(a, b)
    return re.sub(r"\s+", " ", text).strip()


def extract_json_block(answer):
    blocks = re.findall(r"```json\s*(\{.*?\})\s*```", answer, flags=re.S)
    if blocks:
        return blocks[-1]
    start, end = answer.find("{"), answer.rfind("}")
    return answer[start:end + 1] if start != -1 and end > start else None


def looks_like_path(s):
    s = s or ""
    return bool(re.match(r"^[A-Za-z]:[\\/]", s)) or s.startswith("\\\\") or s.startswith("/")


def strip_anchor(s):
    return re.split(r"#", s, maxsplit=1)[0].strip()


def cmd_verdict(a):
    raw = extract_json_block(read_text(a.answer))
    if raw is None:
        report(False, errors=["no JSON block found"])
    try:
        data = json.loads(raw)
    except json.JSONDecodeError as exc:
        report(False, errors=[f"invalid JSON: {exc}"])
    errors, warnings = [], []
    for key in REQUIRED:
        if key not in data:
            errors.append(f"missing key: {key}")
    if a.gate and data.get("gate") != a.gate:
        errors.append(f"gate {data.get('gate')!r} != expected {a.gate!r}")
    if a.call_id and data.get("call_id") != a.call_id:
        errors.append(f"call_id {data.get('call_id')!r} != expected {a.call_id!r}")
    if data.get("verdict") not in VERDICTS:
        errors.append(f"verdict must be one of {sorted(VERDICTS)}")
    canary_ok = None
    if a.canary_expect is not None:
        canary_ok = norm(a.canary_expect).lower() in norm(str(data.get("canary", ""))).lower()
        if not canary_ok:
            errors.append("canary mismatch: answer may not be based on the files")
    allowed = None
    if a.ids_from:
        with open(a.ids_from, encoding="utf-8-sig", newline="") as fh:
            allowed = {row[a.id_column].strip() for row in csv.DictReader(fh) if row.get(a.id_column)}
    counts = {"pass": 0, "fail": 0, "uncertain": 0}
    downgraded = []
    for i, item in enumerate(data.get("items") or []):
        sid = item.get("id")
        st = item.get("status")
        if st not in STATUSES:
            errors.append(f"item {i} ({sid}): bad status {st!r}")
            continue
        if allowed is not None and sid not in allowed:
            errors.append(f"item {i}: id {sid!r} not in {a.ids_from}")
        ev = (item.get("evidence") or "").strip()
        if st in ("pass", "fail"):
            if not ev:
                downgraded.append(sid)
                st = "uncertain"
            elif looks_like_path(ev) and a.check_paths and not os.path.exists(strip_anchor(ev)):
                downgraded.append(sid)
                warnings.append(f"item {sid}: evidence path not found: {strip_anchor(ev)}")
                st = "uncertain"
        counts[st] += 1
    if allowed is not None and a.require_all:
        seen = {it.get("id") for it in data.get("items") or []}
        missing = sorted(allowed - seen)
        if missing:
            errors.append(f"{len(missing)} ids not reviewed: {missing[:20]}")
    if a.check_paths:
        for p in data.get("inputs_read") or []:
            if looks_like_path(p) and not os.path.exists(strip_anchor(p)):
                warnings.append(f"inputs_read path not found: {p}")
    if downgraded:
        warnings.append(f"treated as uncertain (no/invalid evidence): {downgraded}")
    report(not errors, gate=data.get("gate"), call_id=data.get("call_id"), claude_verdict=data.get("verdict"),
           canary_ok=canary_ok, counts=counts, errors=errors, warnings=warnings,
           not_checked=data.get("not_checked"), output_keys=sorted((data.get("outputs") or {}).keys()))


def load_clause_rows(a):
    if a.from_answer:
        data = json.loads(extract_json_block(read_text(a.csv)))
        text = (data.get("outputs") or {}).get(a.output_key)
        if not text:
            report(False, errors=[f"outputs.{a.output_key} missing in answer"])
        return list(csv.DictReader(text.splitlines()))
    with open(a.csv, encoding="utf-8-sig", newline="") as fh:
        return list(csv.DictReader(fh))


def cmd_clauses(a):
    rows = load_clause_rows(a)
    errors, warnings = [], []
    if not rows:
        report(False, errors=["no clause rows"])
    if a.template:
        with open(a.template, encoding="utf-8-sig", newline="") as fh:
            want = next(csv.reader(fh))
        have = list(rows[0].keys())
        if have != want:
            errors.append(f"header differs from template: missing={[c for c in want if c not in have]} extra={[c for c in have if c not in want]}")
    ids = [r.get("clause_id", "").strip() for r in rows]
    dup = sorted({i for i in ids if ids.count(i) > 1})
    if dup:
        errors.append(f"duplicate clause_id: {dup}")
    if any(not i for i in ids):
        errors.append("empty clause_id present")
    empty = [r.get("clause_id") for r in rows if not (r.get("verbatim") or "").strip()]
    if empty:
        errors.append(f"empty verbatim: {empty}")
    joined = norm(" ".join((r.get("verbatim") or "") for r in rows))
    target = norm(read_text(a.narration))
    if joined != target:
        k = next((n for n, (x, y) in enumerate(zip(joined, target)) if x != y), min(len(joined), len(target)))
        errors.append("verbatim concatenation differs from narration")
        warnings.append({"first_diff_char": k, "clauses_text": joined[max(0, k - 60):k + 60],
                         "narration_text": target[max(0, k - 60):k + 60],
                         "clauses_len": len(joined), "narration_len": len(target)})
    prev_end = None
    for r in rows:
        s, e = (r.get("vo_start_seconds") or "").strip(), (r.get("vo_end_seconds") or "").strip()
        if not s and not e:
            continue
        try:
            s, e = float(s), float(e)
        except ValueError:
            errors.append(f"{r.get('clause_id')}: non-numeric timing")
            continue
        if e < s:
            errors.append(f"{r.get('clause_id')}: vo_end < vo_start")
        if prev_end is not None and s + 1e-3 < prev_end:
            errors.append(f"{r.get('clause_id')}: starts before previous clause ends")
        if a.vo_duration and e > a.vo_duration + 0.05:
            errors.append(f"{r.get('clause_id')}: vo_end beyond VO duration")
        prev_end = e
    unlocated = [r.get("clause_id") for r in rows if (r.get("place") or "").strip().lower() == "unlocated"]
    report(not errors, clauses=len(rows), unlocated=len(unlocated), errors=errors, warnings=warnings)


def to_seconds(ts):
    parts = [int(p) for p in ts.split(":")]
    sec = 0
    for p in parts:
        sec = sec * 60 + p
    return sec


def cmd_chapters(a):
    text = read_text(a.description)
    if a.from_answer:
        data = json.loads(extract_json_block(text))
        text = (data.get("outputs") or {}).get(a.output_key) or ""
    found = re.findall(r"^\s*(?:[-*]\s*)?((?:\d{1,2}:)?\d{1,2}:\d{2})\s+[-–—]?\s*(.+?)\s*$", text, flags=re.M)
    with open(a.chapters, encoding="utf-8-sig", newline="") as fh:
        table = list(csv.DictReader(fh))
    errors, warnings = [], []
    if not found:
        report(False, errors=["no timestamp lines found"])
    secs = [to_seconds(t) for t, _ in found]
    if secs[0] != 0:
        errors.append("first chapter must start at 00:00")
    if any(b <= x for x, b in zip(secs, secs[1:])):
        errors.append("timestamps not strictly increasing")
    if any(b - x < 10 for x, b in zip(secs, secs[1:])):
        errors.append("YouTube requires chapters >= 10 s apart")
    expected = [to_seconds(r[a.time_column].strip()) for r in table if r.get(a.time_column)]
    if len(expected) != len(secs):
        errors.append(f"{len(secs)} timestamps in description vs {len(expected)} in chapter table")
    for n, (got, want) in enumerate(zip(secs, expected)):
        if abs(got - want) > a.tolerance:
            errors.append(f"line {n + 1}: {found[n][0]} differs from table {want}s")
    report(not errors, timestamps=[t for t, _ in found], errors=errors, warnings=warnings)


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = p.add_subparsers(dest="cmd", required=True)

    v = sub.add_parser("verdict")
    v.add_argument("--answer", required=True, help="saved Claude answer (answers/<call_id>.md)")
    v.add_argument("--gate")
    v.add_argument("--call-id")
    v.add_argument("--canary-expect", help="text Codex knows the canary must contain")
    v.add_argument("--ids-from", help="CSV whose id column lists the allowed item ids")
    v.add_argument("--id-column", default="id")
    v.add_argument("--require-all", action="store_true", help="every id in --ids-from must be reviewed")
    v.add_argument("--check-paths", action="store_true", help="evidence/inputs paths must exist on this machine")
    v.set_defaults(fn=cmd_verdict)

    c = sub.add_parser("clauses")
    c.add_argument("--csv", required=True, help="clauses CSV, or a saved answer with --from-answer")
    c.add_argument("--from-answer", action="store_true")
    c.add_argument("--output-key", default="clauses_csv")
    c.add_argument("--narration", required=True, help="locked narration text for the same span")
    c.add_argument("--template", help="templates/clauses.csv to compare header")
    c.add_argument("--vo-duration", type=float)
    c.set_defaults(fn=cmd_clauses)

    h = sub.add_parser("chapters")
    h.add_argument("--description", required=True, help="description file, or a saved answer with --from-answer")
    h.add_argument("--from-answer", action="store_true")
    h.add_argument("--output-key", default="description_md")
    h.add_argument("--chapters", required=True, help="chapters.csv from the final timeline")
    h.add_argument("--time-column", default="start_hhmmss")
    h.add_argument("--tolerance", type=int, default=1, help="allowed difference in seconds")
    h.set_defaults(fn=cmd_chapters)

    a = p.parse_args()
    try:
        a.fn(a)
    except (OSError, KeyError, json.JSONDecodeError, StopIteration) as exc:
        print(json.dumps({"result": "ERROR", "error": f"{type(exc).__name__}: {exc}"}, ensure_ascii=False))
        sys.exit(2)


if __name__ == "__main__":
    main()
