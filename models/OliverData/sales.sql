{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    d.date_day,
    p.product_name,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    s.store_name,
    sf.quantity,
    sf.dollars_sold
FROM {{ ref('fact_sales') }} sf

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON sf.customer_key = c.customer_key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON sf.employee_key = e.employee_key

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON sf.product_key = p.product_key

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON sf.store_key = s.store_key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON sf.date_key = d.date_key