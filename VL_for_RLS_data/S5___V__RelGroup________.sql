USE [RLS]
GO
/*****************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************************************************/
/*---------------------------------------------------------------------------------------------------------------*/
ALTER VIEW             [dbo].[Pew_Religion_Group]
AS
/*---------------------------------------------------------------------------------------------------------------*/
SELECT
/*---------------------------------------------------------------------------------------------------------------*/
   PR1.[RLS_Religion_pk]
 , PR1.[RLS_level]
 , PR1.[RLS_Religion]
/*---------------------------------------------------------------------------------------------------------------*/
 ,     [RLSx4_004_denomfordisplay2_v]  =             PR1.[RLS_CODE]
 ,     [RLSx4_004_denomfordisplay2_w]  =             PR1.[RLS_Religion]
/*---------------------------------------------------------------------------------------------------------------*/
 ,     [RLSx4_003_familyfordisplay_v]  = CASE 
                                         WHEN PR1.[RLS_level] = 'Religion Tradition'    THEN -9
                                         WHEN PR1.[RLS_level] = 'Protestant Family'     THEN -9
                                         WHEN PR1.[RLS_level] = 'Religion Family'       THEN PR1.[RLS_CODE]
                                         WHEN PR1.[RLS_level] = 'Religion Denomination' THEN PR2.[RLS_CODE]
                                          END
 ,     [RLSx4_003_familyfordisplay_w]  = CASE
                                         WHEN PR1.[RLS_level] = 'Religion Tradition'    THEN ''
                                         WHEN PR1.[RLS_level] = 'Protestant Family'     THEN ''
                                         WHEN PR1.[RLS_level] = 'Religion Family'       THEN PR1.[RLS_Religion]
                                         WHEN PR1.[RLS_level] = 'Religion Denomination' THEN PR2.[RLS_Religion]
                                          END
/*---------------------------------------------------------------------------------------------------------------*/
 ,     [RLSx4_002_protfamfordisplay_v] = CASE 
                                         WHEN PR1.[RLS_level] = 'Religion Tradition'    THEN -9
                                         WHEN PR1.[RLS_level] = 'Protestant Family'     THEN PR1.[RLS_CODE]
                                         WHEN PR1.[RLS_level] = 'Religion Family'       THEN R3f.[RLS_CODE]
                                         WHEN PR1.[RLS_level] = 'Religion Denomination' THEN R3d.[RLS_CODE]
                                          END
 ,     [RLSx4_002_protfamfordisplay_w] = CASE 
                                         WHEN PR1.[RLS_level] = 'Religion Tradition'    THEN ''
                                         WHEN PR1.[RLS_level] = 'Protestant Family'     THEN PR1.[RLS_Religion]
                                         WHEN PR1.[RLS_level] = 'Religion Family'       THEN R3f.[RLS_Religion]
                                         WHEN PR1.[RLS_level] = 'Religion Denomination' THEN R3d.[RLS_Religion]
                                          END
/*---------------------------------------------------------------------------------------------------------------*/
 ,     [RLSx4_001_reltradfordisplay_v] = CASE
                                         WHEN PR1.[RLS_level] = 'Religion Tradition'    THEN PR1.[RLS_CODE]
                                         WHEN PR1.[RLS_level] = 'Protestant Family'     THEN -9
                                         WHEN PR1.[RLS_level] = 'Religion Family'       THEN PR4.[RLS_CODE]
                                         WHEN PR1.[RLS_level] = 'Religion Denomination' THEN PR4.[RLS_CODE]
                                          END
 ,     [RLSx4_001_reltradfordisplay_w] = CASE
                                         WHEN PR1.[RLS_level] = 'Religion Tradition'    THEN PR1.[RLS_Religion]
                                         WHEN PR1.[RLS_level] = 'Protestant Family'     THEN ''
                                         WHEN PR1.[RLS_level] = 'Religion Family'       THEN PR4.[RLS_Religion]
                                         WHEN PR1.[RLS_level] = 'Religion Denomination' THEN PR4.[RLS_Religion]
                                          END
/*-------------------------------------------------------------------------------------------------------*/
      , PR1.[RLSx3_001_otherfaithfordisplay]
      , PR1.[RLSx3_002_christianfordisplay]
      , PR1.[RLSx3_003_protestantfordisplay]
/*-------------------------------------------------------------------------------------------------------*/
      , PR1.[FamilyParent_fk]
      , PR1.[TraditParent_fk]
      , PR1.[RLS_CODE]
/*-------------------------------------------------------------------------------------------------------*/
  FROM      [Pew_Religion]               PR1
/*-------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN      [Pew_Religion]               PR2
    ON  PR1.[FamilyParent_fk]
      = PR2.[RLS_Religion_pk]
/*-------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN      [Pew_Religion]               R3d     -- Religion Denomination
    ON  PR2.[FamilyParent_fk]
      = R3d.[RLS_Religion_pk]
/*-------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN      [Pew_Religion]               R3f     -- Religion Family
    ON  PR1.[FamilyParent_fk]
      = R3f.[RLS_Religion_pk]
/*-------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN      [Pew_Religion]               PR4
    ON  PR1.[TraditParent_fk]
      = PR4.[RLS_Religion_pk]
/*-------------------------------------------------------------------------------------------------------*/
/*********************************************************************************************************/
GO
/*********************************************************************************************************/
