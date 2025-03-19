with raw_customers AS 
(
    SELECT 
        customer_id,
        gender,
        located,
        tenure_months,
        CREATED_AT,
        UPDATED_AT
    FROM {{ source("MARKETING_INSIGHTS", "customers")}} 
)

SELECT 
    * 
FROM raw_customers 