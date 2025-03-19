with raw_marketing_spend AS 
(
    SELECT 
        spend_id,
        date_spend,
        offline_spend,
        online_spend,
        CREATED_AT,
        UPDATED_AT
    FROM {{ source("MARKETING_INSIGHTS", "marketingSpend")}} 
)

SELECT 
    * 
FROM raw_marketing_spend 