/*Find all the employees with the same hire date as employee 101010 using a sub-query.

69 Rows*/

SELECT
		COUNT(*) as EMPLOYEES
	FROM
		employees as E 
	JOIN
		(SELECT
			hire_date as HD
		FROM
			employees
		WHERE
			emp_no = '101010'
		) HIRE_DATE
		ON E.hire_date = HIRE_DATE.HD
	;

/*Find all the titles held by all employees with the first name Aamod.

314 total titles, 6 unique titles*/



SELECT
		SUM(Records) Records
		,COUNT(*) Titles
	FROM
		(SELECT
			COUNT(*) Records
			,t.title
		FROM
			employees e
		JOIN
			titles t
			ON e.emp_no = t.emp_no
			AND t.to_date > NOW()
 		WHERE
 			e.first_name = 'Aamod'
 		GROUP BY
 			t.title) ts

use employees;	
	/*How many people in the employees table are no longer working for the company?*/
	
			SELECT
		CASE WHEN mxtd.maxdate > NOW() THEN 'Currently Employed' ELSE 'Formerly Employed' END as Working_Status
		,COUNT(*) as Records
	FROM
		(SELECT
			emp_no
			,MAX(to_date) as maxdate
		FROM
			dept_emp
		GROUP BY
			emp_no
		)  as mxtd
	GROUP BY
		Working_Status
	;
/*Find all the current department managers that are female.*/
	SELECT
		E.first_name
		,E.last_name
	FROM
		employees E
	JOIN
		(SELECT
			DM.dept_no
			,CONCAT(E.first_name,' ',E.last_name) as Department_Manager
			,E.gender
			,E.emp_no
		FROM
			employees as E
		JOIN
			dept_manager as DM
			ON E.emp_no = DM.emp_no
			AND DM.to_date > NOW()
			) DM
		ON DM.emp_no = E.emp_no
	WHERE
		DM.gender = 'F'
	;

    /*Find all the employees that currently have a higher than average salary.

154543 rows in total. Here is what the first 5 rows will look like:


+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Georgi     | Facello   | 88958  |
| Bezalel    | Simmel    | 72527  |
| Chirstian  | Koblick   | 74057  |
| Kyoichi    | Maliniak  | 94692  |
| Tzvetan    | Zielinski | 88070  |
+------------+-----------+--------+*/


	SELECT
		E.first_name as FIRST_NAME
		,E.last_name as LAST_NAME
		,S.salary as SALARY
		,avgs.AvgSal as AVERAGE_SALARY
	FROM
		employees E
	JOIN
		salaries S
		ON E.emp_no = S.emp_no
		AND S.to_date > NOW()
	JOIN
		(SELECT
			AVG(salary) AvgSal
		FROM
			salaries
	
		) avgs
	WHERE
		S.salary > avgs.AvgSal
	;

/*How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

78 salaries*/


SELECT
		SUM(within_dev) as Qualifying_Records
		,COUNT(*) as Current_Records
		,CONCAT(100*AVG(within_dev), '%') as Percent
	FROM
	
(SELECT
		E.first_name
		,E.last_name
		,S.salary
		,AVGS.max_salary
		,AVGS.salary_deviation
		,AVGS.max_salary - S.salary 
		,(AVGS.max_salary - S.salary) /  AVGS.salary_deviation 
		,CASE WHEN (AVGS.max_salary - S.salary) <= AVGS.salary_deviation THEN 1 ELSE 0 END as within_dev
	
	FROM
		employees E
	JOIN
		salaries S
		ON E.emp_no = S.emp_no
		AND S.to_date > NOW()
JOIN
	(SELECT 
	
	AVG(salary) as average_salary,
	MAX(salary) as max_salary,
	STDDEV_POP(salary) as salary_deviation	
	
	From salaries
	
	) AVGS
	) STDDEVCHECK



