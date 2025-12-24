# Retail Sales Analysis (SQL & SQLite)

This project performs an end-to-end analysis of retail sales data using SQL and SQLite.

The goal of this project is to practice SQL-based data analysis, including data cleaning, aggregation, window functions, and time-based analysis, using a public retail dataset.

---

## Dataset
- Public retail sales dataset (CSV format)
- Contains transaction-level data including date, time, customer information, product category, and sales values

---

## Tools & Technologies
- SQLite
- SQL (CTEs, CASE statements, window functions)
- Python (to transform csv into SQL database)
- VS Code

---

## Key Analysis Performed
- Data cleaning using SQL views
- Total and average sales analysis by category
- Customer-level sales aggregation
- Monthly sales trend analysis
- Identification of best-performing months using window functions
- Sales distribution across daily time shifts (Morning / Afternoon / Evening)

---

## Project Structure
├── Query.sql # SQL queries for analysis
├── import_csv_to_sqlite.py # Python script to load CSV into SQLite
├── retail_sales.db # SQLite database
└── README.md


---

## Acknowledgement
This project reimplements the analysis using the same public dataset as the following reference project:
https://github.com/najirh/Retail-Sales-Analysis-SQL-Project--P1

The analysis was implemented by reworking a reference solution and independently executing all queries to understand the full SQL analytics workflow.
