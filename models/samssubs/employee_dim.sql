
{{ config(
    materialized = 'table',
    schema = 'dw_samsubs'
    )
}}

select
{{ dbt_utils.generate_surrogate_key(['employeeid', 'STOREID']) }} AS employee_sk,
EMPLOYEEID,
EMPLOYEEBDAY,
EMPLOYEEFNAME,
EMPLOYEELNAME,
STOREID
FROM {{ source('sams_landing', 'employee') }}