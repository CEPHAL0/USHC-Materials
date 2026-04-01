-- Check the data in the database table
SELECT * FROM eligiibility;


-- Check the distinct values in Payer ID
SELECT DISTINCT payer_id FROM eligiibility;

-- Check the counts of the data for each payer id
SELECT payer_id, COUNT(*) AS total_counts FROM eligiibility GROUP BY payer_id;

-- Check the combination of the data for payer name and payer id
SELECT DISTINCT payer_name, payer_id FROM eligiibility;

-- Check the number of distinct members for each payer_name
SELECT payer_name, 
    COUNT(DISTINCT subscriber_id) 
FROM eligiibility 
GROUP BY 1 
ORDER BY 2 DESC;
-- CMS has the most number of insurance holders in the dataset and United Health Commercial has the least


-- Check the distribution of gender in the dataset


-- Check the distinct types of member relationship and try to find out a pattern which shows which type of member relationship is the most claimed

-- Check the distribution of the members for each plan type

-- Check the members whose eligibility end date is still not complete
SELECT * FROM eligiibility WHERE elig_end_date IS NULL;

-- Check the members whose eligibility end date is more than 12 months from start date
SELECT elig_start_date,
    elig_end_date,
    -- calculated column
    elig_end_date - elig_start_date AS difference
FROM eligiibility;


-- Count the number of people who have subscribed to different plans
SELECT plan_type, COUNT(DISTINCT member_id) FROM eligiibility GROUP BY 1 ORDER BY 2 DESC;


-- Analysis of master diagnosis
SELECT * FROM master_diagnosis;

-- Check the distinct values in chronic indicator
SELECT DISTINCT chronic_indicator FROM master_diagnosis;

SELECT chronic_indicator, COUNT(*) FROM master_diagnosis GROUP BY 1 ORDER BY 2 DESC;

SELECT ccsr_category_1, COUNT(DISTINCT icd10cm_code) AS distinct_billing_codes FROM master_diagnosis GROUP BY 1 ORDER BY 2 DESC;


SELECT * FROM medical_claims;

SELECT COUNT(*)  FROM medical_claims;

SELECT * FROM master_pos;

-- Joining Concept
-- Joining two tables based on the common column

SELECT medical_claims.payer_name,
    medical_claims.member_id,
    medical_claims.primary_care_provider_npi,
    medical_claims.claim_id,
    medical_claims.diag_code_01,
    medical_claims.diag_code_02,
    medical_claims.pos_code,
    master_pos.pos_name,
    master_pos.pos_description
FROM medical_claims
LEFT JOIN master_pos
ON medical_claims.pos_code = master_pos.pos_code;

SELECT * FROM master_procedure;

-- MEDICAL CLAIMS and MASTER_PROCEDURE join on the basis of MEDICAL_CLAIMS.ICD_PROC_CODE_1 and MASTER_PROCEDURE.PROC_CODE and retrieve the following extra columns: proc_desc, proc_short_desc, proc_type
SELECT medical_claims.payer_name,
    medical_claims.member_id,
    medical_claims.claim_status,
    medical_claims.proc_code,
    master_procedure.proc_type,
    master_procedure.proc_desc,
    master_procedure.proc_long_desc
FROM medical_claims
OUTER JOIN master_procedure
ON medical_claims.proc_code = master_procedure.proc_code;

-- Left join - Get all the data from the left table but only those from the right table whose data is matched
-- Right join - Get all the data from the right table but only those from the left table whose data is matched
-- Inner join - Get only those data from both table where both of the data is matched
-- Outer join - Get all the data and join those which gets matched otherwise keep them as null

-- Join Condition (One or Multiple columns must match with each others tables)

SELECT * FROM eligiibility;

select * from medical_claims;

-- Eligibility table and medical claims table are to be joined and then provide extra columns from eligibility

-- payer_id, payer_name, member_id, member_gender, member_dob, member_relationship, member_zip, pcp_npi, claim_id, service_from_date, service_thru_date, claim_status, diag_code_01, proc_code, pos_code, network_name, billed_amount