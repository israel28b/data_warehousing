{{ config(
    materialized = 'table',
    schema = 'dw_samsubs'
    )
}}

SELECT
    d.date_key,
    e.event_key,
    p.page_key,
    ts.traffic_key,
    COUNT(wte.*) AS interactioncount,
    u.USER_key

FROM {{ source('sams_landing', 'web_traffic_events') }} wte
INNER JOIN {{ ref('trafficsource_dim') }} ts ON wte.traffic_source=ts.traffic_source
INNER JOIN {{ ref('page_dim') }} p ON wte.page_url = p.page_url
INNER JOIN {{ ref('event_dim') }} e ON wte.event_name = e.event_name
INNER JOIN {{ ref('date_dim') }} d ON CAST(wte.event_timestamp AS DATE) = d.date_day
INNER JOIN {{ ref('user_dim') }} u ON wte.user_email=u.user_email

GROUP BY all

