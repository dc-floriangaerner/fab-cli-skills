---
name: fab-job-ops
description: Use this skill for running, scheduling, monitoring, and troubleshooting Fabric jobs with fab-cli, especially for notebooks, pipelines, and Spark job definitions that need status checks, polling, or schedule updates.
---

# Fab Job Ops

## Overview

Use this skill when the user wants Codex to operate Fabric jobs end to end with `fab job`. It covers synchronous runs, asynchronous starts, polling, schedule changes, cancellations, and concise run summaries.

Read [references/job-runbook.md](C:/Users/florian.gaerner/.codex/skills/fab-job-ops/references/job-runbook.md) for runbook-style troubleshooting and scheduling work. Use [scripts/poll_run.py](C:/Users/florian.gaerner/.codex/skills/fab-job-ops/scripts/poll_run.py) when the user needs repeated status polling with a timeout.

Use [scripts/poll_latest_run.py](C:/Users/florian.gaerner/.codex/skills/fab-job-ops/scripts/poll_latest_run.py) when the user wants "watch the latest run" and does not have an ID ready.

## When To Use It

- User asks to run a notebook, pipeline, or Spark job and wait for the result.
- User wants a status summary for a failing or long-running job.
- User asks to create, update, or remove a scheduled run.
- User needs the latest job run IDs and outcome details.

## Default Workflow

1. Confirm the target item path and job mode: run now, start asynchronously, inspect, schedule, or cancel.
2. Use `fab job --help` and the relevant subcommand help if arguments are not obvious.
3. Trigger the run.
4. Poll with `fab job run-status` or `fab job run-list` when the task requires waiting or troubleshooting.
5. Summarize the final state, important timestamps, run IDs, and next action.

## Command Patterns

Run a job synchronously:

```powershell
fab job run "ws.Workspace/item.Notebook"
```

Start without waiting:

```powershell
fab job start "ws.Workspace/item.Notebook"
```

Check recent runs:

```powershell
fab job run-list "ws.Workspace/item.Notebook"
```

Inspect one run in detail:

```powershell
fab job run-status "ws.Workspace/item.Notebook" --id "<run-id>"
```

Schedule a job:

```powershell
fab job run-sch "ws.Workspace/item.Notebook"
```

Poll until the run finishes:

```powershell
python scripts/poll_run.py "ws.Workspace/item.Notebook" "<run-id>"
```

Poll the latest run automatically:

```powershell
python scripts/poll_latest_run.py "ws.Workspace/item.Notebook"
```

## Troubleshooting Pattern

- If a job fails, gather `run-list` and `run-status` output before suggesting retries.
- Separate infrastructure failure, authentication failure, and notebook or pipeline logic failure when summarizing.
- For long waits, report periodic status instead of staying silent.
- If cancellation is requested, use the specific run identifier and confirm that the target run changed state.

## Output Expectations

- Include the exact job command.
- Report run ID, state, and whether the action completed or is still in progress.
- If scheduling changed, include the updated schedule details and what changed.
