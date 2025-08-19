-- Create table MyEmployees
CREATE TABLE MyEmployees (
EmpId INT PRIMARY KEY IDENTITY(1,1),
EmpName VARCHAR(50),
Gender VARCHAR(10),
Salary INT,
City VARCHAR(50),
Dept_id INT
);
-- Insert records
INSERT INTO MyEmployees (EmpName, Gender, Salary, City, Dept_id)
VALUES
('Amit', 'Male', 50000, 'Delhi', 2),
('Priya', 'Female', 60000, 'Mumbai', 1),
('Rajesh', 'Male', 45000, 'Agra', 3),
('Sneha', 'Female', 55000, 'Delhi', 4),
('Anil', 'Male', 52000, 'Agra', 2),
('Sunita', 'Female', 48000, 'Mumbai', 1),
('Vijay', 'Male', 47000, 'Agra', 3),
('Ritu', 'Female', 62000, 'Mumbai', 2),
('Alok', 'Male', 51000, 'Delhi', 1),
('Neha', 'Female', 53000, 'Agra', 4),
('Simran', 'Female', 33000, 'Agra', 3);
-- Second highest salary
SELECT MAX(Salary) AS SecondHighestSalary
FROM MyEmployees
WHERE Salary < (SELECT MAX(Salary) FROM MyEmployees);
-- Scalar subquery example
-- (Assumes you already have a 'dept' table created with columns id, dept_name)
SELECT * FROM MyEmployees
WHERE Dept_id <> (SELECT id FROM dept WHERE dept_name = 'Accounts');
-- Multi-valued subquery
SELECT * FROM MyEmployees
WHERE EmpName IN (
SELECT EmpName FROM MyEmployees WHERE Gender = 'Female'
);
-- Employee table example
CREATE TABLE employee (
id INT
);
INSERT INTO employee VALUES (2), (4), (4), (6), (6), (7), (8), (8);
-- Largest unique employee ID (SQL Server style, no LIMIT)
SELECT TOP 1 id
FROM employee
GROUP BY id
HAVING COUNT(id) = 1
ORDER BY id DESC;