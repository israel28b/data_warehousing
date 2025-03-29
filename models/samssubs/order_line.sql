{{ config(
    materialized = 'table',
    schema = 'dw_samsubs'
    )
}}

SELECT
    p.productid,
    s.storeid,
    c.customerid,
    d.date_key,
    e.employeeid,
    o.ordernumber,
    olf.orderlineqty,
    olf.orderlineprice

FROM {{ source('sams_landing', 'orderdetails') }} olf
INNER JOIN {{ ref('order_dim') }} o ON olf.ordernumber = o.ordernumber
INNER JOIN {{ source('sams_landing', '"ORDER"') }} original_or ON o.ordernumber = original_or.ordernumber
INNER JOIN {{ ref('employee_dim') }} e ON original_or.employeeid = e.employeeid
INNER JOIN {{ ref('customer_dim') }} c ON original_or.customerid = c.customerid
INNER JOIN {{ ref('product_dim') }} p ON olf.productid = p.productid
INNER JOIN {{ ref('store_dim') }} s ON e.storeid = s.storeid
INNER JOIN {{ ref('date_dim') }} d ON CAST(original_or.orderdate AS DATE) = d.date_day