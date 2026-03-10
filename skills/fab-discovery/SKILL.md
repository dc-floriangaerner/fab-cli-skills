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
3. Narrow output with `-q` queries when large listings are noisy.
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

Query only the needed fields:

```powershell
fab dir -q "[].name"
```

## Guardrails

- Prefer discovery commands before mutating commands.
- If an object type is uncertain, use `desc` rather than guessing the command family.
- Keep summaries short and structured when the listing is large.

## Output Expectations

- Explain the discovered structure in plain language.
- Include the path or item type you resolved.
- Call out which command families appear relevant next.
