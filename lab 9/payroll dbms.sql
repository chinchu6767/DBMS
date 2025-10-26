create database payrollsystems;
use payrollsystems;


CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Designation VARCHAR(50),
    DeptID INT,
    HireDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE SalaryDetails (
    SalaryID INT PRIMARY KEY,
    EmpID INT,
    BasicPay DECIMAL(10,2),
    Allowance DECIMAL(10,2),
    Deductions DECIMAL(10,2),
    NetSalary DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

INSERT INTO Department VALUES
(1, 'Human Resources', 'Bangalore'),
(2, 'Finance', 'Chennai'),
(3, 'IT', 'Hyderabad');

INSERT INTO Employee VALUES
(101, 'Ravi Kumar', 'HR Manager', 1, '2021-04-12'),
(102, 'Sneha Reddy', 'Accountant', 2, '2022-01-15'),
(103, 'Arjun Mehta', 'Software Engineer', 3, '2023-03-10'),
(104, 'Priya Sharma', 'System Analyst', 3, '2020-08-05');

INSERT INTO SalaryDetails VALUES
(1, 101, 55000, 8000, 2000, 61000),
(2, 102, 40000, 5000, 1500, 43500),
(3, 103, 60000, 7000, 2500, 64500),
(4, 104, 65000, 9000, 3000, 71000);

SELECT 
    e.EmpID,
    e.EmpName,
    e.Designation,
    d.DeptName,
    d.Location
FROM Employee e
JOIN Department d ON e.DeptID = d.DeptID;

SELECT 
    e.EmpName,
    e.Designation,
    s.BasicPay,
    s.Allowance,
    s.Deductions,
    s.NetSalary
FROM Employee e
JOIN SalaryDetails s ON e.EmpID = s.EmpID;

SELECT 
    DeptName,SUM(NetSalary) AS Total_Salary_Expense
FROM Department d
JOIN Employee e ON d.DeptID = e.DeptID
JOIN SalaryDetails s ON e.EmpID = s.EmpID
GROUP BY d.DeptName;


SELECT 
    DeptName,AVG(NetSalary) AS Average_Salary
FROM Department d
JOIN Employee e ON d.DeptID = e.DeptID
JOIN SalaryDetails s ON e.EmpID = s.EmpID
GROUP BY d.DeptName;


DELIMITER $$

CREATE PROCEDURE InsertSalary(
    IN sal_id INT,
    IN emp_id INT,
    IN basic DECIMAL(10,2),
    IN allowance DECIMAL(10,2),
    IN deduction DECIMAL(10,2)
)
BEGIN
    SET net = basic + allowance - deduction;

    INSERT INTO SalaryDetails values(SalaryID, EmpID, BasicPay, Allowance, Deductions, NetSalary);

END $$

DELIMITER ;
CALL InsSalary(5, 102, 45000, 6000, 2000);

DELIMITER $$

CREATE PROCEDURE UpdateSalary(
    IN emp_id INT,
    IN new_basic DECIMAL(10,2),
    IN new_allow DECIMAL(10,2),
    IN new_deduct DECIMAL(10,2)
)
BEGIN
    SET new_net = new_basic + new_allow - new_deduct;

    UPDATE SalaryDetails
    SET BasicPay = new_basic,
        Allowance = new_allow,
        Deductions = new_deduct,
        NetSalary = new_net
    WHERE EmpID = emp_id;
END $$

DELIMITER ;






