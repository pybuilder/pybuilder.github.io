---
layout: documentation
title: Plugins
---

# Plugins By Category
{% assign categories = site.data.plugin-docs | group_by_ext: "category" | sort_natural: "name" %}
{% for category in categories %}
## {{ category.name }}
{% for item in category.items %}
### [{{ item.plugin }} - {{ item.heading }}]({{ "/articles/plugins/" | append: item.plugin | rel_canonical_url }})
{{ item.summary }}
{% endfor %}
{% endfor %}