/* ++> create_vi03b_vi_Migrants.sql <++ */
--USE [forum]
--GO
--/**************************************************************************************************************************/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--/**************************************************************************************************************************/
--ALTER  VIEW
--                        [dbo].[vi_Migrants]
--AS
------------------------------------------------------------------------------------------------------------------------------
--SELECT
------------------------------------------------------------------------------------------------------------------------------
--          [MbC_row]       =  ROW_NUMBER()OVER(ORDER BY
--                                             [Level]       DESC
--                                           , [Nation_fk]
--                                           , [Religion_fk]
--                                           , [Direction]
--                                                                )
--        , [Direction]
--        , [Level]
--        , [Nation_fk]
--        , [Location]
--        , [Religion_fk]
--        , [Religion]
--        , [NUM_Migrants]
--        , [PCT_Migrants]
--        , [NUM_Migrants_ds]
--        , [PCT_Migrants_ds]
------------------------------------------------------------------------------------------------------------------------------
--  FROM
--        [forum_ResAnal].[dbo].[vi_Migrants]
--WHERE
--          [Religion_fk] != 52
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/***                                                                                                                    ***/
/***                                                                                                                    ***/
/***     >>>>>   This is the script used to create the view          [forum]..[vi_Migrants]                   <<<<<     ***/
/***     >>>>>   This is the script used to create the table [forum_ResAnal]..[vi_Migrants]                   <<<<<     ***/
/***             NOTE:  This is a fixed table hosted at the default place for auxiliary fixed tables: [forum_ResAnal]   ***/
/***                                                                                                                    ***/
/**************************************************************************************************************************/
/**** database name specification for data sources (once) *****************************************************************/
----------------------------------------------------------------------------------------------------------------------------
USE              [forum]
GO
----------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID (N'[forum_ResAnal].[dbo].[vi_Migrants]', N'U') IS NOT NULL
DROP   TABLE    [forum_ResAnal].[dbo].[vi_Migrants]                                     -- drop table if existent
/*** 1. All Migration Stock by Region&Country/Religion ********************************************************************/
----------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          [MbC_row]       =  ROW_NUMBER()OVER(ORDER BY
                                             [Level]       DESC
                                           , [Nation_fk]
                                           , [Religion_fk]
                                           , [Direction]
                                                                )
        , [Direction]
        , [Level]
        , [Nation_fk]
        , [Location]
        , [Religion_fk]
        , [Religion]
        , [NUM_Migrants]    = ROUND(([N_Migrants])                    , 0)
        , [PCT_Migrants]    = ROUND(([N_Migrants]/[TOT_Migrants])*100 , 1)
        , [TOT_Migrants]
        , [RawN_Migrants]   =                       [N_Migrants]
        , [NUM_Migrants_ds] = ISNULL(Mds, STR(ROUND([N_Migrants], -4)))
        , [PCT_Migrants_ds] = CASE
         WHEN [Religion_fk] = 52
             THEN             CAST(ROUND(([N_Migrants]/[TOT_Migrants])*100 , 1) AS VARCHAR(MAX))
             ELSE ISNULL(Pds, CAST(ROUND(([N_Migrants]/[TOT_Migrants])*100 , 1) AS VARCHAR(MAX)))   END
----------------------------------------------------------------------------------------------------------------------------
INTO            [forum_ResAnal].[dbo].[vi_Migrants]
----------------------------------------------------------------------------------------------------------------------------
-- select *
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT 
       DISTINCT
       [Direction]    = 'From'
      ,[Level]        = CASE 
                        WHEN [C_Orig_fk] < 999
                        THEN 'Countries'
                        WHEN [C_Orig_fk] < 10000
                        THEN 'Regions'
                        ELSE 'World'
                        END 
      ,[Nation_fk]    = [C_Orig_fk]
      ,[Location]     = CASE 
                        WHEN [C_Orig_fk] < 999
                        THEN [C_Origin]
                        ELSE [R_Origin]
                        END 
      ,[Religion_fk]
      ,[Religion]
      ,[N_Migrants]   = (SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk], [Religion_fk]))
      ,[TOT_Migrants] = (SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk]               ))/2  /* total+rels duplicates */
  FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
       [R_Origin] != ' Any Other Region'    ) MYD2
----------------------------------------------------------------------------------------------------------------------------
			-- QUERY 2
			-- Total emigrants FROM a country:
			   --      NO FILTER

			-- QUERY 4
			-- Religious breakdown of emigrant population FROM a country:
			   --      NO FILTER BY COUNTRY
			   --      NO FILTER BY RELIGION
----------------------------------------------------------------------------------------------------------------------------
UNION ALL
----------------------------------------------------------------------------------------------------------------------------
SELECT 
       DISTINCT
       [Direction]    = 'To'
      ,[Level]        = CASE 
                        WHEN [C_Dest_fk] < 999
                        THEN 'Countries'
                        WHEN [C_Dest_fk] < 10000
                        THEN 'Regions'
                        ELSE 'World'
                        END 
      ,[Nation_fk]    = [C_Dest_fk]
      ,[Location]     = CASE 
                        WHEN [C_Dest_fk] < 999
                        THEN [C_Destination]
                        ELSE [R_Destination]
                        END 
      ,[Religion_fk]
      ,[Religion]
      ,[N_Migrants]   = (SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk], [Religion_fk]))
      ,[TOT_Migrants] = (SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk]               ))/2  /* total+rels duplicates */
  FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
       [R_Destination] != ' Any Other Region'    ) MYD1
----------------------------------------------------------------------------------------------------------------------------
			-- QUERY 1
			-- Total immigrants TO a country:
			   --      NO FILTER

			-- QUERY 3
			-- Religious breakdown of immigrant population TO a country:
				--     NO FILTER BY COUNTRY
				--     Displ_by_Rel    =   1
WHERE     [Displ_by_Rel]  = 1
----------------------------------------------------------------------------------------------------------------------------
) AS TO_AND_FROM
----------------------------------------------------------------------------------------------------------------------------
/* -- >> ADD rounding rules for percentage to display in varchar field -------------------------------------------------- */
LEFT JOIN (SELECT  [Pds] = [Display_text]
                 , [Th]  = [Threshold]
                 , [Pt]  = [Point]
           FROM
           [forum].[dbo].[Pew_Thresholds]  /* [vi_Thresholds] is created in vi25, after vi03 */
           WHERE [Datatype]='Percentage') P  
           ON ((([N_Migrants]/[TOT_Migrants])*100) < P.[Th] and P.[Pt] = 'minimum' )
           OR ((([N_Migrants]/[TOT_Migrants])*100) > P.[Th] and P.[Pt] = 'maximum' )
/* -- << ADD rounding rules for percentage to display in varchar field -------------------------------------------------- */
/* -- >> ADD rounding rules for migrant count to display in varchar field ----------------------------------------------- */
LEFT JOIN (SELECT  [Mds] = [Display_text]
                 , [Th]  = [Threshold]
                 , [Pt]  = [Point]
           FROM
           [forum].[dbo].[Pew_Thresholds]  /* [vi_Thresholds] is created in vi25, after vi03 */
           WHERE [Datatype]='Population') M
           ON ( [N_Migrants]                      < M.[Th] and M.[Pt] = 'minimum' )
/* -- << ADD rounding rules for migrant count to display in varchar field ----------------------------------------------- */
-- Exclude denominator as zero:
WHERE     [TOT_Migrants] != 0
--and      [Religion_fk] != 52
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/**************************************************************************************************************************/
go