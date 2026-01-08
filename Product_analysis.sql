#product analysis - top selling products
with top_selling_products as 
(select s.`Order Number`, p.ProductKey
, p.`Product Name` as product_name, p.`Unit Price USD`*s.Quantity as sales
from sales s left join dim_products p
on s.ProductKey = p.ProductKey)
select ProductKey, product_name, sum(sales) as total_sales
from top_selling_products
group by ProductKey, product_name
order by total_sales desc;