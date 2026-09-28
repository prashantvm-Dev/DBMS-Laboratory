CREATE DATABASE StudentDB;
USE StudentDB;



CREATE TABLE Students (
    Student_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Address VARCHAR(200)
);



CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    Capacity INT NOT NULL
);



CREATE TABLE Enrollments (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE,
    Grade VARCHAR(5),
    Status VARCHAR(20),
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);



INSERT INTO Students
(Student_ID, Name, Age, Address)
VALUES
(1, 'Rahul', 20, 'Ranchi'),
(2, 'Priya', 21, 'Patna'),
(3, 'Amit', 19, 'Delhi'),
(4, 'Sneha', 22, 'Pune'),
(5, 'Rohan', 20, 'Kolkata');



INSERT INTO Courses
(Course_ID, Course_Name, Credits, Capacity)
VALUES
(101, 'DBMS', 4, 30),
(102, 'Python', 3, 25),
(103, 'DS', 4, 35),
(104, 'CN', 3, 30),
(105, 'ML', 4, 20);



INSERT INTO Enrollments
(Enrollment_ID, Student_ID, Course_ID, Enrollment_Date, Grade, Status)
VALUES
(1001, 1, 101, '2026-07-01', 'A', 'Active'),
(1002, 2, 102, '2026-07-02', 'B', 'Active'),
(1003, 3, 103, '2026-07-03', 'A', 'Completed'),
(1004, 4, 104, '2026-07-04', 'B', 'Active'),
(1005, 5, 105, '2026-07-05', 'A', 'Completed');



SELECT * FROM Students;


+------------+-------+-----+---------+
| Student_ID | Name  | Age | Address |
+------------+-------+-----+---------+
| 1          | Rahul | 20  | Ranchi  |
| 2          | Priya | 21  | Patna   |
| 3          | Amit  | 19  | Delhi   |
| 4          | Sneha | 22  | Pune    |
| 5          | Rohan | 20  | Kolkata |
+------------+-------+-----+---------+



SELECT * FROM Courses;


+-----------+-------------+---------+----------+
| Course_ID | Course_Name | Credits | Capacity |
+-----------+-------------+---------+----------+
| 101       | DBMS        | 4       | 30       |
| 102       | Python      | 3       | 25       |
| 103       | DS          | 4       | 35       |
| 104       | CN          | 3       | 30       |
| 105       | ML          | 4       | 20       |
+-----------+-------------+---------+----------+



SELECT s.Student_ID, s.Name, c.Course_Name,
       e.Enrollment_Date, e.Grade, e.Status
FROM Students s
JOIN Enrollments e ON s.Student_ID = e.Student_ID
JOIN Courses c ON e.Course_ID = c.Course_ID;



SELECT c.Course_Name, s.Name, e.Enrollment_Date
FROM Enrollments e
JOIN Students s ON e.Student_ID = s.Student_ID
JOIN Courses c ON e.Course_ID = c.Course_ID;



UPDATE Courses
SET Capacity = Capacity - 1
WHERE Course_ID = 101;




UPDATE Enrollments
SET Grade = 'A+', Status = 'Completed'
WHERE Enrollment_ID = 1001;




UPDATE Courses
SET Capacity = Capacity + 10
WHERE Course_ID = 101;




DELETE FROM Enrollments
WHERE Student_ID = 5;
-----
DELETE FROM Students
WHERE Student_ID = 5;



DELETE FROM Enrollments
WHERE Course_ID = 105;
----
DELETE FROM Courses
WHERE Course_ID = 105;



ALTER TABLE Students
ADD Email VARCHAR(100);




ALTER TABLE Students
DROP COLUMN Address;



RENAME TABLE Enrollments TO Registrations;




ALTER TABLE Students
MODIFY Name VARCHAR(100) NOT NULL;




ALTER TABLE Students
ADD CONSTRAINT chk_age CHECK (Age >= 18);




SELECT s.Name, c.Course_Name
FROM Students s
INNER JOIN Registrations r
ON s.Student_ID = r.Student_ID
INNER JOIN Courses c
ON r.Course_ID = c.Course_ID;



SELECT s.Name, c.Course_Name
FROM Students s
LEFT JOIN Registrations r
ON s.Student_ID = r.Student_ID
LEFT JOIN Courses c
ON r.Course_ID = c.Course_ID;




SELECT COUNT(*) AS Total_Students
FROM Students;

+----------------+
| Total_Students |
+----------------+
| 4              |
+----------------+




SELECT MAX(Credits) AS Maximum_Credits,
       MIN(Credits) AS Minimum_Credits
FROM Courses;

SELECT MAX(Credits) AS Maximum_Credits,
       MIN(Credits) AS Minimum_Credits
FROM Courses;

+-----------------+-----------------+
| Maximum_Credits | Minimum_Credits |
+-----------------+-----------------+
| 4               | 3               |
+-----------------+-----------------+





SELECT COUNT(*) AS Active_Enrollments
FROM Registrations
WHERE Status = 'Active';


+-------------------+
| Active_Enrollments |
+-------------------+
| 2                 |
+-------------------+




CREATE VIEW ActiveEnrollmentsView AS
SELECT c.Course_Name,
       s.Name AS Student_Name,
       r.Enrollment_Date
FROM Registrations r
JOIN Students s
ON r.Student_ID = s.Student_ID
JOIN Courses c
ON r.Course_ID = c.Course_ID
WHERE r.Status = 'Active';




SELECT * FROM ActiveEnrollmentsView;




DELIMITER //

CREATE PROCEDURE GetActiveEnrollments()
BEGIN
    SELECT c.Course_Name,
           s.Name AS Student_Name,
           r.Enrollment_Date
    FROM Registrations r
    JOIN Students s
    ON r.Student_ID = s.Student_ID
    JOIN Courses c
    ON r.Course_ID = c.Course_ID
    WHERE r.Status = 'Active';
END //

DELIMITER ;






CALL GetActiveEnrollments();




TRUNCATE TABLE Registrations;
