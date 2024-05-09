WITH sales_data AS (
    SELECT
        DATE,
        PRODUCT_CODE,
        CUSTOMER_CODE,
        SOLD_QUANTITY,
        EXTRACT(MONTH FROM DATE) AS MONTH,
        CASE
            WHEN EXTRACT(MONTH FROM DATE) BETWEEN 9 AND 12 THEN 'Q1'
            WHEN EXTRACT(MONTH FROM DATE) BETWEEN 1 AND 3 THEN 'Q2'
            WHEN EXTRACT(MONTH FROM DATE) BETWEEN 4 AND 6 THEN 'Q3'
            ELSE 'Q4'
        END AS QUARTER
    FROM
        fact_sales_monthly
    WHERE
        EXTRACT(YEAR FROM DATE) = 2020
)
SELECT
    QUARTER,
    SUM(SOLD_QUANTITY) AS total_sold_quantity
FROM
    sales_data
GROUP BY
    QUARTER
ORDER BY
    total_sold_quantity DESC
LIMIT 1;

