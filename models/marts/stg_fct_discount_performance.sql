with revenues AS
(
    SELECT 
        product_category,
        ROUND(SUM(quantity * average_price), 2) AS total_revenue,
        EXTRACT(MONTH FROM sk_transaction_date) AS month_number
    FROM {{ ref("stg_online_sales")}}  
    GROUP BY product_category, month_number
)

SELECT 
    r.product_category,
    mo.month_code,
    dc.discount_pct,
    r.total_revenue,
    ROUND(SUM(r.total_revenue * dc.discount_pct / 100), 2) AS discount_amount,
    ROUND(r.total_revenue - SUM(r.total_revenue * dc.discount_pct / 100), 2) AS net_revenue
FROM revenues AS r
JOIN {{ ref("month_codes")}} AS mo
    ON r.month_number = mo.month_number
JOIN {{ ref("stg_discount_coupon")}} AS dc 
    ON r.product_category = dc.product_category
    AND mo.month_code = dc.month_code
GROUP BY r.product_category, mo.month_code, dc.discount_pct, r.total_revenue 
ORDER BY r.product_category, r.total_revenue DESC 

 