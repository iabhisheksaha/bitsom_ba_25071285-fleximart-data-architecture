# FlexiMart Data Warehouse – Star Schema Design

## Section 1: Schema Overview

### FACT TABLE: fact_sales
**Grain:**  
One row per product per order line item.

**Business Process:**  
Sales transactions generated from customer purchases.

**Measures (Numeric Facts):**
- quantity_sold: Number of units sold per line item
- unit_price: Price per unit at the time of sale
- discount_amount: Discount applied to the line item
- total_amount: Final sales amount (quantity × unit_price − discount)

**Foreign Keys:**
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer

---

### DIMENSION TABLE: dim_date
**Purpose:**  
Supports time-based analysis and reporting.

**Type:**  
Conformed dimension.

**Attributes:**
- date_key (PK): Surrogate key in YYYYMMDD format
- full_date: Calendar date
- day_of_week: Day name
- day_of_month: Numeric day
- month: Month number
- month_name: Month name
- quarter: Quarter (Q1–Q4)
- year: Calendar year
- is_weekend: Indicates weekend or weekday

---

### DIMENSION TABLE: dim_product
**Purpose:**  
Stores descriptive product attributes for analysis.

**Attributes:**
- product_key (PK): Surrogate key
- product_id: Source system product identifier
- product_name: Name of the product
- category: Product category
- subcategory: Product subcategory
- unit_price: Standard unit price

---

### DIMENSION TABLE: dim_customer
**Purpose:**  
Stores customer demographic and segmentation details.

**Attributes:**
- customer_key (PK): Surrogate key
- customer_id: Source system customer identifier
- customer_name: Full customer name
- city: Customer city
- state: Customer state
- customer_segment: Business-defined segment

---

## Section 2: Design Decisions

The transaction line-item grain was chosen to enable the most detailed level of analysis, such as product-level revenue, customer purchasing behavior, and time-based trends. This granularity supports both high-level summaries and detailed drill-downs.

Surrogate keys are used instead of natural keys to improve query performance, maintain historical consistency, and isolate the warehouse from changes in source system identifiers. They also simplify joins between fact and dimension tables.

The star schema design supports efficient roll-up and drill-down operations. Analysts can aggregate data across dimensions such as time, product category, or customer segment while still being able to drill down to individual transactions when required.

---

## Section 3: Sample Data Flow

**Source Transaction:**  
Order #101, Customer "John Doe", Product "Laptop", Quantity: 2, Price: 50000

**Data Warehouse Representation:**

**fact_sales:**  
{
  date_key: 20240115,
  product_key: 5,
  customer_key: 12,
  quantity_sold: 2,
  unit_price: 50000,
  discount_amount: 0,
  total_amount: 100000
}

**dim_date:**  
{ date_key: 20240115, full_date: '2024-01-15', month: 1, quarter: 'Q1' }

**dim_product:**  
{ product_key: 5, product_name: 'Laptop', category: 'Electronics' }

**dim_customer:**  
{ customer_key: 12, customer_name: 'John Doe', city: 'Mumbai' }
