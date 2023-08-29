-- from https://medium.com/@matheuscassolc/generating-custom-schema-names-on-dbt-based-on-environment-d2c7c8865e4e

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

        {{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}