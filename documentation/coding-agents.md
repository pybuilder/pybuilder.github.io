---
layout: documentation
title: Coding Agents
---

# Using PyBuilder with Coding Agents

AI coding agents such as Claude Code, GitHub Copilot, Cursor, Windsurf and others
can work effectively with PyBuilder projects when given the right context. This page
provides guidance for coding agents on PyBuilder's conventions, and describes how to
configure agent instruction files for PyBuilder projects.

## Quick Reference for Agents

This section is written for coding agents directly. If you are a coding agent working
on a PyBuilder project, the information below tells you what you need to know.

### Build Commands

All build commands use `pyb` (the PyBuilder CLI):

```bash
# Full build (compile, test, analyze, package, publish)
pyb

# Verbose output
pyb -v

# Debug verbose output (all debug logging)
pyb -vX

# Run only unit tests
pyb run_unit_tests

# Run only integration tests
pyb run_integration_tests

# Clean and rebuild
pyb clean package

# List available tasks
pyb -t

# Dump project configuration as JSON (no build, stdout is clean JSON)
pyb -i 2>/dev/null | jq .

# Set a property from the command line
pyb -P property_name=value
```

### Project Layout

PyBuilder uses a convention-based directory layout similar to Maven:

```
build.py                          # Build descriptor (like pom.xml or build.gradle)
src/main/python/                  # Main Python source code
src/main/scripts/                 # Executable scripts
src/unittest/python/              # Unit tests (*_tests.py)
src/integrationtest/python/       # Integration tests (*_tests.py)
target/                           # Build output (gitignored)
target/dist/                      # Distribution artifacts
target/reports/                   # Test and analysis reports
```

These paths are defaults and can be overridden in `build.py` via project properties.

### The build.py File

`build.py` is a Python script that configures the project. It declares metadata,
plugins, and dependencies:

```python
from pybuilder.core import use_plugin, init

# Plugins provide build capabilities
use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.coverage")
use_plugin("python.flake8")
use_plugin("python.distutils")

# Project metadata (module-level variables)
name = "my-project"
default_task = "publish"

@init
def initialize(project):
    # Runtime dependencies
    project.depends_on("requests", ">=2.20")
    project.depends_on("click")

    # Build/test dependencies
    project.build_depends_on("mockito")

    # Plugin configuration via properties
    project.set_property("coverage_break_build", False)
    project.set_property("flake8_max_line_length", 120)
```

### Dependencies

Dependencies are declared in initializer functions:

```python
@init
def initialize(project):
    # Runtime dependency with version constraint
    project.depends_on("requests", ">=2.20")

    # Build-time dependency (testing, analysis, etc.)
    project.build_depends_on("mockito")

    # Plugin dependency (installed into plugin venv)
    project.plugin_depends_on("my-custom-plugin")

    # From a requirements file
    project.depends_on_requirements("requirements.txt")
    project.build_depends_on_requirements("requirements-dev.txt")
```

### Writing Tests

Unit tests go in `src/unittest/python/` and must match the glob `*_tests.py`:

```python
# src/unittest/python/my_module_tests.py
import unittest
from my_module import my_function

class MyModuleTests(unittest.TestCase):
    def test_my_function(self):
        self.assertEqual(my_function(2), 4)
```

Integration tests go in `src/integrationtest/python/` with the same naming convention.

### Virtual Environments

PyBuilder manages isolated venvs automatically. Do not install dependencies manually;
declare them in `build.py` and PyBuilder handles the rest.

- `.pybuilder/plugins/{version}/` — plugin dependencies (PyPI plugins)
- `target/venv/build/{version}/` — build/test tool dependencies (`build_depends_on()` + `depends_on()`)
- `target/venv/test/{version}/` — integration test runtime (`depends_on()` only)

Unit tests run in the **build** venv. Integration tests run in the **test** venv.

### Build Output and Logs

After a build, look for:

- `target/reports/unittest` — unit test console output
- `target/reports/unittest.json` — structured unit test results
- `target/reports/TEST-*.xml` — JUnit XML test results
- `target/reports/integrationtests/{test_name}` — per-integration-test stdout
- `target/reports/integrationtests/{test_name}.err` — per-integration-test stderr
- `target/reports/{name}_coverage.json` — coverage data per module
- `target/reports/{name}_coverage_html/` — interactive HTML coverage report
- `target/dist/` — distribution package
- `target/logs/install_dependencies/` — pip install logs

Use `pyb -v` to see individual test names. Use `pyb -vX` for full debug logging
including subprocess sys.path details and remoting diagnostics.

### Key Differences from setuptools/poetry/hatch

- **No `setup.py` or `pyproject.toml` to edit** — PyBuilder generates `setup.py`
  from `build.py` configuration. The `pyproject.toml`, if present, is a PEP 517
  build backend shim, not the project configuration.
- **Source code is not at the repo root** — it is under `src/main/python/`.
- **Tests are not in a `tests/` directory** — they are under `src/unittest/python/`
  and `src/integrationtest/python/`.
- **Dependencies are not in a requirements file by default** — they are declared
  programmatically in `build.py` via `project.depends_on()`.
- **Build output goes to `target/`** — not `dist/` or `build/`.

## Setting Up Agent Instructions

Most coding agents support project-level instruction files that provide context
about the project's conventions. When working on a PyBuilder project, the agent
instruction file should describe the build system so the agent knows how to build,
test, and navigate the project.

### Supported Instruction Files

Most coding agents read a Markdown file from the project root for context.
`AGENTS.md` is an emerging cross-tool standard supported by many agents.
Some agents also have their own tool-specific files:

| Agent | File | Notes |
|-------|------|-------|
| [AGENTS.md standard](https://agents.md/) | `AGENTS.md` | Cross-tool standard (OpenAI Codex, GitHub Copilot, Google Jules/Gemini CLI, Cursor, Roo Code, Aider, JetBrains Junie) |
| Claude Code | `CLAUDE.md` | Also supports `.claude/rules/*.md` for modular rules |
| GitHub Copilot | `.github/copilot-instructions.md` | Also reads `AGENTS.md` |
| Cursor | `.cursor/rules/*.mdc` | MDC format with YAML frontmatter; also reads `AGENTS.md` |
| Windsurf | `.windsurfrules` or `.windsurf/rules/*.md` | 6000 char limit per file |
| Cline | `.clinerules` or `.clinerules/*.md` | Inserted into system prompt verbatim |
| Roo Code | `.roo/rules/*.md` | Also reads `AGENTS.md` |
| Aider | `CONVENTIONS.md` | Loaded via `--read` flag; also reads `AGENTS.md` |
| Gemini CLI | `GEMINI.md` | Supports `@file.md` imports |
| JetBrains Junie | `.junie/guidelines.md` | Configurable to read `AGENTS.md` instead |
| Amazon Q Developer | `.amazonq/rules/*.md` | Directory of Markdown rule files |

All formats use plain Markdown for the instruction body. A practical approach for
maximum coverage is to maintain an `AGENTS.md` (covers most tools) and a `CLAUDE.md`
(covers Claude Code), with both sharing largely the same content.

### Recommended Content

A good agent instruction file for a PyBuilder project should include:

**Project overview** — what the project does, one or two sentences.

**Build commands** — how to build, test, and run analysis. Always include:
```markdown
## Building & Testing

This project uses PyBuilder. All build commands use `pyb`:

- `pyb` — full build
- `pyb run_unit_tests` — unit tests only
- `pyb run_integration_tests` — integration tests only
- `pyb -i` — dump project configuration as JSON (no build)
- `pyb -v` — verbose output
- `pyb -vX` — debug verbose output
```

**Project layout** — if the defaults are used, a brief note is enough.
If directories are customized, specify the actual paths:
```markdown
## Project Layout

- Source: `src/main/python/`
- Unit tests: `src/unittest/python/` (files matching `*_tests.py`)
- Integration tests: `src/integrationtest/python/`
- Build descriptor: `build.py`
```

**Code style** — any linting or formatting rules enforced by the build:
```markdown
## Code Style

- flake8 is enforced by the build (max line length: 120)
- All source files have Apache License 2.0 headers
```

**Dependency management** — how to add dependencies:
```markdown
## Adding Dependencies

Edit `build.py` and add to the initializer:
- Runtime: `project.depends_on("package-name", ">=1.0")`
- Build/test: `project.build_depends_on("package-name")`
```

### Example CLAUDE.md

Here is a complete example for a typical PyBuilder project:

```markdown
# My Project — Project Instructions

## Overview

MyProject is a REST API client library for the Acme service.

## Building & Testing

This project uses PyBuilder. All build commands use `pyb`:

- `pyb` — full build (test + analyze + package)
- `pyb run_unit_tests` — unit tests only
- `pyb run_integration_tests` — integration tests only
- `pyb -i` — dump project configuration as JSON (no build)
- `pyb -v` — verbose output
- `pyb -vX` — debug verbose output

## Project Layout

Standard PyBuilder layout:
- `build.py` — build descriptor
- `src/main/python/` — source code
- `src/unittest/python/` — unit tests (`*_tests.py`)
- `src/integrationtest/python/` — integration tests

## Code Style

- Max line length: 120 (flake8 enforced)

## Git Workflow

PRs to `master`. Always run `pyb` before pushing.
```
