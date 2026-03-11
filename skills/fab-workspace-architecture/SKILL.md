---
name: fab-workspace-architecture
description: Use this skill to design, assess, and refine Microsoft Fabric architecture inside a single workspace with fab-cli, especially when the target pattern is one lakehouse per workspace with bronze, silver, and gold schemas plus explicit folders for notebooks, pipelines, and supporting assets by stage.
---

# Fab Workspace Architecture

## Overview

Use this skill when the task is about architectural guardrails inside one Fabric workspace rather than naming. It is optimized for:

1. designing a new single-workspace pattern
2. auditing an existing workspace against that pattern
3. planning safer remediation when structure, dependencies, or security boundaries are unclear

Use `fab-conventions` when the main problem is naming. Use `fab-workspace-organize` when the main problem is folder creation or cleanup. Use `fab-discovery` first when the current workspace shape is still unknown.

Read [references/single-workspace-architecture.md](references/single-workspace-architecture.md) for the architectural standard and official-platform caveats. Keep `SKILL.md` focused on workflow and decision-making.

## When To Use It

- User wants best practices for a Fabric workspace built around one lakehouse.
- User wants bronze, silver, and gold schemas or folders in a single workspace.
- User wants to know where notebooks, pipelines, semantic models, shortcuts, or shared code should live.
- User wants an architectural review of an existing Fabric workspace.
- User wants to know whether a single-workspace design is safe enough and what tradeoffs it carries versus multi-workspace isolation.

## Default Workflow

1. Determine whether the task is design, assessment, or remediation.
2. Inventory the workspace structure with `fab dir`, `fab get`, `fab api`, and item-specific metadata where needed.
3. Apply the target pattern from [references/single-workspace-architecture.md](references/single-workspace-architecture.md).
4. Separate findings into:
   - hard platform or operational risks
   - strong recommendations
   - optional preferences
5. Verify dependency flow:
   - sources or shortcuts into bronze
   - bronze into silver
   - silver into gold
   - gold into serving items such as semantic models or reports
6. Call out where the single-workspace pattern differs from Microsoft guidance that prefers stronger environment or layer isolation.
7. End with a concrete target structure, exceptions list, and next actions.

## Preferred Target Shape

Use this default blueprint unless the user gives a better domain-specific variant:

- one primary lakehouse for analytical persistence in the workspace
- `bronze`, `silver`, and `gold` schemas inside that lakehouse
- root-level workspace folders for:
  - bronze implementation assets
  - silver implementation assets
  - gold implementation assets
  - orchestration assets
  - shared utilities
- optional stage subfolders by source system or bounded domain

Recommend a shape like this in plain language:

```text
<workspace>
|- <lakehouse>
|  |- bronze schema
|  |- silver schema
|  |- gold schema
|- bronze/
|  |- <source-system>/
|- silver/
|  |- <domain-area>/
|- gold/
|  |- <data-product-or-serving-area>/
|- orchestration/
|  |- pipelines/
|  |- schedules/
|- shared/
|  |- utils/
|  |- tests/
|  |- config/
```

If the team is small, keep only one layer of subfolders. If the workspace grows, prefer `stage -> source` or `stage -> domain` rather than mixing both patterns inconsistently.

## Command Patterns

Inventory the workspace and item layout:

```powershell
fab dir "Analytics Dev.Workspace" -l
fab get "Analytics Dev.Workspace"
fab api "workspaces/<workspace-id>/items" -X get
fab api "workspaces/<workspace-id>/folders" -X get
```

Inspect a lakehouse, notebook, or pipeline before making architecture recommendations:

```powershell
fab get "Analytics Dev.Workspace/lh_core.Lakehouse"
fab get "Analytics Dev.Workspace/nb_bronze_ingest_sales.Notebook"
fab desc "Analytics Dev.Workspace/pl_ingest_sales.DataPipeline"
```

Inspect underlying metadata when the first-class surface is incomplete:

```powershell
fab api "workspaces/<workspace-id>/items/<item-id>" -X get
```

## Assessment Focus

For an architecture audit, check at least these dimensions:

- lakehouse strategy, including whether one lakehouse is being used consistently
- schema strategy for bronze, silver, and gold
- folder strategy for notebooks, pipelines, and shared assets
- ingestion pattern, including shortcuts versus copied raw data
- dependency direction and whether gold depends on raw assets directly
- serving pattern, especially whether reports or semantic models bypass gold
- security and identity handling
- deployment readiness, including whether the workspace is trying to represent multiple environments at once

## Guardrails

- Treat bronze, silver, and gold as contract boundaries, not just folder labels.
- Do not expose bronze directly to business-facing semantic models or reports.
- Do not mix shared utility notebooks into bronze, silver, or gold stage folders; keep them in a dedicated shared area.
- Do not put orchestration notebooks and pipelines inside stage folders when they coordinate multiple stages.
- Prefer phased remediation when changing item placement or dependencies for active workloads.
- Be explicit when the single-workspace choice trades away security or operational isolation that separate workspaces would provide.
- Keep environment separation distinct from medallion layering; a single workspace should not become dev, test, and prod at the same time.

## Decision Heuristics

Use these defaults when the user has not specified the structure in detail:

- Put ingestion notebooks, landing dataflows, and source-specific validation in `bronze`.
- Put standardization, conformance, deduplication, and reusable joins in `silver`.
- Put serving tables, publishing notebooks, and semantic-model-facing SQL artifacts in `gold`.
- Put multi-stage pipelines, triggers, restart logic, and control metadata in `orchestration`.
- Put helper modules, environment bootstrapping, test fixtures, and notebook templates in `shared`.

When an item fits multiple categories, place it where its primary responsibility lives and call out any cross-stage coupling explicitly.

## Output Expectations

- For design requests, return a target single-workspace architecture with rationale and exceptions.
- For audit requests, return a short scorecard plus prioritized findings.
- For remediation requests, separate:
  - safe structural changes
  - changes that need dependency validation
  - changes that should stay manual or happen during deployment windows
- Always distinguish official-platform guidance from team-specific constraints or choices.
