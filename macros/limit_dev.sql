{% macro limit_dev() %}

{% if target.name == 'dev' %}
LIMIT 1000
{% endif %}

{% endmacro %}