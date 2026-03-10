---
name: fab-discovery
description: Use this skill to explore Fabric workspaces, items, paths, and supported commands with fab-cli, especially when the user is unfamiliar with a tenant layout, item type, command surface, or current location.
---

# Fab Discovery

## Overview

Use this skill for exploration and orientation in Fabric with `fab`. It helps map the workspace or item tree, discover valid paths, inspect object properties, and find which commands are supported before taking action.

## When To Use It

- User asks what workspaces, items, or paths exist.
- User is unsure what command is supported for a path or item type.
- User wants to inspect the current Fabric location or change context.
- The task starts with discovery rather than mutation.

## Default Workflow

1. Start with `fab pwd`, `fab dir`, and `fab get` to understand the current context.
2. Use `fab desc` on a dot element or path to discover supported commands.
3. Narrow output with `fab get <path> -q <jmespath>` when large property payloads are noisy.
4. Only move to mutating commands after the path and object type are clear.

## Command Patterns

Show current location:

```powershell
fab pwd
```

List workspaces or child items:

```powershell
fab dir
fab dir "ws.Workspace" -l
```

Inspect properties:

```powershell
fab get "ws.Workspace/item.Notebook"
```

See supported commands:

```powershell
fab desc ".notebook"
fab desc "ws.Workspace/item.Notebook"
```

Query only the needed fields from a resolved object:

```powershell
fab get "ws.Workspace/item.Notebook" -q "{displayName: displayName, type: type}"
```

## Guardrails

- Prefer discovery commands before mutating commands.
- Use `fab dir` for listing and `fab get -q` for filtering JSON properties.
- If an object type is uncertain, use `desc` rather than guessing the command family.
- Keep summaries short and structured when the listing is large.
- For workspace overview requests, prefer a compact visual structure over a plain bullet-only inventory.

## Output Expectations

- Explain the discovered structure in plain language.
- Include the path or item type you resolved.
- When the user asks for a workspace overview, present the result in a more visual format such as:
  - a short type summary table with counts
  - a compact tree-like listing grouped by item type or layer
  - a short "shape of the workspace" section before the detailed inventory
- Use bullets as a fallback, not the default, for workspace overviews.
- Call out which command families appear relevant next.

## Workspace Overview Format

When the user asks what is inside a workspace, prefer this response shape:

1. A one-line summary of the workspace shape, such as "1 Lakehouse, 1 SQL Endpoint, 1 Pipeline, 9 Notebooks".
2. A compact visual grouping, such as a Markdown table or tree grouped by item type.
3. Optional short notes about naming patterns, layers, or likely data flow.
4. Suggested next inspection commands or areas only if helpful.

Example format:

```text
Workspace shape
1 Lakehouse | 1 SQL Endpoint | 1 Pipeline | 9 Notebooks

Items
Lakehouse
- lakehouse

DataPipeline
- pl-main

Notebook
- nb_bronze_load_moco_endpoints
- nb_silver_customers
- nb_silver_projects
```
