/********************************************************************************************************************************************************/
/********************************************************************************************************************************************************/
/***                                                                                                                                                  ***/
/***     >>>>>   This is the script used to create the view [forum_ResAnal].[dbo].[vr_07w_weights]                                          <<<<<     ***/
/***             This view includes numeric weights by year at different levels of aggregation                                                        ***/
/***                                                                                                                                                  ***/
/********************************************************************************************************************************************************/
/*  complete (unfiltered) view could be stored in   *****************************************************************************************************/
USE [forum_ResAnal]
GO
/********************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/********************************************************************************************************************************************************/
/********************************************************************************************************************************************************/
IF OBJECT_ID (N'[forum_ResAnal].[dbo].[vr_08__QAttributes]', N'U') IS NOT NULL
DROP TABLE      [forum_ResAnal].[dbo].[vr_08__QAttributes]
SELECT * INTO   [forum_ResAnal].[dbo].[vr_08__QAttributes]
FROM
(
-- query should be updated once [Pew_Question_Attribute] is properly created in [forum]
--- CHECK!!! script Chg__Pew_Question_Attribute_... in folder UpdateDatabase
/********************************************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
       [VxQAttr]
      ,[Question_Std_fk]
      ,[Variable]
      ,[attk]
      ,[attr]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
FROM
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
       [forum_ResAnal].[dbo].[Pew_Question_Attribute]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
/********************************************************************************************************************************************************/
    )                                                                                                                                          AttrsInUse
/********************************************************************************************************************************************************/
