---
layout: documentation
title: Usage Documentation
---

# PyBuilder Usage Documentation

## Introduction

*PyBuilder* is a multi-purpose software build tool. Most
commonly it targets the building and management of software with a strong focus on Python.


### Building Python Projects

Some of the capabilities provided by *PyBuilder* out-of-the box are:
* Automatic execution of unit and integration tests on every build
* Automatic analysis of the code coverage
* Automatic execution and result interpretation of analysis tools, such as flake8
* Automatic generation of distutils script ```setup.py```

The general idea is that everything you do in your _continuous integration_ chain, you also do locally
before checking in your work.

### Why Another Build Tool

When working on large scale software projects based on Java and Groovy I delved into the build process using tools
such as *Apache Ant*, *Apache Maven* or *Gradle*. Although none of these tools is perfect they all provide a powerful and
extensible way for building and testing software.

When focusing on Python I looked for a similar tool and got frustrated by the large number of tools that all match
some aspect of the build and test process. Unfortunately, many of those tools were not suitable for composition and
there was no central point of entry.

I suddenly found myself writing "build scripts" in Python over and over again using the tools I found out to be
useful.

*PyBuilder* was born on the attempt to create a reusable tool that should
* Make simple things simple
* Make hard things as simple as possible
* Let me use whatever tool I want to integrate
* Integrate these tools into a common view
* Let me use Python (which is really great) to write my build files


## Concepts

*PyBuilder* executes build logic that is organized into tasks and actions.

Tasks are the main building blocks of the build logic. A task is an enclosed piece of build logic to be executed as
a single unit. Each task can name a set of other tasks that it depends on. *PyBuilder* ensures that a
task gets executed only after all of its dependencies have been executed.


Actions are smaller pieces of build logic than tasks. They are bound to the execution of task. Each action states
that it needs to be executed *before* or *after* a named task. PyBuilder will execute the action if
and only if the named task is executed, either directly or through another tasks' dependencies.

Actions as well as tasks are decorated plain Python functions.
Thus, you can structure your code the way you like if you provide a single point of entry to a build step.

Both task and action functions can request parameters known to *PyBuilder* through dependency injection
by parameter name.

## Writing Tasks

Writing a task is easy. You just create a function and decorate with the ```@task``` decorator, and add it to your `build.py`:

<pre><code>from pybuilder.core import task

@task
def say_hello ():
    print "Hello, PyBuilder"
</code></pre>

There is now a new task named `say_hello` available to you. You can verify this by running `pyb -t`.

### Dependency Injection

*PyBuilder* supports dependency injection for tasks based on parameter names. The following parameters can be used to
receive components:

<dl>
  <dt>logger</dt>
  <dd>A logger instance which can be used to issue messages to the user.</dd>
  <dt>project</dt>
  <dd>An instance of the project that is currently being built.</dd>
  <dt>reactor</dt>
  <dd>An instance of the Reactor that manages the build lifecycle.</dd>
</dl>


Thus we can rewrite the task above to use the logger:

<pre><code>from pybuilder.core import task

@task
def say_hello (logger):
   logger.info("Hello, PyBuilder")
</code></pre>

## Project-specific configuration

### Initializers
The configuration of a project is done by mutating the `project` object. You can access this object from within `build.py` by
writing an initializer.
An initializer is a plain python function that is decorated to become an initializer:

<pre><code>
from pybuilder.core import init
@init
def initialize(project):
    pass
</code></pre>

Pybuilder always collects and calls initilizers from `build.py` sorted by alphabetical order.
This fact could be used for initilizers managing.

<pre><code>
from pybuilder.core import init

@init
def initialize2(project):
    pass
    
@init
def initialize1(project):
    pass
</code></pre>

```
[DEBUG] Registering initializer 'initialize1'
[DEBUG] Registering initializer 'initialize2'
....
[DEBUG] Executing initializer 'initialize1' from 'build'
[DEBUG] Executing initializer 'initialize2' from 'build'
```

`pyb` command apply project option `-E <environment>, --environment=<environment>`
which could be used to define environment specific initializers.

<pre><code>
from pybuilder.core import init
@init(environments="dev")
def initialize_dev_env(project):
    pass
</code></pre>

So initializer `initialize_dev_env` will be called only if `pyb` is called with project option `--environment=dev`.

Project option `-E <environment>, --environment=<environment>` can be used multiple time.

### Project Attributes
Project attributes are values that describe a project. Unlike the properties below, they are not used
to configure plugins but rather to describe the project. Each project has several default attributes
like `version` and `license`. These can be set in the `build.py`:

<pre><code>
name = "myproject"
version = "0.1.14"
</code></pre>

 
Or from within an initializer:

<pre><code>@init
def initialize(project):
    project.version = "0.1.14"
</code></pre>

A project's attributes affect the build in a variety of ways. For instance the `license` attribute
is used when generating a setuptools script to correctly fill the metadata fields.
A notable use case for project attributes is replacing placeholder values in source files
at build-time with the [filter_resources plugin](/documentation/plugins.html#filtering-files).

### Project Version Attribute
The `version` has to be specified by PEP-440.
Additionally, *PyBuilder* provides *Apache Maven* logic for versions with suffix `.dev` by adding 
generated timestamp label after that which guarantees unique increasing version of distribution.
For example, project with version `0.1.14.dev` will be built with version `0.1.14.dev20171004032551`.   

### Project Properties
A property is identified by a key (the *name* of the property, which is a string) and has a value.
The type of a property value can be any valid python type.

Project properties are used to configure plugins.
Plugins that rely on properties usually set a default value, that you can override.
This is conform to the idea of _convention over configuration_.

For instance the `unittest` plugin ships with a default property `unittest_module_glob` set to `"*_tests"`.
If the default value does not suit you you can override it by setting the property to something else.

This is done by using the `set_property` method of the 
[`project` object](#). You should do this from within an initializer like so:

<pre><code>@init
def initialize(project):
     project.set_property('unittest_module_glob', '*_unittest')
</code></pre>

A complete reference of the available properties is included in the [plugin reference](/documentation/plugins.html)

#### Setting Properties from tasks
Tasks should always bring a sane default for mandatory properties. Setting properties is done from an _initializer_, just like in `build.py`.
Note that setting project properties from within a task function is possible but will override user-specified properties because initializers run before tasks are executed.
Thus, as a general rule, functions decorated with `task` should only read project properties using <code>project.get_property</code>.

#### Setting Properties from the command line

Properties can be set or overridden using command line switches.

<pre>$ pyb -P spam="spam message"</pre>

This command sets/ overrides the property with the name ```spam``` with the value ```spam message```.

Note that command line switches only allow properties to be set/ overridden using string values.

## Virtual Environment Infrastructure

*PyBuilder* manages isolated Python virtual environments for building and testing.
Understanding this infrastructure is essential for troubleshooting dependency issues
and configuring advanced build scenarios.

### The Four Python Environments

PyBuilder maintains up to four distinct Python environments during a build:

<table class="table table-striped">
  <tr>
    <th>Name</th>
    <th>Location</th>
    <th>Purpose</th>
    <th>What Gets Installed</th>
  </tr>
  <tr>
    <td><strong>system</strong></td>
    <td>The Python running PyBuilder</td>
    <td>Baseline environment, fallback when venvs are disabled</td>
    <td>PyBuilder itself</td>
  </tr>
  <tr>
    <td><strong>pybuilder</strong></td>
    <td><code>.pybuilder/plugins/{version}/</code></td>
    <td>Plugin dependencies (PyPI plugins)</td>
    <td>Packages required by <code>use_plugin("pypi:...")</code> and <code>plugin_depends_on()</code></td>
  </tr>
  <tr>
    <td><strong>build</strong></td>
    <td><code>target/venv/build/{version}/</code></td>
    <td>Build and test tools</td>
    <td><code>build_depends_on()</code> + <code>depends_on()</code> dependencies</td>
  </tr>
  <tr>
    <td><strong>test</strong></td>
    <td><code>target/venv/test/{version}/</code></td>
    <td>Integration test runtime</td>
    <td><code>depends_on()</code> dependencies only</td>
  </tr>
</table>

The `{version}` directory name is derived from the Python implementation and version,
for example `cpython-3.13.2` or `pypy-7.3.12`. Free-threaded builds append `t`
(e.g. `cpython-3.14.0t`) and debug builds append `-debug`.

### Environment Lifecycle

The environments are created in this order during a build:

1. **system** is registered at startup from the Python running `pyb`.
2. **pybuilder** is created during `prepare_build()`, *before* any plugins are loaded.
   Its site-packages are added to `sys.path` so that plugin imports succeed.
3. **build** and **test** are created during the `prepare` task, after plugins and
   initializers have run. Dependencies declared via `depends_on()` and
   `build_depends_on()` are installed via pip into the appropriate venvs.

### Directory Layout

<pre>
project_root/
├─ .pybuilder/
│  └─ plugins/
│     └─ cpython-3.13.2/           # pybuilder env
│        ├─ bin/python3.13
│        └─ lib/python3.13/site-packages/
│
└─ target/
   ├─ venv/
   │  ├─ build/
   │  │  └─ cpython-3.13.2/        # build env
   │  │     ├─ bin/python3.13
   │  │     └─ lib/python3.13/site-packages/
   │  └─ test/
   │     └─ cpython-3.13.2/        # test env
   │        ├─ bin/python3.13
   │        └─ lib/python3.13/site-packages/
   ├─ dist/                         # packaged distribution
   ├─ reports/                      # test and analysis reports
   └─ logs/
      └─ install_dependencies/      # pip install logs
</pre>

### Which Environment Runs What

- **Unit tests** run in the **build** environment by default
  (controlled by `unittest_python_env` property).
- **Integration tests** run in the **test** environment by default
  (controlled by `integrationtest_python_env` property).
- **Plugin code** (flake8, coverage, pylint, etc.) runs using packages from the
  **pybuilder** environment.

### Controlling Venv Behavior

<pre><code>@init
def initialize(project):
    # Force recreation of venvs on every build
    project.set_property("refresh_venvs", True)

    # Customize which venvs are created (default: ["build", "test"])
    project.set_property("venv_names", ["build", "test"])

    # Override default dependency mapping per venv
    project.set_property("venv_dependencies", {
        "build": [Dependency("pytest"), Dependency("coverage")],
        "test": [Dependency("requests")]
    })
</code></pre>

### Running Without Venvs

Passing `--no-venvs` to `pyb` disables virtual environment creation. All environments
fall back to the system Python. This is a legacy mode primarily used for debugging
and is not recommended for normal builds, as it can lead to dependency conflicts
and unreliable coverage results.

## Unit Testing in Detail

The `python.unittest` plugin executes unit tests using Python's `unittest` module
with subprocess isolation and remote object proxying.

### Test Discovery

Tests are discovered by scanning `src/unittest/python/` (configurable via
`dir_source_unittest_python`) for files matching the `unittest_module_glob` pattern
(default: `*_tests`). File paths are converted to Python module names:

- `src/unittest/python/foo_tests.py` becomes module `foo_tests`
- `src/unittest/python/pkg/bar_tests.py` becomes module `pkg.bar_tests`

### Subprocess Isolation and Remoting

Unit tests do **not** run in the main PyBuilder process. Instead, the plugin uses
a remoting mechanism based on Python's `multiprocessing` module:

1. **Spawn subprocess**: A child process is started using the **build** venv's
   Python interpreter. The `multiprocessing` module is patched so that:
   - The child uses the build venv's `python` executable
   - The child's `sys.path` is remapped to use the build venv's site-packages
     instead of the parent process's

2. **Load tests in child**: The subprocess inserts `src/unittest/python/` and
   `src/main/python/` at the front of `sys.path`, then uses
   `unittest.defaultTestLoader.loadTestsFromNames()` to import and discover tests.

3. **Proxy tests to parent**: The loaded test suite is exposed to the parent process
   through a `RemoteObjectPipe`. The parent receives a proxy object that can invoke
   methods on the real test objects in the child.

4. **Execute via runner**: The parent's test runner (default: `XMLTestRunner`) calls
   `runner.run(tests)`. Each test method invocation is proxied as an RPC call to the
   child process, where the actual test code executes. Results are marshaled back
   via pickle serialization.

5. **Collect results**: After all tests complete, the pipe is closed and the
   subprocess terminates.

This architecture ensures that:
- Test imports cannot pollute the build process
- Each test run starts with clean module state
- Build tool dependencies (coverage, xmlrunner) are available via the build venv
- Source code is imported from `src/main/python/`, not from installed packages

### Unit Test Logs and Reports

Unit test output is written to `target/reports/`:

<table class="table table-striped">
  <tr>
    <th>File</th>
    <th>Format</th>
    <th>Contents</th>
  </tr>
  <tr>
    <td><code>target/reports/unittest</code></td>
    <td>Text</td>
    <td>Console output from the test run</td>
  </tr>
  <tr>
    <td><code>target/reports/unittest.json</code></td>
    <td>JSON</td>
    <td>Structured results: test count, errors, failures with tracebacks</td>
  </tr>
  <tr>
    <td><code>target/reports/TEST-*.xml</code></td>
    <td>JUnit XML</td>
    <td>Per-test-class XML results (generated by xmlrunner)</td>
  </tr>
</table>

Use `pyb -v` to see individual test names as they execute. Use `pyb -vX` for full
debug logging including subprocess sys.path details and remoting diagnostics.

## Integration Testing in Detail

The `python.integrationtest` plugin runs each integration test as a standalone
subprocess. Unlike unit tests, there is no remoting or RPC; each test file is
executed as an independent Python script.

### Test Discovery

Integration tests are discovered by scanning `src/integrationtest/python/`
(configurable via `dir_source_integrationtest_python`) for files matching
`integrationtest_file_glob` (default: `*_tests.py`).

### Execution Model

Each test file is executed in its own process:

<pre><code># Effective command for each test:
/path/to/target/venv/test/{version}/bin/python test_file.py [additional_args]
</code></pre>

The test venv's Python executable is used (controlled by
`integrationtest_python_env`, default: `"test"`).

### Classpath and PYTHONPATH

Integration tests import source code from the **built distribution**, not from
`src/main/python/` directly. The `PYTHONPATH` is set to:

<pre>
target/dist/{project-name}-{version}/    # Packaged source code
src/integrationtest/python/              # Test source directory
</pre>

This means the `package` task must complete before integration tests run (which is
enforced by task dependencies). The distribution in `target/dist/` contains the
compiled/copied source code, ensuring tests run against the actual distributable
package.

### Environment Variables

The integration test environment is constructed in layers:

1. **PYTHONPATH** is set to the distribution and test source directories.
2. **Additional environment** variables from the `integrationtest_additional_environment`
   property (a dict) are merged in.
3. If `integrationtest_inherit_environment` is `True` (default: `False`), the test
   venv's full environment (including PATH with venv bin directory) is used as the
   base. Otherwise, only the explicitly set variables are passed.

### Integration Test Logs and Reports

Each integration test produces its own output files in `target/reports/integrationtests/`:

<table class="table table-striped">
  <tr>
    <th>File</th>
    <th>Contents</th>
  </tr>
  <tr>
    <td><code>target/reports/integrationtests/{test_name}</code></td>
    <td>Standard output from the test process</td>
  </tr>
  <tr>
    <td><code>target/reports/integrationtests/{test_name}.err</code></td>
    <td>Standard error from the test process</td>
  </tr>
</table>

Where `{test_name}` is the test filename without its `.py` extension.

On failure (non-zero exit code), or when `integrationtest_always_verbose` is `True`,
the content of both stdout and stderr files is printed to the console. On success,
output is silent unless verbose mode is enabled.

## Coverage in Detail

The `python.coverage` plugin measures code coverage by instrumenting test execution.
It does not re-run tests; instead, it wraps the test task so that coverage measurement
is active during the single test execution.

### How Coverage Works

The coverage task executes *after* the tasks it measures (e.g. `run_unit_tests`).
However, coverage instrumentation occurs during task execution through environment
override:

1. **During `prepare`**: The plugin checks which tasks are eligible for coverage
   measurement (tasks registered via `CoveredTask`, typically `run_unit_tests`).

2. **During `coverage` task execution**: For each covered task:
   - A `CoverageTool` is registered with the reactor
   - The Python environment for the covered task is overridden to inject a coverage
     shim script into the subprocess
   - The covered task (e.g. `run_unit_tests`) is re-executed with coverage active
   - Coverage data is collected from the subprocess via `coverage.combine()`

3. **After execution**: Coverage data from all covered tasks is aggregated, thresholds
   are checked, and reports are generated.

### Thresholds

Coverage enforces three independent threshold types:

<table class="table table-striped">
  <tr>
    <th>Property</th>
    <th>Default</th>
    <th>What It Measures</th>
  </tr>
  <tr>
    <td><code>coverage_threshold_warn</code></td>
    <td>70</td>
    <td>Percentage of statements executed</td>
  </tr>
  <tr>
    <td><code>coverage_branch_threshold_warn</code></td>
    <td>0 (disabled)</td>
    <td>Percentage of branches taken</td>
  </tr>
  <tr>
    <td><code>coverage_branch_partial_threshold_warn</code></td>
    <td>0 (disabled)</td>
    <td>Percentage of branches not partially executed</td>
  </tr>
</table>

When `coverage_break_build` is `True` (the default) and any threshold is violated,
the build fails with a `BuildFailedException`.

### Module Discovery for Coverage

Coverage measures modules found in `coverage_source_path` (default:
`$dir_source_main_python`). Modules listed in `coverage_exceptions` are excluded.
Modules with syntax errors are automatically excluded with a warning. Each module's
coverage is reported individually, and an aggregate is computed across all modules.

### Coverage Reports

Coverage generates reports in `target/reports/`:

<table class="table table-striped">
  <tr>
    <th>File</th>
    <th>Format</th>
    <th>Contents</th>
  </tr>
  <tr>
    <td><code>target/reports/{name}_coverage</code></td>
    <td>Text</td>
    <td>Human-readable coverage summary</td>
  </tr>
  <tr>
    <td><code>target/reports/{name}_coverage.json</code></td>
    <td>JSON</td>
    <td>Per-module coverage data with line/branch details</td>
  </tr>
  <tr>
    <td><code>target/reports/{name}_coverage.xml</code></td>
    <td>Cobertura XML</td>
    <td>For CI/CD integration (Jenkins, GitHub Actions, etc.)</td>
  </tr>
  <tr>
    <td><code>target/reports/{name}_coverage_html/</code></td>
    <td>HTML</td>
    <td>Interactive coverage report with source annotation</td>
  </tr>
</table>

Where `{name}` is derived from the project name (e.g. `My_Project_coverage.json`).

### Reading Coverage Output

In verbose mode (`pyb -v`), coverage reports per-module statistics:

<pre>
[INFO]  Overall my_project coverage is 85%
[INFO]  Overall my_project branch coverage is 72%
</pre>

In debug mode (`pyb -vX`), individual module reports are shown:

<pre>
[DEBUG] Module coverage report: {'module': 'mypackage.core', 'coverage': 92.0,
        'sum_lines': 50, 'lines_not_covered': [23, 45, 67, 89], ...}
</pre>

The HTML report in `target/reports/{name}_coverage_html/index.html` provides the
most detailed view, with source files annotated line-by-line showing which
statements and branches were covered.
