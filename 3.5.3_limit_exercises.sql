/*Create a new SQL script named 3.5.3_limit_exercises.sql.

MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

SELECT DISTINCT title FROM titles;
List the first 10 distinct last name sorted in descending order. Your result should look like this:


Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker
Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees. Their names should be: */

use employees;

show create table employees;





select first_name, last_name, birth_date, hire_date
from `employees`
where birth_date like '%%%%-12-25'
and hire_date like '199%-%%-%%'
ORDER BY birth_date, hire_date DESC
Limit 5;

/*Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results. The employee names should be:*/




select first_name, last_name, birth_date, hire_date
from `employees`
where birth_date like '%%%%-12-25'
and hire_date like '199%-%%-%%'
ORDER BY birth_date, hire_date DESC
Limit 5 Offset 45;

