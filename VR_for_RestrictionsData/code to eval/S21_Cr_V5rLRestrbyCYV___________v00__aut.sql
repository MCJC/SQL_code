/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [for_x].[dbo].[V7r_LRestr_by_RV]                                                       <<<<<     ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [for_x]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
ALTER  VIEW
               [dbo].[V7r_LRestr_by_RV]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  Begining of select statement (values by country/year/question)  ******************************************************************************************/

/***************************************************************************************************************************************************************/
SELECT
          V5Row
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [Variable]
                           , [Value]
                                          )
        , Variable
        , Value
        , [NC_Americas_2007]                   =  STR(ISNULL(MAX([NC_Americas_2007]),0),12,0)
        , [PC_Americas_2007]                   =  STR(ISNULL(MAX([PC_Americas_2007]),0),3,0)+' %'
        , [NC_Americas_2008]                   =  STR(ISNULL(MAX([NC_Americas_2008]),0),12,0)
        , [PC_Americas_2008]                   =  STR(ISNULL(MAX([PC_Americas_2008]),0),3,0)+' %'
        , [NC_Americas_2009]                   =  STR(ISNULL(MAX([NC_Americas_2009]),0),12,0)
        , [PC_Americas_2009]                   =  STR(ISNULL(MAX([PC_Americas_2009]),0),3,0)+' %'
        , [NC_Americas_2010]                   =  STR(ISNULL(MAX([NC_Americas_2010]),0),12,0)
        , [PC_Americas_2010]                   =  STR(ISNULL(MAX([PC_Americas_2010]),0),3,0)+' %'
        , [NC_Americas_2011]                   =  STR(ISNULL(MAX([NC_Americas_2011]),0),12,0)
        , [PC_Americas_2011]                   =  STR(ISNULL(MAX([PC_Americas_2011]),0),3,0)+' %'
        , [NC_Americas_2012]                   =  STR(ISNULL(MAX([NC_Americas_2012]),0),12,0)
        , [PC_Americas_2012]                   =  STR(ISNULL(MAX([PC_Americas_2012]),0),3,0)+' %'
        , [NC_Asia-Pacific_2007]               =  STR(ISNULL(MAX([NC_Asia-Pacific_2007]),0),12,0)
        , [PC_Asia-Pacific_2007]               =  STR(ISNULL(MAX([PC_Asia-Pacific_2007]),0),3,0)+' %'
        , [NC_Asia-Pacific_2008]               =  STR(ISNULL(MAX([NC_Asia-Pacific_2008]),0),12,0)
        , [PC_Asia-Pacific_2008]               =  STR(ISNULL(MAX([PC_Asia-Pacific_2008]),0),3,0)+' %'
        , [NC_Asia-Pacific_2009]               =  STR(ISNULL(MAX([NC_Asia-Pacific_2009]),0),12,0)
        , [PC_Asia-Pacific_2009]               =  STR(ISNULL(MAX([PC_Asia-Pacific_2009]),0),3,0)+' %'
        , [NC_Asia-Pacific_2010]               =  STR(ISNULL(MAX([NC_Asia-Pacific_2010]),0),12,0)
        , [PC_Asia-Pacific_2010]               =  STR(ISNULL(MAX([PC_Asia-Pacific_2010]),0),3,0)+' %'
        , [NC_Asia-Pacific_2011]               =  STR(ISNULL(MAX([NC_Asia-Pacific_2011]),0),12,0)
        , [PC_Asia-Pacific_2011]               =  STR(ISNULL(MAX([PC_Asia-Pacific_2011]),0),3,0)+' %'
        , [NC_Asia-Pacific_2012]               =  STR(ISNULL(MAX([NC_Asia-Pacific_2012]),0),12,0)
        , [PC_Asia-Pacific_2012]               =  STR(ISNULL(MAX([PC_Asia-Pacific_2012]),0),3,0)+' %'
        , [NC_Europe_2007]                     =  STR(ISNULL(MAX([NC_Europe_2007]),0),12,0)
        , [PC_Europe_2007]                     =  STR(ISNULL(MAX([PC_Europe_2007]),0),3,0)+' %'
        , [NC_Europe_2008]                     =  STR(ISNULL(MAX([NC_Europe_2008]),0),12,0)
        , [PC_Europe_2008]                     =  STR(ISNULL(MAX([PC_Europe_2008]),0),3,0)+' %'
        , [NC_Europe_2009]                     =  STR(ISNULL(MAX([NC_Europe_2009]),0),12,0)
        , [PC_Europe_2009]                     =  STR(ISNULL(MAX([PC_Europe_2009]),0),3,0)+' %'
        , [NC_Europe_2010]                     =  STR(ISNULL(MAX([NC_Europe_2010]),0),12,0)
        , [PC_Europe_2010]                     =  STR(ISNULL(MAX([PC_Europe_2010]),0),3,0)+' %'
        , [NC_Europe_2011]                     =  STR(ISNULL(MAX([NC_Europe_2011]),0),12,0)
        , [PC_Europe_2011]                     =  STR(ISNULL(MAX([PC_Europe_2011]),0),3,0)+' %'
        , [NC_Europe_2012]                     =  STR(ISNULL(MAX([NC_Europe_2012]),0),12,0)
        , [PC_Europe_2012]                     =  STR(ISNULL(MAX([PC_Europe_2012]),0),3,0)+' %'
        , [NC_Middle East-North Africa_2007]   =  STR(ISNULL(MAX([NC_Middle East-North Africa_2007]),0),12,0)
        , [PC_Middle East-North Africa_2007]   =  STR(ISNULL(MAX([PC_Middle East-North Africa_2007]),0),3,0)+' %'
        , [NC_Middle East-North Africa_2008]   =  STR(ISNULL(MAX([NC_Middle East-North Africa_2008]),0),12,0)
        , [PC_Middle East-North Africa_2008]   =  STR(ISNULL(MAX([PC_Middle East-North Africa_2008]),0),3,0)+' %'
        , [NC_Middle East-North Africa_2009]   =  STR(ISNULL(MAX([NC_Middle East-North Africa_2009]),0),12,0)
        , [PC_Middle East-North Africa_2009]   =  STR(ISNULL(MAX([PC_Middle East-North Africa_2009]),0),3,0)+' %'
        , [NC_Middle East-North Africa_2010]   =  STR(ISNULL(MAX([NC_Middle East-North Africa_2010]),0),12,0)
        , [PC_Middle East-North Africa_2010]   =  STR(ISNULL(MAX([PC_Middle East-North Africa_2010]),0),3,0)+' %'
        , [NC_Middle East-North Africa_2011]   =  STR(ISNULL(MAX([NC_Middle East-North Africa_2011]),0),12,0)
        , [PC_Middle East-North Africa_2011]   =  STR(ISNULL(MAX([PC_Middle East-North Africa_2011]),0),3,0)+' %'
        , [NC_Middle East-North Africa_2012]   =  STR(ISNULL(MAX([NC_Middle East-North Africa_2012]),0),12,0)
        , [PC_Middle East-North Africa_2012]   =  STR(ISNULL(MAX([PC_Middle East-North Africa_2012]),0),3,0)+' %'
        , [NC_Sub-Saharan Africa_2007]         =  STR(ISNULL(MAX([NC_Sub-Saharan Africa_2007]),0),12,0)
        , [PC_Sub-Saharan Africa_2007]         =  STR(ISNULL(MAX([PC_Sub-Saharan Africa_2007]),0),3,0)+' %'
        , [NC_Sub-Saharan Africa_2008]         =  STR(ISNULL(MAX([NC_Sub-Saharan Africa_2008]),0),12,0)
        , [PC_Sub-Saharan Africa_2008]         =  STR(ISNULL(MAX([PC_Sub-Saharan Africa_2008]),0),3,0)+' %'
        , [NC_Sub-Saharan Africa_2009]         =  STR(ISNULL(MAX([NC_Sub-Saharan Africa_2009]),0),12,0)
        , [PC_Sub-Saharan Africa_2009]         =  STR(ISNULL(MAX([PC_Sub-Saharan Africa_2009]),0),3,0)+' %'
        , [NC_Sub-Saharan Africa_2010]         =  STR(ISNULL(MAX([NC_Sub-Saharan Africa_2010]),0),12,0)
        , [PC_Sub-Saharan Africa_2010]         =  STR(ISNULL(MAX([PC_Sub-Saharan Africa_2010]),0),3,0)+' %'
        , [NC_Sub-Saharan Africa_2011]         =  STR(ISNULL(MAX([NC_Sub-Saharan Africa_2011]),0),12,0)
        , [PC_Sub-Saharan Africa_2011]         =  STR(ISNULL(MAX([PC_Sub-Saharan Africa_2011]),0),3,0)+' %'
        , [NC_Sub-Saharan Africa_2012]         =  STR(ISNULL(MAX([NC_Sub-Saharan Africa_2012]),0),12,0)
        , [PC_Sub-Saharan Africa_2012]         =  STR(ISNULL(MAX([PC_Sub-Saharan Africa_2012]),0),3,0)+' %'
FROM
(
/*** AggrEgate view by C/Y/Q/A *********************************************************************************************************************************/
SELECT
       [RYCNT]     = 'NC_' + [RegionYr]
      ,[RYPCT]     = 'PC_' + [RegionYr]
      ,[Variable]
      ,[Value]
      ,Number      = SUM([CntWg])
      ,Percentage  = SUM([PctWg])
  FROM
/***************************************************************************************************************************************************************/
(
/*** >>> recode for total events (only GRI_19 is currently working) ********************************************************************************************/
/***************************************************************************************************************************************************************/
SELECT 
       [RegionYr]
      ,[Variable]
      ,[Value]
               = CASE
                 WHEN [Variable] = 'GRI_19_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'GRI_19_x'
                  AND [Value]    = 0
                 THEN              NULL
                 WHEN [Variable] = 'SHI_01_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'SHI_01_x'
                  AND [Value]    = 0
                 THEN              NULL
                 WHEN [Variable] = 'SHI_04_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'SHI_04_x'
                  AND [Value]    = 0
                 THEN              NULL
                 WHEN [Variable] = 'SHI_05_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'SHI_05_x'
                  AND [Value]    = 0
                 THEN              NULL
                 ELSE [Value]
                 END
      ,[PctWg]
               = CASE
                 WHEN [Variable] = 'GRI_19_x'
                 THEN              NULL
                 WHEN [Variable] = 'SHI_01_x'
                 THEN              NULL
                 WHEN [Variable] = 'SHI_04_x'
                 THEN              NULL
                 WHEN [Variable] = 'SHI_05_x'
                 THEN              NULL
                 ELSE [PctWg]
                 END
      ,[CntWg]
               = CASE
                 WHEN [Variable] = 'GRI_19_x'
                 THEN [Value]
                 WHEN [Variable] = 'SHI_01_x'
                 THEN [Value]
                 WHEN [Variable] = 'SHI_04_x'
                 THEN [Value]
                 WHEN [Variable] = 'SHI_05_x'
                 THEN [Value]
                 ELSE [CntWg]
                 END
  FROM 
       [for_x].[dbo].[V4r_L_by_RYV]
    WHERE                                                                       /*** begining of filters to be applied...                                    ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'CSR%'                                           /*** filter to exclude CSR questions                                         ***/
    AND                                                                         /*** second filter to be applied...                                          ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'ERI%'                                           /*** filter to exclude ERI questions                                         ***/
    AND                                                                         /*** third filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'IEI%'                                           /*** filter to exclude IEI questions                                         ***/
    AND                                                                         /*** fourth filter to be applied...                                          ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'PPR%'                                           /*** filter to exclude PPR questions                                         ***/
    AND                                                                         /*** ficth filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'RIR%'                                           /*** filter to exclude RIR questions                                         ***/
/*** <<< recode for total events *******************************************************************************************************************************/
)                                                                                                                                                      AS    RTE
/***************************************************************************************************************************************************************/
GROUP BY
       [RegionYr]
      ,[Variable]
      ,[Value]
--ORDER BY
--       [YEAR]
--      ,[Variable]
--      ,[Value]
/********************************************************************************************************************************* Aggregate view by C/Y/Q/A ***/
)                                                                                                                                                      AS A_CYQA
/*** pivoting percentage ***************************************************************************************************************************************/
PIVOT
 (
     MAX(Percentage)
FOR
     RYPCT
in (
        [PC_Americas_2007]
      , [PC_Americas_2008]
      , [PC_Americas_2009]
      , [PC_Americas_2010]
      , [PC_Americas_2011]
      , [PC_Americas_2012]
      , [PC_Asia-Pacific_2007]
      , [PC_Asia-Pacific_2008]
      , [PC_Asia-Pacific_2009]
      , [PC_Asia-Pacific_2010]
      , [PC_Asia-Pacific_2011]
      , [PC_Asia-Pacific_2012]
      , [PC_Europe_2007]
      , [PC_Europe_2008]
      , [PC_Europe_2009]
      , [PC_Europe_2010]
      , [PC_Europe_2011]
      , [PC_Europe_2012]
      , [PC_Middle East-North Africa_2007]
      , [PC_Middle East-North Africa_2008]
      , [PC_Middle East-North Africa_2009]
      , [PC_Middle East-North Africa_2010]
      , [PC_Middle East-North Africa_2011]
      , [PC_Middle East-North Africa_2012]
      , [PC_Sub-Saharan Africa_2007]
      , [PC_Sub-Saharan Africa_2008]
      , [PC_Sub-Saharan Africa_2009]
      , [PC_Sub-Saharan Africa_2010]
      , [PC_Sub-Saharan Africa_2011]
      , [PC_Sub-Saharan Africa_2012]
/***************************************************************************************************************************************************************/
                         )                                                      /*** end of listing of variables                                             ***/
 )                                                                                                                                                    AS   pivt1
/*************************************************************************************************************************************** pivoting percentage ***/
/*** pivoting counts *******************************************************************************************************************************************/
PIVOT
 (
     MAX(Number)
FOR
     RYCNT
in (
        [NC_Americas_2007]
      , [NC_Americas_2008]
      , [NC_Americas_2009]
      , [NC_Americas_2010]
      , [NC_Americas_2011]
      , [NC_Americas_2012]
      , [NC_Asia-Pacific_2007]
      , [NC_Asia-Pacific_2008]
      , [NC_Asia-Pacific_2009]
      , [NC_Asia-Pacific_2010]
      , [NC_Asia-Pacific_2011]
      , [NC_Asia-Pacific_2012]
      , [NC_Europe_2007]
      , [NC_Europe_2008]
      , [NC_Europe_2009]
      , [NC_Europe_2010]
      , [NC_Europe_2011]
      , [NC_Europe_2012]
      , [NC_Middle East-North Africa_2007]
      , [NC_Middle East-North Africa_2008]
      , [NC_Middle East-North Africa_2009]
      , [NC_Middle East-North Africa_2010]
      , [NC_Middle East-North Africa_2011]
      , [NC_Middle East-North Africa_2012]
      , [NC_Sub-Saharan Africa_2007]
      , [NC_Sub-Saharan Africa_2008]
      , [NC_Sub-Saharan Africa_2009]
      , [NC_Sub-Saharan Africa_2010]
      , [NC_Sub-Saharan Africa_2011]
      , [NC_Sub-Saharan Africa_2012]
/***************************************************************************************************************************************************************/
                         )                                                      /*** end of listing of variables                                             ***/
 )                                                                                                                                                    AS   pivt2
/******************************************************************************************************************************************* pivoting counts ***/

GROUP BY
          Variable
        , Value


--ORDER BY
--       [Variable]
--      ,[Value]
