
-- =====================================================
-- 🍕 Pizza Sales SQL Project (Basic → Advanced Queries)
-- =====================================================

-- Table structure (assuming CSV already imported)






=============================
--  KPI QUERIES 
-- =====================================================
SELECT * FROM dbo.pizza_sales
-- Total Revenue
SELECT ROUND(SUM(total_price),2) AS total_revenue
FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

-- Average Order Value
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id),2) AS avg_order_value
FROM pizza_sales;

-- =====================================================
-- TRENDS & ANALYSIS (Intermediate)
-- =====================================================

-- Daily Trend (Orders per Day)
SELECT order_date, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_date
ORDER BY order_date;

-- Hourly Trend (Orders by Hour of Day)
SELECT 
    DATEPART(HOUR, order_time) AS order_hour, 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY order_hour;

--Best-selling pizza names
SELECT pizza_name, SUM(quantity) AS total_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold DESC;

-- Revenue by Pizza Category
SELECT pizza_category, ROUND(SUM(total_price),2) AS revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY revenue DESC;

-- Revenue by Pizza Size
SELECT pizza_size, ROUND(SUM(total_price),2) AS revenue
FROM pizza_sales
GROUP BY pizza_size
ORDER BY revenue DESC;

-- =====================================================
--Advanced Analysis
-- =====================================================

-- A) Rolling 7-Day Average Revenue
WITH daily_revenue AS (
  SELECT order_date, SUM(total_price) AS revenue
  FROM pizza_sales
  GROUP BY order_date
)
SELECT order_date,
       revenue,
       ROUND(AVG(revenue) OVER (ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS rolling_7d_avg
FROM daily_revenue;

-- B) Top 5 Best-Selling Pizzas Each Month
WITH monthly_sales AS (
    SELECT 
        MONTH(order_date) AS ordermonth, 
        pizza_name, 
        SUM(quantity) AS total_sold
    FROM pizza_sales
    GROUP BY MONTH(order_date), pizza_name
),
ranked AS (
    SELECT 
        ordermonth, 
        pizza_name, 
        total_sold,
        RANK() OVER (PARTITION BY ordermonth ORDER BY total_sold DESC) AS rnk
    FROM monthly_sales
)
SELECT ordermonth, pizza_name, total_sold
FROM ranked
WHERE rnk <= 5
ORDER BY ordermonth, rnk;

-- C) Pareto Analysis (80/20 Rule)
WITH pizza_revenue AS (
  SELECT pizza_name, SUM(total_price) AS revenue
  FROM pizza_sales
  GROUP BY pizza_name
),
ranked AS (
  SELECT pizza_name, revenue,
         ROUND(100 * SUM(revenue) OVER (ORDER BY revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
               / SUM(revenue) OVER (),2) AS cum_percent
  FROM pizza_revenue
)
SELECT pizza_name, revenue, cum_percent
FROM ranked
WHERE cum_percent <= 80;

-- D) Month-over-Month Revenue Growth
SELECT FORMAT(order_date, 'yyyy-MM') AS month,
       ROUND(SUM(total_price),2) AS revenue,
       LAG(ROUND(SUM(total_price),2)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')) AS prev_month,
       ROUND((SUM(total_price) - LAG(SUM(total_price)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')))
             / LAG(SUM(total_price)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')) * 100,2) AS mom_growth
FROM pizza_sales
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY month;


