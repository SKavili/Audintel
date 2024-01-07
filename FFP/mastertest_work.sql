create database test1;
use test1;

CREATE TABLE employee (employee_name VARCHAR(40),employee_id INT,salary INT,manager_id INT,hire_date DATE);
INSERT INTO employee VALUES
('John Doe', 1, 60000, 0, '2022-01-01'),
('Jane Smith', 2, 70000, 0, '2022-02-15'),
('Bob Johnson', 3, 80000, 0, '2023-03-20'),
('Alice Williams', 4, 75000, 0, '2023-04-10'),
('Charlie Brown', 5, 90000, 2, '2024-05-05'),
('David Lee', 6, 95000, 0, '2024-06-15'),
('Emma Davis', 7, 100000, 3, '2024-07-20'),
('Frank Miller', 8, 85000, 0, '2025-08-10'),
('Grace Taylor', 9, 92000, 0, '2025-09-05'),
('Henry Wilson', 10, 98000, 3, '2025-10-15');
Truncate table employee;
select year(hire_date) as hired_year,
count(*) from employee group by hired_year;

Select * from employee 
order by salary desc Limit 5;

Select e.employee_name, m.employee_name AS manager 
from employee e
INNER JOIN employee m ON e.manager_id = m.employee_id;
Drop table employees;

CREATE TABLE employees (employee_id INT PRIMARY KEY,employee_name VARCHAR(40),job_title VARCHAR(40));

CREATE TABLE project (project_id INT PRIMARY KEY,project_name VARCHAR(40));

CREATE TABLE employee_projects (employee_id INT,project_id INT,FOREIGN KEY (employee_id) REFERENCES employees(employee_id),FOREIGN KEY (project_id) REFERENCES project(project_id)
);

INSERT INTO employees VALUES
(1, 'John Doe', 'Software Engineer'),
(2, 'Jane Smith', 'Project Manager'),
(3, 'Bob Johnson', 'Data Analyst'),
(4, 'Alice Williams', 'UI/UX Designer');

INSERT INTO project VALUES
(101, 'Project A'),
(102, 'Project B'),
(103, 'Project C');

INSERT INTO employee_projects VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 101),
(1, 102),
(2, 103);


select e.employee_name,e.job_title,count(p.project_name)
as projects from employees e JOIN employee_projects 
ep on e.employee_id = ep.employee_id join project p 
on ep.project_id = p.project_id group by e.employee_name
,e.job_title order by projects;


CREATE TABLE assignments (assignment_id INT PRIMARY KEY,employee_id INT,hours_worked INT,
FOREIGN KEY (employee_id) REFERENCES employees(employee_id));

INSERT INTO assignments VALUES
(1001, 1, 50),
(1002, 1, 75),
(1003, 2, 120),
(1004, 2, 90),
(1005, 3, 60);


with cte as(select e.employee_name from employee e 
join assignments a on e.employee_id=a.employee_id
group by e.employee_name)
select employee_name from cte;
