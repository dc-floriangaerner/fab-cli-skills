# Fabric CLI Skills Pack

<p align="center">
  <strong>Fabric workflows for Codex, packaged for data engineers.</strong>
</p>

<p align="center">
  Install once, then ask Codex to help with Fabric jobs, deployments, OneLake paths, ACLs, APIs, and first-time setup.
</p>

---

## Why This Repo Exists

This repository packages a set of reusable Codex skills for day-to-day work with `fab` and Microsoft Fabric.

You do **not** need to know anything about agentic programming to use them.

Think of these skills as:

- small task-specific playbooks Codex can follow
- built-in helper scripts for repetitive Fabric work
- a way to make Codex more reliable on Fabric tasks

If a teammate says:

- "Deploy this notebook to Test"
- "Run this pipeline and tell me if it failed"
- "Call this Fabric REST endpoint"
- "Check these OneLake paths"
- "Install fab-cli on my laptop"

these skills help Codex do the right thing faster and with better guardrails.

---

## What You Get

| Skill | What it helps with |
| --- | --- |
| `fab-bootstrap` | Install `fab`, repair PATH, verify setup, launch user login |
| `fab-discovery` | Explore workspaces, items, and supported commands |
| `fab-deploy` | Export/import items and promote across environments |
| `fab-job-ops` | Start jobs, poll runs, inspect failures, check schedules |
| `fab-api-bridge` | Use `fab api` for direct REST calls |
| `fab-acl-audit` | Inspect and manage access control safely |
| `fab-onelake-ops` | Work with OneLake paths, files, folders, and tables |

---

## Quick Start

### Windows

From PowerShell:

```powershell
git clone <your-repo-url> C:\DEV\fab-cli-skills
cd C:\DEV\fab-cli-skills
.\scripts\install.ps1
```

### Windows For GitHub Copilot

From PowerShell:

```powershell
git clone <your-repo-url> C:\DEV\fab-cli-skills
cd C:\DEV\fab-cli-skills
.\scripts\install-copilot.ps1
```

### macOS

From Terminal:

```bash
git clone <your-repo-url> ~/DEV/fab-cli-skills
cd ~/DEV/fab-cli-skills
bash ./scripts/install.sh
```

### macOS For GitHub Copilot

From Terminal:

```bash
git clone <your-repo-url> ~/DEV/fab-cli-skills
cd ~/DEV/fab-cli-skills
bash ./scripts/install-copilot.sh
```

After install:

1. Restart Codex if it is already open.
2. Start a new chat.
3. Ask for a Fabric task in plain English.

Example prompts:

```text
Use $fab-bootstrap to install Fabric CLI and set up user login on this machine.
```

```text
Use $fab-deploy to promote a notebook from Analytics Dev to Test123.
```

```text
Use $fab-job-ops to check the latest run of pl-main.DataPipeline and summarize failures.
```

```text
Use $fab-onelake-ops to check whether these paths exist and tell me what is missing.
```

For GitHub Copilot, use `/fab-...` instead of `$fab-...`.

Example:

```text
Use the /fab-job-ops skill to check the latest pipeline run and summarize failures.
```

---

## Codex vs Copilot

Both can use this repo.

### Codex

- install target: `~/.codex/skills`
- prompt style: `$fab-deploy`
- install scripts:
  - [install.ps1](C:/DEV/fab-cli-skills/scripts/install.ps1)
  - [install.sh](C:/DEV/fab-cli-skills/scripts/install.sh)

### GitHub Copilot

- install target: `~/.copilot/skills`
- prompt style: `/fab-deploy`
- install scripts:
  - [install-copilot.ps1](C:/DEV/fab-cli-skills/scripts/install-copilot.ps1)
  - [install-copilot.sh](C:/DEV/fab-cli-skills/scripts/install-copilot.sh)

If a teammate uses both tools, they can install the repo into both locations.

## How Installation Works

The install scripts copy the skill folders from this repo into a local skills directory:

- Windows: `%USERPROFILE%\.codex\skills`
- macOS: `~/.codex/skills`
- If `CODEX_HOME` is set, it installs into `$CODEX_HOME/skills`

For GitHub Copilot, the install target is:

- Windows: `%USERPROFILE%\.copilot\skills`
- macOS: `~/.copilot/skills`

It does **not** install Fabric CLI itself.

That is handled by the `fab-bootstrap` skill when needed.

---

## Easiest Way To Use It

Your teammates do not need to browse the skill files manually.

They just need to:

1. install the skill pack
2. restart Codex
3. mention the skill in a prompt with `$skill-name` in Codex or `/skill-name` in Copilot

Examples for Codex:

- `$fab-bootstrap`
- `$fab-deploy`
- `$fab-job-ops`
- `$fab-api-bridge`

Examples for Copilot:

- `/fab-bootstrap`
- `/fab-deploy`
- `/fab-job-ops`
- `/fab-api-bridge`

The assistant will then load the right instructions and helper scripts for that task.

---

## Recommended Team Rollout

If you want this to be easy for colleagues, the best approach is:

1. Keep this repo in source control.
2. Ask teammates to clone it locally.
3. Have them run the install script once.
4. Point them to the example prompts above.

This is better than sharing individual files ad hoc because:

- everyone gets the same skill versions
- updates are easy with `git pull`
- helper scripts and references stay together
- onboarding stays simple

## Prompt Cookbook

For copy-paste examples your team can use immediately, see:

- [Prompt Cookbook](C:/DEV/fab-cli-skills/docs/prompt-cookbook.md)

---

## Updating Skills

When the repo changes:

```powershell
git pull
.\scripts\install.ps1
```

or on macOS:

```bash
git pull
bash ./scripts/install.sh
```

That refreshes the local skill copies in Codex.

---

## Repo Layout

```text
fab-cli-skills/
├── README.md
├── scripts/
│   ├── install.ps1
│   └── install.sh
└── skills/
    ├── fab-bootstrap/
    ├── fab-deploy/
    ├── fab-job-ops/
    ├── fab-api-bridge/
    ├── fab-acl-audit/
    ├── fab-onelake-ops/
    └── fab-discovery/
```

---

## Good First Prompt For Colleagues

If someone is brand new, this is a good starting point:

```text
Use $fab-bootstrap to check whether Fabric CLI is installed, fix PATH if needed, and help me log in with user auth.
```

Then once setup is done:

```text
Use $fab-discovery to show me what is in my Fabric workspace and what commands I can use.
```

---

## Notes

- These skills are designed around **user auth mode**.
- Some actions still require browser interaction, especially `fab auth login`.
- A few Fabric CLI behaviors are terminal-sensitive on Windows, and the skills include workarounds for that.
- The helper scripts live inside each skill folder and are copied along with the skill.

---

## Bottom Line

Yes, sharing these in a repo is the right move.

For teammates, the smoothest experience is:

**clone repo -> run install script -> restart Codex -> use `$fab-...` prompts**
