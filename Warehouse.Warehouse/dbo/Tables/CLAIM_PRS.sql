CREATE TABLE [dbo].[CLAIM_PRS] (
    [CLAIM_ID]     VARCHAR (20)    NOT NULL,
    [SCCF_ID]      BIGINT          NOT NULL,
    [APPVT_AMT]    DECIMAL (18, 2) NULL,
    [EDIT_DT]      DATE            NOT NULL,
    [OPEN_CLS_IND] VARCHAR (10)    NULL,
    [DISP_CD]      VARCHAR (10)    NULL
);


GO