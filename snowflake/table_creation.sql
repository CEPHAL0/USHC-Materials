SHOW TABLES;

CREATE TABLE students (
    name VARCHAR(60),
    class INT,
    roll_no BIGINT,
    dob DATE
);

SHOW TABLES;

INSERT INTO students (name, class, roll_no, dob) VALUES
('Kisha', 4, 1004, '2004-10-10'),
('Layne', 5, 1004, '2005-09-11'),
('Chris', 6, 1004, '2004-08-15'),
('Donald', 6, 1004, '2003-02-28'),
('Jeremy', 6, 1004, '2001-11-30'),
('Nisha', 5, 1004, '2002-09-09'),
('Robert', 5, 1004, '2001-01-15');

SELECT * FROM students;


SELECT * FROM healthcare;

SELECT DISTINCT admission_type FROM healthcare;

SELECT * FROM ELIGIIBILITY;

SELECT DISTINCT plan_type FROM eligiibility;

SELECT * FROM master_diagnosis;

SELECT DISTINCT icd10cm_code FROM master_diagnosis;

SELECT * FROM master_pos;

SELECT * FROM master_procedure;

SELECT DISTINCT proc_type FROM master_procedure;

SELECT proc_type, count(proc_code) FROM master_procedure GROUP BY proc_type ORDER BY count(proc_code) DESC;


