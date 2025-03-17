SELECT 
    fc.claim_id,
    fc.policy_id,
    dp.policy_type,
    dc.customer_name,
    da.agent_name,
    fc.claim_amount,
    dd.claim_date
FROM {{ ref('fact_claim') }} fc
LEFT JOIN {{ ref('dim_policy') }} dp ON fc.policy_id = dp.policy_id
LEFT JOIN {{ ref('dim_customer') }} dc ON fc.customer_id = dc.customer_id
LEFT JOIN {{ ref('dim_agent') }} da ON dp.agent_id = da.agent_id
LEFT JOIN {{ ref('dim_date') }} dd ON fc.claim_date_id = dd.date_id;
