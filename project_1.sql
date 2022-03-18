/* ********* question 1 ********* */
WITH ta AS (SELECT f.film_id,f.title,f.rating,fc.category_id,c.name FROM film f
		JOIN film_category fc ON
		f.film_id = fc.film_id
		JOIN category c ON
		fc.category_id = c.category_id),

	tb AS (SELECT r.rental_id,r.inventory_id,i.film_id
		FROM rental r
		JOIN inventory i ON
		r.inventory_id = i.inventory_id),

	tt AS (SELECT * FROM tb
			 JOIN ta ON
			 ta.film_id = tb.film_id)

SELECT DISTINCT(tt.title),tt.name,count(tt.rental_id) OVER (PARTITION BY tt.title) AS rental_count
FROM tt
WHERE tt.name='Animation' OR tt.name='Children' OR tt.name='Comedy'
		OR tt.name='Classics' OR tt.name='Family' OR tt.name='Music'
ORDER BY 2 ;


/* ********* question 2 ********* */
WITH tt AS (SELECT f.film_id,f.title,f.rating,f.rental_duration,fc.category_id,c.name FROM film f
		JOIN film_category fc ON
		f.film_id = fc.film_id
		JOIN category c ON
		fc.category_id = c.category_id)



SELECT tt.title,tt.name,tt.rental_duration, NTILE(4) OVER (ORDER BY tt.rental_duration) AS Standard_quartile
FROM tt
WHERE tt.name='Animation' OR tt.name='Children' OR tt.name='Comedy'
		OR tt.name='Classics' OR tt.name='Family' OR tt.name='Music'
ORDER BY 4;

/* ********* question 3 ********* */
WITH tt AS (SELECT f.film_id,f.title,f.rating,f.rental_duration,fc.category_id,c.name FROM film f
		JOIN film_category fc ON
		f.film_id = fc.film_id
		JOIN category c ON
		fc.category_id = c.category_id)

SELECT g.name,g.Standard_quartile,count(g.Standard_quartile)
FROM (SELECT tt.name,NTILE(4) OVER (ORDER BY tt.rental_duration) AS Standard_quartile,tt.title
		FROM tt
		WHERE tt.name='Animation' OR tt.name='Children' OR tt.name='Comedy'
		OR tt.name='Classics' OR tt.name='Family' OR tt.name='Music'
	 	ORDER BY 2) g
GROUP BY (1,2)
ORDER BY (1);



/* ********* question 4 ********* */
SELECT DATE_PART('month',r.rental_date) Rental_month,DATE_PART('year',r.rental_date) Rental_year,
i.store_id,count(rental_id) Count_rentals
FROM inventory i
JOIN rental r ON
i.inventory_id = r.inventory_id
GROUP BY (1,2,3)
ORDER BY 4 desc;


/* ********* question 5 ********* */
SELECT q.pay_date,q.full_name,SUM(q.amount) monthly_sum,COUNT(q.rental_id) pay_countPerMonth,MAX(q.yearly_sum) yearly_amt
FROM
	(SELECT DATE_TRUNC('month',p.payment_date) pay_date,DATE_TRUNC('year',p.payment_date) pay_yeardate,c.customer_id,
			LEFT(c.first_name,LENGTH(c.first_name))||' '||LEFT(c.last_name,LENGTH(c.last_name)) AS full_name,
			p.amount,p.rental_id,SUM(p.amount) OVER (PARTITION BY LEFT(c.first_name,LENGTH(c.first_name))||' '||LEFT(c.last_name,LENGTH(c.last_name)) ORDER BY DATE_TRUNC('year',p.payment_date)) yearly_sum
			FROM payment p
			JOIN customer c ON
			p.customer_id = c.customer_id
			ORDER BY 4) q
GROUP BY (q.pay_date,q.full_name)
ORDER BY 5 desc
LIMIT 10;
