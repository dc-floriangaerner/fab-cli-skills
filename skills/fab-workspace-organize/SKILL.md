---
name: fab-workspace-organize
description: Use this skill to organize Microsoft Fabric workspaces with fab-cli, especially for creating folders, planning item grouping, cleaning up legacy notebooks or pipelines, and verifying workspace structure when folder moves or same-workspace reorganization are risky.
---

# Fab Workspace Organize

## Overview

Use this skill when the task is to clean up or structure a Fabric workspace. It is optimized for folder creation, safe inventory checks, phased reorganization, legacy item cleanup, and knowing when to stop and switch to the Fabric UI or direct API work.

Use `fab-discovery` first when the current workspace contents are still unclear. Use `fab-api-bridge` when folder or item behavior is incomplete through first-class `fab` commands.

## When To Use It

- User wants a workspace organized into folders or sections.
- User wants to remove obsolete notebooks, pipelines, or other items after a refactor.
- User wants a cleaner workspace layout before or after a deployment.
- The task includes verifying whether reorganization succeeded without breaking runnable assets.

## Default Workflow

1. Inventory the workspace with `fab dir "<workspace>.Workspace" -l`.
2. Discover folder support and command behavior with `fab desc ".Folder"` and `fab desc ".Workspace"` if needed.
3. Create the target folders first.
4. Prefer a phased cutover over in-place moves for important runnable assets.
5. Verify every structural change with `fab exists`, `fab dir`, or `fab api`.
6. Delete obsolete root-level items only after the replacement path is verified.

## Command Patterns

Inspect the workspace:

```powershell
fab dir "Test123.Workspace" -l
fab desc ".Folder"
fab desc ".Workspace"
```

Create root-level folders:

```powershell
fab mkdir "Test123.Workspace/10_GoldDimensions.Folder"
fab mkdir "Test123.Workspace/20_GoldFacts.Folder"
fab mkdir "Test123.Workspace/30_Orchestration.Folder"
```

Check whether a folder or item exists:

```powershell
fab exists "Test123.Workspace/10_GoldDimensions.Folder"
fab exists "Test123.Workspace/nb_gold_dimension_customer.Notebook"
```

Delete a legacy item after replacement is verified:

```powershell
fab del "Test123.Workspace/nb_gold_dim_fact_builder.Notebook" -f
```

Fallback inventory through the Fabric REST surface:

```powershell
fab api "workspaces/<workspace-id>/items" -X get
fab api "workspaces/<workspace-id>/folders" -X get
```

## Reorganization Strategy

- Prefer simple root-level folder structures such as `10_GoldDimensions`, `20_GoldFacts`, and `30_Orchestration`.
- Treat same-workspace folder moves as high risk until verified in the current tenant and CLI version.
- If `fab move` reports unsupported same-workspace folder movement, do not assume a retry will fix it.
- For critical items, prefer this order:
  1. create folder
  2. import or recreate the item in the target location if supported
  3. verify the replacement item works
  4. remove the obsolete original
- If folder-contained item discovery is inconsistent through `fab dir` or `fab get`, use `fab api` to confirm the workspace and folder state.
- If the folder workflow remains ambiguous, stop and recommend finishing the placement in the Fabric UI rather than risking the runnable setup.

## Guardrails

- Do not delete the only working copy of a notebook or pipeline before the replacement has been verified.
- Expect folder support to be less mature than item export, import, and job execution.
- If the workspace also contains pipelines, remember that pipeline definitions may need updated notebook IDs after a cutover.
- Keep folder naming consistent and sortable.
- Summarize clearly what was completed, what was verified, and what still needs UI follow-up.

## Output Expectations

- Show the intended workspace structure in plain language.
- State which changes were completed through `fab`.
- Call out any folder limitations or unsupported same-workspace move behavior explicitly.
- Separate verified cleanup from recommended manual follow-up.
