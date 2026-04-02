---
layout: documentation
title: Project Info — JSON Configuration Dump
---

# Project Info — JSON Configuration Dump

The `pyb -i` (or `pyb --project-info`) command outputs the complete project
configuration as pretty-printed JSON to stdout, without running a build.

## Quick Start

```bash
# Dump full project configuration
pyb -i 2>/dev/null | python -m json.tool

# Extract a single value
pyb -i 2>/dev/null | jq -r .project.version

# Apply environment and property overrides
pyb -i -E ci -P coverage_break_build=false 2>/dev/null | jq .properties
```

## Output Separation

JSON is written to **stdout**. All log messages (plugin loading, initializer
execution, debug output) are written to **stderr**. This separation ensures
that the stdout stream is always valid JSON, regardless of verbosity level:

```bash
# JSON only
pyb -i 2>/dev/null

# JSON to file, logs visible
pyb -i > project.json

# JSON piped, debug logs to a file
pyb -i -X 2>debug.log | jq .

# Both visible (JSON to stdout, logs to stderr)
pyb -i
```

## What Runs

When `pyb -i` is invoked:

1. **`build.py` is loaded** — plugins are imported, project attributes are set.
2. **Plugin initializers run** — these populate default property values (e.g.
   `dir_source_main_python`, `coverage_threshold_warn`). Initializers only call
   `set_property_if_unset()` and bind utility functions; they do not create
   directories, install packages, or modify the filesystem.
3. **Property overrides are applied** — values from `-P` flags override
   plugin defaults.

**What does NOT run:** No tasks execute. No build/test virtual environments are
created. No dependencies are installed. No files are written to `target/`.

## JSON Schema

The output is a single JSON object with the following top-level keys:

### `pybuilder_version`

The PyBuilder version string.

### `project`

Project metadata:

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Project name (from `build.py` or directory name) |
| `version` | string | Declared version (e.g. `"1.0.dev"`) |
| `dist_version` | string | Distribution version with timestamp (e.g. `"1.0.dev20260401120000"`) |
| `basedir` | string | Absolute path to project root |
| `summary` | string | One-line project summary |
| `description` | string | Full project description |
| `author` | string | Primary author (legacy field) |
| `authors` | array | List of author objects with `name`, `email`, and optional `roles` |
| `maintainer` | string | Primary maintainer (legacy field) |
| `maintainers` | array | List of maintainer objects |
| `license` | string | License identifier |
| `url` | string | Primary project URL |
| `urls` | object | Named URL map (e.g. `{"Source Code": "https://..."}`) |
| `requires_python` | string | Python version specifier (e.g. `">=3.10"`) |
| `default_task` | string or array | Default task(s) when `pyb` is run without arguments |
| `obsoletes` | array | Obsoleted package names |
| `explicit_namespaces` | array | Explicit namespace packages |

### `environments`

Array of active environment names (from `-E` flags).

### `properties`

Object mapping property names to their values. Includes all built-in and
plugin-defined properties. Values that are not JSON-serializable (e.g. function
objects) are converted to their string representation.

### `plugins`

Array of loaded plugin names in load order.

### `dependencies`

Object with four sub-keys:

| Key | Contents |
|-----|----------|
| `runtime` | Dependencies from `depends_on()` |
| `build` | Dependencies from `build_depends_on()` |
| `plugin` | Dependencies from `plugin_depends_on()` |
| `extras` | Object mapping extra name to dependency array |

Each dependency is an object:

```json
{
  "name": "requests",
  "version": ">=2.28",
  "url": null,
  "extras": null,
  "markers": "sys_platform == 'linux'",
  "declaration_only": false,
  "type": "dependency"
}
```

Requirements files have `"type": "requirements_file"` and only `name`,
`version` (always null), and `declaration_only` fields.

### `tasks`

Array of task objects:

```json
{
  "name": "run_unit_tests",
  "description": "Runs all unit tests",
  "dependencies": [
    {"name": "compile_sources", "optional": false},
    {"name": "coverage", "optional": true}
  ]
}
```

### `manifest_included_files`

Array of glob patterns included in the distribution manifest.

### `package_data`

Object mapping package names to arrays of included file patterns.

### `files_to_install`

Array of `[destination, [filenames]]` pairs for files installed outside packages.

## Integration Examples

### CI/CD: Extract Version for Tagging

```bash
VERSION=$(pyb -i 2>/dev/null | jq -r .project.dist_version)
docker build -t myapp:$VERSION .
```

### Dependency Auditing

```bash
# List all runtime dependencies
pyb -i 2>/dev/null | jq -r '.dependencies.runtime[].name'

# Find dependencies without version constraints
pyb -i 2>/dev/null | jq '.dependencies.runtime[] | select(.version == null) | .name'
```

### Editor/IDE Integration

```bash
# Get source directory for language server configuration
SRC=$(pyb -i 2>/dev/null | jq -r '.properties.dir_source_main_python')

# Get test directory
TEST=$(pyb -i 2>/dev/null | jq -r '.properties.dir_source_unittest_python')
```

### Diffing Configuration Between Environments

```bash
diff <(pyb -i 2>/dev/null | jq -S .properties) \
     <(pyb -i -E ci 2>/dev/null | jq -S .properties)
```

## Command Line Options

`pyb -i` is compatible with most project options:

| Flag | Effect |
|------|--------|
| `-E <env>` | Activate environment (repeatable) |
| `-P <key>=<value>` | Override property value |
| `-D <dir>` | Set project directory |
| `-O` | Offline mode |
| `--no-venvs` | Disable venv creation |
| `-X` | Debug log output (to stderr) |
| `-v` | Verbose log output (to stderr) |
| `-q` / `-Q` | Suppress log output (on stderr) |

`pyb -i` is mutually exclusive with `-t`, `-T`, `--start-project`, and
`--update-project`.
