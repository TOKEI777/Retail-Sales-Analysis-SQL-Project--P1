-- CREATE TABLE retail_sales (
--     transactions_id INTEGER PRIMARY KEY,
--     sale_date TEXT,
--     sale_time TEXT,
--     customer_id INTEGER,
--     gender TEXT,
--     age INTEGER,
--     category TEXT,
--     quantiy INTEGER,
--     price_per_unit REAL,
--     cogs REAL,
--     total_sale REAL
-- );
SELECT COUNT(*) AS n
FROM retail_sales;
DROP VIEW IF EXISTS retail_sales_clean;
CREATE VIEW retail_sales_clean AS
SELECT transactions_id AS transaction_id,
  sale_date,
  sale_time,
  customer_id,
  gender,
  age,
  category,
  quantiy AS quantity,
  price_per_unit,
  cogs,
  total_sale
FROM retail_sales
WHERE transactions_id IS NOT NULL
  AND sale_date IS NOT NULL
  AND sale_time IS NOT NULL
  AND customer_id IS NOT NULL
  AND gender IS NOT NULL
  AND age IS NOT NULL
  AND category IS NOT NULL
  AND quantiy IS NOT NULL
  AND price_per_unit IS NOT NULL
  AND cogs IS NOT NULL
  AND total_sale IS NOT NULL;
SELECT *
FROM retail_sales_clean
LIMIT 20;
SELECT COUNT(DISTINCT customer_id)
FROM retail_sales_clean;
SELECT DISTINCT category
FROM retail_sales_clean;
---data analysis & findings
--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT *
FROM retail_sales_clean
WHERE sale_date = '2022-11-05';
--2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM retail_sales_clean
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date <= '2022-12-01'
  AND quantity >= 4;
--3. Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category,
  SUM(total_sale) AS net_sale,
  COUNT(*) AS total_orders
FROM retail_sales_clean
GROUP BY category;
--4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT AVG(age) AS average_age
FROM retail_sales_clean
WHERE category = 'Beauty';
--5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT *
FROM retail_sales_clean
WHERE total_sale > 1000;
--6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category,
  gender,
  COUNT (*) total_transactions
FROM retail_sales_clean
GROUP BY category,
  gender
ORDER BY category;
--7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT year,
  month,
  average_sale
FROM(
    SELECT CAST(strftime('%Y', sale_date) AS INT) AS year,
      CAST(strftime('%m', sale_date) AS INT) AS month,
      AVG(total_sale) AS average_sale,
      RANK() OVER(
        PARTITION BY CAST(strftime('%Y', sale_date) AS INT)
        ORDER BY AVG(total_sale) DESC
      ) AS RANK
    FROM retail_sales_clean
    GROUP BY 1,
      2
  )
WHERE RANK = 1;
-- SELECT COUNT(DISTINCT CAST(strftime('%Y',sale_date)AS INT)) FROM retail_sales_clean;
--8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT transaction_id,
  SUM(total_sale) as total_sales
FROM retail_sales_clean
GROUP BY transaction_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;
--9. Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category,
  COUNT(DISTINCT transaction_id) AS unique_customers
FROM retail_sales_clean
GROUP BY category;
--10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH shift_sales
AS(
  SELECT*,
  CASE
    WHEN CAST(strftime('%H', sale_time) AS INT) < 12 THEN 'Morning'
    WHEN CAST(strftime('%m', sale_date) AS INT) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift
FROM retail_sales_clean
)
SELECT shift,
  COUNT(*) AS total_orders
FROM shift_sales
GROUP BY shift;