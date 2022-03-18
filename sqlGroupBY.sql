SELECT a.name,o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY o.occurred_at DESC LIMIT 1;

SELECT a.name,SUM(o.total_amt_usd) total_sum
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY total_sum DESC;

SELECT a.name,w.occurred_at,w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at DESC;

SELECT channel,count(channel) channel_usage
FROM web_events w
GROUP BY channel
ORDER BY channel_usage DESC;

SELECT a.name,w.occurred_at,a.primary_poc
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at DESC;

SELECT a.name,MIN(o.total_amt_usd) min_amount
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY min_amount;

SELECT r.name,count(s.id) number_of_sales_rep
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY number_of_sales_rep;
