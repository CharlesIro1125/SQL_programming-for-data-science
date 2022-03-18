SELECT standard_amt_usd,SUM(standard_amt_usd) OVER (ORDER BY occurred_at)
FROM orders;


SELECT occurred_at ,standard_amt_usd,DATE_TRUNC('year',occurred_at) year1,
SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year',occurred_at) ORDER BY occurred_at)
FROM orders;


SELECT id, account_id, total, RANK() OVER (PARTITION BY account_id ORDER BY total DESC) total_rank
FROM orders;


SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS max_std_qty
FROM orders;


/* ******** question 1 ******** */
SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at));



/* ******** question 1 ******** */
SELECT occurred_at,
       total_amt_usd,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd AS lead_difference
FROM (
SELECT occurred_at,
       SUM(total_amt_usd) AS total_amt_usd
  FROM orders
 GROUP BY 1
) sub;


/* ******** question 1 ******** */

SELECT account_id,occurred_at, standard_qty, NTILE(4) OVER (ORDER BY standard_qty) as standard_quartile
FROM orders
ORDER BY account_id DESC;

/* ******** question 2 ******** */

SELECT account_id,occurred_at, gloss_qty, NTILE(2) OVER (ORDER BY gloss_qty) as gloss_half
FROM orders
ORDER BY account_id DESC;

/* ******** question 3 ******** */
SELECT account_id,occurred_at,total_amt_usd, NTILE(100) OVER (ORDER BY total_amt_usd) as total_percentile
FROM orders
ORDER BY account_id DESC;
