[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "opening_claims_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
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
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "new_added_claims_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
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
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "closed_claims_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
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
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "deleted_purged_claims_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
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
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "gl_reported_ending_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
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
shared opening_claims_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Warehouse"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "bronze"]}[Data],
  TableNavigation = Navigation_3{[Name = "opening_claims_src"]}?[Data]?
in
  TableNavigation;
shared Dynamic_destination_demo = let
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
shared closed_claims_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Warehouse"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "bronze"]}[Data],
  TableNavigation = Navigation_3{[Name = "closed_claims_src"]}?[Data]?
in
  TableNavigation;
shared new_added_claims_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Warehouse"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "bronze"]}[Data],
  TableNavigation = Navigation_3{[Name = "new_added_claims_src"]}?[Data]?
in
  TableNavigation;
shared deleted_purged_claims_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Warehouse"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "bronze"]}[Data],
  TableNavigation = Navigation_3{[Name = "deleted_purged_claims_src"]}?[Data]?
in
  TableNavigation;
shared gl_reported_ending_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Warehouse"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "bronze"]}[Data],
  TableNavigation = Navigation_3{[Name = "gl_reported_ending_src"]}?[Data]?
in
  TableNavigation;
