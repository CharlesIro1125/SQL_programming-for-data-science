SELECT r.name region,s.name sale_rep,SUM(o.total_amt_usd)
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id =s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON s.region_id =r.id
GROUP BY 1,2
HAVING SUM(o.total_amt_usd) IN
	(SELECT MAX(sub.sum_total)
	FROM
		(SELECT r.name region_name,s.name 							sale_rep,SUM(o.total_amt_usd) 					sum_total
		FROM accounts a
		JOIN sales_reps s
		ON a.sales_rep_id =s.id
		JOIN orders o
		ON o.account_id = a.id
		JOIN region r
		ON s.region_id =r.id
		GROUP BY 1,2
		ORDER BY 3) sub
 	GROUP BY sub.region_name);


SELECT r.name,count(o.total) total_count
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id =s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON s.region_id =r.id
GROUP BY 1
HAVING SUM(o.total_amt_usd) =
	(SELECT r_sum_total_usd
	FROM
		(SELECT s.region_id,SUM(o.total_amt_usd) 			r_sum_total_usd
		FROM accounts a
		JOIN sales_reps s
		ON a.sales_rep_id =s.id
		JOIN orders o
		ON o.account_id = a.id
		GROUP BY s.region_id
		ORDER BY 2 DESC LIMIT 1) as sub);


SELECT count(*)
FROM
	(SELECT a.name,SUM(o.total)
	FROM accounts a
	JOIN orders o
	ON o.account_id =a.id
	GROUP BY 1
	HAVING SUM(o.total) >
		(SELECT total_std
	 	FROM (SELECT a.name accname,
           SUM(o.standard_qty) std,
           SUM(o.total) total_std
		   FROM accounts a
		   JOIN orders o
		   ON o.account_id =a.id
           GROUP BY 1
           ORDER BY 2 DESC LIMIT 1) sub1)
     )
 as sub2 ;

SELECT a.name,w.channel,count(w.id) events
FROM accounts a
JOIN web_events w
ON w.account_id =a.id
WHERE a.id =
	(SELECT c_id
	FROM
		(SELECT a.id c_id,a.name 						 c_name,SUM(o.total_amt_usd) total_usd
		 FROM accounts a
		 JOIN orders o
		 ON o.account_id =a.id
		 GROUP BY 1,2
		 ORDER BY 3 DESC LIMIT 1) as sub1
    )
GROUP BY 1,2;

SELECT AVG(c_sum)
FROM
	(SELECT a.id c_id,a.name 						 c_name,SUM(o.total_amt_usd) c_sum
	 FROM accounts a
	 JOIN orders o
	 ON o.account_id =a.id
	 GROUP BY 1,2
	 ORDER BY 3 DESC LIMIT 10) as sub;

SELECT AVG(c_avg)
FROM
	(SELECT a.id c_id,a.name 						 c_name,AVG(o.total_amt_usd) c_avg,
     count(o.id)
	 FROM accounts a
	 JOIN orders o
	 ON o.account_id =a.id
	 GROUP BY 1,2
	 HAVING AVG(o.total_amt_usd) >
			(SELECT AVG(o.total_amt_usd)
		 	FROM accounts a
		 	JOIN orders o
		 	ON o.account_id =a.id)
	 ORDER BY 3) as sub;
