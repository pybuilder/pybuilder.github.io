---
layout: post
title: "New Feature: pyb --project-info for Machine-Readable Project Configuration"
author: arcivanov
categories: news
---

PyBuilder now supports dumping the full project configuration as machine-readable
JSON, without running a build. Use `pyb -i` or `pyb --project-info` to inspect
everything PyBuilder knows about your project after loading plugins and running
initializers.

**Clean stdout/stderr separation.** JSON goes to stdout, log messages go to
stderr. This means you can pipe the output directly into `jq`, `python -m
json.tool`, or any JSON consumer:

```bash
# Get the project name
pyb -i 2>/dev/null | jq .project.name

# Inspect all properties with environment and overrides applied
pyb -i -E ci -P verbose=true 2>/dev/null | jq .properties

# Feed into CI scripts
PROJECT_VERSION=$(pyb -i 2>/dev/null | jq -r .project.version)
```

**What's included.** The JSON output covers: project metadata (name, version,
authors, license, URLs), all build properties (built-in and plugin-defined),
loaded plugins, runtime/build/plugin/extras dependencies, available tasks with
their descriptions and dependency graphs, manifest files, and package data.

**No side effects.** Plugin initializers run to populate properties, but no tasks
execute, no venvs are created, and no dependencies are installed. It is safe and
fast to run in any context.

See the [usage documentation](/documentation/manual.html#inspecting-project-configuration)
for details, or the [dedicated project-info page](/documentation/project-info.html)
for the full JSON schema reference and integration examples.
