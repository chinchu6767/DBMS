-- Lab Experiment 05: To implement different types of joins: Inner Join, Outer Join (Left, Right, Full), and Natural Join.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: chinchana k
-- USN: 1ru24bca0018
-- SECTION: A
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Write your code below this line along with the output 
create database onlineshopping;
use onlineshopping;
-- table 01: Customers
-- CREATE  a TABLE named Customers (customer_id INT PRIMARY KEY,customer_name VARCHAR(50),city VARCHAR(50)
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

-- insert 5 records
INSERT INTO Customers (customer_id, customer_name, city) VALUES
(101, 'Preethesh', 'RR Nagar'),
(102, 'Deekusha', 'Hosakote'),
(103, 'Chichu', 'Ramanagara'),
(104, 'Shadow', 'Dubai'),
(105, 'Lishika', 'Patna');
select * from Customers;
-- output:
# customer_id, customer_name, city
/*'101', 'Preethesh', 'RR Nagar'
'102', 'Deekusha', 'Hosakote'
'103', 'Chichu', 'Ramanagara'
'104', 'Shadow', 'Dubai'
'105', 'Lishika', 'Patna'*/

-- TABLE:02 Orders Table

-- CREATE a TABLE named Orders (order_id INT PRIMARY KEY,customer_id INT foreign key,product_name VARCHAR(50),order_date DATE,
    -- insert 5 records


-- TASK FOR STUDENTS 
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, customer_id, product_name, order_date) VALUES
(1, 101, 'Saree', '2009-09-22'),
(2, 102, 'Lengha', '2046-02-21'),
(3, 103, 'Tops', '2023-04-17'),
(4, 104, 'Jeans', '2024-06-15'),
(5, 105, 'Lipstick', '2002-07-18');
SELECT *FROM Orders;

-- output: 
# order_id, customer_id, product_name, order_date
/*'1', '101', 'Saree', '2009-09-22'
'2', '102', 'Lengha', '2046-02-21'
'3', '103', 'Tops', '2023-04-17'
'4', '104', 'Jeans', '2024-06-15'
'5', '105', 'Lipstick', '2002-07-18'*/

 
-- Write and Execute Queries
/*
1. Inner Join – 
   Find all orders placed by customers from the city "Bangalore."
   List all customers with the products they ordered.
   Show customer names and their order dates.
   Display order IDs with the corresponding customer names.
   Find the number of orders placed by each customer.
   Show city names along with the products ordered by customers.
*/
SELECT Orders.order_id, Customers.customer_name, Orders.product_name, Orders.order_date 
FROM Orders JOIN Customers ON Orders.customer_id = Customers.customer_id WHERE Customers.city='Bangalore';

SELECT Customers.customer_name, Orders.product_name 
FROM Customers JOIN Orders ON Customers.customer_id = Orders.customer_id;
-- output:
/*Preethesh	Saree
Deekusha	Lengha
Chichu	Tops
Shadow	Jeans
Lishika	Lipstick*/

SELECT Customers.customer_name, Orders.order_date 
FROM Customers JOIN Orders ON Customers.customer_id = Orders.customer_id;
-- output :
/*# customer_name, order_date
'Preethesh', '2009-09-22'
'Deekusha', '2046-02-21'
'Chichu', '2023-04-17'
'Shadow', '2024-06-15'
'Lishika', '2002-07-18'*/

SELECT Orders.order_id, Customers.customer_name 
FROM Orders JOIN Customers ON Orders.customer_id = Customers.customer_id;
-- output:
/*# order_id, customer_name
'1', 'Preethesh'
'2', 'Deekusha'
'3', 'Chichu'
'4', 'Shadow'
'5', 'Lishika'*/

SELECT Customers.customer_name, COUNT(Orders.order_id) AS total_orders 
FROM Customers JOIN Orders ON Customers.customer_id = Orders.customer_id GROUP BY Customers.customer_name;
-- output:
/*# customer_name, total_orders
'Preethesh', '1'
'Deekusha', '1'
'Chichu', '1'
'Shadow', '1'
'Lishika', '1'*/

SELECT Customers.city, Orders.product_name 
FROM Customers JOIN Orders ON Customers.customer_id = Orders.customer_id;
-- output:
# city, product_name
/*'RR Nagar', 'Saree'
'Hosakote', 'Lengha'
'Ramanagara', 'Tops'
'Dubai', 'Jeans'
'Patna', 'Lipstick'*/

/* 
2  Left Outer Join – 
    Find all customers and their orders, even if a customer has no orders.
    List all customers and the products they ordered.
    Show customer IDs, names, and their order IDs.
    Find the total number of orders (if any) placed by each customer.
    Retrieve customers who have not placed any orders.
	Display customer names with their order dates.
-- Write your code below this line along with the output 
*/
SELECT Customers.customer_name, Orders.product_name FROM Customers LEFT JOIN Orders ON Customers.customer_id=Orders.customer_id;
/*# customer_name, product_name
'Preethesh', 'Saree'
'Deekusha', 'Lengha'
'Chichu', 'Tops'
'Shadow', 'Jeans'
'Lishika', 'Lipstick'*/

SELECT Customers.customer_id, Customers.customer_name, Orders.order_id FROM Customers LEFT JOIN Orders ON Customers.customer_id=Orders.customer_id;
/*# customer_id, customer_name, order_id
'101', 'Preethesh', '1'
'102', 'Deekusha', '2'
'103', 'Chichu', '3'
'104', 'Shadow', '4'
'105', 'Lishika', '5'*/

SELECT Customers.customer_name, COUNT(Orders.order_id) AS total_orders FROM Customers LEFT JOIN Orders ON Customers.customer_id=Orders.customer_id GROUP BY Customers.customer_name;
/*# customer_name, total_orders
'Preethesh', '1'
'Deekusha', '1'
'Chichu', '1'
'Shadow', '1'
'Lishika', '1'*/

SELECT Customers.customer_name FROM Customers LEFT JOIN Orders ON Customers.customer_id=Orders.customer_id WHERE Orders.order_id IS NULL;
SELECT Customers.customer_name FROM Customers LEFT JOIN Orders ON Customers.customer_id=Orders.customer_id WHERE Orders.order_id IS NULL;

 
/* 3: Right Outer Join – 
      Find all orders and their corresponding customers, even if an order doesn't have a customer associated with it.
      Show all orders with the customer names.
      Display product names with the customers who ordered them.
	  List order IDs with customer cities.
      Find the number of orders per customer (include those without orders).
	  Retrieve customers who do not have any matching orders.
     Write your code below this line along with the output 
 */
 SELECT Orders.order_id, Customers.customer_name FROM Customers RIGHT JOIN Orders ON Customers.customer_id=Orders.customer_id;
 /*# order_id, customer_name
'1', 'Preethesh'
'2', 'Deekusha'
'3', 'Chichu'
'4', 'Shadow'
'5', 'Lishika'
*/
SELECT Orders.order_id, Customers.customer_name, Orders.product_name FROM Customers RIGHT JOIN Orders ON Customers.customer_id=Orders.customer_id;
/*# order_id, customer_name, product_name
'1', 'Preethesh', 'Saree'
'2', 'Deekusha', 'Lengha'
'3', 'Chichu', 'Tops'
'4', 'Shadow', 'Jeans'
'5', 'Lishika', 'Lipstick'*/

SELECT Orders.product_name, Customers.customer_name FROM Customers RIGHT JOIN Orders ON Customers.customer_id=Orders.customer_id;
/*# product_name, customer_name
'Saree', 'Preethesh'
'Lengha', 'Deekusha'
'Tops', 'Chichu'
'Jeans', 'Shadow'
'Lipstick', 'Lishika'
*/
SELECT Orders.order_id, Customers.city FROM Customers RIGHT JOIN Orders ON Customers.customer_id=Orders.customer_id;
/*# order_id, city
'1', 'RR Nagar'
'2', 'Hosakote'
'3', 'Ramanagara'
'4', 'Dubai'
'5', 'Patna'*/

SELECT Customers.customer_name, COUNT(Orders.order_id) AS total_orders FROM Customers RIGHT JOIN Orders ON Customers.customer_id=Orders.customer_id GROUP BY Customers.customer_name;
/*# customer_name, total_orders
'Preethesh', '1'
'Deekusha', '1'
'Chichu', '1'
'Shadow', '1'
'Lishika', '1'
*/
SELECT Customers.customer_name FROM Customers LEFT JOIN Orders ON Customers.customer_id=Orders.customer_id WHERE Orders.order_id IS NULL;


/* 4: Full Outer Join – 
        Find all customers and their orders, including those customers with no orders and orders without a customer.
	List all customers and products, whether they placed an order or not.
        Show customer IDs with order IDs (include unmatched ones).
		Display customer names with order dates.
		Find all unmatched records (customers without orders and orders without customers).
        Show customer cities with products.
     Write your code below this line along with the output 
*/
SELECT order_id,product_name,Customer_name
FROM Orders LEFT OUTER JOIN Customers
ON Customers.customer_id = Orders.customer_id
UNION
SELECT order_id,product_name,Customer_name
FROM Orders RIGHT OUTER JOIN Customers
ON Customers.customer_id = Orders.customer_id;
-- output:
/*# order_id, product_name, Customer_name
'1', 'Saree', 'Preethesh'
'2', 'Lengha', 'Deekusha'
'3', 'Tops', 'Chichu'
'4', 'Jeans', 'Shadow'
'5', 'Lipstick', 'Lishika'*/

SELECT customer_name,product_name
 FROM Customers LEFT JOIN Orders 
 ON customer.customer_id=orders.customer_id 
 UNION SELECT customer_name,product_name 
 FROM Customers RIGHT JOIN Orders
 ON customer.customer_id= orders.customer_id;
 
 SELECT customers.customer_id,orders.order_id
 FROM Customers customers LEFT JOIN Orders orders 
 ON customers.customer_id=orders.customer_id 
 UNION SELECT customers.customer_id,orders.order_id 
 FROM Customers customers RIGHT JOIN Orders orders 
 ON customers.customer_id=orders.customer_id;
/*# customer_id, order_id
'101', '1'
'102', '2'
'103', '3'
'104', '4'
'105', '5'*/
SELECT c.customer_id,o.order_id 
FROM Customers c LEFT JOIN Orders o 
ON c.customer_id=o.customer_id 
UNION SELECT c.customer_id,o.order_id 
FROM Customers c 
RIGHT JOIN Orders o 
ON c.customer_id=o.customer_id;

SELECT c.customer_name,o.order_date 
FROM Customers c LEFT JOIN Orders o 
ON c.customer_id=o.customer_id 
UNION SELECT c.customer_name,o.order_date 
FROM Customers c RIGHT JOIN Orders o 
ON c.customer_id=o.customer_id;
-- output: 
/*# customer_name, order_date
'Preethesh', '2009-09-22'
'Deekusha', '2046-02-21'
'Chichu', '2023-04-17'
'Shadow', '2024-06-15'
'Lishika', '2002-07-18'*/

SELECT c.customer_name,o.product_name 
FROM Customers c LEFT JOIN Orders o 
ON c.customer_id=o.customer_id 
WHERE o.order_id 
IS NULL UNION SELECT c.customer_name,o.product_name 
FROM Customers c RIGHT JOIN Orders o 
ON c.customer_id=o.customer_id WHERE c.customer_id IS NULL;


SELECT c.city,o.product_name 
FROM Customers c LEFT JOIN Orders o 
ON c.customer_id=o.customer_id 
UNION SELECT c.city,o.product_name 
FROM Customers c RIGHT JOIN Orders o 
ON c.customer_id=o.customer_id;

-- output:
/*# city, product_name
'RR Nagar', 'Saree'
'Hosakote', 'Lengha'
'Ramanagara', 'Tops'
'Dubai', 'Jeans'
'Patna', 'Lipstick'*/



  /* 5: Natural Join – 
          Find all orders placed by customers.
          List all customers with the products they ordered using NATURAL JOIN.
          Show customer names along with their order dates using NATURAL JOIN.
          Find all customer cities and the products ordered by those customers using NATURAL JOIN.

     Write your code below this line along with the output 
  */
  
SELECT * FROM Customers NATURAL JOIN Orders;
-- output:
# customer_id, customer_name, city, order_id, product_name, order_date
/*'101', 'Preethesh', 'RR Nagar', '1', 'Saree', '2009-09-22'
'102', 'Deekusha', 'Hosakote', '2', 'Lengha', '2046-02-21'
'103', 'Chichu', 'Ramanagara', '3', 'Tops', '2023-04-17'
'104', 'Shadow', 'Dubai', '4', 'Jeans', '2024-06-15'
'105', 'Lishika', 'Patna', '5', 'Lipstick', '2002-07-18'*/

SELECT customer_name, product_name FROM Customers NATURAL JOIN Orders;
-- output:
/*'Preethesh', 'Saree'
'Deekusha', 'Lengha'
'Chichu', 'Tops'
'Shadow', 'Jeans'
'Lishika', 'Lipstick'*/

SELECT customer_name, order_date FROM Customers NATURAL JOIN Orders;
-- output:
/*# customer_name, order_date
'Preethesh', '2009-09-22'
'Deekusha', '2046-02-21'
'Chichu', '2023-04-17'
'Shadow', '2024-06-15'
'Lishika', '2002-07-18'*/

SELECT city, product_name FROM Customers NATURAL JOIN Orders;
-- output: 
/*# city, product_name
'RR Nagar', 'Saree'
'Hosakote', 'Lengha'
'Ramanagara', 'Tops'
'Dubai', 'Jeans'
'Patna', 'Lipstick'*/



