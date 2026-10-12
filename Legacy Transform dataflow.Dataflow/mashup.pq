section Section1;
shared Exception_Claims = let
    // ---- claim ID list from the DNA query ----
    RawInput = PRS_CLAIMS,

    IdsList = 
        if Value.Is(RawInput, type list) then RawInput
        else Table.Column(RawInput, Table.ColumnNames(RawInput){0}),

    Ids = List.Buffer(
        List.Distinct(
            List.RemoveNulls(
                List.Transform(IdsList, each Text.From(_))
            )
        )
    ),

    Chunks = List.Split(Ids,Chunk_Size),

    Source = Sql.Database(Server_Id, DB_NAME),

    SqlText = "
SELECT 
    [CLAIM_ID],
    [SCCF_ID],
    [TOT_PAY_AMT],
    [CLM_LAST_ACT_DT],
    [STS_CD]
FROM [dbo].[CLAIM_CREATION] c
INNER JOIN (SELECT LTRIM(RTRIM(value)) AS CLCL_ID FROM STRING_SPLIT(@p1, '|')) f
    ON f.CLCL_ID =[CLAIM_ID]

",

    RunChunk = (chunk as list) as table =>
        Value.NativeQuery(
            Source,
            SqlText,
            [p1 = Text.Combine(chunk, "|")],
            [EnableFolding = true]
        ),

    Results = List.Transform(Chunks, each RunChunk(_)),

    Combined = if List.IsEmpty(Results)
        then #table({}, {})
        else Table.Combine(Results)
in
    Combined;
shared CLAIM_CREATION = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
    SELECT 
    [CLAIM_ID],
    [SCCF_ID],
    [TOT_PAY_AMT],
    [CLM_LAST_ACT_DT],
    [STS_CD]
FROM [dbo].[CLAIM_CREATION]
WHERE 
   
    [STS_CD] <> '02'
    
    OR (
        [STS_CD] = '02' 
        AND [CLM_LAST_ACT_DT] >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) -" & Monthoffset & ", 0)
        AND [CLM_LAST_ACT_DT] <  DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
    )


        
        ",
        null,
        [EnableFolding = true]
    ),
  #"Added custom" = Table.AddColumn(
    RunQuery, 
    "Month_Flag", 
    each if Date.IsInPreviousMonth([CLM_LAST_ACT_DT]) then "Prev Month" else "Prior Month",
    type text
)
in
    #"Added custom";
shared CLAIM_PRS = let
  Source = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navigation 1" = Source{[workspaceId = "79c0354c-084d-4c2b-804b-4070eec93af3"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[warehouseId = "8967e00d-f1bc-4ec3-80a5-c6aa479b8eaa"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Schema = "dbo", Item = "CLAIM_PRS"]}[Data],
  Custom = Table.AddColumn(
    #"Navigation 3", 
    "Month_Flag", 
    each if Date.IsInPreviousMonth([EDIT_DT]) then "Prev Month" else "Prior Month",
    type text
),
  #"Added custom" = Table.AddColumn(Custom, "Flag", each if [OPEN_CLS_IND] <> "02" or ([OPEN_CLS_IND] = "02" and Date.IsInPreviousMonth([EDIT_DT])) then true else false),
  #"Filtered rows" = Table.SelectRows(#"Added custom", each ([Flag] = true))
in
  #"Filtered rows";
shared PRS_CLAIMS = let
  Source = CLAIM_PRS,
  #"Removed columns" = Table.RemoveColumns(Source, {"SCCF_ID", "APPVT_AMT", "EDIT_DT", "OPEN_CLS_IND", "DISP_CD", "Month_Flag", "Flag"}),
  #"Merged queries" = Table.NestedJoin(#"Removed columns", {"CLAIM_ID"}, CLAIM_CREATION, {"CLAIM_ID"}, "CLAIM_CREATION", JoinKind.LeftAnti),
  #"Removed columns 1" = Table.RemoveColumns(#"Merged queries", {"CLAIM_CREATION"}),
  #"Converted to list" = #"Removed columns 1"[CLAIM_ID]
in
  #"Converted to list";
shared Server_Id = "4sdk7eegcs4exhj4bfxjr3ab4u-jq24a6knbavuzaclibyo5sj26m.datawarehouse.fabric.microsoft.com" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text, List = {"4sdk7eegcs4exhj4bfxjr3ab4u-jq24a6knbavuzaclibyo5sj26m.datawarehouse.fabric.microsoft.com"}, DefaultValue = ""];
shared Chunk_Size = 1000 meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type number];
shared Monthoffset = "1" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text];
shared DB_NAME = "Warehouse" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text, List = {"Warehouse"}];
