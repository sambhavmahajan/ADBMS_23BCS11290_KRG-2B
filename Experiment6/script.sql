-- ==================================================================
-- Step 1: Setup Employees Table with Sample Data
-- ==================================================================

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id     SERIAL PRIMARY KEY,
    emp_name   VARCHAR(100) NOT NULL,
    gender     VARCHAR(10) CHECK (gender IN ('Male', 'Female')),
    department VARCHAR(50),
    joining_date DATE DEFAULT CURRENT_DATE
);

-- Insert sample employees
INSERT INTO employees (emp_name, gender, department) VALUES
('Amit Sharma', 'Male', 'IT'),
('Priya Nair', 'Female', 'HR'),
('Ravi Kumar', 'Male', 'Finance'),
('Neha Singh', 'Female', 'IT'),
('Arjun Mehta', 'Male', 'Marketing'),
('Shreya Iyer', 'Female', 'Finance');

-- ==================================================================
-- Step 2: Create Stored Procedure for Employee Count by Gender
-- ==================================================================

DROP PROCEDURE IF EXISTS get_employee_count_by_gender(VARCHAR, OUT INT);

CREATE OR REPLACE PROCEDURE get_employee_count_by_gender(
    IN in_gender VARCHAR,       -- input parameter
    OUT emp_count INT           -- output parameter
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) INTO emp_count
    FROM employees
    WHERE gender = in_gender;

    RAISE NOTICE 'Total % Employees: %', in_gender, emp_count;
END;
$$;

-- ==================================================================
-- Step 3: Call Procedure and Display Results
-- ==================================================================

-- Call for Male employees
CALL get_employee_count_by_gender('Male', NULL);

-- Call for Female employees
CALL get_employee_count_by_gender('Female', NULL);
