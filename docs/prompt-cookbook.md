# Prompt Cookbook

<p align="center">
  <strong>Copy-paste prompt examples for common Fabric tasks</strong>
</p>

<p align="center">
  Use these prompts as starting points in Codex or GitHub Copilot.
</p>

---

## Before You Start

- In Codex, use `$skill-name`
- In GitHub Copilot, use `/skill-name`
- Replace workspace names, item names, table names, and paths with your own

Example:

- Codex: `$fab-job-ops`
- Copilot: `/fab-job-ops`

---

## Setup

### Install Fabric CLI and sign in

Codex:

```text
Use $fab-bootstrap to install Fabric CLI, fix PATH if needed, and help me log in with user auth.
```

Copilot:

```text
Use the /fab-bootstrap skill to install Fabric CLI, fix PATH if needed, and help me log in with user auth.
```

### Repair PATH for an existing install

Codex:

```text
Use $fab-bootstrap to check my current fab installation and repair PATH only.
```

Copilot:

```text
Use the /fab-bootstrap skill to check my current fab installation and repair PATH only.
```

---

## Discovery

### Inspect a workspace

Codex:

```text
Use $fab-discovery to inspect Analytics Dev.Workspace and summarize the items I can work with.
```

Copilot:

```text
Use the /fab-discovery skill to inspect Analytics Dev.Workspace and summarize the items I can work with.
```

### Check which commands are relevant for an item

Codex:

```text
Use $fab-discovery to inspect Test123.Workspace/nb_silver_customers.Notebook and tell me which fab commands are relevant.
```

Copilot:

```text
Use the /fab-discovery skill to inspect Test123.Workspace/nb_silver_customers.Notebook and tell me which fab commands are relevant.
```

---

## Deployments

### Promote a notebook into Test

Codex:

```text
Use $fab-deploy to export Analytics Dev.Workspace/nb_silver_customers.Notebook and import it into Test123.Workspace with overwrite safety checks.
```

Copilot:

```text
Use the /fab-deploy skill to export Analytics Dev.Workspace/nb_silver_customers.Notebook and import it into Test123.Workspace with overwrite safety checks.
```

### Generate commands from a deployment manifest

Codex:

```text
Use $fab-deploy to turn this deployment manifest into fab commands and explain what each step does.
```

Copilot:

```text
Use the /fab-deploy skill to turn this deployment manifest into fab commands and explain what each step does.
```

---

## Jobs

### Inspect recent pipeline runs

Codex:

```text
Use $fab-job-ops to inspect the latest runs of Analytics Dev.Workspace/pl-main.DataPipeline and summarize failures or recent issues.
```

Copilot:

```text
Use the /fab-job-ops skill to inspect the latest runs of Analytics Dev.Workspace/pl-main.DataPipeline and summarize failures or recent issues.
```

### Start a notebook and watch it finish

Codex:

```text
Use $fab-job-ops to start Test123.Workspace/nb_silver_customers.Notebook, monitor the run, and tell me the final status.
```

Copilot:

```text
Use the /fab-job-ops skill to start Test123.Workspace/nb_silver_customers.Notebook, monitor the run, and tell me the final status.
```

---

## OneLake

### Check whether a set of paths exists

Codex:

```text
Use $fab-onelake-ops to check whether these Test123 lakehouse paths exist and summarize what is missing.
```

Copilot:

```text
Use the /fab-onelake-ops skill to check whether these Test123 lakehouse paths exist and summarize what is missing.
```

### Inspect files and tables in a lakehouse

Codex:

```text
Use $fab-onelake-ops to inspect Test123.Workspace/lakehouse.Lakehouse/Files and Test123.Workspace/lakehouse.Lakehouse/Tables and explain the current structure.
```

Copilot:

```text
Use the /fab-onelake-ops skill to inspect Test123.Workspace/lakehouse.Lakehouse/Files and Test123.Workspace/lakehouse.Lakehouse/Tables and explain the current structure.
```

---

## APIs

### Inspect a Fabric API response safely

Codex:

```text
Use $fab-api-bridge to call the workspaces endpoint, inspect the response shape, and then suggest a good query for just the names and IDs.
```

Copilot:

```text
Use the /fab-api-bridge skill to call the workspaces endpoint, inspect the response shape, and then suggest a good query for just the names and IDs.
```

### Build a reusable API spec

Codex:

```text
Use $fab-api-bridge to create a JSON request spec for this Fabric API call and render the final fab api command before executing it.
```

Copilot:

```text
Use the /fab-api-bridge skill to create a JSON request spec for this Fabric API call and render the final fab api command before executing it.
```

---

## Permissions

### Inspect workspace access

Codex:

```text
Use $fab-acl-audit to inspect the ACLs on Test123.Workspace and summarize who has which role.
```

Copilot:

```text
Use the /fab-acl-audit skill to inspect the ACLs on Test123.Workspace and summarize who has which role.
```

### Prepare a safe permission change

Codex:

```text
Use $fab-acl-audit to inspect the current ACLs, then render the command I would use to grant Viewer access to a specific user without executing it yet.
```

Copilot:

```text
Use the /fab-acl-audit skill to inspect the current ACLs, then render the command I would use to grant Viewer access to a specific user without executing it yet.
```

---

## Simple Rules That Help

- Start with discovery if you are unsure about a path or item.
- Ask for a dry run before copy, move, delete, import, or ACL changes.
- For API work, inspect one raw response before writing a query.
- For job work, look at recent runs before restarting workloads.
