WITH ProductCounts AS (
    SELECT
        dp.segment,
        COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM fs.date) = 2020 THEN dp.product_code END) AS product_count_2020,
        COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM fs.date) = 2021 THEN dp.product_code END) AS product_count_2021
    FROM
        dim_product dp
    LEFT JOIN
        fact_sales_monthly fs ON dp.product_code = fs.product_code
    WHERE
        EXTRACT(YEAR FROM fs.date) IN (2020, 2021)
    GROUP BY
        dp.segment
)

SELECT
    pc.segment,
    pc.product_count_2020,
    pc.product_count_2021,
    pc.product_count_2021 - pc.product_count_2020 AS difference
FROM
    ProductCounts pc
ORDER BY
    difference DESC
LIMIT 1;
