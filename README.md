# FlexiMart Data Architecture Project

**Student Name:** Abhishek Saha  
**Student ID:** bitsom_ba_25071285  
**Email:** abhisheksaha@live.com  
**Date:** 27/12/2025  

GitHub Repository:  
https://github.com/iabhisheksaha/bitsom_ba_25071285-fleximart-data-architecture

---

## Project Overview

This project implements a complete data architecture for FlexiMart, covering ETL ingestion into MySQL, business analytics using SQL, NoSQL modeling with MongoDB, and a star-schema data warehouse with OLAP queries for decision support.
The solution demonstrates ETL implementation, schema documentation, business-driven SQL analytics, NoSQL suitability analysis, and OLAP-style reporting using a star schema.

---

## Repository Structure
bitsom_ba_25071285-fleximart-data-architecture/
│
├── README.md
├── .gitignore
│
├── data/
│ ├── customers_raw.csv
│ ├── products_raw.csv
│ └── sales_raw.csv
│
├── part1-database-etl/
│ ├── etl_pipeline.py
│ ├── schema_documentation.md
│ ├── business_queries.sql
│ ├── data_quality_report.txt
│ └── README.md
│
├── part2-nosql/
│ ├── nosql_analysis.md
│ ├── mongodb_operations.js
│ ├── products_catalog.json
│ └── README.md
│
└── part3-datawarehouse/
├── star_schema_design.md
├── warehouse_schema.sql
├── warehouse_data.sql
├── analytics_queries.sql
└── README.md


---

## Technologies Used

- **Programming Language:** Python 3.13  
- **Libraries:** pandas, mysql-connector-python  
- **Relational Database:** MySQL 8.0  
- **NoSQL Database:** MongoDB 6.0  
- **Data Formats:** CSV, JSON  
- **Version Control:** Git & GitHub  

---

## Setup Instructions

### 1. Database Setup (MySQL)

```bash
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"
