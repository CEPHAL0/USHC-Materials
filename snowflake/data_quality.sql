select * from master_procedure limit 100

-- proc code fields are correctly populated
select * from master_procedure where proc_code is null;

-- the proc type follows proper conventions
select distinct proc_type from master_procedure;

-- multiple records hence the data might be risky
select count(*) from master_procedure where category_one = '' and category_one = '';

select * from eligiibility limit 100;

-- Check the validity of payer_name by checking null or '' value
-- Check the subscriber id if it is null
-- Check the consistency of member_gender (how is it represented)
-- Check the data that has empty primary_care_provider_npi

SELECT member_gender,
    COUNT(*)
FROM eligiibility
GROUP BY 1;

select * from rx_claims;

--payer_name is valid
select * from medical_claims where payer_name = '' or payer_name is null;

⁠SELECT *
FROM eligiibility
WHERE subscriber_id IS null;

-- no issues in subscriber id
select * from eligiibility where subscriber_id is null;


select ndc_code, length(ndc_code) from rx_claims where length(ndc_code) != 11;

select count(*) from rx_claims where ndc_code is null or ndc_code = '';

select * from rx_claims;

-- count the number of digits in line_id in rx_claims
-- claim status consistency
-- dosage form consistency
-- billed_amount 0, < 0

SELECT DISTINCT claim_status FROM rx_claims;

SELECT *
FROM rx_claims
WHERE billed_amount < 0.00;