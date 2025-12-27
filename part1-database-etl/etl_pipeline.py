"""
FlexiMart ETL Pipeline
Part 1 – Database Design and ETL Implementation

This script:
- Extracts raw CSV files
- Cleans and validates data quality issues
- Loads clean data into MySQL database
- Generates a data quality report

No data values are fabricated.
Invalid records are explicitly dropped and reported.
"""

import pandas as pd
import mysql.connector
import re
from datetime import datetime

# --------------------------------------------------
# Database Configuration (update password if needed)
# --------------------------------------------------
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "password",
    "database": "fleximart"
}

# --------------------------------------------------
# Utility Functions
# --------------------------------------------------
def standardize_phone(phone):
    if pd.isna(phone):
        return None
    digits = re.sub(r"\D", "", str(phone))
    if digits.startswith("91"):
        digits = digits[2:]
    if digits.startswith("0"):
        digits = digits[1:]
    if len(digits) == 10:
        return f"+91-{digits}"
    return None


def parse_date(value):
    if pd.isna(value):
        return None
    for fmt in ("%Y-%m-%d", "%d/%m/%Y", "%m-%d-%Y", "%m/%d/%Y"):
        try:
            return datetime.strptime(str(value), fmt).date()
        except ValueError:
            continue
    return None


def standardize_category(category):
    if pd.isna(category):
        return None
    return str(category).strip().title()


# --------------------------------------------------
# Extract
# --------------------------------------------------
customers_df = pd.read_csv("data/customers_raw.csv")
products_df = pd.read_csv("data/products_raw.csv")
sales_df = pd.read_csv("data/sales_raw.csv")

# --------------------------------------------------
# Data Quality Counters
# --------------------------------------------------
customers_read = len(customers_df)
products_read = len(products_df)
sales_read = len(sales_df)

# --------------------------------------------------
# Transform – Customers
# --------------------------------------------------
# Remove duplicate customers
customers_df = customers_df.drop_duplicates(subset="customer_id")

# Standardize attributes
customers_df["phone"] = customers_df["phone"].apply(standardize_phone)
customers_df["registration_date"] = customers_df["registration_date"].apply(parse_date)
customers_df["city"] = customers_df["city"].str.title()

# Drop customers with missing mandatory email
invalid_customers = customers_df[customers_df["email"].isna()]
customers_df = customers_df.dropna(subset=["email"])

customers_dropped = len(invalid_customers)

# --------------------------------------------------
# Transform – Products
# --------------------------------------------------
products_df["category"] = products_df["category"].apply(standardize_category)
products_df["product_name"] = products_df["product_name"].str.strip()

# Default stock to 0 where missing (allowed by schema)
products_df["stock_quantity"] = products_df["stock_quantity"].fillna(0)

# Drop products with missing mandatory price
invalid_products = products_df[products_df["price"].isna()]
products_df = products_df.dropna(subset=["price"])

products_dropped = len(invalid_products)

# --------------------------------------------------
# Transform – Sales
# --------------------------------------------------
# Remove duplicate transactions
sales_df = sales_df.drop_duplicates(subset="transaction_id")

# Standardize dates
sales_df["transaction_date"] = sales_df["transaction_date"].apply(parse_date)

# Drop sales with missing mandatory fields
sales_df = sales_df.dropna(
    subset=["customer_id", "product_id", "transaction_date"]
)

# --------------------------------------------------
# Load
# --------------------------------------------------
connection = mysql.connector.connect(**DB_CONFIG)
cursor = connection.cursor()

# Insert Customers and create mapping (source ID → surrogate key)
customer_key_map = {}
for _, row in customers_df.iterrows():
    cursor.execute(
        """
        INSERT INTO customers
        (first_name, last_name, email, phone, city, registration_date)
        VALUES (%s, %s, %s, %s, %s, %s)
        """,
        (
            row["first_name"],
            row["last_name"],
            row["email"],
            row["phone"],
            row["city"],
            row["registration_date"]
        )
    )
    customer_key_map[row["customer_id"]] = cursor.lastrowid

# Insert Products and create mapping
product_key_map = {}
for _, row in products_df.iterrows():
    cursor.execute(
        """
        INSERT INTO products
        (product_name, category, price, stock_quantity)
        VALUES (%s, %s, %s, %s)
        """,
        (
            row["product_name"],
            row["category"],
            row["price"],
            row["stock_quantity"]
        )
    )
    product_key_map[row["product_id"]] = cursor.lastrowid

# Filter valid sales (must have existing customer and product)
valid_sales = sales_df[
    sales_df["customer_id"].isin(customer_key_map.keys()) &
    sales_df["product_id"].isin(product_key_map.keys())
]

sales_loaded = len(valid_sales)
sales_dropped = sales_read - sales_loaded

# Insert Orders and Order Items
for _, row in valid_sales.iterrows():
    total_amount = row["quantity"] * row["unit_price"]

    cursor.execute(
        """
        INSERT INTO orders
        (customer_id, order_date, total_amount, status)
        VALUES (%s, %s, %s, %s)
        """,
        (
            customer_key_map[row["customer_id"]],
            row["transaction_date"],
            total_amount,
            row["status"]
        )
    )

    order_id = cursor.lastrowid

    cursor.execute(
        """
        INSERT INTO order_items
        (order_id, product_id, quantity, unit_price, subtotal)
        VALUES (%s, %s, %s, %s, %s)
        """,
        (
            order_id,
            product_key_map[row["product_id"]],
            row["quantity"],
            row["unit_price"],
            total_amount
        )
    )

connection.commit()
cursor.close()
connection.close()

# --------------------------------------------------
# Data Quality Report
# --------------------------------------------------
with open("part1-database-etl/data_quality_report.txt", "w") as report:
    report.write(f"Customers read: {customers_read}\n")
    report.write(f"Customers dropped (missing email): {customers_dropped}\n")
    report.write(f"Products read: {products_read}\n")
    report.write(f"Products dropped (missing price): {products_dropped}\n")
    report.write(f"Sales read: {sales_read}\n")
    report.write(f"Sales dropped (missing or invalid references): {sales_dropped}\n")
    report.write(f"Sales loaded successfully: {sales_loaded}\n")

print("ETL pipeline executed successfully.")
