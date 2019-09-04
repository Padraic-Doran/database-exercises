use employees;

show create table employees;


/*In your script, use DISTINCT to find the unique titles in the titles table. Your results should look like:


Senior Engineer
Staff
Engineer
Senior Staff
Assistant Engineer
Technique Leader
Manager*/

Select DISTINCT title
from titles;


/*Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. The results should be:


Eldridge
Erbe
Erde
Erie
Etalle */

select DISTINCT last_name
from `employees`
where last_name like 'e%e'
GROUP BY last_name;

/*Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.*/

select DISTINCT first_name, last_name
from `employees`
where last_name like 'e%e'
GROUP BY last_name, first_name;

/*Find the unique last names with a 'q' but not 'qu'. Your results should be:


Chleq
Lindqvist
Qiwen*/

select DISTINCT last_name 
from `employees`
where last_name like '%q%' and last_name not like '%qu%';

-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.

select last_name, COUNT(*) Recs
from `employees`
where last_name like '%q%' and last_name not like '%qu%'
Group By last_name
Order By last_name;

-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. Your results should be:
-- 

-- 441 M
-- 268 F

select gender, COUNT(*) Record
from `employees`
Where first_name in ('Irena', 'Vidya', 'Maya')
Group By gender
ORDER BY gender;


-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?

SELECT Username, COUNT(*) Recs
From
(SELECT
LOWER(CONCAT
			(SUBSTR(first_name, 1,1),
			SUBSTR(last_name, 1,4),
			'_',
			SUBSTR(birth_date, 6,2),
			SUBSTR(birth_date, 3,2))) username
			,first_name
			,last_name
			,birth_date
FROM 
`employees`) UNAME
Group By 
Username
Having 
Recs > 1;
Order By Recs;

-- Bonus: how many duplicate usernames are there?

Select Sum(Recs) AS TotalDuplicates
From
(SELECT Username, COUNT(*) Recs
From
(SELECT
LOWER(CONCAT
			(SUBSTR(first_name, 1,1),
			SUBSTR(last_name, 1,4),
			'_',
			SUBSTR(birth_date, 6,2),
			SUBSTR(birth_date, 3,2))) username
			,first_name
			,last_name
			,birth_date
FROM 
`employees`) as UNAME
Group By 
Username
Having 
Recs > 1
Order By Recs) as Duplicates;