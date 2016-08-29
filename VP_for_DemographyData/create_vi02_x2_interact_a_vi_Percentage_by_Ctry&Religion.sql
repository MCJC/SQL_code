/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [forum_ResAnal]..[vi_int_Percentage_by_Ctry&Religion]                                  <<<<<     ***/
/***             NOTE:  The view is based on the fixed table [forum_ResAnal]..[vi_AgeSexValuevi_AgeSexValue_15Yrs]                                           ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/**** database name specification [forum_ResAnal] because it is the default place for auxiliary fixed tables) **************************************************/
/***************************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
ALTER  VIEW
               [dbo].[vp_int_Percentage_by_Ctry&Religion]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [row_number]     = ROW_NUMBER()
                           OVER(ORDER BY
                                        [year]
                                      , [level]        DESC
                                      , [Nation_fk]          )
        , *

FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
 SELECT   
          [level]
        , [Nation_fk]
        , [Year]
        , [Region]
        , [Country]
        --, [Population]      = CAST ( ROUND([Population], 0) AS DECIMAL (12,0) )
        , [Percentage]      = CAST ( ROUND([Percentage], 1) AS DECIMAL ( 5,1) )
        , [Religion]
   FROM   [vi_AgeSexValue_15Yrs]
WHERE 
-----------------------------------------------------------------------------------------------------------------
          [Religion_fk]  IS NOT NULL
-----------------------------------------------------------------------------------------------------------------
  AND     [Sex_fk]       = 0
  AND     [Age_fk]       = 0
-----------------------------------------------------------------------------------------------------------------
  AND     [Year]         IN ( 2010, 2020, 2030, 2040, 2050 )
-----------------------------------------------------------------------------------------------------------------
AND       [NV_Display]   = 1
AND       [RV_Display]   = 1
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
) AS SelectedData
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
PIVOT (MAX([Percentage]) 
       FOR [Religion]
       IN (   [All Religions]
            , [Buddhists]
            , [Christians]
            , [Folk Religions]
            , [Hindus]
            , [Jews]
            , [Muslims]
            , [Other Religions]
            , [Unaffiliated]         )) AS ByReligion
/***************************************************************************************************************************************************************/
go