-- Calculate 

SELECT
  COUNT(*) AS Total_Orders
 FROM `bigquery-public-data.thelook_ecommerce.orders`; 

 -- Total items, max, min

 SELECT
  COUNT(*) AS Total_Orders,
  SUM(num_of_item) AS total_items,
  AVG(num_of_item) AS AVG_items,
  MIN(num_of_item) AS min_items,
  MAX(num_of_item) AS max_items

 FROM `bigquery-public-data.thelook_ecommerce.orders`; 


 -- Total order
SELECT
  status,
  COUNT(*) AS Total_Orders
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status
ORDER BY 2 DESC;

-- Total order and AVG no of item

SELECT
  status,
  COUNT(*) AS Total_Orders,
  AVG(num_of_item) AS AVG_items
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status
ORDER BY 2 DESC;


 -- 5 matrix summart from order table bases on GENDER

 SELECT
  gender,
  COUNT(*) AS Total_Orders,
  SUM(num_of_item) AS total_items,
  AVG(num_of_item) AS AVG_items,
  MIN(num_of_item) AS min_items,
  MAX(num_of_item) AS max_items

FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY gender;


-- Query writing sequence

SELECT
FROM
WHERE
GROUP BY
ORDER BY

-- Example of WHERE, GROUP BY and ORDER BY usage

SELECT
  status,
  COUNT(*) AS Total_Orders,
  SUM(num_of_item) AS total_items,
  AVG(num_of_item) AS AVG_items,
  MIN(num_of_item) AS min_items,
  MAX(num_of_item) AS max_items

FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE gender = 'F'
GROUP BY status
ORDER BY 2 DESC;

-- ROUND, COUNT DISTINCT, SAFE DIVIDE

-- file ext.txt/ .sql
-- can save queries by copy all and save into notepad

-- function ROUND is for decimal

SELECT
  status,
  COUNT(*) AS Total_Orders,
  ROUND (AVG(num_of_item), 2) AS avg_items

FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status;


--COUNT DISTINCT (unique value)

SELECT
  COUNT (DISTINCT status) AS num_of_status
FROM `bigquery-public-data.thelook_ecommerce.orders`;

-- IN usage in WHERE (WHERE status ='Complete' AND status = 'Shipped')

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE status IN ('Complete','Shipped');

-- NOT IN usage in WHERE (WHERE status =/'Complete' AND status =/ 'Shipped')

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE status NOT IN ('Complete','Shipped');


--BETWEEN 

SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE created_at >= '2026-10-01' AND created_at < '2026-11-01';

-- WHERE created_at BETWEEN '2026-10-01' AND '2026-10-31' (simpler)


SELECT 
  product_id,

FROM `bigquery-public-data.thelook_ecommerce.orders`










SELECT  

  product_id,
  COUNT(*) AS item_rows

FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY 1
ORDER BY item_rows DESC
LIMIT 10;

--Sales performance based on status. 

SELECT 
  status,
  COUNT(*) AS total_items,
  COUNT(DISTINCT order_id) AS total_orders,
  ROUND (SUM(sale_price), 2) AS total_sales,
  ROUND (AVG(sale_price), 2) AS avg_sale_price


FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY status

--HAVING COUNT = filter after aggregation
--WHERE = filter before aggregation
HAVING COUNT(*) >= 100
ORDER BY total_sales DESC;

-- total sales_price
SELECT SUM(sale_price) AS total_item_sales
FROM `bigquery-public-data.thelook_ecommerce.order_items`

-- total per order status

SELECT 
  status,
  SUM(sale_price) AS total_item_sales
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY 1;


-- Average product price per category (mix and max price added)

SELECT 
  category,
  COUNT(*) AS total_products,
  ROUND(AVG(retail_price),2) AS avg_retail_price,
  MIN(retail_price) AS min_retail_price,
  MAX(retail_price) AS max_retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
GROUP BY category
ORDER BY avg_retail_price DESC;


-- example of HAVING and WHERE

SELECT 
  category,
  COUNT(*) AS total_products,
  ROUND(SUM(retail_price), 2) AS total_retail_value
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE retail_price > 50 -- filter rows of gross product from retail price
GROUP BY category
HAVING SUM(retail_price) > 10000 -- filter final product after grouping / aggregation
ORDER BY 3 DESC;

--Practice 1 (23 Oct 2026)
--Task A
SELECT 
  status,
  COUNT(*) AS total_orders
FROM `bigquery-public-data.thelook_ecommerce.orders`
GROUP BY status
ORDER BY total_orders DESC;

--Task B (Top 10 countries with the most users)

SELECT
  country,
  COUNT (*) AS total_users
FROM `bigquery-public-data.thelook_ecommerce.users`
GROUP BY country
ORDER BY 2 DESC
LIMIT 10;
  

-- INNER JOIN (only display user id that is available in BOTH table orders and users)
-- Values are in pair

SELECT 
  O.order_id AS order_id,
  O.status,
  U.id AS user_id,
  U.country
FROM `bigquery-public-data.thelook_ecommerce.orders` AS O
INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS U

  ON O.user_id = U.id;


-- LEFT JOIN (only display all user id on left table which is Users table)
-- if NO values on the right table, then value in right table becomes 'NULL'
-- Display all users incl users that haven't make order, so order id in righ table becomes 'NULL'

SELECT 
  O.order_id AS order_id,
  O.status,
  U.id AS user_id,
  U.country
FROM `bigquery-public-data.thelook_ecommerce.users` AS U -- left table (1st table after FROM)
LEFT JOIN `bigquery-public-data.thelook_ecommerce.orders` AS O -- right table

  ON U.id = O.user_id
LIMI 10;

--INNER JOIN other example

SELECT 
  o.order_id AS order_id,
  o.status,
  u.country,
  o.created_at
FROM `bigquery-public-data.thelook_ecommerce.orders` AS o
INNER JOIN `bigquery-public-data.thelook_ecommerce.users` AS u

  ON o.user_id = u.id;

-- find rows with value null

SELECT 
  O.order_id AS order_id,
  O.status,
  U.id AS user_id,
  U.country
FROM `bigquery-public-data.thelook_ecommerce.users` AS U -- left table (1st table after FROM)
LEFT JOIN `bigquery-public-data.thelook_ecommerce.orders` AS O -- right table

  ON U.id = O.user_id
WHERE O.order_id IS NULL;

