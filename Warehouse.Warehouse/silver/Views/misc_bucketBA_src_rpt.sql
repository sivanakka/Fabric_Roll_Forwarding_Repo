CREATE     VIEW [silver].[misc_bucketBA_src_rpt] AS
WITH Aggregated_BucketBA_src AS (
    -- SOURCE metrics aggregated here from Bucket B details
    SELECT 
        [accounting_period],
        [lob],
        [jurisdiction],
        COUNT(DISTINCT [claim_id])    AS [src_total_claims],
        SUM([net_liab_amt])           AS [src_net_liab_amt],
        SUM([approved_payment_amt])   AS [src_approved_amt],
        SUM([access_fee])             AS [src_access_fee],
        SUM([claim_liab_amt])         AS [src_claim_liab_amt],
        SUM([admin_amt])              AS [src_admin_amt]
    FROM [silver].[misc_src_bucketBA_detail]
    GROUP BY 
        [accounting_period],
        [lob],
        [jurisdiction]
),
Aggregated_BucketBA_rpt AS (
    -- REPORT metrics aggregated here from Bucket B details
    SELECT 
        [accounting_period],
        [lob],
        [jurisdiction],
        COUNT(DISTINCT [claim_id])    AS [rpt_total_claims],
        SUM([net_liab_amt])           AS [rpt_net_liab_amt],
        SUM([approved_payment_amt])   AS [rpt_approved_amt],
        SUM([access_fee])             AS [rpt_access_fee],
        SUM([claim_liab_amt])         AS [rpt_claim_liab_amt],
        SUM([admin_amt])              AS [rpt_admin_amt]
    FROM [silver].[misc_rpt_bucketBA_detail]
    GROUP BY 
        [accounting_period],
        [lob],
        [jurisdiction]
)

SELECT 
    -- 1. Dimensions (Consolidated via COALESCE from both Buckets)
    'misc_bucketBA'                                           AS [report_name],
    COALESCE(src.[accounting_period], rpt.[accounting_period]) AS [accounting_period],
    COALESCE(src.[lob], rpt.[lob])                             AS [lob],
    COALESCE(src.[jurisdiction], rpt.[jurisdiction])           AS [jurisdiction],

    -- 2. Claim Counts (Source vs Report)
    COALESCE(src.[src_total_claims], 0)                        AS [src_total_claims],
    COALESCE(rpt.[rpt_total_claims], 0)                        AS [rpt_total_claims],

    -- 3. Net Liability (Total Reserve Balance)
    COALESCE(src.[src_net_liab_amt], 0.00)                     AS [src_net_liab_amt],
    COALESCE(rpt.[rpt_net_liab_amt], 0.00)                     AS [rpt_net_liab_amt],

    -- 4. Component Breakdown Amounts
    COALESCE(src.[src_approved_amt], 0.00)                     AS [src_approved_amt],
    COALESCE(rpt.[rpt_approved_amt], 0.00)                     AS [rpt_approved_amt],

    COALESCE(src.[src_access_fee], 0.00)                       AS [src_access_fee],
    COALESCE(rpt.[rpt_access_fee], 0.00)                       AS [rpt_access_fee],

    COALESCE(src.[src_claim_liab_amt], 0.00)                   AS [src_claim_liab_amt],
    COALESCE(rpt.[rpt_claim_liab_amt], 0.00)                   AS [rpt_claim_liab_amt],

    COALESCE(src.[src_admin_amt], 0.00)                        AS [src_admin_amt],
    COALESCE(rpt.[rpt_admin_amt], 0.00)                        AS [rpt_admin_amt]

FROM Aggregated_BucketBA_src src
FULL OUTER JOIN Aggregated_BucketBA_rpt rpt
    ON  src.[accounting_period] = rpt.[accounting_period]
    AND src.[lob]               = rpt.[lob]
    AND src.[jurisdiction]      = rpt.[jurisdiction];

GO