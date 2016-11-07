/******************************************************************************************************************************/
/***                                                                                                                        ***/
/***     >>>>>   This is the script used to create the view [forum_ResAnal].[dbo].[Vx_e_LongIndex]                <<<<<     ***/
/***             This view is hosted in the default place for auxiliary fixed tables & views: [forum_ResAnal]               ***/
/***                                                                                                                        ***/
/***          NOTICE that indexes and median indexes, for now, should be rounded and calculated in Stata                    ***/
/***                      (this is in order to get comparable numbers to previously published data)                         ***/
/***                                                                                                                        ***/
/******************************************************************************************************************************/
USE [forum_ResAnal]
GO
/******************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************************************************************/
ALTER  VIEW
               [dbo].[Vx_e_LongIndex]
AS
/******************************************************************************************************************************/
SELECT
        [Nation_fk]
      , [Ctry_EditorialName]
      , [Region]
      , [SubRegion6]
      , [Index_Year]
         =        CASE
                  WHEN [Question_Year] <  2011 THEN 'MID-' + STR([Question_Year], 4,0)
                  ELSE                              'END-' + STR([Question_Year], 4,0)
                  END
      , [Index_Name]
         =        CASE
                  WHEN [Index_Abbreviation] = 'GRI' THEN 'Government Restrictions Index'
                  WHEN [Index_Abbreviation] = 'SHI' THEN 'Social Hostilities Index'
                  WHEN [Index_Abbreviation] = 'GFI' THEN 'Government Favoritism Index'
                  END
      , [Index_Abbreviation]
      , [Index_Value]
      , [I_Rounded_Value]
      , [I_Scaled_Value]
      , [Question_Year]
FROM
/******************************************************************************************************************************/
(
/******************************************************************************************************************************/
SELECT 
          [Nation_fk]
      , d.[Ctry_EditorialName]
      ,   [Region]
      ,   [SubRegion6]
      ,   [Question_Year]
      ,   [GRI] -- float works fro rounding: don't re-cast
      ,   [SHI] -- float works fro rounding: don't re-cast
      ,   [GFI] -- float works fro rounding: don't re-cast
  FROM         [dbo].[V3_W&Extras_by_Ctry&Year] d
      ,[forum].[dbo].[Pew_Nation]
WHERE
          [Nation_fk]
        = [Nation_pk]
/******************************************************************************************************************************/
)                                                         B
/******************************************************************************************************************************/
UNPIVOT
  (
     [Index_Value]
FOR
     [Index_Abbreviation]
in (
               [GRI]  /*** GRI Yindex (d prec/scale)    ***/
             , [SHI]  /*** SHI Yindex (d prec/scale)    ***/
             , [GFI]  /*** GFI Yindex (d prec/scale)    ***/
                                               ) ) as UNPIVTD1
/******************************************************************************************************************************/
JOIN
/******************************************************************************************************************************/
(
/******************************************************************************************************************************/
SELECT 
          [N2]        = [Nation_fk]
      ,   [Y2]        = [Question_Year]
      ,   [GRI]       = [GRI_rd_1d]    -- already rounded: don't re-cast
      ,   [SHI]       = [SHI_rd_1d]    -- already rounded: don't re-cast
      ,   [GFI]       = [GFI_rd_1d]    -- already rounded: don't re-cast
  FROM         [dbo].[V3_W&Extras_by_Ctry&Year] d
/******************************************************************************************************************************/
)                                                         B
/******************************************************************************************************************************/
UNPIVOT
  (
     [I_Rounded_Value]
FOR
     [I2]
in (
               [GRI]  /*** GRI Yindex rounded ***/
             , [SHI]  /*** SHI Yindex rounded ***/
             , [GFI]  /*** GFI Yindex rounded ***/
                                               ) ) as UNPIVTD2
/******************************************************************************************************************************/
ON        [N2]        = [Nation_fk]
AND       [Y2]        = [Question_Year]
AND       [I2]        = [Index_Abbreviation]
/******************************************************************************************************************************/
JOIN
/******************************************************************************************************************************/
(
/******************************************************************************************************************************/
SELECT 
          [N3]        = [Nation_fk]
      ,   [Y3]        = [Question_Year]
      ,   [GRI]       = [GRI_scaled]    -- already scaled: don't re-cast
      ,   [SHI]       = [SHI_scaled]    -- already scaled: don't re-cast
      ,   [GFI]       = [GFI_scaled]    -- already scaled: don't re-cast
  FROM         [dbo].[V3_W&Extras_by_Ctry&Year] d
/******************************************************************************************************************************/
)                                                         B
/******************************************************************************************************************************/
UNPIVOT
  (
     [I_Scaled_Value]
FOR
     [I3]
in (
               [GRI]  /*** GRI Yindex scaled ***/
             , [SHI]  /*** SHI Yindex scaled ***/
             , [GFI]  /*** GFI Yindex scaled ***/
                                               ) ) as UNPIVTD3
/******************************************************************************************************************************/
ON        [N3]        = [Nation_fk]
AND       [Y3]        = [Question_Year]
AND       [I3]        = [Index_Abbreviation]
/******************************************************************************************************************************/
