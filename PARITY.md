# Parity

## Role

Readable static-typed scripting rewrite for the wider matrix queue, validated locally and held for publication.

## Parity class

- native-and-docker-validated-wider-matrix

## Implemented scope

- Full dedicated `classic-six`
- Full dedicated `modern-core`
- Grouped fallback for post-modern-core families
- Deterministic normalized JSON output
- Shared CLI contract subset for the current rewrite tranche
- Explicit experimental-provider fail-fast path

## Method and Review Model

- Codex-assisted
- Manually reviewed
- Human in the loop
- Derived from `giacomo-b/rust-stakeholder`
- Traceability anchored to Rust, Java, and `stakeholder-core`
- Missing behavior must fail fast and be recorded explicitly in `GAPS.md`

## Current divergence policy

- No silent divergence from the shared deterministic JSON contract is allowed.
- Presentation text may vary by language style while normalized JSON semantics remain stable.
- Post-modern-core families remain grouped fallback until explicitly promoted.
