# Fabric Skills Pack

<p align="center">
  <strong>Practical Microsoft Fabric skills for Codex and GitHub Copilot</strong>
</p>

<p align="center">
  Built for data engineers working with <code>fab</code>, jobs, deployments, OneLake, ACLs, and Fabric APIs.
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> ·
  <a href="#skills">Skills</a> ·
  <a href="#how-to-use">How To Use</a> ·
  <a href="#prompt-cookbook">Prompt Cookbook</a>
</p>

---

## What This Is

This repo contains reusable Fabric-focused skills for AI coding assistants.

They make common Fabric tasks easier to delegate in plain English, for example:

- install and set up `fab`
- inspect workspaces and items
- deploy notebooks or pipelines
- run and monitor jobs
- work with OneLake paths
- call Fabric REST APIs
- inspect or plan ACL changes

You do not need to understand how skills work internally. Install them once, then use them in prompts.

---

## Quick Start

### Codex

Windows:

```powershell
git clone <your-repo-url> C:\DEV\fab-cli-skills
cd C:\DEV\fab-cli-skills
.\scripts\install.ps1
```

macOS:

```bash
git clone <your-repo-url> ~/DEV/fab-cli-skills
cd ~/DEV/fab-cli-skills
bash ./scripts/install.sh
```

### GitHub Copilot

Windows:

```powershell
git clone <your-repo-url> C:\DEV\fab-cli-skills
cd C:\DEV\fab-cli-skills
.\scripts\install-copilot.ps1
```

macOS:

```bash
git clone <your-repo-url> ~/DEV/fab-cli-skills
cd ~/DEV/fab-cli-skills
bash ./scripts/install-copilot.sh
```

### After Install

1. Restart Codex or Copilot if it is already open.
2. Start a new chat.
3. Ask for a Fabric task in plain English.

---

## Skills

| Skill | Purpose |
| --- | --- |
| `fab-bootstrap` | Install `fab`, repair PATH, verify setup, launch user login |
| `fab-discovery` | Explore workspaces, items, paths, and supported commands |
| `fab-deploy` | Export, import, and promote Fabric items safely |
| `fab-job-ops` | Start jobs, inspect runs, poll status, summarize failures |
| `fab-api-bridge` | Use `fab api` for direct REST workflows |
| `fab-acl-audit` | Inspect access and prepare safe ACL changes |
| `fab-onelake-ops` | Work with OneLake files, folders, tables, and paths |

---

## How To Use

### In Codex

Use `$skill-name` in your prompt.

Examples:

```text
Use $fab-bootstrap to install Fabric CLI and help me log in with user auth.
```

```text
Use $fab-job-ops to inspect the latest run of pl-main.DataPipeline and summarize failures.
```

### In GitHub Copilot

Use `/skill-name` in your prompt.

Examples:

```text
Use the /fab-bootstrap skill to install Fabric CLI and help me log in with user auth.
```

```text
Use the /fab-deploy skill to promote a notebook from Analytics Dev to Test123.
```

---

## Prompt Cookbook

Copy-paste examples for common tasks live here:

- [Prompt Cookbook](C:/DEV/fab-cli-skills/docs/prompt-cookbook.md)

Recommended first prompts:

```text
Use $fab-bootstrap to check whether Fabric CLI is installed, fix PATH if needed, and help me log in with user auth.
```

```text
Use $fab-discovery to inspect my Fabric workspace and summarize what I can work with.
```

---

## Update Flow

When this repo changes:

Windows:

```powershell
git pull
.\scripts\install.ps1
```

macOS:

```bash
git pull
bash ./scripts/install.sh
```

For GitHub Copilot, use the corresponding `install-copilot` script instead.

---

## Install Locations

### Codex

- Windows: `%USERPROFILE%\.codex\skills`
- macOS: `~/.codex/skills`
- If `CODEX_HOME` is set: `$CODEX_HOME/skills`

### GitHub Copilot

- Windows: `%USERPROFILE%\.copilot\skills`
- macOS: `~/.copilot/skills`

The install scripts copy the skills from this repo into the correct local skills directory.

---

## Notes

- These skills are designed for user-auth-based Fabric workflows.
- `fab auth login` still requires browser interaction.
- The helper scripts are included inside the skill folders and are installed automatically with the skills.

---

## Team Rollout

The simplest team rollout is:

1. Share this repo.
2. Ask teammates to run one install script.
3. Point them to the prompt cookbook.

That gives everyone the same setup, the same helper scripts, and the same usage patterns.
