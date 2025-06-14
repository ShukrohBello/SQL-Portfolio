--------------------------------------------
-- CASE STUDY #1 QUESTIONS: DANNY'S DINER --
--------------------------------------------

-- Author: Shukurat Bello
-- Date: 14/06/2025
-- Tool used: Microsoft SQL Server

SELECT  * FROM sales;
SELECT * FROM menu;
SELECT * FROM members;

--1. What is the total amount each customer spent at the restaurant?

SELECT customer_id, SUM(price) total_amount_spent
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
GROUP BY customer_id

--2. How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT order_date) customer_visit
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
GROUP BY customer_id;

--3. What was the first item from the menu purchased by each customer?
WITH purchase_rank AS(
SELECT customer_id, order_date, product_name,
		 RANK() OVER (PARTITION BY s.customer_id ORDER BY order_date ASC) AS rank
FROM sales s
JOIN menu m
ON s.product_id = m.product_id
)
SELECT DISTINCT customer_id, order_date, product_name
FROM purchase_rank
WHERE rank = 1;

--4.