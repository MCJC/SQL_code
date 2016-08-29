/* ++> create_vi03a_vi_Migrants_basic.sql <++ */
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the table [forum_ResAnal]..[vi_Migrants_basic]                                                  <<<<<     ***/
/***             NOTE:  This is a fixed table hosted at the default place for auxiliary fixed tables: [forum_ResAnal]                                        ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                                                                                *****/
/*****                                              Step by Step: STEP 2                                              *****/
/*****                                                                                                                *****/
/**************************************************************************************************************************/
/**** database name specification for data sources (once) *****************************************************************/
----------------------------------------------------------------------------------------------------------------------------
USE              [forum]
GO
----------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID (N'[forum_ResAnal].[dbo].[vi_Migrants_basic]', N'U') IS NOT NULL
DROP   TABLE    [forum_ResAnal].[dbo].[vi_Migrants_basic]                                     -- drop table if existent

/*** PREPARE TEMPORARY TABLES *********************************************************************************************/
IF OBJECT_ID('tempdb..#MAIN') IS NOT NULL
DROP TABLE            #MAIN                                 -- drop temporary table if existent
IF OBJECT_ID('tempdb..#AGGR') IS NOT NULL
DROP TABLE            #AGGR                                 -- drop temporary table if existent
IF OBJECT_ID('tempdb..#ByRE') IS NOT NULL
DROP TABLE            #ByRE                                 -- drop temporary table if existent
IF OBJECT_ID('tempdb..#RORIG') IS NOT NULL
DROP TABLE            #RORIG                                -- drop temporary table if existent
IF OBJECT_ID('tempdb..#RDEST') IS NOT NULL
DROP TABLE            #RDEST                                -- drop temporary table if existent
IF OBJECT_ID('tempdb..#ByWRLD') IS NOT NULL
DROP TABLE            #ByWRLD                                -- drop temporary table if existent

/*** 1. All Migration Stock by Country/Religion ***************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          C_Orig_fk
        , C_Origin
        , R_Origin
        , C_Dest_fk
        , C_Destination
        , R_Destination
        , Religion_fk
        , Religion
        , RawN_Migrants   =                  SUM(RawN_Migrants)
        , DataQuality
        , Displ_by_Rel
        , Displ_asDest
        , Displ_asOrig
----------------------------------------------------------------------------------------------------------------------------
INTO #MAIN
----------------------------------------------------------------------------------------------------------------------------
FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          C_Orig_fk       =                  M.origin_nation_fk
        , C_Origin        =                 N1.Ctry_EditorialName
        , R_Origin        =                 N1.SubRegion6
        , C_Dest_fk       =                  M.destination_nation_fk
        , C_Destination   =                 N2.Ctry_EditorialName
        , R_Destination   =                 N2.SubRegion6
        , Religion_fk     =  CASE
                             WHEN R.Pew_RelL02_display = 'Christians'  THEN 51 -- hard coded, table will not change
                             ELSE R.Religion_group_pk
                             END
        , Religion        =                  R.Pew_RelL02_display
        , RawN_Migrants   =                  M.migrant_count
        , DataQuality     =                  D.Data_quality_level_fk
        , Displ_by_Rel    =                  M.Display_by_Religion
        , Displ_asDest    =                  M.Display_as_Destination_Ctry
        , Displ_asOrig    =                  M.Display_as_Origin_Ctry
----------------------------------------------------------------------------------------------------------------------------
FROM      [Pew_Migration]             M
LEFT JOIN [Pew_Nation]                N1 ON  M.origin_nation_fk      = N1.Nation_pk
LEFT JOIN [Pew_Nation]                N2 ON  M.destination_nation_fk = N2.Nation_pk
LEFT JOIN [Pew_Religion_Group]         R ON  M.pew_religion_group_fk =  R.Religion_group_pk
LEFT JOIN [Pew_Migration_Data_Source]  D ON N1.Nation_pk             =  D.Origin_nation_fk
                                        AND N2.Nation_pk             =  D.Destination_nation_fk
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
)                                                                                                                 UNGROUPPED
----------------------------------------------------------------------------------------------------------------------------
GROUP BY
          C_Orig_fk
        , C_Origin
        , R_Origin
        , C_Dest_fk
        , C_Destination
        , R_Destination
        , Religion_fk
        , Religion
        , DataQuality
        , Displ_by_Rel
        , Displ_asDest
        , Displ_asOrig
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/

/*** 2. All Migration Stock by Country ************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          C_Orig_fk
        , C_Origin
        , R_Origin
        , C_Dest_fk
        , C_Destination
        , R_Destination
        , Religion_fk     =                   52             -- hard coded, table will not change
        , Religion        =                  'All Religions'
        , RawN_Migrants   =                  SUM(RawN_Migrants)
        , DataQuality     =                  MIN(DataQuality)
        , Displ_by_Rel    =                  1
        , Displ_asDest    =                  MIN(Displ_asDest)
        , Displ_asOrig    =                  MIN(Displ_asOrig)
----------------------------------------------------------------------------------------------------------------------------
INTO      #AGGR
----------------------------------------------------------------------------------------------------------------------------
FROM      #MAIN
----------------------------------------------------------------------------------------------------------------------------
GROUP BY
          C_Orig_fk
        , C_Origin
        , R_Origin
        , C_Dest_fk
        , C_Destination
        , R_Destination
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/

------/*** 3. Migration Stock aggregated by regions *****************************************************************************/
------this will not be used
----------------------------------------------------------------------------------------------------------------------------------
------SELECT
----------------------------------------------------------------------------------------------------------------------------------
------          C_Orig_fk       =  CASE
------                             WHEN R_Origin = 'North America'             THEN 1001
------                             WHEN R_Origin = 'Latin America-Caribbean'   THEN 1002
------                             WHEN R_Origin = 'Europe'                    THEN 1003
------                             WHEN R_Origin = 'Middle East-North Africa'  THEN 1004
------                             WHEN R_Origin = 'Sub-Saharan Africa'        THEN 1005
------                             WHEN R_Origin = 'Asia-Pacific'              THEN 1006
------                             END
------        , C_Origin        = ' All Countries'
------        , R_Origin
------        , C_Dest_fk       =  CASE
------                             WHEN R_Destination = 'North America'             THEN 1001
------                             WHEN R_Destination = 'Latin America-Caribbean'   THEN 1002
------                             WHEN R_Destination = 'Europe'                    THEN 1003
------                             WHEN R_Destination = 'Middle East-North Africa'  THEN 1004
------                             WHEN R_Destination = 'Sub-Saharan Africa'        THEN 1005
------                             WHEN R_Destination = 'Asia-Pacific'              THEN 1006
------                             END
------        , C_Destination   = ' All Countries'
------        , R_Destination
------        , Religion_fk
------        , Religion
------        , RawN_Migrants   =                  SUM(RawN_Migrants)
------        , DataQuality     =                  MIN(DataQuality)
------        , Displ_by_Rel    =                  1
------        , Displ_asDest    =                  1
------        , Displ_asOrig    =                  1
----------------------------------------------------------------------------------------------------------------------------------
--------INTO      #ByRE
----------------------------------------------------------------------------------------------------------------------------------
------FROM
------(           SELECT * FROM #MAIN
------  UNION ALL SELECT * FROM #AGGR )       MA
----------------------------------------------------------------------------------------------------------------------------------
------WHERE
------          R_Origin
------       != R_Destination
----------------------------------------------------------------------------------------------------------------------------------
------GROUP BY
------          R_Origin
------        , R_Destination
------        , Religion_fk
------        , Religion
----------------------------------------------------------------------------------------------------------------------------------
------/**************************************************************************************************************************/
------GO
------/**************************************************************************************************************************/
------/**************************************************************************************************************************/

/*** 4. Migration Stock aggregated by region of origin ********************************************************************/
----------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          C_Orig_fk       =  CASE
                             WHEN R_Origin = 'North America'             THEN 1001
                             WHEN R_Origin = 'Latin America-Caribbean'   THEN 1002
                             WHEN R_Origin = 'Europe'                    THEN 1003
                             WHEN R_Origin = 'Middle East-North Africa'  THEN 1004
                             WHEN R_Origin = 'Sub-Saharan Africa'        THEN 1005
                             WHEN R_Origin = 'Asia-Pacific'              THEN 1006
                             END
        , C_Origin        = ' All Countries'
        , R_Origin
        , C_Dest_fk       =  10000
        , C_Destination   = ' Any Country in Other Region'
        , R_Destination   = ' Any Other Region'
        , Religion_fk
        , Religion
        , RawN_Migrants   =                  SUM(RawN_Migrants)
        , DataQuality     =                  MIN(DataQuality)
        , Displ_by_Rel    =                  1
        , Displ_asDest    =                  1
        , Displ_asOrig    =                  1
----------------------------------------------------------------------------------------------------------------------------
INTO      #RORIG
----------------------------------------------------------------------------------------------------------------------------
FROM
(           SELECT * FROM #MAIN
  UNION ALL SELECT * FROM #AGGR )       MA
----------------------------------------------------------------------------------------------------------------------------
WHERE
          R_Origin
       != R_Destination
----------------------------------------------------------------------------------------------------------------------------
GROUP BY
          R_Origin
        , Religion_fk
        , Religion
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/

/*** 5. Migration Stock aggregated by region of destination ***************************************************************/
----------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          C_Orig_fk       =  10000
        , C_Origin        = ' Any Country in Other Region'
        , R_Origin        = ' Any Other Region'
        , C_Dest_fk       =  CASE
                             WHEN R_Destination = 'North America'             THEN 1001
                             WHEN R_Destination = 'Latin America-Caribbean'   THEN 1002
                             WHEN R_Destination = 'Europe'                    THEN 1003
                             WHEN R_Destination = 'Middle East-North Africa'  THEN 1004
                             WHEN R_Destination = 'Sub-Saharan Africa'        THEN 1005
                             WHEN R_Destination = 'Asia-Pacific'              THEN 1006
                             END
        , C_Destination   = ' All Countries'
        , R_Destination
        , Religion_fk
        , Religion
        , RawN_Migrants   =                  SUM(RawN_Migrants)
        , DataQuality     =                  MIN(DataQuality)
        , Displ_by_Rel    =                  1
        , Displ_asDest    =                  1
        , Displ_asOrig    =                  1
----------------------------------------------------------------------------------------------------------------------------
INTO      #RDEST
----------------------------------------------------------------------------------------------------------------------------
FROM
(           SELECT * FROM #MAIN
  UNION ALL SELECT * FROM #AGGR )       MA
----------------------------------------------------------------------------------------------------------------------------
WHERE
          R_Origin
       != R_Destination
----------------------------------------------------------------------------------------------------------------------------
GROUP BY
          R_Destination
        , Religion_fk
        , Religion
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/

/*** 6. Migration Stock globally aggregated *******************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          C_Orig_fk       =  10000
        , C_Origin        = ' All Countries'
        , R_Origin        = ' World'
        , C_Dest_fk       =  10000
        , C_Destination   = ' All Countries'
        , R_Destination   = ' World'
        , Religion_fk
        , Religion
        , RawN_Migrants   =                  SUM(RawN_Migrants)
        , DataQuality     =                  MIN(DataQuality)
        , Displ_by_Rel    =                  1
        , Displ_asDest    =                  1
        , Displ_asOrig    =                  1
----------------------------------------------------------------------------------------------------------------------------
INTO      #ByWRLD
----------------------------------------------------------------------------------------------------------------------------
FROM
(           SELECT * FROM #MAIN
  UNION ALL SELECT * FROM #AGGR )       MA
----------------------------------------------------------------------------------------------------------------------------
GROUP BY
          Religion_fk
        , Religion
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/


/*** 7. steps 1 - 6 merged together ***************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          [Mv_row]        =  ROW_NUMBER()OVER(ORDER BY
                                             C_Orig_fk
                                           , C_Dest_fk
                                           , Religion_fk   
                                                           )
        , [C_Orig_fk]
        , [C_Origin]
        , [R_Origin]
        , [C_Dest_fk]
        , [C_Destination]
        , [R_Destination]
        , [Religion_fk]   = CASE
                            WHEN [Religion]    = 'Muslims'   THEN 23
                            WHEN [Religion]    = 'Buddhists' THEN 26
                            WHEN [Religion]    = 'Hindus'    THEN 27
                            WHEN [Religion]    = 'Jews'      THEN 28
                            ELSE [Religion_fk]
                            END
        , [Religion]
        , [RawN_Migrants]
        , [DataQuality]
        , [Displ_by_Rel]
        , [Displ_asDest]
        , [Displ_asOrig]
----------------------------------------------------------------------------------------------------------------------------
INTO            [forum_ResAnal].[dbo].[vi_Migrants_basic]
----------------------------------------------------------------------------------------------------------------------------
FROM
----------------------------------------------------------------------------------------------------------------------------
(            SELECT * FROM #MAIN
   UNION ALL SELECT * FROM #AGGR
   ----UNION ALL SELECT * FROM #ByRE
   UNION ALL SELECT * FROM #RORIG
   UNION ALL SELECT * FROM #RDEST
   UNION ALL SELECT * FROM #ByWRLD    )       A1TO6
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/
