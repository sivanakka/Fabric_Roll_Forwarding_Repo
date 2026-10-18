CREATE       VIEW [silver].[misc_bucketAB_src_rpt] AS
WITH Aggregated_BucketAB_src AS (
    -- Aggregate the report-side details (Bucket A)
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
    FROM [silver].[misc_src_bucketAB_detail]
    GROUP BY 
        [accounting_period],
        [lob],
        [jurisdiction]
),
Aggregated_BucketAB_rpt AS (
    -- Aggregate the source-side details (Bucket B)
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
    FROM [silver].[misc_rpt_bucketAB_detail]
    GROUP BY 
        [accounting_period],
        [lob],
        [jurisdiction]
)

SELECT 
    -- 1. Dimensions (Consolidated via COALESCE from both Buckets)
    'misc_bucketAB'                                         AS [report_name],
    COALESCE(a.[accounting_period], b.[accounting_period]) AS [accounting_period],
    COALESCE(a.[lob], b.[lob])                             AS [lob],
    COALESCE(a.[jurisdiction], b.[jurisdiction])           AS [jurisdiction],

    -- 2. Claim Counts (Source vs Report)
    COALESCE(b.[src_total_claims], 0)                      AS [src_total_claims],
    COALESCE(a.[rpt_total_claims], 0)                      AS [rpt_total_claims],

    -- 3. Net Liability (Total Reserve Balance)
    COALESCE(b.[src_net_liab_amt], 0.00)                   AS [src_net_liab_amt],
    COALESCE(a.[rpt_net_liab_amt], 0.00)                   AS [rpt_net_liab_amt],

    -- 4. Component Breakdown Amounts
    COALESCE(b.[src_approved_amt], 0.00)                   AS [src_approved_amt],
    COALESCE(a.[rpt_approved_amt], 0.00)                   AS [rpt_approved_amt],

    COALESCE(b.[src_access_fee], 0.00)                     AS [src_access_fee],
    COALESCE(a.[rpt_access_fee], 0.00)                     AS [rpt_access_fee],

    COALESCE(b.[src_claim_liab_amt], 0.00)                 AS [src_claim_liab_amt],
    COALESCE(a.[rpt_claim_liab_amt], 0.00)                 AS [rpt_claim_liab_amt],

    COALESCE(b.[src_admin_amt], 0.00)                      AS [src_admin_amt],
    COALESCE(a.[rpt_admin_amt], 0.00)                      AS [rpt_admin_amt]

FROM Aggregated_BucketAB_src a
FULL OUTER JOIN Aggregated_BucketAB_rpt  b
    ON  a.[accounting_period] = b.[accounting_period]
    AND a.[lob]               = b.[lob]
    AND a.[jurisdiction]      = b.[jurisdiction];

GO