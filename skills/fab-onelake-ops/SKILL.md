---
name: fab-onelake-ops
description: Use this skill for file and folder work inside Fabric and OneLake with fab-cli, especially when navigating paths, copying or moving content, checking existence, and verifying tables or files before and after changes.
---

# Fab Onelake Ops

## Overview

Use this skill when the user is working with Fabric paths like workspaces, items, folders, files, or lakehouse table areas through `fab`. It focuses on safe navigation and file operations in filesystem-style paths.

Read [path-patterns.md](C:/Users/florian.gaerner/.codex/skills/fab-onelake-ops/references/path-patterns.md) when the task needs reusable path conventions or a safe sequence for file operations. Use [render_path_op_spec.py](C:/Users/florian.gaerner/.codex/skills/fab-onelake-ops/scripts/render_path_op_spec.py) for dry-run command generation from JSON specs, and [check_paths.py](C:/Users/florian.gaerner/.codex/skills/fab-onelake-ops/scripts/check_paths.py) for batch existence checks. Point users to [path-op.sample.json](C:/Users/florian.gaerner/.codex/skills/fab-onelake-ops/assets/path-op.sample.json) and [paths.sample.json](C:/Users/florian.gaerner/.codex/skills/fab-onelake-ops/assets/paths.sample.json) as starter templates.

## When To Use It

- User asks to inspect or navigate OneLake-style paths.
- User wants to copy, move, link, or delete files or folders inside Fabric.
- User needs to check whether a path or file exists before a change.
- User is working with Lakehouse `Files` or `Tables` paths and wants verification.

## Default Workflow

1. Start with `fab dir`, `fab pwd`, `fab exists`, or `fab get` to confirm the current path and target.
2. If copying or moving data, inspect both source and destination first.
3. Perform `copy`, `move`, `mklink`, `mkdir`, or `del` only after confirming the exact path.
4. Re-list or re-check existence to verify the result.

## Command Patterns

List a path:

```powershell
fab dir "ws.Workspace/lh.Lakehouse/Files"
```

Check existence:

```powershell
fab exists "ws.Workspace/lh.Lakehouse/Files/raw/file.csv"
```

Copy content:

```powershell
fab copy "src-path" "dst-path"
```

Move content:

```powershell
fab move "src-path" "dst-path"
```

Inspect table schema when the task is table-oriented:

```powershell
fab table schema "ws.Workspace/lh.Lakehouse/Tables/table_name"
```

Render a path operation from a JSON spec:

```powershell
python scripts/render_path_op_spec.py .\path-op.json
```

Batch-check a list of paths:

```powershell
python scripts/check_paths.py .\paths.json
```

## Guardrails

- Treat `del` and `move` as high-risk actions. Confirm the exact path first.
- If the path is ambiguous, use `fab dir` to discover it rather than inferring a suffix.
- Prefer `exists` before and after any write operation.
- Separate file workflows from table workflows. Use `fab table` subcommands when the resource is a Delta table rather than a plain file path.
- Prefer rendering commands before executing copy, move, mklink, or delete operations in automation.

## Output Expectations

- Show the resolved paths.
- State what existed before and after.
- If a file or folder operation failed, report the exact path and the command attempted.
