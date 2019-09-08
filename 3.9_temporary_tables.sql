use bayes_812;
 
--  Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments AS
	SELECT emp_no, first_name, last_name, dept_no, dept_name
	FROM employees.employees
	JOIN employees.dept_emp USING(emp_no)
	JOIN employees.departments USING(dept_no)
	LIMIT 100;

select  * from employees_with_departments;

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns


ALTER TABLE 
		employees_with_departments 
	ADD 
		full_name VARCHAR(31);
		
-- Update the table so that full name column contains the correct data

UPDATE 
		employees_with_departments
	SET
		full_name = CONCAT(first_name,' ',last_name);

-- Remove the first_name and last_name columns from the table.
		
ALTER TABLE 
		employees_with_departments 
	DROP COLUMN
		first_name;
		
ALTER TABLE 
		employees_with_departments 
	DROP COLUMN
		last_name;
		
-- What is another way you could have ended up with this same table?
-- 				
-- CREATE TABLE employees_with_departments AS
-- 	SELECT 
-- 		emp_no 
-- 		,CONCAT(first_name,' ',last_name) full_name 
-- 		,dept_no
-- 		,dept_name
-- 	FROM 
-- 		employees.employees
-- 	JOIN 
-- 		employees.dept_emp 
-- 		USING(emp_no)
-- 	JOIN 
-- 		employees.departments 
-- 		USING(dept_no)
-- 	LIMIT 100
-- 	;
-- 	SELECT count(*) FROM employees_with_departments
-- 	;

CREATE TEMPORARY TABLE cents
SELECT * 
FROM sakila.payment;

Select * from cents;

ALTER TABLE cents 
MODIFY 
	amount DECIMAL(7,2) NOT NULL
;
	UPDATE cents
	SET 
		amount = 100*amount
	;
	ALTER TABLE cents MODIFY amount INTEGER NOT NULL;
	;
SELECT * FROM cents;
DROP Table cents;


use employees;

/* SELECT * FROM salaries
Where to_date > NOW(); */

/* SELECT * from employees.dept_emp
Where to_date > NOW(); */

-- Trying to combine tables from the same table 
Select emp_no, dept_no, salary
From(
Select de.emp_no, de.dept_no, s.salary
From dept_emp as de
Join salaries as s
on de.emp_no = s.emp_no
Where de.to_date > NOW() 
and s.to_date > NOW()) as Table_1

JOIN
(
Select dept_no, AVG(salary) as Average_Salary
From(
Select de.emp_no, de.dept_no, s.salary
From dept_emp as de
Join salaries as s
on de.emp_no = s.emp_no
Where de.to_date > NOW() 
and s.to_date > NOW()) as table_2
Group By dept_no) as table_3 On Table_1.dept_no = table_2.dept_no;



use employees;

/* select * from salaries; */

/* select AVG(salary), STDDEV_POP(salary)
from salaries as Salary_Info
where to_date > NOW(); */

/* SELECT DE.emp_no as EMPLOYEE_NO, DE.dept_no as DEPARTMENT_NO, D.dept_name as DEPT_NAME
from employees as E
Join dept_emp as DE
on E.emp_no = DE.emp_no
Join departments as D
On DE.dept_no = D.dept_no
WHERE DE.to_date > NOW()
Order By DEPT_name; */


Select 
from departments
where to_date > NOW()
and department_no = 'd001';



use bayes_812;

CREATE TABLE employees_with_departments AS
	SELECT 
		emp_no
		,first_name
		,last_name
		,dept_no
		,dept_name
	FROM 
		employees.employees
	JOIN 
		employees.dept_emp 
		USING(emp_no)
	JOIN 
		employees.departments 
		USING(dept_no)
	;
	SELECT * FROM employees_with_departments
	;
	
	
	ALTER TABLE 
		employees_with_departments 
	ADD 
		full_name VARCHAR(31)
	;

UPDATE 
		employees_with_departments
	SET
		full_name = CONCAT(first_name,' ',last_name)
	;
	ALTER TABLE 
		employees_with_departments 
	DROP COLUMN
		first_name
	;
	ALTER TABLE 
		employees_with_departments 
	DROP COLUMN
		last_name
	;
	CREATE TEMPORARY TABLE Sal LIKE employees.salaries
	;
	INSERT INTO Sal SELECT * FROM employees.salaries
	;
	ALTER TABLE Sal ADD Zscore FLOAT(53)
	;
SELECT * FROM Sal
	;
	CREATE TEMPORARY TABLE SalInfo
	SELECT 
		AVG(Salary) SalAvg
		,STDDEV(Salary) SalStdDev
	FROM
		Sal
	WHERE
		to_date > now()
	;
	SELECT * FROM SalInfo
	;
	UPDATE Sal s JOIN SalInfo si
	SET
		s.Zscore = ((s.Salary - si.SalAvg)/(si.SalStdDev))
	;
	SELECT 
		ed.dept_name, 
		((AVG(s.salary) - AVG(si.SalAvg))/(AVG(si.SalStdDev))) salary_z_score
	FROM
		employees_with_departments ed
	JOIN
		Sal s
		USING(emp_no)
	JOIN
		SalInfo si
	GROUP BY
		ed.dept_name
	;
/* select * from employees_with_departments */
-- select * from Sal;
select * from SalInfo;


use employees;

Select d.dept_no, d.dept_name, SUM(s.salary), AVG(s.salary) 
from departments as d
join dept_emp as de
on d.dept_no = de.dept_no
join salaries as s 
on de.emp_no = s.emp_no
Group By d.`dept_name`
