CREATE TABLE [dbo].[closed_claims] (
    [claim_id]                VARCHAR (8000) NULL,
    [policy_no]               VARCHAR (8000) NULL,
    [lob]                     VARCHAR (8000) NULL,
    [jurisdiction]            VARCHAR (8000) NULL,
    [accounting_period]       DATE           NULL,
    [transaction_date]        DATE           NULL,
    [transaction_type]        VARCHAR (8000) NULL,
    [high_level_claim_status] VARCHAR (8000) NULL,
    [claim_status]            VARCHAR (8000) NULL,
    [approved_payment_amt]    FLOAT (53)     NULL,
    [access_fee]              FLOAT (53)     NULL,
    [claim_liab_amt]          FLOAT (53)     NULL,
    [admin_amt]               FLOAT (53)     NULL,
    [net_liab_amt]            FLOAT (53)     NULL,
    [scenario]                VARCHAR (8000) NULL
);


GO