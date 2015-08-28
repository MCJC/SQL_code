USE [forum]
GO
/*****************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************************************************************************************/
ALTER VIEW    [dbo].[Pew_Display_Survey_Tables]
AS
/*****************************************************************************************************************************************************/
SELECT
            ROW_NUMBER() OVER(ORDER BY   
                                        Nation_fk
                                      , RGp_L2_fk
                                      , CrossQA
                                      , Answer_fk
                                                  ) AS RowID

          , QLevel
          , Question
          , Answer
          , Percentage
          , Nation_fk
          , RGp_L2_fk
          , Answer_fk
          , Country
          , Religion
          , CrossQA
          , SbjctQ_ab
          , SbjctQ_tx
FROM
/*****************************************************************************************************************************************************/
(
/*****************************************************************************************************************************************************/
-- Set 1: By Country w/o cross question as well as by sex OR age
SELECT
         QLevel     = CASE
                      WHEN 
                           CQ.Question_abbreviation_std IS NULL
                      THEN
                             'Total Population of '
                           + PN.Ctry_EditorialName
                           + ' (both sexes, all ages)'
                      ELSE
                             'Total Population of '
                           + PN.Ctry_EditorialName
                           + ' who are '
                           + CA.answer_wording_std
                       END
       , Question   = 'Q: ' + SQ.Question_short_wording_std
       , Answer     = 'R: ' + SA.answer_wording_std
       , Percentage = ROUND(SUM(XX.Ctry_Pct), 2)
       , Nation_fk  = XX.Nation_fk
       , RGp_L2_fk  = '52'
       , Answer_fk  = XX.Answer_fk
       , Country    = PN.Ctry_EditorialName
       , Religion   = ' N/A'
       , CrossQA    = CASE
                      WHEN 
                           CQ.Question_abbreviation_std IS NULL
                      THEN
                           ' N/A'
                      ELSE
                           'Q: ' + CQ.Question_short_wording_std + ' / ' + CA.answer_wording_std
                       END
       , SbjctQ_ab  = SQ.Question_abbreviation_std
       , SbjctQ_tx  = 'Q: ' + SQ.Question_short_wording_std + ' R: ' + SA.answer_wording_std
     FROM forum.dbo.Pew_Survey_Answer    XX
LEFT JOIN forum.dbo.Pew_Answer           CA  ON CA.Answer_pk         = XX.Cross_Answer_fk
LEFT JOIN forum.dbo.Pew_Question         CQ  ON CQ.Question_pk       = CA.Question_fk
LEFT JOIN forum.dbo.Pew_Answer           SA  ON SA.Answer_pk         = XX.Answer_fk
LEFT JOIN forum.dbo.Pew_Question         SQ  ON SQ.Question_pk       = SA.Question_fk
LEFT JOIN forum.dbo.Pew_Religion_Group   RG  ON RG.Religion_group_pk = XX.PewRel_lev02_5_fk
LEFT JOIN forum.dbo.Pew_Nation           PN  ON PN.Nation_pk         = XX.Nation_fk
-- FILTERS:
    WHERE
           (
             CQ.Question_abbreviation_std IS NULL                                            -- distributions w/o cross-question
          OR CQ.Question_abbreviation_std IN ('SVYc_0071', 'SVYc_0072')                  -- the two cross-questions we use are age and gender
           )
      -----    XX.L02_Display                                                                  -- national level should ALWAYS BE DISPLAYED
      --AND    PN.Ctry_EditorialName        = 'Cameroon'                                       -- test for this country
      --AND    RG.Pew_religion_lev02        = 'Christians'                                     -- test for this religion group
      --AND    CA.answer_wording_std        = '35 and more'                                    -- test this cross-answer
      --AND    SQ.Question_abbreviation_std = 'SVYc_0029'                                      -- test this question distribution
GROUP BY
           PN.Ctry_EditorialName
         , CQ.Question_abbreviation_std
         , SQ.Question_abbreviation_std
         , CQ.Question_short_wording_std
         , CA.answer_wording_std
         , SQ.Question_short_wording_std
         , SA.answer_wording_std
         , XX.Nation_fk
         , XX.Answer_fk
--ORDER BY
--           PN.Ctry_EditorialName
--         , RG.Pew_religion_lev02
--         , CA.answer_wording_std                                                      -- this is the sorting order of the cross-categories/answers
--         , XX.Answer_fk                                                               -- this is the sorting order of the categories/answers

/*****************************************************************************************************************************************************/
UNION
/*****************************************************************************************************************************************************/
-- Set 2: By Country and Religion w/o cross question as well as by sex OR age
SELECT
         QLevel     = CASE
                      WHEN 
                           CQ.Question_abbreviation_std IS NULL
                      THEN
                             RG.Pew_religion_lev02
                           + ' in '
                           + PN.Ctry_EditorialName
                           + ' (both sexes, all ages)'
                      ELSE
                             RG.Pew_religion_lev02
                           + ' in '
                           + PN.Ctry_EditorialName
                           + ' who are '
                           + CA.answer_wording_std
                       END
       , Question   = 'Q: ' + SQ.Question_short_wording_std
       , Answer     = 'R: ' + SA.answer_wording_std
       , Percentage = ROUND(SUM(XX.WRel_lev02_Pct), 2)
       , Nation_fk  = XX.Nation_fk
       , RGp_L2_fk  = XX.PewRel_lev02_fk 
       , Answer_fk  = XX.Answer_fk
       , Country    = PN.Ctry_EditorialName
       , Religion   = RG.Pew_religion_lev02
       , CrossQA    = CASE
                      WHEN 
                           CQ.Question_abbreviation_std IS NULL
                      THEN
                           ' N/A'
                      ELSE
                           'Q: ' + CQ.Question_short_wording_std + ' / ' + CA.answer_wording_std
                       END
       , SbjctQ_ab  = SQ.Question_abbreviation_std
       , SbjctQ_tx  = 'Q: ' + SQ.Question_short_wording_std + ' R: ' + SA.answer_wording_std
     FROM forum.dbo.Pew_Survey_Answer    XX
LEFT JOIN forum.dbo.Pew_Answer           CA  ON CA.Answer_pk         = XX.Cross_Answer_fk
LEFT JOIN forum.dbo.Pew_Question         CQ  ON CQ.Question_pk       = CA.Question_fk
LEFT JOIN forum.dbo.Pew_Answer           SA  ON SA.Answer_pk         = XX.Answer_fk
LEFT JOIN forum.dbo.Pew_Question         SQ  ON SQ.Question_pk       = SA.Question_fk
LEFT JOIN forum.dbo.Pew_Religion_Group   RG  ON RG.Religion_group_pk = XX.PewRel_lev02_5_fk
LEFT JOIN forum.dbo.Pew_Nation           PN  ON PN.Nation_pk         = XX.Nation_fk
-- FILTERS:
    WHERE    XX.L02_Display               = 1                                                -- if this table should be displayed
      AND  (
             CQ.Question_abbreviation_std IS NULL                                            -- distributions w/o cross-question
          OR CQ.Question_abbreviation_std IN ('SVYc_0071', 'SVYc_0072', '')                  -- the two cross-questions we use are age and gender
           )
      --AND    PN.Ctry_EditorialName        = 'Cameroon'                                       -- test for this country
      --AND    RG.Pew_religion_lev02        = 'Christians'                                     -- test for this religion group
      --AND    CA.answer_wording_std        = '35 and more'                                    -- test this cross-answer
      --AND    SQ.Question_abbreviation_std = 'SVYc_0029'                                      -- test this question distribution
GROUP BY
           PN.Ctry_EditorialName
         , RG.Pew_religion_lev02
         , CQ.Question_abbreviation_std
         , SQ.Question_abbreviation_std
         , CQ.Question_short_wording_std
         , CA.answer_wording_std
         , SQ.Question_short_wording_std
         , SA.answer_wording_std
         , XX.Nation_fk
         , XX.PewRel_lev02_fk
         , XX.Answer_fk
--ORDER BY
--           PN.Ctry_EditorialName
--         , RG.Pew_religion_lev02
--         , CA.answer_wording_std                                                      -- this is the sorting order of the cross-categories/answers
--         , XX.Answer_fk                                                               -- this is the sorting order of the categories/answers

/*****************************************************************************************************************************************************/
) AS BTD
/*****************************************************************************************************************************************************/


