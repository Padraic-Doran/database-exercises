/*
How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?
	*/
	-- Thanks Kevin
	SELECT
		concat(CASE WHEN smgr.MgrSal > savg.AvgSal THEN '+' ELSE '' END,
				ROUND(100*((smgr.MgrSal/savg.AvgSal)-1),2),'%') MgrSalIdx
		,smgr.MgrSal
		,savg.AvgSal
		,d.dept_name
		,smgr.dept_mgr
	FROM
		departments d
	JOIN
		(SELECT
			dm.dept_no
			,CONCAT(e.first_name,' ',e.last_name) dept_mgr
			,s.salary MgrSal
		FROM
			employees e
		JOIN
			dept_manager dm
			ON e.emp_no = dm.emp_no
			AND dm.to_date > NOW()
		JOIN
			salaries s
			ON e.emp_no = s.emp_no
			AND s.to_date > NOW()
		) smgr
		ON d.dept_no = smgr.dept_no
	JOIN
		(SELECT
			de.dept_no
			,AVG(salary) as AvgSal
		FROM
			employees e
		JOIN
			dept_emp de
			ON e.emp_no = de.emp_no
			AND de.to_date > NOW()
		JOIN
			salaries s
			ON e.emp_no = s.emp_no
			AND s.to_date > NOW()
		GROUP BY
			de.dept_no
		) savg
		ON d.dept_no = savg.dept_no
	ORDER BY (smgr.MgrSal/savg.AvgSal) DESC
	;






use world;

/*World Database
Use the world database for the questions below.

What languages are spoken in Santa Monica?


+------------+------------+
| Language   | Percentage |
+------------+------------+
| Portuguese |        0.2 |
| Vietnamese |        0.2 |
| Japanese   |        0.2 |
| Korean     |        0.3 |
| Polish     |        0.3 |
| Tagalog    |        0.4 |
| Chinese    |        0.6 |
| Italian    |        0.6 |
| French     |        0.7 |
| German     |        0.7 |
| Spanish    |        7.5 |
| English    |       86.2 |
+------------+------------+
12 rows in set (0.01 sec)*/

SELECT

	CL.Language AS LANGWEDGE,
	CL.Percentage AS PERCENTAGE
	
FROM city as C
	JOIN countrylanguage as CL
		On CL.CountryCode = C.CountryCode
		
WHERE
	C.Name = 'Santa Monica'
	
Order By CL.Percentage;

/*How many different countries are in each region?


+---------------------------+---------------+
| Region                    | num_countries |
+---------------------------+---------------+
| Micronesia/Caribbean      |             1 |
| British Islands           |             2 |
| Baltic Countries          |             3 |
| Antarctica                |             5 |
| North America             |             5 |
| Australia and New Zealand |             5 |
| Melanesia                 |             5 |
| Southern Africa           |             5 |
| Northern Africa           |             7 |
| Micronesia                |             7 |
| Nordic Countries          |             7 |
| Central America           |             8 |
| Eastern Asia              |             8 |
| Central Africa            |             9 |
| Western Europe            |             9 |
| Eastern Europe            |            10 |
| Polynesia                 |            10 |
| Southeast Asia            |            11 |
| Southern and Central Asia |            14 |
| South America             |            14 |
| Southern Europe           |            15 |
| Western Africa            |            17 |
| Middle East               |            18 |
| Eastern Africa            |            20 |
| Caribbean                 |            24 |
+---------------------------+---------------+
25 rows in set (0.00 sec)*/

Select 
	region, 
	Count(*) as num_countries
From
	country
Group By 
	region
Order By num_countries;

/*What is the population for each region?


+---------------------------+------------+
| Region                    | population |
+---------------------------+------------+
| Eastern Asia              | 1507328000 |
| Southern and Central Asia | 1490776000 |
| Southeast Asia            |  518541000 |
| South America             |  345780000 |
| North America             |  309632000 |
| Eastern Europe            |  307026000 |
| Eastern Africa            |  246999000 |
| Western Africa            |  221672000 |
| Middle East               |  188380700 |
| Western Europe            |  183247600 |
| Northern Africa           |  173266000 |
| Southern Europe           |  144674200 |
| Central America           |  135221000 |
| Central Africa            |   95652000 |
| British Islands           |   63398500 |
| Southern Africa           |   46886000 |
| Caribbean                 |   38140000 |
| Nordic Countries          |   24166400 |
| Australia and New Zealand |   22753100 |
| Baltic Countries          |    7561900 |
| Melanesia                 |    6472000 |
| Polynesia                 |     633050 |
| Micronesia                |     543000 |
| Antarctica                |          0 |
| Micronesia/Caribbean      |          0 |
+---------------------------+------------+
25 rows in set (0.00 sec)
*/

Select region, Sum(`Population`) as population 
From country
Group By region
Order By population desc;

/*What is the population for each continent?


+---------------+------------+
| Continent     | population |
+---------------+------------+
| Asia          | 3705025700 |
| Africa        |  784475000 |
| Europe        |  730074600 |
| North America |  482993000 |
| South America |  345780000 |
| Oceania       |   30401150 |
| Antarctica    |          0 |
+---------------+------------+
7 rows in set (0.00 sec)*/

Select 
	continent, 
	Sum(population) as Population 
from 
	country
Group By 
	continent
Order By 
	population DESC;

    /*What is the average life expectancy globally?


+---------------------+
| avg(LifeExpectancy) |
+---------------------+
|            66.48604 |
+---------------------+
1 row in set (0.00 sec)*/

Select avg(`LifeExpectancy`) as LiifExpecktancy
from country;

/*What is the average life expectancy for each region, each continent? Sort the results from shortest to longest


+---------------+-----------------+
| Continent     | life_expectancy |
+---------------+-----------------+
| Antarctica    |            NULL |
| Africa        |        52.57193 |
| Asia          |        67.44118 |
| Oceania       |        69.71500 |
| South America |        70.94615 |
| North America |        72.99189 |
| Europe        |        75.14773 |
+---------------+-----------------+
7 rows in set (0.00 sec)

+---------------------------+-----------------+
| Region                    | life_expectancy |
+---------------------------+-----------------+
| Antarctica                |            NULL |
| Micronesia/Caribbean      |            NULL |
| Southern Africa           |        44.82000 |
| Central Africa            |        50.31111 |
| Eastern Africa            |        50.81053 |
| Western Africa            |        52.74118 |
| Southern and Central Asia |        61.35000 |
| Southeast Asia            |        64.40000 |
| Northern Africa           |        65.38571 |
| Melanesia                 |        67.14000 |
| Micronesia                |        68.08571 |
| Baltic Countries          |        69.00000 |
| Eastern Europe            |        69.93000 |
| Middle East               |        70.56667 |
| Polynesia                 |        70.73333 |
| South America             |        70.94615 |
| Central America           |        71.02500 |
| Caribbean                 |        73.05833 |
| Eastern Asia              |        75.25000 |
| North America             |        75.82000 |
| Southern Europe           |        76.52857 |
| British Islands           |        77.25000 |
| Western Europe            |        78.25556 |
| Nordic Countries          |        78.33333 |
| Australia and New Zealand |        78.80000 |
+---------------------------+-----------------+
25 rows in set (0.00 sec)*/

SELECT 

country.continent as CONTINENT,
AVG(LifeExpectancy) as LIIF_Expectancy

From 
country

Group By Continent
Order By Liif_Expectancy; 

SELECT 

country.region as REGION,
AVG(LifeExpectancy) as LIIF_Expectancy

From 
country

Group By Region
Order By Liif_Expectancy;

-- Find all the countries whose local name is different from the official name

SELECT
	country.name as OFFICIAL_CRTY_NAME, country.localname as LOCAL_CRTY_NAME
	
FROM
	`country`
	
WHERE

country.name NOT LIKE country.localname;

-- What state is city x located in?

select * from country;

select * from city;

select name as city_name, district as state
from city
where CountryCode = 'USA'
order by city.district;

-- What region of the world is city x located in?

select city.name as City_Name, country.region as World_Region
from `city`
join country
on city.countrycode = country.`Code`
Order by country.region, city.name;

-- What country (use the human readable name) city x located in?


select city.name as City_Name, country.name as Country_Name
from `city`
join country
on city.countrycode = country.`Code`
Order by country.name, city.name;

-- What is the life expectancy in city x?

SELECT city.name as CITY_NAME, country.name as COUNTRY_NAME, country.lifeexpectancy as LIFE_EXPECTANCY
from city
join country
on city.countrycode = country.code
Order by country.lifeexpectancy DESC;

select * from actor;
-- Display the first and last names in all lowercase of all the actors.


select LOWER(first_name) as FIRST_NAME, LOWER(last_name)as LAST_NAME
from `actor`
order by last_name;

/* -- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information? */

select actor_id, first_name, `last_name`
from actor
where first_name = "Joe";

-- Find all actors whose last name contain the letters "gen":

select actor_id, first_name, last_name
from actor
where last_name like "%gen%";


-- Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.

select actor_id, first_name, last_name
from actor
where last_name like "%li%"
Order BY last_name, first_name;

/* Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China: */

select * from country;

SELECT
		country_id
		,country
	FROM
		country
	WHERE
		country IN ('Afghanistan','Bangladesh','China')
	;
	
-- List the last names of all the actors, as well as how many actors have that last name.

Select last_name, COUNT(*) as actors
from actor
GROUP BY `last_name`
Order BY actors DESC, last_name;

/* List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors */

Select last_name, COUNT(*) as actors
from actor
GROUP BY `last_name`
Having actors > 1
Order BY actors DESC, last_name;


SHOW CREATE TABLE address;
	/*
CREATE TABLE `address` (
	`address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
	`address` varchar(50) NOT NULL,
	`address2` varchar(50) DEFAULT NULL,
	`district` varchar(20) NOT NULL,
	`city_id` smallint(5) unsigned NOT NULL,
	`postal_code` varchar(10) DEFAULT NULL,
	`phone` varchar(20) NOT NULL,
	`location` geometry NOT NULL,
	`last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`address_id`),
	KEY `idx_fk_city_id` (`city_id`),
	SPATIAL KEY `idx_location` (`location`),
	CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8
*/

/*Use JOIN to display the first and last names, as well as the address, of each staff member.
	*/

	SELECT
		s.first_name
		,s.last_name
		,a.address
		,a.address2
		,c.city
		,a.district
		,a.postal_code
	FROM
		staff s
	JOIN	
		address a
		ON s.address_id = a.address_id
	JOIN
		city c
		ON a.city_id = c.city_id
	;
	
	-- Use /* JOIN to display the total amount rung up by each staff member in August of 2005. */

	SELECT
		CONCAT(s.first_name,' ',s.last_name) as staff_member, SUM(p.amount) as total_sales, COUNT(r.rental_id) as rentals
	FROM
		rental r
	JOIN
		staff s
		ON r.staff_id = s.staff_id
	LEFT JOIN
		payment p
		ON r.rental_id = p.rental_id
	WHERE
		r.rental_date LIKE '2005-08%'
	GROUP BY
		s.staff_id
	;

-- List each film and the number of actors who are listed for that film.

    SELECT
		f.film_id as FILM_ID, f.title as FILM_TITLE, count(fa.film_id) as ACTOR_NO
	FROM
		film f
	JOIN
		film_actor fa
		USING (film_id)
	GROUP BY
		f.film_id
	;

    -- How many copies of the film Hunchback Impossible exist in the inventory system?
	
select * from film;	

select * from inventory;

SELECT f.title as FILM_NAME, COUNT(I.film_id) as NO_OF_FILMS
from film f
join inventory I
on f.film_id = I.film_id
Where f.title = 'Hunchback Impossible'
Group By f.film_id;

/* The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. */


select * from film;
select * from language;


SELECT F.title
from film as F
Where F.title like 'K%' Or F.title like "Q%"
and language_id = 1;

-- Use subqueries to display all actors who appear in the film Alone Trip.

SELECT CONCAT(a.first_name,' ',a.last_name) as Actor 
		FROM actor a
		WHERE a.actor_id IN
			(SELECT actor_id 
				FROM film_actor
				WHERE film_id IN
						(SELECT film_id
 						FROM film
						WHERE film.title = "Alone Trip"));

-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.

SELECT * from customer;
SELECT * from country;  -- 20 --
SELECT * from address;
SELECT * from city;


SELECT Concat(first_name, ' ', last_name) as CUSTOMER_NAME, email as EMAIL
from customer
LEFT JOIN address ON (customer.address_id=address.address_id)
LEFT JOIN city ON (address.city_id=city.city_id)
LEFT JOIN country ON (city.country_id=country.country_id)
WHERE country='Canada';

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.

SELECT * from film;
SELECT * from film_category;
SELECT * from category; -- 8 -- -- Family --

Select F.title as FILM_TITLE
from film as F
LEFT JOIN film_category as FC ON F.film_id = FC.film_id 
LEFT JOIN category as C on FC.`category_id` = C.category_id 
WHERE C.name = 'Family';


-- Write a query to display how much business, in dollars, each store brought in.

Select * from payment;
SELECT * from store;
SELECT * from staff;

SELECT SUM(p.amount) as REVENUE, s.staff_id as Store
FROM payment as p
LEFT JOIN staff as s ON p.staff_id = s.staff_id
GROUP BY s.staff_id;

-- Write a query to display for each store its store ID, city, and country.


SELECT store.store_id, city.city, country.country
FROM store

LEFT JOIN address ON (store.address_id=address.address_id)

LEFT JOIN city ON (address.city_id=city.city_id)

LEFT JOIN country ON (city.country_id=country.country_id);

-- List the top five genres in gross revenue in descending order.
-- (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT category.name AS Genre, SUM(payment.amount) AS Gross_Revenue

FROM payment

LEFT JOIN rental ON (payment.rental_id=rental.rental_id)

LEFT JOIN inventory ON (rental.inventory_id=inventory.inventory_id)

LEFT JOIN film_category ON (inventory.film_id=film_category.film_id)

LEFT JOIN category ON (film_category.category_id=category.category_id)

GROUP BY category.name

ORDER BY gross_revenue DESC
LIMIT 5;


/* SELECT statements

Select all columns from the actor table.
Select only the last_name column from the actor table.
Select only the following columns from the film table. */

Select * from actor;

Select last_name from actor;

/* DISTINCT operator

Select all distinct (different) last names from the actor table.
Select all distinct (different) postal codes from the address table.
Select all distinct (different) ratings from the film table. */

Select DISTINCT last_name from actor;
Select DISTINCT postal_code from address;
Select DISTINCT rating from film;

/* WHERE clause

Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
Select all columns minus the password column from the staff table for rows that contain a password.
Select all columns minus the password column from the staff table for rows that do not contain a password. */

Select * from film;
Select title, description, rating, length from film
where length > 180;

Select * from payment;

Select payment_id, amount, payment_date
from payment
where payment_date >= '05/27/2005';

Select * from payment;
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date='05-07-2005';

SELECT * FROM customer
WHERE last_name LIKE 'S%' AND first_name LIKE '%N';

SELECT * FROM customer
WHERE active=0 OR last_name LIKE 'M%';

SELECT * FROM customer
WHERE customer_id>4 OR
 (first_name LIKE 'C%' OR first_name LIKE 'S%' OR first_name LIKE 'T%');
 
 SELECT
staff_id,
first_name,
last_name,
address_id,
picture,
email,
store_id,
active,
username,
last_update
FROM staff
WHERE password IS NOT NULL;

SELECT
staff_id,
first_name,
last_name,
address_id,
picture,
email,
store_id,
active,
username,
last_update
FROM staff
WHERE password IS NULL;

/* IN operator

Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
-- Select all columns from the film table for films rated G, PG-13 or NC-17. */
Select * from address;
SELECT phone, district
FROM address
WHERE district IN ('California','England','Tapei','West Java');

SELECT * from payment;
SELECT payment_id, amount,
DATE(payment_date) AS only_date
FROM payment
WHERE only_date IN ('2005-05-25','2005-05-27','2005-05-29');

SELECT * from film
WHERE rating IN ('G','PG-13','NC-17');

/* BETWEEN operator
Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
Select the following columns from the film table for films where the length of the description is between 100 and 120. */


SELECT * FROM payment
WHERE payment_date BETWEEN '2005-05-25 23:59:59' AND '2005-05-26 23:59:59';

SELECT * FROM film
WHERE LENGTH(description) BETWEEN 100 AND 120;


/*LIKE operator
Select the following columns from the film table for rows where the description begins with "A Thoughtful".
Select the following columns from the film table for rows where the description ends with the word "Boat".
Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours. */

SELECT * FROM film
WHERE description LIKE 'A Thoughtful%';

SELECT * FROM film
WHERE description LIKE '%Boat';

SELECT * FROM film
WHERE description LIKE '%Database%' AND length>180;


/* LIMIT Operator

Select all columns from the payment table and only include the first 20 rows.
Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200. */

Select * from `payment`
LIMIT 20;

SELECT payment_id, payment_date, amount
FROM payment
WHERE amount > 5
LIMIT 1001 OFFSET 999;

SELECT * from `customer`
LIMIT 100 OFFSET 100;

/*
ORDER BY statement
Select all columns from the film table and order rows by the length field in ascending order.
	*/
	USE sakila;
	SELECT * FROM film
	ORDER BY length 
	;
	/*
	
	/*
Select all distinct ratings from the film table ordered by rating in descending order.
	*/
	USE sakila;
	SELECT DISTINCT rating
	FROM film
	ORDER BY rating DESC
	;
	
	/*
Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
	*/
	USE sakila;
	SELECT payment_date ,amount
	FROM payment
	ORDER BY amount DESC
	LIMIT 20
	;
	
	/*
Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
	*/
	USE sakila;
	SELECT
		title, description, special_features,length, rental_duration
	FROM film
	WHERE length < 120
		AND rental_duration BETWEEN 5 AND 7
		AND special_features LIKE '%Behind the Scenes%' 
	ORDER BY length DESC
	LIMIT 10
	;

/* JOINs

Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
Label customer first_name/last_name columns as customer_first_name/customer_last_name
Label actor first_name/last_name columns in a similar fashion.
-- returns correct number of records: 599 */

SELECT customer.first_name as CUSTOMER_FIRST_NAME,
	 customer.last_name as CUSTOMER_LAST_NAME, 
	 actor.first_name as ACTOR_FIRST_NAME, 
	 actor.last_name as ACTOR_LAST_NAME
FROM customer
LEFT JOIN actor ON customer.last_name = actor.last_name;

/* Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
-- returns correct number of records: 200 */

SELECT customer.first_name as CUSTOMER_FIRST_NAME,
	 customer.last_name as CUSTOMER_LAST_NAME, 
	 actor.first_name as ACTOR_FIRST_NAME, 
	 actor.last_name as ACTOR_LAST_NAME
FROM customer
RIGHT JOIN actor ON customer.last_name = actor.last_name;

/* Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 43 */

SELECT customer.first_name as CUSTOMER_FIRST_NAME,
	 customer.last_name as CUSTOMER_LAST_NAME, 
	 actor.first_name as ACTOR_FIRST_NAME, 
	 actor.last_name as ACTOR_LAST_NAME
FROM customer
INNER JOIN actor ON customer.last_name = actor.last_name;

/* Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
-- Returns correct records: 600 */

SELECT city.city as city, country.country as country
FROM city
LEFT JOIN country using(country_id);

/* Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
Label the language.name column as "language"
Returns 1000 rows */

SELECT title, description, release_year, language.name as 'language'
FROM film
LEFT JOIN language using(Language_ID);

/* Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
returns correct number of rows: 2 */

SELECT * FROM staff;
SELECT * FROM address;
SELECT * FROM city;
SELECT staff.first_name, staff.last_name, address.address, address.address2, city.city, address.district, address.postal_code
FROM staff
LEFT JOIN address using(`address_id`)
LEFT JOIN city using(city_id);


-- What is the average replacement cost of a film? Does this change depending on the rating of the film?

SELECT * FROM film;

SELECT AVG(replacement_cost)
FROM film;

SELECT rating, AVG(replacement_cost)
FROM film
GROUP BY rating;

-- How many different films of each genre are in the database?

SELECT * from film_category;
SELECT * from category;

SELECT category.name as CATEGORY, COUNT(category_id) as Total_Count
FROM film_category
JOIN category USING(category_id)
GROUP BY CATEGORY;

-- What are the 5 frequently rented films?

SELECT * from rental;
SELECT * from inventory;
SELECT * from film;

SELECT title, COUNT(*) as total
FROM film
JOIN inventory USING(film_id)
JOIN rental USING(inventory_id)
GROUP BY title
ORDER BY total DESC
LIMIT 5;

/* What are the most most profitable films (in terms of gross revenue)?


+-------------------+--------+
| title             | total  |
+-------------------+--------+
| TELEGRAPH VOYAGE  | 231.73 |
| WIFE TURN         | 223.69 |
| ZORRO ARK         | 214.69 |
| GOODFELLAS SALUTE | 209.69 |
| SATURDAY LAMBS    | 204.72 |
+-------------------+--------+
5 rows in set (0.17 sec) */

SELECT title, SUM(amount) as total
FROM film
JOIN inventory using(film_id)
JOIN rental using(inventory_id)
JOIN payment using(rental_id)
GROUP BY title
ORDER BY total DESC
LIMIT 5;

/* 
Who is the best customer?


+------------+--------+
| name       | total  |
+------------+--------+
| SEAL, KARL | 221.55 |
+------------+--------+
-- 1 row in set (0.12 sec) */

SELECT CONCAT(last_name,", ",first_name) as name,
SUM(amount) as total
FROM customer
JOIN payment USING(customer_id)
GROUP BY customer_id
ORDER BY total DESC
LIMIT 1;

/* Who are the most popular actors (that have appeared in the most films)?


+-----------------+-------+
| actor_name      | total |
+-----------------+-------+
| DEGENERES, GINA |    42 |
| TORN, WALTER    |    41 |
| KEITEL, MARY    |    40 |
| CARREY, MATTHEW |    39 |
| KILMER, SANDRA  |    37 |
+-----------------+-------+
5 rows in set (0.07 sec) */



SELECT CONCAT(last_name,", ",first_name) as actor_name,
count(*) as total
FROM actor
JOIN film_actor USING(actor_id)
GROUP BY actor_id
ORDER BY total DESC
LIMIT 5;


/* What are the sales for each store for each month in 2005?


+---------+----------+----------+
| month   | store_id | sales    |
+---------+----------+----------+
| 2005-05 |        1 |  2459.25 |
| 2005-05 |        2 |  2364.19 |
| 2005-06 |        1 |  4734.79 |
| 2005-06 |        2 |  4895.10 |
| 2005-07 |        1 | 14308.66 |
| 2005-07 |        2 | 14060.25 |
| 2005-08 |        1 | 11933.99 |
| 2005-08 |        2 | 12136.15 |
+---------+----------+----------+
8 rows in set (0.14 sec) */

select month(payment_date) as month,
store_id,
sum(amount) as sales
from inventory
join rental using(inventory_id)
join payment using(rental_id)
where payment_date like "2005%"
group by month,store_id;

/* Bonus: Find the film title, customer name, customer phone number, and customer address for all the outstanding DVDs.


+------------------------+------------------+--------------+
| title                  | customer_name    | phone        |
+------------------------+------------------+--------------+
| HYDE DOCTOR            | KNIGHT, GAIL     | 904253967161 |
| HUNGER ROOF            | MAULDIN, GREGORY | 80303246192  |
| FRISCO FORREST         | JENKINS, LOUISE  | 800716535041 |
| TITANS JERK            | HOWELL, WILLIE   | 991802825778 |
| CONNECTION MICROCOSMOS | DIAZ, EMILY      | 333339908719 |
+------------------------+------------------+--------------+
5 rows in set (0.06 sec) */


SELECT title,
concat(last_name,", ",first_name) as customer_name, phone, address
FROM rental
JOIN customer using(customer_id)
JOIN address using(address_id)
JOIN inventory using(inventory_id)
JOIN film using(film_id)
WHERE return_date IS NULL;
