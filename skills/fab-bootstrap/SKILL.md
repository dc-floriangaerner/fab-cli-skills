---
name: fab-bootstrap
description: Use this skill to bootstrap Fabric CLI for users who do not already have fab-cli installed, especially on Windows or macOS when the task includes pip install, persistent PATH setup, version verification, and interactive user-auth login.
---

# Fab Bootstrap

## Overview

Use this skill for first-time `fab` setup on Windows and macOS in user-auth mode. It handles install or upgrade, persistent PATH updates, version verification, auth status checks, and interactive login handoff when `fab auth login` cannot run inside the current terminal host.

Read [references/install-auth.md](references/install-auth.md) for the setup flow and caveats. Use [scripts/bootstrap_fab.py](scripts/bootstrap_fab.py) to automate install, PATH setup, verification, and interactive login.
Use [scripts/repair_fab_path.py](scripts/repair_fab_path.py) when `fab` is already installed and the only issue is persistent PATH configuration.

## When To Use It

- User does not have `fab` installed yet.
- `fab` is installed but not on `PATH`.
- The user wants Codex to set up Fabric CLI end to end in user-auth mode.
- The user is on Windows or macOS and wants a repeatable bootstrap flow.

## Default Workflow

1. Detect the OS and the user-level Python script directory.
2. Install or upgrade `ms-fabric-cli` with `pip --user`.
3. Add the user-level script directory to the user's persistent PATH automatically.
4. Verify `fab --version`.
5. Check `fab auth status`.
6. If requested and not already logged in, try `fab auth login`.
7. If interactive login cannot start in the current terminal host, tell the user to run the printed `fab auth login` command in a regular local terminal and then re-check `fab auth status`.

## Command Patterns

Bootstrap everything, including login when the current terminal host supports it:

```powershell
python scripts/bootstrap_fab.py --login
```

Windows launcher fallback if `python` is not mapped:

```powershell
py -3 scripts/bootstrap_fab.py --login
```

Verify only:

```powershell
python scripts/bootstrap_fab.py --verify-only
```

Skip persistent PATH updates:

```powershell
python scripts/bootstrap_fab.py --no-path --login
```

Preview actions without applying changes:

```powershell
python scripts/bootstrap_fab.py --login --dry-run
```

Repair PATH only:

```powershell
python scripts/repair_fab_path.py
```

## Guardrails

- Prefer user-level install so admin rights are not required.
- Treat PATH updates as persistent user-environment changes and say so clearly.
- Expect `fab auth login` to require browser interaction even when the setup steps are automated.
- On Windows, be explicit that embedded terminals may fail to launch the interactive login flow cleanly. If that happens, direct the user to run the printed login command in a regular PowerShell, Windows Terminal, or `cmd.exe` session.
- If `fab auth status` shows encoding problems, retry with `PYTHONIOENCODING=utf-8` and `PYTHONUTF8=1`.
- If `python -m pip` is unavailable, retry with the Windows launcher (`py -3`) or ensure Python is installed for the current user.
- Tell the user that a new shell may be needed before plain `fab` resolves everywhere.

## Output Expectations

- Show the detected script directory and whether it was added to PATH.
- Show the resolved `fab` executable and version.
- Report whether the user is already logged in, whether interactive login was launched, or whether login must be completed in a regular local terminal.
