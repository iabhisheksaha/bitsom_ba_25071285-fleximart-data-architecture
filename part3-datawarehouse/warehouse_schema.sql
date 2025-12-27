USE fleximart_dw;

-- =====================================================
-- DIM_DATE (30 dates: Jan–Feb 2024)
-- =====================================================

INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,false),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,false),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,false),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,false),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,false),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,true),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,true),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,false),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,false),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,false),
(20240111,'2024-01-11','Thursday',11,1,'January','Q1',2024,false),
(20240112,'2024-01-12','Friday',12,1,'January','Q1',2024,false),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,true),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,true),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,false),
(20240116,'2024-01-16','Tuesday',16,1,'January','Q1',2024,false),
(20240117,'2024-01-17','Wednesday',17,1,'January','Q1',2024,false),
(20240118,'2024-01-18','Thursday',18,1,'January','Q1',2024,false),
(20240119,'2024-01-19','Friday',19,1,'January','Q1',2024,false),
(20240120,'2024-01-20','Saturday',20,1,'January','Q1',2024,true),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,false),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,false),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,true),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,true),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,false),
(20240206,'2024-02-06','Tuesday',6,2,'February','Q1',2024,false),
(20240207,'2024-02-07','Wednesday',7,2,'February','Q1',2024,false),
(20240208,'2024-02-08','Thursday',8,2,'February','Q1',2024,false),
(20240209,'2024-02-09','Friday',9,2,'February','Q1',2024,false),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,true);

-- =====================================================
-- DIM_PRODUCT (15 products, 3 categories)
-- =====================================================

INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Samsung Galaxy S21','Electronics','Smartphones',45999),
('P002','Apple MacBook Pro','Electronics','Laptops',52999),
('P003','Sony Headphones','Electronics','Audio',1999),
('P004','Dell Monitor','Electronics','Monitors',12999),
('P005','iPhone 13','Electronics','Smartphones',69999),
('P006','Levi Jeans','Fashion','Clothing',2999),
('P007','Nike Shoes','Fashion','Footwear',3499),
('P008','Adidas T-Shirt','Fashion','Clothing',1299),
('P009','Puma Sneakers','Fashion','Footwear',4599),
('P010','H&M Shirt','Fashion','Clothing',1999),
('P011','Organic Rice','Groceries','Staples',650),
('P012','Organic Almonds','Groceries','Dry Fruits',899),
('P013','Organic Honey','Groceries','Condiments',450),
('P014','Masoor Dal','Groceries','Pulses',120),
('P015','Basmati Rice','Groceries','Staples',750);

-- =====================================================
-- DIM_CUSTOMER (12 customers, 4 cities)
-- =====================================================

INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','Rahul Sharma','Bangalore','Karnataka','Retail'),
('C002','Priya Patel','Mumbai','Maharashtra','Retail'),
('C003','Amit Kumar','Delhi','Delhi','Retail'),
('C004','Sneha Reddy','Hyderabad','Telangana','Retail'),
('C005','Vikram Singh','Chennai','Tamil Nadu','Retail'),
('C006','Anjali Mehta','Bangalore','Karnataka','Retail'),
('C007','Ravi Verma','Pune','Maharashtra','Retail'),
('C008','Pooja Iyer','Bangalore','Karnataka','Retail'),
('C009','Karthik Nair','Kochi','Kerala','Retail'),
('C010','Deepa Gupta','Delhi','Delhi','Retail'),
('C011','Arjun Rao','Hyderabad','Telangana','Retail'),
('C012','Lakshmi Krishnan','Chennai','Tamil Nadu','Retail');

-- =====================================================
-- FACT_SALES (40 transactions)
-- =====================================================

INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
(20240101,1,1,1,45999,0,45999),
(20240102,2,2,1,52999,0,52999),
(20240103,3,3,2,1999,0,3998),
(20240104,4,4,1,12999,0,12999),
(20240105,5,5,1,69999,0,69999),
(20240106,6,6,2,2999,0,5998),
(20240107,7,7,1,3499,0,3499),
(20240108,8,8,3,1299,0,3897),
(20240109,9,9,1,4599,0,4599),
(20240110,10,10,2,1999,0,3998),
(20240111,11,11,5,650,0,3250),
(20240112,12,12,3,899,0,2697),
(20240113,13,1,2,450,0,900),
(20240114,14,2,10,120,0,1200),
(20240115,15,3,4,750,0,3000),
(20240201,1,4,1,45999,0,45999),
(20240202,2,5,1,52999,0,52999),
(20240203,3,6,2,1999,0,3998),
(20240204,4,7,1,12999,0,12999),
(20240205,5,8,1,69999,0,69999),
(20240206,6,9,2,2999,0,5998),
(20240207,7,10,1,3499,0,3499),
(20240208,8,11,3,1299,0,3897),
(20240209,9,12,1,4599,0,4599),
(20240210,10,1,2,1999,0,3998),
(20240201,11,2,6,650,0,3900),
(20240202,12,3,4,899,0,3596),
(20240203,13,4,2,450,0,900),
(20240204,14,5,12,120,0,1440),
(20240205,15,6,5,750,0,3750),
(20240206,1,7,1,45999,0,45999),
(20240207,2,8,1,52999,0,52999),
(20240208,3,9,2,1999,0,3998),
(20240209,4,10,1,12999,0,12999),
(20240210,5,11,1,69999,0,69999),
(20240210,6,12,2,2999,0,5998);
