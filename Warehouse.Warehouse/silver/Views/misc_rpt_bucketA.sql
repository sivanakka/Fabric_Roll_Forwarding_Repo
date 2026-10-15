CREATE   VIEW silver.misc_rpt_bucketA AS

WITH BucketA AS (
    -- Universe of all claims active or reported during the period
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
    FROM [bronze].[opening_claims_rpt]
    
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
    FROM [bronze].[new_added_claims_rpt]
),
ClosedSet AS (
    SELECT DISTINCT [claim_id] FROM [bronze].[closed_claims_rpt]
),
PurgedSet AS (
    SELECT DISTINCT [claim_id] FROM [bronze].[deleted_purged_claims_rpt]
),
GLEndingSet AS (
    SELECT DISTINCT [claim_id] FROM [bronze].[gl_reported_ending_rpt]
)
SELECT 
    'misc_rpt_bucketA'                              AS [report_name],
    a.[accounting_period]                           AS [accounting_period],
    a.[lob]                                         AS [lob],
    a.[jurisdiction]                                AS [jurisdiction],
    COUNT(a.[claim_id])                            AS [total_claims],
    COALESCE(SUM(a.[approved_payment_amt]), 0.00)   AS [total_approved_payment_amt],
    COALESCE(SUM(a.[access_fee]), 0.00)             AS [total_access_fee],
    COALESCE(SUM(a.[claim_liab_amt]), 0.00)         AS [total_claim_liab_amt],
    COALESCE(SUM(a.[admin_amt]), 0.00)              AS [total_admin_amt],
    COALESCE(SUM(a.[net_liab_amt]), 0.00)           AS [total_net_liab_amt]

FROM BucketA a
LEFT JOIN ClosedSet   c ON a.[claim_id] = c.[claim_id]
LEFT JOIN PurgedSet   p ON a.[claim_id] = p.[claim_id]
LEFT JOIN GLEndingSet g ON a.[claim_id] = g.[claim_id]

-- Filters only for claims present in Bucket A but missing from Bucket B
WHERE c.[claim_id] IS NULL 
  AND p.[claim_id] IS NULL 
  AND g.[claim_id] IS NULL

GROUP BY 
    a.[accounting_period],
    a.[lob],
    a.[jurisdiction];

GO