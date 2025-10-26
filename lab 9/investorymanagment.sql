create database investorymanagment;
use investorymanagment;

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactNumber VARCHAR(15),
    City VARCHAR(50)
);

CREATE TABLE SupplyOrder (
    OrderID INT PRIMARY KEY,
    SupplierID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

INSERT INTO Product VALUES
(101, 'Mouse', 450.00, 40),
(102, 'Keyboard', 700.00, 30),
(103, 'Monitor', 8500.00, 20),
(104, 'CPU', 30000.00, 10);

INSERT INTO Supplier VALUES
(1, 'TechSource', '9876543210', 'Bangalore'),
(2, 'Digital Hub', '9123456780', 'Mysore'),
(3, 'PC World', '9988776655', 'Chennai');

INSERT INTO SupplyOrder VALUES
(501, 1, 101, 20, '2025-10-01'),
(502, 1, 102, 10, '2025-10-05'),
(503, 2, 103, 5, '2025-10-10'),
(504, 3, 104, 8, '2025-10-15'),
(505, 2, 101, 15, '2025-10-20');

SELECT SupplierName, SUM(Quantity) AS TotalQuantity
FROM SupplyOrder so
join supplier s on so.supplierID = s.supplierID
GROUP BY s.SupplierName;


SELECT OrderID, DATEDIFF(CURDATE(), OrderDate) AS DaysSinceOrder
FROM SupplyOrder;

SELECT SupplierName, CURDATE() AS TodayDate
FROM Supplier;

SELECT AVG(Quantity) AS AvgQuantity FROM SupplyOrder;

DELIMITER $$

CREATE PROCEDURE InsertSupplyOrder (
    IN p_OrderID INT,
    IN p_SupplierID INT,
    IN p_ProductID INT,
    IN p_Quantity INT,
    IN p_OrderDate DATE
)
BEGIN
    INSERT INTO  supplyorder VALUES (p_OrderID, p_SupplierID, p_ProductID, p_Quantity, p_OrderDate);
END $$

DELIMITER ;

CALL InsertSupplyOrder(506, 3, 102, 12, '2025-10-25');

DELIMITER $$

CREATE PROCEDURE UpdateSupplyOrder (
    IN p_OrderID INT,
    IN p_NewQuantity INT
)
BEGIN
    UPDATE SupplyOrder
    SET Quantity = p_NewQuantity
    WHERE OrderID = p_OrderID;
END $$

DELIMITER ;

CALL UpdateSupplyOrder(503, 10);






