{{  config(
    materialized = 'table',
    schema = 'dw_samsubs'
)
}}

select
{{ dbt_utils.generate_surrogate_key(['ADDRESS', 'STOREID']) }} AS store_sk,
ZIP,
CITY,
STATE,
ADDRESS,
STOREID
FROM {{ source('sams_landing', 'store')}}