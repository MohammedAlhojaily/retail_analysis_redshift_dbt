WITH customer_sales AS (
    SELECT 
    s.customer_id,
    SUM(s.quantity_sold) AS total_purchases,
    SUM(s.total_amount) AS total_spend
    FROM {{ ref('stg_retail__fact_sales')}} s
    GROUP BY s.customer_id
)


SELECT
    cs.customer_id,
    cs.total_purchases,
    cs.total_spend,
    CASE
        WHEN cs.total_purchases >= 50 THEN 'High_Value'
        WHEN cs.total_purchases BETWEEN 20 AND 49 THEN 'Medium_Value'
        WHEN cs.total_purchases < 20 THEN 'Low_Value'
        ELSE 'Unkown'
    END AS customer_segment
FROM customer_sales AS cs