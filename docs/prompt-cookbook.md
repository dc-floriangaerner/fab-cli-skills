# Prompt Cookbook

Copy, paste, and adapt these prompts when working with Fabric in Codex or GitHub Copilot.

## How To Read This Page

- For Codex, use `$skill-name`
- For GitHub Copilot, use `/skill-name`
- Replace workspace names, item names, and paths with your own

---

## 1. First-Time Setup

### Install Fabric CLI and log in

Codex:

```text
Use $fab-bootstrap to install Fabric CLI, fix PATH if needed, and help me log in with user auth.
```

Copilot:

```text
Use the /fab-bootstrap skill to install Fabric CLI, fix PATH if needed, and help me log in with user auth.
```

### Only repair PATH for an existing install

Codex:

```text
Use $fab-bootstrap to check my current fab installation and repair PATH only.
```

Copilot:

```text
Use the /fab-bootstrap skill to check my current fab installation and repair PATH only.
```

---

## 2. Explore A Workspace

### See what is inside a workspace

Codex:

```text
Use $fab-discovery to inspect Analytics Dev.Workspace and summarize the items I can work with.
```

Copilot:

```text
Use the /fab-discovery skill to inspect Analytics Dev.Workspace and summarize the items I can work with.
```

### Find out which commands are supported for one item

Codex:

```text
Use $fab-discovery to inspect Test123.Workspace/nb_silver_customers.Notebook and tell me which fab commands are relevant.
```

Copilot:

```text
Use the /fab-discovery skill to inspect Test123.Workspace/nb_silver_customers.Notebook and tell me which fab commands are relevant.
```

---

## 3. Deploy A Fabric Item

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

## 4. Run Or Inspect Jobs

### Check the latest pipeline runs

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

## 5. Work With OneLake Paths

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

## 6. Use Direct Fabric APIs

### Call a Fabric API endpoint safely

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

## 7. Check Permissions

### Inspect access on a workspace

Codex:

```text
Use $fab-acl-audit to inspect the ACLs on Test123.Workspace and summarize who has which role.
```

Copilot:

```text
Use the /fab-acl-audit skill to inspect the ACLs on Test123.Workspace and summarize who has which role.
```

### Plan a safe permission change

Codex:

```text
Use $fab-acl-audit to inspect the current ACLs, then render the command I would use to grant Viewer access to a specific user without executing it yet.
```

Copilot:

```text
Use the /fab-acl-audit skill to inspect the current ACLs, then render the command I would use to grant Viewer access to a specific user without executing it yet.
```

---

## 8. Good Habits

- Start with discovery if you are unsure about paths.
- Ask for a dry run before copy, move, delete, import, or ACL changes.
- For API work, inspect one raw response before writing a query.
- For job work, ask for a summary of the latest runs before restarting failed workloads.
