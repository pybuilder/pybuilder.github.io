---
layout: documentation
title: Installing PyBuilder
---

# Installation

## PIP

Prior to version 0.12.0 the recommendation was to install *PyBuilder* into a 
[virtual environment](http://pypi.python.org/pypi/virtualenv) using [pip](http://pypi.python.org/pypi/pip):

`pip install pybuilder`

While this is still a preferred way, beginning with version 0.12.0 *PyBuilder* no longer alters the environment
it is installed in by virtue of managing its own `venvs` and therefore can be safely installed into the 
system-wide Python via `sudo pip install pybuilder`.

## Installing From Source

Starting with version 0.12.0 PyBuilder supports PEP-517 (`pyproject.toml`) and can be installed with PIP from source: 

`pip install git+git://github.com/pybuilder/pybuilder`

## Building From Source

Please get the most recent version of *PyBuilder* first:

```bash
git clone https://github.com/pybuilder/pybuilder
cd pybuilder
```

To build simply run

```bash
./build.py
```

Congratulations, you just built PyBuilder from source!
