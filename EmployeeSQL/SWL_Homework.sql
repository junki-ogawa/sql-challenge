CREATE table employees (
	emp_no INT not null primary key,
	emp_title_id VARCHAR (100) NOT NULL,
	birth_date DATE,
	first_name VARCHAR (100) NOT NULL,
	last_name VARCHAR (100) NOT NULL,
	sex VARCHAR (50) NOT NULL,
	hire_date DATE
	);

CREATE table departments (
	dept_no VARCHAR (50) NOT NULL primary key,
	dept_name VARCHAR (50) NOT NULL
	);

CREATE table dep_emp (
	emp_no INT,
	dept_no VARCHAR (50) NOT NULL
	);

CREATE table dept_manager (
	dept_no VARCHAR (50) NOT NULL,
	emp_no INT
	);

CREATE table salaries (
	emp_no INT,
	salary INT
	);
	
CREATE table titles (
	title_id VARCHAR (50) NOT NULL,
	title VARCHAR (50) NOT NULL
	);
	
--List the following details of each employee:
	--employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no
;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '01/01/1986' AND hire_date <= '12/31/1986';

--List the manager of each department with the following information:
	--department number, department name, the manager's employee number, last name, first name.
CREATE VIEW departments_and_managers AS
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

SELECT * FROM departments_and_managers dam;

SELECT employees.last_name, employees.first_name, dam.dept_no, dam.dept_name, dam.emp_no
FROM departments_and_managers dam
JOIN employees
ON dam.emp_no = employees.emp_no
;

--List the department of each employee with the following information: 
	--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments d
JOIN dep_emp de
ON de.dept_no = d.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
;

--List first name, last name, and sex for employees whose
	--first name is "Hercules" and last names begin with "B."
SELECT last_name, first_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department
	--including their employee number, last name, first name, and department name.
---- FIX THIS ** need dam
SELECT dam.emp_no, dam.last_name, dam.first_name, dam.dept_name
WHERE dept_name = 'Sales';

--List all employees in the Sales and Development departments,
	--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments d
JOIN dep_emp de
ON de.dept_no = d.dept_no
JOIN employees e
ON de.emp_no = e.emp_no
WHERE d.dept_name = 'SALES' OR d.dept_name = 'Development';

--In descending order, list the frequency count of employee last names,
	--i.e., how many employees share each last name.
SELECT last_name, count(last_name)
FROM employees
GROUP BY last_name
ORDER BY last_name;

--Epilogue
SELECT * FROM employees WHERE emp_no=499942