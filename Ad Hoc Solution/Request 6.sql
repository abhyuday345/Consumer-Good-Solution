SELECT
    fc.customer_code,
    dc.customer,
    AVG(fc.pre_invoice_discount_pct) AS average_discount_percentage
FROM
    fact_pre_invoice_deductions fc
JOIN
    dim_customer dc ON fc.customer_code = dc.customer_code
WHERE
    fc.fiscal_year = 2021
    AND dc.market = 'India'
GROUP BY
    fc.customer_code,
    dc.customer
ORDER BY
    average_discount_percentage DESC
LIMIT 5;
