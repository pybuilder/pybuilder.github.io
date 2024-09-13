---
layout: documentation
title: Tutorial
---

# Tutorial

This tutorial shows you how to use *PyBuilder* to build a "Hello World!" program in Python.

## Setting Up the Stage

First you need to install *PyBuilder*. We recommend installing *PyBuilder* in a virtual environment :

```bash
virtualenv venv
source venv/bin/activate
pip install pybuilder
```

Now create an empty directory `helloworld`. If you now run `pyb` in this directory this is what you should get:

```
$ pyb
PyBuilder version 0.12.0
Build started at 2020-04-08 14:51:44
------------------------------------------------------------
------------------------------------------------------------
BUILD FAILED - Project directory does not contain descriptor file: ./build.py (pybuilder/reactor.py:474)
------------------------------------------------------------
Build finished at 2020-04-08 14:51:44
Build took 0 seconds (16 ms)
```

`pyb` is the command line interface of *PyBuilder*.

## Creating PyBuilder Project

The next step is to use the `pyb` command to create a basic project scaffold:

```
$ pyb --start-project
Project name (default: 'helloworld') : 
Source directory (default: 'src/main/python') : 
Docs directory (default: 'docs') : 
Unittest directory (default: 'src/unittest/python') : 
Scripts directory (default: 'src/main/scripts') : 
Use plugin python.flake8 (Y/n)? (default: 'y') : 
Use plugin python.coverage (Y/n)? (default: 'y') : 
Use plugin python.distutils (Y/n)? (default: 'y') : 

Created 'setup.py'.

Created 'pyproject.toml'.
```

PyBuilder has now created various files and directories and provided basic project configuration that you can now
customize:

```python
from pybuilder.core import use_plugin, init

use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.flake8")
use_plugin("python.coverage")
use_plugin("python.distutils")


name = "helloworld"
default_task = "publish"


@init
def set_properties(project):
    pass
```

Let's leave the defaults in place for now and continue.


## Adding Python Source Files

The next step is to add a Python module that contains our sources.
PyBuilder separates source files and expects them in different directories based on their meaning. 
The default location for main python sources is `src/main/python`.

This is a convention borrowed from Apache Maven. You can alter this location but in this tutorial we stick to the
defaults. Navigate to `src/main/python` and create a file `helloworld.py` with the following sample code:

```python
import sys

def helloworld(out):
    out.write("Hello world of Python\n")
```

We are now ready to build our project for the first time! If you run ```pyb``` again, here is what you get:

```
$ pyb
PyBuilder version 0.12.0
Build started at 2020-04-08 15:07:37
------------------------------------------------------------
[INFO]  Building helloworld version 1.0.dev0
[INFO]  Executing build in /home/user/projects/helloworld
[INFO]  Going to execute task publish
[INFO]  Processing plugin packages 'coverage~=5.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'flake8~=3.7' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'pypandoc~=1.4' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'setuptools>=38.6.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'twine>=1.15.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'unittest-xml-reporting~=2.5.2' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'wheel>=0.34.0' to be installed with {'upgrade': True}
[INFO]  Creating target 'build' VEnv in '/home/user/projects/helloworld/target/venv/build/cpython-3.8.2.final.0'
[INFO]  Creating target 'test' VEnv in '/home/user/projects/helloworld/target/venv/test/cpython-3.8.2.final.0'
[INFO]  Requested coverage for tasks: pybuilder.plugins.python.unittest_plugin:run_unit_tests
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
[WARN]  No unit tests executed.
[INFO]  All unit tests passed.
[INFO]  Building distribution in /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0
[INFO]  Copying scripts to /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0/scripts
[INFO]  Writing setup.py as /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0/setup.py
[INFO]  Collecting coverage information for 'pybuilder.plugins.python.unittest_plugin:run_unit_tests'
[WARN]  ut_coverage_branch_threshold_warn is 0 and branch coverage will not be checked
[WARN]  ut_coverage_branch_partial_threshold_warn is 0 and partial branch coverage will not be checked
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
Coverage.py warning: No data was collected. (no-data-collected)
[WARN]  No unit tests executed.
[INFO]  All unit tests passed.
[WARN]  Test coverage below 70% for helloworld:  0%
[WARN]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests coverage is below 70%:  0%
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests branch coverage is 100%
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests partial branch coverage is 100%
[WARN]  Test coverage below 70% for helloworld:  0%
[WARN]  Overall helloworld coverage is below 70%:  0%
[INFO]  Overall helloworld branch coverage is 100%
[INFO]  Overall helloworld partial branch coverage is 100%
------------------------------------------------------------
BUILD FAILED - Test coverage for at least one module is below 70% (pybuilder/plugins/python/coverage_plugin.py:154)
------------------------------------------------------------
Build finished at 2020-04-08 15:07:51
Build took 14 seconds (14226 ms)
```

PyBuilder seems to have done a lot of work but it appears that we still were not able to build our project. The reason,
as the error message clearly indicates, is that our code is not tested. Since the code isn't tested it has not 
been executed, and no coverage information is available for it. Coverage plugin, in turn, requires at least 70% code 
coverage by default for the project to build successfully.

Thus, we have two options:
1. Override the coverage plugin default setting and disable failure on missing code coverage threshold.
2. Add a test that ensures that the code is properly tested.

Being a diligent responsible developer that follows 21-st century best practices we will choose the **second option**
 and add an appropriate test.

## Writing Unit Tests
As a next step, we want to add a unit test for our helloworld function.

We add a file ```src/unittest/python/helloworld_tests.py``` with the following content

```python
from mockito import mock, verify
import unittest

from helloworld import helloworld

class HelloWorldTest(unittest.TestCase):
    def test_should_issue_hello_world_message(self):
        out = mock()

        helloworld(out)

        verify(out).write("Hello world of Python\n")
```

Notice that there is no black magic in the test sources. It's just a simple
[unittest TestCase](http://docs.python.org/library/unittest.html#unittest.TestCase) using
[mockito](https://pypi.org/project/mockito/) to stub the call to `sys.stdout.write`.

Concerning the filename it is important to notice that:
 * The file must be located under ```src/unittest/python```. This is the default and [may be altered](/documentation/plugins.html#python-unittest-properties) but as with the main sources, we stick to the defaults.
 * The file must end with ```_tests.py```. This tells *PyBuilder* to consider this file when discovering test cases. Again, [this can be altered](/documentation/plugins.html#python-unittest-properties), although we don't do this.

Since `mockito` is not part of the Python standard libraries, we have to tell *PyBuilder* that our build
process for our project from now on depends on mockito. Therefore we adapt `build.py`:

```python
from pybuilder.core import use_plugin, init

use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.flake8")
use_plugin("python.coverage")
use_plugin("python.distutils")


name = "helloworld"
default_task = "publish"


@init
def set_properties(project):
    project.build_depends_on("mockito")
```

The `init` decorator tells *PyBuilder* that function `initialize` is used to initialize the project.

Now let's execute our unittest.

```
$ pyb
PyBuilder version 0.12.0
Build started at 2020-04-10 08:27:37
------------------------------------------------------------
[INFO]  Building helloworld version 1.0.dev0
[INFO]  Executing build in /home/user/projects/helloworld
[INFO]  Going to execute task publish
[INFO]  Processing plugin packages 'coverage~=5.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'flake8~=3.7' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'pypandoc~=1.4' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'setuptools>=38.6.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'twine>=1.15.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'unittest-xml-reporting~=2.5.2' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'wheel>=0.34.0' to be installed with {'upgrade': True}
[INFO]  Creating target 'build' VEnv in '/home/user/projects/helloworld/target/venv/build/cpython-3.8.2.final.0'
[INFO]  Creating target 'test' VEnv in '/home/user/projects/helloworld/target/venv/test/cpython-3.8.2.final.0'
[INFO]  Requested coverage for tasks: pybuilder.plugins.python.unittest_plugin:run_unit_tests
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
[INFO]  Executed 1 unit tests
[INFO]  All unit tests passed.
[INFO]  Building distribution in /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0
[INFO]  Copying scripts to /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0/scripts
[INFO]  Writing setup.py as /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0/setup.py
[INFO]  Collecting coverage information for 'pybuilder.plugins.python.unittest_plugin:run_unit_tests'
[WARN]  ut_coverage_branch_threshold_warn is 0 and branch coverage will not be checked
[WARN]  ut_coverage_branch_partial_threshold_warn is 0 and partial branch coverage will not be checked
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
[INFO]  Executed 1 unit tests
[INFO]  All unit tests passed.
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests coverage is 100%
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests branch coverage is 100%
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests partial branch coverage is 100%
[INFO]  Overall helloworld coverage is 100%
[INFO]  Overall helloworld branch coverage is 100%
[INFO]  Overall helloworld partial branch coverage is 100%
[INFO]  Building binary distribution in /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0
[INFO]  Running Twine check for generated artifacts
------------------------------------------------------------
BUILD SUCCESSFUL
------------------------------------------------------------
Build Summary
             Project: helloworld
             Version: 1.0.dev0
      Base directory: /home/user/projects/helloworld
        Environments: 
               Tasks: prepare [6511 ms] compile_sources [0 ms] run_unit_tests [133 ms] package [1 ms] run_integration_tests [0 ms] verify [0 ms] coverage [229 ms] publish [603 ms]
Build finished at 2020-04-10 08:27:48
Build took 10 seconds (10945 ms)
```

*PyBuilder* executed the test case successfully. Now let's see what happens, when we force the test to fail.

Modify the test case to verify the call to ```sys.stdout``` for a string that is never written and run `pyb` again.

```
$ pyb
PyBuilder version 0.12.0
Build started at 2020-04-12 20:00:53
------------------------------------------------------------
[INFO]  Building helloworld version 1.0.dev0
[INFO]  Executing build in /home/user/projects/helloworld
[INFO]  Going to execute task publish
[INFO]  Processing plugin packages 'coverage~=5.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'flake8~=3.7' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'pypandoc~=1.4' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'setuptools>=38.6.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'twine>=1.15.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'unittest-xml-reporting~=2.5.2' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'wheel>=0.34.0' to be installed with {'upgrade': True}
[INFO]  Creating target 'build' VEnv in '/home/user/projects/helloworld/target/venv/build/cpython-3.8.2.final.0'
[INFO]  Creating target 'test' VEnv in '/home/user/projects/helloworld/target/venv/test/cpython-3.8.2.final.0'
[INFO]  Requested coverage for tasks: pybuilder.plugins.python.unittest_plugin:run_unit_tests
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
[INFO]  Executed 1 unit tests
[ERROR] Test failed: helloworld_tests.HelloWorldTest.test_should_issue_hello_world_message
------------------------------------------------------------
BUILD FAILED - There were 0 error(s) and 1 failure(s) in unit tests (pybuilder/plugins/python/unittest_plugin.py:111)
------------------------------------------------------------
Build finished at 2020-04-12 20:01:04
Build took 10 seconds (10924 ms)
```

The build failed because there were test errors. How do we get to know which test failed and why?

*PyBuilder* writes reports along each build to capture all the output produced by all the tools it uses, including the
unittest framework.

Have a look at the file ```target/reports/unittest```. It contains all the output written during the execution of the
tests.

Again ```target``` as well as ```reports``` are configurable but we won't change them here.

The command line interface `pyb` also provides a verbose option `-v`.

```
$ pyb -v
PyBuilder version 0.12.0
Build started at 2020-04-12 20:03:25
------------------------------------------------------------
[INFO]  Building helloworld version 1.0.dev0
[INFO]  Executing build in /home/user/projects/helloworld
[INFO]  Going to execute task publish
[INFO]  Processing plugin packages 'coverage~=5.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'flake8~=3.7' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'pypandoc~=1.4' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'setuptools>=38.6.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'twine>=1.15.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'unittest-xml-reporting~=2.5.2' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'wheel>=0.34.0' to be installed with {'upgrade': True}
[INFO]  Creating target 'build' VEnv in '/home/user/projects/helloworld/target/venv/build/cpython-3.8.2.final.0'
[INFO]  Creating target 'test' VEnv in '/home/user/projects/helloworld/target/venv/test/cpython-3.8.2.final.0'
[INFO]  Requested coverage for tasks: pybuilder.plugins.python.unittest_plugin:run_unit_tests
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
[INFO]  Executed 1 unit tests
[ERROR] Test failed: helloworld_tests.HelloWorldTest.test_should_issue_hello_world_message
Traceback (most recent call last):
  File "/home/user/.pyenv/versions/3.8.2/lib/python3.8/unittest/case.py", line 60, in testPartExecutor
    yield
  File "/home/user/.pyenv/versions/3.8.2/lib/python3.8/unittest/case.py", line 676, in run
    self._callTestMethod(testMethod)
  File "/home/user/.pyenv/versions/3.8.2/lib/python3.8/unittest/case.py", line 633, in _callTestMethod
    method()
  File "/home/user/projects/helloworld/src/unittest/python/helloworld_tests.py", line 12, in test_should_issue_hello_world_message
    verify(out).write("Goodbye world of Python\n")
  File "/home/user/projects/helloworld/target/venv/build/cpython-3.8.2.final.0/lib/python3.8/site-packages/mockito/invocation.py", line 242, in __call__
    self.verification.verify(self, len(matched_invocations))
  File "/home/user/projects/helloworld/target/venv/build/cpython-3.8.2.final.0/lib/python3.8/site-packages/mockito/verification.py", line 93, in verify
    raise VerificationError(
mockito.verification.VerificationError: 
Wanted but not invoked:

    write('Goodbye world of Python\n')

Instead got:

    write('Hello world of Python\n')



------------------------------------------------------------
BUILD FAILED - There were 0 error(s) and 1 failure(s) in unit tests (pybuilder/plugins/python/unittest_plugin.py:111)
------------------------------------------------------------
Build finished at 2020-04-12 20:03:35
Build took 9 seconds (9454 ms)
```

## Adding a runnable script

Adding scripts is as simple as writing them and putting them in the directory ```src/main/scripts```.
Note that this path is configurable, but let's stick with the conventions here.

We add a file ```src/main/scripts/hello-pybuilder``` with these contents :

```python
#!/usr/bin/env python
import sys

sys.stdout.write('Hello from my script!\n')
```

Now we can run the PyBuilder again :

```
$ pyb
PyBuilder version 0.12.0
Build started at 2020-04-12 20:08:50
------------------------------------------------------------
[INFO]  Building helloworld version 1.0.dev0
[INFO]  Executing build in /home/user/projects/helloworld
[INFO]  Going to execute task publish
[INFO]  Processing plugin packages 'coverage~=5.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'flake8~=3.7' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'pypandoc~=1.4' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'setuptools>=38.6.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'twine>=1.15.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'unittest-xml-reporting~=2.5.2' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'wheel>=0.34.0' to be installed with {'upgrade': True}
[INFO]  Creating target 'build' VEnv in '/home/user/projects/helloworld/target/venv/build/cpython-3.8.2.final.0'
[INFO]  Creating target 'test' VEnv in '/home/user/projects/helloworld/target/venv/test/cpython-3.8.2.final.0'
[INFO]  Requested coverage for tasks: pybuilder.plugins.python.unittest_plugin:run_unit_tests
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
[INFO]  Executed 1 unit tests
[INFO]  All unit tests passed.
[INFO]  Building distribution in /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0
[INFO]  Copying scripts to /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0/scripts
[INFO]  Writing setup.py as /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0/setup.py
[INFO]  Collecting coverage information for 'pybuilder.plugins.python.unittest_plugin:run_unit_tests'
[WARN]  ut_coverage_branch_threshold_warn is 0 and branch coverage will not be checked
[WARN]  ut_coverage_branch_partial_threshold_warn is 0 and partial branch coverage will not be checked
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
[INFO]  Executed 1 unit tests
[INFO]  All unit tests passed.
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests coverage is 100%
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests branch coverage is 100%
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests partial branch coverage is 100%
[INFO]  Overall helloworld coverage is 100%
[INFO]  Overall helloworld branch coverage is 100%
[INFO]  Overall helloworld partial branch coverage is 100%
[INFO]  Building binary distribution in /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0
[INFO]  Running Twine check for generated artifacts
------------------------------------------------------------
BUILD SUCCESSFUL
------------------------------------------------------------
Build Summary
             Project: helloworld
             Version: 1.0.dev0
      Base directory: /home/user/projects/helloworld
        Environments: 
               Tasks: prepare [6088 ms] compile_sources [0 ms] run_unit_tests [137 ms] package [1 ms] run_integration_tests [0 ms] verify [0 ms] coverage [215 ms] publish [613 ms]
Build finished at 2020-04-12 20:09:01
Build took 10 seconds (10385 ms)
```

As you can see, the script was picked up. We didn't need to fill a list with all the scripts,
putting the file in the right place was enough.

## Measuring Test Coverage

When writing tests, it is important to know which parts if of the code are covered by automatic tests and which aren't.
For Python, there exists a bunch of tools to calculate the coverage. One of these tools that is integrated with
*PyBuilder* is [coverage](https://coverage.readthedocs.io/en/latest/). Python-Coverage measures the line coverage
(as opposed to branch coverage).

To execute python coverage during the execution of unit tests and analyze the results, all you need to do is use 
a plugin `python.coverage`. Luckily, our default project scaffolding already enabled it for us.

The `python.coverage` plugin uses [Ned Batchelder's](https://twitter.com/nedbat) `coverage` to determine the test coverage.

```
$ pyb -v
PyBuilder version 0.12.0
Build started at 2020-04-12 22:45:13
------------------------------------------------------------
[INFO]  Building helloworld version 1.0.dev0
[INFO]  Executing build in /home/user/projects/helloworld
[INFO]  Going to execute task publish
[INFO]  Processing plugin packages 'coverage~=5.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'flake8~=3.7' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'pypandoc~=1.4' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'setuptools>=38.6.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'twine>=1.15.0' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'unittest-xml-reporting~=2.5.2' to be installed with {'upgrade': True}
[INFO]  Processing plugin packages 'wheel>=0.34.0' to be installed with {'upgrade': True}
[INFO]  Creating target 'build' VEnv in '/home/user/projects/helloworld/target/venv/build/cpython-3.8.2.final.0'
[INFO]  Creating target 'test' VEnv in '/home/user/projects/helloworld/target/venv/test/cpython-3.8.2.final.0'
[INFO]  Requested coverage for tasks: pybuilder.plugins.python.unittest_plugin:run_unit_tests
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
[INFO]  Executed 1 unit tests
[INFO]  All unit tests passed.
[INFO]  Building distribution in /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0
[INFO]  Copying scripts to /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0/scripts
[INFO]  Writing setup.py as /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0/setup.py
[INFO]  Collecting coverage information for 'pybuilder.plugins.python.unittest_plugin:run_unit_tests'
[WARN]  ut_coverage_branch_threshold_warn is 0 and branch coverage will not be checked
[WARN]  ut_coverage_branch_partial_threshold_warn is 0 and partial branch coverage will not be checked
[INFO]  Running unit tests
[INFO]  Executing unit tests from Python modules in /home/user/projects/helloworld/src/unittest/python
[INFO]  Executed 1 unit tests
[INFO]  All unit tests passed.
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests coverage is 100%
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests branch coverage is 100%
[INFO]  Overall pybuilder.plugins.python.unittest_plugin.run_unit_tests partial branch coverage is 100%
[INFO]  Overall helloworld coverage is 100%
[INFO]  Overall helloworld branch coverage is 100%
[INFO]  Overall helloworld partial branch coverage is 100%
[INFO]  Building binary distribution in /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0
[INFO]  Running Twine check for generated artifacts
------------------------------------------------------------
BUILD SUCCESSFUL
------------------------------------------------------------
Build Summary
             Project: helloworld
             Version: 1.0.dev0
      Base directory: /home/user/projects/helloworld
        Environments: 
               Tasks: prepare [6083 ms] compile_sources [0 ms] run_unit_tests [144 ms] package [1 ms] run_integration_tests [0 ms] verify [0 ms] coverage [208 ms] publish [745 ms]
Build finished at 2020-04-12 22:45:24
Build took 11 seconds (11305 ms)
```

Notice the last few `INFO` messages. As with the unittest, PyBuilder writes a detailed report to
`target/reports` in text, JSON, XML and interactive HTML report formats. In case your coverage does not equal 100% 
you can find a list of source lines not covered in this file.

The coverage plugin is also capable of breaking the build, if the coverage drops below a given threshold
(70% by default), as you've experienced when we first created the project. This allows you to make sure, 
your code is always tested (to a given extend) before you ship it.

## Building a Distribution

Before you make your code available to the public, you need to think about how users can install the software on
their computers. In the Python world, one standard way to do this is using
[distutils](http://docs.python.org/distutils/index.html) which is shipped with the standard Python distribution.

Using distutils basically means providing a `setup.py` or `pyproject.toml` that can be used to install the software.

*PyBuilder* comes with a plugin, that can generate the `setup.py` script so you don't need to write it your own.
*PyBuilder* automatically discovers your modules, packages and scripts and writes configuration for the setup script
accordingly.

The initial scaffolding already enabled `python.distutils` plugin for us and we were building the 
binary distributions all along in the previous successful runs:

```
$ pyb -v
PyBuilder version 0.12.0
Build started at 2020-04-12 22:45:13
------------------------------------------------------------
[INFO]  Building helloworld version 1.0.dev0
[INFO]  Executing build in /home/user/projects/helloworld
...
[INFO]  Building binary distribution in /home/user/projects/helloworld/target/dist/helloworld-1.0.dev0
[INFO]  Running Twine check for generated artifacts
------------------------------------------------------------
BUILD SUCCESSFUL
------------------------------------------------------------
Build Summary
             Project: helloworld
             Version: 1.0.dev0
      Base directory: /home/user/projects/helloworld
        Environments: 
               Tasks: prepare [6083 ms] compile_sources [0 ms] run_unit_tests [144 ms] package [1 ms] run_integration_tests [0 ms] verify [0 ms] coverage [208 ms] publish [745 ms]
Build finished at 2020-04-12 22:45:24
Build took 11 seconds (11305 ms)
```

Let's have a look, what pyb generated in the target directory:

```
$ tree target/dist
target/dist
└── helloworld-1.0.dev0
    ├── build
    │   ├── bdist.linux-x86_64
    │   ├── lib
    │   │   └── helloworld.py
    │   └── scripts-3.8
    │       └── hello-pybuilder
    ├── dist
    │   ├── helloworld-1.0.dev0-py3-none-any.whl
    │   └── helloworld-1.0.dev0.tar.gz
    ├── helloworld.egg-info
    │   ├── dependency_links.txt
    │   ├── namespace_packages.txt
    │   ├── PKG-INFO
    │   ├── SOURCES.txt
    │   ├── top_level.txt
    │   └── zip-safe
    ├── helloworld.py
    ├── __pycache__
    ├── scripts
    │   └── hello-pybuilder
    └── setup.py

9 directories, 13 files
```

The `target/dist` directory contains the generated `setuptools`/`distutils` distribution. 
The distribution directory contains the same sources but in a Python-typical directory layout. 
You can also find the `setup.py` script there, as well as generated binary wheel and sdist gzip'ed tar in 
`target/dist/dist`.

## Recap

In this tutorial we saw how PyBuilder can be used to "build" a typical Python project. Building in an interpreted
language is more a step of packaging the sources rather than compiling them. Additionally, we saw how PyBuilder
can help you ensuring that all the automatic tests are executed and that the test coverage matches you standards.

We saw a few plugins in action. *PyBuilder* provides more of them.
See the [documentation of plugins](/documentation/plugins.html) for available plugins.
