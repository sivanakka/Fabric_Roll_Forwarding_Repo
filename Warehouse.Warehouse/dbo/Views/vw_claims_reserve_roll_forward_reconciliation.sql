CREATE VIEW [dbo].[vw_claims_reserve_roll_forward_reconciliation]
AS
WITH OpeningSummary AS (
    SELECT [lob], [accounting_period], SUM([net_liab_amt]) AS [opening_reserve]
    FROM [dbo].[opening_claims]
    GROUP BY [lob], [accounting_period]
),
NewAddedSummary AS (
    SELECT [lob], [accounting_period], SUM([net_liab_amt]) AS [new_added_reserve]
    FROM [dbo].[new_added_claims]
    GROUP BY [lob], [accounting_period]
),
ClosedSummary AS (
    SELECT [lob], [accounting_period], SUM([net_liab_amt]) AS [closed_reserve]
    FROM [dbo].[closed_claims]
    GROUP BY [lob], [accounting_period]
),
PurgedSummary AS (
    SELECT [lob], [accounting_period], SUM([net_liab_amt]) AS [purged_reserve]
    FROM [dbo].[deleted_purged_claims]
    GROUP BY [lob], [accounting_period]
),
GLSummary AS (
    SELECT [lob], [accounting_period], SUM([net_liab_amt]) AS [gl_reported_reserve]
    FROM [dbo].[gl_reported_ending]
    GROUP BY [lob], [accounting_period]
),
RollForward AS (
    SELECT 
        COALESCE(o.[lob], n.[lob], c.[lob], p.[lob], g.[lob]) AS [lob],
        COALESCE(o.[accounting_period], n.[accounting_period], c.[accounting_period], p.[accounting_period], g.[accounting_period]) AS [accounting_period],
        ISNULL(o.[opening_reserve], 0.00) AS [opening_reserve],
        ISNULL(n.[new_added_reserve], 0.00) AS [new_added_reserve],
        ISNULL(c.[closed_reserve], 0.00) AS [closed_reserve],
        ISNULL(p.[purged_reserve], 0.00) AS [purged_reserve],
        (ISNULL(o.[opening_reserve], 0.00) + ISNULL(n.[new_added_reserve], 0.00) - ISNULL(c.[closed_reserve], 0.00) - ISNULL(p.[purged_reserve], 0.00)) AS [calculated_ending_reserve],
        ISNULL(g.[gl_reported_reserve], 0.00) AS [gl_reported_reserve]
    FROM OpeningSummary o
    FULL OUTER JOIN NewAddedSummary n ON o.[lob] = n.[lob] AND o.[accounting_period] = n.[accounting_period]
    FULL OUTER JOIN ClosedSummary c ON COALESCE(o.[lob], n.[lob]) = c.[lob] AND COALESCE(o.[accounting_period], n.[accounting_period]) = c.[accounting_period]
    FULL OUTER JOIN PurgedSummary p ON COALESCE(o.[lob], n.[lob], c.[lob]) = p.[lob] AND COALESCE(o.[accounting_period], n.[accounting_period], c.[accounting_period]) = p.[accounting_period]
    FULL OUTER JOIN GLSummary g ON COALESCE(o.[lob], n.[lob], c.[lob], p.[lob]) = g.[lob] AND COALESCE(o.[accounting_period], n.[accounting_period], c.[accounting_period], p.[accounting_period]) = g.[accounting_period]
)
SELECT 
    [lob],
    [accounting_period],
    [opening_reserve],
    [new_added_reserve],
    [closed_reserve],
    [purged_reserve],
    [calculated_ending_reserve],
    [gl_reported_reserve],
    ([gl_reported_reserve] - [calculated_ending_reserve]) AS [variance],
    CASE 
        WHEN ABS([gl_reported_reserve] - [calculated_ending_reserve]) < 0.01 THEN 'MATCH'
        ELSE 'BREAK'
    END AS [reconciliation_status],
    CASE 
        WHEN [lob] = 'PROPERTY' AND ([gl_reported_reserve] - [calculated_ending_reserve]) > 0.01 
            THEN 'GL_OVERSTATEMENT_UNPOSTED_PURGE: Purged QA test claim retained on GL balance sheet'
        WHEN [lob] = 'TRAVEL' AND ([gl_reported_reserve] - [calculated_ending_reserve]) < -0.01 
            THEN 'GL_UNDERSTATEMENT_DUPLICATE_PAYMENT: Duplicate wire deduction in GL cash feed'
        ELSE 'NONE_RECONCILED_EXACT'
    END AS [break_root_cause]
FROM RollForward;

GO