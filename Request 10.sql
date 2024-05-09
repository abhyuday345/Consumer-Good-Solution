WITH sales_data AS (
    SELECT
        dp.division,
        dp.product_code,
        dp.product,
        SUM(fs.sold_quantity) AS total_sold_quantity,
        RANK() OVER(PARTITION BY dp.division ORDER BY SUM(fs.sold_quantity) DESC) AS rank_order
    FROM
        dim_product dp
    JOIN
        fact_sales_monthly fs ON dp.product_code = fs.product_code
    WHERE
        EXTRACT(YEAR FROM fs.date) = 2021
    GROUP BY
        dp.division,
        dp.product_code,
        dp.product
)
SELECT
    division,
    product_code,
    product,
    total_sold_quantity,
    rank_order
FROM
    sales_data
WHERE
    rank_order <= 3
ORDER BY
    division,
    rank_order;
