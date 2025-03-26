{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    c.customer_key,
    e.employee_key,
    s.store_key,
    pd.product_key,
    d.date_key,
    ol.quantity,
    (ol.quantity * p.unit_price) AS dollars_sold,
    p.unit_price
FROM {{ source('oliver_landing', 'product') }} p
INNER JOIN {{ source('oliver_landing', 'orderline') }} ol ON p.product_id = ol.product_id
INNER JOIN {{ source('oliver_landing', 'orders') }} o ON ol.order_id = o.order_id
INNER JOIN {{ ref('oliver_dim_product') }} pd ON pd.product_id = p.product_id
INNER JOIN {{ ref('oliver_dim_customer') }} c ON c.customer_id = o.customer_id
INNER JOIN {{ ref('oliver_dim_employee') }} e ON e.employee_id = o.employee_id
INNER JOIN {{ ref('oliver_dim_store') }} s ON s.store_id = o.store_id
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.date_day = o.order_date