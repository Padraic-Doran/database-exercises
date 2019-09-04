use employees;

show create table employees;

select first_name
from `employees`
Where first_name in ('Irena', 'Vidya', 'Maya');

select last_name
from `employees`
Where last_name like "E%";

Select hire_date
from employees
Where hire_date BETWEEN '1990-01-01' and '1999-12-01';

Select birth_date
from `employees`
where birth_date like "%%%%-12-25";

Select last_name
from employees
where last_name like "%q%";

select first_name
from `employees`
Where first_name = 'Irena' or first_name = 'Vidya' or first_name ='Maya'

select first_name
from `employees`
Where first_name in ('Irena', 'Vidya', 'Maya')
and gender = 'M';

select last_name
from `employees`
where last_name like 'e%' or last_name like '%e';

select last_name
from `employees`
where last_name like 'e%e';

select birth_date
from `employees`
where birth_date like '%%%%-12-25'
and hire_date like '199%-%%-%%';

select last_name 
from `employees`
where last_name like '%q%' and last_name not like '%qu%';
