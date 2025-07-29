CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseCode VARCHAR(30),
    CourseName VARCHAR(100),
    Instructor VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Departments VALUES (1, 'Computer Science & Engg');
INSERT INTO Departments VALUES (2, 'Training & Development');

INSERT INTO Courses VALUES (1, 'CONT_23CST-303', 'OPERATING SYSTEM', 'Puneet Kaur', 1);
INSERT INTO Courses VALUES (2, 'CONT_23CST-302', 'COMPUTER NETWORKS', 'Monika', 1);
INSERT INTO Courses VALUES (3, 'CONT_23CSH-304', 'PROJECT BASED LEARNING IN JAVA', 'Mayank Sharma', 1);
INSERT INTO Courses VALUES (4, 'CONT_23CSP-339', 'FULL STACK-I', 'Amogh Saxena', 1);
INSERT INTO Courses VALUES (5, 'CONT_23CSP-333', 'ADBMS', 'Tushar Sood', 1);
INSERT INTO Courses VALUES (6, 'CONT_23CSH-301', 'DESIGN AND ANALYSIS OF ALGORITHMS', 'Richa Dhiman', 1);
INSERT INTO Courses VALUES (7, 'CONT_23CSP-332', 'COMPETITIVE CODING-I', 'Harshal Jain', 1);
INSERT INTO Courses VALUES (8, 'CONT_23TDP-311', 'SOFT SKILLS-III', 'Purnima Sood', 2);
INSERT INTO Courses VALUES (9, 'CONT_23TDT-312', 'APTITUDE-III', 'Manphool Singh', 2);
INSERT INTO Courses VALUES (10, '23TDP-311_23BCS_KRG-2_B_B', 'SOFT SKILLS-III', 'Gurvinder Kaur', 2);
INSERT INTO Courses VALUES (11, '23TDT-312_23BCS_KRG-2_B_B', 'APTITUDE-III', 'Vinay Kumar', 2);

SELECT DeptName
FROM Departments D
WHERE (
    SELECT COUNT(*)
    FROM Courses C
    WHERE C.DeptID = D.DeptID
) > 2;

GRANT SELECT ON Courses TO student_user;