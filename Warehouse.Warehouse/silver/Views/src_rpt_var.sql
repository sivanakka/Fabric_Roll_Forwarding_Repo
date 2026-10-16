CREATE   VIEW silver.src_rpt_var as

SELECT 
    [report_name], 
    [accounting_period], 
    [lob], 
    [jurisdiction], 
    
    -- Claims Comparison & Variance
    [src_total_claims], 
    [rpt_total_claims], 
    ISNULL([rpt_total_claims], 0) - ISNULL([src_total_claims], 0) AS [variance_total_claims], 
    
    -- Net Liability Comparison & Variance
    [src_net_liab_amt], 
    [rpt_net_liab_amt],
    ISNULL([rpt_net_liab_amt], 0) - ISNULL([src_net_liab_amt], 0) AS [variance_net_liab_amt],

    -- Approved Amount Comparison & Variance
    [src_approved_amt], 
    [rpt_approved_amt],
    ISNULL([rpt_approved_amt], 0) - ISNULL([src_approved_amt], 0) AS [variance_approved_amt],

    -- Access Fee Comparison & Variance
    [src_access_fee], 
    [rpt_access_fee],
    ISNULL([rpt_access_fee], 0) - ISNULL([src_access_fee], 0) AS [variance_access_fee],

    -- Claim Liability Comparison & Variance
    [src_claim_liab_amt], 
    [rpt_claim_liab_amt],
    ISNULL([rpt_claim_liab_amt], 0) - ISNULL([src_claim_liab_amt], 0) AS [variance_claim_liab_amt],

    -- Admin Amount Comparison & Variance
    [src_admin_amt], 
    [rpt_admin_amt],
    ISNULL([rpt_admin_amt], 0) - ISNULL([src_admin_amt], 0) AS [variance_admin_amt]

FROM (
    SELECT * FROM [silver].[open_balance_cal]
    UNION ALL 
    SELECT * FROM [silver].[roll_forwrad_variance]
) AS [combined_data];

GO