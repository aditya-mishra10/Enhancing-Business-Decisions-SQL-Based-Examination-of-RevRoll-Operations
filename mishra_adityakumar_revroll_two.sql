/*
Question #1:

Write a query to find the customer(s) with the most orders. 
Return only the preferred name.

Expected column names: preferred_name
*/

-- q1 solution:

SELECT preferred_name
FROM customers AS cus 
INNER JOIN (
    SELECT customer_id, COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) = (
        SELECT MAX(order_count)
        FROM (
            SELECT COUNT(*) AS order_count
            FROM orders
            GROUP BY customer_id
        ) AS max_orders
    )
) AS max_customer_orders ON cus.customer_id = max_customer_orders.customer_id;



/*
Question #2: 
RevRoll does not install every part that is purchased. 
Some customers prefer to install parts themselves. 
This is a valuable line of business 
RevRoll wants to encourage by finding valuable self-install customers and sending them offers.

Return the customer_id and preferred name of customers 
who have made at least $2000 of purchases in parts that RevRoll did not install. 

Expected column names: customer_id, preferred_name

*/

-- q2 solution:

SELECT
cus.customer_id,
cus.preferred_name
FROM customers AS cus
INNER JOIN orders AS o ON cus.customer_id = o.customer_id
INNER JOIN parts AS pt ON o.part_id = pt.part_id 
LEFT JOIN installs AS i ON o.order_id = i.order_id
WHERE i.install_id IS NULL --Parts not installed by revroll
GROUP BY cus.customer_id, cus.preferred_name
HAVING SUM(pt.price * o.quantity) >= 2000; --least $2000 of purchases in parts


/*
Question #3: 
Report the id and preferred name of customers who bought an Oil Filter and Engine Oil 
but did not buy an Air Filter since we want to recommend these customers buy an Air Filter.
Return the result table ordered by `customer_id`.

Expected column names: customer_id, preferred_name

*/

-- q3 solution:

SELECT DISTINCT
cus.customer_id,
cus.preferred_name
FROM customers AS cus
INNER JOIN orders AS o1 ON cus.customer_id = o1.customer_id
INNER JOIN orders AS o2 ON cus.customer_id = o2.customer_id
LEFT JOIN orders AS o3 ON cus.customer_id = o3.customer_id AND o3.part_id IN (SELECT part_id FROM parts WHERE name = 'Air Filter')
WHERE o1.part_id IN (SELECT part_id FROM parts WHERE name = 'Oil Filter')
  AND o2.part_id IN (SELECT part_id FROM parts WHERE name = 'Engine Oil')
  AND o3.part_id IS NULL
ORDER BY cus.customer_id;

/*
Question #4: 

Write a solution to calculate the cumulative part summary for every part that 
the RevRoll team has installed.

The cumulative part summary for an part can be calculated as follows:

- For each month that the part was installed, 
sum up the price*quantity in **that month** and the **previous two months**. 
This is the **3-month sum** for that month. 
If a part was not installed in previous months, 
the effective price*quantity for those months is 0.
- Do **not** include the 3-month sum for the **most recent month** that the part was installed.
- Do **not** include the 3-month sum for any month the part was not installed.

Return the result table ordered by `part_id` in ascending order. In case of a tie, order it by `month` in descending order. Limit the output to the first 10 rows.

Expected column names: part_id, month, part_summary
*/

-- q4 solution:

WITH summary_part_id AS (
SELECT 
	DATE_PART('month',install_date) AS month,
	pt.part_id,
	SUM(price * quantity) AS summary
FROM 
	orders AS o
INNER JOIN 
	installs AS i
ON o.order_id = i.order_id
INNER JOIN
	parts AS pt
ON o.part_id = pt.part_id
GROUP BY month, pt.part_id),
recent_month AS (
SELECT
  part_id,
  MAX(month) as recent_month
 FROM summary_part_id
	GROUP BY part_id),
month_3_summary AS (
SELECT
  sum_pt_1.part_id,
	sum_pt_1.month,
	SUM(sum_pt_2.summary) AS part_summary
FROM  summary_part_id AS sum_pt_1
LEFT JOIN summary_part_id AS sum_pt_2
	ON sum_pt_1.part_id = sum_pt_2.part_id
	AND sum_pt_2.month BETWEEN (sum_pt_1.month-2) AND sum_pt_1.month
GROUP BY sum_pt_1.month,sum_pt_1.part_id
ORDER BY sum_pt_1.part_id, sum_pt_1.month DESC)
SELECT m3s.*
FROM month_3_summary AS m3s
LEFT JOIN recent_month AS rm
ON m3s.part_id = rm.part_id
WHERE rm.recent_month <> m3s.month
LIMIT 10; 









