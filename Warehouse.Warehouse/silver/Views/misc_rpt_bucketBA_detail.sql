CREATE       VIEW silver.misc_rpt_bucketBA_detail AS

WITH BucketB AS (
    -- Universe of all resolved, derecognized, or ending GL ledger claims
    SELECT 
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
    FROM [bronze].[closed_claims_rpt]
    
    UNION ALL
    
    SELECT 
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
    FROM [bronze].[deleted_purged_claims_rpt]
    
    UNION ALL
    
    SELECT 
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
    FROM [bronze].[gl_reported_ending_rpt]
),
OpeningSet AS (
    SELECT DISTINCT [claim_id] FROM [bronze].[opening_claims_rpt]
),
NewAddedSet AS (
    SELECT DISTINCT [claim_id] FROM [bronze].[new_added_claims_rpt]
)
SELECT 
b.*
FROM BucketB b
LEFT JOIN OpeningSet  o ON b.[claim_id] = o.[claim_id]
LEFT JOIN NewAddedSet n ON b.[claim_id] = n.[claim_id]

-- Filters exclusively for records in Bucket B that have NO parent in Bucket A:
WHERE o.[claim_id] IS NULL 
  AND n.[claim_id] IS NULL

GO