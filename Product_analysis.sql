-- Problem: What are the top selling products
with top_selling_products as 
(select s.`Order Number`, p.ProductKey
, p.`Product Name` as product_name, p.`Unit Price USD`*s.Quantity as sales
from sales s left join dim_products p
on s.ProductKey = p.ProductKey)
select ProductKey, product_name, sum(sales) as total_sales
from top_selling_products
group by ProductKey, product_name
order by total_sales desc;

-- Problem: What is the profit percentage by category
with category_tbl as
(select sum((p.`Unit Price USD`-p.`Unit Cost USD`)*s.Quantity) as Profit,
 sum(p.`Unit Price USD`*s.Quantity) as sales,
p.CategoryKey, p.Category 
from sales s left join dim_products p
on s.ProductKey = p.ProductKey
group by p.CategoryKey, p.Category)
select CategoryKey, Category, concat(round(Profit/Sales, 2)*100, '%') as Profit_percent
from category_tbl

-- 3) Problem: Pareto distribution of product by total sales 

with product_sales as
(select p.ProductKey, p.`Product Name`, sum(s.Quantity*p.`Unit Price USD`) as sales
from sales s inner join dim_products p
on s.ProductKey = p.ProductKey
group by p.ProductKey, p.`Product Name`
), table_with_order_no as
(select ProductKey, `Product Name`, 
row_number() over (order by sales desc) as row_num, sales
from product_sales)
select (row_num/count(*) over ())*100 as `top product %`, 
round((sum(sales) over (order by sales desc)/sum(sales) over())*100,2) as `top sales %`
from table_with_order_no
order by `top product %`;

-- Problem: top 20 low profit top selling product

with top_selling_products as
(select sum(p.`Unit Price USD`*s.Quantity) as sales, p.ProductKey, p.`Product Name`,
sum(p.`Unit Price USD`*s.Quantity - p.`Unit Cost USD`*s.Quantity) as profit
from sales s inner join dim_products p 
on s.ProductKey = p.ProductKey
group by p.ProductKey, `Product Name`
order by sales desc limit 20)
select ProductKey, `Product Name`, sales, profit
from top_selling_products
order by profit;