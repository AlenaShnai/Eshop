-- Выборка продаж за период
SELECT
   o.ORDER_ID,
   u.FirstName || ' ' || u.LastName AS Customer,
   o.TotalAmount,
   o.FinalAmount,
   o.PaymentMethod,
   o.OrderDate
FROM ORDERS o
JOIN USERS u ON o.User_ID = u.User_ID
WHERE o.OrderDate BETWEEN '2023-04-01' AND '2023-04-30';


-- Средняя сумма покупки
WITH avg_purchase AS (
   SELECT AVG(FinalAmount) AS avg_amount
   FROM ORDERS
)
SELECT
   CASE
       WHEN o.FinalAmount >= a.avg_amount THEN 'Выше среднего'
       ELSE 'Ниже среднего'
   END AS purchase_type,
   COUNT(*) AS purchase_count,
   SUM(o.FinalAmount) AS total_amount
FROM ORDERS o, avg_purchase a
GROUP BY
   CASE
       WHEN o.FinalAmount >= a.avg_amount THEN 'Выше среднего'
       ELSE 'Ниже среднего'
   END;


-- Средняя сумма продаж по категории за период
SELECT
   c.CATEGORY_Description AS Category,
   AVG(oi.TotalPrice) AS avg_sale_amount,
   SUM(oi.TotalPrice) AS total_sales
FROM ORDERITEMS oi
JOIN PRODUCTS p ON oi.PRODUCT_ID = p.PRODUCT_ID
JOIN CATEGORIES c ON p.CATEGORY_ID = c.CATEGORY_ID
JOIN ORDERS o ON oi.ORDER_ID = o.ORDER_ID
WHERE o.OrderDate BETWEEN '2023-04-01' AND '2023-04-30'
GROUP BY c.CATEGORY_Description;
-- Средняя сумма продаж конкретного товара
SELECT
   p.PRODUCT_NAME,
   AVG(oi.TotalPrice) AS avg_sale_amount,
   SUM(oi.Quantity) AS total_quantity_sold
FROM ORDERITEMS oi
JOIN PRODUCTS p ON oi.PRODUCT_ID = p.PRODUCT_ID
JOIN ORDERS o ON oi.ORDER_ID = o.ORDER_ID
WHERE p.PRODUCT_ID = 3 -- ID конкретного товара
AND o.OrderDate BETWEEN '2023-04-01' AND '2023-04-30'
GROUP BY p.PRODUCT_NAME;


-- представление на товары, которые есть в наличии на складе
CREATE OR REPLACE VIEW available_products AS
SELECT
   p.PRODUCT_ID,
   p.PRODUCT_NAME,
   p.Description,
   c.CATEGORY_Description AS Category,
   p.PRICE,
   p.StockQuantity,
   CASE
       WHEN p.StockQuantity > 10 THEN 'В наличии'
       WHEN p.StockQuantity > 0 THEN 'Мало'
       ELSE 'Нет в наличии'
   END AS availability_status
FROM PRODUCTS p
JOIN CATEGORIES c ON p.CATEGORY_ID = c.CATEGORY_ID
WHERE p.StockQuantity > 0 AND p.IsActive = TRUE
ORDER BY c.CATEGORY_Description, p.PRODUCT_NAME;
-- Использование представления
SELECT * FROM available_products;
