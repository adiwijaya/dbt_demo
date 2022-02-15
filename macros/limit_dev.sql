{% macro limit_dev() %}

{% if target.name == 'dev' %}
LIMIT 1000000
{% endif %}

{% endmacro %}