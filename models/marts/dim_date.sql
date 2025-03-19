{% set start_date = var('start_date') %}
{% set end_date = var('end_date') %}

{{
    config(
        materialized = "table"
    )
}}

{{ dbt_date.get_date_dimension(start_date, end_date) }}
