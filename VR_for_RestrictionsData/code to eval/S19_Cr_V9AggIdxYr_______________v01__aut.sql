/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [V9AggIdx_by_Yr]                                                                       <<<<<     ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
ALTER  VIEW
               [dbo].[V9_AggIdx_by_Yr]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*** Aggregate GRI view by Y ***********************************************************************************************************************************/
SELECT
       [Question_Year]
      ,INDX     =     'GRI'
      ,AVRG     = AVG([GRI])
      ,NCtries  = STR(SUM([CntWg]))
  FROM
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
SELECT 
       DISTINCT
       [Nation_fk]
      ,[GRI]
      ,[Question_Year]
      ,[CntWg]
  FROM 
       [V4_L_by_CYV]
WHERE 
       [Question_Year] = 2012
/*** <<< recode for total events *******************************************************************************************************************************/
)                                                                                                                                                      AS    RTE
/***************************************************************************************************************************************************************/
GROUP BY
       [Question_Year]
/*********************************************************************************************************************************** Aggregate GRI view by Y ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*** Aggregate SHI view by Y ***********************************************************************************************************************************/
SELECT
       [Question_Year]
      ,INDX     =     'SHI'
      ,AVRG     = AVG([SHI])
      ,NCtries  = STR(SUM([CntWg]))
  FROM
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
SELECT 
       DISTINCT
       [Nation_fk]
      ,[SHI]
      ,[Question_Year]
      ,[CntWg]
  FROM 
       [V4_L_by_CYV]
WHERE 
       [Question_Year] = 2012
/*** <<< recode for total events *******************************************************************************************************************************/
)                                                                                                                                                      AS    RTE
/***************************************************************************************************************************************************************/
GROUP BY
       [Question_Year]
/*********************************************************************************************************************************** Aggregate SHI view by Y ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
