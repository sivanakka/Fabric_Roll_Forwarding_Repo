CREATE   VIEW silver.master_rpt as


-- 1. Opening Claims Report Summary
SELECT 
    [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],
    [total_claims],
    [total_approved_payment_amt],
    [total_access_fee],
    [total_claim_liab_amt],
    [total_admin_amt],
    [total_net_liab_amt]
FROM [bronze].[opening_claims_rpt_summry]

UNION ALL

-- 2. New Added Claims Report Summary
SELECT 
    [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],
    [total_claims],
    [total_approved_payment_amt],
    [total_access_fee],
    [total_claim_liab_amt],
    [total_admin_amt],
    [total_net_liab_amt]
FROM [bronze].[new_added_claims_rpt_summry]

UNION ALL

-- 3. Closed Claims Report Summary
SELECT 
    [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],
    [total_claims],
    [total_approved_payment_amt],
    [total_access_fee],
    [total_claim_liab_amt],
    [total_admin_amt],
    [total_net_liab_amt]
FROM [bronze].[closed_claims_rpt_summry]

UNION ALL

-- 4. Deleted / Purged Claims Report Summary
SELECT 
    [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],
    [total_claims],
    [total_approved_payment_amt],
    [total_access_fee],
    [total_claim_liab_amt],
    [total_admin_amt],
    [total_net_liab_amt]
FROM [bronze].[deleted_purged_claims_rpt_summry]

UNION ALL

-- 5. GL Reported Ending Report Summary
SELECT 
    [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],
    [total_claims],
    [total_approved_payment_amt],
    [total_access_fee],
    [total_claim_liab_amt],
    [total_admin_amt],
    [total_net_liab_amt]
FROM [bronze].[gl_reported_ending_rpt_summry]

GO