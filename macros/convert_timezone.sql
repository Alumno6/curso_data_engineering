{% macro convert_timezone(column_name) %}
    convert_timezone('UTC', TO_TIMESTAMP_TZ({{column_name}}))
{% endmacro %}