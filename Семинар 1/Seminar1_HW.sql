CREATE TABLE `mobile_phone` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(45) DEFAULT NULL,
  `Manufacturer` varchar(45) DEFAULT NULL,
  `ProductCount` int DEFAULT NULL,
  `Price` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

INSERT INTO `` (`Id`,`ProductName`,`Manufacturer`,`ProductCount`,`Price`) VALUES (1,'Iphone X','Apple',3,76000);
INSERT INTO `` (`Id`,`ProductName`,`Manufacturer`,`ProductCount`,`Price`) VALUES (2,'Iphone 8','Apple',2,51000);
INSERT INTO `` (`Id`,`ProductName`,`Manufacturer`,`ProductCount`,`Price`) VALUES (3,'Galaxy S9','Samsung',2,56000);
INSERT INTO `` (`Id`,`ProductName`,`Manufacturer`,`ProductCount`,`Price`) VALUES (4,'Galaxy S8','Samsung',2,41000);
INSERT INTO `` (`Id`,`ProductName`,`Manufacturer`,`ProductCount`,`Price`) VALUES (5,'P20 Pro','Huawei',5,36000);


USE seminar1_hw;
# 2 задание
SELECT ProductName, Manufacturer, Price FROM mobile_phone
WHERE ProductCount > 2;
# 3 задание
SELECT * FROM mobile_phone
WHERE Manufacturer = "Samsung";
# 4 задание
SELECT * FROM mobile_phone
WHERE ProductName LIKE "%Iphone%";
SELECT * FROM mobile_phone
WHERE Manufacturer LIKE "%Samsung%";
SELECT * FROM mobile_phone
WHERE ProductName LIKE "%8%";