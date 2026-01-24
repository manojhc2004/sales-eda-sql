-- over view of dataset

SELECT *
FROM sales
LIMIT 10
;

-- **customer analysis**
----------------------------------------------

    -- 1.total number of customers 

WITH total_customer AS (
    SELECT DISTINCT(customer_id) AS cus_cnt
    FROM sales
    )

SELECT COUNT(*) AS total
FROM total_customer 
; -- there are 793 customers 



       --2. which state as have more customers

SELECT COUNT(DISTINCT(customer_id)) AS cnt,
        state
FROM sales
GROUP BY(state)
ORDER BY cnt DESC
; -- California as have high customers


       --3. total number of orders in each state

SELECT COUNT(DISTINCT(order_id)) AS o_cnt,
        state
FROM sales
GROUP BY(state)
ORDER BY o_cnt DESC 
;

      --4.which city as high cutomers 

SELECT COUNT(DISTINCT(customer_id)) AS cus_cnt,
        city,state
FROM sales
GROUP BY city,state
ORDER BY cus_cnt DESC
; -- new york state ,new york city as high customers