/* ++> create_vi03c_vi_Migrants_by_Ctry.sql <++ */
--USE [forum]
--GO
--/**************************************************************************************************************************/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--/**************************************************************************************************************************/
--ALTER  VIEW
--                        [dbo].[vi_Migrants_by_Ctry]
--AS
------------------------------------------------------------------------------------------------------------------------------
--SELECT
--       *
--  FROM
--        [forum_ResAnal].[dbo].[vi_Migrants_by_Ctry]
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/***                                                                                                                    ***/
/***                                                                                                                    ***/
/***     >>>>>   This is the script used to create the view          [forum]..[vi_Migrants_by_Ctry]           <<<<<     ***/
/***     >>>>>   This is the script used to create the table [forum_ResAnal]..[vi_Migrants_by_Ctry]           <<<<<     ***/
/***             NOTE:  This is a fixed table hosted at the default place for auxiliary fixed tables: [forum_ResAnal]   ***/
/***                                                                                                                    ***/
/**************************************************************************************************************************/
/**** database name specification for data sources (once) *****************************************************************/
----------------------------------------------------------------------------------------------------------------------------
USE              [forum]
GO
----------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID (N'[forum_ResAnal].[dbo].[vi_Migrants_by_Ctry]', N'U') IS NOT NULL
DROP   TABLE    [forum_ResAnal].[dbo].[vi_Migrants_by_Ctry]                                     -- drop table if existent
/**************************************************************************************************************************/
SELECT
          [MbC_row]       =  ROW_NUMBER()OVER(ORDER BY
                                             [Level]       DESC
                                           , [Nation_fk]
                                           , [Religion_fk]
                                           , [Direction]
                                           , [SortBySet]        )
      ,[SortBySet]
      ,[Direction]
      ,[Level]
      ,[Nation_fk]
      ,[Location]
      ,[Religion_fk]
      ,[Religion]
      ,[TopClass]
      ,[NUM_Migrants]
      ,[PCT_Migrants]
      ,[TOT_Migrants]
      ,[RawNMigrants]
      ,[NUM_Migrants_ds]    = ISNULL(Mds, STR(ROUND([NUM_Migrants], -4)))
      ,[PCT_Migrants_ds]    = CASE
  WHEN [TopClass]           = 'Total' THEN CAST([PCT_Migrants] AS VARCHAR(MAX))
                         ELSE ISNULL(Pds,  CAST([PCT_Migrants] AS VARCHAR(MAX)))   END
----------------------------------------------------------------------------------------------------------------------------
INTO      [forum_ResAnal].[dbo].[vi_Migrants_by_Ctry]
----------------------------------------------------------------------------------------------------------------------------
-- select * 
FROM       
/**************************************************************************************************************************/
(
/*** SETS for excluding just totals ***************************************************************************************/
SELECT 
       [x] = sum(1) OVER(PARTITION BY   [Direction]
                                       ,[Nation_fk]
                                       ,[Religion_fk] )
      , *
FROM
/*** ALL SETS *************************************************************************************************************/
(
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/
/*** TOTAL "from": ********************************************************************************************************/
SELECT 
       DISTINCT
       [SortBySet]    =  0
      ,[Direction]    = 'From'
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
      ,[TopClass]     = 'Total'
      ,[NUM_Migrants] = ROUND((SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk], [Religion_fk])), 0)
      ,[PCT_Migrants] = 100
      ,[TOT_Migrants] =        SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk], [Religion_fk])
      ,[RawNMigrants] =        SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk], [Religion_fk])
  FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
       [R_Origin] != ' Any Other Region'    ) MYD1
----------------------------------------------------------------------------------------------------------------------------
			-- QUERY 2
			-- Total emigrants FROM a country:
			   --      NO FILTER
			-- QUERY 4
			-- Religious breakdown of emigrant population FROM a country:
			   --      NO FILTER BY COUNTRY
			   --      NO FILTER BY RELIGION
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/**************************************************************************************************************************/
UNION ALL
/**************************************************************************************************************************/
/*** TOTAL "to": **********************************************************************************************************/
SELECT 
       DISTINCT
       [SortBySet]    =  0
      ,[Direction]    = 'To'
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
      ,[TopClass]     = 'Total'
      ,[NUM_Migrants] = ROUND((SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk], [Religion_fk])), 0)
      ,[PCT_Migrants] = 100
      ,[TOT_Migrants] =        SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk], [Religion_fk])
      ,[RawNMigrants] =        SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk], [Religion_fk])
  FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
       [R_Destination] != ' Any Other Region'    ) MYD2
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
/**************************************************************************************************************************/
/**************************************************************************************************************************/
UNION ALL
/**************************************************************************************************************************/
/*** TOP 10 "from": all religions by each religion & all together, by country *********************************************/
SELECT
       [SortBySet]
      ,[Direction]
      ,[Level]
      ,[Nation_fk]
      ,[Location]
      ,[Religion_fk]
      ,[Religion]
	  ,[TopClass]
      ,[NUM_Migrants]
      ,[PCT_Migrants]
      ,[TOT_Migrants]
      ,[RawNMigrants]
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT
       [SortBySet]    =  ROW_NUMBER()OVER
                                    (PARTITION BY [Nation_fk], [Religion_fk]
                                     ORDER BY     [Nation_fk], [Religion_fk], [RawNMigrants] DESC )
      ,*
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT 
       [Direction]    = 'From'
      ,[Level]        = 'Countries'
      ,[Nation_fk]    = [C_Orig_fk]
      ,[Location]     = [C_Origin]
      ,[Religion_fk]
      ,[Religion]
      ,[TopClass]     = [C_Destination]
      ,[NUM_Migrants] =                ROUND(       ([RawN_Migrants])                                                  , 0)
      ,[PCT_Migrants] = CASE
                        WHEN                     SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk], [Religion_fk])   != 0
                        THEN           ROUND( 100 * ([RawN_Migrants]
                                             / ( SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk], [Religion_fk]) )) , 1)
                        END
      ,[TOT_Migrants] =                          SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk], [Religion_fk])
      ,[RawNMigrants] =                              [RawN_Migrants]
      ,[DataQuality]
      ,[Displ_by_Rel]
      ,[Displ_asDest]
      ,[Displ_asOrig]
----------------------------------------------------------------------------------------------------------------------------
  FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
        [C_Orig_fk] < 999                        ) MYD3
----------------------------------------------------------------------------------------------------------------------------
) CtrLocOrig
----------------------------------------------------------------------------------------------------------------------------
-- QUERY
-- Top 10 countries of destination for the religious breakdown of emigrant population FROM a country:
   --        filter by the country of origin:       Displ_asOrig    =   1
   -- D NOT  filter by the country of destination
   -- DO NOT filter by religion
   --        filter for DataQuality:                DataQuality    IN (7, 8, 9)
WHERE     [Displ_asOrig]  =   1
  AND     [DataQuality]   IN (7, 8, 9)
----------------------------------------------------------------------------------------------------------------------------
) SCtrLocOrig
----------------------------------------------------------------------------------------------------------------------------
WHERE     [SortBySet]    <= 10
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/**************************************************************************************************************************/
UNION ALL
/**************************************************************************************************************************/
/*** TOP 10 "to": all religions by each religion & all together, by country *********************************************/
SELECT
       [SortBySet]
      ,[Direction]
      ,[Level]
      ,[Nation_fk]
      ,[Location]
      ,[Religion_fk]
      ,[Religion]
	  ,[TopClass]
      ,[NUM_Migrants]
      ,[PCT_Migrants]
      ,[TOT_Migrants]
      ,[RawNMigrants]
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT
       [SortBySet]    =  ROW_NUMBER()OVER
                                    (PARTITION BY [Nation_fk], [Religion_fk]
                                     ORDER BY     [Nation_fk], [Religion_fk], [RawNMigrants] DESC )
      ,*
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT 
       [Direction]    = 'To'
      ,[Level]        = 'Countries'
      ,[Nation_fk]    = [C_Dest_fk]
      ,[Location]     = [C_Destination]
      ,[Religion_fk]
      ,[Religion]
      ,[TopClass]     = [C_Origin]
      ,[NUM_Migrants] =                ROUND(       ([RawN_Migrants])                                                  , 0)
      ,[PCT_Migrants] = CASE
                        WHEN                     SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk], [Religion_fk])   != 0
                        THEN           ROUND( 100 * ([RawN_Migrants]
                                             / ( SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk], [Religion_fk]) )) , 1)
                        END

      ,[TOT_Migrants] =                          SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk], [Religion_fk])
      ,[RawNMigrants] =                              [RawN_Migrants]
      ,[DataQuality]
      ,[Displ_by_Rel]
      ,[Displ_asDest]
      ,[Displ_asOrig]
----------------------------------------------------------------------------------------------------------------------------
  FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
        [C_Dest_fk] < 999                        ) MYD4
----------------------------------------------------------------------------------------------------------------------------
) CtrLocDest
----------------------------------------------------------------------------------------------------------------------------
-- QUERY
-- Top 10 countries of origin for the religious breakdown of immigrant population TO a country:
   -- DO NOT filter by the country of origin
   --        filter by the country of destination:  Displ_asDest    =   1
   --        filter by religion:                    Displ_by_Rel    =   1
   --        filter for DataQuality:                DataQuality    IN (7, 8, 9)
WHERE     [Displ_asDest]  = 1
  AND     [Displ_by_Rel]  = 1
  AND     [DataQuality]   IN (7, 8, 9)
----------------------------------------------------------------------------------------------------------------------------
) SCtrLocDest
----------------------------------------------------------------------------------------------------------------------------
WHERE     [SortBySet]    <= 10
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/**************************************************************************************************************************/
UNION ALL
/**************************************************************************************************************************/
/*** TOP 10 "from": all religions by each religion & all together, by region **********************************************/
SELECT
       [SortBySet]
      ,[Direction]
      ,[Level]
      ,[Nation_fk]
      ,[Location]
      ,[Religion_fk]
      ,[Religion]
	  ,[TopClass]
      ,[NUM_Migrants]
      ,[PCT_Migrants]
      ,[TOT_Migrants]
      ,[RawNMigrants]
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT
       [SortBySet]    =  ROW_NUMBER()OVER
                                    (PARTITION BY [Nation_fk], [Religion_fk]
                                     ORDER BY     [Nation_fk], [Religion_fk], [RawNMigrants] DESC )
      ,*
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT 
       DISTINCT
       [Direction]    = 'From'
      ,[Level]        = 'Regions'
      ,[Nation_fk]    =  CASE
                             WHEN R_Origin = 'North America'             THEN 1001
                             WHEN R_Origin = 'Latin America-Caribbean'   THEN 1002
                             WHEN R_Origin = 'Europe'                    THEN 1003
                             WHEN R_Origin = 'Middle East-North Africa'  THEN 1004
                             WHEN R_Origin = 'Sub-Saharan Africa'        THEN 1005
                             WHEN R_Origin = 'Asia-Pacific'              THEN 1006
                         END
      ,[Location]     = [R_Origin]
      ,[Religion_fk]
      ,[Religion]
      ,[TopClass]     = [C_Destination]
      ,[NUM_Migrants] = ROUND(    (  SUM([RawN_Migrants]) OVER(PARTITION BY [R_Origin],[C_Dest_fk],[Religion_fk]) ), 0)
      ,[PCT_Migrants] = ROUND(100*(  SUM([RawN_Migrants]) OVER(PARTITION BY [R_Origin],[C_Dest_fk],[Religion_fk])
                                   /(SUM([RawN_Migrants]) OVER(PARTITION BY [R_Origin],            [Religion_fk]))), 1)
      ,[TOT_Migrants] =              SUM([RawN_Migrants]) OVER(PARTITION BY [R_Origin],            [Religion_fk])
      ,[RawNMigrants] =              SUM([RawN_Migrants]) OVER(PARTITION BY [R_Origin],[C_Dest_fk],[Religion_fk])
----------------------------------------------------------------------------------------------------------------------------
  FROM
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
            [C_Orig_fk] < 999
        AND [R_Origin]
         != [R_Destination]                      ) MYD5
----------------------------------------------------------------------------------------------------------------------------
) RegLocOrig
----------------------------------------------------------------------------------------------------------------------------
-- QUERY
-- Top 10 countries of destination for the religious breakdown of emigrant population FROM a region:
   -- NO FILTERS
----------------------------------------------------------------------------------------------------------------------------
) SRegLocOrig
----------------------------------------------------------------------------------------------------------------------------
WHERE     [SortBySet]    <= 10
/**************************************************************************************************************************/
/**************************************************************************************************************************/
UNION ALL
/**************************************************************************************************************************/
/*** TOP 10 "to": all religions by each religion & all together, by region ************************************************/
SELECT
       [SortBySet]
      ,[Direction]
      ,[Level]
      ,[Nation_fk]
      ,[Location]
      ,[Religion_fk]
      ,[Religion]
	  ,[TopClass]
      ,[NUM_Migrants]
      ,[PCT_Migrants]
      ,[TOT_Migrants]
      ,[RawNMigrants]
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT
       [SortBySet]    =  ROW_NUMBER()OVER
                                    (PARTITION BY [Nation_fk], [Religion_fk]
                                     ORDER BY     [Nation_fk], [Religion_fk], [RawNMigrants] DESC )
      ,*
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT 
       DISTINCT
       [Direction]    = 'To'
      ,[Level]        = 'Regions'
      ,[Nation_fk]    =  CASE
                             WHEN R_Destination = 'North America'             THEN 1001
                             WHEN R_Destination = 'Latin America-Caribbean'   THEN 1002
                             WHEN R_Destination = 'Europe'                    THEN 1003
                             WHEN R_Destination = 'Middle East-North Africa'  THEN 1004
                             WHEN R_Destination = 'Sub-Saharan Africa'        THEN 1005
                             WHEN R_Destination = 'Asia-Pacific'              THEN 1006
                         END
      ,[Location]     = [R_Destination]
      ,[Religion_fk]
      ,[Religion]
      ,[TopClass]     = [C_Origin]
      ,[NUM_Migrants] = ROUND(    (  SUM([RawN_Migrants]) OVER(PARTITION BY [R_Destination],[C_Orig_fk],[Religion_fk]) ), 0)

      ,[PCT_Migrants] = ROUND(100*(  SUM([RawN_Migrants]) OVER(PARTITION BY [R_Destination],[C_Orig_fk],[Religion_fk])
                                   /(SUM([RawN_Migrants]) OVER(PARTITION BY [R_Destination],            [Religion_fk]))), 1)
      ,[TOT_Migrants] =              SUM([RawN_Migrants]) OVER(PARTITION BY [R_Destination],            [Religion_fk])
      ,[RawNMigrants] =              SUM([RawN_Migrants]) OVER(PARTITION BY [R_Destination],[C_Orig_fk],[Religion_fk])
----------------------------------------------------------------------------------------------------------------------------
  FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
            [C_Dest_fk] < 999
        AND [R_Origin]
         != [R_Destination]                      ) MYD6
----------------------------------------------------------------------------------------------------------------------------
) RegLocDest
----------------------------------------------------------------------------------------------------------------------------
-- QUERY
-- Top 10 countries of origin for the religious breakdown of immigrant population TO a region:
   -- NO FILTERS
----------------------------------------------------------------------------------------------------------------------------
) SRegLocDest
----------------------------------------------------------------------------------------------------------------------------
WHERE     [SortBySet]    <= 10
/**************************************************************************************************************************/
/**************************************************************************************************************************/
UNION ALL
/**************************************************************************************************************************/
/*** TOP 10 destination countries ("from" the world): all religions by each religion & all together ***********************/
SELECT
       *
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT
       [SortBySet]    =  ROW_NUMBER()OVER
                                    (PARTITION BY [Nation_fk], [Religion_fk]
                                     ORDER BY     [Nation_fk], [Religion_fk], [RawNMigrants] DESC )
      ,*
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT 
       DISTINCT
       [Direction]    = 'From'
      ,[Level]        = 'World'
      ,[Nation_fk]    =  10000
      ,[Location]     = ' World'
      ,[Religion_fk]
      ,[Religion]
      ,[TopClass]     = [C_Destination]
      ,[NUM_Migrants] = ROUND(    (  SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk],[Religion_fk]) ), 0)
      ,[PCT_Migrants] = ROUND(100*(  SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk],[Religion_fk])
                                   /(SUM([RawN_Migrants]) OVER(PARTITION BY             [Religion_fk]))), 1)
      ,[TOT_Migrants] =              SUM([RawN_Migrants]) OVER(PARTITION BY             [Religion_fk])
      ,[RawNMigrants] =              SUM([RawN_Migrants]) OVER(PARTITION BY [C_Dest_fk],[Religion_fk])
----------------------------------------------------------------------------------------------------------------------------
  FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
            [C_Orig_fk] < 999                    ) MYD7
----------------------------------------------------------------------------------------------------------------------------
) WorldOrig
----------------------------------------------------------------------------------------------------------------------------
-- QUERY
-- Top 10 countries of destination for the religious breakdown of all international migrants:
   -- NO FILTERS
----------------------------------------------------------------------------------------------------------------------------
) SWorldOrig
----------------------------------------------------------------------------------------------------------------------------
WHERE     [SortBySet]    <= 10
/**************************************************************************************************************************/
/**************************************************************************************************************************/
UNION ALL
/**************************************************************************************************************************/
/*** TOP 10 origin countries ("to" the world): all religions by each religion & all together ******************************/
SELECT
       *
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT
       [SortBySet]    =  ROW_NUMBER()OVER
                                    (PARTITION BY [Nation_fk], [Religion_fk]
                                     ORDER BY     [Nation_fk], [Religion_fk], [RawNMigrants] DESC )
      ,*
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT 
       DISTINCT
       [Direction]    = 'to'
      ,[Level]        = 'World'
      ,[Nation_fk]    =  10000
      ,[Location]     = ' World'
      ,[Religion_fk]
      ,[Religion]
      ,[TopClass]     = [C_Origin]

      ,[NUM_Migrants] = ROUND(    (  SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk],[Religion_fk]) ), 0)
      ,[PCT_Migrants] = ROUND(100*(  SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk],[Religion_fk])
                                   /(SUM([RawN_Migrants]) OVER(PARTITION BY             [Religion_fk]))), 1)
      ,[TOT_Migrants] =              SUM([RawN_Migrants]) OVER(PARTITION BY             [Religion_fk])
      ,[RawNMigrants] =              SUM([RawN_Migrants]) OVER(PARTITION BY [C_Orig_fk],[Religion_fk])
----------------------------------------------------------------------------------------------------------------------------
  FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT *
        FROM
       [forum_ResAnal].[dbo].[vi_Migrants_basic]
        WHERE
            [C_Dest_fk] < 999                    ) MYD8
----------------------------------------------------------------------------------------------------------------------------
) WorldDest
----------------------------------------------------------------------------------------------------------------------------
-- QUERY
-- Top 10 countries of destination for the religious breakdown of all international migrants:
   -- NO FILTERS
----------------------------------------------------------------------------------------------------------------------------
) SWorldDest
----------------------------------------------------------------------------------------------------------------------------
WHERE     [SortBySet]    <= 10
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
) ALLSETS
/**************************************************************************************************************************/
-- Exclude denominator as zero:
WHERE     [TOT_Migrants] != 0
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/**************************************************************************************************************************/
) SETSfortot
/**************************************************************************************************************************/
/* -- >> ADD rounding rules for percentage to display in varchar field -------------------------------------------------- */
LEFT JOIN (SELECT  [Pds] = [Display_text]
                 , [Th]  = [Threshold]
                 , [Pt]  = [Point]
           FROM
           [forum].[dbo].[Pew_Thresholds]  /* [vi_Thresholds] is created in vi25, after vi03 */
           WHERE [Datatype]='Percentage') P  ON ([PCT_Migrants] < P.[Th] and P.[Pt] = 'minimum' )
                                             OR ([PCT_Migrants] > P.[Th] and P.[Pt] = 'maximum' )
/* -- << ADD rounding rules for percentage to display in varchar field -------------------------------------------------- */
/* -- >> ADD rounding rules for migrant count to display in varchar field ----------------------------------------------- */
LEFT JOIN (SELECT  [Mds] = [Display_text]
                 , [Th]  = [Threshold]
                 , [Pt]  = [Point]
           FROM
           [forum].[dbo].[Pew_Thresholds]  /* [vi_Thresholds] is created in vi25, after vi03 */
           WHERE [Datatype]='Population') M  ON ([RawNMigrants] < M.[Th] and M.[Pt] = 'minimum' )
/* -- << ADD rounding rules for migrant count to display in varchar field ----------------------------------------------- */
WHERE     [x] > 1
/**************************************************************************************************************************/

go
