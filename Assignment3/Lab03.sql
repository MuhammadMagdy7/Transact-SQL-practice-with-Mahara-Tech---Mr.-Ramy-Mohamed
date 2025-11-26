-- DQL
USE Company_DB
/*
1. Display (Using Union Function)
	a. The name and the gender of the dependence that's gender is Female and depending on Female Employee.
	b. And the male dependence that depends on Male Employee.
*/
SELECT Dependent_name, Sex
FROM Dependent
WHERE Sex = 'F' AND ESSN IN (SELECT SSN FROM Employee WHERE Sex = 'F')
UNION ALL 
SELECT Dependent_name, Sex
FROM Dependent
WHERE Sex = 'M' AND ESSN IN (SELECT SSN FROM Employee WHERE Sex = 'M');

-- 2. For each project, list the project name and the total hours per week (for all employees)
-- spent on that project.
SELECT P.Pname, W.Pno, SUM(Hours) AS [TOTAL Hours]
FROM Works_for W
INNER JOIN Project P
ON P.Pnumber = W.Pno
GROUP BY W.Pno, P.Pname

-- 3. Display the data of the department which has the smallest employee ID over all employees' ID.
SELECT D.*
FROM Departments D
INNER JOIN Employee E
ON D.Dnum = E.Dno
WHERE E.SSN = (SELECT MIN(SSN) FROM Employee)

-- 4. For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
SELECT Dno, Dname, MAX(Salary), MIN(Salary), AVG(Salary)
FROM Employee 
INNER JOIN Departments 
ON Dno = Dnum
GROUP BY Dno, Dname

-- 5. List the full name of all managers who have no dependents.
SELECT CONCAT_WS(' ', E.Fname, E.Lname) AS [FULL NAME]
FROM Employee E
INNER JOIN Departments D
    ON E.SSN = D.MGRSSN         -- Find managers
LEFT JOIN Dependent DP
    ON E.SSN = DP.ESSN          -- Check if they have dependents
WHERE DP.ESSN IS NULL;          -- Keep only managers with NO dependents


/*
6. For each department-- if its average salary is less than the average salary of all
	employees-- display its number, name and number of its employees.
*/
SELECT Dno, Dname, Count(SSN)
FROM Employee E
INNER JOIN Departments D
ON Dno = Dnum
GROUP BY Dno, Dname
Having AVG(Salary) < (SELECT AVG(Salary) FROM Employee); 

/*
7. Retrieve a list of employee’s names and the projects names they are working on
	ordered by department number and within each department, ordered alphabetically by
	last name, first name.
*/
SELECT CONCAT_WS(' ', E.Fname, E.Lname) AS [FULL NAME],  P.Pname
FROM Employee E
INNER JOIN Works_for W
ON E.SSn = W.ESSn
INNER JOIN Project P
ON P.Pnumber = W.Pno
INNER JOIN Departments D
ON E.Dno = D.Dnum
ORDER BY D.Dnum, E.Fname, E.Lname

-- 8. Try to get the max 2 salaries using sub query
SELECT TOP 2 CONCAT_WS(' ', Fname, Lname) AS [FULL NAME], Salary
FROM Employee
ORDER BY Salary DESC;

-- 9. Get the full name of employees that is similar to any dependent name
SELECT CONCAT_WS(' ', Fname, Lname) AS [FULL NAME]
FROM Employee
WHERE Fname + ' ' + Lname IN (SELECT Dependent_name FROM Dependent);

-- 10. Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.
SELECT E.SSN, E.Fname
FROM Employee E
WHERE EXISTS (
	SELECT 1
	FROM Dependent D
	WHERE E.SSN = D.ESSN
	)

/*
11. In the department table insert new department called "DEPT IT”, with id 100,
	employee with SSN = 112233 as a manager for this department. The start date for this
	manager is '1-11-2006'
*/
INSERT INTO Departments Values('IT', 100, 112233, '1-11-2006')


/*
12. Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574) moved to
	be the manager of the new department (id = 100), and they give you(your SSN
	=102672) her position (Dept. 20 manager)
	a. First try to update her record in the department table
	b. Update your record to be department 20 manager.
	c. Update the data of employee number=102660 to be in your teamwork (he will
	be supervised by you) (your SSN =102672)
*/
-- a
UPDATE Departments
SET MGRSSN = 968574
WHERE Dnum = 100;

-- b
UPDATE Departments
SET MGRSSN = 102672
WHERE Dnum = 20;

-- c
UPDATE Employee
SET Superssn = 102672
WHERE SSN = 102660;


/*
13. Unfortunately the company ended the contract with Mr. Kamel Mohamed
	(SSN=223344) so try to delete his data from your database in case you know that you
	will be temporarily in his position.
	Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises
	any employees or works in any projects and handle these cases).
*/
SELECT 1
FROM Dependent
WHERE ESSN = '223344'

DELETE 
FROM Dependent
WHERE ESSN = 223344

UPDATE Departments
SET MGRSSN = 102672
WHERE MGRSSN = 223344;

UPDATE Employee
SET Superssn = 102672
WHERE Superssn = 223344;


-- 14. Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
UPDATE Employee
Set Salary = Salary * 1.30
WHERE SSN IN (SELECT W.ESSn FROM Project P INNER JOIN Works_for W ON W.Pno = P.Pnumber WHERE Pname = 'Al Rabwah')
