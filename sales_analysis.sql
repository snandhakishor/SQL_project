
-- 1) Problem: monthly total sales throughout every year

select month(s.`Order Date`) as month_no,
year(s.`Order Date`) as year_, 
date_format(s.`Order Date`, '%Y-%m') as year_month_,
sum(s.Quantity*p.`Unit Price USD`) as sales
from sales s inner join dim_products p
on s.ProductKey = p.ProductKey
group by month_no, year_,year_month_;


-- 2) Problem: running total sales over month

with monthly_sales as
(select month(s.`Order Date`) as month_no, 
date_format(s.`Order Date`, '%Y-%m') as Month_year, 
year(s.`Order Date`) as year_,
sum(p.`Unit Price USD`*s.Quantity) as sales
from sales s inner join dim_products p
on s.ProductKey = p.ProductKey
group by Month_year, month_no,year_ )
select year_, month_no, Month_year, sum(sales) over 
(partition by year_ order by month_no) as running_total_sales
from monthly_sales;


-- 3) Problem: current year sales vs previous year sales

with yearly_sales as 
(select year(s.`Order Date`) as year_,
sum(p.`Unit Price USD`*s.Quantity) as currentyear_sales
from sales s left join dim_products p
on s.ProductKey = p.ProductKey
group by year_)
select year_, currentyear_sales, lag(currentyear_sales) over (order by year_) as prevyear_sales
from yearly_sales;


-- 4) Problem: 3 month moving average of sales

with monthly_sales as 
(select month(s.`Order Date`) as month_no, 
date_format(s.`Order Date`, '%m-%Y') as month_year,
year(s.`Order Date`) as year_,
sum(s.Quantity*p.`Unit Price USD`) as sales
from sales s inner join dim_products p
on s.ProductKey = p.ProductKey
group by year_, month_no, month_year)
select year_, month_no, month_year, avg(sales) over 
(order by year_, month_no rows between
 2 preceding and current row ) 
as moving_avg_sales
from monthly_sales
order by year_, month_no;