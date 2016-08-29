/* ++> create_vi12a_vi_Restrictions_Index_by_CtryRegion&Yr.sql <++ */
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [forum]..[vi_Restrictions_Index_by_CtryRegion&Yr]                                      <<<<<     ***/
/***                                                                                                                                                         ***/
/***     NOTES:                                                                                                                                              ***/
/***           Current Indexes are calculated and stored at [forum_ResAnal].[dbo].[vrc_04_R&H_Index_by_CtryRegion&Yr]                                        ***/
/***                                                                                                                                                         ***/
/***        -----------------------------------------------------------------------------------------------------------------------------------------        ***/
/***       |   WHILE FINAL DATA ARE READY use wrkg version: [forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]                                |       ***/
/***        -----------------------------------------------------------------------------------------------------------------------------------------        ***/
/***                                                                                                                                                         ***/
/***           The table is NO LONGER created from Stata to replicate previously published figures (37 diff -0.021- found for data < 2012)                   ***/
/***                                                                                                                                                         ***/
/***     Median value for the world or for a region:                                                                                                         ***/
/***           The median is the numerical value separating the higher half from the lower half of the data (it can differ from the mean).                   ***/
/***           We find it by arranging all the observations from lowest value to highest value and picking the middle one.                                   ***/
/***           If there is an even number of observations, median is defined to be the mean of the two middle values.                                        ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [forum]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
ALTER  VIEW
               [dbo].[vi_Restrictions_Index_by_CtryRegion&Yr]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [RIYv_row]          =  ROW_NUMBER()
                                 OVER(ORDER BY
                                                [Year]
                                              , [level]              DESC
                                              , [Nation_fk]
                                              , [Index_abbreviation]       )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , [Year]
       , [level]
       , [SubRegion6_code]    = [Region6_code]
       , [Region]             = [Region6]
       , [Nation_fk]
       , [Ctry_EditorialName]
       , [Index_abbreviation]
       , [Index_name]
       , [Index_value]        = [I_Rounded_value]
       , [Index_level]
       , [Index_Year]
       , [ByRegion]           = [ByRegion6]
       , [ByWorld]
       , [ByWorld&Region]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
/*** country values and calculated median region & world values (from vr working tables)   *********************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]                         VR
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
     , (  SELECT DISTINCT
                 [Index_level]        = [Level]
                ,[Scaled_Level_value]
            FROM [forum].[dbo].[Pew_Index_Cut_Points] )                                  CP
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/********************************************************************* country values and calculated median region & world values (from vr working tables)   ***/
WHERE  
       [I_Scaled_value]
     = [Scaled_Level_value]
  AND  [Index_abbreviation] IN ('GRI' , 'SHI')
  AND  [level]              !=  2.5
--AND  [YEAR]                <  2013
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
GO