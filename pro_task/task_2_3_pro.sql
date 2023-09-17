-- TASK PRO (примечание: задача сформулирована не однозначно!?)
WITH total_products AS (SELECT orderid, SUM(quantity) AS sum_quantity 
                        FROM orderdetails GROUP BY orderid),
table_avg_rating AS (SELECT customerid, AVG(rating) AS avg_rating 
                    FROM productsrewiews GROUP BY customerid)
SELECT cust.customerid,
        firstname,
        lastname,
        SUM(totalamount) OVER(PARTITION BY ord.customerid) AS sum_amounts,
        SUM(sum_quantity) OVER(PARTITION BY tp.customerid) AS sum_quantities, 
        CASE WHEN orderdate > current_date - interval '1 month' THEN orderid ELSE NULL END AS new_orders,
        CASE WHEN orderdate <= current_date - interval '1 month' THEN orderid ELSE NULL END AS old_orders,
        avg_rating
 FROM customers AS cust
JOIN oders AS ord ON cust.customerid = ord.customerid
JOIN total_products AS tp ON ord.orderid = tp.orderid
LEFT JOIN table_avg_rating AS tar ON ord.customerid = tar.customerid
ORDER BY customerid, totalamount DESC
;

