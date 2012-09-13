---
layout: documentation
title: Installing Pybuilder
---

# Installation

## Pip and Easy Install

If you have [pip](http://pypi.python.org/pypi/pip) or [easy_install](http://packages.python.org/distribute/easy_install.html)
available on your machine, you may simply install *pybuilder* using a command such as:

<pre>$ sudo pip pybuilder</pre>

Of course you can install pybuilder into a [virtual environment](http://pypi.python.org/pypi/virtualenv).

## Manual Installation

Please download the most recent version of *pybuilder* from the
[downloads page](https://github.com/pybuilder/pybuilder/downloads).

The *pybuilder* distribution ships with a standard [distutils](http://docs.python.org/distutils/index.html) ```setup.py```
script which can be used to perform a local installation. Just type

<pre>$ python setup.py install</pre>

Note that you need to have administrative permissions to perform the install to Python's standard directories
(Unix/Linux users may prefix the command with ```sudo``` if they have the appropriate permissions.
