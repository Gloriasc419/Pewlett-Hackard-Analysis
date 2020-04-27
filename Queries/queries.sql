-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

SELECT * FROM employees

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining departments and dept_manager tables using aliases
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;



-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
		retirement_info.first_name,
		retirement_info.last_name,
		dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


-- Joining retirement_info and dept_emp tables using aliases
SELECT ri.emp_no,
		ri.first_name,
		ri.last_name,
		de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de 
ON ri.emp_no = de.emp_no;

--Create a table to hold current employees in retirement_info
SELECT ri.emp_no,
		ri.first_name,
		ri.last_name,
		de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_emp


SELECT COUNT(ce.emp_no),de.dept_no
INTO current_emp_count_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


SELECT * FROM salaries
ORDER BY to_date DESC;


--Inner join emp_info and employees
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		e.gender,
		s.salary,
		de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);


SELECT * FROM current_emp

SELECT COUNT(first_name) FROM manager_info

SELECT * FROM emp_info

--Department retirees
SELECT ce.emp_no,
		ce.first_name, 
		ce.last_name, 
		d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no);

--Get a list of retirees from specific departments using IN function
SELECT emp_no, first_name, last_name, dept_name 
FROM dept_info
WHERE dept_name IN ('Sales','Development');

SELECT COUNT(first_name)
FROM employees;

SELECT emp_no, title, to_date
FROM titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC;


SELECT emp_no, title, to_date
FROM titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC;


--Find out number of employees currently at HP (result is 240124)
SELECT COUNT (emp_no)
FROM titles
WHERE to_date = '9999-01-01'

--Find out number of employees currently at HP (result is 240124)
SELECT COUNT (emp_no)
FROM dept_emp
WHERE to_date = '9999-01-01'

--Inner join emp_info and titles
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		tt.title,
		tt.from_date,
		e.salary
INTO emp_info_title
FROM emp_info as e
INNER JOIN titles as tt
ON (e.emp_no = tt.emp_no)


--Find out duplicates
SELECT emp_no, first_name, last_name, COUNT(*)
FROM emp_info_title
GROUP BY emp_no, first_name, last_name
HAVING COUNT(*)>1

-- Partition the data to show only most recent title per employee
SELECT tmp.emp_no,
		tmp.first_name,
		tmp.last_name,
		tmp.title,
		tmp.from_date,
		tmp.salary
INTO retirement_ready
FROM
 (SELECT emp_no,
		  first_name,
		  last_name,
		  title,
		  from_date,
		  salary, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM emp_info_title
 ) tmp WHERE rn = 1
ORDER BY emp_no;

--Find out how many employees are retirement-ready (Result:33118)
SELECT COUNT(*) 
FROM retirement_ready

--Title count for retirment-ready table
SELECT title, COUNT(*)
INTO retirement_title_count
FROM retirement_ready
GROUP BY title;

SELECT * FROM retirement_title_count

SELECT COUNT(*) FROM emp_info


--LEFT join emp_info and titles
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		tt.title,
		e.to_date,
		e.salary
INTO test_comparison
FROM emp_info as e
LEFT JOIN titles as tt
ON (e.emp_no = tt.emp_no)

SELECT emp_no, first_name, last_name, COUNT(*) 
FROM test_comparison
GROUP BY emp_no, first_name, last_name
HAVING COUNT(*)>1

--Inner join to combine employees, titles (title, from_date, to_date)
SELECT e.emp_no, 
		e.first_name,
		e.last_name,
		tt.title,
		tt.from_date,
		tt.to_date
INTO eligible_mentorlist
FROM employees AS e
INNER JOIN titles AS tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (tt.to_date = '9999-01-01');

--Find out if there are duplicates
SELECT emp_no, first_name, last_name, COUNT(*)
FROM eligible_mentorlist
GROUP BY emp_no, first_name, last_name
HAVING COUNT(*)>1

--Total number of people on the mentor list (Result:1549)
SELECT COUNT(emp_no)
FROM eligible_mentorlist

SELECT title, COUNT(*)
FROM eligible_mentorlist
GROUP BY title;

