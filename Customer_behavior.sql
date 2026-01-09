-- 1) Business problem - Total number of repeat vs one-time customers

with customer_orders as 
(select c.CustomerKey, count(distinct s.`Order Number`) as order_counts
from sales s left join dim_customers c
on s.CustomerKey = c.CustomerKey
group by c.CustomerKey),
customer_type_count as 
(select CustomerKey, 
case when order_counts = 1 then 'one time' 
	 else 'repeat'
end as customer_type
from customer_orders)
select customer_type, count(distinct CustomerKey) as `count`
from customer_type_count
group by customer_type;

-- 2) Problem - Find most valuable and most active customers by gender 

select Gender, 
round((total_quantity/sum(total_quantity) over())*100,2) as `total_quantity %`, 
round((total_sales/sum(total_sales) over())*100,2) as `total_sales %` from
(select c.Gender, sum(s.Quantity) as total_quantity , 
sum(s.Quantity*p.`Unit Price USD`) as total_sales
from sales s inner join dim_customers c 
on s.CustomerKey = c.CustomerKey 
inner join dim_products p 
on s.ProductKey = p.ProductKey
group by Gender) as gender_table
group by Gender;

-- 3) Problem: find average order value by year 

with orders_by_year as
(select count(distinct s.`Order Number`) as total_orders, 
year(s.`Order Date`) as year_, sum(p.`Unit Price USD`*s.Quantity) as sales
from sales s inner join dim_products p
on s.ProductKey = p.ProductKey
group by year_ )
select year_, sales/total_orders as AOV 
from orders_by_year
group by year_;

-- 4) Problem: sales by customer age group

with sales_by_age as
(select  sum(s.Quantity*p.`Unit Price USD`) as sales, timestampdiff(year, c.Birthday, curdate()) as age_
from sales s inner join  dim_customers c
on s.CustomerKey = c.CustomerKey
inner join dim_products p on s.ProductKey = p.ProductKey
group by age_), sales_agegroup as
(select sales, 
case when age_ between 18 and 25 then "18-25"
	 when age_ between 25 and 50 then "25-50"
     when age_>50 then "above 50"
else "below 18" end as age_group from sales_by_age)
select age_group, sum(sales) as total_sales
from sales_agegroup
group by age_group;
