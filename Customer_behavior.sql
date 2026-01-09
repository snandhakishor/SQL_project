-- Business problem - Total number of repeat vs one-time customers

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

-- Most valuable and most active customers by gender 

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
group by Gender