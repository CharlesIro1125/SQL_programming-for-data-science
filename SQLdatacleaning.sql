/* ********* question 1 ********* */
SELECT RIGHT(website,3),count(RIGHT(website,3))
FROM accounts
GROUP BY 1;

/* ********* question 2 ********* */
SELECT LEFT(name,1),count(LEFT(name,1))
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

/* ********* question 3 ********* */
SELECT SUM(english) english,SUM(number) number, SUM(english) + SUM(number) total
FROM ( SELECT CASE WHEN LEFT(name,1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 ELSE 0 END AS number,
CASE WHEN LEFT(name,1) NOT IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 ELSE 0 END AS english
FROM accounts ) sub;

/* ********* question 4 ********* */
SELECT SUM(vowel) vowel,SUM(non_vowel) non_vowel, SUM(vowel) + SUM(non_vowel) total
FROM ( SELECT CASE WHEN LEFT(LOWER(name),1) IN ('a','e','i','o','u') THEN 1 ELSE 0 END AS vowel,
CASE WHEN LEFT(LOWER(name),1) NOT IN ('a','e','i','o','u') THEN 1 ELSE 0 END AS non_vowel
FROM accounts ) sub;

/*
SELECT name,CASE WHEN LEFT(LOWER(name),1) IN ('a','e','i','o','u') THEN 1 ELSE 0 END AS vowel,
CASE WHEN LEFT(LOWER(name),1) NOT IN ('a','e','i','o','u') THEN 1 ELSE 0 END AS non_vowel
FROM accounts
*/






/* ********* question 1 ********* */
SELECT primary_poc,LEFT(primary_poc,POSITION(' ' IN primary_poc) - 1),
RIGHT(primary_poc,LENGTH(primary_poc) - POSITION(' ' IN primary_poc))
FROM accounts ;

/* ********* question 2 ********* */
SELECT name,LEFT(name,POSITION(' ' IN name)),
RIGHT(name,LENGTH(name) - POSITION(' ' IN name) - 1)
FROM sales_reps ;



/* ********* question 1 ********* */
WITH table1 AS (SELECT LEFT(primary_poc,
    POSITION(' ' IN primary_poc) - 1) first_name,
    RIGHT(primary_poc,LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) last_name,
    LOWER(name) Cname
	 FROM accounts)
SELECT first_name||'.'||last_name||'@'|| Cname||'.'||'com' email
FROM table1;


/* ********* question 2 ********* */
WITH table1 AS (SELECT LEFT(primary_poc,
    POSITION(' ' IN primary_poc) - 1) first_name,
    RIGHT(primary_poc,LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) last_name,
    REPLACE(LOWER(name),' ','') Cname
	 FROM accounts)
SELECT first_name||'.'||last_name||'@'|| Cname||'.'||'com' email
FROM table1;


/* ********* question 3 ********* */
WITH table1 AS (SELECT LEFT(LOWER(primary_poc),
    POSITION(' ' IN primary_poc) - 1) first_name,
    RIGHT(LOWER(primary_poc),LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) last_name,
    REPLACE(UPPER(name),' ','') Cname
	  FROM accounts)
SELECT LEFT(first_name,1)||RIGHT(first_name,1)||LEFT(last_name,1)||RIGHT(last_name,1)||LENGTH(first_name)||LENGTH(last_name)||Cname passwords
FROM table1;

/* ********* question 1 ********* */

SELECT * FROM sf_crime_data LIMIT 10;

/* ********* question 3 ********* */

SELECT date FROM sf_crime_data LIMIT 10;


/* ********* question 4 & 5 ********* */
WITH ta AS (SELECT SUBSTR(s.date,1,2) month_val,
    SUBSTR(s.date,4,2) day_val,
    SUBSTR(s.date,7,4) year_val
		FROM sf_crime_data s
    LIMIT 10)

SELECT (year_val||'-'||month_val||'-'||day_val)::date formated_date
FROM ta;


/* ********* question 1 & 2 ********* */

SELECT COALESCE(a.id,a.id) new_id,a.name,a.website,a.lat,a.long,a.primary_poc,a.sales_rep_id,o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/* ********* question 3 ********* */

SELECT COALESCE(a.id,a.id) new_id,a.name,a.website,a.lat,a.long,a.primary_poc,a.sales_rep_id,COALESCE(o.id,a.id),o.account_id,o.occurred_at,o.standard_qty,o.gloss_qty,o.poster_qty,o.total,o.standard_amt_usd,o.gloss_amt_usd,o.poster_amt_usd,o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/* ********* question 4 ********* */

SELECT COALESCE(a.id,a.id) new_id,a.name,a.website,a.lat,a.long,a.primary_poc,a.sales_rep_id,COALESCE(o.id,a.id),o.account_id,o.occurred_at,COALESCE(o.standard_qty,0) standard_qty,COALESCE(o.gloss_qty,0) gloss_qty,COALESCE(o.poster_qty,0)poster_qty,o.total,COALESCE(o.standard_amt_usd,0) standard_amt_usd,COALESCE(o.gloss_amt_usd,0) gloss_amt_usd,COALESCE(o.poster_amt_usd,0) poster_amt_usd,o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/* ********* question 5 ********* */

SELECT count(a.id) acc_id,count(o.id) ord_id
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

/* ********* question 6 ********* */

SELECT COALESCE(a.id,a.id) new_id,a.name,a.website,a.lat,a.long,a.primary_poc,a.sales_rep_id,COALESCE(o.id,a.id),o.account_id,o.occurred_at,COALESCE(o.standard_qty,0) standard_qty,COALESCE(o.gloss_qty,0) gloss_qty,COALESCE(o.poster_qty,0)poster_qty,o.total,COALESCE(o.standard_amt_usd,0) standard_amt_usd,COALESCE(o.gloss_amt_usd,0) gloss_amt_usd,COALESCE(o.poster_amt_usd,0) poster_amt_usd,o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
