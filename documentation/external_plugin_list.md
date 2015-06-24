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

* [pybuilder_header_plugin](https://github.com/aelgru/pybuilder_header_plugin) - ensure all your source files have the expected file header
* [pybuilder_release_plugin](https://github.com/aelgru/pybuilder_release_plugin) - release a new version of your project to PyPI
* [pybuilder_smart_copy_resources](https://github.com/margru/pybuilder-smart-copy-resources) - copy additional files into various destinations

## Pybuilder external plugin demo

### Activation
{% highlight python %}
use_plugin("pypi:pybuilder_external_plugin_demo")
{% endhighlight %}

### Provided tasks
`say_hello`: says hello

