-- 1. CREATE DATABASE
CREATE DATABASE SupermarketDB;
USE SupermarketDB;


-- 2. CREATE TABLES

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(50),
    Phone VARCHAR(15),
    Address VARCHAR(100)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    CustomerID INT,
    SaleDate DATE,
    Quantity INT,
    Status VARCHAR(20),
    FOREIGN KEY(ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID)
);


-- 3. INSERT 5 RECORDS

INSERT INTO Products (ProductName,Price,Stock) VALUES
('Rice',50,20),
('Sugar',45,15),
('Oil',120,10),
('Milk',30,25),
('Bread',40,12);

INSERT INTO Customers (CustomerName,Phone,Address) VALUES
('Rahul','9876543210','Ranchi'),
('Priya','9876543211','Patna'),
('Amit','9876543212','Delhi'),
('Sneha','9876543213','Pune'),
('Ravi','9876543214','Cuttack');

INSERT INTO Sales
(ProductID,CustomerID,SaleDate,Quantity,Status) VALUES
(1,1,'2026-10-01',2,'Pending'),
(2,2,'2026-10-02',1,'Completed'),
(3,3,'2026-10-03',2,'Pending'),
(4,4,'2026-10-04',3,'Completed'),
(5,5,'2026-10-05',1,'Pending');


-- 4. DISPLAY ALL PRODUCT RECORDS

SELECT * FROM Products;

-- OUTPUT:
+-----------+-------------+--------+-------+
| ProductID | ProductName | Price  | Stock |
+-----------+-------------+--------+-------+
|         1 | Rice        |  50.00 |    20 |
|         2 | Sugar       |  45.00 |    15 |
|         3 | Oil         | 120.00 |    10 |
|         4 | Milk        |  30.00 |    25 |
|         5 | Bread       |  40.00 |    12 |
+-----------+-------------+--------+-------+
5 rows in set


-- 5. DISPLAY ALL CUSTOMER RECORDS
  
SELECT * FROM Customers;

-- OUTPUT:
+------------+--------------+------------+---------+
| CustomerID | CustomerName | Phone      | Address |
+------------+--------------+------------+---------+
|          1 | Rahul        | 9876543210 | Ranchi  |
|          2 | Priya        | 9876543211 | Patna   |
|          3 | Amit         | 9876543212 | Delhi   |
|          4 | Sneha        | 9876543213 | Pune    |
|          5 | Ravi         | 9876543214 | Cuttack |
+------------+--------------+------------+---------+
5 rows in set


-- 6. DISPLAY SALES WITH PRODUCT AND CUSTOMER DETAILS

SELECT s.SaleID,p.ProductName,c.CustomerName,
       s.SaleDate,s.Quantity,s.Status
FROM Sales s
JOIN Products p ON s.ProductID=p.ProductID
JOIN Customers c ON s.CustomerID=c.CustomerID;

-- OUTPUT:
+--------+-------------+--------------+------------+----------+-----------+
| SaleID | ProductName | CustomerName | SaleDate   | Quantity | Status    |
+--------+-------------+--------------+------------+----------+-----------+
|      1 | Rice        | Rahul        | 2026-10-01 |        2 | Pending   |
|      2 | Sugar       | Priya        | 2026-10-02 |        1 | Completed |
|      3 | Oil         | Amit         | 2026-10-03 |        2 | Pending   |
|      4 | Milk        | Sneha        | 2026-10-04 |        3 | Completed |
|      5 | Bread       | Ravi         | 2026-10-05 |        1 | Pending   |
+--------+-------------+--------------+------------+----------+-----------+
5 rows in set


-- 7. DISPLAY PRODUCT NAME, CUSTOMER NAME AND SALE DATE

SELECT p.ProductName,c.CustomerName,s.SaleDate
FROM Sales s
JOIN Products p ON s.ProductID=p.ProductID
JOIN Customers c ON s.CustomerID=c.CustomerID;

-- OUTPUT:
+-------------+--------------+------------+
| ProductName | CustomerName | SaleDate   |
+-------------+--------------+------------+
| Rice        | Rahul        | 2026-10-01 |
| Sugar       | Priya        | 2026-10-02 |
| Oil         | Amit         | 2026-10-03 |
| Milk        | Sneha        | 2026-10-04 |
| Bread       | Ravi         | 2026-10-05 |
+-------------+--------------+------------+
5 rows in set


-- 8. UPDATE STOCK AFTER SALE

UPDATE Products
SET Stock=Stock-2
WHERE ProductID=1;



-- 9. UPDATE SALE STATUS TO COMPLETED

UPDATE Sales
SET Status='Completed'
WHERE SaleID=1;

-- 10. INCREASE PRODUCT PRICE BY 10%

UPDATE Products
SET Price=Price*1.10
WHERE ProductID=1;


-- 11. DELETE A CUSTOMER RECORD

DELETE FROM Customers
WHERE CustomerID=5;



-- 12. DELETE A PRODUCT RECORD

DELETE FROM Sales
WHERE ProductID=5;

DELETE FROM Products
WHERE ProductID=5;



-- 13. ADD EXPIRYDATE COLUMN

ALTER TABLE Products
ADD ExpiryDate DATE;



-- 14. DROP ADDRESS COLUMN

ALTER TABLE Customers
DROP COLUMN Address;




-- 15. RENAME SALES TO TRANSACTIONS

RENAME TABLE Sales TO Transactions;



-- 16. TRUNCATE ALL RECORDS

TRUNCATE TABLE Transactions;




-- 17. ADD NOT NULL CONSTRAINT

ALTER TABLE Products
MODIFY ProductName VARCHAR(50) NOT NULL;



-- 18. ADD CHECK CONSTRAINT

ALTER TABLE Products
ADD CONSTRAINT chk_price
CHECK(Price > 0);




-- 19. INNER JOIN CUSTOMERS WITH PURCHASED PRODUCTS

SELECT c.CustomerName,p.ProductName
FROM Customers c
INNER JOIN Transactions t
ON c.CustomerID=t.CustomerID
INNER JOIN Products p
ON t.ProductID=p.ProductID;

-- OUTPUT:
Empty set


-- 20. LEFT JOIN ALL CUSTOMERS

SELECT c.CustomerName,p.ProductName
FROM Customers c
LEFT JOIN Transactions t
ON c.CustomerID=t.CustomerID
LEFT JOIN Products p
ON t.ProductID=p.ProductID;

-- OUTPUT:
+--------------+-------------+
| CustomerName | ProductName |
+--------------+-------------+
| Rahul        | NULL        |
| Priya        | NULL        |
| Amit         | NULL        |
| Sneha        | NULL        |
+--------------+-------------+
4 rows in set


-- 21. TOTAL NUMBER OF PRODUCTS

SELECT COUNT(*) AS TotalProducts
FROM Products;

-- OUTPUT:
+--------------+
| TotalProducts |
+--------------+
|            4 |
+--------------+
1 row in set


-- 22. MAXIMUM AND MINIMUM PRODUCT PRICE

SELECT MAX(Price) AS MaxPrice,
       MIN(Price) AS MinPrice
FROM Products;

-- OUTPUT:
+----------+----------+
| MaxPrice | MinPrice |
+----------+----------+
|   132.00 |    30.00 |
+----------+----------+
1 row in set


-- 23. COUNT COMPLETED SALES

SELECT COUNT(*) AS CompletedSales
FROM Transactions
WHERE Status='Completed';

-- OUTPUT:
+---------------+
| CompletedSales |
+---------------+
|             0 |
+---------------+
1 row in set


-- 24. CREATE COMPLETED SALES VIEW

CREATE VIEW CompletedSalesView AS
SELECT p.ProductName,c.CustomerName,t.SaleDate
FROM Transactions t
JOIN Products p ON t.ProductID=p.ProductID
JOIN Customers c ON t.CustomerID=c.CustomerID
WHERE t.Status='Completed';


-- 25. DISPLAY COMPLETEDSALESVIEW

SELECT * FROM CompletedSalesView;

-- OUTPUT:
Empty set


-- 26. CREATE STORED PROCEDURE

DELIMITER //

CREATE PROCEDURE GetCompletedSales()
BEGIN
    SELECT p.ProductName,c.CustomerName,t.SaleDate
    FROM Transactions t
    JOIN Products p ON t.ProductID=p.ProductID
    JOIN Customers c ON t.CustomerID=c.CustomerID
    WHERE t.Status='Completed';
END //

DELIMITER ;

