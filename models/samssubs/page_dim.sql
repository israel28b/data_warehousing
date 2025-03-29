{{ config(
    materialized = 'table',
    schema = 'dw_samsubs'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['page_url']) }} AS page_sk,
    page_url 
FROM {{ source('sams_landing', 'web_traffic_events') }}