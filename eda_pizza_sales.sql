-- KE��FSEL VER� ANAL�Z� (EDA) 

-- Toplam sipari� say�s� 
SELECT COUNT(*) AS Total_Orders FROM pizza_sales; 

-- Restoranlara g�re sipari� say�s� 
SELECT Restaurant_Name, COUNT(*) AS Order_Count
FROM pizza_sales
GROUP BY Restaurant_Name
ORDER BY Order_Count DESC; 

--Konuma g�re sipari� say�s� 
SELECT Location_Name, COUNT(*) AS Location_Count
FROM pizza_sales 
GROUP BY Location_Name
ORDER BY Location_Count DESC;

-- Konuma g�re en �ok sipari� veren 5 �ehir 
SELECT TOP 5
Location_Name, COUNT(*) AS Location_Count
FROM pizza_sales 
GROUP BY Location_Name
ORDER BY Location_Count DESC; 

-- Sipari� saatlerine g�re sipari� say�s�
SELECT 
FORMAT(Order_Time, 'HH:mm')AS Order_Hour,
COUNT(*) AS Order_Time_Count
FROM pizza_sales
GROUP BY FORMAT(Order_Time, 'HH:mm')
ORDER BY Order_Time_Count DESC;

-- Ortalama, minimum, maksimum teslimat s�resi (dakika)
SELECT
AVG(Delivery_Duration_min) AS  Avg_Delivery_Duration_min, -- 29 dakika
MIN(Delivery_Duration_min) AS Min_Delivery_Duration_min, -- 15 dakika 
MAX(Delivery_Duration_min) AS Max_Delivery_Duration_min -- 50 dakika 
FROM pizza_sales;

-- Pizza boyutlar�na g�re sipari� say�s�
SELECT Pizza_Size, COUNT(*) AS Pizza_Size_Count
FROM pizza_sales
GROUP BY Pizza_Size
ORDER BY Pizza_Size_Count DESC; 

-- Pizza t�rlerine g�re sipari� say�s� 
SELECT Pizza_Type, COUNT(*) AS Pizza_Type_Count
FROM pizza_sales 
GROUP BY Pizza_Type
ORDER BY Pizza_Type_Count DESC; 

-- Trafik seviyesine g�re ortalama teslimat s�resi 
SELECT Traffic_Level, AVG(Delivery_Duration_min) AS Avg_Delivery_Duration
FROM pizza_sales
GROUP BY Traffic_Level 

-- Pizza boyutuna g�re ortalama teslimat s�resi 
SELECT Pizza_Size, AVG(Delivery_Duration_min) Avg_Pizza_Size_Delivery_Duration
FROM pizza_sales 
GROUP BY Pizza_Size;

-- Restoranlara g�re ortalama teslimat s�resi
SELECT Restaurant_Name, AVG(Delivery_Duration_min) AS Avg_Restaurant_Delivery_Duration
FROM pizza_sales
GROUP BY Restaurant_Name
ORDER BY Avg_Restaurant_Delivery_Duration 

-- Sipari� saatine g�re ortalama teslimat s�releri 
SELECT 
DATEPART(HOUR, Order_Time) AS Order_Hour,
AVG(Delivery_Duration_min) AS Avg_Order_Delivery_Duration 
FROM pizza_sales
GROUP BY DATEPART(HOUR, Order_Time)
ORDER BY Order_Hour DESC; 

-- Verilen sipari�ler (Haftan�n  g�nlerine g�re)
SELECT
DATENAME(WEEKDAY, Order_Time) AS Weekday_Name,
DATEPART(WEEKDAY, Order_Time) AS Weekday_Number,
COUNT(*) AS Order_Count
FROM pizza_sales
GROUP BY
DATENAME(WEEKDAY, Order_Time),
DATEPART(WEEKDAY, Order_Time)
ORDER BY Order_Count DESC;

-- �deme y�ntemine g�re sipari� say�s�
SELECT Payment_Method, COUNT(*) AS Payment_Method_Count
FROM pizza_sales
GROUP BY Payment_Method
ORDER BY Payment_Method_Count DESC; 

-- �deme kategorisine g�re sipari� say�s� 
SELECT Payment_Category, COUNT(*) AS Payment_Category_Count
FROM pizza_sales
GROUP BY Payment_Category
ORDER BY Payment_Category_Count DESC; 

-- Restoran baz�nda saat dilimlerine g�re ortalama teslimat s�releri 
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

-- 'Small' ve 'XL' pizza boyutlar�n�n Trafik yo�unlu�una g�re ortalama teslimat s�releri 
SELECT
Traffic_Level,
AVG(CASE WHEN Pizza_Size = 'Small' THEN Delivery_Duration_min END) AS Small_Avg_Duration,
AVG(CASE WHEN Pizza_Size = 'XL' THEN Delivery_Duration_min END) AS XL_Avg_Duration
FROM pizza_sales
GROUP BY Traffic_Level
ORDER BY Traffic_Level;