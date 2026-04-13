# Toolchain contract

## Native commands
- `python3 scripts/validate_scaffold.py`
- `crystal tool format --check src spec`
- `crystal build src/crystal_stakeholder.cr -o bin/crystal-stakeholder`
- `crystal spec`

## Docker gate
- `docker build -t crystal-stakeholder .`
- `docker run --rm crystal-stakeholder --list-values --output-format json`
- representative family JSON smokes for classic-six and modern-core
- deterministic same-seed comparison for `platform_engineering`
- explicit `--experimental-provider` fail-fast smoke

## Toolchain sources
- Brew: `crystal`
- System shell: `python3`, `docker`
- Nix: `flake.nix` and `flake.lock` for reproducible shell/app entry points

## Current note
- Docker is the authoritative release gate for this repo.
- Native local checks remain required for formatter/build/spec feedback.
