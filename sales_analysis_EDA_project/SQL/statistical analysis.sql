-- **6 statsitical analysis

    -- 1.Maximum sales from data
SELECT MAX(sales)
FROM sales; -- 22638.48

    -- 2. Minimum sales from data
SELECT MIN(sales)
FROM sales
; -- 0.444


    --3.Average sales by in each state

SELECT state,
        ROUND(AVG(sales),0) AS average
FROM sales
GROUP BY state
;

    -- 4.Top 5 states by average sales

WITH average_sale AS (
    SELECT state,
            ROUND(AVG(sales),0) AS average
    FROM sales
    GROUP BY state

    ),
    order_by_sale AS (
        SELECT *
        FROM average_sale
        ORDER BY average DESC
    )

SELECT *
FROM order_by_sale
LIMIT 5
; -- this query show's which top 5 state as having high marketing sales 


    -- 5.Top 5 states with the lowest average sales

WITH low_average AS (
    SELECT state,
            ROUND(AVG(sales),0) AS average
    FROM sales
    GROUP BY state
    ),
    order_by_asc AS (
        SELECT *
        FROM low_average
        ORDER BY average ASC
    )

SELECT *
FROM order_by_asc
LIMIT 5
;


    -- 6. Average sales by in each region
WITH region_avg_sales AS (
    SELECT region,
            ROUND(AVG(sales),0) AS avg_sales
    FROM sales
    GROUP BY region
),
order_by_desc AS(
    SELECT *
    FROM region_avg_sales
    ORDER BY avg_sales DESC
)

SELECT *
FROM order_by_desc
; -- Highest Average Sales by Region: South