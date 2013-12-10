---
layout: documentation
title: Installing Pybuilder
---

# Installation

## Pip and Easy Install

We recommend installing *PyBuilder* into a [virtual environment](http://pypi.python.org/pypi/virtualenv) using
[pip](http://pypi.python.org/pypi/pip) or [easy_install](http://packages.python.org/distribute/easy_install.html)
using a command such as:

<pre>$ pip install pybuilder</pre>

<div class="alert alert-warning">
At first it might be tempting to install PyBuilder system-wide with <code>sudo pip install pybuilder</code>,
but if you work with <em>virtualenvs</em> then PyBuilder will see your system python (due to being installed there)
instead of the virtualenv python.
</div>

## Building from source

Please checkout the most recent version of *PyBuilder* first :

<pre>
git clone https://github.com/pybuilder/pybuilder
cd pybuilder
</pre>

Now to the bootstrapping part : install the dependencies and build PyBuilder... using PyBuilder!

<pre>
./bootstrap install_dependencies
./bootstrap
</pre>

Congratulations, you just built a binary distribution!

You can now head to ```target/dist/pybuilder-$VERSION```
and use the [distutils](http://docs.python.org/distutils/index.html) ```setup.py``` installation script.
Just type
<pre>$ python setup.py install</pre>
