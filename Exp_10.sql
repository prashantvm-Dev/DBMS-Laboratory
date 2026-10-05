-- 1. CREATE DATABASE
CREATE DATABASE LibraryDB;
USE LibraryDB;



-- 2. CREATE TABLES
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(50),
    Author VARCHAR(50),
    PubYear INT,
    Copies INT
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50),
    Phone VARCHAR(10),
    Address VARCHAR(50)
);

CREATE TABLE IssueReturn (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    IssueDate DATE,
    ReturnDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY(BookID) REFERENCES Books(BookID),
    FOREIGN KEY(MemberID) REFERENCES Members(MemberID)
);



-- 3. INSERT 5 RECORDS

INSERT INTO Books (Title,Author,PubYear,Copies) VALUES
('DBMS','Korth',2020,5),
('Python','Guido',2021,4),
('Java','James',2019,3),
('C++','Bjarne',2018,6),
('AI','Russell',2022,2);

INSERT INTO Members (Name,Phone,Address) VALUES
('Rahul','9876543210','Ranchi'),
('Priya','9876543211','Patna'),
('Amit','9876543212','Delhi'),
('Sneha','9876543213','Pune'),
('Ravi','9876543214','Cuttack');

INSERT INTO IssueReturn
(BookID,MemberID,IssueDate,ReturnDate,Status) VALUES
(1,1,'2026-10-01',NULL,'Issued'),
(2,2,'2026-10-02','2026-10-04','Returned'),
(3,3,'2026-10-03',NULL,'Issued'),
(4,4,'2026-10-04','2026-10-05','Returned'),
(5,5,'2026-10-05',NULL,'Issued');



-- 4. DISPLAY ALL BOOK RECORDS
SELECT * FROM Books;

-- OUTPUT:
+--------+--------+--------+---------+--------+
| BookID | Title  | Author | PubYear | Copies |
+--------+--------+--------+---------+--------+
|      1 | DBMS   | Korth  |    2020 |      5 |
|      2 | Python | Guido  |    2021 |      4 |
|      3 | Java   | James  |    2019 |      3 |
|      4 | C++    | Bjarne |    2018 |      6 |
|      5 | AI     | Russell|    2022 |      2 |
+--------+--------+--------+---------+--------+
5 rows in set

    

-- 5. DISPLAY ALL MEMBER RECORDS
SELECT * FROM Members;

-- OUTPUT:
+----------+-------+------------+---------+
| MemberID | Name  | Phone      | Address |
+----------+-------+------------+---------+
|        1 | Rahul | 9876543210 | Ranchi  |
|        2 | Priya | 9876543211 | Patna   |
|        3 | Amit  | 9876543212 | Delhi   |
|        4 | Sneha | 9876543213 | Pune    |
|        5 | Ravi  | 9876543214 | Cuttack |
+----------+-------+------------+---------+
5 rows in set


    
-- 6. DISPLAY BOOKS ISSUED WITH MEMBER DETAILS
SELECT i.ID,b.Title,m.Name,i.IssueDate,i.Status
FROM IssueReturn i
JOIN Books b ON i.BookID=b.BookID
JOIN Members m ON i.MemberID=m.MemberID;

-- OUTPUT:
+----+--------+-------+------------+----------+
| ID | Title  | Name  | IssueDate  | Status   |
+----+--------+-------+------------+----------+
|  1 | DBMS   | Rahul | 2026-10-01 | Issued   |
|  2 | Python | Priya | 2026-10-02 | Returned |
|  3 | Java   | Amit  | 2026-10-03 | Issued   |
|  4 | C++    | Sneha | 2026-10-04 | Returned |
|  5 | AI     | Ravi  | 2026-10-05 | Issued   |
+----+--------+-------+------------+----------+
5 rows in set




-- 7. DISPLAY BOOK TITLE, MEMBER NAME AND ISSUE DATE
SELECT b.Title,m.Name,i.IssueDate
FROM IssueReturn i
JOIN Books b ON i.BookID=b.BookID
JOIN Members m ON i.MemberID=m.MemberID;

-- OUTPUT:
+--------+-------+------------+
| Title  | Name  | IssueDate  |
+--------+-------+------------+
| DBMS   | Rahul | 2026-10-01 |
| Python | Priya | 2026-10-02 |
| Java   | Amit  | 2026-10-03 |
| C++    | Sneha | 2026-10-04 |
| AI     | Ravi  | 2026-10-05 |
+--------+-------+------------+
5 rows in set


-- 8. UPDATE AVAILABLE COPIES
UPDATE Books SET Copies=Copies-1 WHERE BookID=1;



-- 9. UPDATE RETURN STATUS AND DATE
UPDATE IssueReturn
SET Status='Returned',ReturnDate='2026-10-06'
WHERE ID=1;

SELECT ID,Status,ReturnDate
FROM IssueReturn
WHERE ID=1;

-- OUTPUT:
+----+----------+------------+
| ID | Status   | ReturnDate |
+----+----------+------------+
|  1 | Returned | 2026-10-06 |
+----+----------+------------+
1 row in set


-- 10. INCREASE NUMBER OF COPIES
UPDATE Books SET Copies=Copies+1 WHERE BookID=2;

SELECT Title,Copies FROM Books WHERE BookID=2;

-- OUTPUT:
+--------+--------+
| Title  | Copies |
+--------+--------+
| Python |      5 |
+--------+--------+
1 row in set


-- 11. DELETE A MEMBER RECORD
DELETE FROM Members
WHERE MemberID=5;




-- 12. DELETE A BOOK RECORD
DELETE FROM IssueReturn
WHERE BookID=5;

DELETE FROM Books
WHERE BookID=5;



-- 13. ADD ISBN COLUMN
ALTER TABLE Books
ADD ISBN VARCHAR(20);



-- 14. DROP ADDRESS COLUMN
ALTER TABLE Members
DROP COLUMN Address;




-- 15. RENAME ISSUERETURN TO TRANSACTIONS
RENAME TABLE IssueReturn TO Transactions;



-- 16. TRUNCATE ALL RECORDS FROM TRANSACTIONS
TRUNCATE TABLE Transactions;



-- 17. ADD NOT NULL CONSTRAINT
ALTER TABLE Books
MODIFY Title VARCHAR(50) NOT NULL;



-- 18. ADD CHECK CONSTRAINT FOR PHONE
ALTER TABLE Members
ADD CONSTRAINT chk_phone
CHECK(Phone REGEXP '^[0-9]{10}$');



-- 19. INNER JOIN
SELECT m.Name,b.Title
FROM Members m
INNER JOIN Transactions t
ON m.MemberID=t.MemberID
INNER JOIN Books b
ON t.BookID=b.BookID;

-- OUTPUT:
Empty set


-- 20. LEFT JOIN
SELECT m.Name,b.Title
FROM Members m
LEFT JOIN Transactions t
ON m.MemberID=t.MemberID
LEFT JOIN Books b
ON t.BookID=b.BookID;

-- OUTPUT:
+-------+-------+
| Name  | Title |
+-------+-------+
| Rahul | NULL  |
| Priya | NULL  |
| Amit  | NULL  |
| Sneha | NULL  |
+-------+-------+
4 rows in set


-- 21. TOTAL NUMBER OF BOOKS
SELECT COUNT(*) AS TotalBooks
FROM Books;

-- OUTPUT:
+------------+
| TotalBooks |
+------------+
|          4 |
+------------+
1 row in set


-- 22. MAXIMUM AND MINIMUM PUBLICATION YEAR
SELECT MAX(PubYear) AS MaxYear,
       MIN(PubYear) AS MinYear
FROM Books;

-- OUTPUT:
+---------+---------+
| MaxYear | MinYear |
+---------+---------+
|    2021 |    2018 |
+---------+---------+
1 row in set


-- 23. COUNT CURRENTLY ISSUED BOOKS
SELECT COUNT(*) AS IssuedBooks
FROM Transactions
WHERE Status='Issued';

-- OUTPUT:
+-------------+
| IssuedBooks |
+-------------+
|           0 |
+-------------+
1 row in set


-- 24. CREATE VIEW
CREATE VIEW IssuedBooksView AS
SELECT b.Title,m.Name,t.IssueDate
FROM Transactions t
JOIN Books b ON t.BookID=b.BookID
JOIN Members m ON t.MemberID=m.MemberID
WHERE t.Status='Issued';



-- 25. DISPLAY IssuedBooksView
SELECT * FROM IssuedBooksView;

-- OUTPUT:
Empty set


-- 26. CREATE STORED PROCEDURE
DELIMITER //

CREATE PROCEDURE GetIssuedBooks()
BEGIN
    SELECT b.Title,m.Name,t.IssueDate
    FROM Transactions t
    JOIN Books b ON t.BookID=b.BookID
    JOIN Members m ON t.MemberID=m.MemberID
    WHERE t.Status='Issued';
END //

DELIMITER ;



-- 27. EXECUTE STORED PROCEDURE
CALL GetIssuedBooks();

-- OUTPUT:
Empty set
