---
name: fab-deploy
description: Use this skill for Fabric item promotion and deployment with fab-cli, especially when exporting from one workspace, importing into another, validating overwrite behavior, or preparing repeatable dev-test-prod release steps.
---

# Fab Deploy

## Overview

Use this skill when the task is to promote Fabric items between environments with `fab`. It is optimized for export or import flows, overwrite decisions, path validation, and post-deploy verification.

Read [references/deploy-patterns.md](references/deploy-patterns.md) when the deployment spans multiple items or needs a repeatable promotion plan. Use [scripts/render_manifest.py](scripts/render_manifest.py) when the user wants a manifest-driven command list.

Point users to [assets/deploy-manifest.sample.json](assets/deploy-manifest.sample.json) when they need a starting template.

## When To Use It

- User asks to deploy or promote notebooks, pipelines, reports, lakehouses, or other Fabric items.
- User wants a repeatable dev to test to prod workflow using `fab export` and `fab import`.
- User needs overwrite-safe imports with checks before changing the destination.
- User wants a deployment script or command sequence for CI/CD.

## Default Workflow

1. Confirm the source workspace or item path and the destination path.
2. Inspect the source and destination with `fab dir`, `fab get`, `fab exists`, or `fab desc` before changing anything.
3. Ensure the local staging directory exists, then export or identify the local artifact to deploy.
4. Import with `--force` only when the intended overwrite behavior is explicit.
5. Re-check the destination after import and summarize what changed.

## Command Patterns

Check whether an item exists before import:

```powershell
fab exists "target-ws.Workspace/item.Notebook"
```

Export an item to a local directory:

```powershell
fab export "source-ws.Workspace/item.Notebook" -o ".\\staging" -f
```

Import an item into a workspace:

```powershell
fab import "target-ws.Workspace/item.Notebook" -i ".\\staging\\item.Notebook"
```

Force an update only after confirming intent:

```powershell
fab import "target-ws.Workspace/item.Notebook" -i ".\\staging\\item.Notebook" -f
```

Render commands from a deployment manifest:

```powershell
python scripts/render_manifest.py .\deploy-manifest.json
```

## Safety Rules

- Do not overwrite an existing destination silently. Check first, then state whether the import will create or replace.
- If the user did not specify the source item type or destination path clearly, discover it with `fab dir` rather than guessing.
- Prefer reversible operations using local export folders before destructive updates.
- If a deployment involves multiple items, keep a clear per-item summary.
- In non-interactive automation, prefer `fab import -f` when an import would otherwise prompt.
- Some `fab import` operations may complete successfully even when the terminal host times out before the final success line is printed. Always verify the destination with `fab exists`, `fab dir`, or `fab api` after long-running imports.
- When a deployment creates downstream dependencies such as pipelines that reference notebook IDs, re-discover the imported item IDs after import instead of assuming the IDs from another workspace or an earlier run.
- Treat same-workspace folder reorganization as a separate risk area. `fab` may not support moving items across folders within the same workspace reliably.

## Output Expectations

- Show the exact `fab` commands used or proposed.
- State the source, destination, overwrite behavior, and verification result.
- If you had to infer paths or item types, say so explicitly.
- If verification relied on `fab api` because the first-class command surface was flaky, say that explicitly.
