{{ config(
    materialized = 'table',
    schema = 'dw_samsubs'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['traffic_source']) }} AS traffic_source_sk,
    traffic_source 
FROM {{ source('sams_landing', 'web_traffic_events') }}