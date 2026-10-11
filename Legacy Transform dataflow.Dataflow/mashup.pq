[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared Query = let
  Source = AzureStorage.Blobs("https://azureopendatastorage.blob.core.windows.net/nyctlc/"),
  Navigation = Source{[#"Folder Path" = "https://azureopendatastorage.blob.core.windows.net/nyctlc/", Name = "_$azuretmpfolder$/a223892d-5c6b-4f9b-913b-ee3f608c6841part-00073-tid-5849318790271418554-257afbeb-bf9a-4847-a978-d1bf53c44882-77473.c000.snappy.parquet"]}[Content],
  #"Imported Parquet" = Parquet.Document(Navigation)
in
  #"Imported Parquet";
