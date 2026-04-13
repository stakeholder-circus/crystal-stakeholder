> [!IMPORTANT]
> This repository is part of a Codex-assisted rewrite experiment. All changes are manually reviewed, a human remains in the loop, and missing behavior is tracked explicitly rather than hidden. The project exists for fun, research, language learning, AI agent workflow/planning, interop experiments, and code review testing.
# crystal-stakeholder

Crystal rewrite under `stakeholder-circus`.

## Status
- Local full rewrite tranche for `classic-six + modern-core`.
- Deterministic CLI, normalized JSON, Docker gate, and explicit fail-fast provider path are implemented.
- Imported Rust history is preserved for attribution and auditability.
- Publication remains blocked until the wider program reaches 10 validated new rewrites.

## Role
- Readable static-typed scripting rewrite.
- Purpose: Ruby-like ergonomics plus static typing for rapid generator prototyping and readability comparison against Python.
- Program category: ecosystem reach.

## Commands
- `python3 scripts/validate_scaffold.py`
- `crystal tool format --check src spec`
- `crystal build src/crystal_stakeholder.cr -o bin/crystal-stakeholder`
- `crystal spec`
- `docker build -t crystal-stakeholder .`

## Current tranche
- Dedicated `classic-six` families:
  - `code_analyzer`
  - `data_processing`
  - `jargon`
  - `metrics`
  - `network_activity`
  - `system_monitoring`
- Dedicated `modern-core` families:
  - `agent_workflows`
  - `platform_engineering`
  - `observability_ai_runtime`
  - `delivery_preview_ops`
  - `supply_chain_security`
- Grouped fallback families:
  - `ai_governance`
  - `security_blockchain`
  - `health_protocol`
  - `overlay_quantum`

## Documentation
- [AI disclosure](AI_DISCLOSURE.md)
- [Parity](PARITY.md)
- [Explicit gaps](GAPS.md)
- [Remotes](docs/remotes.md)
- [Provenance](docs/provenance.md)
- [Toolchain](docs/toolchain.md)
- [First-push traceability](docs/traceability/first-push-families.md)
