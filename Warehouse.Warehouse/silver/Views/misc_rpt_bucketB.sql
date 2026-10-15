CREATE   VIEW silver.misc_rpt_bucketB AS

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
    'misc_rpt_bucketB'                              AS [report_name],
    b.[accounting_period]                           AS [accounting_period],
    b.[lob]                                         AS [lob],
    b.[jurisdiction]                                AS [jurisdiction],
    COUNT(b.[claim_id])                            AS [total_claims],
    COALESCE(SUM(b.[approved_payment_amt]), 0.00)   AS [total_approved_payment_amt],
    COALESCE(SUM(b.[access_fee]), 0.00)             AS [total_access_fee],
    COALESCE(SUM(b.[claim_liab_amt]), 0.00)         AS [total_claim_liab_amt],
    COALESCE(SUM(b.[admin_amt]), 0.00)              AS [total_admin_amt],
    COALESCE(SUM(b.[net_liab_amt]), 0.00)           AS [total_net_liab_amt]

FROM BucketB b
LEFT JOIN OpeningSet  o ON b.[claim_id] = o.[claim_id]
LEFT JOIN NewAddedSet n ON b.[claim_id] = n.[claim_id]

-- Filters exclusively for records in Bucket B that have NO parent in Bucket A:
WHERE o.[claim_id] IS NULL 
  AND n.[claim_id] IS NULL

GROUP BY 
    b.[accounting_period],
    b.[lob],
    b.[jurisdiction];

GO