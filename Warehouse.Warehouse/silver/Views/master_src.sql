CREATE   VIEW silver.master_src as
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
FROM [bronze].[opening_claims_src_summry]

UNION ALL

-- 2. New Added Claims Source Summary
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
FROM [bronze].[new_added_claims_src_summry]

UNION ALL

-- 3. Closed Claims Source Summary
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
FROM [bronze].[closed_claims_src_summry]

UNION ALL

-- 4. Deleted / Purged Claims Source Summary
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
FROM [bronze].[deleted_purged_claims_src_summry]

UNION ALL

-- 5. GL Reported Ending Source Summary
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
FROM [bronze].[gl_reported_ending_src_summry]

GO