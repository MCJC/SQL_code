/* ++> create_vi05_vi_Survey_Tables_Displayable.sql <++ */
--USE [forum]
--GO
--/***************************************************************************************************************************************************************/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--/***************************************************************************************************************************************************************/
--ALTER  VIEW
--               [dbo].[vi_Survey_Tables_Displayable]
--AS
--/***************************************************************************************************************************************************************/
--/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--SELECT
--/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--            STDv_row      = ROW_NUMBER()
--                            OVER(ORDER BY STDv_row)
--/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--          , QLevel_code
--          , Cross_Qstd
--          , QLevel
--          , Question
--          , Question_abbreviation_std
--          , Question_short_wording_std
--          , Question_Year
--          , Question_wording_std
--          , Notes
--          , SortBy
--          , Answer
--          , Percentage
--          , Percentage_ds
--          , Nation_fk
--          , Religion_fk
--          , Answer_fk
--          , Country
--          , Religion
--          , Sex
--          , Age
--          , CrossQA
--          , SbjctQ_ab
--          , SbjctQ_tx
--          , Data_source_fk
--          , Question_pk
--          , Question_abbreviation
--          , SampleSize
--          , Question_Std_fk
--/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--FROM        [forum_ResAnal].[dbo].[vi_Survey_Tables_Displayable]
--/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [forum]..[vi_Unique_SurveyQuestions]                                                   <<<<<     ***/
/***             NOTE:  The view is based on a fixed table hosted at [forum_ResAnal]                                                                         ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/**** database name specification (once because [forum_ResAnal] is the default place for auxiliary fixed tables) ***********************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
USE              [forum_ResAnal]
GO
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vi_Survey_Tables_Displayable]', N'U') IS NOT NULL
DROP   TABLE     [forum_ResAnal].[dbo].[vi_Survey_Tables_Displayable]         -- drop table if existent
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT *
INTO   [vi_Survey_Tables_Displayable] FROM
/***************************************************************************************************************************************************************/
  (      /*** -> QRD Query to Retrieve Data ********************************************************************************************************************/
/***************************************************************************************************************************************************************/
SELECT
            ROW_NUMBER() OVER(ORDER BY   
                                        Nation_fk
                                      , RGp_L2_fk
                                      , CrossQA
                                      , Answer_fk
                                                  ) AS STDv_row

          , QLevel_code                  = CASE
                                           WHEN
                                                    [Religion]  = ' N/A'
                                                AND
                                                    [CrossQA]    = ' N/A'
                                               THEN                '1. National Level'
                                           WHEN
                                                    [Religion]   = ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: Gender / Female'
                                               THEN                '3A. Subnational Level | BySex: Females'
                                           WHEN
                                                    [Religion]   = ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: Gender / Male'
                                               THEN                '3B. Subnational Level | BySex: Males'
                                           WHEN
                                                    [Religion]   = ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: How old were you at your last birthday? / 18 to 34'
                                               THEN                '4A. Subnational Level | ByAge: 18 to 34'
                                           WHEN
                                                    [Religion]   = ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: How old were you at your last birthday? / 35 and more'
                                               THEN                '4B. Subnational Level | ByAge: 35 and more'
                                           WHEN
                                                    [Religion]   = ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: How old were you at your last birthday? / DK/Ref. (vol.)'
                                               THEN                '4C. Subnational Level | ByAge: unknown'
                                           WHEN
                                                    [Religion]  != ' N/A'
                                                AND
                                                    [CrossQA]    = ' N/A'
                                               THEN                '2. Subnational Level | ByRel: ' + [Religion]
                                           WHEN
                                                    [Religion]  != ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: Gender / Female'
                                               THEN                '5A. Subnational Level | ByRel: ' + [Religion] + ' & BySex: Females'
                                           WHEN
                                                    [Religion]  != ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: Gender / Male'
                                               THEN                '5B. Subnational Level | ByRel: ' + [Religion] + ' & BySex: Males'
                                           WHEN
                                                    [Religion]  != ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: How old were you at your last birthday? / 18 to 34'
                                               THEN                '6A. Subnational Level | ByRel: ' + [Religion] + ' & ByAge: 18 to 34'
                                           WHEN
                                                    [Religion]  != ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: How old were you at your last birthday? / 35 and more'
                                               THEN                '6B. Subnational Level | ByRel: ' + [Religion] + ' & ByAge: 35 and more'
                                           WHEN
                                                    [Religion]  != ' N/A'
                                                AND
                                                    [CrossQA]    = 'Q: How old were you at your last birthday? / DK/Ref. (vol.)'
                                               THEN                '6C. Subnational Level | ByRel: ' + [Religion] + ' & ByAge: unknown'
                       END
          , Cross_Qstd
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
          , Percentage_ds        = ISNULL(Cds,CAST(Percentage AS VARCHAR(MAX)))
          , Nation_fk
          , Religion_fk          = RGp_L2_fk
          , Answer_fk
          , Country
          , Religion
          , Sex                  = CASE
                                           WHEN     [CrossQA]    = 'Q: Gender / Female'
                                               THEN 'Female'
                                           WHEN     [CrossQA]    = 'Q: Gender / Male'
                                               THEN 'Male'
                                           ELSE     'All Respondents'
                                    END
          , Age                  = CASE
                                           WHEN     [CrossQA]    = 'Q: How old were you at your last birthday? / 18 to 34'
                                               THEN '18-34'
                                           WHEN     [CrossQA]    = 'Q: How old were you at your last birthday? / 35 and more'
                                               THEN '35+'
                                           WHEN     [CrossQA]    = 'Q: How old were you at your last birthday? / DK/Ref. (vol.)'
                                               THEN 'Age Unknown'
                                           ELSE     'All'
                                    END
          , CrossQA
          , SbjctQ_ab
          , SbjctQ_tx
          , Data_source_fk
          , Question_pk
          , Question_abbreviation
          , SampleSize
          , Question_Std_fk
----select *, Percentage_ds = ISNULL(Cds,CAST(Percentage AS VARCHAR(MAX)))
FROM
/*****************************************************************************************************************************************************/
(
/*****************************************************************************************************************************************************/
-- >> Added Sets 1 & 2: By Ctry, Ctry&Sex, Ctry&Age, Ctry&Rel, Ctry&Rel&Sex and Ctry&Rel&Age ----------------------------------------------------------
/*****************************************************************************************************************************************************/
-- >> Set 1: By Country w/o cross question as well as by sex OR age w/o cross question ----------------------------------------------------------------
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
       , Question   = 'Q: '   + SQ.Question_short_wording_std
       ,                        SQ.Question_abbreviation_std
       ,                        SQ.Question_short_wording_std
       ,                        SQ.Question_Year
       ,                        SQ.Question_wording_std
       ,                        SQ.Notes
       ,                        SQ.Data_source_fk
       ,                        SQ.Question_pk
       ,                        SQ.Question_abbreviation
       , SortBy     =           SA.Answer_value
--     , Answer     = 'R: '   + SA.answer_wording_std
       , Answer     =           SA.answer_wording_std
       , Percentage = ROUND(SUM(XX.Ctry_Pct), 0)
       , Nation_fk  =           XX.Nation_fk
       , RGp_L2_fk  =           '52'
       , Answer_fk  =           XX.Answer_fk
       , Country    =           PN.Ctry_EditorialName
       , Religion   =           ' N/A'
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
       ,                      SQ.Question_Std_fk
       , Cross_Qstd = CQ.Question_abbreviation_std
       , QL_code    = ''
       , Display    = SQ.Display
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
         , SQ.Question_Std_fk
         , SQ.Display
--ORDER BY
--           PN.Ctry_EditorialName
--         , RG.Pew_religion_lev02
--         , CA.answer_wording_std                                                      -- this is the sorting order of the cross-categories/answers
--         , XX.Answer_fk                                                               -- this is the sorting order of the categories/answers

-- << Set 1: By Country w/o cross question as well as by sex OR age w/o cross question ----------------------------------------------------------------
/*****************************************************************************************************************************************************/
UNION
/*****************************************************************************************************************************************************/
-- >> Set 2: By Country and Religion w/o cross question as well as by religion+sex OR religion+age w/o cross question ---------------------------------
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
--     , Answer     = 'R: ' + SA.answer_wording_std
       , Answer     =         SA.answer_wording_std
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
       ,                      SQ.Question_Std_fk
       , Cross_Qstd = CQ.Question_abbreviation_std
       , QL_code    = ''
       , Display    = SQ.Display
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
         , SQ.Question_Std_fk
         , SQ.Display
--ORDER BY
--           PN.Ctry_EditorialName
--         , RG.Pew_religion_lev02
--         , CA.answer_wording_std                                                      -- this is the sorting order of the cross-categories/answers
--         , XX.Answer_fk                                                               -- this is the sorting order of the categories/answers
-- << Set 2: By Country and Religion w/o cross question as well as by religion+sex OR religion+age w/o cross question ---------------------------------
/*****************************************************************************************************************************************************/
-- << Added Sets 1 & 2: By Ctry, Ctry&Sex, Ctry&Age, Ctry&Rel, Ctry&Rel&Sex and Ctry&Rel&Age ----------------------------------------------------------
/*****************************************************************************************************************************************************/
) AS BTD
/*****************************************************************************************************************************************************/
-- >> ADD rounding rules for percentage to display in varchar field -----------------------------------------------------------------------------------
LEFT JOIN (SELECT  [Cds] = [Display_text]
                 , [Th]  = [Threshold]
                 , [Pt]  = [Point]
           FROM
           [forum].[dbo].[Pew_Thresholds]  /* [vi_Thresholds] is created in vi25, after vi05 */
           WHERE [Datatype]='Percentage') T  ON (Percentage < T.[Th] and T.[Pt] = 'minimum' )
                                             OR (Percentage > T.[Th] and T.[Pt] = 'maximum' )
-- << ADD rounding rules for percentage to display in varchar field -----------------------------------------------------------------------------------
WHERE
-- >> FILTER: list of questions questions to be displayed ---------------------------------------------------------------------------------------------
       BTD.Display   =  1
-- << FILTER: list of questions questions to be displayed ---------------------------------------------------------------------------------------------
/*****************************************************************************************************************************************************/
    AND
-- >> FILTER: religious groups to be displayed --------------------------------------------------------------------------------------------------------
       Religion  IN ( 
                            ' N/A'
                          , 'Muslims'
                          , 'Christians'
                                              )
-- << FILTER: religious groups to be displayed --------------------------------------------------------------------------------------------------------
    AND NOT
-- >> FILTER: EXCLUDE these cases, (NOTE: should be clarified why !!!!!) ------------------------------------------------------------------------------
           (
             Religion = ' N/A' AND CrossQA != ' N/A'	
                                                                                 )

-- << FILTER: EXCLUDE these cases, (NOTE: should be clarified why !!!!!) ------------------------------------------------------------------------------
    AND NOT
-- >> FILTER: EXCLUDE cases combining questions and countries (by request of Survey team, until recoding) ---------------------------------------------
           (
             Country = 'Lebanon' AND SbjctQ_ab IN (
                                                       'SVYc_0019'
                                                     , 'SVYc_0059'
                                                     , 'SVYu_0002'
                                                                              )  )
-- << FILTER: EXCLUDE cases combining questions and countries (by request of Survey team, until recoding) ---------------------------------------------
    AND NOT
-- >> FILTER: EXCLUDE cases combining religions and countries (by request of Survey team, until recoding) ---------------------------------------------
           (
             Religion = 'Muslims' AND Country = 'Lebanon'
                                                                                 )
-- >> FILTER: EXCLUDE cases combining religions and countries (by request of Survey team, until recoding) ---------------------------------------------
    AND NOT
-- >> FILTER: EXCLUDE cases combining religions and countries (by request of Survey team, until recoding) ---------------------------------------------
           (
             Religion = 'Muslims' AND Country = 'Malaysia'
                                                                                 )
-- >> FILTER: EXCLUDE cases combining religions and countries (by request of Survey team, until recoding) ---------------------------------------------
    AND NOT
-- >> FILTER: EXCLUDE cases combining religions and countries (by request of Survey team, until recoding) ---------------------------------------------
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
-- << FILTER: EXCLUDE cases combining religions and countries (by request of Survey team, until recoding) ---------------------------------------------
    AND
-- >> FILTER: EXCLUDE cases for combinations of level (Ctry + SubPopulation) & question (by request of Survey team, until recoding) -------------------
           ( Qlevel+' | '+SbjctQ_ab
                             NOT IN
                                   (    'Total Population of Botswana (both sexes, all ages) | SVYc_0011' 
                                      , 'Total Population of Botswana (both sexes, all ages) | SVYc_0018'
                                      , 'Total Population of Rwanda (both sexes, all ages) | SVYc_0011'
                                      , 'Total Population of Rwanda (both sexes, all ages) | SVYc_0018'
                                      , 'Total Population of South Africa (both sexes, all ages) | SVYc_0011'
                                      , 'Total Population of South Africa (both sexes, all ages) | SVYc_0018'
                                      , 'Total Population of South Africa who are 18 to 34 | SVYc_0011'
                                      , 'Total Population of South Africa who are 35 and more | SVYc_0011'
                                      , 'Total Population of South Africa who are Female | SVYc_0011'
                                      , 'Total Population of South Africa who are Male | SVYc_0011'
                                      , 'Total Population of Zambia (both sexes, all ages) | SVYc_0011'
                                      , 'Total Population of Zambia (both sexes, all ages) | SVYc_0018'
                                                                                                                  ))
-- << FILTER: EXCLUDE cases for combinations of level (Ctry + SubPopulation) & question (by request of Survey team, until recoding) -------------------
/*****************************************************************************************************************************************************/
--and
----QLevel_code != ''
/***************************************************************************************************************************************************************/
  ) QTR  /*** <- QRD Query to Retrieve Data ********************************************************************************************************************/
/***************************************************************************************************************************************************************/
GO


