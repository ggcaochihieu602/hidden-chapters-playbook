# MoneyPrinter2 workspace (Hidden Chapters production)

This folder holds production work for the Hidden Chapters documentary pipeline on this machine. The full MoneyPrinter2 app is not installed here; only the parts the playbook needs (artifacts, research/davinci-resolve-mcp, scripts/omni_voice_worker.py, Downloads).

## Documentary script preparation

- At the start of each new documentary brief, read `artifacts/script-ideal/SCRIPT_IDEAL_RULES.md` and apply it to location concepts, outlines, titles, and scripts. Keep verified facts, oral tradition, proposed scenes, and unverified footage distinct.
- Use English for narration and titles and Vietnamese for editorial explanation unless the user specifies otherwise.
- A selected direction is required before starting VO, footage sourcing or purchase, editing, or rendering.

## Brief editing

- Before planning, auditing, or implementing documentary editing, resolve `E:/Youtube AI/Hidden Chapters/Playbooks/LATEST.json` (see the path map in the workspace-root AGENTS.md if this machine has no E: drive), read that playbook's `START_HERE.md`, then the project's progress and only its current stage. The personal `mp2-brief-edit` skill routes to this staged workflow.
- Record failures/corrections only in the film workspace during production. Treat the shared playbook and installed skill as read-only unless the user explicitly asks for a playbook update.

## Voice

- OmniVoice, default voice `am_adam` (preset WAV in `<workspace>/data/models/omnivoice/voice-presets`). Run `scripts/omni_voice_worker.py` with the workspace `.voice-venv` Python; see the workspace-root AGENTS.md for the request format.
