SELECT [Nation_pk]
      ,[Ctry_EditorialName]
      ,[TPop1910]
      ,[Christian_pct1910]
      ,[Evangelical_pct2010]
  FROM [forumdb].[forum].[dbo].[Pew_Nation]
  where SubRegion6 = 'Latin America-Caribbean'
  and   Nation_pk  = 9