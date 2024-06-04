{% macro void_to_md5(column_name, text) %}
    IFF({{column_name}} = '', md5({{text}}), {{column_name}})
{% endmacro%} 