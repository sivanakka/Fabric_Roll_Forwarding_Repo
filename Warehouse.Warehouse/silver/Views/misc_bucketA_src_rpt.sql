CREATE     VIEW [silver].[misc_bucketA_src_rpt]
AS
SELECT 
    -- 1. Dimensions (Consolidated via COALESCE)
    'misc_bucketA'                                         AS [report_name],
    COALESCE(r.[accounting_period], s.[accounting_period]) AS [accounting_period],
    COALESCE(r.[lob], s.[lob])                             AS [lob],
    COALESCE(r.[jurisdiction], s.[jurisdiction])           AS [jurisdiction],

    -- 2. Claim Counts (Source vs Report)
    COALESCE(s.[total_claims], 0)                          AS [src_total_claims],
    COALESCE(r.[total_claims], 0)                          AS [rpt_total_claims],

    -- 3. Net Liability (Total Reserve Balance)
    COALESCE(s.[total_net_liab_amt], 0.00)                 AS [src_net_liab_amt],
    COALESCE(r.[total_net_liab_amt], 0.00)                 AS [rpt_net_liab_amt],

    -- 4. Component Breakdown Amounts
    COALESCE(s.[total_approved_payment_amt], 0.00)         AS [src_approved_amt],
    COALESCE(r.[total_approved_payment_amt], 0.00)         AS [rpt_approved_amt],

    COALESCE(s.[total_access_fee], 0.00)                   AS [src_access_fee],
    COALESCE(r.[total_access_fee], 0.00)                   AS [rpt_access_fee],

    COALESCE(s.[total_claim_liab_amt], 0.00)               AS [src_claim_liab_amt],
    COALESCE(r.[total_claim_liab_amt], 0.00)               AS [rpt_claim_liab_amt],

    COALESCE(s.[total_admin_amt], 0.00)                    AS [src_admin_amt],
    COALESCE(r.[total_admin_amt], 0.00)                    AS [rpt_admin_amt]

  

FROM [silver].[misc_rpt_bucketA] r
JOIN [silver].[misc_src_bucketA] s

    ON r.[accounting_period] = s.[accounting_period]
    AND r.report_name=s.report_name
   AND r.[lob]               = s.[lob]
   AND r.[jurisdiction]      = s.[jurisdiction]
UNION

SELECT * FROM
[silver].[master_src_rpt]

GO