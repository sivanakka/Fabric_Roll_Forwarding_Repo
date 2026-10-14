[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared Data_Lake_Path = "https://onelake.dfs.fabric.microsoft.com/FabricDev/Lakehouse.Lakehouse/Files/Balance_Reports" meta [IsParameterQuery = true, IsParameterQueryRequired = true, Type = type text, List = {"https://onelake.dfs.fabric.microsoft.com/FabricDev/Lakehouse.Lakehouse/Files/Balance_Reports"}, DefaultValue = ""];
shared opening_claims = let
  Source = AzureStorage.DataLake(Data_Lake_Path),
  Navigation = Source{[#"Folder Path" = "https://onelake.dfs.fabric.microsoft.com/FabricDev/Lakehouse.Lakehouse/Files/Balance_Reports/", Name = "opening_claims.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(Navigation, null, true),
  #"Navigation 1" = #"Imported Excel workbook"{[Item = "Opening Claims", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true])
in
  #"Promoted headers";
shared new_added_claims = let
  Source = AzureStorage.DataLake(Data_Lake_Path),
  Navigation = Source{[#"Folder Path" = "https://onelake.dfs.fabric.microsoft.com/FabricDev/Lakehouse.Lakehouse/Files/Balance_Reports/", Name = "new_added_claims.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(Navigation, null, true),
  #"Navigation 1" = #"Imported Excel workbook"{[Item = "New Added Claims", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true])
in
  #"Promoted headers";
shared closed_claims = let
  Source = AzureStorage.DataLake(Data_Lake_Path),
  Navigation = Source{[#"Folder Path" = "https://onelake.dfs.fabric.microsoft.com/FabricDev/Lakehouse.Lakehouse/Files/Balance_Reports/", Name = "closed_claims.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(Navigation, null, true),
  #"Navigation 1" = #"Imported Excel workbook"{[Item = "Closed Claims", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true])
in
  #"Promoted headers";
shared deleted_purged_claims = let
  Source = AzureStorage.DataLake(Data_Lake_Path),
  Navigation = Source{[#"Folder Path" = "https://onelake.dfs.fabric.microsoft.com/FabricDev/Lakehouse.Lakehouse/Files/Balance_Reports/", Name = "deleted_purged_claims.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(Navigation, null, true),
  #"Navigation 1" = #"Imported Excel workbook"{[Item = "Deleted Purged Claims", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true])
in
  #"Promoted headers";
shared gl_reported_ending = let
  Source = AzureStorage.DataLake(Data_Lake_Path),
  Navigation = Source{[#"Folder Path" = "https://onelake.dfs.fabric.microsoft.com/FabricDev/Lakehouse.Lakehouse/Files/Balance_Reports/", Name = "gl_reported_ending.xlsx"]}[Content],
  #"Imported Excel workbook" = Excel.Workbook(Navigation, null, true),
  #"Navigation 1" = #"Imported Excel workbook"{[Item = "GL Reported Ending", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true])
in
  #"Promoted headers";
