CREATE TABLE Authors (
AuthorID INT PRIMARY KEY,
Name VARCHAR(100),
Country VARCHAR(50)
);
CREATE TABLE Books (
BookID INT PRIMARY KEY,
Title VARCHAR(100),
AuthorID INT,
FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);
INSERT INTO Authors VALUES (1, 'Chetan Bhagat', 'India');
INSERT INTO Authors VALUES (2, 'Amish Tripathi', 'India');
INSERT INTO Authors VALUES (3, 'Sudha Murty', 'India');
INSERT INTO Books VALUES (1, 'Five Point Someone', 1);
INSERT INTO Books VALUES (2, 'The Immortals of Meluha', 2);
INSERT INTO Books VALUES (3, 'Wise and Otherwise', 3);
SELECT B.Title AS Book_Title, A.Name AS Author_Name, A.Country
FROM Books B
INNER JOIN Authors A ON B.AuthorID = A.AuthorID;