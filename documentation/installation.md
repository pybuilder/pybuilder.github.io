---
layout: documentation
title: Installing PyBuilder
---

# Installation

## Pip and Easy Install

We recommend installing *PyBuilder* into a [virtual environment](http://pypi.python.org/pypi/virtualenv) using
[pip](http://pypi.python.org/pypi/pip):

<pre><code>pip install pybuilder</code></pre>

<div class="alert alert-warning">
At first it might seem tempting to install PyBuilder system-wide with <code>sudo pip install pybuilder</code>,
but if you work with <em>virtualenvs</em> then PyBuilder will see your system python (due to being installed there)
instead of the virtualenv python.
</div>

## Building from source

Please get the most recent version of *PyBuilder* first :

<pre>
git clone https://github.com/pybuilder/pybuilder
cd pybuilder
</pre>

Now to the bootstrapping part : install the dependencies and build PyBuilder... using PyBuilder!

<pre>
./build.py install_dependencies
./build.py
</pre>

Congratulations, you just built a binary distribution!

You can now head to ```target/dist/pybuilder-$VERSION```
and use the [distutils](http://docs.python.org/distutils/index.html) ```setup.py``` installation script.
Just type
<pre><code>python setup.py install</code></pre>
