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
