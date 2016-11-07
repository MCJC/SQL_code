--- 5.	Year-to-year changes (2007-2014) in terrorist activity with no violence, 1-9 casualties, 10-50 casualties and 50+ casualties
                 IF OBJECT_ID  (N'[forum_ResAnal]..[vry16_05__YtoYChngsTerrActvity]', N'U') IS NOT NULL 
                DROP TABLE        [forum_ResAnal]..[vry16_05__YtoYChngsTerrActvity]



SELECT 
       [vx1Row]
      ,[Variable]
      ,[Value]
      ,[Wording]
      ,[N2007]
      ,[P2007]
      ,[N2008]
      ,[P2008]
      ,[N2009]
      ,[P2009]
      ,[N2010]
      ,[P2010]
      ,[N2011]
      ,[P2011]
      ,[N2012]
      ,[P2012]
      ,[N2013]
      ,[P2013]
      ,[N2014]
      ,[P2014]
into   [forum_ResAnal].[dbo].[vry16_05__YtoYChngsTerrActvity]

  FROM [forum_ResAnal].[dbo].[vr___09_cDB_Basic_TopLines_All]
  where Variable     like 'SHI_04'
  and   Variable not like 'GFI%'
--GRI_scaled
--SHI_scaled

  