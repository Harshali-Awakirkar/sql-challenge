CREATE TABLE emp_salary
(
    emp_id INTEGER  NOT NULL,
    name NVARCHAR(20)  NOT NULL,
    salary NVARCHAR(30),
    dept_id INTEGER
);


INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

-- Write a sql query to return all employee whose salary is same in same department
with Dep_Salary as (
	select dept_id, salary 
	from emp_salary
	group by dept_id, salary 
	having count(*) > 1)
select 
	* 
from emp_salary es
inner join dep_salary ds
on es.dept_id = ds.dept_id and es.salary = ds. salary;
with cte as (
select 
	*,
    dense_rank() over(partition by dept_id order by salary) as rnk
from emp_salary)
select * from cte 
where count(*) > 1;

WITH cte AS (
  SELECT *,
    COUNT(*) OVER (PARTITION BY dept_id, salary) Same_dep_salary
  FROM emp_salary
)
SELECT 
	*
FROM cte
WHERE Same_dep_salary > 1;