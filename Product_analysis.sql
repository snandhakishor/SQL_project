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

-- product analysis - profit percentage by category
with category_tbl as
(select sum((p.`Unit Price USD`-p.`Unit Cost USD`)*s.Quantity) as Profit,
 sum(p.`Unit Price USD`*s.Quantity) as sales,
p.CategoryKey, p.Category 
from sales s left join dim_products p
on s.ProductKey = p.ProductKey
group by p.CategoryKey, p.Category)
select CategoryKey, Category, concat(round(Profit/Sales, 2)*100, '%') as Profit_percent
from category_tbl