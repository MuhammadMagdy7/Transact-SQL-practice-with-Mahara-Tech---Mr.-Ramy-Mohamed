-- ● Restore ITI and adventureworks2012 DBs to Server 
RESTORE DATABASE FILELISTONLY
FROM DISK = 'D:\MaharaTech\ITI DB.bak';

RESTORE DATABASE ITI
FROM DISK = 'D:\MaharaTech\ITI DB.bak'
WITH MOVE 'ITI' TO 'D:\DB\ITI.mdf',
     MOVE 'ITI_Log' TO 'D:\DB\ITI_log.ldf';

--------------------------------------------------------

RESTORE DATABASE FILELISTONLY
FROM DISK = 'D:\MaharaTech\adventureworks2012.bak';

RESTORE DATABASE adventureworks2012
FROM DISK = 'D:\MaharaTech\adventureworks2012.bak'
WITH MOVE 'adventureworks2012_Data' TO 'D:\DB\adventureworks2012_Data.mdf',
     MOVE 'adventureworks2012_Log' TO 'D:\DB\adventureworks2012_log.ldf';


-- Part-1: Use ITI DB
USE ITI;

-- 1. Retrieve a number of students who have a value in their age.
SELECT COUNT(st_age) 
FROM Student;

-- 2. Get all instructors Names without repetition
SELECT DISTINCT Ins_Name
FROM Instructor 

/*
3. Display student with the following Format (use isNull function)
		Student ID | Student Full | Name Department name
*/
SELECT 
	st_id AS [Student ID], 
	CONCAT_WS(' ', isNull(St_Fname, '---'), isNull(St_Lname, '---')) AS [Full Name], 
	D.Dept_Name AS [Department name]
FROM 
	Student S
INNER JOIN 
	Department D
ON 
	S.Dept_Id = D.Dept_Id;

/*
4. Display instructor Name and Department Name
Note: display all the instructors if they are attached to a department or not
*/
SELECT 
		 
		isNull(Ins_Name, 'NOT FOUND') AS [Full Name], 
		D.Dept_Name AS [Department name]
FROM 
	Instructor I
LEFT JOIN 
	Department D
ON 
	I.Dept_Id = D.Dept_Id;

/* 5. Display student full name and the name of the course he is taking
For only courses which have a grade */
SELECT 
	CONCAT_WS(' ',St_Fname, St_Lname) AS [Full Name],
	C.Crs_Name AS [Course Name]
FROM Student S
INNER JOIN Stud_Course  SC
ON S.St_Id = SC.St_Id
INNER JOIN  Course C
ON SC.Crs_Id = C.Crs_Id
WHERE SC.Grade IS NOT NULL;

-- 6. Display number of courses for each topic name
SELECT 
	C.Top_Id, T.Top_Name , 
	Count(*) AS [COUNT OF COURSES]
FROM Course C
INNER JOIN Topic T
ON C.Top_Id = T.Top_Id
GROUP BY C.Top_Id, T.Top_Name;

-- 7. Display max and min salary for instructors
SELECT 
	MAX(Salary) AS [Max Salary], 
	MIN(Salary) AS [MIN Salary]
FROM Instructor

-- 8. Display instructors who have salaries less than the average salary of all instructors.
SELECT Ins_Name
FROM Instructor
WHERE Salary < (SELECT AVG(Salary) FROM Instructor )

-- 9. Display the Department name that contains the instructor who receives the minimum salary.
SELECT DISTINCT D.Dept_Name, I.Dept_Id, Salary
FROM Instructor I
INNER JOIN Department D
ON I.Dept_Id = D.Dept_Id
WHERE Salary = (SELECT MIN(Salary) FROM Instructor)


-- 10. Select max two salaries in the instructor table.
SELECT TOP 2 INS_Name, Salary
FROM Instructor
ORDER BY Salary DESC

/*
11. Select instructor name and his salary but if there is no salary display instructor
bonus keyword. “use coalesce Function”
*/
SELECT Ins_Name, COalesce(Salary, 'Bonus') AS Salary
FROM Instructor


-- 12.Select Average Salary for instructors
SELECT AVG(Salary) AS AVG_Salary
FROM Instructor

-- 13.Select Student first name and the data of his supervisor
SELECT S.St_Fname AS Student, Su.St_Fname AS supervisor
FROM Student S
INNER JOIN Student Su
ON S.St_super = Su.St_Id

/*
14.Write a query to select the highest two salaries in Each Department for
instructors who have salaries. “using one of Ranking Functions”
*/
SELECT *
FROM (SELECT 
		Ins_name,
		Salary,
		DENSE_RANK() over (PARTITION BY DEPT_ID ORDER BY Salary DESC) AS DeptRank,
		DEPT_ID
FROM Instructor 
) AS T
WHERE DeptRank IN (1, 2)


-- 15. Write a query to select a random student from each department. “using one of Ranking Functions”
SELECT *
FROM (SELECT 
		St_Fname,
		St_Age,
		RANK() over (PARTITION BY DEPT_ID ORDER BY NEWID()) AS RandomRank,
		DEPT_ID
FROM Student 
) AS T
WHERE Dept_Id IS NOT NULL AND RandomRank = 1 

-- Part-2: Use AdventureWorks DB
USE adventureworks2012;

/* 1. Display the SalesOrderID, ShipDate of the SalesOrderHeader table (Sales
schema) to show SalesOrders that occurred within the period ‘7/28/2002’
and ‘7/29/2014’ */
SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '7/28/2002' AND '7/29/2014'  ;

/* 2. Display only Products(Production schema) with a StandardCost below
$110.00 (show ProductID, Name only) */

SELECT Top 5 *
FROM Production.Product;

SELECT ProductID, Name
FROM Production.Product
WHERE StandardCost < 110;

-- 3. Display ProductID, Name if its weight is unknown
SELECT ProductID, Name
FROM Production.Product
WHERE weight IS NULL;

-- 4. Display all Products with a Silver, Black, or Red Color
SELECT ProductID, Name
FROM Production.Product
WHERE Color IN ('Silver', 'Black', 'Red');

-- 5. Display any Product with a Name starting with the letter B
SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'B%';

/* 6. Run the following Query
	UPDATE Production.ProductDescription
	SET Description = 'Chromoly steel_High of defects'
	WHERE ProductDescriptionID = 3
	Then write a query that displays any Product description with underscore
	value in its description. */

UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3;

SELECT * FROM Production.ProductDescription;

SELECT Description
FROM Production.ProductDescription
WHERE Description LIKE '%\_%' ESCAPE '\';

/* 7. Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader
table for the period between '7/1/2001' and '7/31/2014' */
SELECT Top 5 *
FROM Sales.SalesOrderHeader;

SELECT OrderDate, SUM(TotalDue) [SUM of total for each day]
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '7/1/2001' AND '7/31/2014'
GROUP BY OrderDate
ORDER BY OrderDate;

-- 8. Display the Employees HireDate (note no repeated values are allowed)
SELECT DISTINCT HireDate
FROM HumanResources.Employee;

-- 9. Calculate the average of the unique ListPrices in the Product table
SELECT AVG(ListPrice)
FROM (SELECT DISTINCT ListPrice FROM Production.Product) T;

/* 10.Display the Product Name and its ListPrice within the values of 100 and 120
the list should have the following format "The [product name] is only! [List
price]" (the list will be sorted according to its ListPrice value) */
SELECT 'The ' + Name  + ' is only! ' + Cast(ListPrice AS Varchar(20)) AS Text
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice;


/* 11.
a) Transfer the rowguid ,Name, SalesPersonID, Demographics from
Sales.Store table in a newly created table named [store_Archive]
Note: Check your database to see the new table and how many rows in it?
b) Try the previous query but without transferring the data? */
 SELECT TOP 5 *
 FROM Sales.Store;

 SELECT rowguid ,Name, SalesPersonID, Demographics INTO Sales.[store_Archive]
 FROM Sales.Store;

 SELECT *
 FROM Sales.[store_Archive];

 SELECT rowguid ,Name, SalesPersonID, Demographics
 FROM Sales.Store;

/* 12.Using union statement, retrieve the today’s date in different styles using the
convert or format function. */
SELECT CONVERT(VARCHAR, GETDATE(), 101) AS [Today_Date]     -- mm/dd/yyyy
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 103)                     -- dd/mm/yyyy
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 104)                     -- dd.mm.yyyy
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 105)                     -- dd-mm-yyyy
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 106)                     -- dd mon yyyy
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 108);                    -- hh:mm:ss


