-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/5EHQwe
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_manager" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

SELECT emp_no, salary
FROM salaries

SELECT emp_no, last_name, first_name, gender
FROM employees

--Question 1: List the following details  of each employee: employee number, last name, first name, gender and salary
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

--Question 2: List employees who were hired in 1986. NOT WORKING
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.hire_date > '1985-12-31' AND e.hire_date < '1987-01-01';

--Question 3: List the manager of each department with the following information:
--department number, department name, the manager's employee number, last name,
--first name and start and end employment dates.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date 
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no JOIN employees ON employees.emp_no = dept_manager.emp_no;

--QUESTION 4: List the department of each employee with the following information:
-- employee number, last name, first name and department name.
SELECT dept_manager.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no JOIN employees ON employees.emp_no = dept_manager.emp_no;

--QUESTION 5: List all employees whose first name is "Hercules" and last name begin with "B"
SELECT employees.first_name, employees.last_name
FROM employees
WHERE employees.first_name = 'Hercules'  AND employees.last_name LIKE 'B%';

--QUESTION 6: List all employees in the Sales department, including their employee number,
--last name, first name and department name.
SELECT dept_manager.emp_no, employees.last_name, employees.first_name, d.dept_name
FROM departments d
INNER JOIN dept_manager ON d.dept_no = dept_manager.dept_no JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE d.dept_name = 'Sales';

--QUESTION 7: List all employees in the Sales and Development departments, including their
--employee number, last name, first name and department name.
SELECT dept_manager.emp_no, employees.last_name, employees.first_name, d.dept_name
FROM departments d
INNER JOIN dept_manager ON d.dept_no = dept_manager.dept_no JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

--QUESTION 8: In descending order, list the frequency count of employee last names,
--i.e., how many employees share each last name. 
SELECT COUNT(last_name), last_name
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;


