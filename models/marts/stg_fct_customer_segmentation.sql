with recency AS
(
    SELECT 
        customer_id,
        DATE_DIFF('{{ var("end_date") }}', MAX(sk_transaction_date), day) AS recency
    FROM {{ ref("stg_online_sales")}}
    GROUP BY customer_id
),
frequency AS 
(
    SELECT
        customer_id,
        COUNT(transaction_id) AS frequency
    FROM {{ ref("stg_online_sales")}}
    GROUP BY customer_id
),
monetary AS (
    SELECT 
        customer_id, 
        ROUND(SUM(quantity * average_price + delivery_charges), 2) AS monetary
    FROM {{ ref("stg_online_sales")}}
    GROUP BY customer_id
)

SELECT
    r.customer_id,
    r.recency,
    f.frequency,
    m.monetary,
    CASE
        WHEN r.recency <= 30 AND f.frequency >= 5 AND m.monetary >= 500 THEN 'Premium'
        WHEN r.recency <= 60 AND f.frequency >= 3 AND m.monetary >= 300 THEN 'Gold'
        WHEN r.recency <= 90 AND f.frequency >= 2 AND m.monetary >= 100 THEN 'Silver'
        ELSE 'Standard'
    END AS segment
FROM recency AS r
JOIN frequency AS f ON r.customer_id = f.customer_id
JOIN monetary AS m ON r.customer_id = m.customer_id