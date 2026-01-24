-- **product analysis**

    -- 1.demand product

SELECT SUM(sales) AS total_amount,
        category,
        sub_category,
        product_name
FROM sales
GROUP BY (category,sub_category,product_name)
ORDER BY total_amount DESC
LIMIT 1
; -- Canon imageCLASS 2200 Advanced Copier as most demand product



    --2.total number of category 

SELECT (COUNT(DISTINCT(category))) AS no_category
FROM sales
; -- there are 3 three sub_category



    --3. Top-3 most ordered product from customers

SELECT COUNT(product_id) AS pro_cnt,
            product_id,
            product_name
FROM sales
GROUP BY product_id,product_name
ORDER BY pro_cnt DESC
; -- Logitech 910-002974 M325 Wireless Mouse for Web Scrolling has high orders



    --4.state vise product sales counts + product names

WITH state_sales AS ( 
    SELECT COUNT(product_name) AS cnt,product_name,
            state
    FROM sales
    GROUP BY state,product_name
)

SELECT *
FROM state_sales
ORDER BY cnt DESC
;


    -- 5.products demand each state

WITH product_demand AS (
    SELECT
        state,
        product_id,
        product_name,
        SUM(sales) AS total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY state
            ORDER BY SUM(sales) DESC
        ) AS row_num
    FROM sales
    GROUP BY state, product_id, product_name
)


SELECT *
FROM product_demand
WHERE row_num = 1
ORDER BY state
;


    --6. Number of products 

WITH no_products AS (
    SELECT SPLIT_PART(product_name, ' ',1) AS before_space
    FROM sales
    ),
    count_pro AS (
        SELECT  before_space,
        COUNT(before_space) AS pro_cnt
        FROM no_products
        GROUP BY before_space
    )

SELECT COUNT(pro_cnt) AS total
FROM count_pro; -- There are 501 products have in this data set 



    -- 7. which category is sale more
    
SELECT category,
        COUNT(category) AS c_count
FROM sales
GROUP BY category; -- Office Supplies as have 5909 sales in overall