---
layout: documentation
title: Installing PyBuilder
---

# Installation

## PIP

*PyBuilder* can be installed using [pip](https://pypi.python.org/pypi/pip):

`pip install pybuilder`

*PyBuilder* manages its own virtual environments and does not alter the environment
it is installed in. It can be safely installed into a
[virtual environment](https://docs.python.org/3/library/venv.html) or system-wide.

## Installing From Source

PyBuilder supports PEP-517 (`pyproject.toml`) and can be installed with pip from source:

`pip install git+https://github.com/pybuilder/pybuilder`

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
