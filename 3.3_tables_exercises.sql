use employees;

show tables;

show create table employees;


CREATE TABLE `employees` (
  `emp_no` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

6   Employee Number, 
7    First and Last Name gender?

8    birth_date and hire_date

9   departments shares records with employees 

10  show create table employees.`dept_manager`;