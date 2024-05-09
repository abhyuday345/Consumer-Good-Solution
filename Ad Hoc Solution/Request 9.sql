WITH sales_data AS (
    SELECT
        fs.product_code,
        fs.customer_code,
        fs.sold_quantity,
        fg.gross_price,
        dc.channel,
        fg.fiscal_year
    FROM
        fact_sales_monthly fs
    JOIN
        fact_gross_price fg ON fs.product_code = fg.product_code
    JOIN
        dim_customer dc ON fs.customer_code = dc.customer_code
    WHERE
        fg.fiscal_year = 2021
),
channel_sales AS (
    SELECT
        channel,
        SUM(sold_quantity * gross_price) AS total_sales
    FROM
        sales_data
    GROUP BY
        channel
),
total_sales AS (
    SELECT
        SUM(sold_quantity * gross_price) AS total_sales
    FROM
        sales_data
)
SELECT
    cs.channel,
    ROUND(cs.total_sales / ts.total_sales * 100, 2) AS percentage,
    ROUND(cs.total_sales / 1000000, 2) AS gross_sales_mln
FROM
    channel_sales cs
CROSS JOIN
    total_sales ts
ORDER BY
    cs.total_sales DESC
LIMIT 1;
