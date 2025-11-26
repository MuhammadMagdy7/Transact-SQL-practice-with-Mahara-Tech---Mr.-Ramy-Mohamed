-- Display the Department id, name and id and the name of its manager.
SELECT Dnum, Dname, MGRSSN, Fname
FROM Departments
INNER JOIN Employee E
ON MGRSSN = E.SSN

-- Display the name of the departments and the name of the projects under its control.
SELECT D.Dname, Pname
FROM Departments D
INNER JOIN Project P
ON D.Dnum = P.Dnum

-- Display the full data about all the dependence associated with the name of the employee they depend on him/her.
SELECT D.Dname, Pname
FROM Departments D
INNER JOIN Project P
ON D.Dnum = P.Dnum

-- Display the Id, name and location of the projects in Cairo or Alex city.
SELECT Pnumber, Pname, Plocation
FROM Project 
WHERE City in ('Cairo', 'Alex')

-- Display the Projects full data of the projects with a name starts with "a" letter.  
SELECT *
FROM Project
WHERE Pname Like 'a%'

-- Display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT *
FROM Employee E
WHERE Dno = 30 AND Salary between 1000 and 2000;

-- Retrieve the names of all employees in department 10 who works more than or equal  10 hours per week on "AL Rabwah" project.
SELECT CONCAT_WS(' ', E.Fname, E.Lname) AS [Full Name]
FROM Employee E
INNER JOIN Works_for W
ON E.SSN = W.ESSn
WHERE 
				E.Dno= 10 
			AND 
				W.Hours >= 10 
			AND 
				W.Pno = (SELECT Pnumber FROM Project WHERE Pname = 'AL Rabwah');

-- Find the names of the employees who directly supervised with Kamel Mohamed.
SELECT CONCAT_WS(' ', Fname, Lname) AS [Full Name]
FROM Employee 
WHERE Superssn = (SELECT SSN FROM Employee WHERE CONCAT_WS(' ', Fname, Lname) = 'Kamel Mohamed');


-- Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
SELECT 
	CONCAT_WS(' ', E.Fname, E.Lname) AS [Full Name], P.Pname
FROM 
	Employee E
INNER JOIN 
	Works_for W
ON 
	E.SSN = W.ESSn
INNER JOIN 
	Project P
ON 
	P.Pnumber  = W.Pno
ORDER BY  
	P.Pname;

-- For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
SELECT P.Pnumber, D.Dname, E.Lname, E.Bdate, E.Address
FROM Employee E
INNER JOIN Departments D
ON E.SSN = D.MGRSSN	
INNER JOIN Project P
ON P.Dnum  = D.Dnum
WHERE P.City = 'Cairo'

-- Display All Data of the managers
SELECT E.*
FROM Employee E
INNER JOIN Departments D
ON E.SSN = D.MGRSSN	

-- Display All Employees data and the data of their dependents even if they have no dependents
SELECT *
FROM Employee E
FULL JOIN Dependent D
ON E.SSN = D.ESSN

-- Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
						values('Mohamed', 'Magdy', 102672, '2000-06-24', 'Shoubra', 'M', 2000, 112233, 30)

-- Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or supervisor number to him.
INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
						values('AHmed', 'Mohamed', 102660, '2002-02-21', 'Shoubra', 'M', Null, Null, 30)

-- Upgrade your salary by 20 % of its last value.
UPDATE Employee
SET salary = Salary * 1.20
WHERE SSN = 102672;