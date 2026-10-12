CREATE TABLE [dbo].[CLAIM_CREATION] (
    [CLAIM_ID]        VARCHAR (20)    NOT NULL,
    [SCCF_ID]         VARCHAR (20)    NOT NULL,
    [TOT_PAY_AMT]     DECIMAL (18, 2) NULL,
    [CLM_LAST_ACT_DT] DATE            NOT NULL,
    [STS_CD]          VARCHAR (10)    NULL
);


GO