CREATE TABLE users (
  user_id BIGINT PRIMARY KEY,
  user_name VARCHAR(30)
);

CREATE TABLE orders (
  order_id BIGINT PRIMARY KEY,
  user_id BIGINT,
  order_date DATE,
  order_amount FLOAT(10,2)
);

INSERT INTO users (user_id, user_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Eve'),
(6, 'Alie');

INSERT INTO orders (order_id, user_id, order_date, order_amount) VALUES
(101, 1, '2025-01-01', 500.00),
(102, 1, '2025-01-05', 4150.00),
(103, 1, '2025-01-10', 3010.00),  

(201, 2, '2025-02-02', 800.00),
(202, 2, '2025-02-04', 1100.00),
(203, 2, '2025-02-10', 510.00),  

(301, 3, '2025-03-01', 2200.00),
(302, 3, '2025-03-02', 180.00),
(303, 3, '2025-03-08', 1150.00),  

(401, 4, '2025-04-10', 1000.00),
(402, 4, '2025-04-12', 9999.00),  

(501, 5, '2025-05-01', 300.00),
(502, 5, '2025-05-03', 4600.00),
(503, 5, '2025-05-05', 350.00);  

-- Q.Write a query to find users who have placed orders, but whose latest order amount 
-- is lower than their first ever order amount.


-- select * from users ;
-- select * from orders;


with cte1 as (
  select 
    a.user_id as users_id,
    a.user_name,
    b.order_date,
    b.order_amount,
    row_number()over(partition by a.user_id order by order_date asc) as first_order_number,
    row_number()over(partition by a.user_id order by order_date desc) as last_order_number
  from users as a 
  inner join orders as b 
  on a.user_id = b.user_id
),
cte2 as (
select 
  a.users_id,
  a.user_name,
  a.order_amount as first_order_amount,
  b.order_amount as last_order_amount
from cte1 as a 
join cte1 as b 
on a.users_id = b.users_id
where a.first_order_number = 1 
and b.last_order_number = 1
)

select 
  *
from cte2 
where last_order_amount < first_order_amount ;




