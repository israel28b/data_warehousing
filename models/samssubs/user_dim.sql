{{ config(
    materialized = 'table',
    schema = 'dw_samsubs'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['USER_EMAIL']) }} AS User_sk,
    USER_EMAIL,
    FALSE AS ReturningUser 
FROM {{ source('sams_landing', 'web_traffic_events') }}