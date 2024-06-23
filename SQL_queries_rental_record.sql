/* You are hire by an online Movie Rental Shop as a data analyst in the company to analyse and generate 
an insight from the company data and to solve the company problem.

*/

--Question: Select all columns in the payment table for perusal
--The statement select all columns from payment table
SELECT 
	*
FROM
	payment;
	
/* Your first day as a Data Analyst has started!
 The Marketing Manager asks you for a list of all customers. 
With first name, last name and the customer's email address     */
SELECT
	first_name, last_name, email
FROM
	customer;

/* You need to help the Marketing team to work more easily.
 The Marketing Manager asks you to order the customer list by the last name.
 They want to start from "Z" and work towards "A".
 In case of the same last name the order should be based on the first name - also "Z" to "A".      */
SELECT
	*
FROM 
	customer
ORDER BY 
	last_name DESC, first_name DESC;

/* A marketing team member asks you about the 
different prices that have been paid.
 To make it easier for them order the prices from 
high to low.
 Write a SQL query to get the different prices    */
SELECT 
 	DISTINCT amount
FROM
	payment
ORDER BY 
	amount DESC;

-- Create a list of all the distinct districts customers are from.
SELECT
	DISTINCT district
FROM
	address;

-- What is the latest rental date?
SELECT
	rental_date
FROM
	rental
ORDER BY 
	rental_date DESC;
	
-- How many films does the company have?
SELECT
	COUNT(title) "Total Number of Films"
FROM
	film;

-- How many distinct last names of the customers are there?
SELECT
	COUNT (DISTINCT last_name) "Number of Unique Last Names"
FROM
	customer;


/* How many payment were made by the customer
 with customer_id = 100?    */
SELECT 
	COUNT(amount) "Number of Payment by Cutomer 100"
FROM
	payment
WHERE customer_id =100;
 
/* What is the last name of our customer with 
first name 'Erica'      */
SELECT 
	
	first_name,
	last_name
FROM
	customer
WHERE
	first_name = 'Erica';

--The inventory manager asks you how rentals have not been returned yet ( return_date is null).
SELECT
	COUNT(*) "Number of rentals yet to be return"
FROM
	rental
WHERE return_date is null;
	
/* The sales manager asks you for a list of all the payment_ids with an amount less than or equal to 
   £2. including payment_id and the amount.    */
SELECT
	payment_id,
	amount
FROM
	payment
WHERE	amount <= 2;

/*   The support manager asks you about a list of all the payment of 
the customer 322, 346 and 354 where the amount is either less 
than $2 or greater than $10.       

 It should be ordered by the customer first  (ascending) and then 
as second condition order by amount in a descending order    */
SELECT 
	*
FROM
	payment
WHERE customer_id IN (322,346,354) AND (amount < 2 OR amount > 10)
ORDER BY 
	customer_id ASC, amount DESC;

/*There have been some faulty payments and you need to help to 
found out how many payments have been affected.
 
 How many payments have been made on January 29th and 30th
 2007 (including entire 29th) with an amount between 1.99 and 3.99?         */
SELECT
	*,
	DATE(payment_date)
FROM
	payment
WHERE DATE(payment_date) BETWEEN '2007-04-29' AND '2007-04-30'
AND amount BETWEEN 1.99 AND 3.99;

/* There have been 6 complaints of customers about their payments. 
   customer_id: 12,25,67,93,124,234
 The concerned payments are all the payments of these 
customers with amounts 4.99, 7.99 and 9.99  in January 2020      */
SELECT
	 *,
	 DATE(payment_date)
FROM
	payment
WHERE customer_id IN (12,25,67,93,124,234)
AND amount IN (4.99,7.99,9.99)
AND DATE(payment_date) BETWEEN '2007-04-01' AND  '2007-04-30';

/* You need to help the inventory manager to find out:
 How many movies are there that contain the "Documentary" in 
the description      */
SELECT
	COUNT(*)
FROM
	film
WHERE description LIKE '%Documentary%';
	
/* How many customers are there with a first name that is 
    3 letters long and either an 'x' or a 'y' as the last letter in the last name        */
SELECT
	COUNT(*)
FROM
	customer
WHERE first_name LIKE '___' AND (last_name LIKE '%x' OR last_name LIKE '%y');

/* How many movies are there that contain 'Saga' 
 in the description and where the title starts either 
 with 'A' or ends with 'R'?
 Use the alias 'no_of_movies'.                */
SELECT
	COUNT(*) no_of_movies
FROM
	film
WHERE description LIKE '%Saga%' AND (title LIKE 'A%' OR title LIKE '%r');
 
/* Create a list of all customers where the first name contains 
'ER' and has an 'A' as the second letter.
 Order the results by the last name descendingly.           */
SELECT
	*
FROM	
	customer
WHERE first_name LIKE '%er%' AND first_name LIKE '_a%'
ORDER BY last_name DESC;

/* How many payments are there where the amount is either 0 
or is between 3.99 and 7.99 and in the same time has 
happened on 2020-05-01                                       */
SELECT
	*
FROM
	payment
WHERE amount = 0 OR (amount BETWEEN 3.99 AND 7.99) AND (payment_date ='2007-03-01');

/* Your manager wants to get a better understanding of the films. 
   That's why you are asked to write a query to see the
 • Minimum
 • Maximum
 • Average (rounded)
 • Sum
 of the replacement cost of the films                        */
SELECT
	MIN(replacement_cost),
	MAX(replacement_cost),
	ROUND(AVG(replacement_cost),2) AS AVG,
	SUM(replacement_cost)
FROM
	film;
	
/* Your manager wants to which of the two employees (staff_id) is responsible for more payments?
   Which of the two is responsible for a higher overall payment amount?
   How do these amounts change if we don't consider amounts equal to 0          */
SELECT
	staff_id,
	SUM(amount),
	COUNT(amount)
FROM
	payment
WHERE amount != 0
GROUP BY staff_id
ORDER BY staff_id DESC;

/* There are two competitions between the two employees.
   Which employee had the highest sales amount in a single day?
   Which employee had the most sales in a single day (not 
   counting payments with amount = 0                                              */
SELECT
	staff_id,
	SUM(amount),
	COUNT(*),
	DATE(payment_date)
FROM
	payment
GROUP BY DATE(payment_date), staff_id 
HAVING SUM(amount) !=0
ORDER BY SUM(amount) DESC;

/* In 2007, April 28, 29 and 30 were days with very high revenue. 
 That's why we want to focus in this task only on these days (filter accordingly).
 Find out what is the average payment amount grouped by 
 customer and day– consider only the days/customers with more than 1 payment (per customer and day). 
 Order by the average amount in a descending order.
*/
SELECT
	customer_id,
	DATE(payment_date),
	ROUND(AVG(amount),2) AVG,
	COUNT(*)
FROM
	payment
WHERE DATE(payment_date) IN ('2007-04-28','2007-04-29','2007-04-30')
GROUP BY customer_id, DATE(payment_date) 
HAVING COUNT(*) > 1
ORDER BY AVG(amount)DESC;
	
/* In the email system there was a problem with names where 
either the first name or the last name is more than 10 characters 
long.
 Find these customers and output the list of these first and last 
names in all lower case                                     
*/
SELECT
	LOWER(first_name),
	LOWER(last_name),
	LENGTH(first_name),
	LENGTH(last_name),
	email
FROM
	customer
WHERE LENGTH(first_name) > 10 OR LENGTH(last_name) > 10;
	
/* Extract the last 5 characters of the email address first.
 The email address always ends with '.org'.  How can you extract just the dot '.' from the email address? 	
*/
SELECT
	RIGHT(email,5),
	LEFT(RIGHT(email,4),1)	
FROM
	customer;

/* You need to create an anonymized form of the email addresses
 in the following way: example m***@sakilacustomer.org
*/	
SELECT
	first_name, last_name, email,
	LEFT(email,1),
	RIGHT(email,19),
	LEFT(email,1) || '***' || RIGHT(email,19) AS anonymised_email
FROM
	customer;
	
/* In this challenge you have only the email address and the last name of the customers.
   You need to extract the first name from the email address and concatenate it with the last name. 
   It should be  in the form: "Last name, First name"
*/
SELECT 
	email,last_name,
	LEFT(email,POSITION('.' IN email) - 1) firstName,
	LEFT(email,POSITION('.' IN email) - 1) || ' ' || last_name
FROM
	customer;
	
/* You need to create an anonymized form of the email addresses
 in the following way: example m***.s***@sakilacustomer.org
*/	
SELECT
	first_name, last_name, email,
	LEFT(email,1),
	RIGHT(email,19),
	LEFT(email,1) || '***' || '.' || SUBSTRING(email FROM POSITION('.' IN email) + 1 FOR 1) || '***' ||
	RIGHT(email,19) AS anonymized_email
	
FROM
	customer;

/* In a second query create an anonymized form of the email addresses in the following way: 
example ***a.j***@sakilacustomer.org
*/
SELECT
	first_name, last_name, email,
	RIGHT(email,19),
	'***' || SUBSTRING(email FROM POSITION('.' IN email) - 1 FOR 1) || '.' ||
	SUBSTRING(email FROM POSITION('.' IN email) + 1 FOR 1) || '***' || RIGHT(email,19) AS anonymized_email
FROM
	customer;
	
SELECT
	EXTRACT(DAY from rental_date)  day_of_the_month,
	EXTRACT(month from rental_date) month_of_the_year,
	EXTRACT(year from rental_date) calendar_year,
	EXTRACT(second from rental_date) second_in_time
FROM
	rental;

/* In which day of the month do we have most sales?
How many rentals do we have every single month and what hours of the days we have the most rentals */
SELECT
	EXTRACT(day from rental_date) days_of_the_month,
	EXTRACT(month from rental_date) each_month,
	EXTRACT(year from rental_date) each_year,
	DATE(rental_date),
	COUNT(*)
FROM
	rental
GROUP BY EXTRACT(month from rental_date),EXTRACT(day from rental_date),EXTRACT(year from rental_date), 
				DATE(rental_date)
ORDER BY COUNT(*) DESC

/* You need to analyze the payments and find out the following:
 ▪ What's the month with the highest total payment amount?
*/
SELECT
	EXTRACT(month from payment_date) each_month,
	SUM(amount) AS sum_of_amount_for_each_month,
	COUNT(*)
FROM
	payment
GROUP BY EXTRACT(month from payment_date)
ORDER BY COUNT(*) DESC

/* You need to analyze the payments and find out the following:
 ▪ What's the day of week with the highest total payment amount?  (0 is Sunday)
*/
SELECT
	EXTRACT(DOW from payment_date) day_of_the_week,
	SUM(amount) AS sum_of_amount_for_each_month,
	COUNT(*)
FROM
	payment
GROUP BY EXTRACT(DOW from payment_date)
ORDER BY SUM(amount) DESC
	
/* You need to analyze the payments and find out the following:
 ▪ What's the highest amount one customer has spent in a week
*/
SELECT
	customer_id,
	EXTRACT(week from payment_date) week,
	SUM(amount) AS sum_of_amount_for_each_month,
	COUNT(*)
FROM
	payment
GROUP BY EXTRACT(week from payment_date), customer_id
ORDER BY SUM(amount) DESC;

/* You need to sum payments and group in the following formats :
 * day
 * month and the year
 * week day and time
 */
SELECT	
	SUM(amount),
	TO_CHAR(payment_date, 'Dy, dd/mm/yyyy') AS grouping_by_day,
	TO_CHAR(payment_date, ' Mon,yyyy') AS grouping_by_month_year,
	TO_CHAR(payment_date, 'Day, HH24:MI') AS grouping_by_WeekDay_time
FROM
	payment
GROUP BY TO_CHAR(payment_date, 'Dy, dd/mm/yyyy'),TO_CHAR(payment_date, ' Mon,yyyy'),
		 TO_CHAR(payment_date, 'Day, HH24:MI');
	
/* You need to create a list for the support team of all rental durations of customer with customer_id 35.
*/
SELECT
	customer_id,
	return_date - rental_date AS rental_duration
FROM
	rental
WHERE customer_id = 35;

/*Also you need to find out for the support team which customer has the longest average rental duration?
*/
SELECT
	customer_id,
	AVG(return_date - rental_date) AS rental_duration
FROM
	rental
WHERE customer_id = 35
GROUP BY customer_id
ORDER BY rental_duration DESC;

/* Your manager is thinking about increasing the prices for films that are more expensive to replace.
 For that reason, you should create a list of the films including the relation of rental rate / replacement
 cost where the rental rate is less than 4% of the replacement cost    
 * Create a list of that film_ids together with the percentage roundedto 2 decimal places. For example 3.54 (=3.54%).
 */
SELECT
 	film_id,
	ROUND(rental_rate / replacement_cost * 100,2) AS percentage
FROM film
WHERE ROUND(rental_rate / replacement_cost * 100,2) < 4
ORDER BY ROUND(rental_rate / replacement_cost * 100,2) ASC;

SELECT
amount,
CASE
	WHEN amount < 2 THEN 'low amount'
 	WHEN amount < 5 THEN 'medium amount'
 	ELSE 'high amount'
END
FROM payment;

/* You want to create a tier list in the following way:
   1. Rating is 'PG' or 'PG-13' or length is more then 210 min: 'Great rating or long (tier 1)
   2. Description contains 'Drama' and length is more than 90min: 'Long drama (tier 2)'
   3. Description contains 'Drama' and length is not more than 90min: 'Short drama (tier 3)'
   4. Rental_rate less than $1: 'Very cheap (tier 4)'
  If one movie can be in multiple categories it gets the higher tier assigned.
  How can you filter to only those movies that appear in one of these 4 tiers?
 */
SELECT
title,
CASE
	WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
	WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
	WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
	WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END as tier_list
FROM film
WHERE 
CASE
	WHEN rating IN ('PG','PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
	WHEN description LIKE '%Drama%' AND length>90 THEN 'Long drama (tier 2)'
	WHEN description LIKE '%Drama%' THEN 'Short drama (tier 3)'
	WHEN rental_rate<1 THEN 'Very cheap (tier 4)'
END is not null; 

SELECT
	rating,
CASE
	WHEN rating IN ('PG','G') THEN 1
	ELSE 0
END
FROM film

--count the sum of g and pg
SELECT
SUM(CASE
	WHEN rating IN ('PG','G') THEN 1
	ELSE 0
END) AS no_of_rating_g_or_pg
FROM film;

--count of each category of the rating
SELECT
	rating,
	COUNT(*)
FROM
	film
GROUP BY rating	;

--the above can also be solve this way
SELECT
	SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS "G",
	SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS "R",
	SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS "NC-17",
	SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS "PG-13",
	SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS "PG"
FROM
	film;
	

--Replace the null values in the return_date column with the value 'not return' BY
--using coalesce() and cast()
SELECT
	COALESCE(CAST(return_date AS VARCHAR),'not return')
FROM
	rental
WHERE return_date is null;

/*	The company wants to run a phone call campaing on all customers in Texas (=district).
 	What are the customers (first_name, last_name, phone number and their district) from Texas?
*/	
SELECT
	first_name, last_name, phone, district
FROM
	customer c LEFT JOIN address a
	ON c.address_id = a.address_id
WHERE district = 'Texas'

/* Are there any (old) addresses that are not related to any customer? */
SELECT
	*
FROM
	address a LEFT JOIN customer c
	ON a.address_id = c.address_id
WHERE c.customer_id is null
	
/* The company wants customize their campaigns to customers depending on the country they are from.
 	Which customers are from Brazil?
 	Write a query to get first_name, last_name, email and the country from all 
	customers from Brazil.
*/
SELECT
	first_name,
	last_name,
	email,
	co.country
FROM customer cu
LEFT JOIN address ad
ON cu.address_id = ad.address_id
LEFT JOIN city ci
ON ci.city_id = ad.city_id
LEFT JOIN country co
ON co.country_id = ci.country_id
WHERE country = 'Brazil';

	
SELECT first_name FROM actor
UNION ALL
SELECT first_name FROM customer
ORDER BY first_name;

/* Return all the films that are available in the inventory in store 2 more than 3 times. */
SELECT * FROM film
WHERE film_id IN
			(SELECT film_id FROM inventory
				WHERE store_id = 2
				GROUP BY film_id	
						HAVING COUNT(*) > 3)
						
/* Return all customers' first names and last names that have made a payment on '2007-02-21' */
SELECT 
	first_name,
	last_name
FROM
	customer
WHERE customer_id IN (SELECT customer_id
					 FROM payment
					 WHERE DATE(payment_date) = '2007-02-21');
					 
/* Return all customers' first_names and email addresses that have spent more than $30   */
SELECT 
	first_name,
	email
FROM
	customer
WHERE customer_id IN (SELECT customer_id
					 FROM payment
					  GROUP BY customer_id
					  HAVING SUM(amount) > 30);
					  
/* Return all the  customers' first names and last names that are from California and have 
	spent more than 100 in total.
*/
SELECT 
	first_name,
	email
FROM
	customer
WHERE customer_id IN (SELECT customer_id
					 FROM payment
					  GROUP BY customer_id
					  HAVING SUM(amount) > 100)
AND customer_id IN (SELECT customer_id
				   from customer
					INNER JOIN address
					ON address.address_id = customer.address_id
				    WHERE district = 'California');  
					
/* Find out average lifetime spending per customer     */
SELECT ROUND(AVG(total_amount),2) AS av_lifetime_spent
FROM
	(SELECT customer_id, SUM(amount) AS total_amount  FROM payment
	GROUP BY customer_id);
	
/* What is the average total amount spent per day (average daily revenue)?  */
SELECT ROUND(AVG(amount_per_day),2) AS daily_rev_avg
FROM
	(SELECT 
	SUM(amount) AS amount_per_day,
	DATE(payment_date)
	FROM payment
	GROUP BY DATE(payment_date));
	
/* Show all the payments together with how much the payment amount is below the maximum
	payment amount.
*/
SELECT
	*,
	(SELECT MAX(amount) FROM payment) - amount AS difference FROM payment;
	
/* Show only those payments that have the highest amount per customer. */
SELECT * FROM payment p1
WHERE amount = (SELECT MAX(amount) FROM payment p2
				WHERE p1.customer_id = p2.customer_id)
ORDER BY customer_id;

/* Show only those movie titles, their associated film_id and replacement_cost 
	with the lowest replacement_costs for in each rating category – also show the rating
*/
SELECT title, film_id, replacement_cost, rating
FROM film f1
WHERE replacement_cost = (SELECT MIN(replacement_cost) FROM film f2
						 WHERE f1.rating = f2.rating);

/* Show only those movie titles, their associated film_id and the length that have 
	the highest length in each rating category – also show the rating.
*/
SELECT title, film_id, length, rating
FROM film f1
WHERE length = (SELECT MAX(length) FROM film f2
						 WHERE f1.rating = f2.rating);
						 
/* Show the maximum amount for every customer */
SELECT customer_id,
	MAX(amount)
FROM payment
GROUP BY customer_id
ORDER BY MAX(amount) DESC;
--The above could also be done this way
SELECT *,
 (SELECT MAX(amount) FROM payment p2
  WHERE p1.customer_id = p2.customer_id)
 FROM payment p1
 ORDER BY customer_id;
 
/* Show only those payments with the highest payment for each customer's first name 
  - including the payment_id of that payment.
  How would you solve it if you would not need to see the payment_id?
*/
SELECT first_name, amount, payment_id
FROM payment p1
INNER JOIN customer c
ON p1.customer_id = c.customer_id
WHERE amount = (SELECT MAX(amount) FROM payment p2
			   WHERE p1.customer_id = p2.customer_id);
/* How would you solve it if you would not need to see the payment_id ?   */
SELECT first_name, MAX(amount)
FROM payment p1
INNER JOIN customer c
ON p1.customer_id = c.customer_id
GROUP BY first_name;
   
   
   
   
   
	
	
	
	
	
	
	
	
	