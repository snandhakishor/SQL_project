# Product Analysis

## 1. Top selling products.

**Business question**
What are the top selling electronics products?

**Approach**
- Joined sales and product tables to find total sales using joins.
- Used CTE and window functions to fetch products with top sales.

**Insights**
Adventure Works Desktop PC2.33 XD233 Black was the top selling product.

## 2. Profit Percentage by Category 
**Business question**
What is the profit percentage of each product category.

**Approach**
- Joined sales and product tables to find total sales and profit using joins.
- Used CTE, subqueries and window functions to derive and fetch product category and their profit percentage.

**Insights**
Six out of eight categories have more than 50% profit percentage.

## 3. Pareto Distribution of Product by sales 

**Business Problem**
Does the sales follow pareto distribution for products?

**Approach**
- Joined products and sales table using join to combine import column for analysis
- Used row_number() function to rank products based on high sales.
- Found cumilative sales and found percentage sales contribution to compare with top product percentage using other window functions and CTE

**Insights**
Sales nearly followed pareto distrubtion with top 20 % products achieving 71 % of the total sales

## 4. Top 20 selling products with least profit

**Business Question**
What are least profitable products among most selling products

**Approach**
- Joins to gather relevant columns cost and price from products table and quanitity from sales table.
- CTE to divide querying and window function for aggregating sales and profit.

**Insights**
- 'Adventure Works Desktop PC1.80 ED182 Brown' was the least profitable product of the list ranking 18th in sales.
- Despite selling more than the other 2 products, it delivered least profitablity that them.

# Sales Analysis

## 1. Sales by month

**Business problem**
What is the monthly sales throughout every year?

**Approach**
- Joined products and sales table to derive sales column 
- Used date and format functions to derive months of respective years
- Used window functions to appropriately aggregate the results


**Insights**
- December 2019 reported highest sales among all months
- April month consistently reported lowest sales among every year

## 2. Running Sales by Month

**Business Problem**
What is the monthly running total sales?

**Approach**
- Joined sales and product tables to derive sales (quantity*price),
- Used CTE, window such as partition and date functions to derive month and running total sales.

**Insights**
- 2019 had highest cumilative sales by the end of the year ($1991974.68)
- 2020 january had best opening showing momentum from previous year 

## 3. Current year sales vs previous year sales

**Business Problem**
How does current year sales perform compared to previous year sales.

**Approach**
- Joined sales and product tables to derive sales (quantity*price) and group it by order date.
- Used CTE, window functions such as 'lag' to find previous year sales.
- Used date (year) function to derive year.

**Insights**
Current year sales were greater than previous year sales for most years, except for year 2020.

## 4. Rolling Average by month

**Business problem**
What is the three months rolling average of sales

**Approach**
- Joined sales and product tables to fetch and derive relevant columns.
- used CTE and window functions to find average of three month window.
- Defined window as rows between 2 perceding and current row.

**Insights**
There are huge fluctuations in average sales indicating that the average sales is not consistent over month despite the smoothing effect of averaging.

# Customer Behavior 

## 1. Repeat customers vs One-time customers count

**Business Problem**
Compare total number of one-time and repeat customers to understand customer satisfaction.

**Approach**
- Joined customers and sales table to find total number of orders for each customer key.
- Used multiple CTEs to classify customer keys as 'one-time' or 'repeat' based on number of orders with the help of "case..when..then..else" clause and finally find count of 'one-time' and 'repeat' customer keys.

**Insights**
Number of repeat customers (7272) were greater than that of one-time customers (4615) indicating that many are satisfied with the orders. 

## 2. Product Quantity percentage  and sales percentage by gender.

**Business problem**
To find most valuable and active customers by gender

**Approach**
- Joined customers, sales and products table to get relevant fields such as gender, sales and quantity.
- Used subquery and window function to find percentage contribution of each gender to sales and quantity.

**Insights**
Both male and female contribute roughly the same in both areas with males contributing slightly higher than females (1%).

## 3. Average Order Value over year

**Business problem**
How did customer spending reflect over years?

**Approach**
- Used table joins to join product and sales table to fetch relevant columns such as price and quantity to derive sales.
- Used CTE and window functions to group and find AOV over years.

**Insights**
- There were no significant variations over year.
- 2017 reported highest AOV with $1724.34 per order.

## 4. Average Sales by Age group 

**Business problem**
Which age group spends the most on average?

**Approach**
- Derived age column using DOB with timestampdiff() function and derived age group column by clearly defining age ranges using "case...end as" clause.
- Used CTE to divide the query into managable steps 
- Used window function for aggregation and grouping 

**Insights**
- Customers above 50 were most spending, age group 25-50 was slightly behind first and the least spening group was 18-25.