CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialization VARCHAR(50),
    consultation_fee DECIMAL(10,2)
);




CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    age INT
);




CREATE TABLE Appointments (
    app_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    app_date DATE,
    status VARCHAR(20)
        CHECK (status IN ('Scheduled', 'Completed', 'Cancelled')),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);




INSERT INTO Doctors VALUES
(1, 'Dr. Amit', 'Cardiology', 1000),
(2, 'Dr. Rahul', 'Neurology', 1500),
(3, 'Dr. Priya', 'Dentist', 800),
(4, 'Dr. Neha', 'Cardiology', 1200);



INSERT INTO Patients VALUES
(101, 'Aman', 25),
(102, 'Rohan', 35),
(103, 'Sneha', 45),
(104, 'Karan', 30),
(105, 'Priya', 55);



INSERT INTO Appointments VALUES
(1, 1, 101, '2026-01-10', 'Completed'),
(2, 2, 102, '2026-02-15', 'Completed'),
(3, 1, 103, '2026-03-20', 'Scheduled'),
(4, 3, 104, '2026-04-05', 'Completed'),
(5, 4, 105, '2026-05-12', 'Cancelled'),
(6, 2, 101, '2026-06-18', 'Completed');





UPDATE Doctors
SET consultation_fee = consultation_fee * 1.15
WHERE specialization IN ('Cardiology', 'Neurology');





SELECT p.patient_name,
       d.doctor_name,
       a.app_date
FROM Appointments a
JOIN Patients p
ON a.patient_id = p.patient_id
JOIN Doctors d
ON a.doctor_id = d.doctor_id
WHERE a.status = 'Completed'
ORDER BY a.app_date DESC;





SELECT d.doctor_name,
       d.specialization,
       COUNT(a.app_id) AS Total_Appointments
FROM Doctors d
LEFT JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name, d.specialization;





SELECT *
FROM Patients
WHERE age > (
    SELECT AVG(age)
    FROM Patients
);
