CREATE VIEW sakila.rental_information_for_each_customer AS (
SELECT c.customer_id, c.first_name, c.email, COUNT(rental_id)
FROM sakila.customer as c
JOIN sakila.rental as r
ON c.customer_id = r.customer_id
);

SELECT * FROM rental_information_for_each_customer;

 
CREATE TEMPORARY TABLE total_amount_paid_by_each_customer AS (
  SELECT SUM(amount) AS total_amount, first_name
  FROM sakila.rental_information_for_each_customer as rif
  JOIN sakila.rental_information_for_each_customer as rif
  ON p.customer_id = rif.customer_id
  );
  
SELECT * from total_amount_paid_by_each_customer;

-- Step 1: Create the CTE

WITH customer_summary AS (
	SELECT first_name,email,COUNT(rental_id),tap.SUM(amount)
	FROM sakila.rental_information_for_each_customer as rif
	JOIN sakila.total_amount_paid_by_each_customer as tap
	ON rif.customer_id = tap.customer_id
);

-- Step 2: Generate the customer summary report
SELECT
  first_name,
  email,
  COUNT(rental_id),
  SUM(amount),
  SUM(amount) / COUNT(rental_id) AS average_payment_per_rental
FROM customer_summary;



