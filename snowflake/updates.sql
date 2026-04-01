SELECT * FROM medical_claims;

-- Update and Delete statements
-- Update: Existing data is changed
-- Syntax: UPDATE <table_name> SET <column> <value> WHERE <filter>


UPDATE medical_claims SET diag_code_08 = '' WHERE diag_code_08 = 'Unknown';

SELECT * FROM medical_claims;

SELECT * FROM medical_claims WHERE diag_code_08 = '';

UPDATE medical_claims SET ms_drg_code = 'Unknown' WHERE ms_drg_code = 'Unk';


-- Set the value of proc_modifier_code to '' where ms_drg_code is Unkown
UPDATE medical_claims 
SET proc_modifier_code = '' 
WHERE ms_drg_code = 'Unknown' AND proc_modifier_code = 'N/A';


-- Update the rev code to Unknown where it is UNKN
-- Update the diag_code_01 to '' where rev_code is Unknown and diag_code_01 is also Unknown

UPDATE medical_claims
SET rev_code = 'Unknown'
WHERE rev_code = 'UNKN';

UPDATE medical_claims
SET diag_code_01 = ''
WHERE rev_code = 'Unknown' AND diag_code_01 = 'Unknown';

-- Delete query (Warning: Always use with a filtering)
SELECT * FROM medical_claims;

SELECT claim_status, COUNT(*) FROM medical_claims GROUP BY 1;

-- Delete query
DELETE FROM medical_claims
WHERE claim_status = 'ENCOUNTER';

-- How to add a column in table
SELECT * FROM eligiibility;

-- Add age using CTE
WITH cte1 AS ( 
    SELECT DISTINCT member_id, 
        member_dob, 
        EXTRACT(YEAR FROM member_dob) AS dob_year,
        DATEDIFF(YEAR, member_dob, CURRENT_DATE()) AS age,
        EXTRACT(MONTH FROM member_dob) AS dob_month
    FROM eligiibility
),
cte2 AS (
    SELECT a.*,
        b.dob_year,
        b.age
    FROM medical_claims AS a
    LEFT JOIN cte1 AS b
    ON a.member_id = b.member_id
)
SELECT * FROM cte2 WHERE age > 100 OR age <= 0;

-- Extract the data of 2022 february
SELECT * FROM medical_claims WHERE service_from_date >= '2022-02-01' AND service_thru_date <= '2022-02-28';

-- Find the average age of females whose claim status is paid for the month of march of 2022
WITH cte1 AS ( 
    SELECT DISTINCT member_id, 
        member_gender,
        DATEDIFF(YEAR, member_dob, CURRENT_DATE()) AS age,
    FROM eligiibility
),
cte2 AS (
    SELECT a.*,
        b.member_gender,
        b.age
    FROM medical_claims AS a
    LEFT JOIN cte1 AS b
    ON a.member_id = b.member_id
),
cte3 AS (
    SELECT * FROM cte2
    WHERE member_gender = 'F'
    AND claim_status = 'PAID'
    AND service_from_date >= '2022-02-01'
    AND service_thru_date <= '2022-02-28'
)
SELECT AVG(age),
    MIN(age),
    MAX(age)
FROM cte3
WHERE age < 100;

-- Find the count of males and females for the data of 2022 December where the billed amount is greater than 100$