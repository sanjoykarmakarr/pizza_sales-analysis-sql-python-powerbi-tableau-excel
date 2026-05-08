--DATASET
select * from dbo.pizza_sales;

--Q.1> The sum of the total price of all pizza orders??  (Total revenue!!)
select sum(total_price) as TOTAL_REVENUE from dbo.pizza_sales;
select cast(sum(total_price) as decimal(10,2)) as TOTAL_REVENUE from dbo.pizza_sales; --(here i use {cast-decimal} for upto 2 decimal value)
-- ANS is = 817860.05083847/817860.05

--Q.2> The avg amount spent per pizza,calculated by dividing the total revenue by the total number of orders??
--(avg order value!!)
select sum(total_price)/count (distinct order_id) as AVG_ORDER_VALUE from pizza_sales;
-- ANS is = 38.3072623343546 (as because there is repeating order_id,so here we use distinct count)

--Q.3> The sum of the quantities of all the pizza sold?? (Total pizza sold!!)
select sum(quantity) as TOTAL_QUANTITY from pizza_sales;
-- ANS is = 49574 (Here 'TOTAL_QUANTITY' is alias)

--Q.4> The total number of order placed?? (Total orders!!)
select count(order_id) as TOTAL_ORDERS from pizza_sales;
-- ANS is = 48620

--Q.5> The avg no. of pizzas sold per order,calculated by dividing the total no of pizzas sold by the total no. of 
--orders?? (Avg pizzas per order!!)
select cast(cast(sum (quantity) as decimal (10,2))/cast (count(distinct order_id) as decimal (10,2)) as decimal
(10,2)) as AVG_PIZZA_PER_ORDER from pizza_sales;
-- ANS is =2.32 (Here we use CAST function for dacimal values; ie, 10 for 10 dacimal values and 2 to 
--shorten the values upto 2 values after decimal.)

--Q.6 What is the daily trend for total orders??
select DATENAME(DW, order_date) as order_day, count(distinct order_id) as total_order from pizza_sales 
group by DATENAME(DW, order_date);
-- Ans is =(Using DATENAME to extract a specific part of a date/time value and return it as a string.
-- Here we use DW a inbuild function (day of week) and GROUP BY for  group rows that have the same values 
-- in specified columns into a single summary row.)
Saturday   3158
Wednesday  3024
Monday	   2794
Sunday	   2624
Friday	   3538
Thursday   3239
Tuesday	   2973

--Q.7 What is the HOURLY trend for total orders??
select DATEPART(HOUR,order_time) as order_hours,COUNT(distinct order_id) as total_orders from pizza_sales 
group by DATEPART(HOUR,order_time) order by DATEPART(HOUR,order_time);

--Q.8 What is the MONTHLY trend for total orders??
select DATENAME (month,order_date) as order_day,COUNT(distinct order_id) as total_orders from pizza_sales
group by DATENAME (month,order_date) order by COUNT(distinct order_id) desc;
--Here if we sort by month 
SELECT DATENAME(MONTH, order_date) AS order_month,COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date),MONTH(order_date) ORDER BY MONTH(order_date) ASC;
-- Ans is = 
January	   1845
February   1685
March	   1840
April	   1799
May	       1853
June	   1773
July	   1935
August	   1841
September  1661
October	   1646
November   1792
December   1680

--Q.9 Percentage of sales by Pizza Category??
select pizza_category,sum (total_price) as total_sales ,sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as Percentge from 
pizza_sales group by pizza_category;
--Ans is like,here i take category and total price to show in table and apply percentage formula(group total/grand total*100)and group the category.

--Q.10 Percentage of sales by Pizza size??
select pizza_size,cast(sum (total_price) as decimal(10,2)) as total_sales ,cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales)
as decimal(10,2)) as Percentge from pizza_sales group by pizza_size;
--Ans is like,here i take size and total price to show in table and apply percentage formula(group total/grand total*100)and group the size.

--Q.11 Top 5 best sellers by REVENUE,TOTAL QUANTITY and TOTAL ORDERS ??
select top 5 pizza_name,CAST(SUM(total_price) as decimal(10,2)) as revenue,SUM(quantity) as quantity,COUNT(distinct order_id) as orders 
from pizza_sales group by pizza_name order by revenue desc;

--Q.12 Bottom 5 best sellers by REVENUE,TOTAL QUANTITY and TOTAL ORDERS ??
select top 5 pizza_name,CAST(SUM(total_price) as decimal(10,2)) as revenue,SUM(quantity) as quantity ,COUNT(distinct order_id) as orders 
from pizza_sales group by pizza_name order by revenue asc;






