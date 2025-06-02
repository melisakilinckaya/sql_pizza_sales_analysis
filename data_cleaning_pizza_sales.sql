
-- VERÝ HAZIRLIÐI ve TEMÝZLÝÐÝ 

SELECT 
COLUMN_NAME,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH,
IS_NULLABLE
FROM
INFORMATION_SCHEMA.COLUMNS
WHERE
TABLE_NAME='pizza_sales'; -- Tablo içindeki sütun isimlerini, veri tiplerini, uzunluklarýný ve NULL olup olmadýðýný kontrol ettim.

EXEC sp_rename 'pizza_sales.Location', 'Location_Name', 'COLUMN'; -- Location olan (keyword) Location_Name olarak deðiþtirdim. 

UPDATE pizza_sales
SET Restaurant_Name = 'Marco''s Pizza'
WHERE Restaurant_Name LIKE 'Marco?s Pizza'; -- Karakter hatasý 

SELECT 'Pizza_Size' AS ColumnName, Pizza_Size AS Value
FROM pizza_sales
GROUP BY Pizza_Size 

UNION ALL

SELECT 'Pizza_Type' AS ColumnName, Pizza_Type AS Value 
FROM pizza_sales
GROUP BY Pizza_Type 

UNION ALL

SELECT 'Traffic_Level' AS ColumnName, Traffic_Level AS Value
FROM pizza_sales
GROUP BY Traffic_Level 

UNION ALL 

SELECT 'Payment_Method' AS ColumnName, Payment_Method AS Value
FROM pizza_sales
GROUP BY Payment_Method  -- Deðerlere baktým, tutarlý olup olmadýðýný kontrol ettim.

SELECT * FROM pizza_sales
WHERE Distance_km < 0 OR Distance_km > 100; -- aykýrý deðer var mý?

SELECT * FROM pizza_sales
WHERE Delivery_Duration_min < 0 OR Delivery_Duration_min > 240; -- aykýrý deðer var mý?

SELECT * FROM pizza_sales
WHERE Delivery_Time < Order_Time; -- Teslimat zamaný sipariþ zamanýndan önce olan kayýt var mý? 

SELECT Order_ID, COUNT(*)
FROM pizza_sales
GROUP BY Order_ID 
HAVING COUNT(*) > 1; -- Tekrarlayan kayýt var mý?

SELECT * FROM pizza_sales
WHERE DATEDIFF(MINUTE, Order_Time, Delivery_Time) <> Delivery_Duration_min; -- Teslimat süresi tutarlý mý? 


-- KEÞÝFSEL VERÝ ANALÝZÝ (EDA) 

-- Toplam sipariþ sayýsý 
SELECT COUNT(*) AS Total_Orders FROM pizza_sales; 

-- Restoranlara göre sipariþ sayýsý 
SELECT Restaurant_Name, COUNT(*) AS Order_Count
FROM pizza_sales
GROUP BY Restaurant_Name
ORDER BY Order_Count DESC; 

--Konuma göre sipariþ sayýsý 
SELECT Location_Name, COUNT(*) AS Location_Count
FROM pizza_sales 
GROUP BY Location_Name
ORDER BY Location_Count DESC;

-- Konuma göre en çok sipariþ veren 5 þehir 
SELECT TOP 5
Location_Name, COUNT(*) AS Location_Count
FROM pizza_sales 
GROUP BY Location_Name
ORDER BY Location_Count DESC; 

-- Sipariþ saatlerine göre sipariþ sayýsý
SELECT 
FORMAT(Order_Time, 'HH:mm')AS Order_Hour,
COUNT(*) AS Order_Time_Count
FROM pizza_sales
GROUP BY FORMAT(Order_Time, 'HH:mm')
ORDER BY Order_Time_Count DESC;

-- Ortalama, minimum, maksimum teslimat süresi (dakika)
SELECT
AVG(Delivery_Duration_min) AS  Avg_Delivery_Duration_min, -- 29 dakika
MIN(Delivery_Duration_min) AS Min_Delivery_Duration_min, -- 15 dakika 
MAX(Delivery_Duration_min) AS Max_Delivery_Duration_min -- 50 dakika 
FROM pizza_sales;

-- Pizza boyutlarýna göre sipariþ sayýsý
SELECT Pizza_Size, COUNT(*) AS Pizza_Size_Count
FROM pizza_sales
GROUP BY Pizza_Size
ORDER BY Pizza_Size_Count DESC; 

-- Pizza türlerine göre sipariþ sayýsý 
SELECT Pizza_Type, COUNT(*) AS Pizza_Type_Count
FROM pizza_sales 
GROUP BY Pizza_Type
ORDER BY Pizza_Type_Count DESC; 

-- Trafik seviyesine göre ortalama teslimat süresi 
SELECT Traffic_Level, AVG(Delivery_Duration_min) AS Avg_Delivery_Duration
FROM pizza_sales
GROUP BY Traffic_Level 

-- Pizza boyutuna göre ortalama teslimat süresi 
SELECT Pizza_Size, AVG(Delivery_Duration_min) Avg_Pizza_Size_Delivery_Duration
FROM pizza_sales 
GROUP BY Pizza_Size;

-- Restoranlara göre ortalama teslimat süresi
SELECT Restaurant_Name, AVG(Delivery_Duration_min) AS Avg_Restaurant_Delivery_Duration
FROM pizza_sales
GROUP BY Restaurant_Name
ORDER BY Avg_Restaurant_Delivery_Duration 

-- Sipariþ saatine göre ortalama teslimat süreleri 
SELECT 
DATEPART(HOUR, Order_Time) AS Order_Hour,
AVG(Delivery_Duration_min) AS Avg_Order_Delivery_Duration 
FROM pizza_sales
GROUP BY DATEPART(HOUR, Order_Time)
ORDER BY Order_Hour DESC; 

-- Verilen sipariþler (Haftanýn  günlerine göre)
SELECT
DATENAME(WEEKDAY, Order_Time) AS Weekday_Name,
DATEPART(WEEKDAY, Order_Time) AS Weekday_Number,
COUNT(*) AS Order_Count
FROM pizza_sales
GROUP BY
DATENAME(WEEKDAY, Order_Time),
DATEPART(WEEKDAY, Order_Time)
ORDER BY Order_Count DESC;

-- Ödeme yöntemine göre sipariþ sayýsý
SELECT Payment_Method, COUNT(*) AS Payment_Method_Count
FROM pizza_sales
GROUP BY Payment_Method
ORDER BY Payment_Method_Count DESC; 

-- Ödeme kategorisine göre sipariþ sayýsý 
SELECT Payment_Category, COUNT(*) AS Payment_Category_Count
FROM pizza_sales
GROUP BY Payment_Category
ORDER BY Payment_Category_Count DESC; 

-- Restoran bazýnda saat dilimlerine göre ortalama teslimat süreleri 
SELECT 
Restaurant_Name,
DATEPART(HOUR, Order_Time) AS HOUR,
COUNT(*) AS Order_Count,
AVG(Delivery_Duration_min) AS Avg_Delivery_Duration
FROM pizza_sales
GROUP BY 
Restaurant_Name,
DATEPART(HOUR, Order_Time)
ORDER BY 
Restaurant_Name,
Hour;

-- 'Small' ve 'XL' pizza boyutlarýnýn Trafik yoðunluðuna göre ortalama teslimat süreleri 
SELECT
Traffic_Level,
AVG(CASE WHEN Pizza_Size = 'Small' THEN Delivery_Duration_min END) AS Small_Avg_Duration,
AVG(CASE WHEN Pizza_Size = 'XL' THEN Delivery_Duration_min END) AS XL_Avg_Duration
FROM pizza_sales
GROUP BY Traffic_Level
ORDER BY Traffic_Level;



















