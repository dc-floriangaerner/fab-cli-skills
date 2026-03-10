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

1. Start with `fab pwd` and `fab dir` to understand the current context.
2. Resolve the exact workspace or item path from `fab dir` output before using `fab get` or deeper listing commands.
3. Use `fab desc` on a dot element or resolved path to discover supported commands.
4. Narrow output with `fab get <path> -q <jmespath>` when large property payloads are noisy.
5. Only move to mutating commands after the path and object type are clear.

## Command Patterns

Show current location:

```powershell
fab pwd
```

List workspaces or child items:

```powershell
fab dir
fab dir "Analytics Dev.Workspace" -l
```

Inspect properties:

```powershell
fab get "Analytics Dev.Workspace"
fab get "Analytics Dev.Workspace/nb_silver_projects.Notebook"
```

See supported commands:

```powershell
fab desc ".notebook"
fab desc "Analytics Dev.Workspace/nb_silver_projects.Notebook"
```

Query only the needed fields from a resolved object:

```powershell
fab get "Analytics Dev.Workspace/nb_silver_projects.Notebook" -q "{displayName: displayName, type: type}"
```

## Path Resolution Tips

- Prefer the exact path token emitted by `fab dir`, including suffixes such as `.Workspace`, `.Notebook`, or `.Lakehouse`.
- If a shorthand path such as `ws.<name>` fails with `InvalidPath`, fall back to the literal value returned by `fab dir`.
- Path syntax can vary across `fab` versions, so treat `fab dir` output as the source of truth.

Example:

```powershell
fab dir
fab get "Analytics Dev.Workspace"
fab dir "Analytics Dev.Workspace"
fab dir "Analytics Dev.Workspace" -l
```

## Guardrails

- Prefer discovery commands before mutating commands.
- Prefer exact paths copied from `fab dir` output over inferred path prefixes.
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
