CREATE   view silver.roll_forwrad_variance AS

SELECT 
    'roll_forwrad_variance'                                                          AS [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],

    -- 1. Claims Count: SUM(IH5C) - SUM(open_balance_cal)
    SUM(CASE WHEN [report_name] = 'IH5C' THEN [src_total_claims] ELSE 0 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [src_total_claims] ELSE 0 END) AS [src_total_claims],

    SUM(CASE WHEN [report_name] = 'IH5C' THEN [rpt_total_claims] ELSE 0 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [rpt_total_claims] ELSE 0 END) AS [rpt_total_claims],

    -- 2. Net Liability (Total Reserve): SUM(IH5C) - SUM(open_balance_cal)
    SUM(CASE WHEN [report_name] = 'IH5C' THEN [src_net_liab_amt] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [src_net_liab_amt] ELSE 0.00 END) AS [src_net_liab_amt],

    SUM(CASE WHEN [report_name] = 'IH5C' THEN [rpt_net_liab_amt] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [rpt_net_liab_amt] ELSE 0.00 END) AS [rpt_net_liab_amt],

    -- 3. Approved Payment Amount
    SUM(CASE WHEN [report_name] = 'IH5C' THEN [src_approved_amt] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [src_approved_amt] ELSE 0.00 END) AS [src_approved_amt],

    SUM(CASE WHEN [report_name] = 'IH5C' THEN [rpt_approved_amt] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [rpt_approved_amt] ELSE 0.00 END) AS [rpt_approved_amt],

    -- 4. Access Fee (Deductible / Co-pay)
    SUM(CASE WHEN [report_name] = 'IH5C' THEN [src_access_fee] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [src_access_fee] ELSE 0.00 END) AS [src_access_fee],

    SUM(CASE WHEN [report_name] = 'IH5C' THEN [rpt_access_fee] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [rpt_access_fee] ELSE 0.00 END) AS [rpt_access_fee],

    -- 5. Claim Liability Amount
    SUM(CASE WHEN [report_name] = 'IH5C' THEN [src_claim_liab_amt] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [src_claim_liab_amt] ELSE 0.00 END) AS [src_claim_liab_amt],

    SUM(CASE WHEN [report_name] = 'IH5C' THEN [rpt_claim_liab_amt] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [rpt_claim_liab_amt] ELSE 0.00 END) AS [rpt_claim_liab_amt],

    -- 6. Admin Amount
    SUM(CASE WHEN [report_name] = 'IH5C' THEN [src_admin_amt] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [src_admin_amt] ELSE 0.00 END) AS [src_admin_amt],

    SUM(CASE WHEN [report_name] = 'IH5C' THEN [rpt_admin_amt] ELSE 0.00 END) 
    - SUM(CASE WHEN [report_name] = 'open_balance_cal' THEN [rpt_admin_amt] ELSE 0.00 END) AS [rpt_admin_amt]

FROM [silver].[open_balance_cal]
WHERE [report_name] IN ('IH5C', 'open_balance_cal')
GROUP BY 
    [accounting_period],
    [lob],
    [jurisdiction]

GO