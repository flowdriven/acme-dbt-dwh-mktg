with stg_dim_customers AS
(
    SELECT
        customer_id AS nk_customer_id,
        gender AS dsc_gender,
        located AS dsc_located,
        tenure_months AS mtr_tenure_months,
        CREATED_AT AS dt_created_at,
        UPDATED_AT AS dt_updated_at
    FROM {{ ref("stg_customers")}}
)

SELECT
    {{ dbt_utils.generate_surrogate_key( ["nk_customer_id"] )}} AS sk_customer,
    *
FROM stg_dim_customers