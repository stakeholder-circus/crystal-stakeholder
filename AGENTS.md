# crystal-stakeholder AGENTS

1. Preserve imported Rust history and explicit provenance docs; do not present this repo as greenfield work.
2. This repo is an active local rewrite tranche and remains local-only until the 10 validated rewrite publication threshold is reached.
3. Required native commands for the current tranche:
   - `crystal tool format --check src spec`
   - `crystal build src/crystal_stakeholder.cr -o bin/crystal-stakeholder`
   - `crystal spec`
4. Docker is the authoritative release gate for this repo's first publication tranche.
5. Keep `origin` intended for `stakeholder-circus/crystal-stakeholder` and `upstream` pointed at `https://github.com/giacomo-b/rust-stakeholder`.
6. Preserve deterministic normalized JSON, explicit fail-fast gaps, and traceability rows back to Rust, Java, and stakeholder-core.
7. Do not hide missing behavior behind placeholders; record post-modern-core gaps in `GAPS.md` instead.
