with stg_dim_discount_coupon AS
(
    SELECT
        coupon_id AS nk_coupon_id,
        product_category AS dsc_product_category,
        month_code AS mtr_month_code,
        coupon_code AS dsc_coupon_code,
        discount_pct AS mtr_discount_pct,
        CREATED_AT AS dt_created_at,
        UPDATED_AT AS dt_updated_at
    FROM {{ ref("stg_discount_coupon")}}
)

SELECT
    {{ dbt_utils.generate_surrogate_key( ["nk_coupon_id"] )}} AS sk_coupon,
    *
FROM stg_dim_discount_coupon