CREATE DATABASE Library;
USE Library;
CREATE TABLE Branch(Branch_no INT PRIMARY KEY, Manager_Id INT, Branch_address VARCHAR(50), Contact_no BIGINT);
INSERT INTO Branch VALUES
(101, 001, 'PS TOWER CALICUT', 9865327412),
(102, 002, 'AM CENTER ERNAKULAM', 7754326595),
(103, 003, 'CN TOWER TRIVANDRUM', 6258974562),
(104, 004, 'HS BUILDING TRISSUR', 6852301235),
(105, 005, 'PM TOWER KANNUR', 7845120369),
(106, 006, 'KK CENTER MALAPPURAM', 7812459630),
(107, 007, 'GM TOWER KOLLAM', 8526361024);
SELECT * FROM Branch;

CREATE TABLE Employee(Emp_Id INT PRIMARY KEY,Emp_name VARCHAR(20), Position VARCHAR(20), Salary INT);
INSERT INTO Employee VALUES
(201, 'ABHI', 'INVESTMENT OFFICER', 52000),
(202, 'AJAY', 'ACCOUNTANT', 48000),
(203, 'SHYAM', 'SR ACCOUNTANT', 52000),
(204, 'TOM', 'CLERK', 33000),
(205, 'SHARATH', 'PRO', 56000),
(206, 'REENA', 'LOAN OFFICER', 52000),
(207, 'TEENA', 'ASSOCIATE', 52000);
SELECT * FROM Employee;
 

CREATE TABLE Customer(Customer_Id INT PRIMARY KEY, Customer_name VARCHAR(20), Customer_address VARCHAR(30), Reg_date DATE);
INSERT INTO Customer VALUES
(301, 'RAMESH', 'CALICUT', '2020-05-10'),
(302, 'RAJESH', 'MALAPPURAM', '2020-10-18'),
(303, 'AKSHAY', 'TRIVANDRUM', '2022-12-06'),
(304, 'RASHID', 'KOLLAM', '2021-08-04'),
(305, 'DIYA', 'KANNUR', '2022-06-10'),
(306, 'DAVID', 'WAYANAD', '2019-12-25'),
(307, 'JOHN', 'KOCHI', '2021-08-06');
SELECT * FROM Customer;

CREATE TABLE Books(ISBN VARCHAR(13) PRIMARY KEY, Books_title VARCHAR(30), Category VARCHAR(30), Rental_Price INT,
Status VARCHAR(3), Author VARCHAR(30), publisher VARCHAR(30));
INSERT INTO Books VALUES
('95623-123-2-4', 'THE ALCHEMIST', 'ADVENTURE', 180, 'NO', 'PAULO COELHO', 'HARPER TORCH'),
('82623-156-2-3', 'THE DA VINCI CODE', 'THRILLER', 190, 'YES', 'DAN BROWN', 'DOUBLEDAY'),
('75842-853-9-7', 'THE HOBBIT', 'ADVENTURE', 150, 'YES', 'JOHN RONALD', 'HOUGHTON MIFFLIIN HARCOURT'),
('36259-327-6-8', 'A TALE OF TWO CITIES', 'HISTORY', 190, 'NO', 'CHARLES DICKENS', 'CHAPMAN'),
('45210-013-4-2', 'IT ENDS WITH US', 'ROMANCE', 120, 'YES', 'COLLEEN HOOVER', 'SIMON'),
('96587-896-8-4', 'LOLITA', 'EROTIC', 100, 'NO', 'VLADIMIR NABOKOV', 'OLYMPIA PRESS'),
('67823-784-6-5', 'ATOMIC HABITS', 'NON FICTION', 100, 'NO', 'JAMES CLEAR', 'RANDOM HOUSE');
SELECT * FROM BOOKS;


CREATE TABLE IssueStatus(Issue_Id INT PRIMARY KEY, Issued_cust INT, FOREIGN KEY(Issued_cust) REFERENCES Customer(Customer_Id),
Issued_book_name VARCHAR(30), Issue_date DATE, Isbn_book VARCHAR(13), FOREIGN KEY(Isbn_book) REFERENCES Books(ISBN));
INSERT INTO IssueStatus VALUES
(401, 301, 'THE ALCHEMIST', '2022-04-13', '95623-123-2-4'),
(402, 302, 'THE DA VINCI CODE', '2023-06-21', '82623-156-2-3'),
(403, 303, 'THE HOBBIT', '2023-06-17', '75842-853-9-7'),
(404, 304, 'A TALE OF TWO CITIES', '2021-12-31', '36259-327-6-8'),
(405, 305, 'IT ENDS WITH US', '2022-08-19', '45210-013-4-2'),
(406, 306, 'LOLITA', '2023-07-11', '96587-896-8-4');
SELECT * FROM IssueStatus;

CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY, return_cust INT, Return_book_name VARCHAR(30), 
Return_date DATE, Isbn_book2 VARCHAR(13), FOREIGN KEY(Isbn_book2) REFERENCES Books(ISBN));
INSERT INTO ReturnStatus VALUES
(501, 302, 'THE DA VINCI CODE', '2023-07-21', '82623-156-2-3'),
(502, 303, 'THE HOBBIT', '2023-07-08', '75842-853-9-7'),
(503, 305, 'IT ENDS WITH US', '2022-12-13', '45210-013-4-2');
SELECT * FROM ReturnStatus;



SELECT Books_title,Category, Rental_Price FROM Books WHERE Status ='YES';


SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;


SELECT Issued_book_name, Customer_name
FROM IssueStatus, Customer
WHERE IssueStatus.Issued_cust = Customer.Customer_Id;


SELECT count(Books_title), Category FROM Books GROUP BY Category;


SELECT Emp_name, Position, Salary FROM Employee WHERE Salary > 50000;

 
SELECT Customer_name, Customer_Id 
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);


SELECT Branch_no, count(Manager_Id) AS 'Count of employees' 
FROM Branch GROUP BY Branch_no;


SELECT Customer_name, Issued_book_name
FROM Customer, IssueStatus
WHERE Customer.Customer_Id = IssueStatus.Issued_cust
AND Issue_date between '2023-05-31' AND '2023-06-30';


SELECT Books_title FROM Books WHERE Category = 'HISTORY';


SELECT Branch.Branch_no, COUNT(*) AS Total_Employees
FROM Branch
JOIN Employee ON Branch.Manager_Id = Employee.Emp_Id
GROUP BY Branch.Branch_no
HAVING COUNT(*) > 5;
