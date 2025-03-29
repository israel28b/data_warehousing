{{  config(
    materialized = 'table',
    schema = 'dw_samsubs'
)
}}

select
{{ dbt_utils.generate_surrogate_key(['ordernumber', 'orderdate']) }} AS order_sk,
ORDERDATE,
ORDERMETHOD,
ORDERNUMBER 
FROM {{ source('sams_landing', '"ORDER"')}}