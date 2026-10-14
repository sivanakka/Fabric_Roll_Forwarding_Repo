[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared opening_claims = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM [dbo].[opening_claims]

        
        ",
        null,
        [EnableFolding = true]
    )
in
    RunQuery;
shared Server_Id = "4sdk7eegcs4exhj4bfxjr3ab4u-jq24a6knbavuzaclibyo5sj26m.datawarehouse.fabric.microsoft.com" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text, List = {"4sdk7eegcs4exhj4bfxjr3ab4u-jq24a6knbavuzaclibyo5sj26m.datawarehouse.fabric.microsoft.com"}, DefaultValue = ""];
shared Monthoffset = "1" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text];
shared DB_NAME = "Warehouse" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text, List = {"Warehouse"}];
shared new_added_claims = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM dbo.[new_added_claims]

        
        ",
        null,
        [EnableFolding = true]
    )
in
    RunQuery;
shared closed_claims = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM dbo.[closed_claims]

        
        ",
        null,
        [EnableFolding = true]
    )
in
    RunQuery;
shared deleted_purged_claims = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM dbo.[deleted_purged_claims]

        
        ",
        null,
        [EnableFolding = true]
    )
in
    RunQuery;
shared gl_reported_ending = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM dbo.[gl_reported_ending]

        
        ",
        null,
        [EnableFolding = true]
    )
in
    RunQuery;
