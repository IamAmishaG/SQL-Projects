USE PORTFOLIO;
SELECT * FROM Orders;

--------------------------------------------------------------TOTAL NO. OF ORDERS AND SALES ------------------------------------------------------------------

SELECT COUNT(OrderID) AS Total_Orders, SUM(Sales) AS Total_Sales FROM Orders;

---------------------------------------------------------------MONTHLY AND DAILY SALES AVERAGE ----------------------------------------------------------------

SELECT 
    OrderDate, 
    AVG(Sales) AS Average_Sales
FROM Orders 
GROUP BY OrderDate ORDER BY OrderDate ASC;


SELECT 
    MONTH(OrderDate) AS month, 
    AVG(Sales) AS Average_Sales
FROM Orders
GROUP BY MONTH(OrderDate) ORDER BY month  ASC;

--------------------------------------------------------------- SALES AND PROFIT MADE PER YEAR -----------------------------------------------------------------

SELECT 
	YEAR(OrderDate) AS SaleYear, 
	ROUND(SUM(Sales),2) AS Total_sales,	
	ROUND(SUM(Profit),2) AS Total_profit
FROM Orders 
GROUP BY YEAR(OrderDate) ORDER BY YEAR(OrderDate); 

------------------------------------------------------------------SALES, PROFIT BY MONTH AND RUNNING TOTAL PROFIT -----------------------------------------------------

SELECT 
    MONTH(OrderDate) AS Month, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit, 
    SUM(SUM(Profit)) OVER (ORDER BY MONTH(OrderDate)) AS Running_Total_Profit 
FROM Orders 
GROUP BY MONTH(OrderDate);

-------------------------------------------------------------------- TOP 10 PRODUCTS BY SALES-----------------------------------------------------------------------------

SELECT top(10) [Product Name], SUM(Sales) AS Total_Sales 
FROM Orders 
GROUP BY [Product Name] ORDER BY Total_Sales DESC;

-------------------------------------------------------------------- TOP 10 HIGHEST SALES ORDER DETAILS  ------------------------------------------------------------------------

SELECT TOP(10) RANK() OVER (ORDER BY Sales DESC) as Rank, * 
FROM Orders;

--------------------------------------------------------------------- 7 DAY MOVING AVERAGE OF SALES ------------------------------------------------------------------

SELECT OrderDate, SUM(Sales) OVER (ORDER BY OrderDate ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) / 7 AS seven_day_sales_avg
FROM Orders;

--------------------------------------------------------------------- 2 CONSECUTIVE DAY DISCOUNTS -------------------------------------------------------------

WITH discount_cte AS (
  SELECT OrderDate, SUM(Discount) AS total_discount
  FROM orders
  GROUP BY OrderDate
)
SELECT curr.OrderDate, curr.total_discount AS curr_discount, prev.total_discount AS prev_discount,
  curr.total_discount - prev.total_discount AS discount_change
FROM discount_cte AS curr
LEFT JOIN discount_cte AS prev ON DATEDIFF(day, 1, curr.OrderDate) = prev.OrderDate;

--------------------------------------------------------------------TOP 5 CITIES WITH HIGHEST AVG. PROFIT PER ORDER -------------------------------------------------------------------------

SELECT TOP(5)
    City, 
    AVG(Profit/Quantity) AS Avg_Profit_Per_Order 
FROM Orders 
GROUP BY City ORDER BY Avg_Profit_Per_Order DESC;


