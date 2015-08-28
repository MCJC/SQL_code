USE [RLS]
GO
--/*********************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*********************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------*/
ALTER VIEW             [dbo].[ReligionTree]
AS
/*-------------------------------------------------------------------------------------------------------*/
SELECT
/*-------------------------------------------------------------------------------------------------------*/
            [RelTree_pk]                       = ROW_NUMBER()
                                                 OVER(
                                                 ORDER BY 
                                                 CASE WHEN PR1.[RLS_level] IN (   'Religion Tradition' )
                                                      THEN PR1.[RLS_CODE]
                                                      WHEN PR1.[RLS_level] IN (   'Religion Family'    )
                                                      THEN PR3.[RLS_CODE]
                                                      ELSE PR3.[RLS_CODE]
                                                 END
                                               , CASE WHEN PR1.[RLS_level] IN (   'Religion Tradition' )
                                                      THEN NULL
                                                      WHEN PR1.[RLS_level] IN (   'Religion Family'    )
                                                      THEN PR1.[RLS_CODE]
                                                      ELSE PR2.[RLS_CODE]
                                                 END
                                               , CASE WHEN PR1.[RLS_level] IN (   'Religion Tradition'
                                                                                , 'Religion Family'    )
                                                     THEN NULL
                                                     ELSE PR1.[RLS_CODE]
                                                 END                                                     )
/*-------------------------------------------------------------------------------------------------------*/
      , PR1.[RLSx3_001_otherfaithfordisplay]
      , PR1.[RLSx3_002_christianfordisplay]
      , PR1.[RLSx3_003_protestantfordisplay]
      ,     [RLSx4_001_reltradfordisplay_w]    = CASE WHEN PR1.[RLS_level] IN (   'Religion Tradition' )
                                                      THEN PR1.[RLS_Religion]
                                                      WHEN PR1.[RLS_level] IN (   'Religion Family'    )
                                                      THEN ''                    -- PR3.[RLS_Religion]
                                                      ELSE ''                    -- PR2.[RLS_Religion]
                                                 END
      ,     [RLSx4_002_familyfordisplay_w]     = CASE WHEN PR1.[RLS_level] IN (   'Religion Tradition' )
                                                      THEN ''
                                                      WHEN PR1.[RLS_level] IN (   'Religion Family'    )
                                                      THEN PR1.[RLS_Religion]
                                                      ELSE ''                    -- PR2.[RLS_Religion]
                                                 END
      ,     [RLSx4_004_denomfordisplay2_w]     = CASE WHEN PR1.[RLS_level] IN (   'Religion Tradition'
                                                                                , 'Religion Family'    )
                                                      THEN ''
                                                      ELSE PR1.[RLS_Religion]
                                                 END
      ,     [RLSx4_001_reltradfordisplay_v]    = CASE WHEN PR1.[RLS_level] IN (   'Religion Tradition' )
                                                      THEN PR1.[RLS_CODE]
                                                      WHEN PR1.[RLS_level] IN (   'Religion Family'    )
                                                      THEN PR3.[RLS_CODE]
                                                      ELSE PR3.[RLS_CODE]
                                                 END
      ,     [RLSx4_002_familyfordisplay_v]     = CASE WHEN PR1.[RLS_level] IN (   'Religion Tradition' )
                                                      THEN NULL
                                                      WHEN PR1.[RLS_level] IN (   'Religion Family'    )
                                                      THEN PR1.[RLS_CODE]
                                                      ELSE PR2.[RLS_CODE]
                                                 END
      ,     [RLSx4_004_denomfordisplay2_v]     = CASE WHEN PR1.[RLS_level] IN (   'Religion Tradition'
                                                                                , 'Religion Family'    )
                                                      THEN NULL
                                                      ELSE PR1.[RLS_CODE]
                                                 END
      ,     [raw_frequency]                    = 0
/*-------------------------------------------------------------------------------------------------------*/
  FROM      [Pew_Religion]               PR1
/*-------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN      [Pew_Religion]               PR2
    ON  PR1.[FamilyParent_fk]
      = PR2.[RLS_Religion_pk]
/*-------------------------------------------------------------------------------------------------------*/
  LEFT
  JOIN      [Pew_Religion]               PR3
    ON  PR1.[TraditParent_fk]
      = PR3.[RLS_Religion_pk]
/*-------------------------------------------------------------------------------------------------------*/
--  LEFT
--  JOIN      [Pew_Survey_Respondent]      SR1
--    ON  PR1.[RLS_Religion_pk]
--      = SR1.[RLS_Religion_fk]
/*-------------------------------------------------------------------------------------------------------*/
WHERE
        PR1.[RLS_level]                       != 'Protestant Family'
  AND   PR1.[RLS_CODE]                        != 9999      -- DK Religion Denomination
  AND   PR1.[RLS_CODE]                        != 999       -- DK Religion Family
  AND   PR1.[RLS_CODE]                        != 900000    -- DK Religion Tradition
/*-------------------------------------------------------------------------------------------------------*/
/*********************************************************************************************************/
GO
/*********************************************************************************************************/
