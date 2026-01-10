
-- 1) Problem: monthly total sales

select month(s.`Order Date`) as month_no,
monthname(s.`Order Date`) as month_, 
sum(s.Quantity*p.`Unit Price USD`) as sales
from sales s inner join dim_products p
on s.ProductKey = p.ProductKey
group by month_no, month_
order by month_no

-- 2) Problem: running total sales over month

with monthly_sales as
(select month(s.`Order Date`) as month_no, monthname(s.`Order Date`) as Month_, sum(p.`Unit Price USD`*s.Quantity) as sales
from sales s left join dim_products p
on s.ProductKey = p.ProductKey
group by Month_,month_no)
select month_no, Month_, sum(sales) over (order by month_no) as running_total_sales
from monthly_sales 
order by month_no;

-- 3) Problem: current year sales vs previous year sales

with yearly_sales as 
(select year(s.`Order Date`) as year_,
sum(p.`Unit Price USD`*s.Quantity) as currentyear_sales
from sales s left join dim_products p
on s.ProductKey = p.ProductKey
group by year_)
select year_, currentyear_sales, lag(currentyear_sales) over (order by year_) as prevyear_sales
from yearly_sales;

-- 