-- Find the customer who made purchases in every category avilable'


CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);


CREATE TABLE sales_items (
    item_id INT PRIMARY KEY, 
    sales_id BIGINT,
    product_id INT,
    user_id BIGINT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO categories (category_id, category_name) VALUES 
(1, 'Electronics'),
(2, 'Fashion'),
(3, 'Sports');

INSERT INTO products (product_id, product_name, category_id) VALUES 
(10, 'Laptop', 1), 
(11, 'Phone', 1),
(12, 'Tablet', 1),
(13, 'Smart Watch', 1),
(14, 'Headphone', 1),
(20, 'T-shirt', 2),
(21, 'Hoodies', 2),
(30, 'Cricket Kit', 3),
(31, 'football gloves', 3),
(33, 'Football Shoes', 3),
(32, 'Shoes', 2),
(22, 'Winter Jacket', 2);


INSERT INTO sales_items (item_id, sales_id, product_id, user_id) VALUES
(1, 1, 10, 3333),  
(2, 1, 20, 2222),  
(3, 1, 30, 4444),  
(4, 2, 10, 2222),  
(5, 2, 11, 3333),  
(6, 2, 20, 4444),  
(7, 4, 30, 2222),  
(8, 5, 31, 1111),  
(9, 3, 10, 3333),  
(10, 7, 21, 7777), 
(11, 3, 11, 4444), 
(12, 4, 10, 4444); 


with cte1 as (
  select 
    a.user_id,
    a.sales_id,
    a.item_id,
    a.product_id,
    b.product_name,
    b.category_id,
    c.category_name
  from 
    sales_items as a 
  left join products as b 
  on 
    a.product_id = b.product_id
  left join 
    categories as c 
  on 
    b.category_id = c.category_id
)

select 
  user_id,
  count(distinct category_id) as total_category
from  cte1
group by user_id
having total_category = ( select count(distinct category_id) from categories) ;
