CREATE     VIEW [gold].[IH6] AS



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

  *

FROM (

    SELECT

      *

    FROM [silver].[src_rpt_var]



) AS combined_reports

ORDER BY SORT_KEY

GO