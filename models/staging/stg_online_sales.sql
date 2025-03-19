with
    raw_online_sales as (
        select
            customer_id,
            transaction_id,
            CAST(transaction_date AS DATE) sk_transaction_date,
            product_sku,
            product_description,
            product_category,
            quantity,
            average_price,
            delivery_charges,
            coupon_status,
            created_at,
            updated_at
        from {{ source("MARKETING_INSIGHTS", "onlineSales") }}
    )

select *
from raw_online_sales
