> [!NOTE]
> Missing or deferred behavior must fail fast and be tracked explicitly. No placeholder behavior should mask absent parity work.

# Crystal Gaps

## Current explicit gaps
- `crystal-stakeholder.post-modern-core-grouped-fallback`: `ai_governance`, `security_blockchain`, `health_protocol`, and `overlay_quantum` still use grouped fallback renderers instead of dedicated implementations.
- `crystal-stakeholder.experimental-provider-runtime-pending`: live-provider adapters, encrypted local provider state, and browser/session import flows remain open gaps in the full live-provider expansion lane.
- `crystal-stakeholder.publication-held`: remote creation and first push stay blocked until the wider program reaches 10 validated new rewrites.
- `crystal-stakeholder.codeql-activation-pending`: CodeQL activation is deferred until publication and supported-language scanning policy are finalized.

## Guardrail
- Do not present this repo as end-state complete.
- Deterministic parity output is implemented for the current tranche; anything beyond the current tranche must either fail fast or remain explicitly grouped fallback.
