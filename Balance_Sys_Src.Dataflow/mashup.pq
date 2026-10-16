[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "opening_claims_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "claim_id", DestinationColumnName = "claim_id"], [SourceColumnName = "policy_no", DestinationColumnName = "policy_no"], [SourceColumnName = "lob", DestinationColumnName = "lob"], [SourceColumnName = "jurisdiction", DestinationColumnName = "jurisdiction"], [SourceColumnName = "accounting_period", DestinationColumnName = "accounting_period"], [SourceColumnName = "transaction_date", DestinationColumnName = "transaction_date"], [SourceColumnName = "transaction_type", DestinationColumnName = "transaction_type"], [SourceColumnName = "high_level_claim_status", DestinationColumnName = "high_level_claim_status"], [SourceColumnName = "claim_status", DestinationColumnName = "claim_status"], [SourceColumnName = "approved_payment_amt", DestinationColumnName = "approved_payment_amt"], [SourceColumnName = "access_fee", DestinationColumnName = "access_fee"], [SourceColumnName = "claim_liab_amt", DestinationColumnName = "claim_liab_amt"], [SourceColumnName = "admin_amt", DestinationColumnName = "admin_amt"], [SourceColumnName = "net_liab_amt", DestinationColumnName = "net_liab_amt"], [SourceColumnName = "scenario", DestinationColumnName = "scenario"], [SourceColumnName = "report_name", DestinationColumnName = "report_name"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared opening_claims = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM [dbo].[opening_claims]

        
        ",
        null,
        [EnableFolding = true]
    ),
  Custom = Table.TransformColumnTypes(#"RunQuery", {
    {"claim_id", type text},
    {"policy_no", type text},
    {"lob", type text},
    {"jurisdiction", type text},
    {"transaction_type", type text},
    {"high_level_claim_status", type text},
    {"claim_status", type text},
    {"approved_payment_amt", type number},
    {"scenario", type text},
    {"accounting_period", type date},
    {"transaction_date", type date},
    {"access_fee", type number},
    {"claim_liab_amt", type number},
    {"admin_amt", type number},
    {"net_liab_amt", type number}
}, "en-US"),
  #"Added custom" = Table.AddColumn(Custom, "report_name", each "IH5P"),
  #"Changed column type" = Table.TransformColumnTypes(#"Added custom", {{"report_name", type text}})
in
    #"Changed column type";
shared Server_Id = "4sdk7eegcs4exhj4bfxjr3ab4u-jq24a6knbavuzaclibyo5sj26m.datawarehouse.fabric.microsoft.com" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text, List = {"4sdk7eegcs4exhj4bfxjr3ab4u-jq24a6knbavuzaclibyo5sj26m.datawarehouse.fabric.microsoft.com"}, DefaultValue = ""];
shared Monthoffset = "1" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text];
shared DB_NAME = "Warehouse" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text, List = {"Warehouse"}];
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "new_added_claims_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "claim_id", DestinationColumnName = "claim_id"], [SourceColumnName = "policy_no", DestinationColumnName = "policy_no"], [SourceColumnName = "lob", DestinationColumnName = "lob"], [SourceColumnName = "jurisdiction", DestinationColumnName = "jurisdiction"], [SourceColumnName = "accounting_period", DestinationColumnName = "accounting_period"], [SourceColumnName = "transaction_date", DestinationColumnName = "transaction_date"], [SourceColumnName = "transaction_type", DestinationColumnName = "transaction_type"], [SourceColumnName = "high_level_claim_status", DestinationColumnName = "high_level_claim_status"], [SourceColumnName = "claim_status", DestinationColumnName = "claim_status"], [SourceColumnName = "approved_payment_amt", DestinationColumnName = "approved_payment_amt"], [SourceColumnName = "access_fee", DestinationColumnName = "access_fee"], [SourceColumnName = "claim_liab_amt", DestinationColumnName = "claim_liab_amt"], [SourceColumnName = "admin_amt", DestinationColumnName = "admin_amt"], [SourceColumnName = "net_liab_amt", DestinationColumnName = "net_liab_amt"], [SourceColumnName = "scenario", DestinationColumnName = "scenario"], [SourceColumnName = "report_name", DestinationColumnName = "report_name"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared new_added_claims = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM dbo.[new_added_claims]

        
        ",
        null,
        [EnableFolding = true]
    ),
  #"Custom 1" = Table.TransformColumnTypes(#"RunQuery", {
    {"claim_id", type text},
    {"policy_no", type text},
    {"lob", type text},
    {"jurisdiction", type text},
    {"transaction_type", type text},
    {"high_level_claim_status", type text},
    {"claim_status", type text},
    {"approved_payment_amt", type number},
    {"scenario", type text},
    {"accounting_period", type date},
    {"transaction_date", type date},
    {"access_fee", type number},
    {"claim_liab_amt", type number},
    {"admin_amt", type number},
    {"net_liab_amt", type number}
}, "en-US"),
  Custom = Table.AddColumn(#"Custom 1", "report_name", each "IH2"),
  #"Changed column type" = Table.TransformColumnTypes(Custom, {{"report_name", type text}})
in
    #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "closed_claims_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "claim_id", DestinationColumnName = "claim_id"], [SourceColumnName = "policy_no", DestinationColumnName = "policy_no"], [SourceColumnName = "lob", DestinationColumnName = "lob"], [SourceColumnName = "jurisdiction", DestinationColumnName = "jurisdiction"], [SourceColumnName = "accounting_period", DestinationColumnName = "accounting_period"], [SourceColumnName = "transaction_date", DestinationColumnName = "transaction_date"], [SourceColumnName = "transaction_type", DestinationColumnName = "transaction_type"], [SourceColumnName = "high_level_claim_status", DestinationColumnName = "high_level_claim_status"], [SourceColumnName = "claim_status", DestinationColumnName = "claim_status"], [SourceColumnName = "approved_payment_amt", DestinationColumnName = "approved_payment_amt"], [SourceColumnName = "access_fee", DestinationColumnName = "access_fee"], [SourceColumnName = "claim_liab_amt", DestinationColumnName = "claim_liab_amt"], [SourceColumnName = "admin_amt", DestinationColumnName = "admin_amt"], [SourceColumnName = "net_liab_amt", DestinationColumnName = "net_liab_amt"], [SourceColumnName = "scenario", DestinationColumnName = "scenario"], [SourceColumnName = "report_name", DestinationColumnName = "report_name"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared closed_claims = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM dbo.[closed_claims]

        
        ",
        null,
        [EnableFolding = true]
    ),
  #"Custom 1" = Table.TransformColumnTypes(#"RunQuery", {
    {"claim_id", type text},
    {"policy_no", type text},
    {"lob", type text},
    {"jurisdiction", type text},
    {"transaction_type", type text},
    {"high_level_claim_status", type text},
    {"claim_status", type text},
    {"approved_payment_amt", type number},
    {"scenario", type text},
    {"accounting_period", type date},
    {"transaction_date", type date},
    {"access_fee", type number},
    {"claim_liab_amt", type number},
    {"admin_amt", type number},
    {"net_liab_amt", type number}
}, "en-US"),
  Custom = Table.AddColumn(#"Custom 1", "report_name", each "IH7"),
  #"Changed column type" = Table.TransformColumnTypes(Custom, {{"report_name", type text}})
in
    #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "deleted_purged_claims_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "claim_id", DestinationColumnName = "claim_id"], [SourceColumnName = "policy_no", DestinationColumnName = "policy_no"], [SourceColumnName = "lob", DestinationColumnName = "lob"], [SourceColumnName = "jurisdiction", DestinationColumnName = "jurisdiction"], [SourceColumnName = "accounting_period", DestinationColumnName = "accounting_period"], [SourceColumnName = "transaction_date", DestinationColumnName = "transaction_date"], [SourceColumnName = "transaction_type", DestinationColumnName = "transaction_type"], [SourceColumnName = "high_level_claim_status", DestinationColumnName = "high_level_claim_status"], [SourceColumnName = "claim_status", DestinationColumnName = "claim_status"], [SourceColumnName = "approved_payment_amt", DestinationColumnName = "approved_payment_amt"], [SourceColumnName = "access_fee", DestinationColumnName = "access_fee"], [SourceColumnName = "claim_liab_amt", DestinationColumnName = "claim_liab_amt"], [SourceColumnName = "admin_amt", DestinationColumnName = "admin_amt"], [SourceColumnName = "net_liab_amt", DestinationColumnName = "net_liab_amt"], [SourceColumnName = "scenario", DestinationColumnName = "scenario"], [SourceColumnName = "report_name", DestinationColumnName = "report_name"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared deleted_purged_claims = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM dbo.[deleted_purged_claims]

        
        ",
        null,
        [EnableFolding = true]
    ),
  #"Custom 1" = Table.TransformColumnTypes(#"RunQuery", {
    {"claim_id", type text},
    {"policy_no", type text},
    {"lob", type text},
    {"jurisdiction", type text},
    {"transaction_type", type text},
    {"high_level_claim_status", type text},
    {"claim_status", type text},
    {"approved_payment_amt", type number},
    {"scenario", type text},
    {"accounting_period", type date},
    {"transaction_date", type date},
    {"access_fee", type number},
    {"claim_liab_amt", type number},
    {"admin_amt", type number},
    {"net_liab_amt", type number}
}, "en-US"),
  Custom = Table.AddColumn(#"Custom 1", "report_name", each "IH3"),
  #"Changed column type" = Table.TransformColumnTypes(Custom, {{"report_name", type text}})
in
    #"Changed column type";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "gl_reported_ending_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "claim_id", DestinationColumnName = "claim_id"], [SourceColumnName = "policy_no", DestinationColumnName = "policy_no"], [SourceColumnName = "lob", DestinationColumnName = "lob"], [SourceColumnName = "jurisdiction", DestinationColumnName = "jurisdiction"], [SourceColumnName = "accounting_period", DestinationColumnName = "accounting_period"], [SourceColumnName = "transaction_date", DestinationColumnName = "transaction_date"], [SourceColumnName = "transaction_type", DestinationColumnName = "transaction_type"], [SourceColumnName = "high_level_claim_status", DestinationColumnName = "high_level_claim_status"], [SourceColumnName = "claim_status", DestinationColumnName = "claim_status"], [SourceColumnName = "approved_payment_amt", DestinationColumnName = "approved_payment_amt"], [SourceColumnName = "access_fee", DestinationColumnName = "access_fee"], [SourceColumnName = "claim_liab_amt", DestinationColumnName = "claim_liab_amt"], [SourceColumnName = "admin_amt", DestinationColumnName = "admin_amt"], [SourceColumnName = "net_liab_amt", DestinationColumnName = "net_liab_amt"], [SourceColumnName = "scenario", DestinationColumnName = "scenario"], [SourceColumnName = "report_name", DestinationColumnName = "report_name"]}], DynamicSchema = true, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared gl_reported_ending = let
    Source = Sql.Database(Server_Id,DB_NAME),
    RunQuery = Value.NativeQuery(
        Source, 
        "
        
     SELECT * FROM dbo.[gl_reported_ending]

        
        ",
        null,
        [EnableFolding = true]
    ),
  #"Custom 1" = Table.TransformColumnTypes(#"RunQuery", {
    {"claim_id", type text},
    {"policy_no", type text},
    {"lob", type text},
    {"jurisdiction", type text},
    {"transaction_type", type text},
    {"high_level_claim_status", type text},
    {"claim_status", type text},
    {"approved_payment_amt", type number},
    {"scenario", type text},
    {"accounting_period", type date},
    {"transaction_date", type date},
    {"access_fee", type number},
    {"claim_liab_amt", type number},
    {"admin_amt", type number},
    {"net_liab_amt", type number}
}, "en-US"),
  Custom = Table.AddColumn(#"Custom 1", "report_name", each "IH5C"),
  #"Changed column type" = Table.TransformColumnTypes(Custom, {{"report_name", type text}})
in
    #"Changed column type";
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
shared opening_claims_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Warehouse"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "bronze"]}[Data],
  TableNavigation = Navigation_3{[Name = "opening_claims_src"]}?[Data]?
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
shared closed_claims_DataDestination = let
  Pattern = Fabric.Warehouse([CreateNavigationProperties = false, HierarchicalNavigation = true]),
  Navigation_1 = Pattern{[workspaceId = "."]}[Data],
  Navigation_2 = Navigation_1{[displayName = "Warehouse"]}[Data],
  Navigation_3 = Navigation_2{[Schema = "bronze"]}[Data],
  TableNavigation = Navigation_3{[Name = "closed_claims_src"]}?[Data]?
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
