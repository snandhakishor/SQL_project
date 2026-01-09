-- running total sales over month

with monthly_sales as
(select month(s.`Order Date`) as month_no, monthname(s.`Order Date`) as Month_, sum(p.`Unit Price USD`*s.Quantity) as sales
from sales s left join dim_products p
on s.ProductKey = p.ProductKey
group by Month_,month_no)
select month_no, Month_, sum(sales) over (order by month_no) as running_total_sales
from monthly_sales 
order by month_no;