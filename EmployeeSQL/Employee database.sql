--Create Employee table
CREATE TABLE "Employee" ("emp_no"INTEGER NOT NULL PRIMARY KEY,
"birth_date" DATE NOT NULL,
"first_name" VARCHAR(255) NOT NULL,
"last_name" VARCHAR(255) NOT NULL,
"sex"VARCHAR(1) NOT NULL,
"hire_date" DATE NOT NULL
);


--Create Salaries table
CREATE TABLE "Salaries" (
"emp_no" INTEGER NOT NULL,
"salary" INTEGER NOT NULL,
CONSTRAINT "pk_Salaries" PRIMARY KEY ("emp_no", "salary"),
CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY ("emp_no") references "Employee" ("emp_no")
);

-- Drop the existing Departments table
DROP TABLE IF EXISTS "Departments";

--Create Dapartments table
CREATE TABLE "Departments"
("dept_no" INTEGER NOT NULL PRIMARY KEY,
"dept_name" VARCHAR(255) NOT NULL
);

-- Drop the existing dept_emp table
DROP TABLE IF EXISTS "dept_emp";

--Create dept_emp table
CREATE TABLE "dept_emp"(
"emp_no" INTEGER NOT NULL,
"dept_no" INTEGER NOT NULL,
CONSTRAINT "pk_dept_emp" PRIMARY KEY ("emp_no", "dept_no"),
CONSTRAINT "fk_dept_emp_no" FOREIGN KEY ("emp_no") REFERENCES "Employee" ("emp_no"),
CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no")
);


--Create Dept_manager table
CREATE TABLE "dept_manager"(
"dept_no" INTEGER NOT NULL,
"emp_no" INTEGER NOT NULL,
CONSTRAINT "pk_dept_manager" PRIMARY KEY("dept_no","emp_no"),
CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY ("dept_no")REFERENCES "departments"("dept_no"),
CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY ("emp_no") REFERENCES "Employee" ("emp_no")
);

-- Create Titles table
CREATE TABLE "Titles" (
    "title_id" INTEGER NOT NULL PRIMARY KEY,
    "title" VARCHAR(255) NOT NULL
);	
	
	