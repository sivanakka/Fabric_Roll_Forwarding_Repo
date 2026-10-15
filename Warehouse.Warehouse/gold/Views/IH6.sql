CREATE   VIEW gold.IH6 AS

SELECT * FROM

[silver].[open_balance_cal]

UNION
SELECT * FROM

[silver].[roll_forwrad_variance]

GO