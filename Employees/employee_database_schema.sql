-- DROP TABLE salaries;
-- DROP TABLE dept_manager;
-- DROP TABLE dept_emp;
-- DROP TABLE departments;
-- DROP TABLE employees;
-- DROP TABLE titles;

CREATE TABLE titles(
 	title_id VARCHAR PRIMARY KEY NOT NULL,
 	title VARCHAR NOT NULL
);

CREATE TABLE employees( 
 	emp_no INT NOT NULL,
 	emp_title_id VARCHAR NOT NULL,
	birth_date VARCHAR NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date VARCHAR NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY NOT NULL,
	dept_name VARCHAR NOT NULL
);

CREATE TABLE dept_emp(
 	emp_no INT NOT NULL,
 	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_manager(
 	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE salaries(
 	emp_no INT PRIMARY KEY NOT NULL,
 	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- 1. List the following details of each employee: 
--employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
FROM employees AS e
INNER JOIN salaries AS s ON 
	e.emp_no = s.emp_no
;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%/1986'
;

-- 3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
SELECT m.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
FROM dept_manager AS m
INNER JOIN employees AS e 
ON m.emp_no = e.emp_no
INNER JOIN departments AS d
ON m.dept_no = d.dept_no;

-- 4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN departments AS d
ON d.dept_no = de.dept_no;


-- 5. List first name, last name, and sex for employees 
--whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN departments AS d
ON d.dept_no = de.dept_no
WHERE dept_name = 'Sales';


-- 7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN departments AS d
ON d.dept_no = de.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';


-- 8. In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC;

