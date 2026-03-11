---
name: fab-onelake-ops
description: Use this skill for file and folder work inside Fabric and OneLake with fab-cli, especially when navigating paths, copying or moving content, checking existence, and verifying tables or files before and after changes.
---

# Fab Onelake Ops

## Use

Use this skill when the user is working with Fabric paths like workspaces, items, folders, files, or lakehouse table areas through `fab`. It focuses on safe navigation and file operations in filesystem-style paths.

Read [references/path-patterns.md](references/path-patterns.md) when the task needs reusable path conventions or a safe sequence for file operations. Use [scripts/render_path_op_spec.py](scripts/render_path_op_spec.py) for dry-run command generation from JSON specs, and [scripts/check_paths.py](scripts/check_paths.py) for batch existence checks. Point users to [assets/path-op.sample.json](assets/path-op.sample.json) and [assets/paths.sample.json](assets/paths.sample.json) as starter templates.

## Workflow

1. Start with `fab dir`, `fab pwd`, `fab exists`, or `fab get` to confirm the current path and target.
2. If the target is a Lakehouse, list both `.../Files` and `.../Tables` before assuming where the useful content lives.
3. If the data is table-oriented, list schemas under `.../Tables`, then list tables inside the schema before using `fab table` subcommands.
4. If copying or moving data, inspect both source and destination first.
5. Perform `copy`, `move`, `mklink`, `mkdir`, or `del` only after confirming the exact path.
6. Re-list or re-check existence to verify the result.

## Commands

List a path:

```powershell
fab dir "ws.Workspace/lh.Lakehouse/Files"
```

List the Lakehouse table area:

```powershell
fab dir "ws.Workspace/lh.Lakehouse/Tables"
fab dir "ws.Workspace/lh.Lakehouse/Tables/silver"
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
fab table schema "ws.Workspace/lh.Lakehouse/Tables/silver/customers"
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
- Do not assume Lakehouse data lives under `Files`; many workflows store the useful data under schema folders in `Tables`.
- Separate file workflows from table workflows. Use `fab table` subcommands when the resource is a Delta table rather than a plain file path.
- Prefer rendering commands before executing copy, move, mklink, or delete operations in automation.

## Output

- Show the resolved paths.
- Note whether the relevant content was found under `Files` or `Tables`.
- State what existed before and after.
- If a file or folder operation failed, report the exact path and the command attempted.
