create database banking;
use banking;

CREATE TABLE Customer (
    CustID INT PRIMARY KEY,
    CustName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50)
);

CREATE TABLE Account (
    AccountNo INT PRIMARY KEY,
    CustID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(12,2),
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE TransactionTable (
    TransID INT PRIMARY KEY,
    AccountNo INT,
    TransDate DATE,
    TransType VARCHAR(20),      
    Amount DECIMAL(10,2),
    FOREIGN KEY (AccountNo) REFERENCES Account(AccountNo)
);

INSERT INTO Customer VALUES
(1, 'Ravi Kumar', 'ravi@gmail.com', '9876543210', 'Bangalore'),
(2, 'Sneha Rao', 'sneha@gmail.com', '9123456780', 'Mysore'),
(3, 'Kiran Das', 'kiran@gmail.com', '9988776655', 'Chennai');

INSERT INTO Account VALUES
(10101, 1, 'Savings', 50000.00),
(10102, 2, 'Current', 30000.00),
(10103, 3, 'Savings', 45000.00);

INSERT INTO TransactionTable VALUES
(501, 10101, '2025-10-20', 'Deposit', 10000.00),
(502, 10101, '2025-10-21', 'Withdrawal', 5000.00),
(503, 10102, '2025-10-22', 'Deposit', 15000.00),
(504, 10103, '2025-10-23', 'Deposit', 20000.00),
(505, 10103, '2025-10-24', 'Withdrawal', 5000.00);

SELECT c.CustName, a.AccountNo, a.AccountType, a.Balance
FROM Customer c
JOIN Account a ON c.CustID = a.CustID;

SELECT 
    c.CustName,
    a.AccountNo,
    t.TransType,
    t.Amount,
    t.TransDate
FROM TransactionTable t
JOIN Account a ON t.AccountNo = a.AccountNo
JOIN Customer c ON a.CustID = c.CustID;

SELECT 
    MAX(Amount) AS MaxTransaction,
    MIN(Amount) AS MinTransaction
FROM TransactionTable;

SELECT * FROM TransactionTable
WHERE MONTH(TransDate) = MONTH(CURDATE())
  AND YEAR(TransDate) = YEAR(CURDATE());
  
  DELIMITER $$

CREATE PROCEDURE InsertTransaction (
    IN p_TransID INT,
    IN p_AccountNo INT,
    IN p_TransDate DATE,
    IN p_TransType VARCHAR(20),
    IN p_Amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO TransactionTable VALUES (p_TransID, p_AccountNo, p_TransDate, p_TransType, p_Amount);
END $$

DELIMITER ;

CALL InsertTransaction(506, 10102, '2025-10-26', 'Deposit', 8000.00);

DELIMITER $$

CREATE PROCEDURE UpdateTransaction (
    IN p_TransID INT,
    IN p_NewAmount DECIMAL(10,2)
)
BEGIN
    UPDATE TransactionTable
    SET Amount = p_NewAmount
    WHERE TransID = p_TransID;
END $$

DELIMITER ;

CALL UpdateTransaction(505, 6000.00);

