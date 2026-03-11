---
name: fab-job-ops
description: Use this skill for running, scheduling, monitoring, and troubleshooting Fabric jobs with fab-cli, especially for notebooks, pipelines, and Spark job definitions that need status checks, polling, or schedule updates.
---

# Fab Job Ops

## Use

Use this skill when the user wants Codex to operate Fabric jobs end to end with `fab job`. It covers synchronous runs, asynchronous starts, polling, schedule changes, cancellations, and concise run summaries.

Read [references/job-runbook.md](references/job-runbook.md) for runbook-style troubleshooting and scheduling work. Use [scripts/poll_run.py](scripts/poll_run.py) when the user needs repeated status polling with a timeout.

Use [scripts/poll_latest_run.py](scripts/poll_latest_run.py) when the user wants "watch the latest run" and does not have an ID ready.

## Workflow

1. Confirm the target item path and job mode: run now, start asynchronously, inspect, schedule, or cancel.
2. Use `fab job --help` and the relevant subcommand help if arguments are not obvious.
3. Trigger the run.
4. Poll with `fab job run-status` or `fab job run-list` when the task requires waiting or troubleshooting.
5. Summarize the final state, important timestamps, run IDs, and next action.

## Commands

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
- If a notebook run fails with schema errors such as `SCHEMA_NOT_FOUND`, do not treat successful `fab dir` or `fab exists` checks under `Lakehouse/Tables` as proof that the target Spark schema exists.
- For notebook jobs that write with `saveAsTable("<schema>.<table>")`, recommend verifying the schema from notebook or SQL endpoint perspective, or running a bootstrap step such as `CREATE SCHEMA IF NOT EXISTS bronze`, `silver`, and `gold`, before retrying the job.
- For long waits, report periodic status instead of staying silent.
- If cancellation is requested, use the specific run identifier and confirm that the target run changed state.
- Prefer `fab job run-status --id <run-id>` over `fab job run-list` whenever the run ID is known. In some environments `run-list` may return `No runs found` even though the run exists and `run-status` works.
- For pipeline runs, `NotStarted` can represent a queued state rather than a failure. Poll until it transitions or times out before concluding that the run is stuck.

## Reporting Style

- Prefer rich Markdown presentation over plain prose when reporting job state, schedule changes, or troubleshooting.
- Start with a short status line that uses clear icons such as `OK`, `WARN`, `FAIL`, or `INFO`.
- Use compact tables for run ID, item path, state, timestamps, duration, and validation source.
- Separate the response into short sections such as `Run summary`, `Timeline`, `Diagnosis`, and `Next action`.
- Use fenced code blocks only for exact commands or schedule payloads the user may need to reuse.
- Use simple diagrams only when they clarify status progression, retry flow, or stage transitions.
- For live monitoring, keep updates visually consistent across polling cycles.

## Output

- Include the exact job command.
- Report run ID, state, and whether the action completed or is still in progress in a compact status view.
- If scheduling changed, include the updated schedule details and what changed.
- If the run was validated with `run-status` because `run-list` was incomplete, say so explicitly.
- If the likely blocker is a Spark schema mismatch rather than a path problem, say that explicitly so the user does not retry a job that is guaranteed to fail again.
