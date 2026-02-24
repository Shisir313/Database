CREATE TABLE Employee2 (
    FName VARCHAR(100),
    LName VARCHAR(100),
    SSN INT PRIMARY KEY,
    Address VARCHAR(100),
    Sex VARCHAR(20),
    Salary DOUBLE,
    SuperSSN INT,
    DNO INT
);
-- Insert sample employees into Employee2
INSERT INTO Employee2 (FName, LName, SSN, Address, Sex, Salary, SuperSSN, DNO)
VALUES 
('Alice', 'Johnson', 101001001, '12 Elm St, CityX', 'F', 70000, NULL, 1),
('Bob', 'Williams', 102002002, '34 Oak St, CityY', 'M', 65000, 101001001, 2),
('Carol', 'Taylor', 103003003, '56 Pine St, CityZ', 'F', 60000, 101001001, 1),
('David', 'Lee', 104004004, '78 Maple St, CityX', 'M', 58000, 102002002, 3),
('Eva', 'Martinez', 105005005, '90 Cedar St, CityY', 'F', 62000, 102002002, 2);

CREATE TABLE Department2 (
    DNo INT PRIMARY KEY,
    Dname VARCHAR(50) NOT NULL,
    ManagerStartDate DATE,
    ManagerSSN VARCHAR(100)
);
-- Insert sample departments into Department2
INSERT INTO Department2 (DNo, Dname, ManagerStartDate, ManagerSSN)
VALUES
(1, 'HR', '2020-01-15', '101001001'),
(2, 'IT', '2019-06-01', '102002002'),
(3, 'Finance', '2021-03-10', '105005005'),
(4, 'Marketing', '2022-07-20', '103003003'),
(5, 'Operations', '2018-11-05', '104004004');

ALTER TABLE Employee2
ADD MInit VARCHAR(5);

ALTER TABLE Employee2
ADD CONSTRAINT FK_Employee_Department
FOREIGN KEY (DNO) REFERENCES Department2(DNo);

INSERT INTO Department2 (DNo, Dname, ManagerStartDate, ManagerSSN)
VALUES (6, 'Research', '2023-01-01', '101001001');

UPDATE Employee2
SET DNO = 6
WHERE SSN IN (101001001, 103003003);

UPDATE Employee2
SET Salary = Salary * 1.10
WHERE DNO = 6;

SELECT FName, LName, Salary
FROM Employee2
WHERE DNO = 6;

SELECT 
    SUM(Salary) AS TotalSalary,
    MAX(Salary) AS MaxSalary,
    MIN(Salary) AS MinSalary,
    AVG(Salary) AS AvgSalary
FROM Employee2
WHERE DNO = 1;

SELECT 
    d.Dname,
    SUM(e.Salary) AS TotalSalary,
    MAX(e.Salary) AS MaxSalary,
    MIN(e.Salary) AS MinSalary,
    AVG(e.Salary) AS AvgSalary
FROM Department2 d
LEFT JOIN Employee2 e ON d.DNo = e.DNO
GROUP BY d.Dname;