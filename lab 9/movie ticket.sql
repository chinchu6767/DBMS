create database cinemas;
use cinemas;

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(50),
    Genre VARCHAR(30),
    Duration INT,
    TicketPrice DECIMAL(10,2)
);

CREATE TABLE Shows (
    ShowID INT PRIMARY KEY,
    MovieID INT,
    ShowDate DATE,
    ShowTime TIME,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

CREATE TABLE Customers (
    CustID INT PRIMARY KEY,
    CustName VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(15)
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustID INT,
    ShowID INT,
    NumTickets INT,
    BookingDate DATE,
    FOREIGN KEY (CustID) REFERENCES Customers(CustID),
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID)
);

INSERT INTO Movies VALUES
(1, 'Leo', 'Action', 160, 250.00),
(2, 'Kalki 2898 AD', 'Sci-Fi', 180, 300.00),
(3, 'Kantara', 'Drama', 150, 200.00);

INSERT INTO Shows VALUES
(101, 1, '2025-10-25', '18:00:00'),
(102, 2, '2025-10-25', '20:30:00'),
(103, 3, '2025-10-26', '17:00:00');

INSERT INTO Customers VALUES
(1001, 'Ravi Kumar', 'ravi@gmail.com', '9876543210'),
(1002, 'Priya Shetty', 'priya@gmail.com', '9876501234'),
(1003, 'Arjun Rao', 'arjun@gmail.com', '9886009876');

INSERT INTO Bookings VALUES
(5001, 1001, 101, 2, '2025-10-23'),
(5002, 1002, 102, 3, '2025-10-24'),
(5003, 1003, 103, 1, '2025-10-25'),
(5004, 1001, 103, 2, '2025-10-26');


SELECT 
    c.CustName,
    m.Title ,
    s.ShowDate,
    s.ShowTime,
    b.NumTickets
FROM Bookings b
JOIN Customers c ON b.CustID = c.CustID
JOIN ShowTime s ON b.ShowID = s.ShowID
JOIN Movie m ON s.MovieID = m.MovieID;


SELECT 
    m.Title AS MovieTitle,
    SUM(b.NoOfTickets) as LastBookingDate
FROM Booking b
JOIN ShowTime s ON b.ShowID = s.ShowID
JOIN Movie m ON s.MovieID = m.MovieID
GROUP BY m.Title;

DELIMITER $$

CREATE PROCEDURE InsertBooking (
    IN p_BookingID INT,
    IN p_CustID INT,
    IN p_ShowID INT,
    IN p_NoOfTickets INT,
    IN p_BookingDate DATE
)
BEGIN
    INSERT INTO Booking (BookingID, CustID, ShowID, NoOfTickets, BookingDate)
    VALUES (p_BookingID, p_CustID, p_ShowID, p_NoOfTickets, p_BookingDate);
END $$

DELIMITER ;
CALL InsertBooking(305, 202, 103, 2, '2025-10-25');


DELIMITER $$

CREATE PROCEDURE UpdateBooking (
    IN p_BookingID INT,
    IN p_NewTicketCount INT
)
BEGIN
    UPDATE Booking
    SET NoOfTickets = p_NewTicketCount
    WHERE BookingID = p_BookingID;
END $$

DELIMITER ;

