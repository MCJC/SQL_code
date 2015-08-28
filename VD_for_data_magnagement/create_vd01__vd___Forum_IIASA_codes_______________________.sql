/********************************************************************************************************************************************************/
/********************************************************************************************************************************************************/
/***                                                                                                                                                  ***/
/***     >>>>>   This is the script used to create the view [forum].[dbo].[vd_01__Forum_IIASA_codes]                                        <<<<<     ***/
/***                                                                                                                                                  ***/
/********************************************************************************************************************************************************/
USE [forum]
GO
/********************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/********************************************************************************************************************************************************/
ALTER  VIEW
               [dbo].[vd_01__Forum_IIASA_codes]
AS
/********************************************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
       [Nation_fk]            =          [Nation_pk]
      ,[Num_UNStatDiv]
      ,[Num_IIASAALL]         = CASE
                                    WHEN [Nation_pk]
                                       =  108
                                     AND [Num_UNStatDiv]
                                       =  688
                                    THEN  9999
                                    WHEN [Nation_pk]
                                       =  203
                                     AND [Num_UNStatDiv]
                                       =  490
                                    THEN  158
                                    ELSE [Num_UNStatDiv]
                                 END
--      ,[Ctry_EditorialName]
--      ,[Region]
--      ,[SubRegion6]
--      ,[SubRegion]
--      ,[UN_Reg1]
--      ,[UN_Reg2]
----------------------------------------------------------------------------------------------------------------------------------------------------------
  FROM
       [forum].[dbo].[Pew_Nation]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
/********************************************************************************************************************************************************/
