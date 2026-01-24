-- **3.sales analysis** --

    -- 1.total prodcut sales of each states

SELECT state,
        product_id
        product_name,
        SUM(sales) AS total_sales

FROM sales
GROUP BY state,product_id,product_name
ORDER BY state
;


    -- 2.TOP 5 products sales per each states
    
WITH product_sales AS (
    SELECT
        state,
        product_id,
        product_name,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY state, product_id, product_name
),
ranked_products AS (
    SELECT
        state,
        product_id,
        product_name,
        total_sales,
        DENSE_RANK() OVER (
            PARTITION BY state
            ORDER BY total_sales DESC
        ) AS d_rank
    FROM product_sales
)
SELECT *
FROM ranked_products
WHERE d_rank <= 5
ORDER BY state, d_rank;


    -- 3.which category as sale most of each states

WITH most_sale_category AS (
    SELECT state,
        category,
        SUM(sales) AS sumsale
    FROM sales
    GROUP BY state,category
),
    rows_num AS (
        SELECT state,category,
        ROW_NUMBER() OVER(PARTITION BY state ORDER BY sumsale DESC) AS row_num
    FROM most_sale_category
    
    )
SELECT *
FROM rows_num;


    -- 4.top_5_products sales per each state

WITH city_product_sales AS (
    SELECT
        state,
        city,
        product_id,
        product_name,
        SUM(sales) AS total_sales
    FROM sales
    GROUP BY state, city, product_id, product_name
    ),
    ranked_products AS (
    SELECT
        state,
        city,
        product_id,
        product_name,
        total_sales,
        DENSE_RANK() OVER (
            PARTITION BY state, city
            ORDER BY total_sales DESC
        ) AS d_rank
    FROM city_product_sales
    )


SELECT *
FROM ranked_products
WHERE d_rank <= 5
ORDER BY state, city, d_rank