-- 1. Original master_src_rpt rows (IH5P, IH2, IH7, IH3, IH5C, misc buckets)

CREATE    view silver.open_balance_cal
AS
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

-- 2. Calculated Open Ending Balance Row (open_balance_cal)
SELECT 
    'open_balance_cal'                                          AS [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],

    -- Total Claims Count: (IH5P + IH2 + MiscB) - (IH7 + IH3 + MiscA)
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [src_total_claims] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[src_total_claims] 
             ELSE 0 END)                                        AS [src_total_claims],
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [rpt_total_claims] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[rpt_total_claims] 
             ELSE 0 END)                                        AS [rpt_total_claims],

    -- Net Liability Amount (Total Reserve): (IH5P + IH2 + MiscB) - (IH7 + IH3 + MiscA)
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [src_net_liab_amt] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[src_net_liab_amt] 
             ELSE 0.00 END)                                     AS [src_net_liab_amt],
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [rpt_net_liab_amt] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[rpt_net_liab_amt] 
             ELSE 0.00 END)                                     AS [rpt_net_liab_amt],

    -- Approved Payment Amount
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [src_approved_amt] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[src_approved_amt] 
             ELSE 0.00 END)                                     AS [src_approved_amt],
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [rpt_approved_amt] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[rpt_approved_amt] 
             ELSE 0.00 END)                                     AS [rpt_approved_amt],

    -- Access Fee (Deductible / Co-pay)
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [src_access_fee] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[src_access_fee] 
             ELSE 0.00 END)                                     AS [src_access_fee],
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [rpt_access_fee] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[rpt_access_fee] 
             ELSE 0.00 END)                                     AS [rpt_access_fee],

    -- Total Claim Liability Amount
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [src_claim_liab_amt] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[src_claim_liab_amt] 
             ELSE 0.00 END)                                     AS [src_claim_liab_amt],
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [rpt_claim_liab_amt] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[rpt_claim_liab_amt] 
             ELSE 0.00 END)                                     AS [rpt_claim_liab_amt],

    -- Admin Amount (ALAE / Legal Expenses)
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [src_admin_amt] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[src_admin_amt] 
             ELSE 0.00 END)                                     AS [src_admin_amt],
    SUM(CASE WHEN [report_name] IN ('IH5P', 'IH2', 'misc_bucketB_src_rpt', 'misc_src_bucketB', 'misc_rpt_bucketB') THEN [rpt_admin_amt] 
             WHEN [report_name] IN ('IH7',  'IH3', 'misc_bucketA_src_rpt', 'misc_src_bucketA', 'misc_rpt_bucketA') THEN -[rpt_admin_amt] 
             ELSE 0.00 END)                                     AS [rpt_admin_amt]

FROM [silver].[master_src_rpt]
GROUP BY 
    [accounting_period], 
    [lob], 
    [jurisdiction]

GO