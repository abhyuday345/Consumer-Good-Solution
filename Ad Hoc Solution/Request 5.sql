select d.product_code,d.product,max(f.manufacturing_cost),min(f.manufacturing_cost)
from dim_product d join fact_manufacturing_cost f on d.product_code = f.product_code
group by d.product_code;

