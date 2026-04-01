-- CTE -  Common Text Expressions
-- Coding -> Variables, SQL -> CTE
-- CTE is a temporary table that holds the data and specific columns and can be used in another ctes
-- CTE Syntax:
-- WITH
-- Find the number of billing_codes in master_procedure
SELECT * FROM master_procedure;

-- Not memory efficient
SELECT medical_claims.payer_name, 
    medical_claims.member_id,
    medical_claims.primary_care_provider_npi,
    master_procedure.proc_code,
    master_procedure.proc_desc
FROM medical_claims
LEFT JOIN master_procedure
ON medical_claims.proc_code = master_procedure.proc_code;

-- CTE approach
WITH medical_claims_cte AS (
    SELECT payer_name,
        member_id,
        primary_care_provider_npi,
        proc_code
    FROM medical_claims
),
proc_code_desc AS (
    SELECT DISTINCT proc_code, proc_desc FROM master_procedure
),
joined_table AS (
    SELECT medical_claims_cte.*,
        proc_code_desc.proc_desc
    FROM medical_claims_cte
    LEFT JOIN proc_code_desc
    ON medical_claims_cte.proc_code = proc_code_desc.proc_code
)
SELECT * FROM joined_table;


-- SELECT ONLY the distinct member_id from medical_claims
SELECT DISTINCT member_id FROM medical_claims;

-- CTE approach
WITH distinct_member_ids AS (
    SELECT DISTINCT member_id FROM medical_claims
)
SELECT * FROM distinct_member_ids;

-- LIMIT: Only show the top N output
SELECT proc_code, 
    COUNT(*) AS records_count
FROM medical_claims
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

SELECT * FROM medical_claims;

-- SELECT TOP 5 most average expensive proc_code
SELECT medical_claims.proc_code,
    master_procedure.proc_desc,
    AVG(medical_claims.billed_amount) as average_billed_amount
FROM medical_claims
LEFT JOIN master_procedure
ON medical_claims.proc_code = master_procedure.proc_code
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 5;




WITH top_5_medical_claims AS (
    SELECT proc_code,
        AVG(billed_amount) AS average_billed_amount
    FROM medical_claims
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 5
),
joined_table AS (
    SELECT top_5_medical_claims.*,
        master_procedure.proc_desc
    FROM top_5_medical_claims
    LEFT JOIN master_procedure
    ON top_5_medical_claims.proc_code = master_procedure.proc_code
)
SELECT * FROM joined_table;


SELECT * FROM master_procedure;


-- String aggregation or group by
SELECT proc_type,
    ARRAY_AGG(proc_code) AS distinct_proc_codes,
    COUNT(proc_code) AS proc_code_counts
FROM master_procedure
GROUP BY 1;

-- Concat: Join two strings with a character in middle
SELECT * FROM medical_claims;

SELECT member_id, claim_id, line_id FROM medical_claims;

-- Concatenation of claim_id and line_id
SELECT member_id, 
    CONCAT(claim_id, '-', line_id) AS claim_line_sequence 
FROM medical_claims;

-- Concatenation
SELECT CONCAT(first_name, ' ', middle_name, ' ', last_name) AS name 
FROM table;

/*
   21. Identify Chronic Conditions: 
        Find all diagnosis descriptions in master_diagnosis where the chronic_indicator is equal to '1'.
   22. Chronic Claim Search: 
        Join sample_medical_claims with master_diagnosis to list the claim_id and member_id for any claim where the primary diagnosis           (diag_code_01) is a chronic condition.
   23. Lab Results Cost: 
        Find all claims in sample_medical_claims where the proc_code corresponds to a 'Laboratory' procedure (you’ll need to join with          master_procedure and filter by dh_category).
   24. Telehealth Utilization: 
        Join sample_medical_claims with master_pos to find the total amount paid (paid_amount) for all claims that took place via               'Telehealth'.
*/


/*
This is
a multiline
comment
*/

-- 21
SELECT DISTINCT icd10cm_code_description FROM master_diagnosis WHERE chronic_indicator = 1; 

SELECT * FROM medical_claims;

-- 22 
WITH chronic_descriptions AS (
    SELECT DISTINCT icd10cm_code AS icd_10_code,
        icd10cm_code_description AS icd_10_description
    FROM master_diagnosis 
    WHERE chronic_indicator = 1
),
joined_table AS (
    SELECT DISTINCT m.claim_id,
        m.member_id,
        c.icd_10_code,
        c.icd_10_description
    FROM medical_claims AS m
    LEFT JOIN chronic_descriptions AS c
    ON m.diag_code_01 = c.icd_10_code
)
SELECT * FROM joined_table;

SELECT * FROM master_procedure;

-- Select all data from medical_claims where the procedure code category is Inpatient Stay
WITH cte1 as (
    SELECT DISTINCT proc_code, 
        proc_type,
        dh_category
    FROM master_procedure
    WHERE dh_category = 'Inpatient Stay'
),
cte2 AS (
    SELECT m.* 
    FROM medical_claims AS m
    LEFT JOIN cte1 AS c
    ON m.proc_code = c.proc_code
)
SELECT * FROM cte2;

SELECT * FROM master_pos;

WITH telehealth_place_of_service AS (
    SELECT pos_code FROM master_pos WHERE pos_name = 'Pharmacy'
),
joined_table AS (
    SELECT m.*
    FROM medical_claims AS m
    LEFT JOIN master_pos AS mp
    ON m.pos_code = mp.pos_code
)
SELECT * FROM joined_table;

-- LIKE
-- Anything after Typhoid
SELECT * FROM master_diagnosis WHERE icd10cm_code_description LIKE 'Typhoid%';

-- Anything before pneumonia
SELECT * FROM master_diagnosis WHERE icd10cm_code_description LIKE '%pneumonia';

-- Anything before or after cough
SELECT * FROM master_diagnosis WHERE icd10cm_code_description LIKE '%cough%';

SELECT * FROM master_diagnosis WHERE icd10cm_code_description LIKE '%Cholera%';