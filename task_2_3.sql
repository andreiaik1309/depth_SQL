-- TASK 1
WITH sum_amounts AS (SELECT customerid, sum(totalamount) AS total_amounts FROM Orders
GROUP BY customerid)
SELECT firstname, lastname FROM Customers 
WHERE customerid IN (SELECT customerid FROM sum_amounts 
                WHERE total_amounts = (SELECT MAX(totalamounts) FROM
                sum_amounts));

-- TASK 2
WITH sum_amounts AS (SELECT customerid, sum(totalamount) AS total_amounts FROM Orders
GROUP BY customerid),
customerid_max_amount AS (
SELECT firstname, lastname, customerid FROM Customers 
WHERE customerid IN (SELECT customerid FROM sum_amounts 
                WHERE total_amounts = (SELECT MAX(total_amounts) FROM
                sum_amounts))
)
SELECT firstname, lastname, orderid, totalamount FROM customerid_max_amount AS cma 
LEFT JOIN Orders as ord on cma.customerid = ord.customerid
ORDER BY ord.orderid, totalamount DESC;

--TASK 3
WITH sum_amounts AS (SELECT customerid, sum(totalamount) AS total_amounts FROM Orders
GROUP BY customerid)
SELECT firstname, lastname FROM Customers 
WHERE customerid IN (SELECT customerid FROM sum_amounts 
                WHERE total_amounts > (SELECT AVG(total_amounts) FROM
                sum_amounts));








