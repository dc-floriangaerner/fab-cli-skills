---
name: fab-acl-audit
description: Use this skill for inspecting, comparing, and changing Fabric access control lists with fab-cli, especially for workspace, item, gateway, connection, and OneLake permission troubleshooting or admin-safe updates.
---

# Fab Acl Audit

## Overview

Use this skill when the user needs to understand or modify who has access to a Fabric resource through `fab acl`. It emphasizes read-first investigation, precise permission changes, and clear before or after comparisons.

Read [references/acl-patterns.md](references/acl-patterns.md) when the task needs a reusable ACL workflow. Use [scripts/render_acl_spec.py](scripts/render_acl_spec.py) when the user wants a dry-run ACL command generated from a JSON spec. Point users to [assets/acl-request.sample.json](assets/acl-request.sample.json) as a starter template.

## When To Use It

- User asks who can access a workspace, item, connection, gateway, or OneLake resource.
- User wants to compare permissions between environments.
- User wants to add, change, or remove ACL entries.
- The task is administrative and benefits from a read-before-write workflow.

## Default Workflow

1. Resolve the exact target path.
2. Inspect current ACLs with `fab acl dir` or `fab acl get`.
3. Summarize the current state in human language before proposing changes.
4. Apply `fab acl set` or `fab acl del` only for the specific principal and scope requested.
5. Re-read the ACLs and show the resulting difference.

## Command Patterns

List ACLs:

```powershell
fab acl dir "ws.Workspace"
```

Get detailed ACL info:

```powershell
fab acl get "ws.Workspace/item.Notebook"
```

Set access:

```powershell
fab acl set "ws.Workspace" ...
```

Delete one ACL entry:

```powershell
fab acl del "ws.Workspace" ...
```

Render an ACL command from a JSON spec:

```powershell
python scripts/render_acl_spec.py .\acl-request.json
```

## Guardrails

- Never mutate ACLs before reading the current state.
- Avoid broad permission changes when the request is principal-specific.
- For ambiguous admin changes, spell out the intended delta before executing it.
- After changes, verify by reading the ACLs again instead of assuming success.
- Prefer dry-run command rendering before ACL mutations in automation.

## Output Expectations

- Summarize the current ACL state in plain language.
- Show the exact principals and permissions changed.
- Include a before or after comparison whenever possible.
