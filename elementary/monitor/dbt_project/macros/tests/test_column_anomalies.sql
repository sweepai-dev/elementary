-- Import the UNQUOTE_IDENTIFIER function from dbt
{% from dbt import UNQUOTE_IDENTIFIER %}

-- The existing check that validates if a column exists in the table needs to be modified.
-- Specifically, unquote the column names before testing. This can be done by using the UNQUOTE_IDENTIFIER function provided by dbt.
-- Replace the existing check with UNQUOTE_IDENTIFIER(column_name) IN (SELECT column_name FROM columns).

{% macro test_column_anomalies(model, column_name) %}
  {% set column_name = UNQUOTE_IDENTIFIER(column_name) %}
  {% set columns = adapter.get_columns_in_relation(model) %}

  {% if column_name not in columns %}
    {{ exceptions.raise_compiler_error("Column '" ~ column_name ~ "' does not exist in model '" ~ model ~ "'.") }}
  {% endif %}

  -- Rest of the test code remains the same
{% endmacro %}