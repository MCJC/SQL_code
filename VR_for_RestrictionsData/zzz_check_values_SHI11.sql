/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Nation_fk]
      ,[Ctry_EditorialName]
      ,[Q_Yr]
      ,[SHI_11_a]
      ,[SHI_11_a_DES]
      ,[SHI_11_a_n]
      ,[SHI_11_b]
      ,[SHI_11_b_DES]
      ,[SHI_11_b_n]
  FROM [GRSHR2015].[dbo].[v02_AllCodedValues]




/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Nation_fk]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[SHI_11]
      ,[SHI_11_a]
      ,[SHI_11_x]
  FROM [forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]
where
