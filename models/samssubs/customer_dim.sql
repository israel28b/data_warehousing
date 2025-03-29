{{ config(
    materialized = 'table',
    schema = 'dw_samsubs'
    )
}}


select
{{ dbt_utils.generate_surrogate_key(['customerid', 'CUSTOMERBDAY']) }} AS customer_sk,
CUSTOMERID,
CUSTOMERBDAY,
CUSTOMERFNAME,
CUSTOMERLNAME,
CUSTOMERPHONE
FROM {{ source('sams_landing', 'customer') }}