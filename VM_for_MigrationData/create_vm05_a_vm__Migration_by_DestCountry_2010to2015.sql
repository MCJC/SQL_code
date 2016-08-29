/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view          [forum]..[vm__Migration_by_DestCountry_2010to2015]                            <<<<<     ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/**** database name specification for data sources (once) ******************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
USE [forum]
GO
/***************************************************************************************************************************************************************/
----Hi Juan Carlos,
----How difficult would it be for you to generate this table for flows in 2010 to 2015 in LONG FORMAT using population counts?
----I think the last variable is the most tricky. If this doesn’t take long, can you do it this afternoon?
----Thanks.
----PC
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
ALTER  VIEW
                       [dbo].[vm__Migration_by_DestCountry_2010to2015]
AS
/***************************************************************************************************************************************************************/
WITH
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     MajorRel -- pct & count
            AS
              (
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
				SELECT 
					   [Year]
					  ,[Nation_fk]
					  ,[Population]
					  ,[Percentage]
				FROM
				(
				SELECT [Year]
					  ,[Nation_fk]
					  ,[Population]
					  ,[Percentage]
					  ,[Major]          = ROW_NUMBER()OVER(PARTITION BY [Country]
															   ORDER BY [Population] DESC )
				  FROM [forum].[dbo].[vi_AgeSexValue]
				WHERE  [Sex]   = 'all'
				  AND  [Age]   = 'all'
				  AND  [level] =  1
				  AND  [Year]         =  2010
				  AND  [Religion_fk] IS NOT NULL
				  AND  [Religion]    != 'All Religions'
				) MySorted
				WHERE  [Major]        = 1
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                             )
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    ,
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     InMigr -- immigrants by country by Rel
            AS
              (
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

				SELECT
						[Year]                   = [Field_year]
					  , [Scenario_id]
					  , [Destination_Nation_fk]
					  , [Country_of_Destination] = [Ctry_EditorialName]
					  , [MigReligion]            = [Pew_RelL02_Display]
					  , [Total_Immigrants]       = CAST((ROUND(( SUM([Migrant_Count]) ), 0)) AS INT)
					  , [Display]                = MIN([Display_by_Religion])
				  FROM [vm__Migration_Flow_by_Country]
					 , [Pew_Field]
					 , [Pew_Religion_Group]
					 , [Pew_Nation]
				WHERE
					     [Scenario_id]
					 =    4
				AND
                         [Field_year] IN 
                         (   '2010-2015' )
				AND
						 [Field_pk]
					 =   [Field_fk]
				AND
						 [Religion_group_pk]
					 =   [Religion_group_fk]
				AND
					     [Nation_pk]
					 =   [Destination_Nation_fk]
				GROUP BY 
                          [Field_fk]
                      ,   [Field_year]
                      ,   [Scenario_id]
					  ,   [Destination_Nation_fk]
					  ,   [Ctry_EditorialName]
					  ,   [Religion_group_fk]
					  ,   [Pew_RelL02_Display]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                             )
/*---------------------------------------------- ---------------------------------------------------------------------------------------------------------------*/
SELECT
      [v_row]                  =  ROW_NUMBER()
                                        OVER(
                                     ORDER BY  [Year]
                                              ,[Scenario_id]
                                              ,[Destination_Nation_fk]
                                              ,[MigReligion]              )
     ,[Year]
     ,[Scenario_id]
     ,[Destination_Nation_fk]
     ,[Country_of_Destination]
     ,[MigrReligion]           = CASE
                                 WHEN    [MigReligion]
                                       = 'Other Religions'
                                 THEN    'Members of '
                                       + [MigReligion]
                                 ELSE    [MigReligion]
                                  END
     ,[Total_Immigrants]
     ,[Display]
     ,[TotPop2010]
     ,[MajorRel_2010]
     ,[MajorRelPCT]
     ,[MajorRelPop]
FROM
      [InMigr]                                                                                            I
   , ( SELECT
              [MajorRelYR]
            , [Nation_fk]
            , [TotPop2010]
            , [MajorRel_2010] = CASE WHEN [N_Majors] = 1
                                     THEN [R1]
                                     WHEN [N_Majors] = 2
                                     THEN '>1 majority rel: ' + [R1] + ', ' + [R2]
                                     WHEN [N_Majors] = 3
                                     THEN '>1 majority rel: ' + [R1] + ', ' + [R2] + ', ' + [R3]
                                     ELSE 'Check QUERY'
                                 END
            , [MajorRelPCT]
            , [MajorRelPop]
          FROM (
				SELECT 
				       X.[Nation_fk]
					  ,X.[Country]
					  ,X.[Religion]
					  ,  [MajorRelYR]       = X.[Year]
					  ,  [TotPop2010]       = X.[TotPopulat]
					  ,  [MajorRelPop]      = X.[Population]
					  ,  [MajorRelPCT]      = X.[Percentage]
					  ,  [NofMajor]         = 'R' 
					                        + CAST(
					                          (ROW_NUMBER()
					                           OVER
					                           (PARTITION BY X.[Nation_fk]
					                            ORDER BY X.[Population] DESC )) AS CHAR(3))
					  ,  [N_Majors]         = COUNT(*)
					                           OVER
					                           (PARTITION BY X.[Nation_fk])
				  --FROM   (select * from
				  --        [forum].[dbo].[vi_AgeSexValue]
				  --        union all 
				  --        select * from 
				  --        [forum].[dbo].[vi_AgeSexValue]
				  --        Where  Nation_fk = 6          ) X
				  FROM   [forum].[dbo].[vi_AgeSexValue]   X
                     ,   [MajorRel]                       M
				WHERE  X.[Sex]   = 'all'
				  AND  X.[Age]   = 'all'
				  AND  X.[level] =  1
				  AND  X.[Religion_fk] IS NOT NULL
				  AND  X.[Religion]    != 'All Religions'
				  AND  X.[Year]
                     = M.[Year]
				  AND  X.[Nation_fk]
                     = M.[Nation_fk]
				  AND  X.[Population]
                     = M.[Population]
             ) b
             PIVOT (MAX ([Religion]) 
               FOR       [NofMajor]
                IN      ([R1],[R2],[R3])) AS WideRels                                                                                                        ) R
WHERE
        R.[Nation_fk]
      = I.[Destination_Nation_fk]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
