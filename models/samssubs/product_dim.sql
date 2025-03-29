{{  config(
    materialized = 'table',
    schema = 'dw_samsubs'
)
}}

select
{{ dbt_utils.generate_surrogate_key(['p.PRODUCTID', 'p.PRODUCTNAME']) }} AS product_sk,
p.PRODUCTID,
p.PRODUCTCOST,
p.PRODUCTNAME,
p.PRODUCTTYPE,
p.PRODUCTCALORIES,
s.LENGTH,
s.BREADTYPE
FROM {{ source('sams_landing', 'product')}} p
LEFT JOIN {{ source ('sams_landing', 'sandwich')}} s
    ON p.PRODUCTID = s.PRODUCTID