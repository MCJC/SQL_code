

  SELECT  
          [InRes]
        , [TP]    = SUM([TP])
        , [PCT]   = SUM([RP]) / [WP]
        , [XP]    = SUM([XP])
		, [WP]

--FROM
--(
--  SELECT  
--          [InRes] = CASE WHEN [Ctry_EditorialName] IS NOT NULL THEN 1 ELSE 0 END
--        , [InW]   = 1
--        , [TP]
--        , [RP]

--                , [Ctry_EditorialName]
--        , [Nfk]


FROM
       (  SELECT  [TP]            =  CAST([Cnt] AS BIGINT)
                , [RP]            =       [Cnt]
                , [XP]            =       [Cnt] / SUM([Cnt]) OVER()
                , [WP]            =   SUM([Cnt]) OVER()
                , [Nfk]           =       [Nation_fk]
             FROM [forum].[dbo].[Pew_Nation_Age_Sex_Value]
                , [forum].[dbo].[Pew_Field]
           WHERE
   		          [Scenario_id]  = 3
             AND  [Field_fk]
                = [Field_pk]     
			 AND  [Field_year]   = '2014'  ) POP
    LEFT JOIN
       (  SELECT  DISTINCT
	              [Nation_fk]
                , [Ctry_EditorialName]
        ,  [InRes] = 1
             FROM [forum_ResAnal].[dbo].[vr___04_cDB_SemiWide_byCtry&Yr]  ) CTRIES
on 
	    [Nation_fk] = [Nfk]
--) CaP 

group by [InRes] , [WP] 




