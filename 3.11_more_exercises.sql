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
	
	