---
name: fab-acl-audit
description: Use this skill for inspecting, comparing, and changing Fabric access control lists with fab-cli, especially for workspace, item, gateway, connection, and OneLake permission troubleshooting or admin-safe updates.
---

# Fab Acl Audit

## Use

Use this skill when the user needs to understand or modify who has access to a Fabric resource through `fab acl`. It emphasizes read-first investigation, precise permission changes, and clear before or after comparisons.

Read [references/acl-patterns.md](references/acl-patterns.md) when the task needs a reusable ACL workflow. Use [scripts/render_acl_spec.py](scripts/render_acl_spec.py) when the user wants a dry-run ACL command generated from a JSON spec. Point users to [assets/acl-request.sample.json](assets/acl-request.sample.json) as a starter template.

## Workflow

1. Resolve the exact target path.
2. Inspect current ACLs with `fab acl dir` or `fab acl get`.
3. Summarize the current state in human language before proposing changes.
4. Apply `fab acl set` or `fab acl del` only for the specific principal and scope requested.
5. Re-read the ACLs and show the resulting difference.

## Commands

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

## Reporting Style

- Prefer rich Markdown presentation over plain prose when reporting ACL analysis or changes.
- Start with a short status line that uses clear icons such as `OK`, `WARN`, `FAIL`, or `INFO`.
- Use compact tables for principals, roles, scopes, and before or after comparisons.
- Use short labeled sections such as `Current state`, `Requested delta`, `Applied change`, and `Verification`.
- Use fenced code blocks only for exact commands, paths, or raw snippets the user may need to rerun.
- Use simple diagrams or flow summaries only when they clarify inheritance or multi-scope permission flow.
- Avoid decorative formatting when the result is tiny; keep the output visually ordered, not noisy.

## Output

- Summarize the current ACL state in a visually ordered format.
- Show the exact principals and permissions changed in a compact table.
- Include a before or after comparison whenever possible.
- Call out risk, uncertainty, or inherited permissions with an explicit warning block or status row.
