---
layout: documentation
title: Publishing your plugins to PyPI
---

# {{ page.title }}

## Developing your plugin
Please refer to [the plugin development documentation](/documentation/writing-plugins.html) for this step.

As for the layout, you should create a python package (folder with an `__init__.py` inside). Your package should expose everything that PyBuilder requires from a plugin (tasks, initializers, ...) in the package top-level.
To do this, you can either declare everything in `__init__.py`, or you can simply import those things.
A plugin sample is available [here](https://github.com/pybuilder/pybuilder/tree/master/samples/pybuilder_external_plugin_demo).

### Plugin naming
The easiest solution is to use a lowercase name without special characters.
If you want the plugin name to be readable, though, you might be tempted to use underscores (the author of this document recommends namespacing with `pybuilder_*`).

This would lead to a package structure like so:

<pre>
<code>
pybuilder_myplugin
---src/
------main/
---------python/
------------pybuilder_myplugin/
---------------__init__.py
</code>
</pre>

In that case, you will have to [set the name of your package (for PyPI) to `pybuilder-*`](https://github.com/pybuilder/pybuilder/blob/master/samples/pybuilder_external_plugin_demo/build.py#L11) (dashes instead of underscores).

Why this?

  * Using a project name with dashes will make your plugin installable with `pip`. Pip replaces underscores with dashes, so if you use underscores in the project name it will not work.
  * Having a package name with underscores is required, because using dashes in an package name is a syntax error at import.

## Using your plugin
Once your plugin is published to PyPI, you can use it by requiring the plugin prefixed with `pypi:`.

As an example, the [sample external plugin](https://github.com/pybuilder/pybuilder/blob/master/samples/pybuilder_external_plugin_demo) can be activated by adding 

```
use_plugin("pypi:pybuilder_external_plugin_demo")
```

Note that you need to require the plugin name with underscores (as it is the name that will be imported).

## Plugin list
If possible and desired, add your plugin to the [external plugin list](https://github.com/pybuilder/pybuilder.github.io/tree/source/documentation/external-plugin-list.md).

## TLDR
  * Prefix your package with `pybuilder_`
  * Package itself is named `pybuilder_*`
  * Package has all plugin related things (tasks ...) at top-level
  * PyPI name of package is `pybuilder-*` (with dashes instead of underscores)
  * Plugin is used by prefixing the package name (underscores!) with `pypi:`
  * Add your plugin to the [external plugin list](https://github.com/pybuilder/pybuilder.github.io/tree/source/documentation/external-plugin-list.md)
