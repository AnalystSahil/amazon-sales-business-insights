CREATE database IF NOT exists NEW_PROJECT;
USE NEW_PROJECT;


select count(*) from amazon_sales_dataset;

show columns from amazon_sales_dataset;


select * from amazon_sales_dataset
order by order_id asc
 limit 10;
 
-- check duplicate values
select count(*) as total_rows,
count(distinct order_id) as unique_orders
from amazon_sales_dataset;

-- check null values
SELECT
    COUNT(*) - COUNT(order_id) AS missing_order_id,
    COUNT(*) - COUNT(order_date) AS missing_order_date,
    COUNT(*) - COUNT(product_id) AS missing_product_id,
    COUNT(*) - COUNT(product_category) AS missing_category,
    COUNT(*) - COUNT(price) AS missing_price,
    COUNT(*) - COUNT(quantity_sold) AS missing_quantity,
    COUNT(*) - COUNT(customer_region) AS missing_region,
    COUNT(*) - COUNT(payment_method) AS missing_payment,
    COUNT(*) - COUNT(rating) AS missing_rating,
    COUNT(*) - COUNT(review_count) AS missing_review_count,
    COUNT(*) - COUNT(discounted_price) AS missing_discounted_price,
    COUNT(*) - COUNT(total_revenue) AS missing_revenue
FROM amazon_sales_dataset;

describe amazon_sales_dataset;

select sum(total_revenue) as total_revenue
from amazon_sales_dataset;


select product_category, SUM(total_revenue) AS  TOTAL_REVENUE_OF_CATEGORY
FROM amazon_sales_dataset
GROUP BY product_category
ORDER BY  TOTAL_REVENUE_OF_CATEGORY DESC;


select product_category, sum(quantity_sold) AS total_sold
FROM amazon_sales_dataset
GROUP BY product_category
ORDER BY  total_sold DESC;

select payment_method, sum(total_revenue) as total_revenue
from amazon_sales_dataset
group by  payment_method
order by total_revenue desc;

SELECT
    product_category,
    AVG(discount_percent) AS avg_discount,
    round(SUM(total_revenue),1) AS total_revenue
FROM amazon_sales_dataset
GROUP BY product_category
ORDER BY total_revenue DESC;

show columns from amazon_sales_dataset;

-- RENAME THE  TABLE NAME

alter table amazon_sales_dataset rename SALES_DATA;

SELECT product_category,SUM(TOTAL_REVENUE)AS TOTAL_REVENUE 
FROM  SALES_DATA
GROUP BY product_category
ORDER BY TOTAL_REVENUE  DESC
LIMIT 5;

SELECT product_category,SUM(QUANTITY_SOLD)AS TOTAL_SOLD
FROM  SALES_DATA
GROUP BY product_category
ORDER BY TOTAL_SOLD  DESC;

SELECT product_category,SUM(QUANTITY_SOLD)AS TOTAL_SOLD,
 ROUND(SUM(TOTAL_REVENUE),1) AS TOTAL_REVENUE
FROM  SALES_DATA
GROUP BY product_category
ORDER BY TOTAL_REVENUE DESC;

SELECT PRODUCT_CATEGORY,ROUND(SUM(TOTAL_REVENUE),2)AS TOTAL_REVENUE,
RANK() OVER(ORDER BY ROUND(SUM(TOTAL_REVENUE),2)  DESC) AS RANK_REVENUE
FROM SALES_DATA
GROUP BY PRODUCT_CATEGORY;


SELECT PRODUCT_CATEGORY, SUM(TOTAL_REVENUE) AS TOTAL_REVENUE,
SUM(QUANTITY_SOLD)AS TOTAL_SOLD
FROM SALES_DATA
GROUP BY PRODUCT_CATEGORY
ORDER BY SUM(QUANTITY_SOLD) desc;

SELECT 
    product_category,
    SUM(total_revenue) AS total_revenue,
    SUM(quantity_sold) AS total_quantity
FROM SALES_DATA
GROUP BY product_category
HAVING SUM(total_revenue) > (SELECT AVG(total_revenue) FROM SALES_DATA)
   AND SUM(quantity_sold) < (SELECT AVG(quantity_sold) FROM SALES_DATA);
   
   
   SELECT 
    product_category,
    SUM(total_revenue) AS total_revenue,
    SUM(quantity_sold) AS total_quantity
FROM SALES_DATA
GROUP BY product_category
HAVING SUM(quantity_sold) > (SELECT AVG(quantity_sold) FROM SALES_DATA)
   AND SUM(total_revenue) < (SELECT AVG(total_revenue) FROM SALES_DATA);
   
   
   
    
   
   SELECT 
    product_category,
    SUM(total_revenue) AS total_revenue,
    SUM(quantity_sold) AS total_quantity
FROM SALES_DATA
GROUP BY product_category
HAVING SUM(quantity_sold) > (SELECT AVG(quantity_sold) FROM SALES_DATA)
   AND SUM(total_revenue) < (SELECT AVG(total_revenue) FROM SALES_DATA) ;
   
   
   
SELECT 
    product_category,
    SUM(total_revenue) AS total_revenue
FROM SALES_DATA
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 3;


SELECT 
    product_category,
    SUM(quantity_sold) AS total_quantity
FROM SALES_DATA
GROUP BY product_category
ORDER BY total_quantity DESC
LIMIT 3;

SELECT 
    product_category,
    SUM(total_revenue) AS total_revenue
FROM SALES_DATA
GROUP BY product_category
ORDER BY total_revenue ASC
LIMIT 3;


SELECT 
    product_category,
    SUM(quantity_sold) AS total_quantity
FROM SALES_DATA
GROUP BY product_category
ORDER BY total_quantity ASC
LIMIT 3;


SELECT customer_region, SUM(TOTAL_REVENUE) AS TOTAL_REVENUE
FROM SALES_DATA
group by customer_region;


SELECT customer_region, SUM(QUANTITY_SOLD) AS TOTAL_QUANTITY
FROM SALES_DATA
group by customer_region;


SELECT PRODUCT_CATEGORY, SUM( RATING) AS RATING
FROM SALES_DATA
group by PRODUCT_CATEGORY;


SELECT 
    product_category,
    AVG(rating) AS avg_rating
FROM SALES_DATA
GROUP BY product_category
ORDER BY avg_rating DESC;


SELECT 
    product_category,SUM(TOTAL_REVENUE)AS TOTAL_REVENUE,
    AVG(rating) AS avg_rating
FROM SALES_DATA
GROUP BY product_category
ORDER BY SUM(TOTAL_REVENUE) DESC;

SELECT  PAYMENT_METHOD,
SUM(TOTAL_REVENUE)AS TOTAL_REVENUE
 FROM SALES_DATA
 GROUP BY PAYMENT_METHOD;
 
SELECT 
    payment_method,
    COUNT(*) AS usage_count
FROM SALES_DATA
GROUP BY payment_method
ORDER BY usage_count DESC;





SELECT
        product_category,
        product_id,
        SUM(total_revenue) AS revenue,
        RANK() OVER(
            PARTITION BY product_category
            ORDER BY SUM(total_revenue) DESC
        ) AS rk
    FROM SALES_DATA
    GROUP BY product_category, product_id;
show columns from sales_data;




SELECT *
FROM (
    SELECT
        product_category,
        product_id,
        SUM(total_revenue) AS revenue,
        RANK() OVER(
            PARTITION BY product_category
            ORDER BY SUM(total_revenue) DESC
        ) AS rk
    FROM SALES_DATA
    GROUP BY product_category, product_id
) t
WHERE rk = 1;
 
 SELECT
    product_category,
    ROUND(SUM(total_revenue),2) AS revenue,
    ROUND(
        SUM(total_revenue) * 100 /
        (SELECT SUM(total_revenue) FROM SALES_DATA),
        2
    ) AS revenue_percentage
FROM SALES_DATA
GROUP BY product_category
ORDER BY revenue DESC; 
 



SHOW COLUMNS  FROM SALES_DATA;
