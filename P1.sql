-- SQL Retail Sales Analysis - P1
--CREATE TABLE

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(10),
age	INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

SELECT * FROM retail_sales;

ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;

SELECT 
COUNT(*) FROM retail_sales;

-- DELETING THE NULL VALUES
SELECT * FROM retail_sales
WHERE 
     transactions_id IS NULL
	 OR 
	 sale_date IS NULL
	 OR 
	 sale_time IS NULL
	 OR 
	 customer_id IS NULL
	 OR 
	 gender	IS NULL
	 OR 
	 age IS NULL
	 OR
	 category IS NULL
	 OR 
	 quantiy	IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs 
	 IS NULL
	 OR 
	 total_sale IS NULL
;

DELETE FROM retail_sales
WHERE
transactions_id IS NULL
	 OR 
	 sale_date IS NULL
	 OR 
	 sale_time IS NULL
	 OR 
	 customer_id IS NULL
	 OR 
	 gender	IS NULL
	 OR 
	 age IS NULL
	 OR
	 category IS NULL
	 OR 
	 quantiy	IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs 
	 IS NULL
	 OR 
	 total_sale IS NULL ;

--DATA EXPLORATION

--How many sales do we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

--How many customers do we have?
SELECT COUNT(DISTINCT customer_id) AS total_customer FROM retail_sales;

--How many categories do we have?
SELECT COUNT(DISTINCT category) AS total_category FROM retail_sales;

--BUSINESS KEY PROBLEMS & ANSWERS
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE 
     category = 'Clothing'
	 AND
	 quantity > 3
	 AND 
	 TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
      category,
	  SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT ROUND(AVG(age),2) AS average_age FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT gender, category, COUNT(transactions_id) AS total_transactions FROM retail_sales
GROUP BY gender, category
ORDER BY gender, category;

-- Q.7 Write a SQL query to calculate the average sale for each month. 
--            Find out best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
    
-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

--END OF PROJECT
