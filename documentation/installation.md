---
layout: documentation
title: Installing Pybuilder
---

# Installation

## Pip and Easy Install

We recommend installing *pybuilder* into a [virtual environment](http://pypi.python.org/pypi/virtualenv) using
[pip](http://pypi.python.org/pypi/pip) or [easy_install](http://packages.python.org/distribute/easy_install.html)
using a command such as:

<pre>$ pip install pybuilder</pre>

## Building from source

Please checkout the most recent version of *pybuilder* first :

<pre>
git clone https://github.com/pybuilder/pybuilder
cd pybuilder
</pre>

Now to the bootstrapping part : install the dependencies and build pybuilder... using pybuilder!

<pre>
./bootstrap install_dependencies
./bootstrap
</pre>

Congratulations, you just built a binary distribution!

You can now head to ```target/dist/pybuilder-$VERSION```
and use the [distutils](http://docs.python.org/distutils/index.html) ```setup.py``` installation script.
Just type
<pre>$ python setup.py install</pre>

Note that you need to have administrative permissions to perform the install to Python's standard directories
(Unix/Linux users may prefix the command with ```sudo``` if they have the appropriate permissions.
