USE fleximart_dw;

-- =========================
-- dim_date (Jan–Feb 2024)
-- =========================
INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,FALSE),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,TRUE),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,TRUE),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,TRUE),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,TRUE),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,TRUE),
(20240121,'2024-01-21','Sunday',21,1,'January','Q1',2024,TRUE),
(20240127,'2024-01-27','Saturday',27,1,'January','Q1',2024,TRUE),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,TRUE),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,TRUE),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,TRUE),
(20240211,'2024-02-11','Sunday',11,2,'February','Q1',2024,TRUE),
(20240217,'2024-02-17','Saturday',17,2,'February','Q1',2024,TRUE),
(20240218,'2024-02-18','Sunday',18,2,'February','Q1',2024,TRUE),
(20240224,'2024-02-24','Saturday',24,2,'February','Q1',2024,TRUE);

-- =========================
-- dim_product (15 products)
-- =========================
INSERT INTO dim_product (product_id,product_name,category,subcategory,unit_price) VALUES
('P001','Samsung Galaxy S21','Electronics','Smartphone',45999),
('P002','Nike Running Shoes','Fashion','Footwear',3499),
('P003','Apple MacBook Pro','Electronics','Laptop',52999),
('P004','Levis Jeans','Fashion','Clothing',2999),
('P005','Sony Headphones','Electronics','Audio',1999),
('P006','Organic Almonds','Groceries','Food',899),
('P007','HP Laptop','Electronics','Laptop',52999),
('P008','Adidas T-Shirt','Fashion','Clothing',1299),
('P009','Basmati Rice 5kg','Groceries','Food',650),
('P010','OnePlus Nord','Electronics','Smartphone',45999),
('P011','Puma Sneakers','Fashion','Footwear',4599),
('P012','Dell Monitor','Electronics','Monitor',12999),
('P013','Woodland Shoes','Fashion','Footwear',5499),
('P014','iPhone 13','Electronics','Smartphone',69999),
('P015','Organic Honey','Groceries','Food',450);

-- =========================
-- dim_customer (12 customers)
-- =========================
INSERT INTO dim_customer (customer_id,customer_name,city,state,customer_segment) VALUES
('C001','Rahul Sharma','Bangalore','KA','Retail'),
('C002','Priya Patel','Mumbai','MH','Retail'),
('C003','Amit Kumar','Delhi','DL','Retail'),
('C004','Sneha Reddy','Hyderabad','TS','Retail'),
('C005','Vikram Singh','Chennai','TN','Retail'),
('C006','Anjali Mehta','Bangalore','KA','Retail'),
('C007','Ravi Verma','Pune','MH','Retail'),
('C008','Pooja Iyer','Bangalore','KA','Retail'),
('C009','Karthik Nair','Kochi','KL','Retail'),
('C010','Deepa Gupta','Delhi','DL','Retail'),
('C011','Arjun Rao','Hyderabad','TS','Retail'),
('C012','Lakshmi Krishnan','Chennai','TN','Retail');

-- =========================
-- fact_sales (40 rows)
-- =========================
INSERT INTO fact_sales
(date_key,product_key,customer_key,quantity_sold,unit_price,discount_amount,total_amount)
VALUES
(20240106,1,1,1,45999,0,45999),
(20240107,2,2,2,3499,0,6998),
(20240113,3,3,1,52999,2000,50999),
(20240114,4,4,2,2999,0,5998),
(20240120,5,5,3,1999,0,5997),
(20240121,6,6,5,899,0,4495),
(20240127,7,7,1,52999,0,52999),
(20240203,8,8,4,1299,0,5196),
(20240204,9,9,6,650,0,3900),
(20240210,10,10,1,45999,3000,42999),
(20240211,11,11,2,4599,0,9198),
(20240217,12,12,1,12999,0,12999),
(20240218,13,1,1,5499,0,5499),
(20240224,14,2,1,69999,5000,64999),
(20240224,15,3,5,450,0,2250);
