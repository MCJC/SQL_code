/*****************************************************************************************************************************************************/
/***   This code includes in the view to be imported by Intridea only te questions that the Survey Team wants to display in the GRF website   ********/
/*****************************************************************************************************************************************************/
USE [forum]
GO
/*****************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************************************************************************************/
ALTER VIEW    [dbo].[Pew_Survey_Tables_Displayable]
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
          , Question_abbreviation_std
          , Question_short_wording_std
          , Question_Year
          , Question_wording_std
          , Notes
          , SortBy
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
          , Data_source_fk
          , Question_pk
          , Question_abbreviation
          , SampleSize
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
       ,                      SQ.Question_abbreviation_std
       ,                      SQ.Question_short_wording_std
       ,                      SQ.Question_Year
       ,                      SQ.Question_wording_std
       ,                      SQ.Notes
       ,                      SQ.Data_source_fk
       ,                      SQ.Question_pk
       ,                      SQ.Question_abbreviation
       , SortBy     = SA.Answer_value
       , Answer     = 'R: ' + SA.answer_wording_std
       , Percentage = ROUND(SUM(XX.Ctry_Pct), 0)
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
       , SampleSize = SUM(XX.unW_cases)
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
         , SQ.Question_Year
         , SQ.Question_wording_std
         , SQ.Notes
         , SQ.Data_source_fk
         , SQ.Question_pk
         , SQ.Question_abbreviation
         , SA.Answer_value
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
       ,                      SQ.Question_abbreviation_std
       ,                      SQ.Question_short_wording_std
       ,                      SQ.Question_Year
       ,                      SQ.Question_wording_std
       ,                      SQ.Notes
       ,                      SQ.Data_source_fk
       ,                      SQ.Question_pk
       ,                      SQ.Question_abbreviation
       , SortBy     = SA.Answer_value
       , Answer     = 'R: ' + SA.answer_wording_std
       , Percentage = ROUND(SUM(XX.WRel_lev02_Pct), 0)
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
       , SampleSize = SUM(XX.unW_cases)
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
         , SQ.Question_Year
         , SQ.Question_wording_std
         , SQ.Notes
         , SQ.Data_source_fk
         , SQ.Question_pk
         , SQ.Question_abbreviation
         , SA.Answer_value
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
WHERE                                                                                   -- this is the filter for questions to be displayed
       BTD.SbjctQ_ab IN (   
                            'SVYc_0029'   --  How important is religion in your life | Beliefs and practices
                          , 'SVYc_0033'   --  How often do you pray | Beliefs and practices
                          , 'SVYc_0064'   --  How often do you attend religious services | Beliefs and practices
                          , 'SVYc_0011'   --  Do you believe in one god, Allah and his Prophet Muhammad | Beliefs and practices
                          , 'SVYc_0040'   --  Moral acceptability of divorce | Culture and society
                          , 'SVYu_0168'   --  Moral acceptability of family planning | Culture and society
                          , 'SVYc_0043'   --  Moral acceptability of homosexuality | Culture and society
                          , 'SVYc_0044'   --  Belief in God and morality | Culture and society
                          , 'SVYu_0189'   --  Veiling | Culture and society
                          , 'SVYu_0198'   --  Inheritence rights  | Culture and society
                          , 'SVYc_0019'   --  Like western pop culture | Culture and society
                          , 'SVYc_0024'   --  Western pop culture hurts morality | Culture and society
                          , 'SVYu_0032'   --  Evolution | Culture and society
                          , 'SVYu_0004'   --  Shia-Sunni tensions | Inter-faith relations
                          , 'SVYu_0003'   --  Tensions between more devout and less devout Muslims | Inter-faith relations
                          , 'SVYc_0061'   --  How free are people of other faiths | Inter-faith relations
                          , 'SVYc_0062'   --  How free are people of other faiths/good thing, bad thing | Inter-faith relations
                          , 'SVYc_0054'   --  Sharia/Bible as law of the land | Politics and government
                          , 'SVYu_0185'   --  Ways to interpret sharia | Politics and government
                          , 'SVYu_0184'   --  Sharia apply to both Muslims and non-Muslims | Politics and government
          --              , 'SVYu_0181'   --  Biblical law apply to both Christians and non-Christians | Politics and government
                          , 'SVYc_0015'   --  Cutting hands | Politics and government
                          , 'SVYc_0017'   --  Stoning | Politics and government
                          , 'SVYc_0018'   --  Death penalty for apostates | Politics and government
                          , 'SVYc_0016'   --  Religious judges | Politics and government
                          , 'SVYc_0059'   --  Democracy | Politics and government
                          , 'SVYu_0002'   --  Suicide bombing | Politics and government
                          , 'SVYc_0027'   --  Concern about extremism | Politics and government
                          , 'SVYc_0003'   --  Concerned about Muslim or Christian groups | Politics and government
                                        )
/*****************************************************************************************************************************************************/
    AND
       Religion  IN ( 
                            ' N/A'
                          , 'Muslims'
                          , 'Christians'
                                              )
    AND NOT
           (
             Religion = ' N/A' AND CrossQA != ' N/A'	
                                                                                 )

    AND NOT
           (
             Country = 'Lebanon' AND SbjctQ_ab IN (
                                                       'SVYc_0019'
                                                     , 'SVYc_0059'
                                                     , 'SVYu_0002'
                                                                              )  )
    AND NOT
           (
             Religion = 'Muslims' AND Country = 'Lebanon'
                                                                                 )
    AND NOT
           (
             Religion = 'Muslims' AND Country = 'Malaysia'
                                                                                 )

    AND NOT
           (
             Religion = 'Christians' AND Country IN (
                                                       'Albania'
                                                     , 'Bosnia-Herzegovina'
                                                     , 'Egypt'
                                                     , 'Kazakhstan'
                                                     , 'Kosovo'
                                                     , 'Kyrgyzstan'
                                                     , 'Lebanon'
                                                     , 'Malaysia'
                                                     , 'Russia'
                                                     , 'Senegal'
                                                                              )  )


    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of Botswana (both sexes, all ages) | SVYc_0011' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of Botswana (both sexes, all ages) | SVYc_0018' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of Rwanda (both sexes, all ages) | SVYc_0011' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of Rwanda (both sexes, all ages) | SVYc_0018' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of South Africa (both sexes, all ages) | SVYc_0011' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of South Africa (both sexes, all ages) | SVYc_0018' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of South Africa who are 18 to 34 | SVYc_0011' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of South Africa who are 35 and more | SVYc_0011' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of South Africa who are Female | SVYc_0011' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of South Africa who are Male | SVYc_0011' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of Zambia (both sexes, all ages) | SVYc_0011' )
    AND   ( Qlevel+' | '+SbjctQ_ab != 'Total Population of Zambia (both sexes, all ages) | SVYc_0018' )
/*****************************************************************************************************************************************************/
