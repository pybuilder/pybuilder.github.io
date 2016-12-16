---
layout: documentation
title: External plugin list
---

# {{ page.title }}

## Plugins Available on PyPI

In general you can activate a plugin by using `use_plugin` from `pybuilder.core`:

{% highlight python %}
from pybuilder.core import use_plugin

use_plugin("pypi:<< plugin name goes here >>")
{% endhighlight %}
Please read the documentation of each plugin to get more information on plugin tasks and configuration properties.

* [pybuilder_header_plugin](https://github.com/cowst/pybuilder_header_plugin) - ensure all your source files have the expected file header
* [pybuilder_smart_copy_resources](https://github.com/margru/pybuilder-smart-copy-resources) - copy additional files into various destinations
* [pybuilder_pytest](https://github.com/AlexeySanko/pybuilder_pytest) - use pytest Python module for running unittests

## Pybuilder external plugin demo

### Activation
{% highlight python %}
use_plugin("pypi:pybuilder_external_plugin_demo")
{% endhighlight %}
