-- Define the structure and create an empty table
CREATE TABLE students (
    name VARCHAR(60),
    class INT,
    roll_no BIGINT,
    dob DATE
);


INSERT INTO students (name, class, roll_no, dob) VALUES('Alex', 4, 1003, '2002-10-10');

-- Insert multiple data into the table at once
INSERT INTO students (name, class, roll_no, dob) VALUES
('Kisha', 4, 1004, '2004-10-10'),
('Layne', 5, 1004, '2005-09-11'),
('Chris', 6, 1004, '2004-08-15'),
('Donald', 6, 1004, '2003-02-28'),
('Jeremy', 6, 1004, '2001-11-30'),
('Nisha', 5, 1004, '2002-09-09'),
('Robert', 5, 1004, '2001-01-15');


SELECT name, class, roll_no, dob FROM students;

-- Select one column from the table
SELECT name FROM students;

-- Select only specific columns from the table
SELECT name, class FROM students;

-- Select all the columns from the table
SELECT * FROM students;

-- Column Syntax: --

-- Filtering
SELECT * FROM students WHERE name = 'Layne';

CREATE TABLE claims(
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    dob DATE,
    ssn BIGINT,
    gender VARCHAR(50),
    billing_code VARCHAR(10),
    billing_code_type VARCHAR(10),
    claim_number BIGINT,
    relationship_code VARCHAR(10),
    billed_amount DECIMAL(10, 2)
);

INSERT INTO claims (first_name, last_name, dob, ssn, gender, billing_code, billing_code_type, claim_number, relationship_code, billed_amount) VALUES
('James', 'Smith', '1980-05-15', 123456789, 'Male', '99213', 'CPT', 100000001, 'Self', 150.00),
('Maria', 'Garcia', '1992-08-22', 234567890, 'Female', 'M54.5', 'ICD-10', 100000002, 'Self', 320.50),
('Robert', 'Johnson', '1975-12-01', 345678901, 'Male', '99214', 'CPT', 100000003, 'Spouse', 210.00),
('Linda', 'Williams', '2015-03-10', 456789012, 'Female', 'J02.9', 'ICD-10', 100000004, 'Child', 85.00),
('Michael', 'Brown', '1968-11-30', 567890123, 'Male', 'E11.9', 'ICD-10', 100000005, 'Self', 450.00),
('Elizabeth', 'Jones', '1988-07-14', 678901234, 'Female', '90658', 'CPT', 100000006, 'Self', 65.00),
('David', 'Miller', '1955-01-25', 789012345, 'Male', 'I10', 'ICD-10', 100000007, 'Self', 125.75),
('Jennifer', 'Davis', '1995-09-05', 890123456, 'Female', '99283', 'CPT', 100000008, 'Spouse', 890.00),
('William', 'Rodriguez', '2018-06-18', 901234567, 'Male', 'Z00.129', 'ICD-10', 100000009, 'Child', 110.00),
('Susan', 'Martinez', '1972-04-12', 112233445, 'Female', '71045', 'CPT', 100000010, 'Self', 195.00),
('Joseph', 'Hernandez', '1983-10-22', 223344556, 'Male', '99213', 'CPT', 100000011, 'Self', 150.00),
('Margaret', 'Lopez', '1960-02-28', 334455667, 'Female', 'M17.11', 'ICD-10', 100000012, 'Spouse', 1200.00),
('Charles', 'Gonzalez', '2010-12-15', 445566778, 'Male', '99393', 'CPT', 100000013, 'Child', 225.00),
('Patricia', 'Wilson', '1990-01-08', 556677889, 'Female', 'O99.28', 'ICD-10', 100000014, 'Self', 540.25),
('Christopher', 'Anderson', '1977-05-20', 667788990, 'Male', '99215', 'CPT', 100000015, 'Self', 315.00),
('Barbara', 'Thomas', '1952-03-14', 778899001, 'Female', 'I25.10', 'ICD-10', 100000016, 'Self', 2500.00),
('Daniel', 'Taylor', '1985-11-11', 889900112, 'Male', '99203', 'CPT', 100000017, 'Spouse', 185.00),
('Nancy', 'Moore', '2020-07-04', 990011223, 'Female', 'Z00.121', 'ICD-10', 100000018, 'Child', 95.00),
('Matthew', 'Jackson', '1998-08-30', 101112131, 'Male', '99214', 'CPT', 100000019, 'Self', 210.00),
('Karen', 'White', '1965-06-25', 121314151, 'Female', 'E66.9', 'ICD-10', 100000020, 'Self', 130.40);


SELECT * FROM claims;

-- Greater than operator
SELECT * FROM claims WHERE billed_amount > 200.0;


-- Less than operator
SELECT * FROM claims WHERE billed_amount < 200.0;

-- Equals Operator
SELECT * FROM claims WHERE relationship_code = 'Self';

-- Not Equals Operator
SELECT * FROM claims WHERE relationship_code != 'Self';

-- Check where the billing amount is more than 500
-- Check where the billing amount is greater than or equal to 400
-- Check where the gender is Male
-- Check where the billing code type is not CPT


SELECT * FROM claims WHERE gender = 'Male';

SELECT * FROM claims WHERE billing_code_type != 'CPT';

-- AND Condition
SELECT * FROM claims WHERE billing_code_type = 'CPT' AND billed_amount > 500;

SELECT * FROM claims WHERE billing_code_type = 'CPT' AND billed_amount > 500 AND gender = 'Male';


-- get the data where 
-- gender is Female and 
-- billed amount is less than or equal to 100 
-- and the relationship code is Self

SELECT * FROM claims
WHERE gender = 'Female'
AND billed_amount <= 100
AND relationship_code = 'Self';

-- get the data where either the gender is Male or the relationship code is Spouse
SELECT * FROM claims WHERE gender = 'Male' OR relationship_code = 'Spouse';

-- get the data where
-- either the billed amount is greater than 100
-- or the billing code type is ICD-10
SELECT * FROM claims
WHERE billed_amount > 100
OR billing_code_type = 'ICD-10';

-- get the data where if gender is Male then relationship code should be Spouse or billed amount is less than 100
SELECT * FROM claims
WHERE (gender = 'Male' AND relationship_code = 'Spouse')
OR billed_amount < 100;


-- get the data where if the billing code type is CPT then the billed amount should be greater than 250 or relationship code is not equals to Self
SELECT * FROM claims
WHERE (billing_code_type = 'CPT' AND billed_amount > 250)
OR relationship_code = 'Self';

-- get the data where the neither the billing code type is CPT nor the billed amount is greater than 200
-- Without using NOT operator
SELECT * FROM claims WHERE billing_code_type != 'CPT'

-- Using NOT operator
SELECT * FROM claims WHERE NOT (billing_code_type = 'CPT');

-- New Table
SELECT * FROM claims_data;

SELECT code FROM claims_data;

-- Only show the unique values
SELECT DISTINCT code FROM claims_data;

-- Only show the unique combination of gender and relationship
SELECT DISTINCT gender, relationship_code FROM claims;

-- Use distinct along with filtering
SELECT DISTINCT gender, relationship_code FROM claims WHERE gender = 'Male';





