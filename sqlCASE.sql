SELECT a.id,o.total_amt_usd,
CASE WHEN o.total_amt_usd < 3000 THEN 'small' ELSE 'large' END AS level
FROM accounts a
JOIN orders o
ON o.account_id = a.id ;

SELECT
CASE WHEN o.total > 2000 THEN 'above 2000'
WHEN o.total BETWEEN 1000 AND 2000 THEN '1000-2000' WHEN o.total < 1000 THEN 'below 1000' END AS level,count(a.id)
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2;

SELECT a.name,SUM(o.total_amt_usd),
CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'over 200,000'
WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN '100,000-200,000' WHEN SUM(o.total_amt_usd) < 100000 THEN 'under 100,000' END AS level
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;

SELECT a.name,SUM(o.total_amt_usd),
CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'over 200,000'
WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN '100,000-200,000' WHEN SUM(o.total_amt_usd) < 100000 THEN 'under 100,000' END AS level
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY 1
ORDER BY 2 DESC;


SELECT s.name, count(o.id),CASE WHEN count(o.id) > 200 THEN 'top' ELSE 'not' END AS level
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 3 DESC;

SELECT s.name, count(o.id),SUM(o.total_amt_usd),CASE WHEN count(o.id) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top' WHEN count(o.id) BETWEEN 150 AND 200 OR SUM(o.total_amt_usd) BETWEEN 500000 AND 750000 THEN 'middle' ELSE 'not' END AS level
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
ORDER BY 3 DESC;
