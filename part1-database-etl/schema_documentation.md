# FlexiMart Database Schema Documentation

## Entity–Relationship Description

### ENTITY: customers
**Purpose:**  
Stores master data related to customers registered on the FlexiMart platform.

**Attributes:**
- customer_id: Surrogate primary key, uniquely identifies each customer
- first_name: Customer’s first name
- last_name: Customer’s last name
- email: Unique email address used for customer identification and communication
- phone: Contact number stored in standardized format
- city: City of residence
- registration_date: Date when the customer registered on the platform

**Relationships:**
- One customer can place many orders  
  (1:M relationship with the orders table)

---

### ENTITY: products
**Purpose:**  
Stores product catalog information available for sale on FlexiMart.

**Attributes:**
- product_id: Surrogate primary key for each product
- product_name: Name of the product
- category: Standardized product category (e.g., Electronics, Fashion)
- price: Unit price of the product
- stock_quantity: Available inventory count

**Relationships:**
- One product can appear in many order items  
  (1:M relationship with the order_items table)

---

### ENTITY: orders
**Purpose:**  
Stores high-level order transaction details.

**Attributes:**
- order_id: Surrogate primary key for each order
- customer_id: Foreign key referencing customers.customer_id
- order_date: Date when the order was placed
- total_amount: Total monetary value of the order
- status: Order status (e.g., Completed, Pending, Cancelled)

**Relationships:**
- Each order belongs to exactly one customer  
- Each order can contain multiple order items  
  (1:M relationship with order_items)

---

### ENTITY: order_items
**Purpose:**  
Stores line-level details of products purchased in each order.

**Attributes:**
- order_item_id: Surrogate primary key
- order_id: Foreign key referencing orders.order_id
- product_id: Foreign key referencing products.product_id
- quantity: Number of units purchased
- unit_price: Price per unit at time of purchase
- subtotal: Calculated as quantity × unit_price

**Relationships:**
- Many order items belong to one order  
- Each order item references one product

---

## Normalization Explanation (Third Normal Form – 3NF)

The FlexiMart database schema is designed in Third Normal Form (3NF) to ensure data integrity, eliminate redundancy, and support scalable transactional processing.

First Normal Form (1NF) is satisfied because all tables contain atomic values with no repeating groups or multivalued attributes. Each table has a clearly defined primary key that uniquely identifies every record.

Second Normal Form (2NF) is achieved as all non-key attributes are fully functionally dependent on the entire primary key. For example, in the order_items table, attributes such as quantity, unit_price, and subtotal depend on the order_item_id and not partially on order_id or product_id alone.

Third Normal Form (3NF) is satisfied because there are no transitive dependencies. Non-key attributes depend only on the primary key of their respective tables. Customer details are stored only in the customers table, product details only in the products table, and transactional data is separated into orders and order_items.

This design avoids update anomalies by ensuring that changes to customer or product information occur in a single place. Insert anomalies are prevented because valid foreign key references are enforced before inserting transactional records. Delete anomalies are avoided since removing an order does not delete customer or product master data.

---

## Sample Data Representation

### customers
| customer_id | first_name | last_name | email                    | city       | registration_date |
|------------|-----------|-----------|--------------------------|-----------|-------------------|
| 1          | Rahul     | Sharma    | rahul.sharma@gmail.com   | Bangalore | 2023-01-15        |
| 2          | Priya     | Patel     | priya.patel@yahoo.com    | Mumbai   | 2023-02-20        |

### products
| product_id | product_name        | category     | price    | stock_quantity |
|-----------|---------------------|--------------|----------|----------------|
| 1         | Samsung Galaxy S21  | Electronics  | 45999.00 | 150            |
| 2         | Nike Running Shoes  | Fashion      | 3499.00  | 80             |

### orders
| order_id | customer_id | order_date | total_amount | status     |
|---------|-------------|------------|--------------|------------|
| 1       | 1           | 2024-01-15 | 45999.00     | Completed  |
| 2       | 2           | 2024-01-16 | 5998.00      | Completed  |

### order_items
| order_item_id | order_id | product_id | quantity | unit_price | subtotal |
|--------------|----------|------------|----------|------------|----------|
| 1            | 1        | 1          | 1        | 45999.00   | 45999.00 |
| 2            | 2        | 2          | 2        | 2999.00    | 5998.00  |
