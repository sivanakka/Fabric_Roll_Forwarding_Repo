CREATE   VIEW MISC_SRC_DETAIL_BUCKET_A AS

WITH BucketA AS (
    -- Universe of all claims active or reported during the period
    SELECT 
        [claim_id],
        [policy_no],
        [lob],
        [jurisdiction],
        [accounting_period],
        [transaction_date],
        [net_liab_amt],
        'OPENING' AS [origin_bucket]
    FROM [bronze].[opening_claims_rpt]
    
    UNION ALL
    
    SELECT 
        [claim_id],
        [policy_no],
        [lob],
        [jurisdiction],
        [accounting_period],
        [transaction_date],
        [net_liab_amt],
        'NEW_ADDED' AS [origin_bucket]
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
    a.[claim_id],
    a.[policy_no],
    a.[lob],
    a.[jurisdiction],
    a.[accounting_period],
    a.[origin_bucket],                       -- OPENING or NEW_ADDED
    a.[net_liab_amt],
    

    -- Diagnosis: Identifies the exact disposition bucket or flags a missing leak
    CASE 
        WHEN c.[claim_id] IS NOT NULL THEN 'ACCOUNTED_IN_CLOSED'
        WHEN p.[claim_id] IS NOT NULL THEN 'ACCOUNTED_IN_PURGED'
        WHEN g.[claim_id] IS NOT NULL THEN 'ACCOUNTED_IN_GL_ENDING'
        ELSE 'MISSING_FROM_ALL_BUCKET_B'
    END AS [reconciliation_diagnosis]

FROM BucketA a
LEFT JOIN ClosedSet   c ON a.[claim_id] = c.[claim_id]
LEFT JOIN PurgedSet   p ON a.[claim_id] = p.[claim_id]
LEFT JOIN GLEndingSet g ON a.[claim_id] = g.[claim_id]

-- To filter only for claims missing from Bucket B:
WHERE c.[claim_id] IS NULL AND p.[claim_id] IS NULL AND g.[claim_id] IS NULL

GO