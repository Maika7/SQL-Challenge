--- Data Modeling----
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" (PK)   NOT NULL,
    "dept_name" VARCHAR(40)   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" (PK)   NOT NULL,
    "emp_title" VARCHAR(40)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(40)   NOT NULL,
    "last_name" VARCHAR(40)   NOT NULL,
    "sex" CHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" (FK)   NOT NULL,
    "dept_no" (FK)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" (FK)   NOT NULL,
    "emp_no" (FK)   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" (FK)   NOT NULL,
    "salary" NUMERIC(10,2)   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" (PK)   NOT NULL,
    "title" VARCHAR(40)   NOT NULL
);

--- Import each CSV file into its corresponding SQL table

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");




----Data Engineering---
--Create a table schema for each of the six CSV files

CREATE TABLE departments (
    dept_no VARCHAR(4) PRIMARY KEY,  -- Primary Key
    dept_name VARCHAR(40) NOT NULL   -- No foreign key in this table
);

CREATE TABLE employees (
    emp_no INTEGER PRIMARY KEY,      -- Primary Key
    emp_title VARCHAR(40),           -- Job title
    birth_date DATE NOT NULL,        -- Not null constraint on date
    first_name VARCHAR(40) NOT NULL, -- First name cannot be null
    last_name VARCHAR(40) NOT NULL,  -- Last name cannot be null
    sex CHAR(1),                     -- Gender (M/F)
    hire_date DATE NOT NULL          -- Hire date
);


CREATE TABLE dept_emp (
    emp_no INTEGER,                  -- Foreign key to employees
    dept_no VARCHAR(4),              -- Foreign key to departments
    PRIMARY KEY (emp_no, dept_no),    -- Composite primary key
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


CREATE TABLE dept_manager (
    emp_no INTEGER,                  -- Foreign key to employees
    dept_no VARCHAR(4),              -- Foreign key to departments
    PRIMARY KEY (emp_no, dept_no),    -- Composite primary key
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


CREATE TABLE salaries (
    emp_no INTEGER,                  -- Foreign key to employees
    salary NUMERIC(10, 2) NOT NULL,  -- Salary with 2 decimal places
    PRIMARY KEY (emp_no),            -- One-to-one relationship with employees
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);



CREATE TABLE titles (
    title_id SERIAL PRIMARY KEY,     -- Primary key
    title VARCHAR(40) NOT NULL       -- Job title field
);


-----Data Analysis----
---List the employee number, last name, first name, sex, and salary of each employee

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;


---List the first name, last name, and hire date for the employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;


---List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN employees e ON dm.emp_no = e.emp_no
JOIN departments d ON dm.dept_no = d.dept_no;



--- List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT d.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no;



--- List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';



--- List each employee in the Sales department, including their employee number, last name, and first name
SELECT e.emp_no, e.last_name, e.first_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';



----List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');



--- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
