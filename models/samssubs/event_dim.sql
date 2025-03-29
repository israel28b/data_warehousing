{{ config(
    materialized = 'table',
    schema = 'dw_samsubs'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['EVENT_NAME ']) }} AS event_sk,
    EVENT_NAME 
FROM {{ source('sams_landing', 'web_traffic_events') }}