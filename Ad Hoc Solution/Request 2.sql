with unique_products_2020 as
(
SELECT count(distinct product_code) as '2020'
FROM fact_sales_monthly
WHERE YEAR(date) = 2020
),
unique_products_2021 as
(
SELECT count(distinct product_code) as '2021'
FROM fact_sales_monthly
WHERE YEAR(date) = 2021
)
select *, round(((2021 - 2020) / (2020)) * 100,2) as Percenatge_Change from unique_products_2020 join unique_products_2021;
