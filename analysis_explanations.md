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


# Sales Analysis

## 1. Running Sales by Month

**Business Problem**
What is the monthly running total sales?

**Approach**
- Joined sales and product tables to derive sales (quantity*price),
- Used CTE, window and date functions to derive month and running total sales.

**Insights**
Sales growth is mostly steady over month.

## 2. Current year sales vs previous year sales

**Business Problem**
How does current year sales perform compared to previous year sales.

**Approach**
- Joined sales and product tables to derive sales (quantity*price) and group it by order date.
- Used CTE, window functions such as 'lag' to find previous year sales.
- Used date (year) function to derive year.

**Insights**
Current year sales were greater than previous year sales for most years, except for year 2020.


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