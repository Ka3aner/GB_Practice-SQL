-- 1 Задание
USE seminar2_hw;
CREATE TABLE sales (
id int NOT NULL AUTO_INCREMENT,
order_date DATE, 
count_product int,
PRIMARY KEY (`id`)
);

INSERT sales (id, order_date, count_product)
VALUES
(1, '2020-01-01', 156),
(2, '2020-01-02', 180),
(3, '2020-01-03', 21),
(4, '2020-01-04', 124),
(5, '2020-01-05', 341);

-- 2 Задание
SELECT 
id as "id_заказа",
IF (count_product < 100, 'Маленький заказ',
IF (count_product > 300, 'Большой заказ', 'Средний заказ'))
AS "Тип заказа"
FROM sales;

-- 3 Задание
CREATE TABLE orders (
id int NOT NULL AUTO_INCREMENT,
employee_id varchar(45), 
amount float,
order_status varchar(45),
PRIMARY KEY (`id`)
);

INSERT orders (id, employee_id, amount, order_status)
VALUES
(1, 'e03', 15.00, "OPEN"),
(2, 'e01', 25.00, "OPEN"),
(3, 'e05', 100.70, "CLOSED"),
(4, 'e02', 22.18, "OPEN"),
(5, 'e04', 9.50, "CANCELLED");

SELECT *,
CASE
WHEN order_status = "OPEN" THEN "Order is in open state"
WHEN order_status = "CLOSED" THEN "Order is closed"
WHEN order_status = "CANCELLED" THEN "Order is cancelled"
END AS full_order_status
FROM orders;

-- 4 Задание
/*
Чем 0 отличается от NULL?

0 - число типа integer
NULL - полная пустота ячейки, NULL фактически "ничего"
0 равен 0
NULL не равен ничему, даже NULL.
Если у нас нет каких-то данных в БД принято использовать именно NULL.
*/

