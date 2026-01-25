--  ***Order date , ship data analysis***


    -- 1.more days taken product to ship

WITH days_to_ship AS (
    SELECT product_name,
            order_date,
            ship_date,
            (ship_date) - (order_date) AS taken
    FROM sales
)

SELECT *
FROM days_to_ship
ORDER BY taken DESC
; -- this query show's which product as taken more days to ship


    -- 2.how many days taken to ship in every state

WITH state_days_to_ship AS (
    SELECT state,product_name, 
            order_date,
            ship_date,
            (ship_date) - (order_date) AS days_taken

    FROM sales
    GROUP BY state,product_name, order_date,
            ship_date
    )

SELECT state,product_name,days_taken,
    ROW_NUMBER() OVER(PARTITION BY state ORDER BY days_taken DESC) AS state_vise
FROM state_days_to_ship
; --! this query shows products taken to days from order_date to ship date and days are DESC high - to - low ,because we need to take action from which product as taken more days to ship,and actually we need to reduce's "Ship date"


    -- 3.The maximum days taken by products
-- !this query is inherit from --2. query

WITH maximum AS (
    SELECT product_name,
            ship_date - order_date AS diff
    FROM sales
    ),
    get_maximum AS (
        SELECT MAX(diff) AS max_num
        FROM maximum -- identifies the maximum number 
    )

SELECT *
FROM maximum
WHERE diff = 7
; -- This query show's which have product taken "Maximum Days" to ship or to reach


    -- 4.Which top 12 products is more occure in --3.query ,max() = 7 days taken to ship

WITH maximum AS (
    SELECT product_name,
            ship_date - order_date AS diff
    FROM sales
    ),
    maximum_days_taken AS (
        SELECT *
        FROM maximum
        WHERE diff = 7
    ),
    split AS (
        SELECT SPLIT_PART(product_name, ' ',1) AS before_space -- ! because some same products as new versions names and numbers or code so iam just split starting product name to count.
        FROM maximum_days_taken
    )

SELECT before_space,
       COUNT(before_space) AS p_cnt
FROM split
GROUP BY before_space
ORDER BY p_cnt DESC
LIMIT 12 -- xerox product is top 1 product which take maximum days to ship
;


    -- 5. Count the numbers of ship mode

SELECT ship_mode,
        COUNT(ship_mode) AS cnt 
FROM sales
GROUP BY ship_mode
ORDER BY cnt DESC -- Standard Class is used to more ship (this top 1)
;


    -- 6.State vise row_number() order by Count(ship_mode) Decending
WITH ship_mode_order AS (

    SELECT DISTINCT state,ship_mode,
            COUNT(ship_mode) OVER(PARTITION BY state,ship_mode) AS ship_mode_count
    FROM sales
    ORDER BY state
    
    ),
    row_nums AS (
    SELECT state,ship_mode,ship_mode_count,
            ROW_NUMBER() OVER(PARTITION BY state ORDER BY ship_mode_count DESC) AS row_num
    FROM ship_mode_order
    )
SELECT *
FROM row_nums
WHERE row_num = 1
ORDER BY ship_mode_count DESC
;
    -- 7.Check which state has more Standard Class

-- !inheritance form -- 6.query (ship_mode_order)

SELECT state,ship_mode,ship_mode_count
FROM row_num
WHERE ship_mode_count = 1129
; -- California has have 1125 with Standard ship_mode , this show california uses more standard ship_mode to delilvery the products to the customers or client or sales

