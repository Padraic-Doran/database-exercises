Select roles.name ,roles.id, Count(*)
from users
right join roles
on roles.id = users.role_id
Group By roles.id;

/*Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang*/
  
Select d.`dept_name` as DEPARTMENT, Concat(e.first_name, ' ', e.last_name) as D_MANAGER

	From employees As e
	Join dept_manager as dm
		on e.emp_no = dm.emp_no
	Join departments as d
		on d.dept_no = dm.dept_no
		
WHERE dm.to_date > NOW()
ORDER BY d.dept_name;

	/*Find the name of all departments currently managed by women.


Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil*/  

Select d.`dept_name` as DEPARTMENT, Concat(e.first_name, ' ', e.last_name) as D_MANAGER

	From employees As e
	Join dept_manager as dm
		on e.emp_no = dm.emp_no
	Join departments as d
		on d.dept_no = dm.dept_no
		
WHERE dm.to_date > NOW()
	And e.gender = "F"
ORDER BY d.dept_name;
	

/*Find the current titles of employees currently working in the Customer Service department.


Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/

SELECT T.title as TITLE, Count(*) as RECS
	FROM employees as E
		JOIN dept_emp as DE
			ON E.emp_no = DE.emp_no
		JOIN titles as T
			On E.emp_no = T.emp_no
			
	WHERE
	DE.dept_no = 'd009'
	AND DE.to_date > CURDATE()
	AND T.to_date > CURDATE()
	
	GROUP BY T.title;

    /*Find the current salary of all current managers.


Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987*/


SELECT
	D.dept_name as DEPARTMENT,
	CONCAT(E.first_name,' ', E.last_name) as NAME,
	S.salary as SALARY
	
	
FROM employees as E
		JOIN dept_manager as DM
			on E.emp_no = DM.emp_no
			
		JOIN departments as D
			on DM.dept_no = D.`dept_no`
			
		JOIN salaries as S
			on S.emp_no = E.emp_no
			
WHERE
	DM.to_date > CURDATE()
	AND S.to_date > CURDATE()
	
ORDER BY D.dept_name;
			
            USE employees;

/*Find the number of employees in each department.


+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+*/

SELECT

	D.dept_no as DEPARTMENT_NO,
	D.dept_name as DEPARTMENT_NAME,
	COUNT(*) as EMPS
	
FROM employees as E

	JOIN dept_emp as DE
		on E.emp_no = DE.emp_no
		
	JOIN departments as D
		ON DE.dept_no = D.dept_no
		
WHERE
	DE.to_date > NOW()		
GROUP BY
	D.dept_no,
	D.dept_name
	
ORDER BY
	D.dept_no;
	
	
	
	/*Which department has the highest average salary?


+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+*/


SELECT
		D.dept_name as DEPARTMENT_NAME
		,AVG(salary) as AVERAGE_SALARY
	FROM
		employees as E
	JOIN
		dept_emp as DE
		ON E.emp_no = DE.emp_no
	JOIN
		departments as D
		ON DE.dept_no = D.dept_no
	JOIN
		salaries as S
		ON E.emp_no = S.emp_no
	WHERE
		DE.to_date > NOW()
		AND S.to_date > NOW()
	GROUP BY
		D.dept_name
	ORDER BY Average_Salary desc
	LIMIT 1
	;

    /*Who is the highest paid employee in the Marketing department?


+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+*/


SELECT
	D.dept_name as DEPARTMENT,
	CONCAT(E.first_name, ' ', E.last_name) as PERSON,
	S.salary as SALARY
	
FROM
	employees as E
		JOIN dept_emp as DE
			ON E.emp_no = DE.`emp_no`
			
		JOIN departments as D
			ON DE.dept_no = D.dept_no
			
		JOIN salaries as S
			ON E.emp_no = S.emp_no
			
WHERE
	DE.to_date > NOW() and
	S.to_date > NOW() and
	D.dept_no = 'd001'
	
ORDER BY S.salary DESC
Limit 1;


/*Which current department manager has the highest salary?


+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+*/

SELECT 
	CONCAT(E.first_name, " ", E.last_name) as PERSON,
	S.salary as SALARY,
	D.dept_name as DEPARTMENT
	
FROM employees as E

	JOIN dept_manager as DM
		ON E.emp_no = DM.emp_no
	
	JOIN departments as D
		ON D.dept_no = DM.dept_no
		
	JOIN salaries as S
		ON S.emp_no = E.emp_no
		
Where
DM.to_date > NOW() AND
S.to_date > NOW()

ORDER BY S.salary DESC
Limit 1;
	
	/*Bonus Find the names of all current employees, their department name, and their current manager's name.


240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman*/
 

SELECT
		CONCAT(e.first_name,' ',e.last_name) as EMPLOYEE_NAME
		,mn.dept_name as DEPARTMENT
		,mn.dept_mgr as DEPARTMENT_MANAGER
	FROM
		employees e
	JOIN
		dept_emp de
		ON e.emp_no = de.emp_no
	JOIN	
		(SELECT
			d.dept_no
			,d.dept_name
			,CONCAT(e.first_name,' ',e.last_name) dept_mgr
		FROM
			employees e
		JOIN
			dept_manager dm
			ON e.emp_no = dm.emp_no
		JOIN
			departments d
			ON dm.dept_no = d.dept_no
		WHERE
			dm.to_date > NOW()
		) mn
		ON
			de.dept_no = mn.dept_no
	WHERE
		de.to_date > now()
	ORDER BY
		e.last_name, e.first_name	
	;

    
/*Bonus Find the highest paid employee in each department.*/


SELECT
		d.dept_name as DEPARTMENT
		,cd.dept_no as CURRENT_EMPLOYEE
		,dmxs.max_sal as DEPARTMENT_MAX_SALARY
		,e.first_name as FIRST_NAME
		,e.last_name as LAST_NAME
		,cs.salary as CURRENT_SALARY
	FROM
		employees e
	JOIN
		(SELECT
			*
		FROM
			salaries
		WHERE
			to_date > now()	
		) cs
		ON e.emp_no = cs.emp_no
	JOIN
		(SELECT
			*
		FROM
			dept_emp
		WHERE
			to_date > now()
		) cd
		ON e.emp_no = cd.emp_no
	JOIN	
		(SELECT
			de.dept_no 
			,MAX(salary) as max_sal
		FROM
			employees e
		JOIN
			dept_emp de
			ON e.emp_no = de.emp_no
		JOIN
			salaries s
			ON e.emp_no = s.emp_no
		WHERE
			de.to_date > NOW()
			AND s.to_date > NOW()
		GROUP BY
			de.dept_no
		) dmxs
		ON cd.dept_no = dmxs.dept_no
	JOIN 
		departments d
		ON cd.dept_no = d.dept_no
	WHERE cs.salary = dmxs.max_sal
	ORDER BY
		d.dept_no, cs.salary desc
		
	;