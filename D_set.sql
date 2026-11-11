CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);


INSERT INTO Departments VALUES
(1, 'AIML'),
(2, 'CSE'),
(3, 'ECE'),
(4, 'Mechanical'),
(5, 'Civil');



CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2) NOT NULL CHECK (salary > 15000),
    dept_id INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);




INSERT INTO Employees VALUES
(101, 'Aman', 30000, 1, '2024-02-15'),
(102, 'Rohan', 40000, 1, '2025-03-10'),
(103, 'Karan', 25000, 1, '2024-06-20'),
(104, 'Ankit', 35000, 1, '2025-08-12'),
(105, 'Rahul', 28000, 2, '2023-05-10'),
(106, 'Arjun', 45000, 2, '2024-04-18'),
(107, 'Suman', 32000, 2, '2025-11-05'),
(108, 'Ravi', 22000, 3, '2024-09-15'),
(109, 'Mohan', 38000, 3, '2025-01-20');



SELECT *
FROM Employees
WHERE hire_date BETWEEN '2024-01-01' AND '2025-12-31'
AND emp_name LIKE '%an%';




SELECT d.dept_name, e.emp_name
FROM Departments d
LEFT JOIN Employees e
ON d.dept_id = e.dept_id;



SELECT d.dept_name,
       MAX(e.salary) AS max_salary,
       MIN(e.salary) AS min_salary
FROM Departments d
JOIN Employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(e.emp_id) > 3;




SELECT emp_name, salary, dept_id
FROM Employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees e2
    WHERE e2.dept_id = e1.dept_id
);
