--USE [forum]
--GO
--/***************************************************************************************************************************************************************/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--/***************************************************************************************************************************************************************/
--ALTER  VIEW
--                       [dbo].[vm__Migration_Flow_by_Country]
--AS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SELECT
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--       [MFCv_row]
--                  =  ROW_NUMBER()
--                     OVER(ORDER BY
--                            [Migration_Flow_fk_min] )
--      ,[Migration_Flow_fk_min]
--      ,[Field_fk]
--      ,[Scenario_id]
--      ,[Origin_Nation_fk]
--      ,[Destination_Nation_fk]
--      ,[Religion_group_fk]
--      ,[Migrant_Count]
--      ,[Display_by_Religion]
--      ,[Display_as_Destination_Ctry]
--      ,[Display_as_Origin_Ctry]
--  FROM [forum_ResAnal].[dbo].[vm__Migration_Flow_by_Country]
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--/***************************************************************************************************************************************************************/

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view          [forum]..[vm__Migration_Flow_by_Country]                                      <<<<<     ***/
/***     >>>>>   This is the script used to create the table [forum_ResAnal]..[vm__Migration_Flow_by_Country]                                      <<<<<     ***/
/***             NOTE:  This is a fixed table hosted at the default place for auxiliary fixed tables: [forum_ResAnal]                                        ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/**** database name specification for data sources (once) ******************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vm__Migration_Flow_by_Country]', N'U') IS NOT NULL
DROP   TABLE     [forum_ResAnal].[dbo].[vm__Migration_Flow_by_Country]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
/***************************************************************************************************************************************************************/
CREATE TABLE
             [vm__Migration_Flow_by_Country]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
    [Migration_Flow_fk_min]            [int]         NOT NULL,
	[Field_fk]                         [int]             NULL,
	[Scenario_id]                      [int]             NULL,
    [Origin_Nation_fk]                 [int]             NULL,
    [Destination_Nation_fk]            [int]             NULL,
	[Religion_group_fk]                [int]             NULL,
    [Migrant_Count]                    [decimal](32,24)  NULL,
    [Display_by_Religion]              [int]             NULL,
    [Display_as_Destination_Ctry]      [int]             NULL,
    [Display_as_Origin_Ctry]           [int]             NULL,
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
    CONSTRAINT
    [PK_Migration_Flow_by_Country]
    PRIMARY KEY CLUSTERED 
    (
	  [Migration_Flow_fk_min]
	                      ASC
                         )WITH (  PAD_INDEX              = OFF,
                                  STATISTICS_NORECOMPUTE = OFF,
                                  IGNORE_DUP_KEY         = OFF,
                                  ALLOW_ROW_LOCKS        = ON ,
                                  ALLOW_PAGE_LOCKS       = ON  ) ON [PRIMARY]
                                                                               ) ON [PRIMARY]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
GO
/***************************************************************************************************************************************************************/
SET ANSI_PADDING OFF
GO
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---- collapse migration projected data --------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO 
             [vm__Migration_Flow_by_Country]
SELECT 
       [Migration_Flow_fk_min]       = MIN([V_Migration_Flow_pk])          -- 1st row in sub-set of 41 sex/age cohorts
      ,[Field_fk]
      ,[Scenario_id]
      ,[Origin_Nation_fk]
      ,[Destination_Nation_fk]
      ,[Religion_group_fk]
      ,[MigrantCount]                = SUM([Migrant_Count])                -- total for 28 sex/age cohorts
      ,[Display_by_Religion]         = MIN([Display_by_Religion])          -- zero if any row is zero
      ,[Display_as_Destination_Ctry] = MIN([Display_as_Destination_Ctry])  -- zero if any row is zero
      ,[Display_as_Origin_Ctry]      = MIN([Display_as_Origin_Ctry])       -- zero if any row is zero
  FROM
             [vm__Migration_Flow_all]
GROUP
BY
       [Field_fk]
      ,[Scenario_id]
      ,[Origin_Nation_fk]
      ,[Destination_Nation_fk]
      ,[Religion_group_fk]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- select * from [vm__Migration_Flow_by_Country]  --   155C * (155-1) * 8 * 10 = 1,909,600
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*-- check aggregated data ------------------------------------------------------------------------------------------------------------------------------------*/
--SELECT        distinct
--             [Nation_fk]
--            ,[Ctry_EditorialName]
--  FROM       [vi_Nation_Attributes]
--  LEFT JOIN  [vm__Migration_Flow_by_Country] o
--       ON    [Nation_fk]
--           = o.[Origin_Nation_fk]
--  LEFT JOIN  [vm__Migration_Flow_by_Country] d
--       ON    [Nation_fk]
--           = d.[Destination_Nation_fk]
--  WHERE      o.[Origin_Nation_fk]       IS NULL
--    AND      d.[Destination_Nation_fk]  IS NULL
--    AND        [Nation_fk]               < 1000
--ORDER BY       [Nation_fk]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--SELECT TOP 5 [Origin_Nation_fk]
--            ,[Ctry_EditorialName]
--            ,[MigrantCount]                = SUM([Migrant_Count])
--  FROM       [vm__Migration_Flow_by_Country]
--            ,[vi_Nation_Attributes]
--WHERE        [Origin_Nation_fk]
--           =             [Nation_fk]
--GROUP BY     [Origin_Nation_fk]
--            ,[Ctry_EditorialName]
--ORDER BY     [MigrantCount]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--SELECT TOP 5 [Destination_Nation_fk]
--            ,[Ctry_EditorialName]
--            ,[MigrantCount]                = SUM([Migrant_Count])
--  FROM       [vm__Migration_Flow_by_Country]
--            ,[vi_Nation_Attributes]
--WHERE        [Destination_Nation_fk]
--           =             [Nation_fk]
--GROUP BY     [Destination_Nation_fk]
--            ,[Ctry_EditorialName]
--ORDER BY     [MigrantCount]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
