-- **Country - city - region analysis** --

    -- 1. No of state

SELECT DISTINCT(country)
FROM sales -- there are only one country : United state
;

    -- 2.Which city as made more sales
    
WITH descending_order_of_sales AS (
    SELECT city, SUM(sales) AS total_sales
    FROM sales
    GROUP BY city ),

    descending AS (
        SELECT *
        FROM descending_order_of_sales
        ORDER BY total_sales DESC
)


SELECT *
FROM descending
;

    -- 3. Which region has made more sales of each state also top 1

WITH region_sales AS (
    SELECT region,state, SUM(sales) AS region_sum_sales
    FROM sales
    GROUP BY region,state
    )

SELECT *
FROM region_sales
ORDER BY region_sum_sales DESC
LIMIT 5
; -- West California 446306.4635 made high sale
    

    --4. overall which region is made more sales

SELECT region ,
        SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC
; -- West was made : 710219.6845 total_sales