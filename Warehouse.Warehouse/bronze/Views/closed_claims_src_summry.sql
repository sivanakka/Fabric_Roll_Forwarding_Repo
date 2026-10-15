CREATE    VIEW [bronze].[closed_claims_src_summry] AS
SELECT
    [report_name],
    [accounting_period],
    [lob],
    [jurisdiction],
    COUNT([claim_id])               AS [total_claims],
    SUM([approved_payment_amt])     AS [total_approved_payment_amt],
    SUM([access_fee])               AS [total_access_fee],
    SUM([claim_liab_amt])           AS [total_claim_liab_amt],
    SUM([admin_amt])                AS [total_admin_amt],
    SUM([net_liab_amt])             AS [total_net_liab_amt]
FROM [bronze].[closed_claims_src]
GROUP BY 
 [report_name],
    [accounting_period],
    [lob],
    [jurisdiction]

GO