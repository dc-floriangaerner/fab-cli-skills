---
name: fab-semantic-model
description: Use this skill to inspect, improve, and document Microsoft Fabric or Power BI semantic models, especially when connecting through the Power BI Modeling MCP Server to Fabric, Power BI Desktop, or TMDL/PBIP sources and applying safe best practices for relationships, naming, measures, hierarchies, descriptions, and documentation.
---

# Fab Semantic Model

## Use

Use this skill when the task is to inspect, clean up, extend, or document a semantic model.

This skill is optimized for:

1. improving an existing model end-to-end with safe direct changes
2. reviewing a model and separating safe fixes from risky recommendations
3. building reusable semantic-model standards for a team
4. documenting a model in Markdown for handoff or governance

If the Power BI Modeling MCP Server is available, always use it for model inspection and changes. Do not edit TMDL files directly when that server is present. Use exported TMDL only for documentation or diff-friendly inspection when helpful.

Read [references/modeling-best-practices.md](references/modeling-best-practices.md) when choosing defaults, deciding whether a change is safe, or explaining why something was skipped.

When Tabular Editor guidance is relevant, use the merged Tabular Editor baseline in [references/modeling-best-practices.md](references/modeling-best-practices.md).

Use `fab-discovery` only when you first need to discover the Fabric workspace or semantic model identity. Use `fab-conventions` only when the request is mostly about cross-workspace naming governance rather than model internals.

## Connection Order

Prefer this connection order:

1. open Power BI Desktop model on Windows when the user says the file is already open
2. Fabric semantic model in a workspace when the user gives workspace and model names
3. local TMDL or PBIP semantic-model folder when the user is working from source files

Use `connection_operations` to inspect available connections and connect through the correct path:

- `ListLocalInstances` for open Desktop models
- `ConnectFabric` for Fabric-hosted semantic models
- `ConnectFolder` for TMDL or PBIP semantic-model definition folders
- `GetLastUsed` or `SetLastUsed` when continuing an existing modeling session

When loading a PBIP project, connect only to the `.SemanticModel/definition` folder.

## Workflow

1. Connect to the target model with the Power BI Modeling MCP Server.
2. Inventory the current state with `model_operations`, `table_operations`, `column_operations`, `measure_operations`, `relationship_operations`, `user_hierarchy_operations`, `perspective_operations`, `security_role_operations`, `culture_operations`, `partition_operations`, `calendar_operations`, and `named_expression_operations` as needed.
3. Split findings into:
   - safe direct changes
   - ambiguous or risky items that should be skipped and documented
4. For multi-object edits, prefer a transaction or a tightly grouped sequence so partial updates are minimized.
5. Apply changes in this order unless the request calls for a narrower scope:
   - relationships and star-schema cleanup
   - safe naming cleanup
   - hide technical fields
   - field properties and data types
   - measures table and core measures
   - display folders
   - hierarchies
   - descriptions
   - Markdown documentation
6. Re-read the affected objects after each major change area.
7. Validate measure expressions with `measure_operations`, `function_operations`, and `dax_query_operations` when the logic changed materially.
8. End with a consolidated summary of changes, skips, assumptions, and follow-up advice.

## Modeling Rules

### 1. Star Schema

- Prefer fact-to-dimension relationships with dimensions on the `1` side and facts on the `*` side.
- Prefer single-direction filtering from dimension to fact.
- Prefer one active relationship path between two filter domains.
- Create a missing relationship only when the join looks clearly inferable from names, compatible data types, and likely uniqueness on the dimension side.
- Skip relationships that would introduce ambiguity, many-to-many risk, or uncertain business meaning.
- If a snowflake can be flattened safely into a simpler star, recommend it; do not force a large restructure unless the user asked for broader remodeling.

### 2. Naming

- Standardize tables, columns, measures, hierarchies, and folders toward short business-facing names.
- Favor consistency over cleverness.
- Prefer readable names with spaces over CamelCase for visible objects unless the model relies on translations that intentionally present user-friendly names separately.
- Prefer visible table and measure names that start with uppercase letters and avoid technical prefixes in user-facing names.
- Apply only safe renames that can be updated cleanly in dependent objects during the same session.
- When one relationship exists between two tables, prefer aligned key names on both sides. When multiple role-playing relationships exist, prefer fact-side names that clarify the role, such as `Order Date Key` and `Ship Date Key`.
- Re-check affected measures, hierarchies, sort-by settings, relationships, translations, and perspectives after renames.

### 3. Hidden Technical Fields

Hide fields that are primarily technical and not useful to report authors, such as:

- surrogate keys
- foreign keys
- `*ID`, `*Id`, `*Key`
- GUIDs
- row identifiers
- sort helper columns that should not be used directly

Keep business attributes visible when users may actually slice, filter, search, or reconcile by them.

### 4. Data Types and Field Properties

- Prefer whole numbers for integer keys, sequence numbers, and counts.
- Use `Date` or `DateTime` deliberately; do not keep timestamps when a date grain is the real semantic meaning.
- Avoid floating-point `Double` where fixed decimal or whole number is the better semantic type.
- Keep decimal types only where fractional precision is needed, such as currency, rates, percentages, ratios, or measurements.
- Default visible numeric columns to `Do Not Summarize`; prefer explicit measures for business aggregations instead of implicit column summarization.
- Set IDs and codes to `Do Not Summarize`.
- Assign format strings to visible numeric and date fields and to visible numeric measures.
- Avoid risky type changes that could break relationships, DAX logic, or source-query assumptions.

### 5. Measures Table and Core Measures

- Reuse an existing dedicated measures table when present; otherwise create one.
- Move explicit measures into that table when the user wants central organization.
- Hide any placeholder column used only to host the table.
- Detect the primary fact table or fact tables before creating measures.
- Detect the amount column, status column, and primary date table from the model rather than assuming names.
- If a valid date table or calendar is missing, create time-intelligence measures that return `BLANK()` and explain why.
- Use `DIVIDE` for percentage measures and other protected division patterns.
- Prefer fully qualified column references and unqualified measure references in DAX where expressions are touched.
- State assumptions for business definitions such as `Net Sales`.

### 6. Display Folders

- Keep folder names short, professional, and stable.
- Reuse a good existing structure rather than churning names.
- Group measures by business area or calculation family, not by every tiny variation.
- Normalize casing and separator style when the current folders are inconsistent.
- When a table has many visible columns, hierarchies, or measures, organize them into display folders for usability.

### 7. Hierarchies

Create or repair only natural drill paths that actually exist in the data, for example:

- Date: `Year > Quarter > Month > Day`
- Geography: `Country > Region/State > City`
- Product: `Category > Subcategory > Product`

Do not create redundant hierarchies or duplicate what a calendar object already handles well.

### 8. Descriptions

Add clear descriptions to tables, columns, measures, and hierarchies.

Use these description rules:

- tables: business purpose and grain
- columns: meaning, business unit where relevant, and notable usage notes
- technical keys: short technical purpose only
- measures: plain-language definition and a brief logic summary
- hierarchies: intended drill path and level meaning

When cultures exist, prefer translated names, descriptions, hierarchy level names, and display folders instead of leaving only the base-language metadata.

### 9. Documentation

When asked to generate semantic-model documentation, produce Markdown that includes:

- overview and intended usage
- table-by-table data dictionary
- measures with DAX and business explanation
- relationship summary
- role or row-filter summary when roles exist
- high-level Power Query source summary when it can be derived safely
- Mermaid ER diagram
- display-folder layout
- assumptions, exceptions, and skipped risky changes

## Safety Rules

- Default to safe, non-breaking changes.
- Prefer metadata and organizational cleanup before structural remodeling.
- Do not create ambiguous relationships.
- Do not convert data types when relationship or logic breakage is likely.
- Do not assume a date table is valid just because a table is named `Date` or `Calendar`; verify it.
- If auto date/time tables exist, prefer a proper shared date table and treat auto date/time as technical debt.
- Prefer active single-path filtering over bidirectional fixes.
- If a required business rule is unclear, implement the safest neutral version and document the assumption.
- Do not delete unused hidden columns or measures automatically unless dependencies have been checked carefully; report them as cleanup candidates by default.
- Do not force perspective or translation work unless the model already uses perspectives or cultures, or the user explicitly wants multilingual or persona-specific design.
- When the model is large or the change is broad, checkpoint progress with concise summaries between phases.

## Reporting Style

- Prefer rich Markdown over plain prose for review and remediation output.
- Start with a short status line such as `OK`, `WARN`, `FAIL`, or `INFO`.
- Use compact tables for rename mappings, hidden fields, created measures, skipped items, and coverage stats.
- Keep one change log section that records what changed and why.
- Separate skipped items from completed changes.
- Include assumptions explicitly.
- Use Mermaid only when it materially clarifies the model shape.

## Output

For end-to-end improvement requests, return:

- connection path used
- summary of safe changes applied
- skipped items with reason
- rename mapping
- hidden fields by table
- property and data type changes
- created or moved measures
- final folder structure
- created or updated hierarchies
- description coverage stats
- complete Markdown model documentation when requested

Always state whether the Power BI Modeling MCP Server was used and whether any direct changes were intentionally deferred for safety.
