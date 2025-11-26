-- Restore Company DB 
RESTORE DATABASE FILELISTONLY
FROM DISK = 'D:\MaharaTech\Company DB.bak';

RESTORE DATABASE Company_DB
FROM DISK = 'D:\MaharaTech\Company DB.bak'
WITH MOVE 'Company_SD' TO 'D:\DB\Company DB.mdf',
     MOVE 'Company_SD_Log' TO 'D:\DB\Company DB_log.ldf';


use Company_DB


-- 1. Display all the employees Data.
SELECT * FROM Employee;


-- 2. Display the employee First name, last name, Salary and Department number.
SELECT Fname,Lname, Salary, Dno FROM Employee

-- 3. Display all the projects names, locations and the department which is responsible about it.
SELECT Pname, Plocation, D.Dname FROM Project P INNER JOIN Departments D ON D.Dnum = P.Dnum

/*
4. If you know that the company policy is to pay an annual commission for each
employee with specific percent equals 10% of his/her annual salary .Display each
employee full name and his annual commission in an ANNUAL COMM column
(alias).
*/
SELECT CONCAT_WS(' ', Fname, Lname) AS [Full Name],
		Salary * .10 AS [ANNUAL COMM]
FROM Employee;


-- 5. Display the employees Id, name who earns more than 1000 LE monthly.
SELECT SSN, CONCAT_WS(' ', Fname, Lname) AS [Full Name]
FROM Employee
WHERE Salary > 1000;

-- 6. Display the employees Id, name who earns more than 10000 LE annually.
SELECT SSN, CONCAT_WS(' ', Fname, Lname) AS [Full Name]
FROM Employee
WHERE Salary*12 > 10000;

-- 7. Display the names and salaries of the female employees
SELECT CONCAT_WS(' ', Fname, Lname) AS [Full Name], Salary
FROM Employee
WHERE Sex = 'F';

-- 8. Display each department id, name which managed by a manager with id equals 968574.
SELECT Dnum, Dname
FROM Departments
WHERE MGRSSN = 968574;

-- 9. Display the ids, names and locations of the pojects which controled with department 10.
SELECT Pnumber, Pname, Plocation
FROM Project
WHERE Dnum = 10;
