/* ++> create_vi01b_vi_Religion_Attributes.sql <++ */
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [forum]..[vi_vi_Religion_Attributes]                                                   <<<<<     ***/
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
ALTER  VIEW
               [dbo].[vi_Religion_Attributes]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [RLRv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY
                             MDA.[Year]
                           , ASV.[Religion_fk]     )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      , MDA.[Year]
      , ASV.[Region]
      , ASV.[Country]
      , ASV.[Religion_fk]
      , ASV.[Religion]
      ,     [WorldTotalPop]  =  ASV.[TotPopulat]
      , ASV.[Population]
      , ASV.[Percentage]
      , MDA.[MedianAge]
      --, MDA.[MedAgeCohort]
      --,     [ASVv_row]
      --,     [MAv_row]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  FROM 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       ( SELECT * FROM
         [forum].[dbo].[vi_MedianAge]
         WHERE Nation_fk    = 10000
           AND Religion    != 'All Religions'
           AND [Year]       = 2010
           AND Sex          = 'all'            )   MDA
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
     ,
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       ( SELECT * FROM
         [forum].[dbo].[vi_AgeSexValue]
         WHERE Nation_fk    = 10000
           AND Religion    != 'All Religions'
           AND Religion_fk IS NOT NULL
           AND [Year]       = 2010
           AND Sex          = 'all'
           AND Age          = 'all'            )   ASV
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
           MDA.[Year]
         = ASV.[Year]
  AND
           MDA.[Religion]
         = ASV.[Religion]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
go
