CREATE   VIEW [gold].[IH6] AS

SELECT TOP (100) PERCENT

	 CASE [report_name]
    WHEN 'IH5P' THEN 1
    WHEN 'IH2' THEN 2
    WHEN 'misc_bucketB_src_rpt' THEN 3
    WHEN 'IH7' THEN 4
    WHEN 'IH3' THEN 5
    WHEN 'misc_bucketA_src_rpt' THEN 6
    WHEN 'IH5C' THEN 7
    WHEN 'open_balance_cal' THEN 8
    ELSE 9 END AS SORT_KEY,
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
FROM (
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
    FROM [silver].[open_balance_cal]

    UNION

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
    FROM [silver].[roll_forwrad_variance]
) AS combined_reports
ORDER BY SORT_KEY

GO