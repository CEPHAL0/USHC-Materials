-- Get all columns for every claim where the city is exactly ‘Chicago’.
SELECT * FROM claims_data WHERE city = 'Chicago';

SELECT * FROM claims_data;

--  Get the first_name, last_name, and amount where the gender is 'Male' and the amount is greater than 500.
SELECT first_name, last_name, amount FROM claims_data WHERE gender = 'Male' AND amount > 500;


--Get the unique (distinct) list of cities where the amount is less than or equal to 50 and the gender is 'Female'
SELECT DISTINCT city FROM claims_data WHERE amount <= 50 AND gender = 'Female';


SELECT * FROM claims_data;

-- Get the maximum spending amount for each gender
SELECT gender, 
    code, 
    MAX(amount) AS maximum_amount,
    AVG(amount) AS average_amount,
    COUNT(*) AS total_count     
FROM claims_data 
GROUP BY gender, code;


SELECT * FROM healthcare;


-- Find the total billing amount grouped by insurance provider.
SELECT insurance_provider,
    SUM(billing_amount) AS total_amount
FROM healthcare
GROUP BY insurance_provider;

-- Calculate the average age of patients for each medical condition.
SELECT medical_condition,
    AVG(age) as average_age
FROM healthcare
GROUP BY medical_condition;

-- Grouping with Filtering
SELECT test_results,
    COUNT(*) AS total_count
FROM healthcare
WHERE gender = 'Male'
GROUP BY test_results;

-- Single Ordering
SELECT * FROM healthcare
WHERE gender = 'Male'
ORDER BY blood_type;

-- Multiple ordering with mixed order
SELECT * FROM healthcare
WHERE gender = 'Male'
ORDER BY blood_type ASC, billing_amount DESC;

-- Find all insurance companies where total billing amount exceeds 500000
SELECT insurance_provider,
    SUM(billing_amount) AS total_amount
FROM healthcare
GROUP BY insurance_provider
HAVING SUM(billing_amount) > 500000;

-- Find all hospitals where the average billing amount is greater than $30,000.

SELECT * FROM 