# Changelog

## v0.10.1 - 2025-05-27 (Asia/Tokyo)

## Misc

- Mark for aqua registry.

## v0.10.0 - 2025-05-25 (Asia/Tokyo)

### Features

- Add support filename of configuration.

### Misc

- Update workspace.

## v0.9.0 - 2025-05-08 (Asia/Tokyo)

### Breaking changes

- `now` renders full timestamp text in templating.

### Features

- Update templatings.
  - Add `nowFormat` to render some fometted text of `now`.
    - `nowFormat.dateISO` renders `YYYY-MM-DD` style string.
  - Add `sameLengthChars` lambda recommended for writing underline.

### Misc

- Rename repository (`age-cli` -> `age`).
- Remove description about Rust.
- Use taskfile.
- Use remote lefthook hooks.
- Update dependency monitoring by Renovate.

## v0.8.0 - 2025-04-30 (Asia/Tokyo)

### Breaking changes

- Remove 'help' and 'version' subcommands.
  - Please use `--help` and `--version` options instead.
- `now` renders object now.
- Template syntax is changed from Jinja2-like to Mustache-like.

### Misc

- Change codebase from Rust to Nim.

## v0.7.0 - 2024-04-13 (JST)

### Features

- Support `regex` option in ``[[files]]`` to search by regular expression. (#8)

## v0.6.1 - 2024-04-08 (JST)

### Misc

- Change display message of `--version` option (#5)
- Add logging for some points

## v0.6.0 - 2024-04-06 (JST)

### Features

- Find parent configuration files.
- Support extra toml file for configuration.
  - `Cargo.toml` for Rust project.
  - `pyproject.toml` for Python project.

## v0.5.0 - 2024-03-22 (JST)

### Features

- Support multiline replacement.
- `init` command support `--preset` option to customize first `.age.toml`.

### Misc

- Rename project (binary name is not changed).
- Transfer repository into personarl space.
- Add management target by age.
- Update documents.
- Launch documentation site on https://age.attakei.dev/

## v0.4.0 - 2024-03-21 (JST)

### Breaking chances

- Remove `version` subcommand (use `--version` instead)

### Features

- Print error these cases:
  - Run `init` if configuration file is already exists.
  - Run except for `init` if configuration file is not exists or is invalid format.

## v0.3.0 - 2024-03-18 (JST)

### Features

- `search` and `replace` (of `[[files]]` in config) are supported context values. (#2)
- Add `now` about execute datetime into context values. (#2)

## v0.2.1 - 2024-03-15 (JST)

### Fixes

- Correct template for `age init` command.

## v0.2.0 - 2024-03-10 (JST)

### Breaking changes

- It is renamed application.
- Change replace search and target rule.
  It use `{{ ~ }}` instead of `{ ~ }`.

## v0.1.0 - 2024-03-10 (JST)

### Features

- Update managed version
- Replace value of version target sources
