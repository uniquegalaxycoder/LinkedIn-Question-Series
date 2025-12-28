"""
❓ Interview Question (Joins Foundation)

You have two tables:

employee

emp_id, emp_name, depart_id

department

depart_id, depart_name, manager_id

Rules:

Every employee may or may not belong to a department

Every department may or may not have employees

manager_id in department refers to emp_id of employee table

🎯 Write a query to return:

All department names

Number of employees in each department

Manager name of that department

Even if department has 0 employees, it should still appear

Bonus check: Order result by employee count descending.

"""

CREATE TABLE employee (
  emp_id BIGINT PRIMARY KEY,
  emp_name VARCHAR(20),
  depart_id BIGINT NULL
);

CREATE TABLE department (
  depart_id BIGINT PRIMARY KEY,
  depart_name VARCHAR(20),
  manager_id BIGINT NULL
);

INSERT INTO employee (emp_id, emp_name, depart_id) VALUES
(101, 'Omkar', 1),
(102, 'Amit', 1),
(103, 'Priya', 2),
(104, 'Rahul', 2),
(105, 'Sneha', 3),
(106, 'John', 3),
(107, 'Sara', 3),
(108, 'Mike', 4),
(109, 'Alex', 4),
(110, 'Neha', NULL),
(111, 'David', 2),
(112, 'Kiran', 1);

INSERT INTO department (depart_id, depart_name, manager_id) VALUES
(1, 'Operations', 101),
(2, 'Marketing', 103),
(3, 'Food Delivery', 105),
(4, 'Tech Support', 108),
(5, 'Legal', 110);


select * from employee;
select * from department ;

with cte1 AS (
  select
    a.emp_id,
    a.emp_name,
    a.depart_id,
    b.depart_name,
    b.manager_id
  from 
      employee as a 
  left join 
      department as b 
  on 
      a.depart_id = b.depart_id 
)

,cte2 as (
select 
  x.*,
  y.emp_name as manager_name
from 
  cte1 as x 
left join 
  cte1 as y
on 
  x.manager_id = y.emp_id
)

select 
  department.depart_id,
  department.depart_name,
  cte2.manager_name,
  count(cte2.emp_id) as total_emp
from 
    department  
left join 
    cte2
on 
  department.depart_id = cte2.depart_id
and 
  department.manager_id = cte2.manager_id
group by 
  department.depart_id, 
  department.depart_name,
  department.manager_id
order by 
  count(cte2.emp_id) desc
  ;
