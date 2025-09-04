##🍕 Pizza Sales SQL Project
📌 Overview

This project analyzes pizza sales data using SQL — starting from basic KPIs to advanced business insights. It is designed to showcase SQL skills across different levels:

Basic Queries → KPIs like revenue, orders, and sales volume

Intermediate Queries → Trends, category/size analysis, and best-sellers

Advanced Queries → Rolling averages, ranking, Pareto analysis, and revenue growth

The goal is to provide business intelligence insights that can help a pizza store understand sales performance and make data-driven decisions.

🗂 Dataset

The project assumes you have a table named pizza_sales, typically loaded from a CSV or database.

Sample Schema:

Column	Description
order_id	Unique ID for each order
order_date	Date of the order
order_time	Time of the order
pizza_name	Name of the pizza sold
pizza_category	Category (e.g., Classic, Supreme, Veggie, etc.)
pizza_size	Size of the pizza (S, M, L, XL, etc.)
quantity	Number of pizzas ordered
total_price	Total price of the order
🚀 Features
✅ Basic KPIs

Total Revenue

Total Pizzas Sold

Total Orders

Average Order Value (AOV)

📈 Trends & Analysis (Intermediate)

Orders per Day

Orders by Hour of Day

Best-Selling Pizzas

Revenue by Pizza Category

Revenue by Pizza Size

🔬 Advanced Analysis

Rolling 7-Day Average Revenue

Top 5 Best-Selling Pizzas Each Month

Pareto Analysis (80/20 Rule for Revenue)

Month-over-Month Revenue Growth (%)

🛠️ How to Run

Import your pizza sales dataset into a SQL database (SQL Server / PostgreSQL / MySQL).

Create the table pizza_sales with the schema above.

Load the dataset (CSV → database).

Run the queries in pizza_sales_sql_project.sql
.

📊 Insights You Can Gain

What is the total revenue generated?

Which pizzas are the best sellers?

Which time of day has the most orders?

What pizza sizes/categories bring in the most revenue?

Is revenue following an upward or downward trend month-over-month?

Does the Pareto principle (80% revenue from 20% pizzas) apply?
