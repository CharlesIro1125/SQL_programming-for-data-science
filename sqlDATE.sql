SELECT DATE_PART('year',occurred_at),SUM(total_amt_usd) total
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT DATE_PART('month',occurred_at),SUM(total_amt_usd) total
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT DATE_PART('year',occurred_at),SUM(total) total
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT DATE_PART('month',occurred_at),SUM(total) total
FROM orders
GROUP BY 1
ORDER BY 2 DESC;
