CREATE TABLE [bronze].[new_added_claims_src] (
    [claim_id]                VARCHAR (8000)  NULL,
    [policy_no]               VARCHAR (8000)  NULL,
    [lob]                     VARCHAR (8000)  NULL,
    [jurisdiction]            VARCHAR (8000)  NULL,
    [accounting_period]       VARCHAR (8000)  NULL,
    [transaction_date]        VARCHAR (8000)  NULL,
    [transaction_type]        VARCHAR (8000)  NULL,
    [high_level_claim_status] VARCHAR (8000)  NULL,
    [claim_status]            VARCHAR (8000)  NULL,
    [approved_payment_amt]    DECIMAL (38, 6) NULL,
    [access_fee]              DECIMAL (38, 6) NULL,
    [claim_liab_amt]          DECIMAL (38, 6) NULL,
    [admin_amt]               DECIMAL (38, 6) NULL,
    [net_liab_amt]            DECIMAL (38, 6) NULL,
    [scenario]                VARCHAR (8000)  NULL
);


GO