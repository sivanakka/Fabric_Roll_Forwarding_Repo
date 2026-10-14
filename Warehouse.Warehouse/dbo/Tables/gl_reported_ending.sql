CREATE TABLE [dbo].[gl_reported_ending] (
    [claim_id]                VARCHAR (50)    NOT NULL,
    [policy_no]               VARCHAR (50)    NOT NULL,
    [lob]                     VARCHAR (20)    NOT NULL,
    [jurisdiction]            VARCHAR (10)    NOT NULL,
    [accounting_period]       VARCHAR (20)    NOT NULL,
    [transaction_date]        VARCHAR (20)    NOT NULL,
    [transaction_type]        VARCHAR (50)    NOT NULL,
    [high_level_claim_status] VARCHAR (20)    NOT NULL,
    [claim_status]            VARCHAR (50)    NOT NULL,
    [approved_payment_amt]    DECIMAL (18, 2) NOT NULL,
    [access_fee]              DECIMAL (18, 2) NOT NULL,
    [claim_liab_amt]          DECIMAL (18, 2) NOT NULL,
    [admin_amt]               DECIMAL (18, 2) NOT NULL,
    [net_liab_amt]            DECIMAL (18, 2) NOT NULL,
    [scenario]                VARCHAR (500)   NOT NULL
);


GO