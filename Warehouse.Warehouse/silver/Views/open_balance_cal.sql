-- 1. Original master_src_rpt rows (IH5P, IH2, IH7, IH3, IH5C, misc buckets)
CREATE          view silver.open_balance_cal AS
SELECT 
    [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],
    [src_total_claims],
    [rpt_total_claims],
    [src_net_liab_amt],
    [rpt_net_liab_amt],
    [src_approved_amt],
    [rpt_approved_amt],
    [src_access_fee],
    [rpt_access_fee],
    [src_claim_liab_amt],
    [rpt_claim_liab_amt],
    [src_admin_amt],
    [rpt_admin_amt]
FROM [silver].[master_src_rpt]
UNION ALL 
SELECT * FROM 
[silver].[misc_bucketAB_src_rpt]
UNION ALL 
SELECT * FROM 
[silver].[misc_bucketBA_src_rpt]
UNION ALL
SELECT 
  
    'open_balance_cal'                                 AS [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],
    
    -- Total Claims (src & rpt)
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([src_total_claims], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([src_total_claims], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([src_total_claims], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([src_total_claims], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([src_total_claims], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([src_total_claims], 0) ELSE 0 END)
    ) AS [src_total_claims],
    
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([rpt_total_claims], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([rpt_total_claims], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([rpt_total_claims], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([rpt_total_claims], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([rpt_total_claims], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([rpt_total_claims], 0) ELSE 0 END)
    ) AS [rpt_total_claims],
    -- Net Liability Amounts (src & rpt)
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([src_net_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([src_net_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([src_net_liab_amt], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([src_net_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([src_net_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([src_net_liab_amt], 0) ELSE 0 END)
    ) AS [src_net_liab_amt],
    
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([rpt_net_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([rpt_net_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([rpt_net_liab_amt], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([rpt_net_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([rpt_net_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([rpt_net_liab_amt], 0) ELSE 0 END)
    ) AS [rpt_net_liab_amt],
    -- Approved Indemnity Amounts
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([src_approved_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([src_approved_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([src_approved_amt], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([src_approved_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([src_approved_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([src_approved_amt], 0) ELSE 0 END)
    ) AS [src_approved_amt],
    
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([rpt_approved_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([rpt_approved_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([rpt_approved_amt], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([rpt_approved_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([rpt_approved_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([rpt_approved_amt], 0) ELSE 0 END)
    ) AS [rpt_approved_amt],
    -- Access Fee / Deductibles
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([src_access_fee], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([src_access_fee], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([src_access_fee], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([src_access_fee], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([src_access_fee], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([src_access_fee], 0) ELSE 0 END)
    ) AS [src_access_fee],
    
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([rpt_access_fee], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([rpt_access_fee], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([rpt_access_fee], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([rpt_access_fee], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([rpt_access_fee], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([rpt_access_fee], 0) ELSE 0 END)
    ) AS [rpt_access_fee],
    -- Claim Loss Liability
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([src_claim_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([src_claim_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([src_claim_liab_amt], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([src_claim_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([src_claim_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([src_claim_liab_amt], 0) ELSE 0 END)
    ) AS [src_claim_liab_amt],
    
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([rpt_claim_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([rpt_claim_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([rpt_claim_liab_amt], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([rpt_claim_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([rpt_claim_liab_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([rpt_claim_liab_amt], 0) ELSE 0 END)
    ) AS [rpt_claim_liab_amt],
    -- Administrative Expenses (ALAE)
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([src_admin_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([src_admin_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([src_admin_amt], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([src_admin_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([src_admin_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([src_admin_amt], 0) ELSE 0 END)
    ) AS [src_admin_amt],
    
    (
        SUM(CASE WHEN [report_name] = 'IH5P'                 THEN ISNULL([rpt_admin_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH2'                  THEN ISNULL([rpt_admin_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketBA_src_rpt' THEN ISNULL([rpt_admin_amt], 0) ELSE 0 END)
    ) - (
        SUM(CASE WHEN [report_name] = 'IH7'                  THEN ISNULL([rpt_admin_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'IH3'                  THEN ISNULL([rpt_admin_amt], 0) ELSE 0 END) +
        SUM(CASE WHEN [report_name] = 'misc_bucketAB_src_rpt' THEN ISNULL([rpt_admin_amt], 0) ELSE 0 END)
    ) AS [rpt_admin_amt]
FROM [silver].[master_src_rpt]
WHERE [report_name] IN ('IH5P', 'IH2', 'misc_bucketBA_src_rpt', 'IH7', 'IH3', 'misc_bucketAB_src_rpt')
GROUP BY [accounting_period], [lob], [jurisdiction]

GO