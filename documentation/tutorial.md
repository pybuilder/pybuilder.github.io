---
layout: documentation
title: PyBuilder Tutorial
---

# Tutorial

This tutorial shows you how to use *PyBuilder* to build a
hello world program in python.

## Setting up the stage

*PyBuilder* is configured (or programmed) using a Python file that is named ```build.py```. To start, create an empty
directory ```helloworld``` as well as an empty file ```build.py```.
We recommend installing the PyBuilder in a virtual environment :

<pre>
<code>
virtualenv venv
source venv/bin/activate
pip install pybuilder
</code>
</pre>

Run ```pyb``` in this directory. This is what you should get:

<pre>
$ pyb
PYTHON BUILDER VERSION 0.4-SNAPSHOT
	Build started at 2011-08-14 18:46:02
------------------------------------------------------------

	[ERROR] No default task given.

------------------------------------------------------------
BUILD FAILED - No default task given.
	Build finished at 2011-08-14 18:46:02
	Build took 0 seconds (23 ms)
</pre>

## Adding Python Source Files

The next step is to add a Python module that contains our sources.
PyBuilder separates source files and expects them in different directories based on their meaning. The default
location for main python sources is

```src/main/python```

This is a convention borrowed from Apache Maven. You can alter this location but in this tutorial we stick to the
defaults. Create the directory and in there, create a file ```helloworld.py``` with the following sample code:

<pre><code>import sys

def helloworld (out):
    out.write("Hello world of Python\n")
</code></pre>

Now we need to tell pyb that we want to build a Python project. Fortunately, *PyBuilder* comes with a first class Python support, so telling it to build a Python project is dead easy. Modify your ```build.py``` as follows:

<pre><code>from pybuilder.core import use_plugin

use_plugin("python.core")

default_task = "publish"
</code></pre>

Now, if you run ```pyb``` again, here is what you get:

<pre>
$ pyb
PYTHON BUILDER VERSION 0.4-SNAPSHOT
	Build started at 2011-08-14 18:46:32
------------------------------------------------------------

	 [INFO] Building helloworld version 1.0-SNAPSHOT
	 [INFO] Executing build in /home/alex/workspaces/python/python-builder/samples/helloworld
	 [INFO] Going to execute task publish
	 [INFO] Building distribution in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT
	 [INFO] Compiling python source files in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT

------------------------------------------------------------
BUILD SUCCESSFUL
	Build Summary
	             Project: helloworld
	             Version: 1.0-SNAPSHOT
	      Base directory: /home/alex/workspaces/python/python-builder/samples/helloworld
	               Tasks: prepare compile_sources run_unit_tests package run_integration_tests verify publish
	Build finished at 2011-08-14 18:46:32
	Build took 0 seconds (10 ms)
</pre>

Ok, now everything seems to work, but that doesn't really help us. That's ok, because this was just the foundation we are going to extend.
Usually python project will want to deliver a runnable entry-point file - we'll see how to do that in the next section.

## Adding a runnable script

Adding scripts is as simple as writing them and putting them in the directory ```src/main/scripts```.
Note that this path is configurable, but let us stick with the conventions here.

We add a file ```src/main/scripts/hello-pybuilder``` with these contents :

<pre><code>#!/usr/bin/env python
import sys

sys.stdout.write('Hello from my script!\n')
</code></pre>


Now we can run the PyBuilder again :

<pre>
$ pyb
PYBUILDER Version 0.9.8
Build started at 2013-08-12 08:54:09
------------------------------------------------------------

[INFO]  Building helloworld version 1.0-SNAPSHOT
[INFO]  Executing build in /home/alex/workspaces/python/python-builder/samples/helloworld
[INFO]  Going to execute task publish
[INFO]  Building distribution in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT
[INFO]  Copying scripts to /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT

------------------------------------------------------------
BUILD SUCCESSFUL
------------------------------------------------------------
Build Summary
             Project: helloworld
             Version: 1.0-SNAPSHOT
      Base directory: /home/alex/workspaces/python/python-builder/samples/helloworld
        Environments:
               Tasks: prepare [0 ms] compile_sources [0 ms] run_unit_tests [0 ms] package [0 ms] run_integration_tests [0 ms] verify [0 ms] publish [0 ms]
Build finished at 2013-08-12 08:54:09
Build took 0 seconds (2 ms)
</pre>

As you can see, the script was picked up. We didn't need to fill a list with all the scripts,
putting the file in the right place was enough.

In the next section, we will start writing tests and integrate their execution into our build.

## Writing Unit Tests
As a next step, we want to add a unit test for our helloworld function.

We add a file ```src/unittest/python/helloworld_tests.py``` with the following content

<pre><code>from mockito import mock, verify
import unittest

from helloworld import helloworld

class HelloWorldTest (unittest.TestCase):
    def test_should_issue_hello_world_message (self):
        out = mock()

        helloworld(out)

        verify(out).write("Hello world of Python\n")
</code></pre>

Notice that there is no black magic in the test sources. It's just a simple
[unittest TestCase](http://docs.python.org/library/unittest.html#unittest.TestCase) using
[mockito](http://code.google.com/p/mockito-python/) to stub the call to ```sys.stdout.write```.

Concerning the filename it is important to notice that
 * The file must be located under ```src/unittest/python```. This is the default and may be altered but as with the main sources, we stick to the defaults.
 * The file must end with ```_tests.py```. This tells PyBuilder to consider this file when discovering test cases. Again, this can be altered, although we don't do this.

Now it's time to tell pyb to
 * execute the tests on each build
 * break the build (i.e. produce a failure) when a test fails.

Again, it's dead easy. Modify your ```build.py``` as follows:

<pre><code>from pybuilder.core import use_plugin

use_plugin("python.core")
use_plugin("python.unittest")

default_task = "publish"
</code></pre>

and run pyb again:

<pre>
$ pyb
PYTHON BUILDER VERSION 0.4-SNAPSHOT
	Build started at 2011-08-14 18:46:55
------------------------------------------------------------

	 [INFO] Building helloworld version 1.0-SNAPSHOT
	 [INFO] Executing build in /home/alex/workspaces/python/python-builder/samples/helloworld
	 [INFO] Going to execute task publish
	 [INFO] Executing unittests in /home/alex/workspaces/python/python-builder/samples/helloworld/src/unittest/python
	 [INFO] Executed 1 unittests
	 [INFO] All unittests passed.
	 [INFO] Building distribution in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT
	 [INFO] Compiling python source files in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT

------------------------------------------------------------
BUILD SUCCESSFUL
	Build Summary
	             Project: helloworld
	             Version: 1.0-SNAPSHOT
	      Base directory: /home/alex/workspaces/python/python-builder/samples/helloworld
	               Tasks: prepare compile_sources run_unit_tests package run_integration_tests verify publish
	Build finished at 2011-08-14 18:46:55
	Build took 0 seconds (14 ms)
</pre>

PyBuilder executed the test case. Now let's see what happens, when we force the test to fail.

Modify the test case to verify the call to ```sys.stdout``` for a string that is never written and run pyb again.

<pre>
$ pyb
PYTHON BUILDER VERSION 0.4-SNAPSHOT
	Build started at 2011-08-14 18:47:39
------------------------------------------------------------

	 [INFO] Building helloworld version 1.0-SNAPSHOT
	 [INFO] Executing build in /home/alex/workspaces/python/python-builder/samples/helloworld
	 [INFO] Going to execute task publish
	 [INFO] Executing unittests in /home/alex/workspaces/python/python-builder/samples/helloworld/src/unittest/python
	 [INFO] Executed 1 unittests
	[ERROR] Test failed: helloworld_tests.HelloWorldTest.test_should_issue_hello_world_message
	[ERROR] There were test errors.

------------------------------------------------------------
BUILD FAILED - There were test errors.
	Build finished at 2011-08-14 18:47:39
	Build took 0 seconds (29 ms)
</pre>

The build failed because there were test errors. How do we get to know which test failed and why?

PyBuilder writes reports along each build to capture all the output produced by all the tools it uses, including the unittest framework.

Have a look at the file ```target/reports/unittest```. It contains all the output written during the execution of the tests.

Again ```target``` as well as ```reports``` are configurable but we won't change them here.

## Measuring Test Coverage

When writing tests, it is important to know which parts if of the code are covered by automatic tests and which aren't.
For Python, there exists a bunch of tools to calculate the coverage. One of these tools that is integrated with
*PyBuilder* is [coverage](http://nedbatchelder.com/code/coverage/). Python-Coverage measures the line coverage
(as opposed to branch coverage).

To execute python coverage during the execution of unit tests and analyze the results, all you need to do is use a plugin.

Modify your ```build.py``` again:

<pre><code>from pybuilder.core import use_plugin

use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.coverage")

default_task = "publish"
</code></pre>

Now run pyb again:

<pre>
$ pyb
PYTHON BUILDER VERSION 0.4-SNAPSHOT
	Build started at 2011-08-14 18:43:27
------------------------------------------------------------

	 [INFO] Building helloworld version 1.0-SNAPSHOT
	 [INFO] Executing build in /home/alex/workspaces/python/python-builder/samples/helloworld
	 [INFO] Going to execute task publish
	 [INFO] Executing unittests in /home/alex/workspaces/python/python-builder/samples/helloworld/src/unittest/python
	 [INFO] Executed 1 unittests
	 [INFO] All unittests passed.
	 [INFO] Building distribution in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT
	 [INFO] Compiling python source files in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT
	 [INFO] Collecting coverage information
	 [INFO] Overall coverage is 100%

------------------------------------------------------------
BUILD SUCCESSFUL
	Build Summary
	             Project: helloworld
	             Version: 1.0-SNAPSHOT
	      Base directory: /home/alex/workspaces/python/python-builder/samples/helloworld
	               Tasks: prepare compile_sources run_unit_tests package run_integration_tests verify publish
	Build finished at 2011-08-14 18:43:28
	Build took 0 seconds (149 ms)
</pre>

Notice the last INFO message. As with the unittest, PyBuilder writes a detailed report to
```target/reports/coverage```. In case your coverage does not equal 100% you can find a list of source lines not
covered in this file.

The coverage plugin is also capable of breaking the build, if the coverage drops below a given threshold
(70% by default). This allows you to make sure, your code is always tested (to a given extend) before you ship it.

## Building a distribution

Before you make your code available to the public, you need to think about how users can install the software on
their computers. In the Python world, one standard way to do this is using
[distutils](http://docs.python.org/distutils/index.html) which is shipped with the standard Python distribution.

Using distutils basically means providing a ```setup.py``` that can be used to install the software.

*PyBuilder* comes with a plugin, that can generate the ```setup.py``` script so you don't need to write it your own.
*PyBuilder* automatically discovers your modules, packages and scripts and writes configuration for the setup script
accordingly.

Modify your ```build.py``` to use the plugin:

<pre><code>from pybuilder.core import use_plugin

use_plugin("python.core")
use_plugin("python.unittest")
use_plugin("python.coverage")
use_plugin("python.distutils")

default_task = "publish"
</code></pre>

Now run pyb again:

<pre>
$ pyb
PYTHON BUILDER VERSION 0.4-SNAPSHOT
	Build started at 2011-08-14 18:52:06
------------------------------------------------------------

	 [INFO] Building helloworld version 1.0-SNAPSHOT
	 [INFO] Executing build in /home/alex/workspaces/python/python-builder/samples/helloworld
	 [INFO] Going to execute task publish
	 [INFO] Executing unittests in /home/alex/workspaces/python/python-builder/samples/helloworld/src/unittest/python
	 [INFO] Executed 1 unittests
	 [INFO] All unittests passed.
	 [INFO] Building distribution in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT
	 [INFO] Compiling python source files in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT
	 [INFO] Writing setup.py as /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT/setup.py
	 [INFO] Collecting coverage information
	 [INFO] Overall coverage is 100%
	 [INFO] Building binary distribution in /home/alex/workspaces/python/python-builder/samples/helloworld/target/dist/helloworld-1.0-SNAPSHOT

------------------------------------------------------------
BUILD SUCCESSFUL
	Build Summary
	             Project: helloworld
	             Version: 1.0-SNAPSHOT
	      Base directory: /home/alex/workspaces/python/python-builder/samples/helloworld
	               Tasks: prepare compile_sources run_unit_tests package run_integration_tests verify publish
	Build finished at 2011-08-14 18:52:07
	Build took 0 seconds (311 ms)
</pre>

Let's have a look, what pyb generated in the target directory:

<pre>
target/
|-- dist
|   `-- helloworld-1.0-SNAPSHOT
|       |-- build
|       |   `-- bdist.linux-i686
|       |-- dist
|       |   |-- helloworld-1.0-SNAPSHOT.linux-i686.tar.gz
|       |   `-- helloworld-1.0-SNAPSHOT.tar.gz
|       |-- helloworld.py
|       |-- helloworld.pyc
|       |-- MANIFEST
|       `-- setup.py
`-- reports
    |-- coverage
    |-- coverage.json
    |-- distutils
    |   |-- bdist_dumb
    |   `-- sdist
    |-- unittest
    `-- unittest.json
</pre>

In the reports directory you can find some reports each containing detailed information on a tool or command, ```pyb```
invoked during the build. We already saw the unittest and coverage report.

A second directory is the dist directory which contains the distribution. The distribution directory contains the same
sources but in a Python-typical directory layout. You can also find the ```setup.py``` script there.

## Recap

In this tutorial we saw how PyBuilder can be used to "build" a typical Python project. Building in an interpreted
language is more a step of packaging the sources rather than compiling them. Additionally, we saw how PyBuilder
can help you ensuring that all the automatic tests are executed and that the test coverage matches you standards.

We saw a few plugins in action. *PyBuilder* provides more of them.
See the [documentation of plugins](/documentation/plugins.html) for available plugins.
