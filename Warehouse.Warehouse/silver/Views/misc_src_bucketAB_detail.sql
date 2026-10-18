CREATE       VIEW silver.misc_src_bucketAB_detail AS

WITH BucketA AS (
    -- Universe of all claims active or reported during the period
    SELECT 
        report_name,
        [claim_id],
        [policy_no],
        [lob],
        [jurisdiction],
        [accounting_period],
        [approved_payment_amt],
        [access_fee],
        [claim_liab_amt],
        [admin_amt],
        [net_liab_amt]
    FROM [bronze].[opening_claims_src]
    
    UNION ALL
    
    SELECT 
        report_name,
        [claim_id],
        [policy_no],
        [lob],
        [jurisdiction],
        [accounting_period],
        [approved_payment_amt],
        [access_fee],
        [claim_liab_amt],
        [admin_amt],
        [net_liab_amt]
    FROM [bronze].[new_added_claims_src]
),
ClosedSet AS (
    SELECT DISTINCT [claim_id] FROM [bronze].[closed_claims_src]
),
PurgedSet AS (
    SELECT DISTINCT [claim_id] FROM [bronze].[deleted_purged_claims_src]
),
GLEndingSet AS (
    SELECT DISTINCT [claim_id] FROM [bronze].[gl_reported_ending_src]
)

SELECT a.* from 

 BucketA a
LEFT JOIN ClosedSet   c ON a.[claim_id] = c.[claim_id]
LEFT JOIN PurgedSet   p ON a.[claim_id] = p.[claim_id]
LEFT JOIN GLEndingSet g ON a.[claim_id] = g.[claim_id]

-- Filters only for claims present in Bucket A but missing from Bucket B
WHERE c.[claim_id] IS NULL 
  AND p.[claim_id] IS NULL 
  AND g.[claim_id] IS NULL

GO