SELECT 
    EXTRACT(MONTH FROM fs.date) AS Month,
    EXTRACT(YEAR FROM fs.date) AS Year,
    SUM(fs.sold_quantity * fgp.gross_price) AS Gross_sales_Amount
FROM 
    fact_sales_monthly fs
JOIN 
    dim_customer dc ON fs.customer_code = dc.customer_code
JOIN 
    fact_gross_price fgp ON fs.product_code = fgp.product_code
WHERE 
    dc.customer = 'Atliq Exclusive'
GROUP BY 
    EXTRACT(MONTH FROM fs.date),
    EXTRACT(YEAR FROM fs.date)
ORDER BY 
    Year, Month;
