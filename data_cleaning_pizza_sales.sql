
SELECT 
COLUMN_NAME,
DATA_TYPE,
CHARACTER_MAXIMUM_LENGTH,
IS_NULLABLE
FROM
INFORMATION_SCHEMA.COLUMNS
WHERE
TABLE_NAME='pizza_sales'; -- Tablo içindeki sütun isimlerini, veri tiplerini, uzunluklarini ve NULL olup olmadıgını kontrol ettim.

EXEC sp_rename 'pizza_sales.Location', 'Location_Name', 'COLUMN'; -- Location olan (keyword) Location_Name olarak degistirdim.

UPDATE pizza_sales
SET Restaurant_Name = 'Marco''s Pizza'
WHERE Restaurant_Name LIKE 'Marco?s Pizza'; -- Karakter hatasi

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
GROUP BY Payment_Method  -- Degerlere baktim, tutarli olup olmadigini kontrol ettim.

SELECT * FROM pizza_sales
WHERE Distance_km < 0 OR Distance_km > 100; -- aykiri deger var mi?

SELECT * FROM pizza_sales
WHERE Delivery_Duration_min < 0 OR Delivery_Duration_min > 240; -- aykiri deger var mi?

SELECT * FROM pizza_sales
WHERE Delivery_Time < Order_Time; -- Teslimat zamani sipariþ zamanindan önce olan kayit var mi? 

SELECT Order_ID, COUNT(*)
FROM pizza_sales
GROUP BY Order_ID 
HAVING COUNT(*) > 1; -- Tekrarlayan kayit var mi?

SELECT * FROM pizza_sales
WHERE DATEDIFF(MINUTE, Order_Time, Delivery_Time) <> Delivery_Duration_min; -- Teslimat süresi tutarli mi?




























