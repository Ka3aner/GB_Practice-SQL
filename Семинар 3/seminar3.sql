DROP DATABASE IF EXISTS seminar3;
CREATE DATABASE IF NOT EXISTS seminar3;

USE seminar3;

-- В MySQL можно использовать ` ` для названий таблиц и БД. Используется, когда мы хотим назвать с пробелом или использовать в названии служебные слова

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`firstname` VARCHAR(45),
`lastname` VARCHAR(45),
`post` VARCHAR(45),
`seniority` INT,
`salary` INT,
`age` INT
);

-- Допустим, решили, что 45 символов для post - много. Что делать?

ALTER TABLE staff
MODIFY post VARCHAR(30);

INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Васькин', 'Начальник', 40, 100000, 60),
('Петр', 'Власов', 'Начальник', 8, 70000, 30),
('Катя', 'Катина', 'Инженер', 2, 70000, 25),
('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

DROP TABLE IF EXISTS `activity_staff`;
CREATE TABLE IF NOT EXISTS `activity_staff`
(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`staff_id` INT,
FOREIGN KEY(staff_id) REFERENCES staff(id),
`date_activity` DATE,
`count_pages` INT
);

INSERT `activity_staff` (`staff_id`, `date_activity`, `count_pages`)
VALUES
(1,'2022-01-01',250),
(2,'2022-01-01',220),
(3,'2022-01-01',170),
(1,'2022-01-02',100),
(2,'2022-01-01',220),
(3,'2022-01-01',300),
(7,'2022-01-01',350),
(1,'2022-01-03',168),
(2,'2022-01-03',62),
(3,'2022-01-03',84);

-- Посмотрим на таблицу staff
SELECT * FROM staff;

-- Вывести среднюю ЗП сотрудников
SELECT AVG(salary) FROM staff;

-- Вывести всех сотрудников, у кого зарплата больше средней (используем запрос внутри запроса)
SELECT * FROM staff
WHERE salary > (SELECT AVG(salary) FROM staff);

-- Получить инфу о зарплате сотрудников по возрастанию (можно написать ASC, но ето по умолчанию)
SELECT id, salary
FROM staff
ORDER BY salary;

-- Получить инфу о зарплате сотрудников по убыванию 
SELECT id, salary
FROM staff
ORDER BY salary DESC;

-- Выведем инфу о сотрудниках в должности Рабочий и стаж работы больше 5 летalter
SELECT * FROM staff
WHERE seniority > 5 AND post = "Рабочий"
ORDER BY salary;

-- Самостоятельное задание
-- Выведите все записи, отсортированные по полю "age" по возрастанию
SELECT * FROM staff
ORDER BY age;

-- Выведите все записи, отсортированные по полю “firstname"
SELECT * FROM staff
ORDER BY firstname;

-- Выведите записи полей "firstname ", “lastname", "age", отсортированные по полю "firstname " в алфавитном порядке по убыванию
SELECT firstname, lastname, age FROM staff
ORDER BY firstname DESC;

-- Выполните сортировку по полям " firstname " и "age" по убыванию
SELECT * FROM staff
ORDER BY firstname DESC, age DESC;

-- LIMIT
-- Выведем 5 первых строк из таблицы
SELECT id, firstname, age
FROM staff
LIMIT 5;

-- Выведем 3 строки из таблицы, пропустив первые 2 строки
SELECT id, firstname, age
FROM staff
LIMIT 2,3; -- первая цифра отвечает за кол-во пропущенных строк, вторая цифра за кол-во выводимых строк

-- DISTINCT
-- Вывести количество уникальных фамилий
SELECT COUNT(DISTINCT lastname) FROM staff;

-- Нужно вывести количество НЕ уникальных фамилий
SELECT COUNT(lastname) - COUNT(DISTINCT lastname) AS "количество НЕ уникальных фамилий" FROM staff;

-- Самостоятельная работа
-- Выведите уникальные (неповторяющиеся) значения полей "firstname"
SELECT DISTINCT firstname FROM staff;

-- Отсортируйте записи по возрастанию значений поля "id". Выведите первые две записи данной выборки
SELECT * FROM staff
ORDER BY id 
LIMIT 2;

-- Отсортируйте записи по возрастанию значений поля "id". Пропустите первые 4 строки данной выборки и извлеките следующие 3
SELECT * FROM staff
ORDER BY id 
LIMIT 4,3;

-- Отсортируйте записи по убыванию поля "id". Пропустите две строки данной выборки и извлеките следующие за ними 3 строки
SELECT * FROM staff
ORDER BY id DESC
LIMIT 2,3;

-- Установки, чтобы MySQL не ругался на GROUP BY в следующей строке (он требует только агрегирующие функции)
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY','')); -- установка для данного скрипта
SET GLOBAl sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY','')); -- установка для всего Workbench (сейчас и на будущее)


-- Сгруппировать по должности (будет не совсем корректно, потому что фамилию возьмет первую попавшуюся)
SELECT salary, lastname, post,
MAX(salary) AS "Макс зарплата",
MIN(salary) AS "Мин зарплата",
MAX(salary) - MIN(salary) AS "Разница"
FROM staff
GROUP BY post;

-- Сгруппировать по должности (более точный вариант)
SELECT COUNT(salary), COUNT(lastname), COUNT(post),
MAX(salary) AS "Макс зарплата",
MIN(salary) AS "Мин зарплата",
MAX(salary) - MIN(salary) AS "Разница"
FROM staff
GROUP BY post;

--  Самостоятельная работа
-- Выведите общее количество напечатанных страниц каждым сотрудником
SELECT staff_id, SUM(count_pages) 
FROM activity_staff
GROUP BY staff_id;

-- Посчитайте количество страниц за каждый день
SELECT date_activity, SUM(count_pages) 
FROM activity_staff
GROUP BY date_activity;

-- Найдите среднее арифметическое по количеству ежедневных страниц
SELECT date_activity, AVG(count_pages) 
FROM activity_staff
GROUP BY date_activity;

/* Сгруппируйте данные о сотрудниках по возрасту:
1 группа – младше 20 лет
2 группа – от 20 до 40 лет
3 группа – старше 40 лет
Для каждой группы найдите суммарную зарплату */

SELECT `Возрастная группа`, SUM(salary)
FROM 
(SELECT salary, 
CASE 
WHEN age < 20 THEN "Младше 20 лет"
WHEN age BETWEEN 20 AND 40 THEN "от 20 до 40"
ELSE "больше 40"
END AS `Возрастная группа`
FROM staff) as lists
GROUP BY `Возрастная группа`;



