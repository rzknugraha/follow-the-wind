# Contributing Guide

This repository uses a simple commit message convention so changes are easy to recognize from the Git history.

## Commit Message Format

Use this format:

```text
<type>: <short message>
```

Examples:

```text
feat: add standalone redis stack
fix: correct python compose env path
docs: update readme usage instructions
chore: update gitignore entries
```

## Commit Types

| Type | Use For |
|---|---|
| `feat` | New feature or new capability |
| `fix` | Bug fix or correction |
| `docs` | Documentation changes |
| `chore` | Maintenance work that does not change behavior |
| `refactor` | Code or structure improvement without changing behavior |
| `style` | Formatting, spacing, or naming cleanup |
| `test` | Test-related changes |
| `build` | Docker, dependency, package, or build system changes |
| `ci` | CI/CD or automation changes |
| `perf` | Performance improvement |
| `revert` | Revert a previous commit |

## Rules

- Use lowercase type names.
- Use a colon after the type.
- Put one space after the colon.
- Keep the message short and clear.
- Use English for commit messages.
- Use imperative style when possible.

Good examples:

```text
feat: add standalone kafka stack
fix: remove unused external network
docs: add python environment usage guide
build: update python dockerfile base image
```

Avoid:

```text
feat : add redis
Fix bug
updated things
add file
```

The preferred style is `feat: message`, not `feat : message`.
