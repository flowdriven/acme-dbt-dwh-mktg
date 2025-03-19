with raw_discount_coupon AS 
(
    SELECT 
        coupon_id,
        product_category,
        month_code,
        coupon_code,
        discount_pct, 
        CREATED_AT,
        UPDATED_AT
    FROM {{ source("MARKETING_INSIGHTS", "discountCoupon")}} 
)

SELECT 
    * 
FROM raw_discount_coupon 