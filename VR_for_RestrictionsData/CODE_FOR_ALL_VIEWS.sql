-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[Pew_Indexes]    Script Date: 4/4/2016 8:26:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[Pew_Indexes]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          ViewRow
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [Nation_fk]
                           , [Index_abbreviation]
                           , [Question_Year]
                                                       )
       , *
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  FROM 
       [forum_ResAnal].[dbo].[Pew_Indexes]
/***************************************************************************************************************************************************************/


GO
-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[Pew_Nation_Religion_Value]    Script Date: 4/4/2016 8:28:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

   
CREATE VIEW    [dbo].[Pew_Nation_Religion_Value]
AS
/*********************************************************************************************************/
SELECT 
       Nation_religion_age_sex_value_fk   = Nation_religion_age_sex_value_pk
      ,Nation_fk
      ,Religion_group_fk
       -- Fields for working data, 1990,
       -- 2000, 2010, 2020, & 2030
      ,Field_fk                           = CASE
                                                WHEN Field_fk = 25 THEN 24
                                                WHEN Field_fk = 26 THEN  8
                                                WHEN Field_fk = 27 THEN 21
                                                WHEN Field_fk = 28 THEN  7
                                                WHEN Field_fk = 29 THEN 22
                                                WHEN Field_fk = 30 THEN 23
                                            END
      ,nation_value                       = Percentage
      ,[nation_value_Source]
      ,[nation_value_Note]                = Notes              -- SUBSTRING(column, begin_position, length)
      ,[Base_source]                      = Source
      ,[Source_year]
      ,[Scenario_id]
      ,[Distribution_wave_id]
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
WHERE
       [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Field_fk]    IN (25, 26, 27, 28, 29, 30)
AND
       [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Scenario_id] IN (0, 1, 2, 3)
AND
       [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Age_fk]       =   0
AND
       [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Sex_fk]       =   0
/*********************************************************************************************************/

GO
-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[Pew_Question_Displayable]    Script Date: 4/4/2016 8:31:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************************/
CREATE VIEW    [dbo].[Pew_Question_Displayable]
AS
/*** ALL Qs *********************************************************************************/
SELECT
       *
from
(
/********************************************************************************************/
-- Notice that:
-- the statement " distinct Question_abbreviation_std, Question_Year '
-- gives all cases, because such combined fields are a unique ID
/*** Restrictions Questions *****************************************************************/
SELECT   Question_abbreviation_std
       , Question_short_wording_std
       , Question_Year
FROM
(
       SELECT Question_Year = 2007
 UNION SELECT Question_Year = 2008
 UNION SELECT Question_Year = 2009
 UNION SELECT Question_Year = 2010
 UNION SELECT Question_Year = 2011
 UNION SELECT Question_Year = 2012
) AS YR
CROSS JOIN
(
SELECT
          Question_abbreviation_std
        , Question_short_wording_std
  FROM [forum].[dbo].[Pew_Question_std]
WHERE  Question_abbreviation_std IN
(
  'GRI'
, 'GRI_01'
, 'GRI_02'
, 'GRI_03'
, 'GRI_04'
, 'GRI_05'
, 'GRI_06'
, 'GRI_07'
, 'GRI_08'
, 'GRI_09'
, 'GRI_10'
, 'GRI_11'
, 'GRI_12'
, 'GRI_13'
, 'GRI_14'
, 'GRI_15'
, 'GRI_16'
, 'GRI_17'
, 'GRI_18'
, 'GRI_19'
--, 'GRI_19_b'
--, 'GRI_19_c'
--, 'GRI_19_d'
--, 'GRI_19_e'
--, 'GRI_19_f'
, 'GRI_20_SUMMARY'
, 'GRI_20_01'
, 'GRI_20_02'
, 'GRI_20_03_SUMMARY'
, 'GRI_20_03_a'
, 'GRI_20_03_b'
, 'GRI_20_03_c'
, 'GRI_20_04'
, 'GRI_20_05'
, 'SHI'
, 'SHI_01_summary_a'
, 'SHI_01_summary_b'
, 'SHI_02'
, 'SHI_03'
, 'SHI_04'
, 'SHI_05'
, 'SHI_06'
, 'SHI_07'
, 'SHI_08'
, 'SHI_09'
, 'SHI_10'
, 'SHI_11'
, 'SHI_12'
, 'SHI_13'
, 'GFI'
)
) AS VARS
/***************************************************************** Restrictions Questions ***/
UNION
/*** Survey Questions ***********************************************************************/
SELECT DISTINCT
         Question_abbreviation_std
       , Question_short_wording_std
       , Question_Year
  FROM [forum].[dbo].[Pew_Question]
 WHERE  Question_abbreviation_std     LIKE 'SVY%'
   AND  Question_abbreviation_std       != 'SVYc_0073'
   AND  Question_abbreviation     NOT LIKE 'CSP%'
/*********************************************************************** Survey Questions ***/
)
AS Qs_to_D
/********************************************************************************* ALL Qs ***/
-- Other Filters



GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[Restrictions_byCtry]    Script Date: 4/4/2016 8:33:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


   
CREATE VIEW    [dbo].[Restrictions_byCtry]
AS
SELECT
        ARD.Q_Level
      , ARD.Nation_fk
      , ARD.Ctry_EditorialName
      , ARD.Question_Year
      , ARD.Question_abbreviation_std
      , ARD.Question_short_wording_std
      , ARD.Answer_value
      , ARD.answer_wording_std
      , ARD.Question_fk
      , ARD.Answer_fk

/*****************************************************************************************************************************************/
--SELECT
--        distinct
--        ARD.Question_abbreviation_std
--      , ARD.[Question_short_wording_std]
--      , ARD.[Answer_value]
--      , ARD.[answer_wording_std]
--      , ARD.Question_fk
--      , ARD.Answer_fk
--      , ARD.Question_Year
/*****************************************************************************************************************************************/

FROM
(
/***  Get ALL restrictions data  *********************************************************************************************************/

/***  NON-AGGREGATED variables  **********************************************************************************************************/
SELECT     Q_Level     = 'Country'
      ,    Nation_fk   = N.[Nation_pk]
      , N.[Ctry_EditorialName]
      , Q.[Question_Year]
      , Q.[Question_abbreviation_std]
      , Q.[Question_short_wording_std]
      ,    Answer_value
                       =  CASE
                              WHEN (   Q.Question_abbreviation_std = 'GRI_08'
                                    OR Q.Question_abbreviation_std = 'SHI_11' )
                               AND     A.answer_value              = 0.5        THEN 1
                              ELSE     A.answer_value
                         END
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]
/**********************************************************************************************************  NON-AGGREGATED variables  ***/
UNION
/***  GRI_20_summary  ********************************************************************************************************************/
SELECT      Q_Level     = 'aggregated'
      , AG1.Nation_fk
      , AG1.Ctry_EditorialName
      , AG1.Question_Year
      ,     Question_abbreviation_std  = 'GRI_20_summary'
      ,     Question_short_wording_std = 'Do some religious groups receive government support or favors, '
                                       + 'such as funding, official recognition or special access?'
      , AG1.Answer_value
      ,     Answer_wording_std =
                   CASE
                        WHEN AG1.Answer_value = 0   THEN
                          'No'
                        WHEN AG1.Answer_value = 0.5 THEN
                          'Yes, the government provides support  to religious groups, '
                        + 'but it does so on a more-or-less fair and equal basis'
                        WHEN AG1.Answer_value = 1   THEN
                          'Yes, the government gives preferential support or favors to some'
                        + ' religious group(s) and clearly discriminates against others'
                     END
      ,      Question_fk = 999999
      ,      Answer_fk   = 999999
FROM
(  SELECT           Question_abbreviation_std = LEFT(Q.question_abbreviation_std, 6)
           ,     KN.Nation_fk
           ,      N.Ctry_EditorialName
           ,      Q.question_year
           ,      Answer_value
                  = ROUND( (MAX(CASE
             WHEN Q.question_abbreviation_std = 'GRI_20_01'
              AND A.answer_value              > 0              THEN 0.5
             WHEN Q.question_abbreviation_std = 'GRI_20_02'
              AND A.answer_value              = 0.25           THEN 0.5
             WHEN Q.question_abbreviation_std = 'GRI_20_02'
              AND A.answer_value              = 0.5            THEN 0.5
             WHEN Q.question_abbreviation_std = 'GRI_20_03_a'
              AND A.answer_value              = 0.5            THEN 0.5
             WHEN Q.question_abbreviation_std = 'GRI_20_03_b'
              AND A.answer_value              = 0.5            THEN 0.5
             WHEN Q.question_abbreviation_std = 'GRI_20_03_c'
              AND A.answer_value              = 0.5            THEN 0.5
             WHEN Q.question_abbreviation_std = 'GRI_20_04'
              AND A.answer_value              > 0              THEN 0.5
             WHEN Q.question_abbreviation_std = 'GRI_20_05'
              AND A.answer_value              > 0              THEN 0.5
             WHEN Q.question_abbreviation_std = 'GRI_20_02'
              AND A.answer_value              > 0.5            THEN 1
             WHEN Q.question_abbreviation_std = 'GRI_20_03_a'
              AND A.answer_value              > 0.5            THEN 1
             WHEN Q.question_abbreviation_std = 'GRI_20_03_b'
              AND A.answer_value              > 0.5            THEN 1
             WHEN Q.question_abbreviation_std = 'GRI_20_03_c'
              AND A.answer_value              > 0.5            THEN 1
                                                               ELSE 0
                         END
                  )), 1 )
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]
  AND Q.Question_abbreviation_std
      in (
           'GRI_20_01'   ,
           'GRI_20_02'   ,
           'GRI_20_03_a' ,
           'GRI_20_03_b' ,
           'GRI_20_03_c' ,
           'GRI_20_04',
           'GRI_20_05'
         )
GROUP BY     LEFT(Q.question_abbreviation_std, 6)
           ,     KN.Nation_fk
           ,      N.Ctry_EditorialName
           ,      Q.question_year
                                                                )  AG1
/********************************************************************************************************************  GRI_20_summary  ***/
UNION
/***  GRI_20_3_summary  ******************************************************************************************************************/
SELECT      Q_Level     = 'aggregated'
      , AG2.Nation_fk
      , AG2.Ctry_EditorialName
      , AG2.Question_Year
      ,     Question_abbreviation_std  = 'GRI_20_03_summary'
      ,     Question_short_wording_std = 'Does any level of government provide funds'
                                       + ' or other resources to religious groups?'
      , AG2.Answer_value
      ,     Answer_wording_std =
                   CASE
                        WHEN AG2.Answer_value = 0   THEN
                          'No'
                        WHEN AG2.Answer_value = 0.5 THEN
                          'Yes, but with no obvious favoritism to a particular group or groups'
                        WHEN AG2.Answer_value = 1   THEN
                          'Yes, and with obvious favoritism to a particular group or groups'
                     END
      ,      Question_fk = 999999
      ,      Answer_fk   = 999999
FROM
(  SELECT           Question_abbreviation_std = LEFT(Q.question_abbreviation_std, 9)
           ,     KN.Nation_fk
           ,      N.Ctry_EditorialName
           ,      Q.question_year
           ,      Answer_value = MAX(Answer_value)
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]
  AND Q.Question_abbreviation_std
      in (
           'GRI_20_03_a' ,
           'GRI_20_03_b' ,
           'GRI_20_03_c'
         )
GROUP BY     LEFT(Q.question_abbreviation_std, 9)
           ,     KN.Nation_fk
           ,      N.Ctry_EditorialName
           ,      Q.question_year
                                                                )  AG2
/******************************************************************************************************************  GRI_20_3_summary  ***/
UNION
/***  SHI_01_summary_b  ******************************************************************************************************************/
SELECT      Q_Level     = 'aggregated'
      , AG3.Nation_fk
      , AG3.Ctry_EditorialName
      , AG3.Question_Year
      ,     Question_abbreviation_std  = 'SHI_01_summary_b'
      ,     Question_short_wording_std = 'How many different types of crimes, malicious acts or '
                                       + 'violence motivated by religious hatred or bias occured?'
      , AG3.Answer_value
      ,     Answer_wording_std =
                   CASE
                        WHEN AG3.Answer_value = 0    THEN
                          'No'
                        WHEN AG3.Answer_value = 0.17 THEN
                          'Yes: 1 type of'
                        WHEN AG3.Answer_value = 0.33 THEN
                          'Yes: 2 types of'
                        WHEN AG3.Answer_value = 0.50 THEN
                          'Yes: 3 types of'
                        WHEN AG3.Answer_value = 0.67 THEN
                          'Yes: 4 types of'
                        WHEN AG3.Answer_value = 0.83 THEN
                          'Yes: 5 types of'
                        WHEN AG3.Answer_value = 1.00 THEN
                          'Yes: 6 types of'
                     END
      ,      Question_fk = 999999
      ,      Answer_fk   = 999999
FROM
(
/** Aggregated SHI_Q_1 **************************************************/
SELECT       pre.Nation_fk
           , pre.Ctry_EditorialName
           ,     Question_abbreviation_std = LEFT(pre.question_abbreviation_std, 6)
           , pre.Question_year
           ,     Answer_value              =  CAST( (SUM(pre.Answer_value)) as decimal(5,2))
FROM
(
/** SHI_Q_1_a ==> Country level *****************************************/
SELECT       KN.Nation_fk
           ,  N.Ctry_EditorialName
           ,  Q.Question_abbreviation_std
           ,  Q.Question_year
           ,    Answer_value  
                            = CASE
                                  WHEN A.Answer_value > 0 THEN 0.1667
                                                          ELSE 0
                         END
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]
  AND Q.Question_abbreviation_std like 'shi_01_a'
                                                                        
/***************************************** SHI_Q_1_a ==> Country level **/
UNION
/** SHI_Q_1_b, c, d, e, f ==> Province level ****************************/
SELECT        L.Nation_fk
           ,  N.Ctry_EditorialName
           ,  Q.Question_abbreviation_std
           ,  Q.Question_year
           ,    Answer_value  
                            = CASE
                                  WHEN SUM(A.answer_value) > 0 THEN 0.1667
                                                               ELSE 0
                         END
           --,    Answer_value = SUM(A.answer_value) 
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Locality]          L
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Locality_Answer]   KL
WHERE Q.[Question_pk] = A.[Question_fk]
  AND A.[Answer_pk]   = KL.[Answer_fk]
  AND L.[Locality_pk] = KL.[Locality_fk]
  AND N.[Nation_pk]   =
                           /* In order to keep consistent to previuos years 
                              Data by Province currently belonging to South Sudan
                              should considered data for South Sudan before 2010: */
                     CASE 
                            WHEN L.[Nation_fk]     = 237 
                             AND Q.[Question_Year] < 2010 
                            THEN                           197
                            ELSE                           L.[Nation_fk]
                     END 
  AND Q.question_abbreviation_std like 'shi_01_[b-f]'
group by     L.nation_fk
           , N.Ctry_EditorialName
           , Q.question_abbreviation_std
           , Q.question_year
/**************************** SHI_Q_1_b, c, d, e, f ==> Province level **/
                                                                )  pre
GROUP BY          pre.Nation_fk
           ,      pre.Ctry_EditorialName
           , LEFT(pre.question_abbreviation_std, 6)
           ,      pre.Question_year
/************************************************** Aggregated SHI_Q_1 **/
                                                                )  AG3
/******************************************************************************************************************  SHI_01_summary_b  ***/
)
                                                   AS ARD

JOIN [forum].[dbo].[Pew_Question_Displayable] AS PQD
  ON ARD.Question_abbreviation_std
   = PQD.Question_abbreviation_std
 AND ARD.Question_Year
   = PQD.Question_Year

WHERE   NOT (  ARD.[Nation_fk]         = 237
               AND ard.[Question_Year] = 2010
            ) 
--      AND    ARD.Question_abbreviation_std like 'SHI_05%'
--WHERE      ARD.Question_abbreviation_std like 'SHI_05%'
--ORDER BY   ARD.Question_abbreviation_std
--         , ARD.Nation_fk
--         , ARD.Question_Year
--         , ARD.Answer_value

--order by Ctry_EditorialName



GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[v__AllCodedData]    Script Date: 4/4/2016 8:33:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************************************************************************/
CREATE  VIEW
                      [dbo].[v__AllCodedData]
AS
----------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------
          [ACDv_row] = ROW_NUMBER()OVER(ORDER BY
                                          [Nation_fk]
                                        , [Question_Year]  )
        ,  *
----------------------------------------------------------------------------------------------------------------------------------------------------
--   FROM [forum_ResAnal].[dbo].[V3_W&Extras_by_Ctry&Year]
   FROM [for_x].[dbo].[V3_W&Extras_by_Ctry&Year]
----------------------------------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[v_Current_Survey_Questions]    Script Date: 4/4/2016 8:35:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************************************************************************************/
CREATE VIEW    [dbo].[v_Current_Survey_Questions]
AS
/*****************************************************************************************************************************************************/
-------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
        row_n                 =   'r:'
                                + STR((
                                  ROW_NUMBER()
                                  OVER(ORDER BY
                                                [Question_abbreviation_std]
                                               ,[Question_abbreviation]
                                                                                     )), 4,0 )

      , Std_Variable_Name     =   [Question_abbreviation_std]
      , Survey_Name           =   [Data_source_name]
      , Study_Name            =   [Source_Display_Name]
      , Reported_Year         =   [Question_Year]
      , Q_Abbrev_in_Survey    =   [Question_abbreviation]
      , Q_Wording_in_Survey   =   [Question_wording]
      , Notes                 =   [Notes]
      , Standard_Q_Wording    =   [Question_wording_std]
      , Standard_Q_short_Wdng =   [Question_short_wording_std]
      , Full_set_of_Answers   =   [ACode]

  FROM  [forum].[dbo].[Pew_Question]
      , [forum].[dbo].[Pew_Data_Source]
-------------------------------------------------------------------------------------------------------------------------------------------------------
      , (
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
            QCode 
            AS STD_Q
          , STUFF((    SELECT 
                               '   ||'
                             + ACode 
                                       AS [text()]
                              -- Add a string (,) before each value
                        FROM
-------------------------------------------------------------------------------------------------------------------------------------------------------
                            (
/* answer codes > ************************************************************************************************************************************/
                               SELECT 
                                      distinct
                                      QSfk         =   [Question_Std_fk] 
                                     ,ACode        =   STR([Answer_value], 4,0 )
                                                     + ': '
                                                     + [answer_wording_std]
                                 FROM [forum].[dbo].[Pew_Question]
                                    , [forum].[dbo].[Pew_Answer]
                               WHERE
                                      [Question_pk]
                                    = [Question_fk]
                               AND
                                      [Question_abbreviation_std]
                                      LIKE 'SVY%'
/* < answer codes ************************************************************************************************************************************/
                            )                                                                       A
-------------------------------------------------------------------------------------------------------------------------------------------------------
                        WHERE   A.QSfk
                              = Q.QSpk
-------------------------------------------------------------------------------------------------------------------------------------------------------
                        FOR XML PATH('') -- code to select it as XML
                        ), 1, 8, '' )    -- code to remove, from the 1st position, 7 characters (from the result)
            AS ACode
FROM
(
/* question codes > **********************************************************************************************************************************/
SELECT 
       QSpk         =   [Question_Std_pk] 
      ,QCode        =   [Question_abbreviation_std]
FROM
       [forum].[dbo].[Pew_Question_Std]
WHERE
       [Question_abbreviation_std]
       LIKE 'SVY%'
/* < question codes **********************************************************************************************************************************/
)                                                                                                     Q
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
         )                                                                                            ANSWERS
-------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE  
        [Data_source_pk]
      = [Data_source_fk]
  AND
        [Question_abbreviation_std]
      = [STD_Q]
      
  AND   [Question_abbreviation_std]     LIKE 'SVY%'
  AND   [Question_abbreviation]     NOT LIKE 'CSP%'
/*****************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[v_Data_for_WRD_Religion_Comparison]    Script Date: 4/4/2016 8:35:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  CREATE View [dbo].[v_Data_for_WRD_Religion_Comparison] as 
--Peter Crossing 13 Feb 2013 cf.emails with Juan Carlos; upd 26 Mar 2014; upd 13 Aug 2014
-- Assumes Nations = WRD Countries (232) otherwise must also sum by Country_fk

-- uncomment next line and last lines to check ctry totals
--Select Country_fk, sum(Nation_value) as sum_Nation_Value from (

--Wrap so that Religion_Group can link to either religions or subreligions
Select Top 100 percent Country_fk, R.Wrd_religion_code, nation_value_Source, RGpPercentage/100 as Nation_value from (
	--Isnull gets subreligion data if available from D or otherwise religion data from RV
	SELECT	N.Country_fk, ISNULL(D.nation_value_Source, ISNULL(RV.Working_Nation_Value_Source,RV.Notes)) as nation_value_Source, 
			ISNULL(D.Proportion, 100) * RV.Percentage / 100 AS RGpPercentage, 
			ISNULL(D.Sub_Religion_fk, RV.Religion_group_fk) AS MajorReligion_fk
	FROM    (
			--All Religion_Age_Sex_Value for Final set (field 28) with one additional field: Nation_Value_Source from Working set (Field 25)
			SELECT	RASV.*,
				RASV_Working.Nation_Value_Source AS Working_Nation_Value_Source
			FROM    Pew_Nation_Religion_Age_Sex_Value AS RASV INNER JOIN
					Pew_Nation_Religion_Age_Sex_Value AS RASV_Working 
						ON	RASV.Nation_fk = RASV_Working.Nation_fk 
						AND RASV.Religion_group_fk = RASV_Working.Religion_group_fk 
						AND RASV.Sex_fk = RASV_Working.Sex_fk 
						AND RASV.Age_fk = RASV_Working.Age_fk
			WHERE  (RASV.Sex_fk = 0) AND (RASV.Age_fk = 0)  AND (RASV.Nation_fk = 221) 
					AND (RASV.Field_fk = 77) AND (RASV_Working.Field_fk = 25)	
					--84 = Religious Distribution	Pew Estimate	Final	2050; 76=2010; 77=2015
					AND rasv.scenario_id = 4 --Scenario 4: Main demographic scenario with switching for 70 countries (equal switching transitions in all "switching age groups")
		) AS RV 
			Inner Join Pew_Nation N ON N.Nation_pk = RV.Nation_fk
			--Link to get subreligion data for subreligions where proportion > 0
			LEFT OUTER JOIN
			(Select * from Pew_Nation_Subreligion_Distribution where Proportion > 0)	AS D 
				ON RV.Religion_group_fk = D.Aggregated_Religion_fk 
				AND RV.Nation_fk = D.Nation_fk
	WHERE  (RV.Sex_fk = 0) AND (RV.Age_fk = 0) AND (RV.Field_fk = 77)  --AND (RV.Nation_fk = 74) '77 was 28
			AND (D.Majority_SubReligion_Range = 'mid' OR D.Majority_SubReligion_Range IS NULL)
 ) t1 
 LEFT OUTER JOIN Pew_Religion_Group R on R.Religion_Group_pk = t1.MajorReligion_fk
 Where RGpPercentage > 0
 Order by country_fk, RGpPercentage desc
-- uncomment to check ctry totals
--) t2
--group by Country_fk
--order by sum_Nation_Value

--select * from Pew_Religion_Group
--Select * from Pew_Nation_Subreligion_Distribution where Proportion > 0 and nation_fk=221
GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[v_GRI_20_01_all]    Script Date: 4/4/2016 8:37:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************************************************/
CREATE View [dbo].[v_GRI_20_01_all] as 
/**************************************************************************************************************************/
SELECT 
        Ctry_EditorialName
      , GRI_20_01_2007
      , GRI_20_01_2008
      , GRI_20_01_2009
      , GRI_20_01_2010
      , GRI_20_01_2011
      , GRI_20_01_D_2011
      , GRI_20_01_X_Buddhism_2009
      , GRI_20_01_X_Buddhism_2010
      , GRI_20_01_X_Buddhism_2011
      , GRI_20_01_X_CatholicChristianity_2009
      , GRI_20_01_X_CatholicChristianity_2010
      , GRI_20_01_X_CatholicChristianity_2011
      , GRI_20_01_X_Christianityunspecified_2009
      , GRI_20_01_X_Christianityunspecified_2010
      , GRI_20_01_X_Christianityunspecified_2011
      , GRI_20_01_X_Hinduism_2009
      , GRI_20_01_X_Hinduism_2010
      , GRI_20_01_X_Hinduism_2011
      , GRI_20_01_X_Islamunspecified_2009
      , GRI_20_01_X_Islamunspecified_2010
      , GRI_20_01_X_Islamunspecified_2011
      , GRI_20_01_X_Judaism_2009
      , GRI_20_01_X_Judaism_2010
      , GRI_20_01_X_Judaism_2011
      , GRI_20_01_X_OrthodoxChristianity_2009
      , GRI_20_01_X_OrthodoxChristianity_2010
      , GRI_20_01_X_OrthodoxChristianity_2011
      , GRI_20_01_X_Other_2009
      , GRI_20_01_X_Other_2010
      , GRI_20_01_X_Other_2011
      , GRI_20_01_X_ProtestantAnglicanChristianity_2009
      , GRI_20_01_X_ProtestantAnglicanChristianity_2010
      , GRI_20_01_X_ProtestantAnglicanChristianity_2011
      , GRI_20_01_X_ShiaIslam_2009
      , GRI_20_01_X_ShiaIslam_2010
      , GRI_20_01_X_ShiaIslam_2011
      , GRI_20_01_X_SunniIslam_2009
      , GRI_20_01_X_SunniIslam_2010
      , GRI_20_01_X_SunniIslam_2011

FROM
(
/* Restrictions' Data in long format ****************************************************************/
SELECT
        Nation_fk
      , Ctry_EditorialName
      --, Question_wording
      , Heading = CASE
                       WHEN Std_VarName = 'GRI_20_01'
                       THEN   
                              'GRI_20_01_'
                            + STR(Question_Year , 4,2 )
                       WHEN Std_VarName = 'GRI_20_01_DSCPTN'
                       THEN   
                              'GRI_20_01_D_'
                            + STR(Question_Year , 4,2 )
                       ELSE
                              'GRI_20_01_X_'
                            + Religion
                            + '_'
                            + STR(Question_Year , 4,2 )
                       
                       END
      , Answer  = CASE
                       WHEN Std_VarName = 'GRI_20_01_DSCPTN'
                       THEN   
                             Answer_wording
                       WHEN Std_VarName = 'GRI_20_01'
                       THEN   
                              STR((CAST(Answer_value as decimal (4,2))) , 4,2 )
                           + '   - '
                           + Answer_wording_std
                       ELSE
                              STR((CAST(Answer_value as decimal (4,2))) , 4,2 )
                       END
FROM
(
SELECT  level              = 'Ctry'
      , Nation_fk          = N.[Nation_pk]
      , Ctry_EditorialName = N.[Ctry_EditorialName]
      , Religion           = 'not detailed'
      , Question_Year      = Q.[Question_Year]
      , Std_VarName        = Q.[Question_abbreviation_std]
      , Question_wording   = Q.[Question_wording_std]
      , Answer_value       = A.[Answer_value]
      , Answer_wording_std = A.[answer_wording_std]
      , Answer_wording     = A.[answer_wording]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]

UNION

SELECT  level              = 'RGrp'
      , Nation_fk          = N.[Nation_pk]
      , Ctry_EditorialName = N.[Ctry_EditorialName]
      , Religion           =   
                              Replace(
                                (Replace(
                                   (Replace(G.[Pew_religion], ',', ''))
                                                            , ' ', ''))
                                                            , '/', '')
      , Question_Year      = Q.[Question_Year]
      , Std_VarName        = Q.[Question_abbreviation_std]
      , Question_wording   = Q.[Question_wording]
      , Answer_value       = A.[Answer_value]
      , Answer_wording_std = A.[answer_wording_std]
      , Answer_wording     = A.[answer_wording]
  FROM [forum].[dbo].[Pew_Answer]                   A
      ,[forum].[dbo].[Pew_Question]                 Q
      ,[forum].[dbo].[Pew_Nation]                   N
      ,[forum].[dbo].[Pew_Religion_Group]           G
      ,[forum].[dbo].[Pew_Nation_Religion_Answer]   KR
WHERE  Q.[Question_pk]       =  A.[Question_fk]
  AND  A.[Answer_pk]         = KR.[Answer_fk]
  AND KR.[Religion_group_fk] =  G.[Religion_group_pk]
  AND  N.[Nation_pk]         = KR.[Nation_fk]
                           /* Pull only data on Restrictions */
  AND (   Q.[Question_abbreviation_std] like 'SHI_%'
       OR Q.[Question_abbreviation_std] like 'GRI_%'  )
)
AS JOINED
where Std_VarName like 'GRI_20_01%'
/**************************************************************** Restrictions' Data in long format */
) AS rdlf
pivot (max (Answer) 
       for Heading
           in (
        GRI_20_01_2007
      , GRI_20_01_2008
      , GRI_20_01_2009
      , GRI_20_01_2010
      , GRI_20_01_2011
      , GRI_20_01_D_2011
      , GRI_20_01_X_Buddhism_2009
      , GRI_20_01_X_Buddhism_2010
      , GRI_20_01_X_Buddhism_2011
      , GRI_20_01_X_CatholicChristianity_2009
      , GRI_20_01_X_CatholicChristianity_2010
      , GRI_20_01_X_CatholicChristianity_2011
      , GRI_20_01_X_Christianityunspecified_2009
      , GRI_20_01_X_Christianityunspecified_2010
      , GRI_20_01_X_Christianityunspecified_2011
      , GRI_20_01_X_Hinduism_2009
      , GRI_20_01_X_Hinduism_2010
      , GRI_20_01_X_Hinduism_2011
      , GRI_20_01_X_Islamunspecified_2009
      , GRI_20_01_X_Islamunspecified_2010
      , GRI_20_01_X_Islamunspecified_2011
      , GRI_20_01_X_Judaism_2009
      , GRI_20_01_X_Judaism_2010
      , GRI_20_01_X_Judaism_2011
      , GRI_20_01_X_OrthodoxChristianity_2009
      , GRI_20_01_X_OrthodoxChristianity_2010
      , GRI_20_01_X_OrthodoxChristianity_2011
      , GRI_20_01_X_Other_2009
      , GRI_20_01_X_Other_2010
      , GRI_20_01_X_Other_2011
      , GRI_20_01_X_ProtestantAnglicanChristianity_2009
      , GRI_20_01_X_ProtestantAnglicanChristianity_2010
      , GRI_20_01_X_ProtestantAnglicanChristianity_2011
      , GRI_20_01_X_ShiaIslam_2009
      , GRI_20_01_X_ShiaIslam_2010
      , GRI_20_01_X_ShiaIslam_2011
      , GRI_20_01_X_SunniIslam_2009
      , GRI_20_01_X_SunniIslam_2010
      , GRI_20_01_X_SunniIslam_2011
              )
        ) 
       as PivotedData
/******************************************************************  Unpivoted Values: Nation Level   ***/
/**************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[V_Pew_LongIndex]    Script Date: 4/4/2016 8:37:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
--               [dbo].[Vx_f_LongIndex]
               [dbo].[V_Pew_LongIndex]
AS
/***************************************************************************************************************************************************************/
SELECT
        [Nation_fk]
      , [Ctry_EditorialName]
      , [YEAR]
         =        CASE
                  WHEN [Question_Year] <  2011 THEN 'MID-' + STR([Question_Year], 4,0)
                  ELSE                              'END-' + STR([Question_Year], 4,0)
                  END
      , [Question_Year]
      , [Variable]
      , [Value]
FROM
/**********************************************************/
(
/**********************************************************/
SELECT 
       [Nation_fk]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[GRI] -- float works fro rounding: don't re-cast
      ,[SHI] -- float works fro rounding: don't re-cast
      ,[GFI] -- float works fro rounding: don't re-cast
  FROM [for_x].[dbo].[V3_W&Extras_by_Ctry&Year]
/**********************************************************/
)                                                         B
/**********************************************************/
UNPIVOT
  (
     Value
FOR
     Variable
in (
               [GRI]  /*** GRI Yindex (d prec/scale)    ***/
             , [SHI]  /*** SHI Yindex (d prec/scale)    ***/
             , [GFI]  /*** GFI Yindex (d prec/scale)    ***/
                                               ) ) as UNPIVTD
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[v_Religion_Group_for_Surveys]    Script Date: 4/4/2016 9:05:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************************************************************************************/
CREATE VIEW    [dbo].[v_Religion_Group_for_Surveys]
AS
/*****************************************************************************************************************************************************/
SELECT
        Religion_fk                        = [Religion_group_pk]
      , Detailed_Name                      = [Pew_religion]
      , Standard_Name                      = [Pew_religion_lev05] 
      , Lowest_Aggregation_Level           = [Pew_religion_lev04] 
      , Second_Aggregation_Level           = [Pew_religion_lev03]
      , Third_Aggregation_Level            = [Pew_religion_lev02_5]
      , Fourth_Aggregation_Level           = [Pew_religion_lev02]
      , Fifth_Aggregation_Level            = [Pew_religion_lev01_5]
      , Highest_Aggregation_Level          = [Pew_religion_lev01]
      , ROW                                =   'CurrentRow_is_'
                                             + STR((
                                               ROW_NUMBER()
                                               OVER(ORDER BY
                                                             [Pew_religion_lev01]
                                                            ,[Pew_religion_lev01_5]
                                                            ,[Pew_religion_lev02]
                                                            ,[Pew_religion_lev02_5]
                                                            ,[Pew_religion_lev03]
                                                            ,[Pew_religion_lev04]
                                                            ,[Pew_religion_lev05]
                                                            ,[Pew_religion]
                                                                                     )), 4,0 )
  FROM [forum].[dbo].[Pew_Religion_Group]
WHERE [Pew_religion] NOT IN (
                               'Total'
                             , 'Affiliated'
                             , 'Other Religions and Folk Religionists'
                             , 'Buddhists and Hindus'
                             , 'Abrahamic Religions '
                                                                            )
/*****************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vd_01__Forum_IIASA_codes]    Script Date: 4/4/2016 9:06:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************************************************/
CREATE  VIEW
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

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vg_04__Switching_BasicRate]    Script Date: 4/4/2016 9:09:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE  VIEW
               [dbo].[vg_04__Switching_BasicRate]
AS
----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
       [SBRv_row]
                  =  ROW_NUMBER()
                     OVER(ORDER BY
                            [Nation_fk]     
                          , [Origin_religion_fk]
                          , [Sex_fk]
                          , [Destination_religion_fk] )
     , [Nation_fk]
     , [switching]                = CASE
                                       WHEN    O.[Pew_RelL02_Display]
                                             = D.[Pew_RelL02_Display]
                                       THEN
                                                  'no_switching_'
                                               +  D.[Pew_RelL02_Display]
                                                + '_'
                                                + SUBSTRING(S.[Sex], 1, 2)
                                       WHEN    O.[Pew_RelL02_Display]
                                            <> D.[Pew_RelL02_Display]
                                       THEN
                                                  O.[Pew_RelL02_Display]
                                                + '_to_'
                                                + D.[Pew_RelL02_Display]
                                                + '_'
                                                + SUBSTRING(S.[Sex], 1, 2)
                                     END
     , [Switch_Pct]
----------------------------------------------------------------------------------------------------------------------------------------------------------
  FROM
----------------------------------------------------------------------------------------------------------------------------------------------------------
       [Pew_Nation_Religion_Switching_Base_Rate]    R
     , [Pew_Religion_Group]                         O
     , [Pew_Religion_Group]                         D
     , [Pew_Sex]                                    S
----------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
        O.[Religion_group_pk]
     =  R.[Origin_religion_fk]
  AND
        D.[Religion_group_pk]
     =  R.[Destination_religion_fk]
  AND
        S.[Sex_pk]
     =  R.[Sex_fk]
  AND
        R.[Switch_Pct]
     <> 0
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_AgeSexValue]    Script Date: 4/4/2016 9:10:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_AgeSexValue]
AS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [ASVv_row]        = ROW_NUMBER()
                           OVER(ORDER BY
                                        [year]
                                      , [level]        DESC
                                      , [Nation_fk]
                                      , [Religion]
                                      , [Religion_fk]  DESC
                                      , [SubReligion]
                                      , [Sex_fk]
                                      , [Age_fk]             )
        , [Year]
        , [level]
        , [SubRegion6_code]
        , [Nation_fk]
        , [Region]
        , [Country]
        , [Religion_fk]
        , [Religion]
        , [SubReligion]
        , [Sex]
        , [Age]
        , [TotPopulat]        = CAST ( ROUND([TotPopulat]       , 0) AS DECIMAL (12,0) )
		                        /* CONVERT(varchar, CAST(ROUND([TotPopulat], 0) AS money), 0) -- */
        , [Population]        = CAST ( ROUND([Population]       , 0) AS DECIMAL (12,0) )
        , [Percentage]        = CAST ( ROUND([Percentage]       , 1) AS DECIMAL ( 5,1) )
        , [Pct_by_AgeCohorts] = CAST ( ROUND([Pct_by_AgeCohorts], 1) AS DECIMAL ( 6,2) )
        , [Data_source_fk]
        , [NV_Display_AgeStr_15Yrs] = [NV_Display]
        , [RV_Display_AgeStr_15Yrs] = [RV_Display]
        , [Sex_fk]
        , [Age_fk]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
   FROM [forum_ResAnal].[dbo].[vi_AgeSexValue_15Yrs]
WHERE
/***            [Sex_fk]       = 0        -- filter removed on March 2016   ***/
/***  AND                                                                   ***/
      NOT (     [Religion_fk] IS NULL
            AND [Year]        != '2010'   )                            --  150,697 (p)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
AND
                [Year]        IN ( 2010, 2020, 2030, 2040, 2050 )      --   68,239 (checked)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
AND
                [NV_Display]   = 1
AND
      NOT (     [Religion_fk] !=  52
            AND [RV_Display]   =   0      )                            --   34,159 (provisionally checked)
/***************************************************************************************************************************************************************/
GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_AgeSexValue_Pct_of_W]    Script Date: 4/4/2016 9:10:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_AgeSexValue_Pct_of_W]
AS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [ASpwv_row]           = ROW_NUMBER()
                                  OVER(ORDER BY
                                        [Religion]
                                      , [SubReligion]
                                      , [year]
                                      , [Sex_fk]
                                      , [Age]
                                      , [level]        DESC
                                      , [Nation_fk]         )
        , [Year]
        , [level]
        , [SubRegion6_code]
        , [Nation_fk]
        , [Region]
        , [Country]
        , [Religion_fk]
        , [Religion]
        , [SubReligion]
        , [Sex]
        , [Age]
        , [Population]
        , [Percentage_of_WP]
        , [Data_source_fk]
        , [NV_Display_AgeStr_15Yrs]
        , [RV_Display_AgeStr_15Yrs]
        , [Sex_fk]
        , [Age_fk]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                [forum_ResAnal].[dbo].[vi_AgeSexValue_15Yrs_Pct_of_W]                                     -- drop table if existent
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
                [NV_Display_AgeStr_15Yrs]   = 1                                     --  ONLY data to be displayed by population
AND
      NOT (     [Religion_fk]              !=  52
            AND [RV_Display_AgeStr_15Yrs]   =   0      )                            --  ONLY data to be displayed by religion
AND
                [Religion_fk]               IS NOT NULL                              --  exclude Christian sub-groups
/***************************************************************************************************************************************************************/


GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_CutPoints]    Script Date: 4/4/2016 9:11:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_CutPoints]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [CPv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY
                            Field_name
                          , Field_year      )
       , Field_fk      =    Field_pk
       , Index_Name    =    Field_Name
       , Index_Year    =    Field_year
       , Index_Type
       , Index_Level
       , Index_Level_Point
       , CutPoint
       , Data_source_fk
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--select *
FROM     [Pew_Field] AS PF
--where
--[Field_type] IN ( 'GRI', 'SHI', 'GFI')

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
JOIN 
		(
		SELECT
			   Index_Type         = [Field_type]
			  ,Index_Level        = [Level] 
			  ,Index_Level_Point  = [Point]
			  ,CutPoint           = [CutPoint]
		  FROM [Pew_Index_Cut_Points]
			 , [Pew_Field]
		WHERE
			   [Field_pk]
			  =[Field_fk]
		  AND
---------------Notice that table [Pew_Index_Cut_Points] only has 4 years: wshould it be redesigned?
			   [Field_fk] IN (15, 16, 48)    -- limiting to these fields makes possible apply same assumption to all years
		) AS Pew_Fixed_Index_Cut_Points
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
   ON   [Index_Type]
      = [Field_type]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_FertilityRate]    Script Date: 4/4/2016 9:11:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_FertilityRate]
AS
---------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
          TFRv_row
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [YearPeriod]
                           , [level] DESC
                           , [Nation_fk]
                           , [Religion]      )
     , [YearPeriod]
     , [level]
     , [Nation_fk]
     , [Country]
     , [Religion_fk]
     , [Religion]
     , [TFR]                = CAST ( ROUND([TFR], 1) AS DECIMAL ( 4,1) )
FROM      
        [forum_ResAnal].[dbo].[vi_FertilityRate]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
                [Display]     =   1                                   --   3,725 (provisionally checked)
  AND           [YearPeriod]  in  ( '2010-2015', '2040-2045', '2020-2025', '2050-2055', '2030-2035' )

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Field]    Script Date: 4/4/2016 9:12:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Field]
AS
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
          [T_row]
          =  ROW_NUMBER()
             OVER(ORDER BY  [Field_pk] )
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,[Field_name]
      ,[Field_note]
      ,[Field_type]
      ,[Field_year]
      ,[Data_source_fk]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  FROM [forum].[dbo].[Pew_Field]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_ForMoreInformationLinks_by_Region_or_Ctry]    Script Date: 4/4/2016 9:12:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_ForMoreInformationLinks_by_Region_or_Ctry]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [RLCv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY
                            N.[Nation_fk]
                          , R.[Report_SortingNumber]      )
       , N.Nation_fk
       , N.Ctry_EditorialName
       , R.Report_SortingNumber
       , S.Source_Display_Name
       , S.Data_source_url
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
     [Pew_Data_Source]              AS S
JOIN [Pew_Display_Reports]          AS R
  ON    Data_source_fk
      = Data_source_pk
JOIN [vi_Nation_Attributes]         AS N
  ON    R.Nation_fk
      = N.Nation_fk
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
        GRF_Level = 'for_more_info'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_ForMoreInformationLinks_by_Religion]    Script Date: 4/4/2016 9:13:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_ForMoreInformationLinks_by_Religion]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [RLRv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY
                            R.[Religion_fk]
                          , R.[Report_SortingNumber]      )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--       , Display_Reports_pk
--       , R.Data_source_fk
       , R.Religion_fk
       , G.Pew_RelL02_Display
       , R.Report_SortingNumber
--       , S.Data_source_name
--       , S.Data_source_description
       , S.Source_Display_Name
       , S.Data_source_url
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
     [Pew_Data_Source]              AS S
JOIN [Pew_Display_Reports]          AS R
  ON    Data_source_fk
      = Data_source_pk
JOIN [Pew_Religion_Group]           AS G
  ON    Religion_fk
      = Religion_group_pk
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
        GRF_Level = 'for_more_info'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Locations_by_Question]    Script Date: 4/4/2016 9:14:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Locations_by_Question]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [LbyQv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY  [Topic_sorting]
                           ,[SubTopic_Sorting]
                           ,[BySubTopic_QuestionSort]
                           ,[Question_abbreviation_std]
                           ,[Nation_fk]                 )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      ,[Question_abbreviation_std]
      ,[Nation_fk]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      ,[Topic]
      ,[SubTopic]
      ,[Question_short_wording_std]
      ,[Location]
      --,[K]
  FROM [vi_Topic&Question_Displayable]
/***************************************************************************************************************************************************************/
FULL JOIN
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
SELECT DISTINCT
       [Nation_fk]
      ,[Location]           = CASE
                              WHEN [level] > 1
                              THEN [Region]
                              ELSE [Ctry_EditorialName]
                              END
      ,[Index_abbreviation]          [K]
  FROM [forum].[dbo].[vi_Restrictions_Index_by_CtryRegion&Yr]  
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UNION ALL
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT DISTINCT
       [Nation_fk]
      ,[Region]                      [Location]
      ,[Question_abbreviation_std]   [K]
  FROM [vi_Restrictions_Tables_by_region&world]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UNION ALL
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT DISTINCT
       [Nation_fk]
      ,[Country]                     [Location]
      ,[Question_abbreviation_std]   [K]
  FROM [vi_Survey_Tables_Displayable]
/***************************************************************************************************************************************************************/
) LocByQ
ON
       [Question_abbreviation_std] = [K]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
WHERE
       [Topic]                    != 'Population Characteristics'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-- use this row for test besides OR instead of the fisrt row ([Question_short_wording_std] != '') -----------------------------------------------------------*/
     --and
     --( [Question_abbreviation_std] IS NULL or [K] IS NULL )
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_MedianAge]    Script Date: 4/4/2016 9:14:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************************************************/
CREATE  VIEW
                      [dbo].[vi_MedianAge]
AS
----------------------------------------------------------------------------------------------------------------------------
SELECT
          [MAv_row]      =  ROW_NUMBER()OVER(ORDER BY
                                          Year
                                        , level     DESC
                                        , Nation_fk
                                        , Religion
                                        , Sex            )
         , [YEAR]	
         , [level]	
         , [Nation_fk]	
         , [Country]	
         , [Religion_fk]	
         , [Religion]	
         , [Sex]	
         , [MedianAge]	--      = CAST ( ROUND([MedianAge], 0) AS DECIMAL ( 2,0) )
         , [MedAgeCohort]	
----------------------------------------------------------------------------------------------------------------------------
   FROM [forum_ResAnal].[dbo].[vi_MedianAge]
----------------------------------------------------------------------------------------------------------------------------
WHERE
        [RV_Display_MedianAge]  = 1      /* data can be displayed for median age */
 AND
        [Sex]     = 'all'                /* data cannot be displayed by gender   */
GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Migrants]    Script Date: 4/4/2016 9:16:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************************************************/
CREATE  VIEW
                        [dbo].[vi_Migrants]
AS
----------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          [MbC_row]       =  ROW_NUMBER()OVER(ORDER BY
                                             [Level]       DESC
                                           , [Nation_fk]
                                           , [Religion_fk]
                                           , [Direction]
                                                                )
        , [Direction]
        , [Level]
        , [Nation_fk]
        , [Location]
        , [Religion_fk]
        , [Religion]
        , [NUM_Migrants]
        , [PCT_Migrants]
        , [NUM_Migrants_ds]
        , [PCT_Migrants_ds]
----------------------------------------------------------------------------------------------------------------------------
  FROM
        [forum_ResAnal].[dbo].[vi_Migrants]
WHERE
          [Religion_fk] != 52
/**************************************************************************************************************************/
GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Migrants_by_Ctry]    Script Date: 4/4/2016 9:17:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************************************************/
CREATE  VIEW
                        [dbo].[vi_Migrants_by_Ctry]
AS
----------------------------------------------------------------------------------------------------------------------------
SELECT
       *
  FROM
        [forum_ResAnal].[dbo].[vi_Migrants_by_Ctry]
/**************************************************************************************************************************/
GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Nation_Attributes]    Script Date: 4/4/2016 9:27:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Nation_Attributes]
AS
/***************************************************************************************************************************************************************/
SELECT
       *
  FROM
        [forum_ResAnal].[dbo].[vi_Nation_Attributes]
/***************************************************************************************************************************************************************/
GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Nation_Flags]    Script Date: 4/4/2016 9:33:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Nation_Flags]
AS
/***************************************************************************************************************************************************************/
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
         [Nation_fk]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , [SubRegion6_code]    =  CASE
                                     WHEN [SubRegion6] = 'North America'             THEN 1001
                                     WHEN [SubRegion6] = 'Latin America-Caribbean'   THEN 1002
                                     WHEN [SubRegion6] = 'Europe'                    THEN 1003
                                     WHEN [SubRegion6] = 'Middle East-North Africa'  THEN 1004
                                     WHEN [SubRegion6] = 'Sub-Saharan Africa'        THEN 1005
                                     WHEN [SubRegion6] = 'Asia-Pacific'              THEN 1006
                                 END
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , [Ctry_EditorialName]
       , [SubRegion6]
       , [Flag_name]
       , [Flag_image]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  FROM   [Pew_Flag]
     ,   [Pew_Nation]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
         [Nation_pk]
       = [Nation_fk]
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_QuestionMetadata_Svy&Restr]    Script Date: 4/4/2016 10:47:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
              [dbo].[vi_QuestionMetadata_Svy&Restr]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        DISTINCT
        [QMv_row] = ROW_NUMBER()OVER(ORDER BY
                                                [Topic_fk]
                                               ,[Question_abbreviation_std]
                                                                            )
      , *
FROM
/***************************************************************************************************************************************************************/
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        DISTINCT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [Topic_fk]
      ,[Topic]
      ,[SubTopic]
      ,[Question_Std_fk]              = [Question_Std_fk]
      ,[Question_abbreviation_std]
      ,[FootNote_by_Topic&Question]   = [Footnote]
      ,[About_the_Data_link]          = [About_the_Data_link]
      ,[RelatedPewResearchReports]    = [Reports]
      ,[Sources_by_Question]          = REPLACE([Q_Sources],': Global Restrictions on Religion studies)  (',', ')
      ,[Question_short_wording_std]
      ,[DetailedWording_by_Question]  = CASE
                                             WHEN [Question_abbreviation_std] LIKE 'SVY%'
                                               --OR [Q_Years]                   IS NULL
                                             THEN [Q_Wording]
                                             ELSE   '('
                                                  + [Q_Years]
                                                  + ': '
                                                  + [Question_short_wording_std]
                                                  + ')'
                                        END
      ,[Notes_by_Question]            = [Q_Notes]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
       [forum_ResAnal].[dbo].[vi_Topic&Question&Related_Displayable]    TL
      ,[forum_ResAnal].[dbo].[vi_QMetadata_Wording&Note&Source]         QL
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
 WHERE
           [Question_Std_fk]
         = [Q_Std_fk]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
)  mytable
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Religion_Attributes]    Script Date: 04/04/2016 23:06:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
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

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Reportable_DataSource_Joins]    Script Date: 04/05/2016 04:21:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Reportable_DataSource_Joins]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [RDSJv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY
                            List_pk
                          , item_fk
                          , Report_SortingNumber      )
       , List          =    L.List
       , RelatedItem   =    CASE
                            WHEN List_pk = 1 THEN 'Country'
                            WHEN List_pk = 2 THEN 'Locality'
                            WHEN List_pk = 3 THEN 'Religion'
                            WHEN List_pk = 4 THEN 'Topic'
                            WHEN List_pk = 5 THEN 'Question'
                            END
       , List_pk       =    L.List_pk
       , Nation_fk     =    CASE WHEN List_pk = 1 THEN item_fk
                                 ELSE NULL
                            END
       --, Locality_fk   =    CASE WHEN List_pk = 2 THEN item_fk
       --                          ELSE NULL
       --                     END
       , Religion_fk   =    CASE WHEN List_pk = 3 THEN item_fk
                                 ELSE NULL
                            END
       , Topic_fk      =    CASE WHEN List_pk = 4 THEN item_fk
                                 ELSE NULL
                            END
       --, Question_fk   =    CASE WHEN List_pk = 5 THEN item_fk
       --                          ELSE NULL
       --                     END
       , Report_SortingNumber
       , Data_source_fk
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM [forum].[dbo].[Pew_Display_Reports] R
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
JOIN [forum].[dbo].[Pew_Lists]           L
  ON   List_pk
     = List_fk
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_ReportLinks_by_Region_or_Ctry]    Script Date: 04/05/2016 04:21:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_ReportLinks_by_Region_or_Ctry]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [RLCv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY
                            N.[Nation_fk]
                          , R.[Report_SortingNumber]      )
--       , Display_Reports_fk           = R.Display_Reports_pk
--       , R.Data_source_fk
       , N.Nation_fk
       , N.Ctry_EditorialName
       , R.Report_SortingNumber
--       , S.Data_source_name
--       , S.Data_source_description
       , S.Source_Display_Name
       , S.Data_source_url
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
     [Pew_Data_Source]              AS S
JOIN [Pew_Display_Reports]          AS R
  ON    Data_source_fk
      = Data_source_pk
JOIN [vi_Nation_Attributes]         AS N
  ON    R.Nation_fk
      = N.Nation_fk
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
        GRF_Level = 'reports'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_ReportLinks_by_Religion]    Script Date: 04/05/2016 04:22:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_ReportLinks_by_Religion]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [RLRv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY
                            R.[Religion_fk]
                          , R.[Report_SortingNumber]      )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--       , Display_Reports_pk
--       , R.Data_source_fk
       , R.Religion_fk
       , G.Pew_RelL02_Display
       , R.Report_SortingNumber
--       , S.Data_source_name
--       , S.Data_source_description
       , S.Source_Display_Name
       , S.Data_source_url
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
     [Pew_Data_Source]              AS S
JOIN [Pew_Display_Reports]          AS R
  ON    Data_source_fk
      = Data_source_pk
JOIN [Pew_Religion_Group]           AS G
  ON    Religion_fk
      = Religion_group_pk
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
        GRF_Level = 'reports'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Restrictions_byCtryYr]    Script Date: 04/05/2016 04:23:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
              [dbo].[vi_Restrictions_byCtryYr]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
           [RQYDv_row]
         = ROW_NUMBER()OVER(ORDER BY
           [VR].[Nation_fk]
         , [VR].[Question_Year]
         , [VR].[QA_std]            )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      ,    [Q_Level]                     = CASE
                                          ----- slightly different wording: -------------------------------------------------------------------------------------
                                                WHEN [entity] = 'Stored by Country'
                                                THEN            'code stored by country'
                                                ELSE            'aggregated by country'                                                   END
                                          --------------------------------------------------------------------------------------------------- < recode ends -----
      , DQ.[Nation_fk]
      , VR.[Ctry_EditorialName]
      , DQ.[Question_Year]
      , DQ.[Question_abbreviation_std]      
      ,    [Question_short_wording_std]  = [QW_std]
      , VR.[Answer_value]
      , VR.[Answer_wording_std]
      ,    [Question_fk]                 = ISNULL([Question_fk], 999999)
      ,    [Answer_fk]                   = ISNULL([Answer_fk]  , 999999)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*** country values and calculated median region & world values (from vr working tables)   *********************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [forum_ResAnal].[dbo].[vr_06w_LongData_ALL]                                                     VR
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/********************************************************************* country values and calculated median region & world values (from vr working tables)   ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
RIGHT OUTER JOIN
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
    (   SELECT *
        FROM
              [forum].[dbo].[vi_Restrictions_Ctry&Q&Yr_Displayable]
        WHERE Question_abbreviation_std NOT IN ('GRI', 'SHI') /* not for this view */   )         AS   DQ
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  ON   VR.Question_Year
     = DQ.Question_Year
 AND   VR.Nation_fk
     = DQ.Nation_fk
          --  NOTE: this recoding is NECESSARY to avoid introducing different [QA_std] codes from those in the database
          --        we should keep a unique QA_std for the same question in all data sent to Intridea (2014.06.18.jceo)
 AND   CASE WHEN VR.QA_std = 'GRI_20_top'
            THEN             'GRI_20_SUMMARY'
            WHEN VR.QA_std = 'GRI_20_03_top'
            THEN             'GRI_20_03_SUMMARY'
            --WHEN VR.QA_std = 'GRI_08'
            --THEN             'GRI_08_XXXXXXXXX'
            --WHEN VR.QA_std = 'GRI_08_for_index'
            --THEN             'GRI_08'
            --WHEN VR.QA_std = 'SHI_11'
            --THEN             'SHI_11_XXXXXXXXX'
            --WHEN VR.QA_std = 'SHI_11_for_index'
            --THEN             'SHI_11'
            ELSE VR.QA_std                       END
     = DQ.Question_abbreviation_std
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Restrictions_Ctry&Q&Yr_Displayable]    Script Date: 04/05/2016 04:24:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
              [dbo].[vi_Restrictions_Ctry&Q&Yr_Displayable]
AS
/***************************************************************************************************************************************************************/
-- Notice that:
-- the statement " distinct Question_abbreviation_std, Question_Year '
-- does not give all cases, because:
--      - GFI, GRI, SHI        are in Pew_Question_Std but not in Pew_Question
--      - GRI_20_SUMMARY &
--        GRI_20_03_SUMMARY    are in Pew_Question_Std but not in Pew_Question for 2012
--      - SHI_01_summary_a &
--        SHI_01_summary_b     are in Pew_Question_Std but not in Pew_Question by year
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*** Restrictions Questions for each year **********************************************************************************************************************/
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
         [RQYDv_row]
         = ROW_NUMBER()OVER(ORDER BY
           [Nation_fk]
          ,[Question_abbreviation_std]
          ,[Question_Year]             )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       ,  Nation_fk
       ,  Ctry_EditorialName
       ,  Q_Level                    = CASE
                                       WHEN Question_abbreviation_std
                                            IN (  'GFI'
                                                , 'GRI'
                                                , 'GRI_20_summary'
                                                , 'GRI_20_03_summary'
                                                , 'SHI'
                                                , 'SHI_01_summary_a'
                                                , 'SHI_01_summary_b'  )
                                       THEN   'aggregated by country'
                                       ELSE   'code stored by country'
                                       END
       ,  Question_abbreviation_std
       ,  Question_short_wording_std
       ,  Question_Year
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
/*** Restrictions Questions for each year (filter not included country/year ************************************************************************************/
SELECT * FROM
/*** List of years (should be updated in the corresponding table) **********************************************************************************************/
(  SELECT [Question_Year] = [Year]
     FROM [Pew_Display_by_Year]
    WHERE [Restrictions_Data] = 1 
) AS YR
/************************************************************************************************************************* List of years (should be updated) ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
CROSS JOIN
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
/*** List of countries (should be evetually updated) ***********************************************************************************************************/
 SELECT 
        [Nation_fk] = [Nation_pk]
      , [Ctry_EditorialName]
   FROM [forum].[dbo].[Pew_Nation]
 WHERE   [Nation_pk] NOT IN
                            (    	4	 -- 	American Samoa
                               , 	7	 -- 	Anguilla
                               , 	11	 -- 	Aruba
                               , 	23	 -- 	Bermuda
                               , 	29	 -- 	British Virgin Islands
                               , 	38	 -- 	Cayman Islands
                               , 	41	 -- 	Channel Islands
                               , 	48	 -- 	Cook Islands
                               , 	66	 -- 	Faeroe Islands
                               , 	67	 -- 	Falkland Islands (Malvinas)
                               , 	71	 -- 	French Guiana
                               , 	72	 -- 	French Polynesia
                               , 	78	 -- 	Gibraltar
                               , 	80	 -- 	Greenland
                               , 	82	 -- 	Guadeloupe
                               , 	83	 -- 	Guam
                               , 	89	 -- 	Vatican City
                               , 	99	 -- 	Isle of Man
                               , 	129	 -- 	Martinique
                               , 	132	 -- 	Mayotte
                               , 	139	 -- 	Montserrat
                               , 	147	 -- 	Netherlands Antilles
                               , 	148	 -- 	New Caledonia
                               , 	153	 -- 	Niue
                               , 	154	 -- 	North Korea
                               , 	155	 -- 	Northern Mariana Islands
                               , 	169	 -- 	Puerto Rico
                               , 	171	 -- 	Reunion
                               , 	175	 -- 	St. Helena
                               , 	178	 -- 	St. Pierre and Miquelon
                               , 	209	 -- 	Tokelau
                               , 	215	 -- 	Turks and Caicos Islands
                               , 	222	 -- 	U.S. Virgin Islands
                               , 	228	 -- 	Wallis and Futuna
                               , 	238  --		Curacao
                               , 	239  --		Sint Maarten
                               , 	240	)-- 	Caribbean Netherlands
/********************************************************************************************************************** List of countries (should be updated ***/
) AS CTRY
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
CROSS JOIN
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
/*** MAIN Restrictions Questions *******************************************************************************************************************************/
SELECT
          Question_abbreviation_std
        , Question_short_wording_std
  FROM     [forum].[dbo].[Pew_Question_std]
WHERE     Question_abbreviation_std IN
(
  'GRI'
, 'GRI_01'
, 'GRI_02'
, 'GRI_03'
, 'GRI_04'
, 'GRI_05'
, 'GRI_06'
, 'GRI_07'
, 'GRI_08'
, 'GRI_09'
, 'GRI_10'
, 'GRI_11'
, 'GRI_12'
, 'GRI_13'
, 'GRI_14'
, 'GRI_15'
, 'GRI_16'
, 'GRI_17'
, 'GRI_18'
, 'GRI_19'
--, 'GRI_19_b'
--, 'GRI_19_c'
--, 'GRI_19_d'
--, 'GRI_19_e'
--, 'GRI_19_f'
, 'GRI_20_SUMMARY'
, 'GRI_20_01'
, 'GRI_20_02'
, 'GRI_20_03_SUMMARY'
, 'GRI_20_03_a'
, 'GRI_20_03_b'
, 'GRI_20_03_c'
, 'GRI_20_04'
, 'GRI_20_05'
, 'SHI'
--, 'SHI_01_summary_a'   -- removed, cannot be tabulated as displayed in GRF website (2014.06.18.jceo)
, 'SHI_01_summary_b'
, 'SHI_02'
, 'SHI_03'
, 'SHI_04'
, 'SHI_05'
, 'SHI_06'
, 'SHI_07'
, 'SHI_08'
, 'SHI_09'
, 'SHI_10'
, 'SHI_11'
, 'SHI_12'
, 'SHI_13'
--, 'GFI'                -- removed, it is not currently displayed in GRF website (2014.06.18.jceo)
)
/******************************************************************************************************************************* MAIN Restrictions Questions ***/
) AS VARS
/********************************************************************************************************************** Restrictions Questions for each year ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE 
      NOT ( Nation_fk = 237 AND Question_Year < 2011)      -- filter out data not gathered for South Sudan
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
) AS REYF
/************************************************************************************ Restrictions Questions for each year (filter not included country/year ***/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Restrictions_Index_by_CtryRegion&Yr]    Script Date: 04/05/2016 04:24:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Restrictions_Index_by_CtryRegion&Yr]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [RIYv_row]          =  ROW_NUMBER()
                                 OVER(ORDER BY
                                                [Year]
                                              , [level]              DESC
                                              , [Nation_fk]
                                              , [Index_abbreviation]       )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , [Year]
       , [level]
       , [SubRegion6_code]    = [Region6_code]
       , [Region]             = [Region6]
       , [Nation_fk]
       , [Ctry_EditorialName]
       , [Index_abbreviation]
       , [Index_name]
       , [Index_value]        = [I_Rounded_value]
       , [Index_level]
       , [Index_Year]
       , [ByRegion]           = [ByRegion6]
       , [ByWorld]
       , [ByWorld&Region]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
/*** country values and calculated median region & world values (from vr working tables)   *********************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]                         VR
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
     , (  SELECT DISTINCT
                 [Index_level]        = [Level]
                ,[Scaled_Level_value]
            FROM [forum].[dbo].[Pew_Index_Cut_Points] )                                  CP
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/********************************************************************* country values and calculated median region & world values (from vr working tables)   ***/
WHERE  
       [I_Scaled_value]
     = [Scaled_Level_value]
  AND  [Index_abbreviation] IN ('GRI' , 'SHI')
  AND  [level]              !=  2.5
--AND  [YEAR]                <  2013
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Restrictions_Q&Yr_Displayable]    Script Date: 04/05/2016 04:26:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Restrictions_Q&Yr_Displayable]
AS
/***************************************************************************************************************************************************************/
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
         [RQYDv_row]
         = ROW_NUMBER()OVER(ORDER BY
           [Question_abbreviation_std]
          ,[Question_Year]             )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       ,  *
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM  (
        SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                  DISTINCT
                  [Question_abbreviation_std]   = [QA_std]
               ,  [Question_short_wording_std]  = [QS_std]
               ,  [Question_Year]               = [Year]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
               [forum_ResAnal].[dbo].[vi_Both_Svy&Rstr_Yr&Q&A_Displayable]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-------- filter questions to be displayed for Restrictions ------------------------------------------------------------------------------------------------------
WHERE
       [QA_std]     not like 'SVY%'
/* AND [QA_std]     not like '%scaled'  */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
)DistQY
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Restrictions_Tables_by_region&world]    Script Date: 04/05/2016 04:26:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
              [dbo].[vi_Restrictions_Tables_by_region&world]
AS
/***  Begining of select statement *****************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
            [RTRWv_row]         =  ROW_NUMBER()
                                   OVER(ORDER BY  [Year]
                                                , [level]                       DESC
                                                , [Nation_fk]
                                                , [Question_abbreviation_std]
                                                , [Sorting_Order_v]                   )
        ,   [Year]
        ,   [level]
        ,   [Nation_fk]
        ,   [Region]
        ,   [Question_abbreviation_std]
        ,   [Question]
        ,   [Sorting_Order_v]
        ,   [Bar_Chart_Labels]
        ,   [frequency]
        ,   [percentage]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
              [forum_ResAnal].[dbo].[vi_Restrictions_Tables_by_region&world]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
            [level]  != 2.5

/***************************************************************************************************************************************************************/
GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Sources_by_Tabs&Charts]    Script Date: 04/05/2016 04:27:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Sources_by_Tabs&Charts]
AS
/***************************************************************************************************************************************************************/
/*=============================================================================================================================================================*/
SELECT 
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
          [STCv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY [Country]
                          ,[T]
                          ,[C] )
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [Nation_fk]
        , [Country]
        , [TAB]
        , [Chart]
        , [Source_Display_Name]
        , [Data_source_url]
        , [TabNumber]           = [T]
        , [ChartNumber]         = [C]
        , [Question_fk]
        , [Question_Std_fk]
--      , [Display_Question_fk]
/*=============================================================================================================================================================*/
FROM
/*=============================================================================================================================================================*/
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
SELECT [Nation_fk]
      ,[Country]          =  [Ctry_EditorialName]
      ,[T]
      ,[C]
      ,[TAB]
      ,[Chart]
      ,[Data_source_fk]
      ,[Question_fk]         = NULL
      ,[Question_Std_fk]     = NULL
      ,[Display_Question_fk] = NULL
  FROM [forum].[dbo].[vi_Nation_Attributes]
cross join
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
          SELECT T =  1, C =  1, [TAB] = 'Demographics'          , [Chart] = 'Religious Affiliation'              , [Data_source_fk] =  71
UNION ALL SELECT T =  1, C =  2, [TAB] = 'Demographics'          , [Chart] = 'Religions Affiliation Over Time'    , [Data_source_fk] =  71
UNION ALL SELECT T =  1, C =  3, [TAB] = 'Demographics'          , [Chart] = 'Age Structure'                      , [Data_source_fk] =  71
UNION ALL SELECT T =  1, C =  4, [TAB] = 'Demographics'          , [Chart] = 'Median Age'                         , [Data_source_fk] =  71
UNION ALL SELECT T =  1, C =  5, [TAB] = 'Demographics'          , [Chart] = 'Total Fertility Rate'               , [Data_source_fk] =  71
UNION ALL SELECT T =  3, C =  1, [TAB] = 'Religious Restrictions', [Chart] = 'Restrictions on Religion'           , [Data_source_fk] =   1
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
) ADDEDTABS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
SELECT 
        DISTINCT                                      -- Exclude dulicates for each answer
       [Nation_fk]           =  ST.[Nation_fk]
      ,[Country]             =  ST.[Country]
      ,[T]                   =  [TabNumber]
      ,[C]                   =  [ChartNumber]
      ,[TAB]                 = 'Public Opinion'
      ,[Chart]               =  ST.[Question_short_wording_std]
      ,[Data_source_fk]      =  ST.[Data_source_fk]
      ,[Question_fk]         =  DQ.[Question_fk]
      ,[Question_Std_fk]     =  ST.[Question_Std_fk]
      ,[Display_Question_pk] =  DQ.[Display_Question_pk]
FROM
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
       [forum].[dbo].[vi_Survey_Tables_Displayable]                ST
RIGHT
JOIN   [forum].[dbo].[Pew_Display_Question]                        DQ
    ON  ST.[Nation_fk]
      = DQ.[Nation_fk]
   AND  ST.[Question_pk]
      = DQ.[Question_fk]
WHERE  ST.[QLevel_code]  = '1. National Level'          -- Implies: Sex='All Respondents' / Age='All' / Religion=' N/A'
  AND  DQ.[Question_fk] IS NOT NULL
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
) AllRows
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/
JOIN
/***************************************************************************************************************************************************************/
       [forum].[dbo].[Pew_Data_Source]
/***************************************************************************************************************************************************************/
ON  
       [Data_source_pk]
     = [Data_source_fk]
/***************************************************************************************************************************************************************/
/*=============================================================================================================================================================*/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Survey_Tables_Displayable]    Script Date: 04/05/2016 04:28:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Survey_Tables_Displayable]
AS
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
            STDv_row      = ROW_NUMBER()
                            OVER(ORDER BY STDv_row)
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
          , QLevel_code
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
          , Percentage_ds
          , Nation_fk
          , Religion_fk
          , Answer_fk
          , Country
          , Religion
          , Sex
          , Age
          , CrossQA
          , SbjctQ_ab
          , SbjctQ_tx
          , Data_source_fk
          , Question_pk
          , Question_abbreviation
          , SampleSize
          , Question_Std_fk
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
FROM        [forum_ResAnal].[dbo].[vi_Survey_Tables_Displayable]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_SurveyQuestion&Answers_Unique]    Script Date: 04/05/2016 04:28:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_SurveyQuestion&Answers_Unique]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 

         [SQAv_row]
         = ROW_NUMBER()OVER(ORDER BY
         [Question_abbreviation_std]
       , [SortBy]                     )
       , [Question_abbreviation_std]
       , [Question_short_wording_std]
       , [SortBy]
       , [Answer]
  FROM 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       (  SELECT 
                 DISTINCT
                 [Question_abbreviation_std]
               , [Question_short_wording_std]
               , [SortBy]
               , [Answer]
            FROM [vi_Survey_Tables_Displayable]  ) T
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_SurveyQuestions_ByYear]    Script Date: 04/05/2016 04:28:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_SurveyQuestions_ByYear]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
         [SQYv_row]
          = ROW_NUMBER()OVER(ORDER BY
         [Question_abbreviation_std]
       , [Question_Year]                     )
       , [Question_abbreviation_std]
       , [Question_short_wording_std]
       , [Question_Year]
  FROM 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       (  SELECT 
                 DISTINCT
                 [Question_abbreviation_std]
               , [Question_short_wording_std]
               , [Question_Year]
            FROM [vi_Survey_Tables_Displayable]  ) T
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_SurveyQuestions_Unique]    Script Date: 04/05/2016 04:29:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_SurveyQuestions_Unique]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
       [SQUv_row] = ROW_NUMBER()OVER(ORDER BY
       [Question_short_wording_std]          )
     , [Question_short_wording_std]
  FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      (  SELECT
                DISTINCT
                [Question_short_wording_std]
           FROM [vi_Survey_Tables_Displayable]  ) T
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Thresholds]    Script Date: 04/05/2016 04:30:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Thresholds]
AS
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
          [T_row]
          =  ROW_NUMBER()
             OVER(ORDER BY  [Pew_Thresholds_pk] )
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,[Datatype]
      ,[Point]
      ,[Threshold]
      ,[Display_text]
      ,[Notes]
      ,[code]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  FROM [forum].[dbo].[Pew_Thresholds]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Topic&Question_Displayable]    Script Date: 04/05/2016 04:30:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
              [dbo].[vi_Topic&Question_Displayable]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        DISTINCT
        [TQDv_row] = ROW_NUMBER()OVER(ORDER BY
                                                [Topic_sorting]
                                              , [SubTopic_Sorting]
                                              , [BySubTopic_QuestionSort]
                                                                          )
      , *
FROM
/***************************************************************************************************************************************************************/
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
           DISTINCT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
           [Topic_fk]
      ,    [Topic]
      ,    [SubTopic]
      ,    [Question_Std_fk]
      ,    [Question_abbreviation_std]
      ,    [Question_short_wording_std]
      ,    [Question_wording_std]
      ,    [GRFsite_URL]
      ,    [Topic_sorting]
      ,    [SubTopic_Sorting]
      ,    [ByTopic_QuestionSort]
      ,    [BySubTopic_QuestionSort]
      ,    [Footnote]
      ,    [About_the_Data_link]
      ,    [Reports]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
                [forum_ResAnal].[dbo].[vi_Topic&Question&Related_Displayable]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
)  mytable
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vi_Topic&Question_link_RelatedPewResearchReports]    Script Date: 04/05/2016 04:31:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
              [dbo].[vi_Topic&Question_link_RelatedPewResearchReports]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
           [TQLv_row] = [TQRDv_row]
      ,    [Topic_fk]
      ,    [Topic]
      ,    [SubTopic]
      ,    [Question_Std_fk]
      ,    [Question_abbreviation_std]
      ,    [Report_Name]               = [Report_Name_disitinct]
      ,    [Report_url]
      ,    [Report_SortingNumber]

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
                [forum_ResAnal].[dbo].[vi_Topic&Question&Related_Displayable]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vm__Migration_by_DestCountry_2010to2015]    Script Date: 04/05/2016 04:31:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
                       [dbo].[vm__Migration_by_DestCountry_2010to2015]
AS
/***************************************************************************************************************************************************************/
WITH
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     MajorRel -- pct & count
            AS
              (
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
				SELECT 
					   [Year]
					  ,[Nation_fk]
					  ,[Population]
					  ,[Percentage]
				FROM
				(
				SELECT [Year]
					  ,[Nation_fk]
					  ,[Population]
					  ,[Percentage]
					  ,[Major]          = ROW_NUMBER()OVER(PARTITION BY [Country]
															   ORDER BY [Population] DESC )
				  FROM [forum].[dbo].[vi_AgeSexValue]
				WHERE  [Sex]   = 'all'
				  AND  [Age]   = 'all'
				  AND  [level] =  1
				  AND  [Year]         =  2010
				  AND  [Religion_fk] IS NOT NULL
				  AND  [Religion]    != 'All Religions'
				) MySorted
				WHERE  [Major]        = 1
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                             )
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    ,
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     InMigr -- immigrants by country by Rel
            AS
              (
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

				SELECT
						[Year]                   = [Field_year]
					  , [Scenario_id]
					  , [Destination_Nation_fk]
					  , [Country_of_Destination] = [Ctry_EditorialName]
					  , [MigReligion]            = [Pew_RelL02_Display]
					  , [Total_Immigrants]       = CAST((ROUND(( SUM([Migrant_Count]) ), 0)) AS INT)
					  , [Display]                = MIN([Display_by_Religion])
				  FROM [vm__Migration_Flow_by_Country]
					 , [Pew_Field]
					 , [Pew_Religion_Group]
					 , [Pew_Nation]
				WHERE
					     [Scenario_id]
					 =    4
				AND
                         [Field_year] IN 
                         (   '2010-2015' )
				AND
						 [Field_pk]
					 =   [Field_fk]
				AND
						 [Religion_group_pk]
					 =   [Religion_group_fk]
				AND
					     [Nation_pk]
					 =   [Destination_Nation_fk]
				GROUP BY 
                          [Field_fk]
                      ,   [Field_year]
                      ,   [Scenario_id]
					  ,   [Destination_Nation_fk]
					  ,   [Ctry_EditorialName]
					  ,   [Religion_group_fk]
					  ,   [Pew_RelL02_Display]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                             )
/*---------------------------------------------- ---------------------------------------------------------------------------------------------------------------*/
SELECT
      [v_row]                  =  ROW_NUMBER()
                                        OVER(
                                     ORDER BY  [Year]
                                              ,[Scenario_id]
                                              ,[Destination_Nation_fk]
                                              ,[MigReligion]              )
     ,[Year]
     ,[Scenario_id]
     ,[Destination_Nation_fk]
     ,[Country_of_Destination]
     ,[MigrReligion]           = CASE
                                 WHEN    [MigReligion]
                                       = 'Other Religions'
                                 THEN    'Members of '
                                       + [MigReligion]
                                 ELSE    [MigReligion]
                                  END
     ,[Total_Immigrants]
     ,[Display]
     ,[TotPop2010]
     ,[MajorRel_2010]
     ,[MajorRelPCT]
     ,[MajorRelPop]
FROM
      [InMigr]                                                                                            I
   , ( SELECT
              [MajorRelYR]
            , [Nation_fk]
            , [TotPop2010]
            , [MajorRel_2010] = CASE WHEN [N_Majors] = 1
                                     THEN [R1]
                                     WHEN [N_Majors] = 2
                                     THEN '>1 majority rel: ' + [R1] + ', ' + [R2]
                                     WHEN [N_Majors] = 3
                                     THEN '>1 majority rel: ' + [R1] + ', ' + [R2] + ', ' + [R3]
                                     ELSE 'Check QUERY'
                                 END
            , [MajorRelPCT]
            , [MajorRelPop]
          FROM (
				SELECT 
				       X.[Nation_fk]
					  ,X.[Country]
					  ,X.[Religion]
					  ,  [MajorRelYR]       = X.[Year]
					  ,  [TotPop2010]       = X.[TotPopulat]
					  ,  [MajorRelPop]      = X.[Population]
					  ,  [MajorRelPCT]      = X.[Percentage]
					  ,  [NofMajor]         = 'R' 
					                        + CAST(
					                          (ROW_NUMBER()
					                           OVER
					                           (PARTITION BY X.[Nation_fk]
					                            ORDER BY X.[Population] DESC )) AS CHAR(3))
					  ,  [N_Majors]         = COUNT(*)
					                           OVER
					                           (PARTITION BY X.[Nation_fk])
				  --FROM   (select * from
				  --        [forum].[dbo].[vi_AgeSexValue]
				  --        union all 
				  --        select * from 
				  --        [forum].[dbo].[vi_AgeSexValue]
				  --        Where  Nation_fk = 6          ) X
				  FROM   [forum].[dbo].[vi_AgeSexValue]   X
                     ,   [MajorRel]                       M
				WHERE  X.[Sex]   = 'all'
				  AND  X.[Age]   = 'all'
				  AND  X.[level] =  1
				  AND  X.[Religion_fk] IS NOT NULL
				  AND  X.[Religion]    != 'All Religions'
				  AND  X.[Year]
                     = M.[Year]
				  AND  X.[Nation_fk]
                     = M.[Nation_fk]
				  AND  X.[Population]
                     = M.[Population]
             ) b
             PIVOT (MAX ([Religion]) 
               FOR       [NofMajor]
                IN      ([R1],[R2],[R3])) AS WideRels                                                                                                        ) R
WHERE
        R.[Nation_fk]
      = I.[Destination_Nation_fk]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vm__Migration_by_Religion_2010to2015]    Script Date: 04/05/2016 04:32:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
                       [dbo].[vm__Migration_by_Religion_2010to2015]
AS
/***************************************************************************************************************************************************************/
WITH RegMigr --(SalesPersonID, NumberOfOrders, MostRecentOrderDate)
            AS
              (
				SELECT
						[Field_fk]
					  , [Year]                  =   '2010-2015'
					  , [Scenario_id]
					  , [Region_of_Origin]
					  , [Region_of_Destination]
					  , [Religion_group_fk]
					  , [Pew_RelL02_Display]    = CASE
                                                  WHEN    [Pew_RelL02_Display]
                                                        = 'Other Religions'
                                                  THEN    'Members of '
                                                        + [Pew_RelL02_Display]
                                                  ELSE    [Pew_RelL02_Display]
                                                  END
					  , [Total Migrants]
					  , [Display]
				FROM
				(
				SELECT
						[Field_fk]
					  , [Scenario_id]
					  , [Region_of_Origin]      = O.[SubRegion6]
					  , [Region_of_Destination] = D.[SubRegion6]
					  , [Religion_group_fk]
					  , [Pew_RelL02_Display]
					  , [Total Migrants]        = SUM([Migrant_Count])
					  , [Display]               = MIN([Display_by_Religion])
				  FROM [vm__Migration_Flow_by_Country]
					 , [Pew_Religion_Group]
					 , [Pew_Nation]                        O
					 , [Pew_Nation]                        D
				WHERE
					     [Scenario_id]
					 =    4
				AND
						 [Religion_group_pk]
					 =   [Religion_group_fk]
				AND
					   O.[Nation_pk]
					 =   [Origin_Nation_fk]
				AND
					   D.[Nation_pk]
					 =   [Destination_Nation_fk]
				AND
					   D.[Nation_pk]
					 =   [Destination_Nation_fk]
				GROUP BY 
						  [Field_fk]
					  ,   [Scenario_id]
					  , O.[SubRegion6]
					  , D.[SubRegion6]
					  ,   [Religion_group_fk]
					  ,   [Pew_RelL02_Display]
				)                                                                  B
				JOIN
					  [Pew_Field]
				  ON
						 [Field_pk]
					 =   [Field_fk]
                WHERE
                      [Field_year] IN 
                         (   '2010-2015' )
					                                                     )
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        [v_row]      = 
                         ROW_NUMBER()OVER(ORDER BY
                                                  [Year]
                                                , [Scenario_id]
                                                , [Pew_RelL02_Display]    )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      , [Year]
      , [Scenario_id]
      , [Religion]   = [Pew_RelL02_Display]
      , [Migrants]   = ROUND(( SUM([Total Migrants]) ), 0) 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
        [RegMigr]
GROUP BY 
        [Year]
      , [Scenario_id]
      , [Religion_group_fk]
      , [Pew_RelL02_Display]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vm__Migration_Flow_all]    Script Date: 04/05/2016 04:32:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
                       [dbo].[vm__Migration_Flow_all]
AS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [V_Migration_Flow_pk]        =  ROW_NUMBER()
                                       OVER(ORDER BY [V_Migration_Flow_pk] )
      ,[MF_shortset_pk]
      ,[Field_fk]
      ,[Scenario_id]
      ,[Origin_Nation_fk]
      ,[Destination_Nation_fk]
      ,[Religion_group_fk]
      ,[Sex_fk]
      ,[Age_fk]
      ,[Migrant_Count]
      ,[Display_by_Religion]
      ,[Display_as_Destination_Ctry]
      ,[Display_as_Origin_Ctry]
  FROM [forum_ResAnal].[dbo].[vm__Migration_Flow_all]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vm__Migration_Flow_by_Country]    Script Date: 04/05/2016 04:33:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
                       [dbo].[vm__Migration_Flow_by_Country]
AS
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [MFCv_row]
                  =  ROW_NUMBER()
                     OVER(ORDER BY
                            [Migration_Flow_fk_min] )
      ,[Migration_Flow_fk_min]
      ,[Field_fk]
      ,[Scenario_id]
      ,[Origin_Nation_fk]
      ,[Destination_Nation_fk]
      ,[Religion_group_fk]
      ,[Migrant_Count]
      ,[Display_by_Religion]
      ,[Display_as_Destination_Ctry]
      ,[Display_as_Origin_Ctry]
  FROM [forum_ResAnal].[dbo].[vm__Migration_Flow_by_Country]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vm__RegionalMigration]    Script Date: 04/05/2016 04:34:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
                       [dbo].[vm__RegionalMigration]
AS
/***************************************************************************************************************************************************************/
WITH RegMigr --(SalesPersonID, NumberOfOrders, MostRecentOrderDate)
            AS
              (
				SELECT
						[Field_fk]
					  , [Year]                  =   [Field_year]
					  , [Scenario_id]
					  , [Region_of_Origin]
					  , [Region_of_Destination]
					  , [Religion_group_fk]
					  , [Pew_RelL02_Display]    = CASE
                                                  WHEN    [Pew_RelL02_Display]
                                                        = 'Other Religions'
                                                  THEN    'Members of '
                                                        + [Pew_RelL02_Display]
                                                  ELSE    [Pew_RelL02_Display]
                                                  END
					  , [Total Migrants]
					  , [Display]
				FROM
				(
				SELECT
						[Field_fk]
					  , [Scenario_id]
					  , [Region_of_Origin]      = O.[SubRegion6]
					  , [Region_of_Destination] = D.[SubRegion6]
					  , [Religion_group_fk]
					  , [Pew_RelL02_Display]
					  , [Total Migrants]        = SUM([Migrant_Count])
					  , [Display]               = MIN([Display_by_Religion])
				  FROM [vm__Migration_Flow_by_Country]
					 , [Pew_Religion_Group]
					 , [Pew_Nation]                        O
					 , [Pew_Nation]                        D
				WHERE
						 [Religion_group_pk]
					 =   [Religion_group_fk]
				AND
					   O.[Nation_pk]
					 =   [Origin_Nation_fk]
				AND
					   D.[Nation_pk]
					 =   [Destination_Nation_fk]
				GROUP BY 
						  [Field_fk]
					  ,   [Scenario_id]
					  , O.[SubRegion6]
					  , D.[SubRegion6]
					  ,   [Religion_group_fk]
					  ,   [Pew_RelL02_Display]
				)                                                                  B
				JOIN
					   [Pew_Field]
				  ON
						 [Field_pk]
					 =   [Field_fk]                                                    )
/**************************************************************************************************************************/
SELECT
        [v_row]      = 
                         ROW_NUMBER()OVER(ORDER BY
						    [Year]
						  , [Scenario_id]
						  , [S0]
						  , [S1]
						  , [S2]                )
      , [Year]
      --, [Field_fk]
      --, [Scenario_id]
      , [CategMigr]
      , [NMigrants]   = CAST(ROUND([NMigrants], 0) AS INT)
FROM
(
/**************************************************************************************************************************/
SELECT
        [Field_fk]
      , [Year]
      , [Scenario_id]
      , [S0]         = [Pew_RelL02_Display]
      , [S1]         = [Region_of_Origin]
      , [S2]         = [Region_of_Destination]
      , [CategMigr]  = CASE
                       WHEN
                              [Region_of_Origin]
                            !=[Region_of_Destination]
                       THEN
                              [Pew_RelL02_Display]
                            + ' migrating from '
                            + [Region_of_Origin]
                            + ' to '
                            + [Region_of_Destination]
                       WHEN
                              [Region_of_Origin]
                            = [Region_of_Destination]
                       THEN
                              [Pew_RelL02_Display]
                            + ' migrating inside the region among countries of '
                            + [Region_of_Origin]
                       END
      , [NMigrants]  = [Total Migrants]
FROM
        [RegMigr]
UNION ALL
SELECT
        [Field_fk]
      , [Year]
      , [Scenario_id]
      , [S0]         = [Pew_RelL02_Display]
      , [S1]         = [Region_of_Origin]
      , [S2]         = 'X'
      , [CategMigr]  = 
                              'Total number of '
                            + [Pew_RelL02_Display]
                            + ' migrating from '
                            + [Region_of_Origin]
      , [NMigrants]  = SUM([Total Migrants])
FROM
        [RegMigr]
WHERE
        [Region_of_Origin]
     != [Region_of_Destination]
GROUP BY 
        [Field_fk]
      , [Year]
      , [Scenario_id]
      , [Pew_RelL02_Display]
      , [Region_of_Origin]
UNION ALL
SELECT
        [Field_fk]
      , [Year]
      , [Scenario_id]
      , [S0]         = [Pew_RelL02_Display]
      , [S1]         = [Region_of_Destination]
      , [S2]         = 'XX'
      , [CategMigr]  = 
                              'Total number of '
                            + [Pew_RelL02_Display]
                            + ' migrating to '
                            + [Region_of_Destination]
      , [NMigrants]  = SUM([Total Migrants])
FROM
        [RegMigr]
WHERE
        [Region_of_Origin]
     != [Region_of_Destination]
GROUP BY 
        [Field_fk]
      , [Year]
      , [Scenario_id]
      , [Pew_RelL02_Display]
      , [Region_of_Destination]
/**************************************************************************************************************************/
) MYALL
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vm__RegionalMigration_IN&OUT&NET_2010to2015]    Script Date: 04/05/2016 04:36:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
                       [dbo].[vm__RegionalMigration_IN&OUT&NET_2010to2015]
AS
/***************************************************************************************************************************************************************/
WITH RegMigr --(SalesPersonID, NumberOfOrders, MostRecentOrderDate)
            AS
              (
				SELECT
						[Field_fk]
					  , [Year]                  =   '2010-2015'
					  , [Scenario_id]
					  , [Region_of_Origin]
					  , [Region_of_Destination]
					  , [Religion_group_fk]
					  , [Pew_RelL02_Display]    = CASE
                                                  WHEN    [Pew_RelL02_Display]
                                                        = 'Other Religions'
                                                  THEN    'Members of '
                                                        + [Pew_RelL02_Display]
                                                  ELSE    [Pew_RelL02_Display]
                                                  END
					  , [Total Migrants]
					  , [Display]
				FROM
				(
				SELECT
						[Field_fk]
					  , [Scenario_id]
					  , [Region_of_Origin]      = O.[SubRegion6]
					  , [Region_of_Destination] = D.[SubRegion6]
					  , [Religion_group_fk]
					  , [Pew_RelL02_Display]
					  , [Total Migrants]        = SUM([Migrant_Count])
					  , [Display]               = MIN([Display_by_Religion])
				  FROM [vm__Migration_Flow_by_Country]
					 , [Pew_Religion_Group]
					 , [Pew_Nation]                        O
					 , [Pew_Nation]                        D
				WHERE
					     [Scenario_id]
					 =    4
				AND
						 [Religion_group_pk]
					 =   [Religion_group_fk]
				AND
					   O.[Nation_pk]
					 =   [Origin_Nation_fk]
				AND
					   D.[Nation_pk]
					 =   [Destination_Nation_fk]
				AND
					   D.[Nation_pk]
					 =   [Destination_Nation_fk]
				GROUP BY 
						  [Field_fk]
					  ,   [Scenario_id]
					  , O.[SubRegion6]
					  , D.[SubRegion6]
					  ,   [Religion_group_fk]
					  ,   [Pew_RelL02_Display]
				)                                                                  B
				JOIN
					  [Pew_Field]
				  ON
						 [Field_pk]
					 =   [Field_fk]
                WHERE
                      [Field_year] IN 
                         (   '2010-2015' )
					                                                     )
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        [v_row]      = 
                         ROW_NUMBER()OVER(ORDER BY
						    ALLO.[Year]
						  , ALLO.[Scenario_id]
						  , ALLO.[Region]
						  , ALLO.[Religion]                )
      , ALLO.[Year]
      , ALLO.[Scenario_id]
      , ALLO.[Region]
      , ALLO.[Religion]
      ,      [Immigrants] = ROUND(([Immigrants] ), 0) 
      ,      [Emigrants]  = ROUND(([Emigrants]  ), 0) 
      ,      [Mill_NET]   = ROUND(([Immigrants]
                                  -[Emigrants]  ), 0) 
      --,      [Mill_NET]   = CAST(ROUND(([Immigrants]
      --                                 -[Emigrants]  ), 0) AS DEC(8,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        [Year]
      , [Scenario_id]
      , [Region]     = [Region_of_Origin]
      , [Religion]   = [Pew_RelL02_Display]
      , [S1]         = [Religion_group_fk]
      , [Emigrants]  = SUM([Total Migrants]) -- /1000000
FROM
        [RegMigr]
WHERE
        [Region_of_Origin]
     != [Region_of_Destination]
GROUP BY 
        [Year]
      , [Scenario_id]
      , [Religion_group_fk]
      , [Pew_RelL02_Display]
      , [Region_of_Origin]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
)                                                                                                                    ALLO
/***************************************************************************************************************************************************************/
,
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        [Year]
      , [Scenario_id]
      , [Region]     = [Region_of_Destination]
      , [Religion]   = [Pew_RelL02_Display]
      , [S1]         = [Religion_group_fk]
      , [Immigrants] = SUM([Total Migrants]) -- /1000000
FROM
        [RegMigr]
WHERE
        [Region_of_Origin]
     != [Region_of_Destination]
GROUP BY 
        [Year]
      , [Scenario_id]
      , [Religion_group_fk]
      , [Pew_RelL02_Display]
      , [Region_of_Destination]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
)                                                                                                                    ALLD
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
        ALLO.[Year]
      = ALLD.[Year]
  AND
        ALLO.[Scenario_id]
      = ALLD.[Scenario_id]
  AND
        ALLO.[Region]
      = ALLD.[Region]
  AND
        ALLO.[Religion]
      = ALLD.[Religion]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum]
GO

/****** Object:  View [dbo].[vm__RegionalMigration_IN&OUT&NET_2010to2050]    Script Date: 04/05/2016 04:37:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
                       [dbo].[vm__RegionalMigration_IN&OUT&NET_2010to2050]
AS
/***************************************************************************************************************************************************************/
WITH RegMigr --(SalesPersonID, NumberOfOrders, MostRecentOrderDate)
            AS
              (
				SELECT
						[Field_fk]
					  , [Year]                  =   '2010-2050'
					  , [Scenario_id]
					  , [Region_of_Origin]
					  , [Region_of_Destination]
					  , [Religion_group_fk]
					  , [Pew_RelL02_Display]    = CASE
                                                  WHEN    [Pew_RelL02_Display]
                                                        = 'Other Religions'
                                                  THEN    'Members of '
                                                        + [Pew_RelL02_Display]
                                                  ELSE    [Pew_RelL02_Display]
                                                  END
					  , [Total Migrants]
					  , [Display]
				FROM
				(
				SELECT
						[Field_fk]
					  , [Scenario_id]
					  , [Region_of_Origin]      = O.[SubRegion6]
					  , [Region_of_Destination] = D.[SubRegion6]
					  , [Religion_group_fk]
					  , [Pew_RelL02_Display]
					  , [Total Migrants]        = SUM([Migrant_Count])
					  , [Display]               = MIN([Display_by_Religion])
				  FROM [vm__Migration_Flow_by_Country]
					 , [Pew_Religion_Group]
					 , [Pew_Nation]                        O
					 , [Pew_Nation]                        D
				WHERE
						 [Religion_group_pk]
					 =   [Religion_group_fk]
				AND
					   O.[Nation_pk]
					 =   [Origin_Nation_fk]
				AND
					   D.[Nation_pk]
					 =   [Destination_Nation_fk]
				AND
					   D.[Nation_pk]
					 =   [Destination_Nation_fk]
				GROUP BY 
						  [Field_fk]
					  ,   [Scenario_id]
					  , O.[SubRegion6]
					  , D.[SubRegion6]
					  ,   [Religion_group_fk]
					  ,   [Pew_RelL02_Display]
				)                                                                  B
				JOIN
					  [Pew_Field]
				  ON
						 [Field_pk]
					 =   [Field_fk]
                WHERE
                      [Field_year] IN 
                         (   '2010-2015'
                           , '2015-2020'
                           , '2020-2025'
                           , '2025-2030'
                           , '2030-2035'
                           , '2035-2040'
                           , '2040-2045'
                           , '2045-2050' )
					                                                     )
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        [v_row]      = 
                         ROW_NUMBER()OVER(ORDER BY
						    ALLO.[Year]
						  , ALLO.[Scenario_id]
						  , ALLO.[Region]
						  , ALLO.[Religion]                )
      , ALLO.[Year]
      , ALLO.[Scenario_id]
      , ALLO.[Region]
      , ALLO.[Religion]
      ,      [Mill_INTO]  = CAST(ROUND( [Mill_INTO] , 2) AS DEC(8,2))
      ,      [Mill_OUT]   = CAST(ROUND( [Mill_OUT]  , 2) AS DEC(8,2))
      ,      [Mill_NET]   = CAST(ROUND(([Mill_INTO]
                                       -[Mill_OUT] ), 2) AS DEC(8,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
/**************************************************************************************************************************/
(
/**************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        [Year]
      , [Scenario_id]
      , [Region]     = [Region_of_Origin]
      , [Religion]   = [Pew_RelL02_Display]
      , [S1]         = [Religion_group_fk]
      , [Mill_OUT]   = SUM([Total Migrants])/1000000
FROM
        [RegMigr]
WHERE
        [Region_of_Origin]
     != [Region_of_Destination]
GROUP BY 
        [Year]
      , [Scenario_id]
      , [Religion_group_fk]
      , [Pew_RelL02_Display]
      , [Region_of_Origin]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
)                                                                                                                    ALLO
/**************************************************************************************************************************/
,
/**************************************************************************************************************************/
(
/**************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        [Year]
      , [Scenario_id]
      , [Region]     = [Region_of_Destination]
      , [Religion]   = [Pew_RelL02_Display]
      , [S1]         = [Religion_group_fk]
      , [Mill_INTO]  = SUM([Total Migrants])/1000000
FROM
        [RegMigr]
WHERE
        [Region_of_Origin]
     != [Region_of_Destination]
GROUP BY 
        [Year]
      , [Scenario_id]
      , [Religion_group_fk]
      , [Pew_RelL02_Display]
      , [Region_of_Destination]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
)                                                                                                                    ALLD
/**************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
        ALLO.[Region]
      = ALLD.[Region]
  AND
        ALLO.[Religion]
      = ALLD.[Religion]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------



GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V1_DB_Long]    Script Date: 04/05/2016 06:02:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[V1_DB_Long]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  Basic Data: Long NPR ******************************************************************************************/
----------------------------------------------------------------------------------------------------------------------
/*** Set of data at country level ***********************************************************************************/
SELECT
           entity      = 'Ctry'
      ,    link_fk     = KN.[Nation_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = NULL
      ,    Religion_fk = NULL
      ,    Region5     = N.[Region]
      ,    Region6     = N.[SubRegion6]
      , N.[Ctry_EditorialName]
      ,    Locality    = 'not detailed'
      ,    Religion    = ''
      , Q.[Question_Year]
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
      , A.[Answer_value]
      , A.[answer_wording]
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]
/*********************************************************************************** Set of data at country level ***/
UNION
/*** Set of data at country/religious group level *******************************************************************/
SELECT
           entity      = 'RGrp'
      ,    link_fk     = KR.[Nation_religion_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = NULL
      ,    Religion_fk = G.[Religion_group_pk]
      ,    Region5     = N.[Region]
      ,    Region6     = N.[SubRegion6]
      , N.[Ctry_EditorialName]
      ,    Locality    = 'not detailed'
      ,    Religion    = G.[Pew_religion]
      , Q.[Question_Year]
      , Q.[Question_abbreviation_std]  AS  QA_std
      , Q.[Question_short_wording_std] AS  QW_std
      , A.[Answer_value]
      , A.[answer_wording]
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]                   A
      ,[forum].[dbo].[Pew_Question]                 Q
      ,[forum].[dbo].[Pew_Nation]                   N
      ,[forum].[dbo].[Pew_Religion_Group]           G
      ,[forum].[dbo].[Pew_Nation_Religion_Answer]   KR
WHERE  Q.[Question_pk]       =  A.[Question_fk]
  AND  A.[Answer_pk]         = KR.[Answer_fk]
  AND KR.[Religion_group_fk] =  G.[Religion_group_pk]
  AND  N.[Nation_pk]         = KR.[Nation_fk]
                           /* Pull only data on Restrictions */
  AND (   Q.[Question_abbreviation_std] like 'SHI_%'
       OR Q.[Question_abbreviation_std] like 'GRI_%'  )
/******************************************************************* Set of data at country/religious group level ***/
UNION
/*** Set of data at country/province level **************************************************************************/
SELECT
           entity             = 'Prov'
      ,    link_fk     = KL.[Locality_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = L.[Locality_pk]
      ,    Religion_fk = NULL
      ,    Region5     = N.[Region]
      ,    Region6     = N.[SubRegion6]
      , N.[Ctry_EditorialName]
      ,    Locality    = L.Locality
      ,    Religion    = ''
      , Q.[Question_Year]
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
      , A.[Answer_value]
      , A.[answer_wording]
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Locality]          L
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Locality_Answer]   KL
WHERE Q.[Question_pk] = A.[Question_fk]
  AND A.[Answer_pk]   = KL.[Answer_fk]
  AND L.[Locality_pk] = KL.[Locality_fk]
  AND N.[Nation_pk]   =
                           /* In order to keep consistent to previuos years 
                              Data by Province currently belonging to South Sudan
                              should considered data for Sudan before 2010: */
                     CASE 
                            WHEN L.[Nation_fk]     = 237 
                             AND Q.[Question_Year] < 2010 
                            THEN                           197
                            ELSE                           L.[Nation_fk]
                     END 
                           /* In order to avoid changing the final set,
                              Data previously used for Northern Cyprus
                              should be excluded: ????                                 */
                           /* Although we have REAL data by province for North Korea,
                              we will not use them in this analysis: ????              */
/************************************************************************** Set of data at country/province level ***/
----------------------------------------------------------------------------------------------------------------------
/******************************************************************************************  Basic Data: Long NPR ***/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V2_W_by_Ctry&Year]    Script Date: 04/05/2016 06:04:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[V2_W_by_Ctry&Year]
AS
/***************************************************************************************************************************************************************/

/***************************************************************************************************************************************************************/
SELECT
       *
FROM
/***************************************************************************************************************************************************************/

(
/***************************************************************************************************************************************************************/
SELECT 
       [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[QA_std]
      ,[Answer_value]      = SUM([Answer_value])
  FROM
/***  Basic Data: Long NPR *************************************************************************************************************************************/
            [V1_DB_Long]
/************************************************************************************************************************************  Basic Data: Long NPR  ***/
GROUP BY
       [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[QA_std]
/***************************************************************************************************************************************************************/
)                                                                                                                                                      AS   lnpr

/***************************************************************************************************************************************************************/
PIVOT
(
  MAX([Answer_value])
  FOR [QA_std]
                   in (
/***************************************************************************************************************************************************************/
 CSR_01, CSR_02, CSR_02_a, CSR_02_b, CSR_02_c, CSR_02_d, CSR_03_a, CSR_03_b, CSR_03_c, CSR_04_a, CSR_04_b, CSR_04_c, CSR_05, CSR_06, CSR_S_01, CSR_S_02, CSR_S_03, CSR_S_04, CSR_S_05, CSR_S_06, CSR_S_07, CSR_S_08, CSR_S_09, CSR_S_10, CSR_S_11, CSR_S_12, CSR_S_13, CSR_S_14, CSR_S_15, CSR_S_16, CSR_S_17, CSR_S_18, CSR_S_19, CSR_S_20, CSR_S_21, CSR_S_22, CSR_S_23, CSR_S_24, CSR_S_25, CSR_S_99_01, CSR_S_99_02, CSR_S_99_03, ERI_01, ERI_02, ERI_03, ERI_04, ERI_05, ERI_06, ERI_06_a, ERI_06_b, ERI_06_b_x, ERI_06_c, ERI_06_c_x, ERI_06_x, ERI_07, ERI_07_a, ERI_07_b, ERI_07_b_x, ERI_07_c, ERI_07_c_x, ERI_07_x, ERI_08, ERI_08_a, ERI_08_b, ERI_08_b_x, ERI_08_c, ERI_08_c_x, ERI_08_x, ERI_S_01, ERI_S_02, ERI_S_03, ERI_S_04, ERI_S_05, ERI_S_06, ERI_S_07, ERI_S_08, ERI_S_09, ERI_S_10, ERI_S_11, ERI_S_12, ERI_S_13, ERI_S_14, ERI_S_15, ERI_S_16, ERI_S_17, ERI_S_18, ERI_S_19, ERI_S_20, ERI_S_21, ERI_S_22, ERI_S_23, ERI_S_24, ERI_S_25, ERI_S_99_01, ERI_S_99_02, ERI_S_99_03, ERI_S_99_04, GRI_01, GRI_01_x, GRI_01_x2, GRI_02, GRI_03, GRI_04, GRI_05, GRI_06, GRI_07, GRI_08, GRI_09, GRI_10, GRI_10_01, GRI_10_02, GRI_10_03, GRI_11, GRI_11_01a, GRI_11_01b, GRI_11_02, GRI_11_03, GRI_11_04, GRI_11_05, GRI_11_06, GRI_11_07, GRI_11_08, GRI_11_09, GRI_11_10, GRI_11_11, GRI_11_12, GRI_11_13, GRI_11_14, GRI_11_15, GRI_11_16, GRI_11_17, GRI_12, GRI_13, GRI_14, GRI_15, GRI_16, GRI_16_01, GRI_17, GRI_18, GRI_19, GRI_19_b, GRI_19_c, GRI_19_d, GRI_19_da, GRI_19_db, GRI_19_e, GRI_19_f, GRI_20_01, GRI_20_01x_01a, GRI_20_01x_01b, GRI_20_01x_02, GRI_20_01x_03, GRI_20_01x_04, GRI_20_01x_05, GRI_20_01x_06, GRI_20_01x_07, GRI_20_01x_08, GRI_20_01x_09, GRI_20_01x_10, GRI_20_02, GRI_20_03_a, GRI_20_03_b, GRI_20_03_c, GRI_20_04, GRI_20_04_x, GRI_20_05, GRI_20_05_x, GRI_20_05_x1, GRX_21_01, GRX_21_02, GRX_21_03, GRX_22, GRX_22_01, GRX_22_02, GRX_22_03, GRX_22_04, GRX_23, GRX_24, GRX_25_01, GRX_25_02, GRX_25_03, GRX_26_01, GRX_26_02, GRX_26_03, GRX_26_04, GRX_26_05, GRX_26_06, GRX_26_07, GRX_26_08, GRX_27_01, GRX_27_02, GRX_27_03, GRX_28_01, GRX_28_02, GRX_28_03, GRX_29_01, GRX_29_02, GRX_29_03, GRX_29_04, GRX_29_05, IEI_01, IEI_02, IEI_A_01, IEI_S_01, IEI_S_02, IEI_S_03, IEI_S_04, IEI_S_05, IEI_S_06, IEI_S_07, IEI_S_08, IEI_S_09, IEI_S_10, IEI_S_11, IEI_S_12, IEI_S_13, IEI_S_14, IEI_S_15, IEI_S_16, IEI_S_17, IEI_S_18, IEI_S_19, IEI_S_20, IEI_S_21, IEI_S_22, IEI_S_23, IEI_S_24, IEI_S_25, IEI_S_99_01, IEI_S_99_02, PPR_01, PPR_01_a, PPR_02, PPR_02_a, PPR_03, PPR_04, PPR_S_01, PPR_S_02, PPR_S_03, PPR_S_04, PPR_S_05, PPR_S_06, PPR_S_07, PPR_S_08, PPR_S_09, PPR_S_10, PPR_S_11, PPR_S_12, PPR_S_13, PPR_S_14, PPR_S_15, PPR_S_16, PPR_S_17, PPR_S_18, PPR_S_19, PPR_S_20, PPR_S_21, PPR_S_22, PPR_S_23, PPR_S_24, PPR_S_25, PPR_S_99_01, PPR_S_99_02, PPR_S_99_03, RIR_01, RIR_02, RIR_03, RIR_03_a, RIR_03_b, RIR_03_c, RIR_04, RIR_04_a_01, RIR_04_a_02, RIR_04_a_03, RIR_04_a_04, RIR_04_b_01, RIR_04_b_02, RIR_04_b_03, RIR_04_b_04, RIR_S_01, RIR_S_02, RIR_S_03, RIR_S_04, RIR_S_05, RIR_S_06, RIR_S_07, RIR_S_08, RIR_S_09, RIR_S_10, RIR_S_11, RIR_S_12, RIR_S_13, RIR_S_14, RIR_S_15, RIR_S_16, RIR_S_17, RIR_S_18, RIR_S_19, RIR_S_20, RIR_S_21, RIR_S_22, RIR_S_23, RIR_S_24, RIR_S_25, RIR_S_99_01, RIR_S_99_02, RIR_S_99_03, SHI_01_a, SHI_01_b, SHI_01_c, SHI_01_d, SHI_01_da, SHI_01_db, SHI_01_e, SHI_01_f, SHI_01_x_01a, SHI_01_x_01b, SHI_01_x_02, SHI_01_x_03, SHI_01_x_04, SHI_01_x_05, SHI_01_x_06, SHI_01_x_07, SHI_01_x_08, SHI_01_x_09, SHI_01_x_10, SHI_01_x_11, SHI_01_x_12, SHI_01_x_13, SHI_01_x_14, SHI_01_x_15, SHI_01_x_16, SHI_01_x_17, SHI_02, SHI_02_01, SHI_03, SHI_04, SHI_04_b, SHI_04_c, SHI_04_d, SHI_04_da, SHI_04_db, SHI_04_e, SHI_04_f, SHI_04_x01, SHI_05, SHI_05_b, SHI_05_c, SHI_05_d, SHI_05_da, SHI_05_db, SHI_05_e, SHI_05_f, SHI_06, SHI_07, SHI_08, SHI_09, SHI_10, SHI_11, SHI_11_x, SHI_12, SHI_13, SHX_14_01, SHX_14_02, SHX_14_03, SHX_14_04, SHX_15_01, SHX_15_02, SHX_15_03, SHX_15_04, SHX_15_05, SHX_15_06, SHX_15_07, SHX_15_08, SHX_15_09, SHX_15_10, SHX_25, SHX_26, SHX_27_01, SHX_27_02, SHX_27_03, SHX_28_01, SHX_28_02, SHX_28_03, SHX_28_04, SHX_28_05, SHX_28_06, SHX_28_07, SHX_28_08, XSG_24, XSG_S_01, XSG_S_02, XSG_S_03, XSG_S_04, XSG_S_05, XSG_S_06, XSG_S_07, XSG_S_08, XSG_S_09, XSG_S_10, XSG_S_11, XSG_S_12, XSG_S_13, XSG_S_14, XSG_S_15, XSG_S_16, XSG_S_17, XSG_S_18, XSG_S_19, XSG_S_20, XSG_S_21, XSG_S_22, XSG_S_23, XSG_S_99_01, XSG_S_99_02, XSG_S_99_03, XSG_S_99_04, XSG_S_99_05, XSG_S_99_06
/***************************************************************************************************************************************************************/
)                                                                               /*** end of listing of variables                                             ***/
 )                                                                                                                                                      AS   pivt
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V3_W&Extras_by_Ctry&Year]    Script Date: 04/05/2016 06:05:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[V3_W&Extras_by_Ctry&Year]
AS
/***************************************************************************************************************************************************************/
--*** May need to:
--    Clean XSG_25n27  as rowmax(GRX_25_01_2010 SHX_27_01_2010)
/*** main select statement *************************************************************************************************************************************/
/*** table including numeric values + Step-3 calculated variables **********************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_scaled index */
         GRI_scaled 
         =        CAST ((
                  CASE
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'low'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 1.00
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'moderate'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 2.00
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 3.00
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'very high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 4.00
                  END
                                                               ) AS DECIMAL (38,2))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI_scaled index */
      ,  SHI_scaled 
         =        CAST ((
                  CASE
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'low'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 1.00
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'moderate'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 2.00
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 3.00
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'very high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 4.00
                  END
                                                               ) AS DECIMAL (38,2))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI_scaled index */
      ,  GFI_scaled 
         =        CAST ((
                  CASE
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'low'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 1.00
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'moderate'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 2.00
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 3.00
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'very high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 4.00
                  END
                                                               ) AS DECIMAL (38,2))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_rounded index */
      ,  GRI_rd_1d 
         =        CAST ((
                                  GRI 
                                                               ) AS DECIMAL (38,1))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI_rounded index */
      ,  SHI_rd_1d 
         =        CAST ((
                                  SHI 
                                                               ) AS DECIMAL (38,1))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI_rounded index */
      ,  GFI_rd_1d 
         =        CAST ((
                                  GFI
                                                               ) AS DECIMAL (38,1))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------------------------------------------------------
       ,
 *
FROM
/***************************************************************************************************************************************************************/
(
/*** table including numeric values + Step-2 calculated variables **********************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI index */
         GRI 
         =
--/*********************************************************************************************/    
--                  CASE
--/*  Fit previously published data  ----------------------------------------------------------*/    
--    ---------------------------------------------------------------------------------------
--	                                        WHEN Nation_fk	               = 69
--	                                         AND Question_Year             = 2011
--	                                        THEN 1.8
--    -----------------------------------------------------------------------------------------
--                                            WHEN Nation_fk	               = 146
--                                             AND Question_Year             = 2011
--                                            THEN 1.950
--    -----------------------------------------------------------------------------------------
--                                            WHEN Nation_fk	               = 131
--                                             AND Question_Year             = 2011
--                                            THEN 1.350
--    -----------------------------------------------------------------------------------------
--                                            WHEN Nation_fk	               = 186
--                                             AND Question_Year             = 2011
--                                            THEN 1.750
--    -----------------------------------------------------------------------------------------
--/*  Fit previously published median  --------------------------------------------------------*/    
--    ---------------------------------------------------------------------------------------
--                                            WHEN Nation_fk	               = 116
--                                             AND Question_Year             = 2010
--                                            THEN 5.844
--    ---------------------------------------------------------------------------------------
--                  ELSE
--/*********************************************************************************************/    
                  ROUND(
                  CAST ((((
                                [GRI_01]
                         +      [GRI_02]
                         +      [GRI_03]
                         +      [GRI_04]
                         +      [GRI_05]
                         +      [GRI_06]
                         +      [GRI_07]
                         +      [GRI_08_for_index]
                         +      [GRI_09]
                         +      [GRI_10]
                         +      [GRI_11]
                         +      [GRI_12]
                         +      [GRI_13]
                         +      [GRI_14]
                         +      [GRI_15]
                         +      [GRI_16]
                         +      [GRI_17]
                         +      [GRI_18]
                         +      [GRI_19]
                         +      [GRI_20]
                                                       ) / 2    )
                                                                  ) AS float) ,64)
--                                                                ) AS DECIMAL (38,4)) ,4)
--                  END
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI index */
       , SHI 
         =        ROUND(
                  CAST ((((
                                [SHI_01]
                         +      [SHI_02]
                         +      [SHI_03]
                         +      [SHI_04]
                         +      [SHI_05]
                         +      [SHI_06]
                         +      [SHI_07]
                         +      [SHI_08]
                         +      [SHI_09]
                         +      [SHI_10]
                         +      [SHI_11_for_index]
                         +      [SHI_12]
                         +      [SHI_13]
                                                       ) / 1.3  )
                                                                  ) AS float) ,64)
--                                                                ) AS DECIMAL (38,4)) ,4)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI index */
       , GFI 
         =        ROUND(
                  CAST ((((
                                [GRI_20_01]
                         +      [GRI_20_02]
                         + ( (  [GRI_20_03_a]
                              + [GRI_20_03_b]
                              + [GRI_20_03_c]
                                               ) / 3 )
                         +      [GRI_20_04]
                         +      [GRI_20_05]
                                                       ) / 5 ) 
                                                              * 10
                                                                  ) AS float) ,64)
--                                                                ) AS DECIMAL (38,4)) ,4)
--         =        GRI_20 * 10
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Christianity */
       , XSG_01_xG1 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG1 + SHI_01_xG1 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Islam */
       , XSG_01_xG2 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG2 + SHI_01_xG2 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Buddhism */
       , XSG_01_xG3 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG3 + SHI_01_xG3 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Hinduism */
       , XSG_01_xG4 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG4 + SHI_01_xG4 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Judaism */
       , XSG_01_xG5 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG5 + SHI_01_xG5 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Other ('New' Religions, Ancient Religions, Sikhs, Zoroastrianism) */
       , XSG_01_xG6 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG6 + SHI_01_xG6 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Ethnic or Tribal Religions */
       , XSG_01_xG7 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG7 + SHI_01_xG7 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_01_summary_a_ny           for toplines */
       ,           SHI_01_summary_a_ny0
       = CAST ((
         CASE 
              WHEN SHI_01     =  0.00
              THEN               0.00
              WHEN SHI_01     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny1
       = CAST ((
         CASE 
              WHEN SHI_01_a   >  0.00
              THEN               1.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny2
       = CAST ((
         CASE 
              WHEN SHI_01_b   >  0.00
              THEN               1.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny3
       = CAST ((
         CASE 
              WHEN SHI_01_c   >  0.00
              THEN               1.03
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny4
       = CAST ((
         CASE 
              WHEN SHI_01_d   >  0.00
              THEN               1.04
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny5
       = CAST ((
         CASE 
              WHEN SHI_01_e   >  0.00
              THEN               1.05
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny6
       = CAST ((
         CASE 
              WHEN SHI_01_f   >  0.00
              THEN               1.06
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 XSG_242526_ny           for toplines */
       ,           XSG_242526_ny0
       = CAST ((
         CASE WHEN GRX_24     = 0.00
               AND SHX_25     = 0.00
               AND SHX_26     = 0.00
              THEN              0.00
              WHEN GRX_24     = 1.00
                OR SHX_25     = 1.00
                OR SHX_26     = 1.00
              THEN              1.00
              WHEN GRX_24     = 0.67
                OR SHX_25     = 0.67
                OR SHX_26     = 0.67
              THEN              0.67
              WHEN GRX_24     = 0.33
                OR SHX_25     = 0.33
                OR SHX_26     = 0.33
              THEN              0.33
              END
                                                               ) AS DECIMAL (38,2))
       ,           XSG_242526_ny1
       = CAST ((
         CASE WHEN GRX_24     > 0.00
                OR SHX_25     > 0.00
                OR SHX_26     > 0.00
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 XSG_25n27_ny           for toplines */
       ,           XSG_25n27_ny1
       = CAST ((
         CASE WHEN GRX_25_ny1 = 0.00
               AND SHX_27_ny1 = 0.00
              THEN              0.00
              WHEN GRX_25_ny1 = 0.01
                OR SHX_27_ny1 = 0.01
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
       ,           XSG_25n27_ny2
       = CAST ((
         CASE WHEN GRX_25_ny2 = 0.02
                OR SHX_27_ny2 = 0.02
              THEN              0.02
              END
                                                               ) AS DECIMAL (38,2))
       ,           XSG_25n27_ny3
       = CAST ((
         CASE WHEN GRX_25_ny3 = 0.03
                OR SHX_27_ny3 = 0.03
              THEN              0.03
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

       , *
FROM
/***************************************************************************************************************************************************************/
(
/*** table including numeric values + Step-1 calculated variables **********************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
         GRI_20
         =        ROUND(
                  CAST ((((
                                [GRI_20_01]
                         +      [GRI_20_02]
                         + ( (  [GRI_20_03_a]
                              + [GRI_20_03_b]
                              + [GRI_20_03_c]
                                               ) / 3 )
                         +      [GRI_20_04]
                         +      [GRI_20_05]
                                                       ) / 5  )
                                                               ) AS DECIMAL (38,2)) ,2)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , GRI_20_top
         =        CAST ((
                  CASE
                  WHEN GRI_20_03_a = 1
                    OR GRI_20_03_b = 1
                    OR GRI_20_03_c = 1
                    OR GRI_20_02   > 0.5
                  THEN               1.00
                  WHEN GRI_20_01   > 0
                    OR GRI_20_02   > 0
                    OR GRI_20_03_a > 0
                    OR GRI_20_03_b > 0
                    OR GRI_20_03_c > 0
                    OR GRI_20_04   > 0
                    OR GRI_20_05   > 0
                  THEN               0.50
                  ELSE               0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , GRI_20_03_top
         =        CAST ((
                  CASE
                  WHEN GRI_20_03_a >= GRI_20_03_b
                   AND GRI_20_03_a >= GRI_20_03_c
                  THEN GRI_20_03_a
                  WHEN GRI_20_03_b >= GRI_20_03_a
                   AND GRI_20_03_b >= GRI_20_03_c
                  THEN GRI_20_03_b
                  WHEN GRI_20_03_c >= GRI_20_03_b
                   AND GRI_20_03_c >= GRI_20_03_c
                  THEN GRI_20_03_c
                  ELSE NULL
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , 
--       select
       SHI_01
         =        CAST ((
                  (
                  CAST ((
                    ( CASE
                      WHEN SHI_01_a > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_b > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_c > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_d > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_e > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_f > 0 THEN 1
                      ELSE                   0
                       END                     )
                                                       
                                                               ) AS DECIMAL (38,2))
                                                                                    / 6 )
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , SHI_01_summary_b
         =        CAST ((
                    ( CASE
                      WHEN SHI_01_a > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_b > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_c > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_d > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_e > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_f > 0 THEN 1
                      ELSE                   0
                       END                     )
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_01_[a,b,c,d,e,f]_dummy for tables of question answers by country */
       ,           SHI_01_a_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_a   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_b_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_b   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_c_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_c   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_d_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_d   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_e_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_e   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_f_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_f   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Christianity */
       , GRI_11_xG1
         =        CAST ((
                  CASE
                  WHEN   GRI_11_01a
                       + GRI_11_01b
                       + GRI_11_02
                       + GRI_11_03
                       + GRI_11_11
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Islam */
       , GRI_11_xG2 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_04
                       + GRI_11_05
                       + GRI_11_06
                       + GRI_11_12
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Buddhism */
       , GRI_11_xG3 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_07
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Hinduism */
       , GRI_11_xG4 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_08
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Judaism */
       , GRI_11_xG5 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_09
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Other ('New' Religions, Ancient Religions, Sikhs, Zoroastrianism) */
       , GRI_11_xG6 
         =        CAST ((
                  CASE
                  WHEN   isnull(GRI_11_10, 0)
                       + isnull(GRI_11_14, 0)
                       + isnull(GRI_11_15, 0)
                       + isnull(GRI_11_16, 0)
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Ethnic or Tribal Religions */
       , GRI_11_xG7
         =        CAST ((
                  CASE
                  WHEN   GRI_11_13
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Christianity */
       , SHI_01_xG1
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_01a
                       + SHI_01_x_01b
                       + SHI_01_x_02
                       + SHI_01_x_03
                       + SHI_01_x_11
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Islam */
       , SHI_01_xG2 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_04
                       + SHI_01_x_05
                       + SHI_01_x_06
                       + SHI_01_x_12
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Buddhism */
       , SHI_01_xG3 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_07
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Hinduism */
       , SHI_01_xG4 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_08
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Judaism */
       , SHI_01_xG5 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_09
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Other ('New' Religions, Ancient Religions, Sikhs, Zoroastrianism) */
       , SHI_01_xG6 
         =        CAST ((
                  CASE
                  WHEN   isnull(SHI_01_x_10, 0)
                       + isnull(SHI_01_x_14, 0)
                       + isnull(SHI_01_x_15, 0)
                       + isnull(SHI_01_x_16, 0)
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Ethnic or Tribal Religions */
       , SHI_01_xG7
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_13
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* recode GRI_08 to be used as index-factor */
       , GRI_08_for_index
         =        CAST ((
                  CASE
                  WHEN GRI_08  = 0.5
                  THEN           1
                  ELSE GRI_08
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* recode SHI_Q_11 to be used as index-factor */
       , SHI_11_for_index
         =        CAST ((
                  CASE
                  WHEN SHI_11  = 0.5
                  THEN           1
                  ELSE SHI_11
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_16               for toplines */
       ,           GRI_16_ny1
       =           GRI_16
       ,           GRI_16_ny2
       = CAST ((
         CASE WHEN GRI_16  > 0
                  THEN           0.01
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19               for toplines */
       ,           GRI_19_ny1
       =           GRI_19
       ,           GRI_19_ny2
       = CAST ((
         CASE WHEN GRI_19  > 0
              THEN           0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19_summ_ny          for toplines */
       ,           GRI_19_summ_ny1
       = CAST ((
         CASE 
              WHEN GRI_19     =  0.00
              THEN               0.00
              WHEN GRI_19     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny2
       = CAST ((
         CASE 
              WHEN GRI_19_b   >  0.00
              THEN               1.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny3
       = CAST ((
         CASE 
              WHEN GRI_19_c   >  0.00
              THEN               1.03
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny4
       = CAST ((
         CASE 
              WHEN GRI_19_d   >  0.00
              THEN               1.04
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny5
       = CAST ((
         CASE 
              WHEN GRI_19_e   >  0.00
              THEN               1.05
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny6
       = CAST ((
         CASE 
              WHEN GRI_19_f   >  0.00
              THEN               1.06
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19_x              for toplines */
       ,           GRI_19_x
       =           ISNULL(GRI_19_b, 0)
                 + ISNULL(GRI_19_c, 0)
                 + ISNULL(GRI_19_d, 0)
                 + ISNULL(GRI_19_e, 0)
                 + ISNULL(GRI_19_f, 0)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_04_ny          for toplines */
       ,           SHI_04_ny0
       =           SHI_04

       ,           SHI_04_ny1
       = CAST ((
         CASE 
              WHEN SHI_04     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_05_ny          for toplines */
       ,           SHI_05_ny0
       =           SHI_05
       ,           SHI_05_ny1
       = CAST ((
         CASE 
              WHEN SHI_05     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_07_ny          for toplines */
       ,           SHI_07_ny0
       =           SHI_07
       ,           SHI_07_ny1
       = CAST ((
         CASE 
              WHEN SHI_07     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--/*                 SHI_01_x              for toplines shoul;d be added???*/
--       ,           SHI_01_x
--       =           ISNULL(SHI_01_b, 0)
--                 + ISNULL(SHI_01_c, 0)
--                 + ISNULL(SHI_01_d, 0)
--                 + ISNULL(SHI_01_e, 0)
--                 + ISNULL(SHI_01_f, 0)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22               for toplines */
       ,           GRX_22_ny1
       = CAST ((
         CASE WHEN ISNULL(GRX_22   , 0)  < 0.66
               AND ISNULL(GRX_22_01, 0)  < 0.66
               AND ISNULL(GRX_22_02, 0)  < 0.66
               AND ISNULL(GRX_22_04, 0)  < 0.66
              THEN                         0
              WHEN ISNULL(GRX_22   , 0)  < 1.00
               AND ISNULL(GRX_22_01, 0)  < 1.00
               AND ISNULL(GRX_22_02, 0)  < 1.00
               AND ISNULL(GRX_22_04, 0)  < 1.00
              THEN                         0.67
              WHEN ISNULL(GRX_22   , 0)  = 1.00
                OR ISNULL(GRX_22_01, 0)  = 1.00
                OR ISNULL(GRX_22_02, 0)  = 1.00
                OR ISNULL(GRX_22_04, 0)  = 1.00
              THEN                         1.00
--              ELSE GRX_22_01                 -- value does not fit logical distribution where 2 "no" cetegories are collapsed 
              END
                                                               ) AS DECIMAL (38,2))
--       ,           GRX_22_ny2
--       = CAST ((
--         CASE WHEN GRX_22    >= 0.66
--                OR GRX_22_01 >= 0.66
--                OR GRX_22_02 >= 0.66
--                OR GRX_22_04 >= 0.66
--              THEN              0.01
--              END
--                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_01               for toplines */
       ,           GRX_22_01_ny1
       = CAST ((
         CASE WHEN GRX_22_01  < 0.66
              THEN              0
              ELSE GRX_22_01
              END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_01_ny2
       = CAST ((
         CASE WHEN GRX_22_01 >= 0.66
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_02               for toplines */
       ,           GRX_22_02_ny1
       = CAST ((
         CASE WHEN GRX_22_02  < 0.66
              THEN              0
              ELSE GRX_22_02
              END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_02_ny2
       = CAST ((
         CASE WHEN GRX_22_02 >= 0.66
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_03               for toplines */
       ,           GRX_22_03_ny1
       = CAST ((
         CASE WHEN GRX_22_03  < 0.66
              THEN              0
              ELSE GRX_22_03
              END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_03_ny2
       = CAST ((
         CASE WHEN GRX_22_03 >= 0.66
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_04               for toplines */
       ,           GRX_22_04_ny1
       = CAST ((
         CASE WHEN GRX_22_04  < 0.66
              THEN              0
              ELSE GRX_22_04
              END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_04_ny2
       = CAST ((
         CASE WHEN GRX_22_04 >= 0.66
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_24               for toplines */
       ,           GRX_24_ny1
       =           GRX_24
       ,           GRX_24_ny2
       = CAST ((
         CASE WHEN GRX_24  > 0
                  THEN           0.01
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_25               for toplines */
       ,           GRX_25_ny1
       = CAST ((
         CASE 
              WHEN GRX_25_01  =  0.00
              THEN               0.00
              WHEN GRX_25_01  =  1.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_25_ny2
       = CAST ((
         CASE 
              WHEN GRX_25_02  =  1.00
              THEN               0.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_25_ny3
       = CAST ((
         CASE 
              WHEN GRX_25_03  =  1.00
              THEN               0.03
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHX_25               for toplines */
       ,           SHX_25_ny1
       =           SHX_25
       ,           SHX_25_ny2
       = CAST ((
         CASE WHEN SHX_25  > 0
                  THEN           0.01
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHX_26               for toplines */
       ,           SHX_26_ny1
       =           SHX_26
       ,           SHX_26_ny2
       = CAST ((
         CASE WHEN SHX_26  > 0
                  THEN           0.01
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHX_27               for toplines */
       ,           SHX_27_ny1
       = CAST ((
         CASE 
              WHEN SHX_27_01  =  0.00
              THEN               0.00
              WHEN SHX_27_01  =  1.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHX_27_ny2
       = CAST ((
         CASE 
              WHEN SHX_27_02  =  1.00
              THEN               0.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHX_27_ny3
       = CAST ((
         CASE 
              WHEN SHX_27_03  =  1.00
              THEN               0.03
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , *
FROM
/*** View including numeric values aggregated by country/religion & year ***************************************************************************************/
               [dbo].[V2_W_by_Ctry&Year]
/*************************************************************************************** View including numeric values aggregated by country/religion & year ***/
/********************************************************************************************** table including numeric values + Step-1 calculated variables ***/
)                                                                                                                                                       AS NV_S1
/***************************************************************************************************************************************************************/
)                                                                                                                                                       AS NV_S2
/********************************************************************************************** table including numeric values + Step-2 calculated variables ***/
/* filters */
WHERE
Ctry_EditorialName                                   != 'North Korea'
AND
Ctry_EditorialName + '_/_' + STR(Question_Year, 4,0) != 'South Sudan_/_2010'            /* although data are not aggregated for the other part of former Sudan */
/* filters */
/********************************************************************************************** table including numeric values + Step-3 calculated variables ***/
/************************************************************************************************************************************* main select statement ***/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V4_L_by_CYV]    Script Date: 04/05/2016 06:06:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[V4_L_by_CYV]
AS
/***************************************************************************************************************************************************************/

/***************************************************************************************************************************************************************/
SELECT
        [Nation_fk]
      , [Ctry_EditorialName]
      , [Region5Yr]
         =        [Region5] + '_' + STR([Question_Year], 4,0)
      , [Region6Yr]
         =        [Region6] + '_' + STR([Question_Year], 4,0)
      , [Region5]
      , [Region6]
      , [YEAR]
         =        CASE
                  WHEN [Question_Year] <  2011 THEN 'MID-' + STR([Question_Year], 4,0)
                  ELSE                              'END-' + STR([Question_Year], 4,0)
                  END
      , [Question_Year]
      , [GRI]
      , [SHI]
      , [GFI]
      , [Variable]
         =        
                  CASE
                  WHEN                 [Variable] LIKE '%_ny%' 
                  THEN STUFF(          [Variable]      ,         
                  ((CHARINDEX('_ny', [Variable])) + 3) , 1, '')
                  ELSE                 [Variable]
                  END
      , [Value]
      , [PctWg]
         =        
                  CAST ((
                            100.000000000000
                           /SUM([CntWg]) 
                            OVER(
                            PARTITION BY  [Question_Year]
                                        , [Variable]      )
                                                            ) AS DECIMAL (38,12))
      , [PctWgR5]
         =        
                  CAST ((
                            100.000000000000
                           /SUM([CntWg]) 
                            OVER(
                            PARTITION BY  [Region5]
                                        , [Question_Year]
                                        , [Variable]      )
                                                            ) AS DECIMAL (38,12))
      , [PctWgR6]
         =        
                  CAST ((
                            100.000000000000
                           /SUM([CntWg]) 
                            OVER(
                            PARTITION BY  [Region6]
                                        , [Question_Year]
                                        , [Variable]      )
                                                            ) AS DECIMAL (38,12))
      , [CntWg] 
FROM
(
SELECT  
        *
      , [CntWg] 
         =        1
  FROM [V3_W&Extras_by_Ctry&Year]
) NR
UNPIVOT
  (
     Value
FOR
     Variable
in (
/***************************************************************************************************************************************************************/
 CSR_01, CSR_02, CSR_02_a, CSR_02_b, CSR_02_c, CSR_02_d, CSR_03_a, CSR_03_b, CSR_03_c, CSR_04_a, CSR_04_b, CSR_04_c, CSR_05, CSR_06, CSR_S_01, CSR_S_02, CSR_S_03, CSR_S_04, CSR_S_05, CSR_S_06, CSR_S_07, CSR_S_08, CSR_S_09, CSR_S_10, CSR_S_11, CSR_S_12, CSR_S_13, CSR_S_14, CSR_S_15, CSR_S_16, CSR_S_17, CSR_S_18, CSR_S_19, CSR_S_20, CSR_S_21, CSR_S_22, CSR_S_23, CSR_S_24, CSR_S_25, CSR_S_99_01, CSR_S_99_02, CSR_S_99_03, ERI_01, ERI_02, ERI_03, ERI_04, ERI_05, ERI_06, ERI_06_a, ERI_06_b, ERI_06_b_x, ERI_06_c, ERI_06_c_x, ERI_06_x, ERI_07, ERI_07_a, ERI_07_b, ERI_07_b_x, ERI_07_c, ERI_07_c_x, ERI_07_x, ERI_08, ERI_08_a, ERI_08_b, ERI_08_b_x, ERI_08_c, ERI_08_c_x, ERI_08_x, ERI_S_01, ERI_S_02, ERI_S_03, ERI_S_04, ERI_S_05, ERI_S_06, ERI_S_07, ERI_S_08, ERI_S_09, ERI_S_10, ERI_S_11, ERI_S_12, ERI_S_13, ERI_S_14, ERI_S_15, ERI_S_16, ERI_S_17, ERI_S_18, ERI_S_19, ERI_S_20, ERI_S_21, ERI_S_22, ERI_S_23, ERI_S_24, ERI_S_25, ERI_S_99_01, ERI_S_99_02, ERI_S_99_03, ERI_S_99_04, GFI_scaled, GRI_01, GRI_01_x, GRI_01_x2, GRI_02, GRI_03, GRI_04, GRI_05, GRI_06, GRI_07, GRI_08, GRI_08_for_index, GRI_09, GRI_10, GRI_10_01, GRI_10_02, GRI_10_03, GRI_11, GRI_11_01a, GRI_11_01b, GRI_11_02, GRI_11_03, GRI_11_04, GRI_11_05, GRI_11_06, GRI_11_07, GRI_11_08, GRI_11_09, GRI_11_10, GRI_11_11, GRI_11_12, GRI_11_13, GRI_11_14, GRI_11_15, GRI_11_16, GRI_11_17, GRI_11_xG1, GRI_11_xG2, GRI_11_xG3, GRI_11_xG4, GRI_11_xG5, GRI_11_xG6, GRI_11_xG7, GRI_12, GRI_13, GRI_14, GRI_15, GRI_16, GRI_16_01, GRI_16_ny1, GRI_16_ny2, GRI_17, GRI_18, GRI_19, GRI_19_b, GRI_19_c, GRI_19_d, GRI_19_da, GRI_19_db, GRI_19_e, GRI_19_f, GRI_19_ny1, GRI_19_ny2, GRI_19_summ_ny1, GRI_19_summ_ny2, GRI_19_summ_ny3, GRI_19_summ_ny4, GRI_19_summ_ny5, GRI_19_summ_ny6, GRI_19_x, GRI_20, GRI_20_01, GRI_20_01x_01a, GRI_20_01x_01b, GRI_20_01x_02, GRI_20_01x_03, GRI_20_01x_04, GRI_20_01x_05, GRI_20_01x_06, GRI_20_01x_07, GRI_20_01x_08, GRI_20_01x_09, GRI_20_01x_10, GRI_20_02, GRI_20_03_a, GRI_20_03_b, GRI_20_03_c, GRI_20_03_top, GRI_20_04, GRI_20_04_x, GRI_20_05, GRI_20_05_x, GRI_20_05_x1, GRI_20_top, GRI_scaled, GRX_21_01, GRX_21_02, GRX_21_03, GRX_22, GRX_22_01, GRX_22_01_ny1, GRX_22_01_ny2, GRX_22_02, GRX_22_02_ny1, GRX_22_02_ny2, GRX_22_03, GRX_22_03_ny1, GRX_22_03_ny2, GRX_22_04, GRX_22_04_ny1, GRX_22_04_ny2, GRX_22_ny1, GRX_23, GRX_24, GRX_24_ny1, GRX_24_ny2, GRX_25_01, GRX_25_02, GRX_25_03, GRX_25_ny1, GRX_25_ny2, GRX_25_ny3, GRX_26_01, GRX_26_02, GRX_26_03, GRX_26_04, GRX_26_05, GRX_26_06, GRX_26_07, GRX_26_08, GRX_27_01, GRX_27_02, GRX_27_03, GRX_28_01, GRX_28_02, GRX_28_03, GRX_29_01, GRX_29_02, GRX_29_03, GRX_29_04, GRX_29_05, IEI_01, IEI_02, IEI_A_01, IEI_S_01, IEI_S_02, IEI_S_03, IEI_S_04, IEI_S_05, IEI_S_06, IEI_S_07, IEI_S_08, IEI_S_09, IEI_S_10, IEI_S_11, IEI_S_12, IEI_S_13, IEI_S_14, IEI_S_15, IEI_S_16, IEI_S_17, IEI_S_18, IEI_S_19, IEI_S_20, IEI_S_21, IEI_S_22, IEI_S_23, IEI_S_24, IEI_S_25, IEI_S_99_01, IEI_S_99_02, PPR_01, PPR_01_a, PPR_02, PPR_02_a, PPR_03, PPR_04, PPR_S_01, PPR_S_02, PPR_S_03, PPR_S_04, PPR_S_05, PPR_S_06, PPR_S_07, PPR_S_08, PPR_S_09, PPR_S_10, PPR_S_11, PPR_S_12, PPR_S_13, PPR_S_14, PPR_S_15, PPR_S_16, PPR_S_17, PPR_S_18, PPR_S_19, PPR_S_20, PPR_S_21, PPR_S_22, PPR_S_23, PPR_S_24, PPR_S_25, PPR_S_99_01, PPR_S_99_02, PPR_S_99_03, RIR_01, RIR_02, RIR_03, RIR_03_a, RIR_03_b, RIR_03_c, RIR_04, RIR_04_a_01, RIR_04_a_02, RIR_04_a_03, RIR_04_a_04, RIR_04_b_01, RIR_04_b_02, RIR_04_b_03, RIR_04_b_04, RIR_S_01, RIR_S_02, RIR_S_03, RIR_S_04, RIR_S_05, RIR_S_06, RIR_S_07, RIR_S_08, RIR_S_09, RIR_S_10, RIR_S_11, RIR_S_12, RIR_S_13, RIR_S_14, RIR_S_15, RIR_S_16, RIR_S_17, RIR_S_18, RIR_S_19, RIR_S_20, RIR_S_21, RIR_S_22, RIR_S_23, RIR_S_24, RIR_S_25, RIR_S_99_01, RIR_S_99_02, RIR_S_99_03, SHI_01, SHI_01_a, SHI_01_a_dummy, SHI_01_b, SHI_01_b_dummy, SHI_01_c, SHI_01_c_dummy, SHI_01_d, SHI_01_d_dummy, SHI_01_da, SHI_01_db, SHI_01_e, SHI_01_e_dummy, SHI_01_f, SHI_01_f_dummy, SHI_01_summary_a_ny0, SHI_01_summary_a_ny1, SHI_01_summary_a_ny2, SHI_01_summary_a_ny3, SHI_01_summary_a_ny4, SHI_01_summary_a_ny5, SHI_01_summary_a_ny6, SHI_01_summary_b, SHI_01_x_01a, SHI_01_x_01b, SHI_01_x_02, SHI_01_x_03, SHI_01_x_04, SHI_01_x_05, SHI_01_x_06, SHI_01_x_07, SHI_01_x_08, SHI_01_x_09, SHI_01_x_10, SHI_01_x_11, SHI_01_x_12, SHI_01_x_13, SHI_01_x_14, SHI_01_x_15, SHI_01_x_16, SHI_01_x_17, SHI_01_xG1, SHI_01_xG2, SHI_01_xG3, SHI_01_xG4, SHI_01_xG5, SHI_01_xG6, SHI_01_xG7, SHI_02, SHI_02_01, SHI_03, SHI_04, SHI_04_b, SHI_04_c, SHI_04_d, SHI_04_da, SHI_04_db, SHI_04_e, SHI_04_f, SHI_04_ny0, SHI_04_ny1, SHI_04_x01, SHI_05, SHI_05_b, SHI_05_c, SHI_05_d, SHI_05_da, SHI_05_db, SHI_05_e, SHI_05_f, SHI_05_ny0, SHI_05_ny1, SHI_06, SHI_07, SHI_07_ny0, SHI_07_ny1, SHI_08, SHI_09, SHI_10, SHI_11, SHI_11_for_index, SHI_11_x, SHI_12, SHI_13, SHI_scaled, SHX_14_01, SHX_14_02, SHX_14_03, SHX_14_04, SHX_15_01, SHX_15_02, SHX_15_03, SHX_15_04, SHX_15_05, SHX_15_06, SHX_15_07, SHX_15_08, SHX_15_09, SHX_15_10, SHX_25, SHX_25_ny1, SHX_25_ny2, SHX_26, SHX_26_ny1, SHX_26_ny2, SHX_27_01, SHX_27_02, SHX_27_03, SHX_27_ny1, SHX_27_ny2, SHX_27_ny3, SHX_28_01, SHX_28_02, SHX_28_03, SHX_28_04, SHX_28_05, SHX_28_06, SHX_28_07, SHX_28_08, XSG_01_xG1, XSG_01_xG2, XSG_01_xG3, XSG_01_xG4, XSG_01_xG5, XSG_01_xG6, XSG_01_xG7, XSG_24, XSG_242526_ny0, XSG_242526_ny1, XSG_25n27_ny1, XSG_25n27_ny2, XSG_25n27_ny3, XSG_S_01, XSG_S_02, XSG_S_03, XSG_S_04, XSG_S_05, XSG_S_06, XSG_S_07, XSG_S_08, XSG_S_09, XSG_S_10, XSG_S_11, XSG_S_12, XSG_S_13, XSG_S_14, XSG_S_15, XSG_S_16, XSG_S_17, XSG_S_18, XSG_S_19, XSG_S_20, XSG_S_21, XSG_S_22, XSG_S_23, XSG_S_99_01, XSG_S_99_02, XSG_S_99_03, XSG_S_99_04, XSG_S_99_05, XSG_S_99_06
/***************************************************************************************************************************************************************/
)                                                                               /*** end of listing of variables                                             ***/
 )                                                                                                                                                      AS   pivt
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V5_LRestr_by_CYV]    Script Date: 04/05/2016 06:06:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[V5_LRestr_by_CYV]
AS
/***************************************************************************************************************************************************************/
SELECT
       *
  FROM
/***************************************************************************************************************************************************************/
(  
/***************************************************************************************************************************************************************/
SELECT   
        [row_key]            = ROW_NUMBER()
                               OVER(ORDER BY   
                                                  V.[Nation_fk]
                                                , Q.[Q_Number]
                                                , V.[Question_Year]
                                                , V.[Variable]
                                                , V.[Value]                      ) 
      ,  [Nation_fk]
      ,  [Ctry_EditorialName]
      ,  [YEAR]
      ,  [Question_Year]
      ,  [GRI]
      ,  [SHI]
      ,  [GFI]
      ,V.[Variable]
      ,  [Value]
      ,  [PctWg]
      ,  [PctWgR5]
      ,  [PctWgR6]
      ,  [CntWg]
      ,Q.[Q_Number]
  FROM [V4_L_by_CYV]       V
     , [AllQuestions]      Q
WHERE  
       V.[Variable]
     = Q.[Variable]
/***************************************************************************************************************************************************************/
)   AS  V4s
/***************************************************************************************************************************************************************/
    WHERE                                                                       /*** begining of filters to be applied...                                    ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'CSR%'                                           /*** filter to exclude CSR questions                                         ***/
    AND                                                                         /*** second filter to be applied...                                          ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'ERI%'                                           /*** filter to exclude ERI questions                                         ***/
    AND                                                                         /*** third filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'IEI%'                                           /*** filter to exclude IEI questions                                         ***/
    AND                                                                         /*** fourth filter to be applied...                                          ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'PPR%'                                           /*** filter to exclude PPR questions                                         ***/
    AND                                                                         /*** ficth filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'RIR%'                                           /*** filter to exclude RIR questions                                         ***/
    AND                                                                         /*** ficth filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE '%_ny'                                           /*** filter to exclude y/n (repeated) questions                              ***/
    AND                                                                         /*** ficth filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE '%_dummy'                                        /*** filter to exclude dummy questions                                       ***/
    AND                                                                         /*** ficth filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT IN (                                                  /*** filter to exclude unuseful Restrictions/Hostilities questions           ***/
                                  'GRI_01_x2'
                                , 'XSG_S_99_01'
                                , 'XSG_S_99_02'
                                , 'XSG_S_99_03'
                                , 'XSG_S_99_04'
                                , 'XSG_S_99_05'
                                , 'XSG_S_99_06'
                                , 'GRI_20_05_x1'
                                , 'GRX_21_01'
                                , 'GRX_21_02'
                                , 'GRX_21_03'
                                                            )

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V6_Basic&Index]    Script Date: 04/05/2016 06:07:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[V6_Basic&Index]
AS
/***************************************************************************************************************************************************************/
/***  Begining of select statement (values by country)  ********************************************************************************************************/
/***************************************************************************************************************************************************************/
SELECT 
/*** variables NOT changing though time ************************************************************************************************************************/
       [Nation_fk]
      ,[Country_fk]
      ,[Ctry_EditorialName]
      ,[GDP_per_capita]
      ,[Region5]
      ,[Region6]
      ,[SubRegion]
      ,[IMF_Advance]
      ,[Global_NS]
      ,[UN_Reg1]
      ,[UN_Reg2]
      ,[UN_Develop]
/*** population variables CAN CHANGE though time ***************************************************************************************************************/
      ,[Pop2000]
      ,[Pop2010]
      ,[Pop2012]
/*** index values SHOULD BE ADDED EACH YEAR ********************************************************************************************************************/
      ,[GRI_2007]
      ,[GRI_2008]
      ,[GRI_2009]
      ,[GRI_2010]
      ,[GRI_2011]
      ,[GRI_2012]
      ,[SHI_2007]
      ,[SHI_2008]
      ,[SHI_2009]
      ,[SHI_2010]
      ,[SHI_2011]
      ,[SHI_2012]
      ,[GFI_2007]
      ,[GFI_2008]
      ,[GFI_2009]
      ,[GFI_2010]
      ,[GFI_2011]
      ,[GFI_2012]
/***************************************************************************************************************************************************************/
FROM
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
SELECT 
/*** variables NOT changibng though time ***********************************************************************************************************************/
       [Nation_pk]                 AS Nation_fk
      ,[Country_fk]
      ,N.[Ctry_EditorialName]
      ,[GDP_per_capita]
      ,[Region]                    AS Region5
      ,[SubRegion6]                AS Region6
      ,[SubRegion]
      ,[IMF_Advance]
      ,[Global_NS]
      ,[UN_Reg1]
      ,[UN_Reg2]
      ,[UN_Develop]
/*** population variables CAN CHANGE though time ***************************************************************************************************************/
      ,S1.[Cnt]                    AS Pop2000
      ,S2.[Cnt]                    AS Pop2010
      ,S3.[Cnt]                    AS Pop2012
/*** sources for the query (some repeated for different years) *************************************************************************************************/
  FROM 
       [forum].[dbo].[Pew_Nation]                N
     , [forum].[dbo].[Pew_Nation_Age_Sex_Value]  S1
     , [forum].[dbo].[Pew_Field]                 F1
     , [forum].[dbo].[Pew_Nation_Age_Sex_Value]  S2
     , [forum].[dbo].[Pew_Field]                 F2
     , [forum].[dbo].[Pew_Nation_Age_Sex_Value]  S3
     , [forum].[dbo].[Pew_Field]                 F3
/*** filters and matching conditions ***************************************************************************************************************************/
 WHERE 
       S1.[Nation_fk]   =     [Nation_pk]
   AND S2.[Nation_fk]   =     [Nation_pk]
   AND S3.[Nation_fk]   =     [Nation_pk]
   AND S1.[Field_fk]    =  F1.[Field_pk]
   AND S2.[Field_fk]    =  F2.[Field_pk]
   AND S3.[Field_fk]    =  F3.[Field_pk]
   AND S1.[Age_fk]      =  0
   AND S1.[Sex_fk]      =  0
   AND S2.[Age_fk]      =  0
   AND S2.[Sex_fk]      =  0
   AND S3.[Age_fk]      =  0
   AND S3.[Sex_fk]      =  0
   AND F1.[Field_year]  =  '2000'
   AND F2.[Field_year]  =  '2010'
   AND F3.[Field_year]  =  '2012'
/***************************************************************************************************************************************************************/
)                                                                                                                                           AS      M  /* MAIN */
/***************************************************************************************************************************************************************/
LEFT JOIN
/***************************************************************************************************************************************************************/
/*** query with most current index values should be added here to be joined ************************************************************************************/
/***************************************************************************************************************************************************************/
(
/*** index values for 2012 *************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [Nation_fk]              AS N2012_pk
      ,[GRI]                    AS GRI_2012
      ,[SHI]                    AS SHI_2012
      ,[GFI]                    AS GFI_2012
  FROM 
       [V3_W&Extras_by_Ctry&Year]
 WHERE 
       [Question_Year]  =  2012
/***************************************************************************************************************************************************************/
)                                                                                                                                         AS   I2012   /* MAIN */
/***************************************************************************************************************************************************************/
ON 
     Nation_fk = N2012_pk
/***************************************************************************************************************************************************************/
LEFT JOIN
/***************************************************************************************************************************************************************/
(
/*** index values for 2011 *************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [Nation_fk]              AS N2011_pk
      ,[GRI]                    AS GRI_2011
      ,[SHI]                    AS SHI_2011
      ,[GFI]                    AS GFI_2011
  FROM 
       [V3_W&Extras_by_Ctry&Year]
 WHERE 
       [Question_Year]  =  2011
/***************************************************************************************************************************************************************/
)                                                                                                                                         AS   I2011   /* MAIN */
/***************************************************************************************************************************************************************/
ON 
     Nation_fk = N2011_pk
/***************************************************************************************************************************************************************/
LEFT JOIN
/***************************************************************************************************************************************************************/
(
/*** index values for 2010 *************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [Nation_fk]              AS N2010_pk
      ,[GRI]                    AS GRI_2010
      ,[SHI]                    AS SHI_2010
      ,[GFI]                    AS GFI_2010
  FROM 
       [V3_W&Extras_by_Ctry&Year]
 WHERE 
       [Question_Year]  =  2010
/***************************************************************************************************************************************************************/
)                                                                                                                                         AS   I2010   /* MAIN */
/***************************************************************************************************************************************************************/
ON 
     Nation_fk = N2010_pk
/***************************************************************************************************************************************************************/
LEFT JOIN
/***************************************************************************************************************************************************************/
(
/*** index values for 2009 *************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [Nation_fk]              AS N2009_pk
      ,[GRI]                    AS GRI_2009
      ,[SHI]                    AS SHI_2009
      ,[GFI]                    AS GFI_2009
  FROM 
       [V3_W&Extras_by_Ctry&Year]
 WHERE 
       [Question_Year]  =  2009
/***************************************************************************************************************************************************************/
)                                                                                                                                         AS   I2009   /* MAIN */
/***************************************************************************************************************************************************************/
ON 
     Nation_fk = N2009_pk
/***************************************************************************************************************************************************************/
LEFT JOIN
/***************************************************************************************************************************************************************/
(
/*** index values for 2008 *************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [Nation_fk]              AS N2008_pk
      ,[GRI]                    AS GRI_2008
      ,[SHI]                    AS SHI_2008
      ,[GFI]                    AS GFI_2008
  FROM 
       [V3_W&Extras_by_Ctry&Year]
 WHERE 
       [Question_Year]  =  2008
/***************************************************************************************************************************************************************/
)                                                                                                                                         AS   I2008   /* MAIN */
/***************************************************************************************************************************************************************/
ON 
     Nation_fk = N2008_pk
/***************************************************************************************************************************************************************/
LEFT JOIN
/***************************************************************************************************************************************************************/
(
/*** index values for 2007 *************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [Nation_fk]              AS N2007_pk
      ,[GRI]                    AS GRI_2007
      ,[SHI]                    AS SHI_2007
      ,[GFI]                    AS GFI_2007
  FROM 
       [V3_W&Extras_by_Ctry&Year]
 WHERE 
       [Question_Year]  =  2007
/***************************************************************************************************************************************************************/
)                                                                                                                                         AS   I2007   /* MAIN */
/***************************************************************************************************************************************************************/
ON 
     Nation_fk = N2007_pk
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V7_LRestr_by_CV]    Script Date: 04/05/2016 09:30:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[V7_LRestr_by_CV]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  Begining of select statement (values by country/year/question)  ******************************************************************************************/

/***************************************************************************************************************************************************************/
SELECT
          V5Row
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [Variable]
                           , [Value]
                                          )
        , Variable
        , Value
        , [NC_MID-2007]   =  STR(MAX([NC_MID-2007]),12,0)
        , [PC_MID-2007]   =  STR(MAX([PC_MID-2007]),3,0)
        , [NC_MID-2008]   =  STR(MAX([NC_MID-2008]),12,0)
        , [PC_MID-2008]   =  STR(MAX([PC_MID-2008]),3,0)
        , [NC_MID-2009]   =  STR(MAX([NC_MID-2009]),12,0)
        , [PC_MID-2009]   =  STR(MAX([PC_MID-2009]),3,0)
        , [NC_MID-2010]   =  STR(MAX([NC_MID-2010]),12,0)
        , [PC_MID-2010]   =  STR(MAX([PC_MID-2010]),3,0)
        , [NC_END-2011]   =  STR(MAX([NC_END-2011]),12,0)
        , [PC_END-2011]   =  STR(MAX([PC_END-2011]),3,0)
        , [NC_END-2012]   =  STR(MAX([NC_END-2012]),12,0)
        , [PC_END-2012]   =  STR(MAX([PC_END-2012]),3,0)
FROM
(
/*** AggrEgate view by C/Y/Q/A *********************************************************************************************************************************/
SELECT
       [YCNT]     = 'NC_' + [YEAR]
      ,[YPCT]     = 'PC_' + [YEAR]
      ,[Variable]
      ,[Value]
      ,Number     = SUM([CntWg])
      ,Percentage = SUM([PctWg])
  FROM
/***************************************************************************************************************************************************************/
(
/*** >>> recode for total events (only GRI_19 is currently working) ********************************************************************************************/
/***************************************************************************************************************************************************************/
SELECT 
       [YEAR]
      ,[Variable]
      ,[Value]
               = CASE
                 WHEN [Variable] = 'GRI_19_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'GRI_19_x'
                  AND [Value]    = 0
                 THEN              NULL
                 WHEN [Variable] = 'SHI_01_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'SHI_01_x'
                  AND [Value]    = 0
                 THEN              NULL
                 WHEN [Variable] = 'SHI_04_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'SHI_04_x'
                  AND [Value]    = 0
                 THEN              NULL
                 WHEN [Variable] = 'SHI_05_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'SHI_05_x'
                  AND [Value]    = 0
                 THEN              NULL
                 ELSE [Value]
                 END
      ,[PctWg]
               = CASE
                 WHEN [Variable] = 'GRI_19_x'
                 THEN              NULL
                 WHEN [Variable] = 'SHI_01_x'
                 THEN              NULL
                 WHEN [Variable] = 'SHI_04_x'
                 THEN              NULL
                 WHEN [Variable] = 'SHI_05_x'
                 THEN              NULL
                 ELSE [PctWg]
                 END
      ,[CntWg]
               = CASE
                 WHEN [Variable] = 'GRI_19_x'
                 THEN [Value]
                 WHEN [Variable] = 'SHI_01_x'
                 THEN [Value]
                 WHEN [Variable] = 'SHI_04_x'
                 THEN [Value]
                 WHEN [Variable] = 'SHI_05_x'
                 THEN [Value]
                 ELSE [CntWg]
                 END
  FROM 
       [V4_L_by_CYV]
/*** <<< recode for total events *******************************************************************************************************************************/
)                                                                                                                                                      AS    RTE
/***************************************************************************************************************************************************************/
GROUP BY
       [YEAR]
      ,[Variable]
      ,[Value]
--ORDER BY
--       [YEAR]
--      ,[Variable]
--      ,[Value]
/********************************************************************************************************************************* Aggregate view by C/Y/Q/A ***/
)                                                                                                                                                      AS A_CYQA
/*** pivoting percentage ***************************************************************************************************************************************/
PIVOT
 (
     MAX(Percentage)
FOR
     YPCT
in (
        [PC_MID-2007]
      , [PC_MID-2008]
      , [PC_MID-2009]
      , [PC_MID-2010]
      , [PC_END-2011]
      , [PC_END-2012]
/***************************************************************************************************************************************************************/
                         )                                                      /*** end of listing of variables                                             ***/
 )                                                                                                                                                    AS   pivt1
/*************************************************************************************************************************************** pivoting percentage ***/
/*** pivoting counts *******************************************************************************************************************************************/
PIVOT
 (
     MAX(Number)
FOR
     YCNT
in (
        [NC_MID-2007]
      , [NC_MID-2008]
      , [NC_MID-2009]
      , [NC_MID-2010]
      , [NC_END-2011]
      , [NC_END-2012]
/***************************************************************************************************************************************************************/
                         )                                                      /*** end of listing of variables                                             ***/
 )                                                                                                                                                    AS   pivt2
/******************************************************************************************************************************************* pivoting counts ***/

GROUP BY
          Variable
        , Value


--ORDER BY
--       [Variable]
--      ,[Value]

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V7_LRestr_by_VarVal]    Script Date: 04/05/2016 09:31:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[V7_LRestr_by_VarVal]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  Begining of select statement (values by country/year/question)  ******************************************************************************************/

/***************************************************************************************************************************************************************/
SELECT
          V5Row
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [Variable]
                           , [Value]
                                          )
        , Variable
        , Value
        , [NC_MID-2007]   =  STR(MAX([NC_MID-2007]),12,0)
        , [PC_MID-2007]   =  STR(MAX([PC_MID-2007]),3,0)
        , [NC_MID-2008]   =  STR(MAX([NC_MID-2008]),12,0)
        , [PC_MID-2008]   =  STR(MAX([PC_MID-2008]),3,0)
        , [NC_MID-2009]   =  STR(MAX([NC_MID-2009]),12,0)
        , [PC_MID-2009]   =  STR(MAX([PC_MID-2009]),3,0)
        , [NC_MID-2010]   =  STR(MAX([NC_MID-2010]),12,0)
        , [PC_MID-2010]   =  STR(MAX([PC_MID-2010]),3,0)
        , [NC_END-2011]   =  STR(MAX([NC_END-2011]),12,0)
        , [PC_END-2011]   =  STR(MAX([PC_END-2011]),3,0)
        , [NC_END-2012]   =  STR(MAX([NC_END-2012]),12,0)
        , [PC_END-2012]   =  STR(MAX([PC_END-2012]),3,0)
FROM
(
/*** AggrEgate view by C/Y/Q/A *********************************************************************************************************************************/
SELECT
       [YCNT]     = 'NC_' + [YEAR]
      ,[YPCT]     = 'PC_' + [YEAR]
      ,[Variable]
      ,[Value]
      ,Number     = SUM([CntWg])
      ,Percentage = SUM([PctWg])
  FROM
/***************************************************************************************************************************************************************/
(
/*** >>> recode for total events (only GRI_19 is currently working) ********************************************************************************************/
/***************************************************************************************************************************************************************/
SELECT 
       [YEAR]
      ,[Variable]
      ,[Value]
               = CASE
                 WHEN [Variable] = 'GRI_19_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'GRI_19_x'
                  AND [Value]    = 0
                 THEN              NULL
                 WHEN [Variable] = 'SHI_01_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'SHI_01_x'
                  AND [Value]    = 0
                 THEN              NULL
                 WHEN [Variable] = 'SHI_04_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'SHI_04_x'
                  AND [Value]    = 0
                 THEN              NULL
                 WHEN [Variable] = 'SHI_05_x'
                  AND [Value]    > 0
                 THEN              0
                 WHEN [Variable] = 'SHI_05_x'
                  AND [Value]    = 0
                 THEN              NULL
                 ELSE [Value]
                 END
      ,[PctWg]
               = CASE
                 WHEN [Variable] = 'GRI_19_x'
                 THEN              NULL
                 WHEN [Variable] = 'SHI_01_x'
                 THEN              NULL
                 WHEN [Variable] = 'SHI_04_x'
                 THEN              NULL
                 WHEN [Variable] = 'SHI_05_x'
                 THEN              NULL
                 ELSE [PctWg]
                 END
      ,[CntWg]
               = CASE
                 WHEN [Variable] = 'GRI_19_x'
                 THEN [Value]
                 WHEN [Variable] = 'SHI_01_x'
                 THEN [Value]
                 WHEN [Variable] = 'SHI_04_x'
                 THEN [Value]
                 WHEN [Variable] = 'SHI_05_x'
                 THEN [Value]
                 ELSE [CntWg]
                 END
  FROM 
       [V4_L_by_CYV]
/*** <<< recode for total events *******************************************************************************************************************************/
)                                                                                                                                                      AS    RTE
/***************************************************************************************************************************************************************/
GROUP BY
       [YEAR]
      ,[Variable]
      ,[Value]
/********************************************************************************************************************************* Aggregate view by C/Y/Q/A ***/
)                                                                                                                                                      AS A_CYQA
/*** pivoting percentage ***************************************************************************************************************************************/
PIVOT
 (
     MAX(Percentage)
FOR
     YPCT
in (
        [PC_MID-2007]
      , [PC_MID-2008]
      , [PC_MID-2009]
      , [PC_MID-2010]
      , [PC_END-2011]
      , [PC_END-2012]
/***************************************************************************************************************************************************************/
                         )                                                      /*** end of listing of variables                                             ***/
 )                                                                                                                                                    AS   pivt1
/*************************************************************************************************************************************** pivoting percentage ***/
/*** pivoting counts *******************************************************************************************************************************************/
PIVOT
 (
     MAX(Number)
FOR
     YCNT
in (
        [NC_MID-2007]
      , [NC_MID-2008]
      , [NC_MID-2009]
      , [NC_MID-2010]
      , [NC_END-2011]
      , [NC_END-2012]
/***************************************************************************************************************************************************************/
                         )                                                      /*** end of listing of variables                                             ***/
 )                                                                                                                                                    AS   pivt2
/******************************************************************************************************************************************* pivoting counts ***/

GROUP BY
          Variable
        , Value

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V8_AggIdx_by_VarVal]    Script Date: 04/05/2016 09:31:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[V8_AggIdx_by_VarVal]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  Begining of select statement (values by country/year/question)  ******************************************************************************************/
/***************************************************************************************************************************************************************/
SELECT
          V7Row
          =  ROW_NUMBER()
             OVER(ORDER BY
                             Variable
                           , Value
                           , INDX
                                          )
        , Variable
        , Value
        , INDX
        , AVRG
        , NCtries = STR(NCtries)
FROM
/***************************************************************************************************************************************************************/
(
/*** union of both GRI & SHI aggregate views by C/Y/Q/A ********************************************************************************************************/
/***************************************************************************************************************************************************************/
/*** Aggregate view by C/Y/Q/A *********************************************************************************************************************************/
SELECT
       [Variable]
      ,[Value]
      ,INDX     =     'GRI'
      ,AVRG     = AVG([GRI])
      ,NCtries  = SUM([CntWg])
  FROM
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
SELECT 
       [GRI]
      ,[Question_Year]
      ,[Variable]
      ,[Value]
      ,[CntWg]
  FROM 
       [V4_L_by_CYV]
WHERE 
       [Question_Year] = 2012
  AND 
    (
       [Variable]      LIKE 'SH%'
   OR
       [Variable]      LIKE 'GR%'
   OR
       [Variable]      LIKE 'GF%'
   OR
       [Variable]      LIKE 'XS%'
    )
/*** <<< recode for total events *******************************************************************************************************************************/
)                                                                                                                                                      AS    RTE
/***************************************************************************************************************************************************************/
GROUP BY
       [Variable]
      ,[Value]
/********************************************************************************************************************************* Aggregate view by C/Y/Q/A ***/
UNION
/*** Aggregate view by C/Y/Q/A *********************************************************************************************************************************/
SELECT
       [Variable]
      ,[Value]
      ,INDX     =     'SHI'
      ,AVRG     = AVG([SHI])
      ,NCtries  = SUM([CntWg])
  FROM
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
SELECT 
       [SHI]
      ,[Question_Year]
      ,[Variable]
      ,[Value]
      ,[CntWg]

  FROM 
       [V4_L_by_CYV]
WHERE 
       [Question_Year] = 2012
  AND 
    (
       [Variable]      LIKE 'SH%'
   OR
       [Variable]      LIKE 'GR%'
   OR
       [Variable]      LIKE 'GF%'
   OR
       [Variable]      LIKE 'XS%'
    )
/*** <<< recode for total events *******************************************************************************************************************************/
)                                                                                                                                                      AS    RTE
/***************************************************************************************************************************************************************/
GROUP BY
       [Variable]
      ,[Value]
/********************************************************************************************************************************* Aggregate view by C/Y/Q/A ***/
)                                                                                                                                                      AS    UBA
/******************************************************************************************************** union of both GRI & SHI aggregate views by C/Y/Q/A ***/

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[V9_AggIdx_by_Yr]    Script Date: 04/05/2016 09:32:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
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

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vg_01__AgeSex_DisplayRules]    Script Date: 04/05/2016 09:33:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vg_01__AgeSex_DisplayRules]
AS
/********************************************************************************************************************************************************/
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
          [asfDR_row]                  = ROW_NUMBER()OVER(ORDER BY 
                                                        [IsDisplayed] DESC 
                                                    , A.[Field_year]
                                                    , A.[Scenario_pk]
                                                    , D.[Nation_fk]
                                                    , D.[Religion_Group_fk]
                                                    , D.[rows]               )
----------------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [Ctry_EditorialName]         = CASE
                                         WHEN D.[Ctry_EditorialName] IS NULL
                                         THEN '>> ALL COUNTRIES <<'
                                         ELSE D.[Ctry_EditorialName]
                                         END
      ,   [Religion]                   = CASE
                                         WHEN D.[Pew_RelL02_Display] IS NULL
                                         THEN '>> ALL RELIGIONS <<'
                                         ELSE D.[Pew_RelL02_Display]
                                         END
      ,   [level]                      = CASE
                                         WHEN D.[level] IS NULL
                                         THEN 'Both Total & by cohorts'
                                         ELSE D.[level]
                                         END
----------------------------------------------------------------------------------------------------------------------------------------------------------
      , D.[Display_AgeSex_Str]
      , D.[Display_AgeStr_15Yrs]
      , D.[Display_MedianAge]
      , A.[Field_fk]
      , A.[Scenario_pk]
      , D.[Nation_fk]                  
      , D.[Religion_Group_fk]
      , A.[Field_year]
      , A.[Scenario_description]
      , A.[NofRows_by_Field&Scenario]
      , B.[NofRows_to_be_Hidden]
      ,   [NofRows_to_Display]         = ISNULL(C.[NofRows_to_Display], 0)
      , D.[rows]
  FROM
(
/* rows per Field&Scenario -----------------------------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_pk]
      ,[Field_year]
      ,[Scenario_description]
      , COUNT(*)     [NofRows_by_Field&Scenario]
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]  X
     , [forum].[dbo].[Pew_Field]                          F
     , [forum].[dbo].[Pew_Scenario]                       S
WHERE 
       [Field_pk]
     = [Field_fk]
and
       X.[Scenario_id]
     = S.[Scenario_id]

GROUP
   BY
       [Field_fk]
      ,[Scenario_pk]
      ,[Field_year]
      ,[Scenario_description]
/* < rows per Field&Scenario ---------------------------------------------------------------------------------------------------------------------------*/
) A
LEFT OUTER JOIN 
(
/* rows per Field&Scenario&Display NOT DISPLAYED  ------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      , COUNT(*)     [NofRows_to_be_Hidden]
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
WHERE  [Display_AgeSex_Str]     = 0
AND    [Display_AgeStr_15Yrs]   = 0
AND    [Display_MedianAge]      = 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
/* < rows per Field&Scenario&Display NOT DISPLAYED  ----------------------------------------------------------------------------------------------------*/
) B
ON      A.[Field_fk]
      = B.[Field_fk]
AND
        A.[Scenario_pk]
      = B.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
LEFT OUTER JOIN 
(
/* rows per Field&Scenario&Display DISPLAYED  ----------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      , COUNT(*)     [NofRows_to_Display]
      ,[IsDisplayed] = 1
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
WHERE  [Display_AgeSex_Str]    != 0
   OR  [Display_AgeStr_15Yrs]  != 0
   OR  [Display_MedianAge]     != 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
/* < rows per Field&Scenario&Display DISPLAYED  --------------------------------------------------------------------------------------------------------*/
) C
ON      A.[Field_fk]
      = C.[Field_fk]
AND
        A.[Scenario_pk]
      = C.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
LEFT OUTER JOIN 
(
/* rows to be actually displaye by Field&Scenario&Ctry&Rel ---------------------------------------------------------------------------------------------*/
SELECT 
       [level]                = 'Total by Ctry&Rel'
      ,[Field_fk]
      ,[Scenario_id]
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Religion_Group_fk]
      ,[Pew_RelL02_Display]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      ,[rows]                 = COUNT(*) OVER(PARTITION BY [Field_fk]                   --NofTOT_by_Ctry&Rel
                                                         , [Scenario_id]
                                                         , [Nation_fk]
                                                         , [Religion_Group_fk] 
                                                         , [Display_AgeSex_Str]
                                                         , [Display_AgeStr_15Yrs]
                                                         , [Display_MedianAge]    )
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
     , [forum].[dbo].[Pew_Nation]
     , [forum].[dbo].[Pew_Religion_Group]
WHERE  [Sex_fk]                 = 0
AND    [Age_fk]                 = 0
AND(   [Display_AgeSex_Str]    != 0
    OR [Display_AgeStr_15Yrs]  != 0
    OR [Display_MedianAge]     != 0  )
AND    [Nation_fk]
     = [Nation_pk]
AND    [Religion_Group_fk]
     = [Religion_group_pk]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
UNION ALL
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
      DISTINCT
       [level]                = 'By Age&Sex cohorts'
      ,[Field_fk]
      ,[Scenario_id]
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Religion_Group_fk]
      ,[Pew_RelL02_Display]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      ,[rows]                 = COUNT(*) OVER(PARTITION BY [Field_fk]                   --NofTOT_by_Ctry&Rel
                                                         , [Scenario_id]
                                                         , [Nation_fk]
                                                         , [Religion_Group_fk] 
                                                         , [Display_AgeSex_Str]
                                                         , [Display_AgeStr_15Yrs]
                                                         , [Display_MedianAge]    )
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
     , [forum].[dbo].[Pew_Nation]
     , [forum].[dbo].[Pew_Religion_Group]
WHERE  [Sex_fk]                != 0
AND    [Age_fk]                != 0
AND(   [Display_AgeSex_Str]    != 0
    OR [Display_AgeStr_15Yrs]  != 0
    OR [Display_MedianAge]     != 0  )
AND    [Nation_fk]
     = [Nation_pk]
AND    [Religion_Group_fk]
     = [Religion_group_pk]
/* < rows to be actually displaye by Field&Scenario&Ctry&Rel -------------------------------------------------------------------------------------------*/
) D
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
ON      A.[Field_fk]
      = D.[Field_fk]
AND
        A.[Scenario_pk]
      = D.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
/********************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vg_02__Fertility_DisplayRules]    Script Date: 04/05/2016 09:34:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vg_02__Fertility_DisplayRules]
AS
/********************************************************************************************************************************************************/
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
          [fDR_row]                    = ROW_NUMBER()OVER(ORDER BY 
                                                        [IsDisplayed] DESC 
                                                    , A.[Field_year]
                                                    , A.[Scenario_pk]
                                                    , D.[Nation_fk]
                                                    , D.[Religion_Group_fk]
                                                    , D.[rows]               )
----------------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [Ctry_EditorialName]         = CASE
                                         WHEN D.[Ctry_EditorialName] IS NULL
                                         THEN '>> ALL COUNTRIES <<'
                                         ELSE D.[Ctry_EditorialName]
                                         END
      ,   [Religion]                   = CASE
                                         WHEN D.[Pew_RelL02_Display] IS NULL
                                         THEN '>> ALL RELIGIONS <<'
                                         ELSE D.[Pew_RelL02_Display]
                                         END
      ,   [Measurement]                = CASE
                                         WHEN D.[Measurement] IS NULL
                                         THEN 'Any Measurement'
                                         ELSE D.[Measurement]
                                         END
----------------------------------------------------------------------------------------------------------------------------------------------------------
      , D.[Display]
      , A.[Field_fk]
      , A.[Scenario_pk]
      , D.[Nation_fk]                  
      , D.[Religion_Group_fk]
      , A.[Field_year]
      , A.[Scenario_description]
      , A.[NofRows_by_Field&Scenario]
      , B.[NofRows_to_be_Hidden]
      ,   [NofRows_to_Display]         = ISNULL(C.[NofRows_to_Display], 0)
      , D.[rows]
  FROM
(
/* rows per Field&Scenario -----------------------------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_pk]
      ,[Field_year]
      ,[Scenario_description]
      , COUNT(*)     [NofRows_by_Field&Scenario]
  FROM [forum].[dbo].[Pew_Nation_Religion_Fertility_Value] X
     , [forum].[dbo].[Pew_Field]                           F
     , [forum].[dbo].[Pew_Scenario]                        S
WHERE 
       [Field_pk]
     = [Field_fk]
and
       X.[Scenario_id]
     = S.[Scenario_id]
GROUP
   BY
       [Field_fk]
      ,[Scenario_pk]
      ,[Field_year]
      ,[Scenario_description]
/* < rows per Field&Scenario ---------------------------------------------------------------------------------------------------------------------------*/
) A
LEFT OUTER JOIN 
(
/* rows per Field&Scenario&Display NOT DISPLAYED  ------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_id]
      ,[Display]
      , COUNT(*)     [NofRows_to_be_Hidden]
  FROM [forum].[dbo].[Pew_Nation_Religion_Fertility_Value]
WHERE  [Display]                = 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display]
/* < rows per Field&Scenario&Display NOT DISPLAYED  ----------------------------------------------------------------------------------------------------*/
) B
ON      A.[Field_fk]
      = B.[Field_fk]
AND
        A.[Scenario_pk]
      = B.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
LEFT OUTER JOIN 
(
/* rows per Field&Scenario&Display DISPLAYED  ----------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_id]
      ,[Display]
      , COUNT(*)     [NofRows_to_Display]
      ,[IsDisplayed] = 1
  FROM [forum].[dbo].[Pew_Nation_Religion_Fertility_Value]
WHERE  [Display]               != 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display]
/* < rows per Field&Scenario&Display DISPLAYED  --------------------------------------------------------------------------------------------------------*/
) C
ON      A.[Field_fk]
      = C.[Field_fk]
AND
        A.[Scenario_pk]
      = C.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
LEFT OUTER JOIN 
(
/* rows to be actually displayed by Field&Scenario&Ctry&Rel --------------------------------------------------------------------------------------------*/
SELECT 
      DISTINCT
       [Measurement]
      ,[Field_fk]
      ,[Scenario_id]
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Religion_Group_fk]
      ,[Pew_RelL02_Display]
      ,[Display]
      ,[rows]                 = COUNT(*) OVER(PARTITION BY [Field_fk]                   --NofTOT_by_Ctry&Rel
                                                         , [Scenario_id]
                                                         , [Nation_fk]
                                                         , [Religion_Group_fk] 
                                                         , [Display]              )
  FROM [forum].[dbo].[Pew_Nation_Religion_Fertility_Value]
     , [forum].[dbo].[Pew_Nation]
     , [forum].[dbo].[Pew_Religion_Group]
WHERE  [Display]               != 0
AND    [Nation_fk]
     = [Nation_pk]
AND    [Religion_Group_fk]
     = [Religion_group_pk]
/* < rows to be actually displayed by Field&Scenario&Ctry&Rel ------------------------------------------------------------------------------------------*/
) D
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
ON      A.[Field_fk]
      = D.[Field_fk]
AND
        A.[Scenario_pk]
      = D.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
/********************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vg_03__AgeSex&Fertility_DisplayRules]    Script Date: 04/05/2016 09:34:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vg_03__AgeSex&Fertility_DisplayRules]
AS
/********************************************************************************************************************************************************/
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
          [asfDR_row]                  = ROW_NUMBER()OVER(ORDER BY 
                                                        [IsDisplayed] DESC 
                                                    , A.[Field_year]
                                                    , A.[Scenario_pk]
                                                    , D.[Nation_fk]
                                                    , D.[Religion_Group_fk]
                                                    , D.[rows]               )
----------------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [Ctry_EditorialName]         = CASE
                                         WHEN D.[Ctry_EditorialName] IS NULL
                                         THEN '>> ALL COUNTRIES <<'
                                         ELSE D.[Ctry_EditorialName]
                                         END
      ,   [Religion]                   = CASE
                                         WHEN D.[Pew_RelL02_Display] IS NULL
                                         THEN '>> ALL RELIGIONS <<'
                                         ELSE D.[Pew_RelL02_Display]
                                         END
      ,   [level]                      = CASE
                                         WHEN D.[level] IS NULL
                                         THEN 'Both Total & by cohorts'
                                         ELSE D.[level]
                                         END
----------------------------------------------------------------------------------------------------------------------------------------------------------
      , D.[Display_AgeSex_Str]
      , D.[Display_AgeStr_15Yrs]
      , D.[Display_MedianAge]
      , A.[Field_fk]
      , A.[Scenario_pk]
      , D.[Nation_fk]                  
      , D.[Religion_Group_fk]
      , A.[Field_year]
      , A.[Scenario_description]
      , A.[NofRows_by_Field&Scenario]
      , B.[NofRows_to_be_Hidden]
      ,   [NofRows_to_Display]         = ISNULL(C.[NofRows_to_Display], 0)
      , D.[rows]
  FROM
(
/* rows per Field&Scenario -----------------------------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_pk]
      ,[Field_year]
      ,[Scenario_description]
      , COUNT(*)     [NofRows_by_Field&Scenario]
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]  X
     , [forum].[dbo].[Pew_Field]                          F
     , [forum].[dbo].[Pew_Scenario]                       S
WHERE 
       [Field_pk]
     = [Field_fk]
and
       X.[Scenario_id]
     = S.[Scenario_id]

GROUP
   BY
       [Field_fk]
      ,[Scenario_pk]
      ,[Field_year]
      ,[Scenario_description]
/* < rows per Field&Scenario ---------------------------------------------------------------------------------------------------------------------------*/
) A
LEFT OUTER JOIN 
(
/* rows per Field&Scenario&Display NOT DISPLAYED  ------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      , COUNT(*)     [NofRows_to_be_Hidden]
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
WHERE  [Display_AgeSex_Str]     = 0
AND    [Display_AgeStr_15Yrs]   = 0
AND    [Display_MedianAge]      = 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
/* < rows per Field&Scenario&Display NOT DISPLAYED  ----------------------------------------------------------------------------------------------------*/
) B
ON      A.[Field_fk]
      = B.[Field_fk]
AND
        A.[Scenario_pk]
      = B.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
LEFT OUTER JOIN 
(
/* rows per Field&Scenario&Display DISPLAYED  ----------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      , COUNT(*)     [NofRows_to_Display]
      ,[IsDisplayed] = 1
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
WHERE  [Display_AgeSex_Str]    != 0
   OR  [Display_AgeStr_15Yrs]  != 0
   OR  [Display_MedianAge]     != 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
/* < rows per Field&Scenario&Display DISPLAYED  --------------------------------------------------------------------------------------------------------*/
) C
ON      A.[Field_fk]
      = C.[Field_fk]
AND
        A.[Scenario_pk]
      = C.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
LEFT OUTER JOIN 
(
/* rows to be actually displaye by Field&Scenario&Ctry&Rel ---------------------------------------------------------------------------------------------*/
SELECT 
       [level]                = 'Total by Ctry&Rel'
      ,[Field_fk]
      ,[Scenario_id]
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Religion_Group_fk]
      ,[Pew_RelL02_Display]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      ,[rows]                 = COUNT(*) OVER(PARTITION BY [Field_fk]                   --NofTOT_by_Ctry&Rel
                                                         , [Scenario_id]
                                                         , [Nation_fk]
                                                         , [Religion_Group_fk] 
                                                         , [Display_AgeSex_Str]
                                                         , [Display_AgeStr_15Yrs]
                                                         , [Display_MedianAge]    )
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
     , [forum].[dbo].[Pew_Nation]
     , [forum].[dbo].[Pew_Religion_Group]
WHERE  [Sex_fk]                 = 0
AND    [Age_fk]                 = 0
AND(   [Display_AgeSex_Str]    != 0
    OR [Display_AgeStr_15Yrs]  != 0
    OR [Display_MedianAge]     != 0  )
AND    [Nation_fk]
     = [Nation_pk]
AND    [Religion_Group_fk]
     = [Religion_group_pk]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
UNION ALL
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
      DISTINCT
       [level]                = 'By Age&Sex cohorts'
      ,[Field_fk]
      ,[Scenario_id]
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Religion_Group_fk]
      ,[Pew_RelL02_Display]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      ,[rows]                 = COUNT(*) OVER(PARTITION BY [Field_fk]                   --NofTOT_by_Ctry&Rel
                                                         , [Scenario_id]
                                                         , [Nation_fk]
                                                         , [Religion_Group_fk] 
                                                         , [Display_AgeSex_Str]
                                                         , [Display_AgeStr_15Yrs]
                                                         , [Display_MedianAge]    )
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
     , [forum].[dbo].[Pew_Nation]
     , [forum].[dbo].[Pew_Religion_Group]
WHERE  [Sex_fk]                != 0
AND    [Age_fk]                != 0
AND(   [Display_AgeSex_Str]    != 0
    OR [Display_AgeStr_15Yrs]  != 0
    OR [Display_MedianAge]     != 0  )
AND    [Nation_fk]
     = [Nation_pk]
AND    [Religion_Group_fk]
     = [Religion_group_pk]
/* < rows to be actually displaye by Field&Scenario&Ctry&Rel -------------------------------------------------------------------------------------------*/
) D
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
ON      A.[Field_fk]
      = D.[Field_fk]
AND
        A.[Scenario_pk]
      = D.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
/********************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vi_Restrictions_Yr&Q&A_Displayable]    Script Date: 04/05/2016 09:35:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Restrictions_Yr&Q&A_Displayable]
AS
/***************************************************************************************************************************************************************/
SELECT  
        [RYQAv_row]
      , [Year]
      , [QA_std]
      , [QW_std]
      , [AV_std]
      , [AW_std]
      , [Display]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
               [dbo].[vi_Both_Svy&Rstr_Yr&Q&A_Displayable]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-------- filter questions to be displayed for Restrictions ------------------------------------------------------------------------------------------------------
WHERE
       [QA_std]     not like 'SVY%'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vi_Survey_Yr&Q&A_Displayable]    Script Date: 04/05/2016 09:35:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vi_Survey_Yr&Q&A_Displayable]
AS
/***************************************************************************************************************************************************************/
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
        [RYQAv_row]
      , [Year]
      , [QA_std]
      , [QW_std]
      , [AV_std]
      , [AW_std]
      , [Display]



FROM
               [dbo].[vi_Both_Svy&Rstr_Yr&Q&A_Displayable]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-------- filter questions to be displayed for Restrictions ------------------------------------------------------------------------------------------------------
WHERE
       [QA_std]         like 'SVY%'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vp_int_code-round-Percentage_by_Ctry&Religion]    Script Date: 04/05/2016 09:36:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vp_int_code-round-Percentage_by_Ctry&Religion]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [row_number]     = ROW_NUMBER()
                           OVER(ORDER BY
                                        [year]
                                      , [level]        DESC
                                      , [Nation_fk]          )
        , *

FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
 SELECT   
          [level]
        , [Nation_fk]
        , [Year]
        , [Region]
        , [Country]
      --, [Population]        = CAST ( ROUND([Population], 0) AS DECIMAL (12,0) )
        , [Percentage]  = CASE WHEN [Religion] = 'All Religions' THEN CAST(ROUND([Percentage], 1) AS DECIMAL ( 5,1) )
                               ELSE              ISNULL([code],       CAST(ROUND([Percentage], 1) AS DECIMAL ( 5,1) ) ) END
        , [Religion]
   FROM   [vi_AgeSexValue_15Yrs]                                                 V
LEFT JOIN ( SELECT *                       FROM [forum].[dbo].[vi_Thresholds]
                                           WHERE [Datatype] = 'Percentage'     ) C
       ON ([Percentage] < C.[Threshold] and C.[Point] = 'minimum' )
       OR ([Percentage] > C.[Threshold] and C.[Point] = 'maximum' )
WHERE 
-----------------------------------------------------------------------------------------------------------------
          [Religion_fk]  IS NOT NULL
-----------------------------------------------------------------------------------------------------------------
  AND     [Sex_fk]       = 0
  AND     [Age_fk]       = 0
-----------------------------------------------------------------------------------------------------------------
  AND     [Year]         IN ( 2010, 2020, 2030, 2040, 2050 )
-----------------------------------------------------------------------------------------------------------------
AND       [NV_Display]   = 1
AND       [RV_Display]   = 1
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
) AS SelectedData
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
PIVOT (MAX([Percentage]) 
       FOR [Religion]
       IN (   [All Religions]
            , [Buddhists]
            , [Christians]
            , [Folk Religions]
            , [Hindus]
            , [Jews]
            , [Muslims]
            , [Other Religions]
            , [Unaffiliated]         )) AS ByReligion
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vp_int_Percentage_by_Ctry&Religion]    Script Date: 04/05/2016 09:36:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vp_int_Percentage_by_Ctry&Religion]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [row_number]     = ROW_NUMBER()
                           OVER(ORDER BY
                                        [year]
                                      , [level]        DESC
                                      , [Nation_fk]          )
        , *

FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
 SELECT   
          [level]
        , [Nation_fk]
        , [Year]
        , [Region]
        , [Country]
        --, [Population]      = CAST ( ROUND([Population], 0) AS DECIMAL (12,0) )
        , [Percentage]      = CAST ( ROUND([Percentage], 1) AS DECIMAL ( 5,1) )
        , [Religion]
   FROM   [vi_AgeSexValue_15Yrs]
WHERE 
-----------------------------------------------------------------------------------------------------------------
          [Religion_fk]  IS NOT NULL
-----------------------------------------------------------------------------------------------------------------
  AND     [Sex_fk]       = 0
  AND     [Age_fk]       = 0
-----------------------------------------------------------------------------------------------------------------
  AND     [Year]         IN ( 2010, 2020, 2030, 2040, 2050 )
-----------------------------------------------------------------------------------------------------------------
AND       [NV_Display]   = 1
AND       [RV_Display]   = 1
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
) AS SelectedData
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
PIVOT (MAX([Percentage]) 
       FOR [Religion]
       IN (   [All Religions]
            , [Buddhists]
            , [Christians]
            , [Folk Religions]
            , [Hindus]
            , [Jews]
            , [Muslims]
            , [Other Religions]
            , [Unaffiliated]         )) AS ByReligion
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vp_int_Population_by_Ctry&Religion]    Script Date: 04/05/2016 09:37:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vp_int_Population_by_Ctry&Religion]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [row_number]     = ROW_NUMBER()
                           OVER(ORDER BY
                                        [year]
                                      , [level]        DESC
                                      , [Nation_fk]          )
        , *

FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
 SELECT   
          [level]
        , [Nation_fk]
        , [Year]
        , [Region]
        , [Country]
        , [Population]      = CAST ( ROUND([Population], 0) AS DECIMAL (12,0) )
        --, [Percentage]      = CAST ( ROUND([Percentage], 1) AS DECIMAL ( 5,1) )
        , [Religion]
   FROM   [vi_AgeSexValue_15Yrs]
WHERE 
-----------------------------------------------------------------------------------------------------------------
          [Religion_fk]  IS NOT NULL
-----------------------------------------------------------------------------------------------------------------
  AND     [Sex_fk]       = 0
  AND     [Age_fk]       = 0
-----------------------------------------------------------------------------------------------------------------
  AND     [Year]         IN ( 2010, 2020, 2030, 2040, 2050 )
-----------------------------------------------------------------------------------------------------------------
AND       [NV_Display]   = 1
AND       [RV_Display]   = 1
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
) AS SelectedData
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
pivot (MAX([Population]) 
       FOR [Religion]
       IN (   [All Religions]
            , [Buddhists]
            , [Christians]
            , [Folk Religions]
            , [Hindus]
            , [Jews]
            , [Muslims]
            , [Other Religions]
            , [Unaffiliated]         )) AS ByReligion
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vp_int_RawPercentage_by_Ctry&Religion]    Script Date: 04/05/2016 09:37:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vp_int_RawPercentage_by_Ctry&Religion]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [row_number]     = ROW_NUMBER()
                           OVER(ORDER BY
                                        [year]
                                      , [level]        DESC
                                      , [Nation_fk]          )
        , *

FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
 SELECT   
          [level]
        , [Nation_fk]
        , [Year]
        , [Region]
        , [Country]
        --, [Population]      = CAST ( ROUND([Population], 0) AS DECIMAL (12,0) )
        , [Percentage]      --= CAST ( ROUND([Percentage], 1) AS DECIMAL ( 5,1) )
        , [Religion]
   FROM   [vi_AgeSexValue_15Yrs]
WHERE 
-----------------------------------------------------------------------------------------------------------------
          [Religion_fk]  IS NOT NULL
-----------------------------------------------------------------------------------------------------------------
  AND     [Sex_fk]       = 0
  AND     [Age_fk]       = 0
-----------------------------------------------------------------------------------------------------------------
  AND     [Year]         IN ( 2010, 2020, 2030, 2040, 2050 )
-----------------------------------------------------------------------------------------------------------------
AND       [NV_Display]   = 1
AND       [RV_Display]   = 1
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
) AS SelectedData
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
PIVOT (MAX([Percentage]) 
       FOR [Religion]
       IN (   [All Religions]
            , [Buddhists]
            , [Christians]
            , [Folk Religions]
            , [Hindus]
            , [Jews]
            , [Muslims]
            , [Other Religions]
            , [Unaffiliated]         )) AS ByReligion
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vp_int_rounded_Percentage_by_Ctry&Religion]    Script Date: 04/05/2016 09:37:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vp_int_rounded_Percentage_by_Ctry&Religion]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [row_number]     = ROW_NUMBER()
                           OVER(ORDER BY
                                        [year]
                                      , [level]        DESC
                                      , [Nation_fk]          )
        , *

FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
 SELECT   
          [level]
        , [Nation_fk]
        , [Year]
        , [Region]
        , [Country]
      --, [Population]        = CAST ( ROUND([Population], 0) AS DECIMAL (12,0) )
        , [Percentage]  = CASE WHEN [Religion] = 'All Religions'   THEN STR([Percentage], 4,1)
                               ELSE              ISNULL([Display_text], STR([Percentage], 4,1) ) END
        , [Religion]
   FROM   [vi_AgeSexValue_15Yrs]                                                 V
LEFT JOIN ( SELECT *                       FROM [forum].[dbo].[vi_Thresholds]
                                           WHERE [Datatype] = 'Percentage'     ) C
       ON ([Percentage] < C.[Threshold] and C.[Point] = 'minimum' )
       OR ([Percentage] > C.[Threshold] and C.[Point] = 'maximum' )
WHERE 
-----------------------------------------------------------------------------------------------------------------
          [Religion_fk]  IS NOT NULL
-----------------------------------------------------------------------------------------------------------------
  AND     [Sex_fk]       = 0
  AND     [Age_fk]       = 0
-----------------------------------------------------------------------------------------------------------------
  AND     [Year]         IN ( 2010, 2020, 2030, 2040, 2050 )
-----------------------------------------------------------------------------------------------------------------
AND       [NV_Display]   = 1
AND       [RV_Display]   = 1
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
) AS SelectedData
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
PIVOT (MAX([Percentage]) 
       FOR [Religion]
       IN (   [All Religions]
            , [Buddhists]
            , [Christians]
            , [Folk Religions]
            , [Hindus]
            , [Jews]
            , [Muslims]
            , [Other Religions]
            , [Unaffiliated]         )) AS ByReligion
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vp_int_rounded_Population_by_Ctry&Religion]    Script Date: 04/05/2016 09:38:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vp_int_rounded_Population_by_Ctry&Religion]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [row_number]     = ROW_NUMBER()
                           OVER(ORDER BY
                                        [year]
                                      , [level]        DESC
                                      , [Nation_fk]          )
        , *

FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
 SELECT   
          [level]
        , [Nation_fk]
        , [Year]
        , [Region]
        , [Country]
    --  , [Population]  =                       ISNULL ([Display_text], (                                        [Population]                               ))
    --  , [Population]  =                       ISNULL ([Display_text], (                                 ROUND ([Population], -4)                          ))
    --  , [Population]  =                       ISNULL ([Display_text], (                           CAST (ROUND ([Population], -4) AS MONEY)                ))
    --  , [Population]  =                       ISNULL ([Display_text], (         CONVERT (varchar, CAST (ROUND ([Population], -4) AS MONEY), 1)            ))
    --  , [Population]  =                       ISNULL ([Display_text], (REPLACE (CONVERT (varchar, CAST (ROUND ([Population], -4) AS MONEY), 1), '.00', '')))
        , [Population]  = RIGHT ('          ' + ISNULL ([Display_text], (REPLACE (CONVERT (varchar, CAST (ROUND ([Population], -4) AS MONEY), 1), '.00', ''))),16)
        , [Religion]
-----------------------------------------------------------------------------------------------------------------
   FROM   [vi_AgeSexValue_15Yrs]                                                 V
LEFT JOIN ( SELECT *                       FROM [forum].[dbo].[vi_Thresholds]
                                           WHERE [Datatype] = 'Population'     ) C
       ON ([Population] < C.[Threshold] and C.[Point] = 'minimum' )
-----------------------------------------------------------------------------------------------------------------
WHERE 
-----------------------------------------------------------------------------------------------------------------
          [Religion_fk]  IS NOT NULL
-----------------------------------------------------------------------------------------------------------------
  AND     [Sex_fk]       = 0
  AND     [Age_fk]       = 0
-----------------------------------------------------------------------------------------------------------------
  AND     [Year]         IN ( 2010, 2020, 2030, 2040, 2050 )
-----------------------------------------------------------------------------------------------------------------
AND       [NV_Display]   = 1
AND       [RV_Display]   = 1
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
) AS SelectedData
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
pivot (MAX([Population]) 
       FOR [Religion]
       IN (   [Christians]
            , [Muslims]
            , [Unaffiliated]
            , [Hindus]
            , [Buddhists]
            , [Folk Religions]
            , [Other Religions]
            , [Jews]
            , [All Religions]        )) AS ByReligion
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vr_01_DB_Long_NoAggregated]    Script Date: 04/05/2016 09:38:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vr_01_DB_Long_NoAggregated]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
       *
FROM
(
/***  Basic Data: Long NPR ******************************************************************************************/
----------------------------------------------------------------------------------------------------------------------
/*** Set of data at country level ***********************************************************************************/
SELECT
           entity      = 'Ctry'
      ,    link_fk     = KN.[Nation_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = NULL
      ,    Religion_fk = NULL
      ,    Region5     = N.[Region]
      ,    Region6     = N.[SubRegion6]
      , N.[Ctry_EditorialName]
      ,    Locality    = 'not detailed'
      ,    Religion    = ''
      , Q.[Question_Year]
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
      , A.[Answer_value]
      , A.[answer_wording]
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]
/*********************************************************************************** Set of data at country level ***/
UNION
/*** Set of data at country/religious group level *******************************************************************/
SELECT
           entity      = 'RGrp'
      ,    link_fk     = KR.[Nation_religion_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = NULL
      ,    Religion_fk = G.[Religion_group_pk]
      ,    Region5     = N.[Region]
      ,    Region6     = N.[SubRegion6]
      , N.[Ctry_EditorialName]
      ,    Locality    = 'not detailed'
      ,    Religion    = G.[Pew_religion]
      , Q.[Question_Year]
      , Q.[Question_abbreviation_std]  AS  QA_std
      , Q.[Question_short_wording_std] AS  QW_std
      , A.[Answer_value]
      , A.[answer_wording]
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]                   A
      ,[forum].[dbo].[Pew_Question]                 Q
      ,[forum].[dbo].[Pew_Nation]                   N
      ,[forum].[dbo].[Pew_Religion_Group]           G
      ,[forum].[dbo].[Pew_Nation_Religion_Answer]   KR
WHERE  Q.[Question_pk]       =  A.[Question_fk]
  AND  A.[Answer_pk]         = KR.[Answer_fk]
  AND KR.[Religion_group_fk] =  G.[Religion_group_pk]
  AND  N.[Nation_pk]         = KR.[Nation_fk]
                           /* Pull only data on Restrictions */
  AND (   Q.[Question_abbreviation_std] like 'SHI_%'
       OR Q.[Question_abbreviation_std] like 'GRI_%'  )
/******************************************************************* Set of data at country/religious group level ***/
UNION
/*** Set of data at country/province level **************************************************************************/
SELECT
           entity             = 'Prov'
      ,    link_fk     = KL.[Locality_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = L.[Locality_pk]
      ,    Religion_fk = NULL
      ,    Region5     = N.[Region]
      ,    Region6     = N.[SubRegion6]
      , N.[Ctry_EditorialName]
      ,    Locality    = L.Locality
      ,    Religion    = ''
      , Q.[Question_Year]
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
      , A.[Answer_value]
      , A.[answer_wording]
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Locality]          L
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Locality_Answer]   KL
WHERE Q.[Question_pk] = A.[Question_fk]
  AND A.[Answer_pk]   = KL.[Answer_fk]
  AND L.[Locality_pk] = KL.[Locality_fk]
  AND N.[Nation_pk]   =
                           /* In order to keep consistent to previuos years 
                              Data by Province currently belonging to South Sudan
                              should considered data for Sudan before 2010: */
                     CASE 
                            WHEN L.[Nation_fk]     = 237 
                             AND Q.[Question_Year] < 2010 
                            THEN                           197
                            ELSE                           L.[Nation_fk]
                     END 
                           /* In order to avoid changing the final set,
                              Data previously used for Northern Cyprus
                              should be excluded: ????                                 */
                           /* Although we have REAL data by province for North Korea,
                              we will not use them in this analysis: ????              */
/************************************************************************** Set of data at country/province level ***/
----------------------------------------------------------------------------------------------------------------------
/******************************************************************************************  Basic Data: Long NPR ***/
) AS NPR
/***************************************************************************************************************************************************************/
WHERE SUBSTRING(QA_std, 1, 2) IN ( 'GR', 'SH', 'XS')
/* filters */
AND
Ctry_EditorialName                                   != 'North Korea'                   /* Excluded from the analysis */
AND
Ctry_EditorialName + '_/_' + STR(Question_Year, 4,0) != 'South Sudan_/_2010'            /* although data are not aggregated for the other part of former Sudan */
/* filters */

/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vr_02_W_by_Ctry&Year]    Script Date: 04/05/2016 09:39:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vr_02_W_by_Ctry&Year]
AS
/***************************************************************************************************************************************************************/

/***************************************************************************************************************************************************************/
SELECT
       *
FROM
/***************************************************************************************************************************************************************/

(
/***************************************************************************************************************************************************************/
SELECT 
       [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[QA_std]
      ,[Answer_value]      = SUM([Answer_value])
  FROM
/***  Basic Data: Long NPR *************************************************************************************************************************************/
            [vr_01_DB_Long_NoAggregated]
/************************************************************************************************************************************  Basic Data: Long NPR  ***/
GROUP BY
       [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[QA_std]
/***************************************************************************************************************************************************************/
)                                                                                                                                                      AS   lnpr

/***************************************************************************************************************************************************************/
PIVOT
(
  MAX([Answer_value])
  FOR [QA_std]
                   in (
/***************************************************************************************************************************************************************/
 GRI_01, GRI_01_x, GRI_01_x2, GRI_02, GRI_03, GRI_04, GRI_05, GRI_06, GRI_07, GRI_08, GRI_09, GRI_10, GRI_10_01, GRI_10_02, GRI_10_03, GRI_11, GRI_11_01a, GRI_11_01b, GRI_11_02, GRI_11_03, GRI_11_04, GRI_11_05, GRI_11_06, GRI_11_07, GRI_11_08, GRI_11_09, GRI_11_10, GRI_11_11, GRI_11_12, GRI_11_13, GRI_11_14, GRI_11_15, GRI_11_16, GRI_11_17, GRI_12, GRI_13, GRI_14, GRI_15, GRI_16, GRI_16_01, GRI_17, GRI_18, GRI_19, GRI_19_b, GRI_19_c, GRI_19_d, GRI_19_da, GRI_19_db, GRI_19_e, GRI_19_f, GRI_20_01, GRI_20_01x_01a, GRI_20_01x_01b, GRI_20_01x_02, GRI_20_01x_03, GRI_20_01x_04, GRI_20_01x_05, GRI_20_01x_06, GRI_20_01x_07, GRI_20_01x_08, GRI_20_01x_09, GRI_20_01x_10, GRI_20_02, GRI_20_03_a, GRI_20_03_b, GRI_20_03_c, GRI_20_04, GRI_20_04_x, GRI_20_05, GRI_20_05_x, GRI_20_05_x1, GRX_21_01, GRX_21_02, GRX_21_03, GRX_22, GRX_22_01, GRX_22_02, GRX_22_03, GRX_22_04, GRX_23, GRX_24, GRX_25_01, GRX_25_02, GRX_25_03, GRX_26_01, GRX_26_02, GRX_26_03, GRX_26_04, GRX_26_05, GRX_26_06, GRX_26_07, GRX_26_08, GRX_27_01, GRX_27_02, GRX_27_03, GRX_28_01, GRX_28_02, GRX_28_03, GRX_29_01, GRX_29_02, GRX_29_03, GRX_29_04, GRX_29_05, SHI_01_a, SHI_01_b, SHI_01_c, SHI_01_d, SHI_01_da, SHI_01_db, SHI_01_e, SHI_01_f, SHI_01_x_01a, SHI_01_x_01b, SHI_01_x_02, SHI_01_x_03, SHI_01_x_04, SHI_01_x_05, SHI_01_x_06, SHI_01_x_07, SHI_01_x_08, SHI_01_x_09, SHI_01_x_10, SHI_01_x_11, SHI_01_x_12, SHI_01_x_13, SHI_01_x_14, SHI_01_x_15, SHI_01_x_16, SHI_01_x_17, SHI_02, SHI_02_01, SHI_03, SHI_04, SHI_04_b, SHI_04_c, SHI_04_d, SHI_04_da, SHI_04_db, SHI_04_e, SHI_04_f, SHI_04_x01, SHI_05, SHI_05_b, SHI_05_c, SHI_05_d, SHI_05_da, SHI_05_db, SHI_05_e, SHI_05_f, SHI_06, SHI_07, SHI_08, SHI_09, SHI_10, SHI_11, SHI_11_x, SHI_12, SHI_13, SHX_14_01, SHX_14_02, SHX_14_03, SHX_14_04, SHX_15_01, SHX_15_02, SHX_15_03, SHX_15_04, SHX_15_05, SHX_15_06, SHX_15_07, SHX_15_08, SHX_15_09, SHX_15_10, SHX_25, SHX_26, SHX_27_01, SHX_27_02, SHX_27_03, SHX_28_01, SHX_28_02, SHX_28_03, SHX_28_04, SHX_28_05, SHX_28_06, SHX_28_07, SHX_28_08, XSG_24, XSG_S_01, XSG_S_02, XSG_S_03, XSG_S_04, XSG_S_05, XSG_S_06, XSG_S_07, XSG_S_08, XSG_S_09, XSG_S_10, XSG_S_11, XSG_S_12, XSG_S_13, XSG_S_14, XSG_S_15, XSG_S_16, XSG_S_17, XSG_S_18, XSG_S_19, XSG_S_20, XSG_S_21, XSG_S_22, XSG_S_23, XSG_S_99_01, XSG_S_99_02, XSG_S_99_03, XSG_S_99_04, XSG_S_99_05, XSG_S_99_06
/***************************************************************************************************************************************************************/
)                                                                               /*** end of listing of variables                                             ***/
 )                                                                                                                                                      AS   pivt
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vr_03_W&Extras_by_Ctry&Year]    Script Date: 04/05/2016 09:40:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vr_03_W&Extras_by_Ctry&Year]
AS
/***************************************************************************************************************************************************************/
--*** May need to:
--    Clean XSG_25n27  as rowmax(GRX_25_01_2010 SHX_27_01_2010)
/*** main select statement *************************************************************************************************************************************/
/*** table including numeric values + Step-3 calculated variables **********************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_scaled index */
         GRI_scaled 
         =        CAST ((
                  CASE
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'low'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 1.00
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'moderate'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 2.00
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 3.00
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'very high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 4.00
                  END
                                                               ) AS DECIMAL (38,2))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI_scaled index */
      ,  SHI_scaled 
         =        CAST ((
                  CASE
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'low'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 1.00
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'moderate'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 2.00
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 3.00
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'very high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 4.00
                  END
                                                               ) AS DECIMAL (38,2))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI_scaled index */
      ,  GFI_scaled 
         =        CAST ((
                  CASE
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'low'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 1.00
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'moderate'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 2.00
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 3.00
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'very high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 4.00
                  END
                                                               ) AS DECIMAL (38,2))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_rounded index */
      ,  GRI_rd_1d 
         =        CAST ((
                                  GRI 
                                                               ) AS DECIMAL (38,1))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI_rounded index */
      ,  SHI_rd_1d 
         =        CAST ((
                                  SHI 
                                                               ) AS DECIMAL (38,1))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI_rounded index */
      ,  GFI_rd_1d 
         =        CAST ((
                                  GFI
                                                               ) AS DECIMAL (38,1))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------------------------------------------------------------------------------------------------------
       ,
 *
FROM
/***************************************************************************************************************************************************************/
(
/*** table including numeric values + Step-2 calculated variables **********************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI index */
         GRI 
         =
--/*********************************************************************************************/    
--                  CASE
--/*  Fit previously published data  ----------------------------------------------------------*/    
--    ---------------------------------------------------------------------------------------
--	                                        WHEN Nation_fk	               = 69
--	                                         AND Question_Year             = 2011
--	                                        THEN 1.8
--    -----------------------------------------------------------------------------------------
--                                            WHEN Nation_fk	               = 146
--                                             AND Question_Year             = 2011
--                                            THEN 1.950
--    -----------------------------------------------------------------------------------------
--                                            WHEN Nation_fk	               = 131
--                                             AND Question_Year             = 2011
--                                            THEN 1.350
--    -----------------------------------------------------------------------------------------
--                                            WHEN Nation_fk	               = 186
--                                             AND Question_Year             = 2011
--                                            THEN 1.750
--    -----------------------------------------------------------------------------------------
--/*  Fit previously published median  --------------------------------------------------------*/    
--    ---------------------------------------------------------------------------------------
--                                            WHEN Nation_fk	               = 116
--                                             AND Question_Year             = 2010
--                                            THEN 5.844
--    ---------------------------------------------------------------------------------------
--                  ELSE
--/*********************************************************************************************/    
                  ROUND(
                  CAST ((((
                                [GRI_01]
                         +      [GRI_02]
                         +      [GRI_03]
                         +      [GRI_04]
                         +      [GRI_05]
                         +      [GRI_06]
                         +      [GRI_07]
                         +      [GRI_08_for_index]
                         +      [GRI_09]
                         +      [GRI_10]
                         +      [GRI_11]
                         +      [GRI_12]
                         +      [GRI_13]
                         +      [GRI_14]
                         +      [GRI_15]
                         +      [GRI_16]
                         +      [GRI_17]
                         +      [GRI_18]
                         +      [GRI_19]
                         +      [GRI_20]
                                                       ) / 2    )
                                                                  ) AS float) ,64)
--                                                                ) AS DECIMAL (38,4)) ,4)
--                  END
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI index */
       , SHI 
         =        ROUND(
                  CAST ((((
                                [SHI_01]
                         +      [SHI_02]
                         +      [SHI_03]
                         +      [SHI_04]
                         +      [SHI_05]
                         +      [SHI_06]
                         +      [SHI_07]
                         +      [SHI_08]
                         +      [SHI_09]
                         +      [SHI_10]
                         +      [SHI_11_for_index]
                         +      [SHI_12]
                         +      [SHI_13]
                                                       ) / 1.3  )
                                                                  ) AS float) ,64)
--                                                                ) AS DECIMAL (38,4)) ,4)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI index */
       , GFI 
         =        ROUND(
                  CAST ((((
                                [GRI_20_01]
                         +      [GRI_20_02]
                         + ( (  [GRI_20_03_a]
                              + [GRI_20_03_b]
                              + [GRI_20_03_c]
                                               ) / 3 )
                         +      [GRI_20_04]
                         +      [GRI_20_05]
                                                       ) / 5 ) 
                                                              * 10
                                                                  ) AS float) ,64)
--                                                                ) AS DECIMAL (38,4)) ,4)
--         =        GRI_20 * 10
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Christianity */
       , XSG_01_xG1 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG1 + SHI_01_xG1 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Islam */
       , XSG_01_xG2 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG2 + SHI_01_xG2 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Buddhism */
       , XSG_01_xG3 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG3 + SHI_01_xG3 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Hinduism */
       , XSG_01_xG4 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG4 + SHI_01_xG4 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Judaism */
       , XSG_01_xG5 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG5 + SHI_01_xG5 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Other ('New' Religions, Ancient Religions, Sikhs, Zoroastrianism) */
       , XSG_01_xG6 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG6 + SHI_01_xG6 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Ethnic or Tribal Religions */
       , XSG_01_xG7 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG7 + SHI_01_xG7 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_01_summary_a_ny           for toplines */
       ,           SHI_01_summary_a_ny0
       = CAST ((
         CASE 
              WHEN SHI_01     =  0.00
              THEN               0.00
              WHEN SHI_01     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny1
       = CAST ((
         CASE 
              WHEN SHI_01_a   >  0.00
              THEN               1.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny2
       = CAST ((
         CASE 
              WHEN SHI_01_b   >  0.00
              THEN               1.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny3
       = CAST ((
         CASE 
              WHEN SHI_01_c   >  0.00
              THEN               1.03
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny4
       = CAST ((
         CASE 
              WHEN SHI_01_d   >  0.00
              THEN               1.04
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny5
       = CAST ((
         CASE 
              WHEN SHI_01_e   >  0.00
              THEN               1.05
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_ny6
       = CAST ((
         CASE 
              WHEN SHI_01_f   >  0.00
              THEN               1.06
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 XSG_242526_ny           for toplines */
       ,           XSG_242526_ny0
       = CAST ((
         CASE WHEN GRX_24     = 0.00
               AND SHX_25     = 0.00
               AND SHX_26     = 0.00
              THEN              0.00
              WHEN GRX_24     = 1.00
                OR SHX_25     = 1.00
                OR SHX_26     = 1.00
              THEN              1.00
              WHEN GRX_24     = 0.67
                OR SHX_25     = 0.67
                OR SHX_26     = 0.67
              THEN              0.67
              WHEN GRX_24     = 0.33
                OR SHX_25     = 0.33
                OR SHX_26     = 0.33
              THEN              0.33
              END
                                                               ) AS DECIMAL (38,2))
       ,           XSG_242526_ny1
       = CAST ((
         CASE WHEN GRX_24     > 0.00
                OR SHX_25     > 0.00
                OR SHX_26     > 0.00
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 XSG_25n27_ny           for toplines */
       ,           XSG_25n27_ny1
       = CAST ((
         CASE WHEN GRX_25_ny1 = 0.00
               AND SHX_27_ny1 = 0.00
              THEN              0.00
              WHEN GRX_25_ny1 = 0.01
                OR SHX_27_ny1 = 0.01
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
       ,           XSG_25n27_ny2
       = CAST ((
         CASE WHEN GRX_25_ny2 = 0.02
                OR SHX_27_ny2 = 0.02
              THEN              0.02
              END
                                                               ) AS DECIMAL (38,2))
       ,           XSG_25n27_ny3
       = CAST ((
         CASE WHEN GRX_25_ny3 = 0.03
                OR SHX_27_ny3 = 0.03
              THEN              0.03
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

       , *
FROM
/***************************************************************************************************************************************************************/
(
/*** table including numeric values + Step-1 calculated variables **********************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
         GRI_20
         =        ROUND(
                  CAST ((((
                                [GRI_20_01]
                         +      [GRI_20_02]
                         + ( (  [GRI_20_03_a]
                              + [GRI_20_03_b]
                              + [GRI_20_03_c]
                                               ) / 3 )
                         +      [GRI_20_04]
                         +      [GRI_20_05]
                                                       ) / 5  )
                                                               ) AS DECIMAL (38,2)) ,2)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , GRI_20_top
         =        CAST ((
                  CASE
                  WHEN GRI_20_03_a = 1
                    OR GRI_20_03_b = 1
                    OR GRI_20_03_c = 1
                    OR GRI_20_02   > 0.5
                  THEN               1.00
                  WHEN GRI_20_01   > 0
                    OR GRI_20_02   > 0
                    OR GRI_20_03_a > 0
                    OR GRI_20_03_b > 0
                    OR GRI_20_03_c > 0
                    OR GRI_20_04   > 0
                    OR GRI_20_05   > 0
                  THEN               0.50
                  ELSE               0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , GRI_20_03_top
         =        CAST ((
                  CASE
                  WHEN GRI_20_03_a >= GRI_20_03_b
                   AND GRI_20_03_a >= GRI_20_03_c
                  THEN GRI_20_03_a
                  WHEN GRI_20_03_b >= GRI_20_03_a
                   AND GRI_20_03_b >= GRI_20_03_c
                  THEN GRI_20_03_b
                  WHEN GRI_20_03_c >= GRI_20_03_b
                   AND GRI_20_03_c >= GRI_20_03_c
                  THEN GRI_20_03_c
                  ELSE NULL
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , 
--       select
       SHI_01
         =        CAST ((
                  (
                  CAST ((
                    ( CASE
                      WHEN SHI_01_a > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_b > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_c > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_d > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_e > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_f > 0 THEN 1
                      ELSE                   0
                       END                     )
                                                       
                                                               ) AS DECIMAL (38,2))
                                                                                    / 6 )
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , SHI_01_summary_b
         =        CAST ((
                    ( CASE
                      WHEN SHI_01_a > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_b > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_c > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_d > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_e > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_f > 0 THEN 1
                      ELSE                   0
                       END                     )
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_01_[a,b,c,d,e,f]_dummy for tables of question answers by country */
       ,           SHI_01_a_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_a   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_b_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_b   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_c_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_c   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_d_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_d   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_e_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_e   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_f_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_f   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Christianity */
       , GRI_11_xG1
         =        CAST ((
                  CASE
                  WHEN   GRI_11_01a
                       + GRI_11_01b
                       + GRI_11_02
                       + GRI_11_03
                       + GRI_11_11
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Islam */
       , GRI_11_xG2 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_04
                       + GRI_11_05
                       + GRI_11_06
                       + GRI_11_12
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Buddhism */
       , GRI_11_xG3 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_07
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Hinduism */
       , GRI_11_xG4 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_08
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Judaism */
       , GRI_11_xG5 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_09
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Other ('New' Religions, Ancient Religions, Sikhs, Zoroastrianism) */
       , GRI_11_xG6 
         =        CAST ((
                  CASE
                  WHEN   isnull(GRI_11_10, 0)
                       + isnull(GRI_11_14, 0)
                       + isnull(GRI_11_15, 0)
                       + isnull(GRI_11_16, 0)
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Ethnic or Tribal Religions */
       , GRI_11_xG7
         =        CAST ((
                  CASE
                  WHEN   GRI_11_13
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Christianity */
       , SHI_01_xG1
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_01a
                       + SHI_01_x_01b
                       + SHI_01_x_02
                       + SHI_01_x_03
                       + SHI_01_x_11
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Islam */
       , SHI_01_xG2 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_04
                       + SHI_01_x_05
                       + SHI_01_x_06
                       + SHI_01_x_12
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Buddhism */
       , SHI_01_xG3 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_07
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Hinduism */
       , SHI_01_xG4 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_08
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Judaism */
       , SHI_01_xG5 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_09
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Other ('New' Religions, Ancient Religions, Sikhs, Zoroastrianism) */
       , SHI_01_xG6 
         =        CAST ((
                  CASE
                  WHEN   isnull(SHI_01_x_10, 0)
                       + isnull(SHI_01_x_14, 0)
                       + isnull(SHI_01_x_15, 0)
                       + isnull(SHI_01_x_16, 0)
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Ethnic or Tribal Religions */
       , SHI_01_xG7
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_13
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* recode GRI_08 to be used as index-factor */
       , GRI_08_for_index
         =        CAST ((
                  CASE
                  WHEN GRI_08  = 0.5
                  THEN           1
                  ELSE GRI_08
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* recode SHI_Q_11 to be used as index-factor */
       , SHI_11_for_index
         =        CAST ((
                  CASE
                  WHEN SHI_11  = 0.5
                  THEN           1
                  ELSE SHI_11
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_16               for toplines */
       ,           GRI_16_ny1
       =           GRI_16
       ,           GRI_16_ny2
       = CAST ((
         CASE WHEN GRI_16  > 0
                  THEN           0.01
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19               for toplines */
       ,           GRI_19_ny1
       =           GRI_19
       ,           GRI_19_ny2
       = CAST ((
         CASE WHEN GRI_19  > 0
              THEN           0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19_summ_ny          for toplines */
       ,           GRI_19_summ_ny1
       = CAST ((
         CASE 
              WHEN GRI_19     =  0.00
              THEN               0.00
              WHEN GRI_19     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny2
       = CAST ((
         CASE 
              WHEN GRI_19_b   >  0.00
              THEN               1.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny3
       = CAST ((
         CASE 
              WHEN GRI_19_c   >  0.00
              THEN               1.03
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny4
       = CAST ((
         CASE 
              WHEN GRI_19_d   >  0.00
              THEN               1.04
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny5
       = CAST ((
         CASE 
              WHEN GRI_19_e   >  0.00
              THEN               1.05
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_ny6
       = CAST ((
         CASE 
              WHEN GRI_19_f   >  0.00
              THEN               1.06
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19_x              for toplines */
       ,           GRI_19_x
       =           ISNULL(GRI_19_b, 0)
                 + ISNULL(GRI_19_c, 0)
                 + ISNULL(GRI_19_d, 0)
                 + ISNULL(GRI_19_e, 0)
                 + ISNULL(GRI_19_f, 0)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_04_ny          for toplines */
       ,           SHI_04_ny0
       =           SHI_04

       ,           SHI_04_ny1
       = CAST ((
         CASE 
              WHEN SHI_04     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_05_ny          for toplines */
       ,           SHI_05_ny0
       =           SHI_05
       ,           SHI_05_ny1
       = CAST ((
         CASE 
              WHEN SHI_05     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_07_ny          for toplines */
       ,           SHI_07_ny0
       =           SHI_07
       ,           SHI_07_ny1
       = CAST ((
         CASE 
              WHEN SHI_07     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--/*                 SHI_01_x              for toplines shoul;d be added???*/
--       ,           SHI_01_x
--       =           ISNULL(SHI_01_b, 0)
--                 + ISNULL(SHI_01_c, 0)
--                 + ISNULL(SHI_01_d, 0)
--                 + ISNULL(SHI_01_e, 0)
--                 + ISNULL(SHI_01_f, 0)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22               for toplines */
       ,           GRX_22_ny1
       = CAST ((
         CASE WHEN GRX_22     < 0.66
               AND GRX_22_01  < 0.66
               AND GRX_22_02  < 0.66
               AND GRX_22_04  < 0.66
              THEN              0
              WHEN GRX_22     < 1.00
               AND GRX_22_01  < 1.00
               AND GRX_22_02  < 1.00
               AND GRX_22_04  < 1.00
              THEN              0.67
              WHEN GRX_22     = 1.00
                OR GRX_22_01  = 1.00
                OR GRX_22_02  = 1.00
                OR GRX_22_04  = 1.00
              THEN              1.00
              ELSE GRX_22_01
              END
                                                               ) AS DECIMAL (38,2))
--       ,           GRX_22_ny2
--       = CAST ((
--         CASE WHEN GRX_22    >= 0.66
--                OR GRX_22_01 >= 0.66
--                OR GRX_22_02 >= 0.66
--                OR GRX_22_04 >= 0.66
--              THEN              0.01
--              END
--                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_01               for toplines */
       ,           GRX_22_01_ny1
       = CAST ((
         CASE WHEN GRX_22_01  < 0.66
              THEN              0
              ELSE GRX_22_01
              END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_01_ny2
       = CAST ((
         CASE WHEN GRX_22_01 >= 0.66
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_02               for toplines */
       ,           GRX_22_02_ny1
       = CAST ((
         CASE WHEN GRX_22_02  < 0.66
              THEN              0
              ELSE GRX_22_02
              END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_02_ny2
       = CAST ((
         CASE WHEN GRX_22_02 >= 0.66
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_03               for toplines */
       ,           GRX_22_03_ny1
       = CAST ((
         CASE WHEN GRX_22_03  < 0.66
              THEN              0
              ELSE GRX_22_03
              END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_03_ny2
       = CAST ((
         CASE WHEN GRX_22_03 >= 0.66
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_04               for toplines */
       ,           GRX_22_04_ny1
       = CAST ((
         CASE WHEN GRX_22_04  < 0.66
              THEN              0
              ELSE GRX_22_04
              END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_04_ny2
       = CAST ((
         CASE WHEN GRX_22_04 >= 0.66
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_24               for toplines */
       ,           GRX_24_ny1
       =           GRX_24
       ,           GRX_24_ny2
       = CAST ((
         CASE WHEN GRX_24  > 0
                  THEN           0.01
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_25               for toplines */
       ,           GRX_25_ny1
       = CAST ((
         CASE 
              WHEN GRX_25_01  =  0.00
              THEN               0.00
              WHEN GRX_25_01  =  1.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_25_ny2
       = CAST ((
         CASE 
              WHEN GRX_25_02  =  1.00
              THEN               0.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_25_ny3
       = CAST ((
         CASE 
              WHEN GRX_25_03  =  1.00
              THEN               0.03
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHX_25               for toplines */
       ,           SHX_25_ny1
       =           SHX_25
       ,           SHX_25_ny2
       = CAST ((
         CASE WHEN SHX_25  > 0
                  THEN           0.01
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHX_26               for toplines */
       ,           SHX_26_ny1
       =           SHX_26
       ,           SHX_26_ny2
       = CAST ((
         CASE WHEN SHX_26  > 0
                  THEN           0.01
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHX_27               for toplines */
       ,           SHX_27_ny1
       = CAST ((
         CASE 
              WHEN SHX_27_01  =  0.00
              THEN               0.00
              WHEN SHX_27_01  =  1.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHX_27_ny2
       = CAST ((
         CASE 
              WHEN SHX_27_02  =  1.00
              THEN               0.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHX_27_ny3
       = CAST ((
         CASE 
              WHEN SHX_27_03  =  1.00
              THEN               0.03
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , *
FROM
/*** View including numeric values aggregated by country/religion & year ***************************************************************************************/
               [dbo].[vr_02_W_by_Ctry&Year]
/*************************************************************************************** View including numeric values aggregated by country/religion & year ***/
/********************************************************************************************** table including numeric values + Step-1 calculated variables ***/
)                                                                                                                                                       AS NV_S1
/***************************************************************************************************************************************************************/
)                                                                                                                                                       AS NV_S2
/********************************************************************************************** table including numeric values + Step-2 calculated variables ***/
/* filters */
WHERE
Ctry_EditorialName                                   != 'North Korea'
AND
Ctry_EditorialName + '_/_' + STR(Question_Year, 4,0) != 'South Sudan_/_2010'            /* although data are not aggregated for the other part of former Sudan */
/* filters */
/********************************************************************************************** table including numeric values + Step-3 calculated variables ***/
/************************************************************************************************************************************* main select statement ***/
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[vr_LongCodedData_in_DB]    Script Date: 04/05/2016 09:40:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/********************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[vr_LongCodedData_in_DB]
AS
/********************************************************************************************************************************************************/
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
       [v_Basic_row] = ROW_NUMBER()OVER(ORDER BY Nation_fk, Question_Year, QA_std)
      ,[entity]
      ,[note]
      ,[link_fk]
      ,[Nation_fk]
      ,[Locality_fk]
      ,[Religion_fk]
      ,[Ctry_EditorialName]
      ,[Locality]
      ,[Religion]
      ,[Question_Year]
      ,[QA_std]
      ,[QW_std]
      ,[Answer_value]
      ,[answer_wording]
      ,[answer_wording_std]
      ,[Question_fk]
      ,[Answer_fk]
      ,[Notes]
      ,[Region5]
      ,[Region6]
      ,[editable]               = CASE
                                       WHEN [note] LIKE '%this field can be edited' THEN 1
                                       WHEN [note] LIKE '%eld should NOT be edited' THEN 0
                                  END                                       
FROM
/********************************************************************************************************************************************************/
(
/***  ALL SETS OF DATA  *********************************************************************************************************************************/
/********************************************************************************************************************************************************/
/***  Basic Data: NPR  **********************************************************************************************************************************/
---   Long set of data including numeric values and descriptive wordings.
---   At levels: country, country/religious group, & country/province
---   Notes
---        - In order to keep consistent to previuos years, data by Province currently belonging to South Sudan
---          should considered data for Sudan before 2010
---        - In order to avoid changing the final set,data previously used for Northern Cyprus
---          should be excluded (current decision)
---        - Although we have REAL data by province for North Korea, we do not use them
----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
        [entity]             = CASE
                                    WHEN [entity]         = 'Ctry' THEN 'Stored by Country'
                                    WHEN [entity]         = 'RGrp' THEN 'Stordred by Religion Group (& Ctry)'
                                    WHEN [Question_Year]  < 2012
                                     AND [entity]         = 'Prov' THEN 'Stored by Locality (should be aggregated)'
                                    WHEN [Question_Year] >= 2012
                                     AND [entity]         = 'Prov' THEN 'Stored by Country (using Locality code)'
                               END
      , [note]               = 'updated on ' + CONVERT(VARCHAR(11),GETDATE(),9) + ' --  this field can be edited'
      , [link_fk]
      , [Nation_fk]
      , [Locality_fk]
      , [Religion_fk]
      , [Ctry_EditorialName]
      , [Locality]
      , [Religion]           = CASE
                                    WHEN [Religion]       = '' THEN 'not detailed'
                                    WHEN [Religion]      != '' THEN [Religion]
                               END
      , [Question_Year]
      , [QA_std]             = CASE
                                    WHEN [Question_Year]  < 2012
                                     AND [entity]         = 'Prov' THEN [QA_std] + '__p'
                                    ELSE                                [QA_std]
                               END
      , [QW_std]
      , [Answer_value]
      , [answer_wording]
      , [answer_wording_std]
      , [Question_fk]
      , [Answer_fk]
      , [Notes]
      , [Region5]
      , [Region6]
----------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
----------------------------------------------------------------------------------------------------------------------------------------------------------
       [forum_ResAnal].[dbo].[vr_01_DB_Long_NoAggregated]
/**********************************************************************************************************************************  Basic Data: NPR  ***/
----------------------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL
----------------------------------------------------------------------------------------------------------------------------------------------------------
/*** Set of province data aggregated at country level (before 2012) *************************************************************************************/
---   Notes
---        - In order to keep consistent to previuos years, data by Province currently belonging to South Sudan
---          should considered data for Sudan before 2010
---        - In order to avoid changing the final set,data previously used for Northern Cyprus
---          should be excluded (current decision)
---        - Although we have REAL data by province for North Korea, we do not use them
----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
           entity             = 'Aggregated by Country'
      ,    note               = 'updated on ' + CONVERT(VARCHAR(11),GETDATE(),9) + ' --  this field should NOT be edited'
      ,    link_fk            = NULL
      ,    Nation_fk          = CASE
                                     WHEN PCDbC.Nation_fk IS NOT NULL 
                                     THEN PCDbC.Nation_fk 
                                     ELSE PTDbC.Nation_fk
                                END
      ,    Locality_fk        = NULL
      ,    Religion_fk        = NULL
      ,    Ctry_EditorialName = CASE
                                     WHEN PCDbC.Ctry_EditorialName IS NOT NULL 
                                     THEN PCDbC.Ctry_EditorialName
                                     ELSE PTDbC.Ctry_EditorialName
                                END
      ,    Locality           = 'aggregated by country'
      ,    Religion           = 'not detailed'
      ,    Question_Year      = CASE
                                     WHEN PCDbC.Question_Year IS NOT NULL 
                                     THEN PCDbC.Question_Year
                                     ELSE PTDbC.Question_Year
                                END
      ,    QA_std             = CASE
                                     WHEN PCDbC.QA_std IS NOT NULL 
                                     THEN PCDbC.QA_std
                                     ELSE PTDbC.QA_std
                                END
      ,    QW_std             = CASE
                                     WHEN PCDbC.QW_std IS NOT NULL 
                                     THEN PCDbC.QW_std
                                     ELSE PTDbC.QW_std
                                END
      ,    Answer_value       = CASE
                                     WHEN PCDbC.Answer_value IS NOT NULL 
                                     THEN PCDbC.Answer_value
                                     ELSE 0
                                END
      ,    Answer_wording     = CASE
                                     WHEN PTDbC.Answer_wording IS NOT NULL 
                                     THEN PTDbC.Answer_wording
                                     ELSE 'Not Available'
                                END
      ,    Answer_wording_std = 'events'
      ,    Question_fk        = NULL
      ,    Answer_fk          = NULL
      ,    Notes              = 'not detailed'
      ,    Region5            = ''
      ,    Region6            = ''
--select *
FROM
(
/*** Values to be joined ***/-----------------------------------------------------------------------------------------------------------------------------
/*** Set of province count data aggregated by country ***/------------------------------------------------------------------------------------------------
SELECT
           Nation_fk          = N.[Nation_pk]
      , N.[Ctry_EditorialName]
      , Q.[Question_Year]
      ,   QA_std              = Q.[Question_abbreviation_std]
      ,   QW_std              = Q.[Question_short_wording_std]
      ,    Answer_value       = SUM(A.[Answer_value])
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Locality]          L
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Locality_Answer]   KL
WHERE Q.[Question_pk] = A.[Question_fk]
  AND A.[Answer_pk]   = KL.[Answer_fk]
  AND L.[Locality_pk] = KL.[Locality_fk]
  AND N.[Nation_pk]   =
                           /* In order to keep consistent to previuos years 
                              Data by Province currently belonging to South Sudan
                              should considered data for Sudan before 2010: */
                     CASE 
                            WHEN L.[Nation_fk]     = 237 
                             AND Q.[Question_Year] < 2010 
                            THEN                           197
                           /* In order to avoid changing the final set,
                              Data previously used for Northern Cyprus
                              should be excluded:                       */
                            ELSE                           L.[Nation_fk]
                     END 
                           /* Although we have REAL data by province for North Korea,
                              we will not use them in this analysis                   */
  AND N.Ctry_EditorialName  <>  'North Korea'
GROUP BY
          N.[Nation_pk]
        , N.[Ctry_EditorialName]
        , Q.[Question_Year]
        , Q.[Question_abbreviation_std]
        , Q.[Question_short_wording_std]
------------------------------------------------------------------------------------------------/*** Set of province count data aggregated by country ***/ 
-----------------------------------------------------------------------------------------------------------------------------/*** Values to be joined ***/ 
) AS PCDbC
FULL JOIN
(
/*** Wordings to be joined ***/---------------------------------------------------------------------------------------------------------------------------
/*** Set of province text data aggregated by country ***/-------------------------------------------------------------------------------------------------
SELECT
           Nation_fk
      ,    Ctry_EditorialName
      ,    Question_Year
      ,    QA_std
      ,    QW_std
      ,    Answer_wording
--into [GRSHR].[dbo].[MyTest]
FROM
(
---- Aggregate (concatenate) province text by country ----------------------------------------------------------------------------------------------------
    SELECT 
           Question_Year      =      QU.[Question_Year]
         , QA_std             =      QU.[QA_std]
         , QW_std             =      QU.[QW_std]
         , Nation_fk          =      QU.[Nation_fk]
         , Ctry_EditorialName =      QU.[Ctry_EditorialName]
    , STUFF
    (
        (
            SELECT 
                    '|' + X.Answer_wording
            FROM
               (
---- ALL answer wording by province (to be aggregated) ---------------------------------------------------------------------------------------------------
                SELECT
                DISTINCT 
                            Q.Question_Year
                     ,      Q.Question_abbreviation_std AS QA_std
                     ,        Nation_fk =
                                         CASE 
                                              WHEN L.Nation_fk     = 237 
                                               AND Q.Question_Year < 2010 
                                              THEN                           197
                                              ELSE                           L.Nation_fk
                                         END 
                     ,      A.Answer_wording
                FROM
                     [forum].[dbo].[Pew_Locality]          L
                    ,[forum].[dbo].[Pew_Answer]            A
                    ,[forum].[dbo].[Pew_Locality_Answer]   KL
                    ,[forum].[dbo].[Pew_Question]          Q
                WHERE
                      L.[Locality_pk]  = KL.[Locality_fk]
                  AND A.[Answer_pk]    = KL.[Answer_fk]
                  AND Q.[Question_pk]  = A.[Question_fk]
                  AND A.Answer_wording IS NOT NULL
                  AND A.Answer_wording != 'NULL'
                  AND A.Answer_wording != ''
                  AND L.Nation_fk      != 154     -- exclude North Korea
                  --order by Std_VarName, Question_Year, Nation_fk
--------------------------------------------------------------------------------------------------- ALL answer wording by province (to be aggregated) ----
               ) AS X
            WHERE
                 QU.QA_std        = X.QA_std
             AND QU.Question_Year = X.Question_Year
             AND QU.Nation_fk     = X.Nation_fk
            FOR XML PATH('')
        )
    ,1,1,'') AS Answer_wording
               
FROM 
(
---- Data listing combinations of Nation/Variable/Year ---------------------------------------------------------------------------------------------------
SELECT   
         Nation_fk
       , Ctry_EditorialName
       , QA_std
       , QW_std
       , Question_Year
FROM 
  (
---- Data listing countries included in the restrictions data --------------------------------------------------------------------------------------------
     SELECT  Nation_pk AS Nation_fk
           , Ctry_EditorialName
       FROM
            [forum].[dbo].[Pew_Nation]
     WHERE
         Nation_pk NOT IN (
                           4 ,
                           7 ,
                           11 ,
                           23 ,
                           29 ,
                           38 ,
                           41 ,
                           48 ,
                           66 ,
                           67 ,
                           71 ,
                           72 ,
                           78 ,
                           80 ,
                           82 ,
                           83 ,
                           89 ,
                           99 ,
                           129 ,
                           132 ,
                           139 ,
                           147 ,
                           148 ,
                           153 ,
                           154 ,
                           155 ,
                           169 ,
                           171 ,
                           175 ,
                           178 ,
                           209 ,
                           215 ,
                           222 ,
                           228
                       )
-------------------------------------------------------------------------------------------- Data listing countries included in the restrictions data ----
       ) AS D1
----------------------------------------------------------------------------------------------------------------------------------------------------------
                       CROSS JOIN 
----------------------------------------------------------------------------------------------------------------------------------------------------------
      (
---- Data listing combinations of countries and years ----------------------------------------------------------------------------------------------------
        SELECT DISTINCT 
                           Q.Question_abbreviation_std  AS QA_std
                     ,     Q.Question_Year
                     ,     Q.Question_short_wording_std AS QW_std
        from
                       [forum].[dbo].[Pew_Question]          Q
where
Question_abbreviation_std
                                  IN
                                   (
                                      'GRI_19_b'
                                    , 'GRI_19_c'
                                    , 'GRI_19_d'
                                    , 'GRI_19_e'
                                    , 'GRI_19_f'
                                    , 'GRI_20_05_x1'   -- no wording stored here
                                    , 'SHI_01_b'
                                    , 'SHI_01_c'
                                    , 'SHI_01_d'
                                    , 'SHI_01_e'
                                    , 'SHI_01_f'
                                    , 'SHI_04_b'
                                    , 'SHI_04_c'
                                    , 'SHI_04_d'
                                    , 'SHI_04_e'
                                    , 'SHI_04_f'
                                    , 'SHI_05_c'
                                    , 'SHI_05_d'
                                    , 'SHI_05_e'
                                    , 'SHI_05_f' 


                                   )
---------------------------------------------------------------------------------------------------- Data listing combinations of countries and years ----
       ) AS D2
--------------------------------------------------------------------------------------------------- Data listing combinations of Nation/Variable/Year ----
  ) AS     QU
---------------------------------------------------------------------------------------------------- Aggregate (concatenate) province text by country ----
)as DA
--where DA.Answer_wording IS NOT NULL
---------------------------------------------------------------------------------------------------------------------------/*** Wordings to be joined ***/
-------------------------------------------------------------------------------------------------/*** Set of province text data aggregated by country ***/
) AS PTDbC
ON
       PCDbC.Nation_fk
     = PTDbC.Nation_fk
 AND
       PCDbC.Ctry_EditorialName
     = PTDbC.Ctry_EditorialName
 AND
       PCDbC.Question_Year
     = PTDbC.Question_Year
 AND
       PCDbC.QA_std
     = PTDbC.QA_std
 AND
       PCDbC.QW_std
     = PTDbC.QW_std
---- filter: only before 2012 ----------------------------------------------------------------------------------------------------------------------------
WHERE 
       PCDbC.Question_Year < 2012
 AND
       PTDbC.Question_Year < 2012
---------------------------------------------------------------------------------------------------------------------------- filter: only before 2012 ----
----------------------------------------------------------------------------------------------------------------------------------------------------------
/************************************************************************************* Set of province data aggregated at country level (before 2012) ***/
----------------------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL
----------------------------------------------------------------------------------------------------------------------------------------------------------
/*** Set of country level data calculated from data stored/aggregated by country ************************************************************************/
---   The data are based on the NPR basic data ([forum_ResAnal].[dbo].[vr_01_DB_Long_NoAggregated])
---   All notes for NPR apply
----------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
          [entity]             = 'Calculated/Aggragated by Country'
      ,   [note]               = 'updated on ' + CONVERT(VARCHAR(11),GETDATE(),9) + ' --  this field should NOT be edited'
      ,   [link_fk]            = NULL
      , L.[Nation_fk]
      ,   [Locality_fk]        = NULL
      ,   [Religion_fk]        = NULL
      , L.[Ctry_EditorialName]
      ,   [Locality]           = 'not detailed'
      ,   [Religion]           = CASE
                                     WHEN L.[Variable]     = 'XSG_01_xG1' THEN 'Christianity'
                                     WHEN L.[Variable]     = 'XSG_01_xG2' THEN 'Islam'
                                     WHEN L.[Variable]     = 'XSG_01_xG3' THEN 'Buddhism'
                                     WHEN L.[Variable]     = 'XSG_01_xG4' THEN 'Hinduism'
                                     WHEN L.[Variable]     = 'XSG_01_xG5' THEN 'Judaism'
                                     WHEN L.[Variable]     = 'XSG_01_xG6' THEN 'Other (New/Ancient Religions, Sikhs, Zoroastrianism)'
                                     WHEN L.[Variable]     = 'XSG_01_xG7' THEN 'Ethnic or Tribal Religions'
                                     WHEN L.[Variable]     = 'GRI_11_xG1' THEN 'Christianity'
                                     WHEN L.[Variable]     = 'GRI_11_xG2' THEN 'Islam'
                                     WHEN L.[Variable]     = 'GRI_11_xG3' THEN 'Buddhism'
                                     WHEN L.[Variable]     = 'GRI_11_xG4' THEN 'Hinduism'
                                     WHEN L.[Variable]     = 'GRI_11_xG5' THEN 'Judaism'
                                     WHEN L.[Variable]     = 'GRI_11_xG6' THEN 'Other (New/Ancient Religions, Sikhs, Zoroastrianism)'
                                     WHEN L.[Variable]     = 'GRI_11_xG7' THEN 'Ethnic or Tribal Religions'
                                     WHEN L.[Variable]     = 'SHI_01_xG1' THEN 'Christianity'
                                     WHEN L.[Variable]     = 'SHI_01_xG2' THEN 'Islam'
                                     WHEN L.[Variable]     = 'SHI_01_xG3' THEN 'Buddhism'
                                     WHEN L.[Variable]     = 'SHI_01_xG4' THEN 'Hinduism'
                                     WHEN L.[Variable]     = 'SHI_01_xG5' THEN 'Judaism'
                                     WHEN L.[Variable]     = 'SHI_01_xG6' THEN 'Other (New/Ancient Religions, Sikhs, Zoroastrianism)'
                                     WHEN L.[Variable]     = 'SHI_01_xG7' THEN 'Ethnic or Tribal Religions'
                                     ELSE                                      'not detailed'
                                 END
      , L.[Question_Year]
      ,   [QA_std]             = L.[Variable]
      ,   [QW_std]             = Q.[Wording_minus3]
      ,   [Answer_value]       = L.[Value]
      ,   [answer_wording]     = ''
      ,   [answer_wording_std] = A.[Answer_wording_std]
      ,   [Question_fk]        = NULL
      ,   [Answer_fk]          = NULL
      ,   [Notes]              = ''
      , L.[Region5]
      , L.[Region6]
----------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
----------------------------------------------------------------------------------------------------------------------------------------------------------
       [forum_ResAnal].[dbo].[V4_L_by_CYV]    L
     , [forum_ResAnal].[dbo].[CodedQuestions] Q
     , [forum_ResAnal].[dbo].[CodedAnswers]   A
WHERE
       Q.[Variable]
     = L.[Variable]
AND
       A.[Variable]
     = L.[Variable]
AND
       A.[Value]
     = CASE
            WHEN       L.[Value]    >= 2000
             and (
                       L.[Variable]  = 'PPR_01'
                   OR  L.[Variable]  = 'PPR_02'
                 )                              THEN 2000
            WHEN       L.[Value]    >=     2    THEN    1
            ELSE                                     L.[Value]
        END
AND
       L.[Variable]
       NOT IN 
              ( SELECT 
                       DISTINCT
                       [QA_std]
                FROM   [forum_ResAnal].[dbo].[vr_01_DB_Long_NoAggregated]  ) 
/************************************************************************ Set of country level data calculated from data stored/aggregated by country ***/
----------------------------------------------------------------------------------------------------------------------------------------------------------
UNION ALL
----------------------------------------------------------------------------------------------------------------------------------------------------------
/*** Set of indexes by country aswell as world and region median indexes ********************************************************************************/
SELECT


       [entity]                  = CASE
                                        WHEN level = 3 THEN 'Aggregated at the World level'
                                        WHEN level = 2 THEN 'Aggregated by Region'
                                        WHEN level = 1 THEN 'Aggregated by Country'
                                   END
      ,[note]                    = 'updated on ' + CONVERT(VARCHAR(11),GETDATE(),9) + ' --  this field should NOT be edited'
      ,[link_fk]                 = [RIYv_row]
      ,[Nation_fk]
      ,[Locality_fk]             = NULL
      ,[Religion_fk]             = NULL
      ,[Ctry_EditorialName]
      ,[Locality]                = 'not detailed'
      ,[Religion]                = 'not detailed'
      ,[Question_Year]           = [Year]
      ,[QA_std]                  = CASE
                                        WHEN level > 1 THEN [Index_abbreviation] + ' (median)'
                                        WHEN level = 1 THEN [Index_abbreviation]
                                   END
      ,[QW_std]                  = CASE
                                        WHEN level > 1 THEN 'Median ' + [Index_name]
                                        WHEN level = 1 THEN             [Index_name]
                                   END
      ,[Answer_value]            = [Index_value]
      ,[answer_wording]          = ''
      ,[answer_wording_std]      = [Index_level]
      ,[Question_fk]             = NULL
      ,[Answer_fk]               = NULL
      ,[Notes]                   = ''
      ,[Region5]                 = CASE
                                        WHEN [level] < 3
                                         AND [Region]     IN (  'North America'
                                                              , 'Latin America-Caribbean ' ) THEN 'Americas'
                                        WHEN [level] < 3
                                         AND [Region] NOT IN (  'North America'
                                                              , 'Latin America-Caribbean ' ) THEN [Region]
                                        ELSE                                                      ''
                                   END
      ,[Region6]                 = CASE
                                        WHEN [level] < 3 THEN [Region]
                                        ELSE                  ''
                                   END
FROM
forum.[dbo].[vi_Restrictions_Index_by_CtryRegion&Yr]
/******************************************************************************** Set of indexes by country aswell as world and region median indexes ***/
/********************************************************************************************************************************************************/
/*********************************************************************************************************************************  ALL SETS OF DATA  ***/
)                                                                                                                                                     ASD
/********************************************************************************************************************************************************/

/********************************************************************************************************************************************************/
/*** temporary exclusion on PGRI ************************************************************************************************************************/
----WHERE
----       QA_std NOT LIKE 'CSR%'
----  AND  QA_std NOT LIKE 'ERI%'
----  AND  QA_std NOT LIKE 'IEI%'
----  AND  QA_std NOT LIKE 'PPR%'
----  AND  QA_std NOT LIKE 'RIR%'
/************************************************************************************************************************ temporary exclusion of PGRI ***/
/********************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[Vx_a_LongData]    Script Date: 04/05/2016 09:41:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[Vx_a_LongData]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [Vx_a_Row]
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [Nation_fk]
                            ,[Locality_fk]
                            ,[Q_Number]
                            ,[QA_std]
                            ,[Question_Year]
                            ,[Answer_value]
                            ,[AW_det]         )
      ,[entity]
      ,[link_fk]
      ,[Nation_fk]
      ,[Locality_fk]
      ,[Religion_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]
      ,[Religion]
      ,[Question_Year]
      ,[QA_std]
      ,[QW_std]
      ,[Answer_value]
      ,[AW_std]
      ,[AW_det]
      ,[Question_fk]
      ,[Answer_fk]
      ,[Notes]
FROM
/***************************************************************************************************************************************************************/
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
       distinct
       [Q_Number]        =   CASE WHEN [Q_Number] IS NULL THEN 9999
                                  ELSE [Q_Number]
                                  END
      ,[entity]
      ,[link_fk]
      ,[Nation_fk]
      ,[Locality_fk]
      ,[Religion_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]
      ,[Religion]
      ,[Question_Year]
      ,[QA_std]
      ,[QW_std]
      ,[Answer_value]
      ,[AW_std]
                              --= CASE
                              --       WHEN [AW_std] IS NULL THEN [answer_wording]
                              --       ELSE [AW_std]
                              --   END
      ,[AW_det]
      ,[Question_fk]
      ,[Answer_fk]
      ,[Notes]
/***************************************************************************************************************************************************************/
FROM
/** >> ** sorting order of questions ***************************************************************************************************************************/
       [AllQuestions]
/** << ** sorting order of questions ***************************************************************************************************************************/
RIGHT OUTER JOIN
(
/** >> ** current rows of coded & calculated data **************************************************************************************************************/
SELECT 
       [entity]
      ,[link_fk]
      ,[Nation_fk]
      ,[Locality_fk]
      ,[Religion_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]
      ,[Religion]
      ,[Question_Year]
      ,[QA_std]
      ,[QW_std]
      ,[Answer_value]
      ,[answer_wording_std]        AS [AW_std]
      ,[answer_wording]            AS [AW_det]
      ,[Question_fk]
      ,[Answer_fk]
      ,[Notes]
  FROM [V1_DB_Long]
/* filters */
WHERE
Ctry_EditorialName                                   != 'North Korea'
AND
Ctry_EditorialName + '_/_' + STR(Question_Year, 4,0) != 'South Sudan_/_2010'            /* although data are not aggregated for the other part of former Sudan */
/* filters */
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
       [entity]                    = 'Ctry'
      ,[link_fk]                   = 0
      ,[Nation_fk]
      ,[Locality_fk]               = NULL
      ,[Religion_fk]               = NULL
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]                  = 'not detailed'
      ,[Religion]                  = ''
      ,[Question_Year]
      ,[QA_std]                    = V4.[Variable]
      ,[QW_std]                    = [Wording_minus3]
      ,[Answer_value]              = V4.[Value]
      ,[AW_std]                    = [Answer_wording]
      ,[AW_det]                    = NULL
      ,[Question_fk]               = NULL
      ,[Answer_fk]                 = NULL
      ,[Notes]                     = NULL
  FROM
       [V4_L_by_CYV]   V4
LEFT OUTER JOIN
       [AllQuestions]  AQ
ON
       V4.[Variable]
    =  AQ.[Variable]
LEFT OUTER JOIN
       [AllAnswers]    AA
ON
       V4.[Variable]
    =  AA.[Variable]
AND
       V4.[Value]
    =  AA.[Value]
WHERE 
       V4.[Variable]
       NOT IN
              (
                SELECT  
                       DISTINCT
                       [QA_std]
                  FROM 
                       [V1_DB_Long]
                  WHERE 
                       [QA_std] NOT IN (
                                            'GRI_19_b'
                                          , 'GRI_19_c'
                                          , 'GRI_19_d'
                                          , 'GRI_19_da'
                                          , 'GRI_19_db'
                                          , 'GRI_19_e'
                                          , 'GRI_19_f'
                                          , 'GRI_20_05_x1'
                                          , 'SHI_01_b'
                                          , 'SHI_01_c'
                                          , 'SHI_01_d'
                                          , 'SHI_01_da'
                                          , 'SHI_01_db'
                                          , 'SHI_01_e'
                                          , 'SHI_01_f'
                                          , 'SHI_04_b'
                                          , 'SHI_04_c'
                                          , 'SHI_04_d'
                                          , 'SHI_04_da'
                                          , 'SHI_04_db'
                                          , 'SHI_04_e'
                                          , 'SHI_04_f'
                                          , 'SHI_05_b'
                                          , 'SHI_05_c'
                                          , 'SHI_05_d'
                                          , 'SHI_05_da'
                                          , 'SHI_05_db'
                                          , 'SHI_05_e'
                                          , 'SHI_05_f'

                                                                  ) 
                                                                    )
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
       [entity]                    = 'Ctry'
      ,[link_fk]                   = 0
      ,[Nation_fk]
      ,[Locality_fk]               = NULL
      ,[Religion_fk]               = NULL
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]                  = 'not detailed'
      ,[Religion]                  = ''
      ,[Question_Year]
      ,[QA_std]                    = 'GRI'
      ,[QW_std]                    = 'Government Restrictions Index (GRI)'
      ,[Answer_value]              = [GRI]
      ,[AW_std]                    = 'scale 0 - [+.] - 10'
      ,[AW_det]                    = NULL
      ,[Question_fk]               = NULL
      ,[Answer_fk]                 = NULL
      ,[Notes]                     = NULL
  FROM
       [V3_W&Extras_by_Ctry&Year]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
       [entity]                    = 'Ctry'
      ,[link_fk]                   = 0
      ,[Nation_fk]
      ,[Locality_fk]               = NULL
      ,[Religion_fk]               = NULL
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]                  = 'not detailed'
      ,[Religion]                  = ''
      ,[Question_Year]
      ,[QA_std]                    = 'SHI'
      ,[QW_std]                    = 'Social Hostilities Index (SHI)'
      ,[Answer_value]              = [SHI]
      ,[AW_std]                    = 'scale 0 - [+.] - 10'
      ,[AW_det]                    = NULL
      ,[Question_fk]               = NULL
      ,[Answer_fk]                 = NULL
      ,[Notes]                     = NULL
  FROM
       [V3_W&Extras_by_Ctry&Year]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
       [entity]                    = 'Ctry'
      ,[link_fk]                   = 0
      ,[Nation_fk]
      ,[Locality_fk]               = NULL
      ,[Religion_fk]               = NULL
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]                  = 'not detailed'
      ,[Religion]                  = ''
      ,[Question_Year]
      ,[QA_std]                    = 'GFI'
      ,[QW_std]                    = 'Government Favoritism Index (GFI)'
      ,[Answer_value]              = [GFI]
      ,[AW_std]                    = 'scale 0 - [+.] - 10'
      ,[AW_det]                    = NULL
      ,[Question_fk]               = NULL
      ,[Answer_fk]                 = NULL
      ,[Notes]                     = NULL
  FROM
       [V3_W&Extras_by_Ctry&Year]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
       [entity]                    = 'Ctry'
      ,[link_fk]                   = 0
      ,[Nation_fk]
      ,[Locality_fk]               = NULL
      ,[Religion_fk]               = NULL
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]                  = 'not detailed'
      ,[Religion]                  = ''
      ,[Question_Year]
      ,[QA_std]                    = 'GRI_rd_1d'
      ,[QW_std]                    = 'Government Restrictions Index (GRI-rounded)'
      ,[Answer_value]              = [GRI_rd_1d]
      ,[AW_std]                    = 'scale 0 - [+.1] - 10'
      ,[AW_det]                    = NULL
      ,[Question_fk]               = NULL
      ,[Answer_fk]                 = NULL
      ,[Notes]                     = NULL
  FROM
       [V3_W&Extras_by_Ctry&Year]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
       [entity]                    = 'Ctry'
      ,[link_fk]                   = 0
      ,[Nation_fk]
      ,[Locality_fk]               = NULL
      ,[Religion_fk]               = NULL
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]                  = 'not detailed'
      ,[Religion]                  = ''
      ,[Question_Year]
      ,[QA_std]                    = 'SHI_rd_1d'
      ,[QW_std]                    = 'Social Hostilities Index (SHI-rounded)'
      ,[Answer_value]              = [SHI_rd_1d]
      ,[AW_std]                    = 'scale 0 - [+.1] - 10'
      ,[AW_det]                    = NULL
      ,[Question_fk]               = NULL
      ,[Answer_fk]                 = NULL
      ,[Notes]                     = NULL
  FROM
       [V3_W&Extras_by_Ctry&Year]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
       [entity]                    = 'Ctry'
      ,[link_fk]                   = 0
      ,[Nation_fk]
      ,[Locality_fk]               = NULL
      ,[Religion_fk]               = NULL
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]                  = 'not detailed'
      ,[Religion]                  = ''
      ,[Question_Year]
      ,[QA_std]                    = 'GFI_rd_1d'
      ,[QW_std]                    = 'Government Favoritism Index (GFI-rounded)'
      ,[Answer_value]              = [GFI_rd_1d]
      ,[AW_std]                    = 'scale 0 - [+.1] - 10'
      ,[AW_det]                    = NULL
      ,[Question_fk]               = NULL
      ,[Answer_fk]                 = NULL
      ,[Notes]                     = NULL
  FROM
       [V3_W&Extras_by_Ctry&Year]
/** << ** current rows of coded & calculated data **************************************************************************************************************/
)                                                                                                                                                         AS CRC
/***************************************************************************************************************************************************************/
ON     
       [Variable]
     = [QA_std]
/***************************************************************************************************************************************************************/
)                                                                                                                                                         AS AbO
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[Vx_b_TopLines]    Script Date: 04/05/2016 09:41:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[Vx_b_TopLines]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------SELECT 
          V6Row
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [Q_Number]
                           , [Variable]
                           , [Value]
                                          )
      ,  [Variable]
      ,  [Value]
      ,  [Answer_wording]
      ,  [NC_MID-2007]
      ,  [PC_MID-2007]
      ,  [NC_MID-2008]
      ,  [PC_MID-2008]
      ,  [NC_MID-2009]
      ,  [PC_MID-2009]
      ,  [NC_MID-2010]
      ,  [PC_MID-2010]
      ,  [NC_END-2011]
      ,  [PC_END-2011]
      ,  [NC_END-2012]
      ,  [PC_END-2012]
      ,  [V5Row]   
FROM
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
SELECT 
       Q.[Q_Number]
      ,V.[Variable]
      ,V.[Value]
      ,V.[Answer_wording]
      ,  [NC_MID-2007]
      ,  [PC_MID-2007]
      ,  [NC_MID-2008]
      ,  [PC_MID-2008]
      ,  [NC_MID-2009]
      ,  [PC_MID-2009]
      ,  [NC_MID-2010]
      ,  [PC_MID-2010]
      ,  [NC_END-2011]
      ,  [PC_END-2011]
      ,  [NC_END-2012]
      ,  [PC_END-2012]
      ,  [V5Row]   
  FROM
       [AllAnswers]            V
LEFT
OUTER
JOIN
       [V7_LRestr_by_CV]       D
ON
       V.[Variable]
     = D.[Variable]
AND
       V.[Value]
     = D.[Value]
JOIN
       [AllQuestions]          Q
ON
       V.[Variable]
     = Q.[Variable]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -6.00
      ,  [Answer_wording] = [Label_minus4]
      ,  [NC_MID-2007]    = ''
      ,  [PC_MID-2007]    = ''
      ,  [NC_MID-2008]    = ''
      ,  [PC_MID-2008]    = ''
      ,  [NC_MID-2009]    = ''
      ,  [PC_MID-2009]    = ''
      ,  [NC_MID-2010]    = ''
      ,  [PC_MID-2010]    = ''
      ,  [NC_END-2011]    = ''
      ,  [PC_END-2011]    = ''
      ,  [NC_END-2012]    = ''
      ,  [PC_END-2012]    = ''
      ,  V5Row            = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -5.00
      ,  [Answer_wording] = [Wording_minus3]
      ,  [NC_MID-2007]    = ''
      ,  [PC_MID-2007]    = ''
      ,  [NC_MID-2008]    = ''
      ,  [PC_MID-2008]    = ''
      ,  [NC_MID-2009]    = ''
      ,  [PC_MID-2009]    = ''
      ,  [NC_MID-2010]    = ''
      ,  [PC_MID-2010]    = ''
      ,  [NC_END-2011]    = ''
      ,  [PC_END-2011]    = ''
      ,  [NC_END-2012]    = ''
      ,  [PC_END-2012]    = ''
      ,  V5Row            = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -4.00
      ,  [Answer_wording] = ''
      ,  [NC_MID-2007]    = 'baseline year,'
      ,  [PC_MID-2007]    = 'ending'
      ,  [NC_MID-2008]    = 'year'
      ,  [PC_MID-2008]    = 'ending'
      ,  [NC_MID-2009]    = 'year'
      ,  [PC_MID-2009]    = 'ending'
      ,  [NC_MID-2010]    = 'year'
      ,  [PC_MID-2010]    = 'ending'
      ,  [NC_END-2011]    = 'previous year'
      ,  [PC_END-2011]    = 'ending'
      ,  [NC_END-2012]    = 'latest year,'
      ,  [PC_END-2012]    = 'ending'
      ,  V5Row            = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -3.00
      ,  [Answer_wording] = ''
      ,  [NC_MID-2007]    = 'JUN '
      ,  [PC_MID-2007]    = '2007'
      ,  [NC_MID-2008]    = 'JUN '
      ,  [PC_MID-2008]    = '2008'
      ,  [NC_MID-2009]    = 'JUN '
      ,  [PC_MID-2009]    = '2009'
      ,  [NC_MID-2010]    = 'JUN '
      ,  [PC_MID-2010]    = '2010'
      ,  [NC_END-2011]    = 'DEC '
      ,  [PC_END-2011]    = '2011'
      ,  [NC_END-2012]    = 'DEC '
      ,  [PC_END-2012]    = '2012'
      ,  V5Row            = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -2.00
      ,  [Answer_wording] = ''
      ,  [NC_MID-2007]    = 'NUMBER OF'
      ,  [PC_MID-2007]    = '  %  OF  '
      ,  [NC_MID-2008]    = 'NUMBER OF'
      ,  [PC_MID-2008]    = '  %  OF  '
      ,  [NC_MID-2009]    = 'NUMBER OF'
      ,  [PC_MID-2009]    = '  %  OF  '
      ,  [NC_MID-2010]    = 'NUMBER OF'
      ,  [PC_MID-2010]    = '  %  OF  '
      ,  [NC_MID-2011]    = 'NUMBER OF'
      ,  [PC_MID-2011]    = '  %  OF  '
      ,  [NC_MID-2012]    = 'NUMBER OF'
      ,  [PC_MID-2012]    = '  %  OF  '
      ,  V5Row            = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -1.00
      ,  [Answer_wording] = ''
      ,  [NC_MID-2007]    = 'COUNTRIES'
      ,  [PC_MID-2007]    = 'COUNTRIES'
      ,  [NC_MID-2008]    = 'COUNTRIES'
      ,  [PC_MID-2008]    = 'COUNTRIES'
      ,  [NC_MID-2009]    = 'COUNTRIES'
      ,  [PC_MID-2009]    = 'COUNTRIES'
      ,  [NC_MID-2010]    = 'COUNTRIES'
      ,  [PC_MID-2010]    = 'COUNTRIES'
      ,  [NC_MID-2011]    = 'COUNTRIES'
      ,  [PC_MID-2011]    = 'COUNTRIES'
      ,  [NC_MID-2012]    = 'COUNTRIES'
      ,  [PC_MID-2012]    = 'COUNTRIES'
      ,  V5Row            = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = 200.00
      ,  [Answer_wording] = ''
      ,  [NC_MID-2007]    = '197'
      ,  [PC_MID-2007]    = '100%'
      ,  [NC_MID-2008]    = '197'
      ,  [PC_MID-2008]    = '100%'
      ,  [NC_MID-2009]    = '197'
      ,  [PC_MID-2009]    = '100%'
      ,  [NC_MID-2010]    = '197'
      ,  [PC_MID-2010]    = '100%'
      ,  [NC_END-2011]    = '198'
      ,  [PC_END-2011]    = '100%'
      ,  [NC_END-2012]    = '198'
      ,  [PC_END-2012]    = '100%'
      ,  V5Row            = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = 201.00
      ,  [Answer_wording] = [Notes1_plus201]
      ,  [NC_MID-2007]    = ''
      ,  [PC_MID-2007]    = ''
      ,  [NC_MID-2008]    = ''
      ,  [PC_MID-2008]    = ''
      ,  [NC_MID-2009]    = ''
      ,  [PC_MID-2009]    = ''
      ,  [NC_MID-2010]    = ''
      ,  [PC_MID-2010]    = ''
      ,  [NC_END-2011]    = ''
      ,  [PC_END-2011]    = ''
      ,  [NC_END-2012]    = ''
      ,  [PC_END-2012]    = ''
      ,  V5Row            = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = 500.00
      ,  [Answer_wording] = ''
      ,  [NC_MID-2007]    = ''
      ,  [PC_MID-2007]    = ''
      ,  [NC_MID-2008]    = ''
      ,  [PC_MID-2008]    = ''
      ,  [NC_MID-2009]    = ''
      ,  [PC_MID-2009]    = ''
      ,  [NC_MID-2010]    = ''
      ,  [PC_MID-2010]    = ''
      ,  [NC_END-2011]    = ''
      ,  [PC_END-2011]    = ''
      ,  [NC_END-2012]    = ''
      ,  [PC_END-2012]    = ''
      ,  V5Row            = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
)                                                                                                                                                      AS     TL
/***************************************************************************************************************************************************************/
      --,[Notes2_plus202]
      --,[Notes3_plus203]
      --,[CtryVals_p300]

WHERE
Variable
NOT IN
( 
  'GFI'
, 'GRI'
, 'SHI'
, 'GFI_rd_1d'
, 'GRI_rd_1d'
, 'SHI_rd_1d'
--
, 'GRI_01_x2'
, 'GRI_01_x2_a'
, 'GRI_01_x2_b'
--
, 'GRI_19_b'
, 'GRI_19_c'
, 'GRI_19_d'
, 'GRI_19_da'
, 'GRI_19_db'
, 'GRI_19_e'
, 'GRI_19_f'
, 'GRI_19_filter'
--
, 'GRI_20_05_x1'
--
, 'GRX_21_01'
, 'GRX_21_02'
, 'GRX_21_03'
--
, 'GRX_22'
, 'GRX_22_01'
, 'GRX_22_02'
, 'GRX_22_03'
, 'GRX_22_04'
, 'GRX_22_filter'
--
, 'GRX_23'
, 'GRX_24'
--
, 'GRX_27_01'
, 'GRX_27_02'
, 'GRX_27_03'
, 'GRX_28_01'
, 'GRX_28_02'
, 'GRX_28_03'
--
, 'SHI_01_a'
, 'SHI_01_b'
, 'SHI_01_c'
, 'SHI_01_d'
, 'SHI_01_da'
, 'SHI_01_db'
, 'SHI_01_e'
, 'SHI_01_f'
--
, 'SHI_04_b'
, 'SHI_04_c'
, 'SHI_04_d'
, 'SHI_04_da'
, 'SHI_04_db'
, 'SHI_04_e'
, 'SHI_04_f'
, 'SHI_04_filter'
, 'SHI_04_x'
--
, 'SHI_05_b'
, 'SHI_05_c'
, 'SHI_05_d'
, 'SHI_05_da'
, 'SHI_05_db'
, 'SHI_05_e'
, 'SHI_05_f'
, 'SHI_05_filter'
, 'SHI_05_x'
--
, 'SHX_14_01'
, 'SHX_14_02'
, 'SHX_14_03'
, 'SHX_14_04'
, 'SHX_15_01'
, 'SHX_15_02'
, 'SHX_15_03'
, 'SHX_15_04'
, 'SHX_15_05'
, 'SHX_15_06'
, 'SHX_15_07'
, 'SHX_15_08'
, 'SHX_15_09'
, 'SHX_15_10'
--
, 'XSG_S_99_01'
, 'XSG_S_99_02'
, 'XSG_S_99_03'
, 'XSG_S_99_04'
, 'XSG_S_99_05'
, 'XSG_S_99_06'
, 'XSG_S_99_filter'
 )
GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[Vx_c_GR&SH_WideData]    Script Date: 04/05/2016 09:42:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  VIEW
               [dbo].[Vx_c_GR&SH_WideData]
AS

SELECT 
/*** final list of variables > *********************************************************************************************************************************/
/*** variables NOT changing though time ************************************************************************************************************************/
       [Nation_fk]
      ,[Country_fk]
      ,[Ctry_EditorialName]
      ,[GDP_per_capita]
      ,[Region5]
      ,[Region6]
      ,[SubRegion]
      ,[IMF_Advance]
      ,[Global_NS]
      ,[UN_Reg1]
      ,[UN_Reg2]
      ,[UN_Develop]
/*** population variables CAN CHANGE though time ***************************************************************************************************************/
      ,[Pop2000]
      ,[Pop2010]
      ,[Pop2012]
/*** index values SHOULD BE ADDED EACH YEAR ********************************************************************************************************************/
      ,[GRI_2007]
      ,[GRI_2008]
      ,[GRI_2009]
      ,[GRI_2010]
      ,[GRI_2011]
      ,[GRI_2012]
      ,[SHI_2007]
      ,[SHI_2008]
      ,[SHI_2009]
      ,[SHI_2010]
      ,[SHI_2011]
      ,[SHI_2012]
      ,[GFI_2007]
      ,[GFI_2008]
      ,[GFI_2009]
      ,[GFI_2010]
      ,[GFI_2011]
      ,[GFI_2012]
, GFI_scaled_2007, GFI_scaled_2008, GFI_scaled_2009, GFI_scaled_2010, GFI_scaled_2011, GFI_scaled_2012, GRI_01_2007, GRI_01_2008, GRI_01_2009, GRI_01_2010, GRI_01_2011, GRI_01_2012, GRI_01_x_2010, GRI_01_x_2011, GRI_01_x_2012, GRI_02_2007, GRI_02_2008, GRI_02_2009, GRI_02_2010, GRI_02_2011, GRI_02_2012, GRI_03_2007, GRI_03_2008, GRI_03_2009, GRI_03_2010, GRI_03_2011, GRI_03_2012, GRI_04_2007, GRI_04_2008, GRI_04_2009, GRI_04_2010, GRI_04_2011, GRI_04_2012, GRI_05_2007, GRI_05_2008, GRI_05_2009, GRI_05_2010, GRI_05_2011, GRI_05_2012, GRI_06_2007, GRI_06_2008, GRI_06_2009, GRI_06_2010, GRI_06_2011, GRI_06_2012, GRI_07_2007, GRI_07_2008, GRI_07_2009, GRI_07_2010, GRI_07_2011, GRI_07_2012, GRI_08_2007, GRI_08_2008, GRI_08_2009, GRI_08_2010, GRI_08_2011, GRI_08_2012, GRI_08_for_index_2007, GRI_08_for_index_2008, GRI_08_for_index_2009, GRI_08_for_index_2010, GRI_08_for_index_2011, GRI_08_for_index_2012, GRI_09_2007, GRI_09_2008, GRI_09_2009, GRI_09_2010, GRI_09_2011, GRI_09_2012, GRI_10_01_2007, GRI_10_01_2008, GRI_10_01_2009, GRI_10_01_2010, GRI_10_01_2011, GRI_10_01_2012, GRI_10_02_2007, GRI_10_02_2008, GRI_10_02_2009, GRI_10_02_2010, GRI_10_02_2011, GRI_10_02_2012, GRI_10_03_2007, GRI_10_03_2008, GRI_10_03_2009, GRI_10_03_2010, GRI_10_03_2011, GRI_10_03_2012, GRI_10_2007, GRI_10_2008, GRI_10_2009, GRI_10_2010, GRI_10_2011, GRI_10_2012, GRI_11_01a_2007, GRI_11_01a_2008, GRI_11_01a_2009, GRI_11_01a_2010, GRI_11_01a_2011, GRI_11_01a_2012, GRI_11_01b_2007, GRI_11_01b_2008, GRI_11_01b_2009, GRI_11_01b_2010, GRI_11_01b_2011, GRI_11_01b_2012, GRI_11_02_2007, GRI_11_02_2008, GRI_11_02_2009, GRI_11_02_2010, GRI_11_02_2011, GRI_11_02_2012, GRI_11_03_2007, GRI_11_03_2008, GRI_11_03_2009, GRI_11_03_2010, GRI_11_03_2011, GRI_11_03_2012, GRI_11_04_2007, GRI_11_04_2008, GRI_11_04_2009, GRI_11_04_2010, GRI_11_04_2011, GRI_11_04_2012, GRI_11_05_2007, GRI_11_05_2008, GRI_11_05_2009, GRI_11_05_2010, GRI_11_05_2011, GRI_11_05_2012, GRI_11_06_2007, GRI_11_06_2008, GRI_11_06_2009, GRI_11_06_2010, GRI_11_06_2011, GRI_11_06_2012, GRI_11_07_2007, GRI_11_07_2008, GRI_11_07_2009, GRI_11_07_2010, GRI_11_07_2011, GRI_11_07_2012, GRI_11_08_2007, GRI_11_08_2008, GRI_11_08_2009, GRI_11_08_2010, GRI_11_08_2011, GRI_11_08_2012, GRI_11_09_2007, GRI_11_09_2008, GRI_11_09_2009, GRI_11_09_2010, GRI_11_09_2011, GRI_11_09_2012, GRI_11_10_2007, GRI_11_10_2008, GRI_11_10_2009, GRI_11_10_2010, GRI_11_10_2011, GRI_11_10_2012, GRI_11_11_2007, GRI_11_11_2008, GRI_11_11_2009, GRI_11_11_2010, GRI_11_11_2011, GRI_11_11_2012, GRI_11_12_2007, GRI_11_12_2008, GRI_11_12_2009, GRI_11_12_2010, GRI_11_12_2011, GRI_11_12_2012, GRI_11_13_2007, GRI_11_13_2008, GRI_11_13_2009, GRI_11_13_2010, GRI_11_13_2011, GRI_11_13_2012, GRI_11_14_2007, GRI_11_14_2008, GRI_11_14_2009, GRI_11_15_2010, GRI_11_15_2011, GRI_11_15_2012, GRI_11_16_2010, GRI_11_16_2011, GRI_11_16_2012, GRI_11_17_2012, GRI_11_2007, GRI_11_2008, GRI_11_2009, GRI_11_2010, GRI_11_2011, GRI_11_2012, GRI_11_xG1_2007, GRI_11_xG1_2008, GRI_11_xG1_2009, GRI_11_xG1_2010, GRI_11_xG1_2011, GRI_11_xG1_2012, GRI_11_xG2_2007, GRI_11_xG2_2008, GRI_11_xG2_2009, GRI_11_xG2_2010, GRI_11_xG2_2011, GRI_11_xG2_2012, GRI_11_xG3_2007, GRI_11_xG3_2008, GRI_11_xG3_2009, GRI_11_xG3_2010, GRI_11_xG3_2011, GRI_11_xG3_2012, GRI_11_xG4_2007, GRI_11_xG4_2008, GRI_11_xG4_2009, GRI_11_xG4_2010, GRI_11_xG4_2011, GRI_11_xG4_2012, GRI_11_xG5_2007, GRI_11_xG5_2008, GRI_11_xG5_2009, GRI_11_xG5_2010, GRI_11_xG5_2011, GRI_11_xG5_2012, GRI_11_xG6_2007, GRI_11_xG6_2008, GRI_11_xG6_2009, GRI_11_xG6_2010, GRI_11_xG6_2011, GRI_11_xG6_2012, GRI_11_xG7_2007, GRI_11_xG7_2008, GRI_11_xG7_2009, GRI_11_xG7_2010, GRI_11_xG7_2011, GRI_11_xG7_2012, GRI_12_2007, GRI_12_2008, GRI_12_2009, GRI_12_2010, GRI_12_2011, GRI_12_2012, GRI_13_2007, GRI_13_2008, GRI_13_2009, GRI_13_2010, GRI_13_2011, GRI_13_2012, GRI_14_2007, GRI_14_2008, GRI_14_2009, GRI_14_2010, GRI_14_2011, GRI_14_2012, GRI_15_2007, GRI_15_2008, GRI_15_2009, GRI_15_2010, GRI_15_2011, GRI_15_2012, GRI_16_01_2010, GRI_16_01_2011, GRI_16_01_2012, GRI_16_2007, GRI_16_2008, GRI_16_2009, GRI_16_2010, GRI_16_2011, GRI_16_2012, GRI_17_2007, GRI_17_2008, GRI_17_2009, GRI_17_2010, GRI_17_2011, GRI_17_2012, GRI_18_2007, GRI_18_2008, GRI_18_2009, GRI_18_2010, GRI_18_2011, GRI_18_2012, GRI_19_2007, GRI_19_2008, GRI_19_2009, GRI_19_2010, GRI_19_2011, GRI_19_2012, GRI_19_b_2007, GRI_19_b_2008, GRI_19_b_2009, GRI_19_b_2010, GRI_19_b_2011, GRI_19_b_2012, GRI_19_c_2007, GRI_19_c_2008, GRI_19_c_2009, GRI_19_c_2010, GRI_19_c_2011, GRI_19_c_2012, GRI_19_d_2007, GRI_19_d_2008, GRI_19_d_2009, GRI_19_d_2010, GRI_19_d_2011, GRI_19_d_2012, GRI_19_da_2010, GRI_19_db_2010, GRI_19_e_2007, GRI_19_e_2008, GRI_19_e_2009, GRI_19_e_2010, GRI_19_e_2011, GRI_19_e_2012, GRI_19_f_2007, GRI_19_f_2008, GRI_19_f_2009, GRI_19_f_2010, GRI_19_f_2011, GRI_19_f_2012, GRI_19_x_2007, GRI_19_x_2008, GRI_19_x_2009, GRI_19_x_2010, GRI_19_x_2011, GRI_19_x_2012, GRI_20_01_2007, GRI_20_01_2008, GRI_20_01_2009, GRI_20_01_2010, GRI_20_01_2011, GRI_20_01_2012, GRI_20_01x_01a_2009, GRI_20_01x_01a_2010, GRI_20_01x_01a_2011, GRI_20_01x_01a_2012, GRI_20_01x_01b_2009, GRI_20_01x_01b_2010, GRI_20_01x_01b_2011, GRI_20_01x_01b_2012, GRI_20_01x_02_2009, GRI_20_01x_02_2010, GRI_20_01x_02_2011, GRI_20_01x_02_2012, GRI_20_01x_03_2009, GRI_20_01x_03_2010, GRI_20_01x_03_2011, GRI_20_01x_03_2012, GRI_20_01x_04_2009, GRI_20_01x_04_2010, GRI_20_01x_04_2011, GRI_20_01x_04_2012, GRI_20_01x_05_2009, GRI_20_01x_05_2010, GRI_20_01x_05_2011, GRI_20_01x_05_2012, GRI_20_01x_06_2009, GRI_20_01x_06_2010, GRI_20_01x_06_2011, GRI_20_01x_06_2012, GRI_20_01x_07_2009, GRI_20_01x_07_2010, GRI_20_01x_07_2011, GRI_20_01x_07_2012, GRI_20_01x_08_2009, GRI_20_01x_08_2010, GRI_20_01x_08_2011, GRI_20_01x_08_2012, GRI_20_01x_09_2009, GRI_20_01x_09_2010, GRI_20_01x_09_2011, GRI_20_01x_09_2012, GRI_20_01x_10_2009, GRI_20_01x_10_2010, GRI_20_01x_10_2011, GRI_20_01x_10_2012, GRI_20_02_2007, GRI_20_02_2008, GRI_20_02_2009, GRI_20_02_2010, GRI_20_02_2011, GRI_20_02_2012, GRI_20_03_a_2007, GRI_20_03_a_2008, GRI_20_03_a_2009, GRI_20_03_a_2010, GRI_20_03_a_2011, GRI_20_03_a_2012, GRI_20_03_b_2007, GRI_20_03_b_2008, GRI_20_03_b_2009, GRI_20_03_b_2010, GRI_20_03_b_2011, GRI_20_03_b_2012, GRI_20_03_c_2007, GRI_20_03_c_2008, GRI_20_03_c_2009, GRI_20_03_c_2010, GRI_20_03_c_2011, GRI_20_03_c_2012, GRI_20_03_top_2007, GRI_20_03_top_2008, GRI_20_03_top_2009, GRI_20_03_top_2010, GRI_20_03_top_2011, GRI_20_03_top_2012, GRI_20_04_2007, GRI_20_04_2008, GRI_20_04_2009, GRI_20_04_2010, GRI_20_04_2011, GRI_20_04_2012, GRI_20_04_x_2010, GRI_20_04_x_2011, GRI_20_04_x_2012, GRI_20_05_2007, GRI_20_05_2008, GRI_20_05_2009, GRI_20_05_2010, GRI_20_05_2011, GRI_20_05_2012, GRI_20_05_x_2007, GRI_20_05_x_2008, GRI_20_05_x_2009, GRI_20_05_x_2010, GRI_20_05_x_2011, GRI_20_05_x_2012, GRI_20_2007, GRI_20_2008, GRI_20_2009, GRI_20_2010, GRI_20_2011, GRI_20_2012, GRI_20_top_2007, GRI_20_top_2008, GRI_20_top_2009, GRI_20_top_2010, GRI_20_top_2011, GRI_20_top_2012, GRI_scaled_2007, GRI_scaled_2008, GRI_scaled_2009, GRI_scaled_2010, GRI_scaled_2011, GRI_scaled_2012, GRX_22_01_2010, GRX_22_01_2011, GRX_22_01_2012, GRX_22_02_2010, GRX_22_02_2011, GRX_22_02_2012, GRX_22_03_2010, GRX_22_03_2011, GRX_22_03_2012, GRX_22_04_2010, GRX_22_04_2011, GRX_22_04_2012, GRX_22_2009, GRX_23_2009, GRX_23_2010, GRX_24_2010, GRX_24_2011, GRX_24_2012, GRX_25_01_2010, GRX_25_01_2011, GRX_25_01_2012, GRX_25_02_2010, GRX_25_02_2011, GRX_25_02_2012, GRX_25_03_2010, GRX_25_03_2011, GRX_25_03_2012, GRX_26_01_2011, GRX_26_01_2012, GRX_26_02_2011, GRX_26_02_2012, GRX_26_03_2011, GRX_26_03_2012, GRX_26_04_2011, GRX_26_04_2012, GRX_26_05_2011, GRX_26_05_2012, GRX_26_06_2011, GRX_26_07_2011, GRX_26_07_2012, GRX_26_08_2011, GRX_26_08_2012, GRX_27_01_2011, GRX_27_02_2011, GRX_27_03_2011, GRX_28_01_2011, GRX_28_02_2011, GRX_28_03_2011, GRX_29_01_2012, GRX_29_02_2012, GRX_29_03_2012, GRX_29_04_2012, GRX_29_05_2012, SHI_01_2007, SHI_01_2008, SHI_01_2009, SHI_01_2010, SHI_01_2011, SHI_01_2012, SHI_01_a_2007, SHI_01_a_2008, SHI_01_a_2009, SHI_01_a_2010, SHI_01_a_2011, SHI_01_a_2012, SHI_01_b_2007, SHI_01_b_2008, SHI_01_b_2009, SHI_01_b_2010, SHI_01_b_2011, SHI_01_b_2012, SHI_01_c_2007, SHI_01_c_2008, SHI_01_c_2009, SHI_01_c_2010, SHI_01_c_2011, SHI_01_c_2012, SHI_01_d_2007, SHI_01_d_2008, SHI_01_d_2009, SHI_01_d_2010, SHI_01_d_2011, SHI_01_d_2012, SHI_01_da_2010, SHI_01_db_2010, SHI_01_e_2007, SHI_01_e_2008, SHI_01_e_2009, SHI_01_e_2010, SHI_01_e_2011, SHI_01_e_2012, SHI_01_f_2007, SHI_01_f_2008, SHI_01_f_2009, SHI_01_f_2010, SHI_01_f_2011, SHI_01_f_2012, SHI_01_summary_b_2007, SHI_01_summary_b_2008, SHI_01_summary_b_2009, SHI_01_summary_b_2010, SHI_01_summary_b_2011, SHI_01_summary_b_2012, SHI_01_x_01a_2007, SHI_01_x_01a_2008, SHI_01_x_01a_2009, SHI_01_x_01a_2010, SHI_01_x_01a_2011, SHI_01_x_01a_2012, SHI_01_x_01b_2007, SHI_01_x_01b_2008, SHI_01_x_01b_2009, SHI_01_x_01b_2010, SHI_01_x_01b_2011, SHI_01_x_01b_2012, SHI_01_x_02_2007, SHI_01_x_02_2008, SHI_01_x_02_2009, SHI_01_x_02_2010, SHI_01_x_02_2011, SHI_01_x_02_2012, SHI_01_x_03_2007, SHI_01_x_03_2008, SHI_01_x_03_2009, SHI_01_x_03_2010, SHI_01_x_03_2011, SHI_01_x_03_2012, SHI_01_x_04_2007, SHI_01_x_04_2008, SHI_01_x_04_2009, SHI_01_x_04_2010, SHI_01_x_04_2011, SHI_01_x_04_2012, SHI_01_x_05_2007, SHI_01_x_05_2008, SHI_01_x_05_2009, SHI_01_x_05_2010, SHI_01_x_05_2011, SHI_01_x_05_2012, SHI_01_x_06_2007, SHI_01_x_06_2008, SHI_01_x_06_2009, SHI_01_x_06_2010, SHI_01_x_06_2011, SHI_01_x_06_2012, SHI_01_x_07_2007, SHI_01_x_07_2008, SHI_01_x_07_2009, SHI_01_x_07_2010, SHI_01_x_07_2011, SHI_01_x_07_2012, SHI_01_x_08_2007, SHI_01_x_08_2008, SHI_01_x_08_2009, SHI_01_x_08_2010, SHI_01_x_08_2011, SHI_01_x_08_2012, SHI_01_x_09_2007, SHI_01_x_09_2008, SHI_01_x_09_2009, SHI_01_x_09_2010, SHI_01_x_09_2011, SHI_01_x_09_2012, SHI_01_x_10_2007, SHI_01_x_10_2008, SHI_01_x_10_2009, SHI_01_x_10_2010, SHI_01_x_10_2011, SHI_01_x_10_2012, SHI_01_x_11_2007, SHI_01_x_11_2008, SHI_01_x_11_2009, SHI_01_x_11_2010, SHI_01_x_11_2011, SHI_01_x_11_2012, SHI_01_x_12_2007, SHI_01_x_12_2008, SHI_01_x_12_2009, SHI_01_x_12_2010, SHI_01_x_12_2011, SHI_01_x_12_2012, SHI_01_x_13_2007, SHI_01_x_13_2008, SHI_01_x_13_2009, SHI_01_x_13_2010, SHI_01_x_13_2011, SHI_01_x_13_2012, SHI_01_x_14_2007, SHI_01_x_14_2008, SHI_01_x_14_2009, SHI_01_x_15_2010, SHI_01_x_15_2011, SHI_01_x_15_2012, SHI_01_x_16_2010, SHI_01_x_16_2011, SHI_01_x_16_2012, SHI_01_x_17_2012, SHI_01_xG1_2007, SHI_01_xG1_2008, SHI_01_xG1_2009, SHI_01_xG1_2010, SHI_01_xG1_2011, SHI_01_xG1_2012, SHI_01_xG2_2007, SHI_01_xG2_2008, SHI_01_xG2_2009, SHI_01_xG2_2010, SHI_01_xG2_2011, SHI_01_xG2_2012, SHI_01_xG3_2007, SHI_01_xG3_2008, SHI_01_xG3_2009, SHI_01_xG3_2010, SHI_01_xG3_2011, SHI_01_xG3_2012, SHI_01_xG4_2007, SHI_01_xG4_2008, SHI_01_xG4_2009, SHI_01_xG4_2010, SHI_01_xG4_2011, SHI_01_xG4_2012, SHI_01_xG5_2007, SHI_01_xG5_2008, SHI_01_xG5_2009, SHI_01_xG5_2010, SHI_01_xG5_2011, SHI_01_xG5_2012, SHI_01_xG6_2007, SHI_01_xG6_2008, SHI_01_xG6_2009, SHI_01_xG6_2010, SHI_01_xG6_2011, SHI_01_xG6_2012, SHI_01_xG7_2007, SHI_01_xG7_2008, SHI_01_xG7_2009, SHI_01_xG7_2010, SHI_01_xG7_2011, SHI_01_xG7_2012, SHI_02_01_2007, SHI_02_01_2008, SHI_02_01_2009, SHI_02_01_2010, SHI_02_01_2011, SHI_02_01_2012, SHI_02_2007, SHI_02_2008, SHI_02_2009, SHI_02_2010, SHI_02_2011, SHI_02_2012, SHI_03_2007, SHI_03_2008, SHI_03_2009, SHI_03_2010, SHI_03_2011, SHI_03_2012, SHI_04_2007, SHI_04_2008, SHI_04_2009, SHI_04_2010, SHI_04_2011, SHI_04_2012, SHI_04_b_2007, SHI_04_b_2009, SHI_04_b_2010, SHI_04_b_2011, SHI_04_b_2012, SHI_04_c_2007, SHI_04_c_2008, SHI_04_c_2009, SHI_04_c_2010, SHI_04_c_2011, SHI_04_c_2012, SHI_04_d_2007, SHI_04_d_2008, SHI_04_d_2009, SHI_04_d_2010, SHI_04_d_2011, SHI_04_d_2012, SHI_04_da_2010, SHI_04_db_2010, SHI_04_e_2007, SHI_04_e_2008, SHI_04_e_2009, SHI_04_e_2010, SHI_04_e_2011, SHI_04_e_2012, SHI_04_f_2007, SHI_04_f_2008, SHI_04_f_2009, SHI_04_f_2010, SHI_04_f_2011, SHI_04_f_2012, SHI_04_x01_2010, SHI_04_x01_2011, SHI_04_x01_2012, SHI_05_2007, SHI_05_2008, SHI_05_2009, SHI_05_2010, SHI_05_2011, SHI_05_2012, SHI_05_b_2011, SHI_05_c_2007, SHI_05_c_2008, SHI_05_c_2009, SHI_05_c_2010, SHI_05_c_2011, SHI_05_c_2012, SHI_05_d_2007, SHI_05_d_2008, SHI_05_d_2009, SHI_05_d_2010, SHI_05_d_2011, SHI_05_d_2012, SHI_05_da_2010, SHI_05_db_2010, SHI_05_e_2007, SHI_05_e_2008, SHI_05_e_2009, SHI_05_e_2010, SHI_05_e_2011, SHI_05_e_2012, SHI_05_f_2007, SHI_05_f_2008, SHI_05_f_2009, SHI_05_f_2010, SHI_05_f_2011, SHI_05_f_2012, SHI_06_2007, SHI_06_2008, SHI_06_2009, SHI_06_2010, SHI_06_2011, SHI_06_2012, SHI_07_2007, SHI_07_2008, SHI_07_2009, SHI_07_2010, SHI_07_2011, SHI_07_2012, SHI_08_2007, SHI_08_2008, SHI_08_2009, SHI_08_2010, SHI_08_2011, SHI_08_2012, SHI_09_2007, SHI_09_2008, SHI_09_2009, SHI_09_2010, SHI_09_2011, SHI_09_2012, SHI_10_2007, SHI_10_2008, SHI_10_2009, SHI_10_2010, SHI_10_2011, SHI_10_2012, SHI_11_2007, SHI_11_2008, SHI_11_2009, SHI_11_2010, SHI_11_2011, SHI_11_2012, SHI_11_for_index_2007, SHI_11_for_index_2008, SHI_11_for_index_2009, SHI_11_for_index_2010, SHI_11_for_index_2011, SHI_11_for_index_2012, SHI_11_x_2010, SHI_11_x_2011, SHI_11_x_2012, SHI_12_2007, SHI_12_2008, SHI_12_2009, SHI_12_2010, SHI_12_2011, SHI_12_2012, SHI_13_2007, SHI_13_2008, SHI_13_2009, SHI_13_2010, SHI_13_2011, SHI_13_2012, SHI_scaled_2007, SHI_scaled_2008, SHI_scaled_2009, SHI_scaled_2010, SHI_scaled_2011, SHI_scaled_2012, SHX_14_01_2009, SHX_14_01_2010, SHX_14_02_2009, SHX_14_02_2010, SHX_14_03_2009, SHX_14_03_2010, SHX_14_04_2010, SHX_15_01_2009, SHX_15_01_2010, SHX_15_02_2009, SHX_15_02_2010, SHX_15_03_2009, SHX_15_03_2010, SHX_15_04_2009, SHX_15_04_2010, SHX_15_05_2009, SHX_15_05_2010, SHX_15_06_2009, SHX_15_06_2010, SHX_15_07_2009, SHX_15_07_2010, SHX_15_08_2009, SHX_15_08_2010, SHX_15_09_2009, SHX_15_09_2010, SHX_15_10_2009, SHX_15_10_2010, SHX_25_2010, SHX_25_2011, SHX_25_2012, SHX_26_2010, SHX_26_2011, SHX_26_2012, SHX_27_01_2010, SHX_27_01_2011, SHX_27_01_2012, SHX_27_02_2010, SHX_27_02_2011, SHX_27_02_2012, SHX_27_03_2010, SHX_27_03_2011, SHX_27_03_2012, SHX_28_01_2011, SHX_28_01_2012, SHX_28_02_2011, SHX_28_02_2012, SHX_28_03_2011, SHX_28_03_2012, SHX_28_04_2011, SHX_28_04_2012, SHX_28_05_2011, SHX_28_05_2012, SHX_28_06_2011, SHX_28_06_2012, SHX_28_07_2011, SHX_28_07_2012, SHX_28_08_2011, SHX_28_08_2012, XSG_01_xG1_2007, XSG_01_xG1_2008, XSG_01_xG1_2009, XSG_01_xG1_2010, XSG_01_xG1_2011, XSG_01_xG1_2012, XSG_01_xG2_2007, XSG_01_xG2_2008, XSG_01_xG2_2009, XSG_01_xG2_2010, XSG_01_xG2_2011, XSG_01_xG2_2012, XSG_01_xG3_2007, XSG_01_xG3_2008, XSG_01_xG3_2009, XSG_01_xG3_2010, XSG_01_xG3_2011, XSG_01_xG3_2012, XSG_01_xG4_2007, XSG_01_xG4_2008, XSG_01_xG4_2009, XSG_01_xG4_2010, XSG_01_xG4_2011, XSG_01_xG4_2012, XSG_01_xG5_2007, XSG_01_xG5_2008, XSG_01_xG5_2009, XSG_01_xG5_2010, XSG_01_xG5_2011, XSG_01_xG5_2012, XSG_01_xG6_2007, XSG_01_xG6_2008, XSG_01_xG6_2009, XSG_01_xG6_2010, XSG_01_xG6_2011, XSG_01_xG6_2012, XSG_01_xG7_2007, XSG_01_xG7_2008, XSG_01_xG7_2009, XSG_01_xG7_2010, XSG_01_xG7_2011, XSG_01_xG7_2012, XSG_24_2009, XSG_24_2010, XSG_24_2011, XSG_24_2012, XSG_S_01_2012, XSG_S_02_2012, XSG_S_03_2012, XSG_S_04_2012, XSG_S_05_2012, XSG_S_06_2012, XSG_S_07_2012, XSG_S_08_2012, XSG_S_09_2012, XSG_S_10_2012, XSG_S_11_2012, XSG_S_12_2012, XSG_S_13_2012, XSG_S_14_2012, XSG_S_15_2012, XSG_S_16_2012, XSG_S_17_2012, XSG_S_18_2012, XSG_S_19_2012, XSG_S_20_2012, XSG_S_21_2012, XSG_S_22_2012, XSG_S_23_2012
  FROM 
       [V6_Basic&Index]
                                                                                                                                            AS      M  /* MAIN */

/***************************************************************************************************************************************************************/
JOIN
/***************************************************************************************************************************************************************/
(
/*** variable data in wide format > ****************************************************************************************************************************/
SELECT
                 *
FROM
/***************************************************************************************************************************************************************/
(
/*** variable data in long format (concatenating varnames ans years) > *****************************************************************************************/
SELECT 
       NV           = [Nation_fk] 
      ,[MYVAR]      = [Variable] + '_' + STR([Question_Year], 4,0)
      ,[Value]
  FROM [V5_LRestr_by_CYV]
/*** < variable data in long format ****************************************************************************************************************************/
)                                                                                                                                                AS        NOIND
/*** pivoting begins > *****************************************************************************************************************************************/
pivot (max (Value) 
       for  MYVAR
           in (
/***************************************************************************************************************************************************************/
 GFI_scaled_2007, GFI_scaled_2008, GFI_scaled_2009, GFI_scaled_2010, GFI_scaled_2011, GFI_scaled_2012, GRI_01_2007, GRI_01_2008, GRI_01_2009, GRI_01_2010, GRI_01_2011, GRI_01_2012, GRI_01_x_2010, GRI_01_x_2011, GRI_01_x_2012, GRI_02_2007, GRI_02_2008, GRI_02_2009, GRI_02_2010, GRI_02_2011, GRI_02_2012, GRI_03_2007, GRI_03_2008, GRI_03_2009, GRI_03_2010, GRI_03_2011, GRI_03_2012, GRI_04_2007, GRI_04_2008, GRI_04_2009, GRI_04_2010, GRI_04_2011, GRI_04_2012, GRI_05_2007, GRI_05_2008, GRI_05_2009, GRI_05_2010, GRI_05_2011, GRI_05_2012, GRI_06_2007, GRI_06_2008, GRI_06_2009, GRI_06_2010, GRI_06_2011, GRI_06_2012, GRI_07_2007, GRI_07_2008, GRI_07_2009, GRI_07_2010, GRI_07_2011, GRI_07_2012, GRI_08_2007, GRI_08_2008, GRI_08_2009, GRI_08_2010, GRI_08_2011, GRI_08_2012, GRI_08_for_index_2007, GRI_08_for_index_2008, GRI_08_for_index_2009, GRI_08_for_index_2010, GRI_08_for_index_2011, GRI_08_for_index_2012, GRI_09_2007, GRI_09_2008, GRI_09_2009, GRI_09_2010, GRI_09_2011, GRI_09_2012, GRI_10_01_2007, GRI_10_01_2008, GRI_10_01_2009, GRI_10_01_2010, GRI_10_01_2011, GRI_10_01_2012, GRI_10_02_2007, GRI_10_02_2008, GRI_10_02_2009, GRI_10_02_2010, GRI_10_02_2011, GRI_10_02_2012, GRI_10_03_2007, GRI_10_03_2008, GRI_10_03_2009, GRI_10_03_2010, GRI_10_03_2011, GRI_10_03_2012, GRI_10_2007, GRI_10_2008, GRI_10_2009, GRI_10_2010, GRI_10_2011, GRI_10_2012, GRI_11_01a_2007, GRI_11_01a_2008, GRI_11_01a_2009, GRI_11_01a_2010, GRI_11_01a_2011, GRI_11_01a_2012, GRI_11_01b_2007, GRI_11_01b_2008, GRI_11_01b_2009, GRI_11_01b_2010, GRI_11_01b_2011, GRI_11_01b_2012, GRI_11_02_2007, GRI_11_02_2008, GRI_11_02_2009, GRI_11_02_2010, GRI_11_02_2011, GRI_11_02_2012, GRI_11_03_2007, GRI_11_03_2008, GRI_11_03_2009, GRI_11_03_2010, GRI_11_03_2011, GRI_11_03_2012, GRI_11_04_2007, GRI_11_04_2008, GRI_11_04_2009, GRI_11_04_2010, GRI_11_04_2011, GRI_11_04_2012, GRI_11_05_2007, GRI_11_05_2008, GRI_11_05_2009, GRI_11_05_2010, GRI_11_05_2011, GRI_11_05_2012, GRI_11_06_2007, GRI_11_06_2008, GRI_11_06_2009, GRI_11_06_2010, GRI_11_06_2011, GRI_11_06_2012, GRI_11_07_2007, GRI_11_07_2008, GRI_11_07_2009, GRI_11_07_2010, GRI_11_07_2011, GRI_11_07_2012, GRI_11_08_2007, GRI_11_08_2008, GRI_11_08_2009, GRI_11_08_2010, GRI_11_08_2011, GRI_11_08_2012, GRI_11_09_2007, GRI_11_09_2008, GRI_11_09_2009, GRI_11_09_2010, GRI_11_09_2011, GRI_11_09_2012, GRI_11_10_2007, GRI_11_10_2008, GRI_11_10_2009, GRI_11_10_2010, GRI_11_10_2011, GRI_11_10_2012, GRI_11_11_2007, GRI_11_11_2008, GRI_11_11_2009, GRI_11_11_2010, GRI_11_11_2011, GRI_11_11_2012, GRI_11_12_2007, GRI_11_12_2008, GRI_11_12_2009, GRI_11_12_2010, GRI_11_12_2011, GRI_11_12_2012, GRI_11_13_2007, GRI_11_13_2008, GRI_11_13_2009, GRI_11_13_2010, GRI_11_13_2011, GRI_11_13_2012, GRI_11_14_2007, GRI_11_14_2008, GRI_11_14_2009, GRI_11_15_2010, GRI_11_15_2011, GRI_11_15_2012, GRI_11_16_2010, GRI_11_16_2011, GRI_11_16_2012, GRI_11_17_2012, GRI_11_2007, GRI_11_2008, GRI_11_2009, GRI_11_2010, GRI_11_2011, GRI_11_2012, GRI_11_xG1_2007, GRI_11_xG1_2008, GRI_11_xG1_2009, GRI_11_xG1_2010, GRI_11_xG1_2011, GRI_11_xG1_2012, GRI_11_xG2_2007, GRI_11_xG2_2008, GRI_11_xG2_2009, GRI_11_xG2_2010, GRI_11_xG2_2011, GRI_11_xG2_2012, GRI_11_xG3_2007, GRI_11_xG3_2008, GRI_11_xG3_2009, GRI_11_xG3_2010, GRI_11_xG3_2011, GRI_11_xG3_2012, GRI_11_xG4_2007, GRI_11_xG4_2008, GRI_11_xG4_2009, GRI_11_xG4_2010, GRI_11_xG4_2011, GRI_11_xG4_2012, GRI_11_xG5_2007, GRI_11_xG5_2008, GRI_11_xG5_2009, GRI_11_xG5_2010, GRI_11_xG5_2011, GRI_11_xG5_2012, GRI_11_xG6_2007, GRI_11_xG6_2008, GRI_11_xG6_2009, GRI_11_xG6_2010, GRI_11_xG6_2011, GRI_11_xG6_2012, GRI_11_xG7_2007, GRI_11_xG7_2008, GRI_11_xG7_2009, GRI_11_xG7_2010, GRI_11_xG7_2011, GRI_11_xG7_2012, GRI_12_2007, GRI_12_2008, GRI_12_2009, GRI_12_2010, GRI_12_2011, GRI_12_2012, GRI_13_2007, GRI_13_2008, GRI_13_2009, GRI_13_2010, GRI_13_2011, GRI_13_2012, GRI_14_2007, GRI_14_2008, GRI_14_2009, GRI_14_2010, GRI_14_2011, GRI_14_2012, GRI_15_2007, GRI_15_2008, GRI_15_2009, GRI_15_2010, GRI_15_2011, GRI_15_2012, GRI_16_01_2010, GRI_16_01_2011, GRI_16_01_2012, GRI_16_2007, GRI_16_2008, GRI_16_2009, GRI_16_2010, GRI_16_2011, GRI_16_2012, GRI_17_2007, GRI_17_2008, GRI_17_2009, GRI_17_2010, GRI_17_2011, GRI_17_2012, GRI_18_2007, GRI_18_2008, GRI_18_2009, GRI_18_2010, GRI_18_2011, GRI_18_2012, GRI_19_2007, GRI_19_2008, GRI_19_2009, GRI_19_2010, GRI_19_2011, GRI_19_2012, GRI_19_b_2007, GRI_19_b_2008, GRI_19_b_2009, GRI_19_b_2010, GRI_19_b_2011, GRI_19_b_2012, GRI_19_c_2007, GRI_19_c_2008, GRI_19_c_2009, GRI_19_c_2010, GRI_19_c_2011, GRI_19_c_2012, GRI_19_d_2007, GRI_19_d_2008, GRI_19_d_2009, GRI_19_d_2010, GRI_19_d_2011, GRI_19_d_2012, GRI_19_da_2010, GRI_19_db_2010, GRI_19_e_2007, GRI_19_e_2008, GRI_19_e_2009, GRI_19_e_2010, GRI_19_e_2011, GRI_19_e_2012, GRI_19_f_2007, GRI_19_f_2008, GRI_19_f_2009, GRI_19_f_2010, GRI_19_f_2011, GRI_19_f_2012, GRI_19_x_2007, GRI_19_x_2008, GRI_19_x_2009, GRI_19_x_2010, GRI_19_x_2011, GRI_19_x_2012, GRI_20_01_2007, GRI_20_01_2008, GRI_20_01_2009, GRI_20_01_2010, GRI_20_01_2011, GRI_20_01_2012, GRI_20_01x_01a_2009, GRI_20_01x_01a_2010, GRI_20_01x_01a_2011, GRI_20_01x_01a_2012, GRI_20_01x_01b_2009, GRI_20_01x_01b_2010, GRI_20_01x_01b_2011, GRI_20_01x_01b_2012, GRI_20_01x_02_2009, GRI_20_01x_02_2010, GRI_20_01x_02_2011, GRI_20_01x_02_2012, GRI_20_01x_03_2009, GRI_20_01x_03_2010, GRI_20_01x_03_2011, GRI_20_01x_03_2012, GRI_20_01x_04_2009, GRI_20_01x_04_2010, GRI_20_01x_04_2011, GRI_20_01x_04_2012, GRI_20_01x_05_2009, GRI_20_01x_05_2010, GRI_20_01x_05_2011, GRI_20_01x_05_2012, GRI_20_01x_06_2009, GRI_20_01x_06_2010, GRI_20_01x_06_2011, GRI_20_01x_06_2012, GRI_20_01x_07_2009, GRI_20_01x_07_2010, GRI_20_01x_07_2011, GRI_20_01x_07_2012, GRI_20_01x_08_2009, GRI_20_01x_08_2010, GRI_20_01x_08_2011, GRI_20_01x_08_2012, GRI_20_01x_09_2009, GRI_20_01x_09_2010, GRI_20_01x_09_2011, GRI_20_01x_09_2012, GRI_20_01x_10_2009, GRI_20_01x_10_2010, GRI_20_01x_10_2011, GRI_20_01x_10_2012, GRI_20_02_2007, GRI_20_02_2008, GRI_20_02_2009, GRI_20_02_2010, GRI_20_02_2011, GRI_20_02_2012, GRI_20_03_a_2007, GRI_20_03_a_2008, GRI_20_03_a_2009, GRI_20_03_a_2010, GRI_20_03_a_2011, GRI_20_03_a_2012, GRI_20_03_b_2007, GRI_20_03_b_2008, GRI_20_03_b_2009, GRI_20_03_b_2010, GRI_20_03_b_2011, GRI_20_03_b_2012, GRI_20_03_c_2007, GRI_20_03_c_2008, GRI_20_03_c_2009, GRI_20_03_c_2010, GRI_20_03_c_2011, GRI_20_03_c_2012, GRI_20_03_top_2007, GRI_20_03_top_2008, GRI_20_03_top_2009, GRI_20_03_top_2010, GRI_20_03_top_2011, GRI_20_03_top_2012, GRI_20_04_2007, GRI_20_04_2008, GRI_20_04_2009, GRI_20_04_2010, GRI_20_04_2011, GRI_20_04_2012, GRI_20_04_x_2010, GRI_20_04_x_2011, GRI_20_04_x_2012, GRI_20_05_2007, GRI_20_05_2008, GRI_20_05_2009, GRI_20_05_2010, GRI_20_05_2011, GRI_20_05_2012, GRI_20_05_x_2007, GRI_20_05_x_2008, GRI_20_05_x_2009, GRI_20_05_x_2010, GRI_20_05_x_2011, GRI_20_05_x_2012, GRI_20_2007, GRI_20_2008, GRI_20_2009, GRI_20_2010, GRI_20_2011, GRI_20_2012, GRI_20_top_2007, GRI_20_top_2008, GRI_20_top_2009, GRI_20_top_2010, GRI_20_top_2011, GRI_20_top_2012, GRI_scaled_2007, GRI_scaled_2008, GRI_scaled_2009, GRI_scaled_2010, GRI_scaled_2011, GRI_scaled_2012, GRX_22_01_2010, GRX_22_01_2011, GRX_22_01_2012, GRX_22_02_2010, GRX_22_02_2011, GRX_22_02_2012, GRX_22_03_2010, GRX_22_03_2011, GRX_22_03_2012, GRX_22_04_2010, GRX_22_04_2011, GRX_22_04_2012, GRX_22_2009, GRX_23_2009, GRX_23_2010, GRX_24_2010, GRX_24_2011, GRX_24_2012, GRX_25_01_2010, GRX_25_01_2011, GRX_25_01_2012, GRX_25_02_2010, GRX_25_02_2011, GRX_25_02_2012, GRX_25_03_2010, GRX_25_03_2011, GRX_25_03_2012, GRX_26_01_2011, GRX_26_01_2012, GRX_26_02_2011, GRX_26_02_2012, GRX_26_03_2011, GRX_26_03_2012, GRX_26_04_2011, GRX_26_04_2012, GRX_26_05_2011, GRX_26_05_2012, GRX_26_06_2011, GRX_26_07_2011, GRX_26_07_2012, GRX_26_08_2011, GRX_26_08_2012, GRX_27_01_2011, GRX_27_02_2011, GRX_27_03_2011, GRX_28_01_2011, GRX_28_02_2011, GRX_28_03_2011, GRX_29_01_2012, GRX_29_02_2012, GRX_29_03_2012, GRX_29_04_2012, GRX_29_05_2012, SHI_01_2007, SHI_01_2008, SHI_01_2009, SHI_01_2010, SHI_01_2011, SHI_01_2012, SHI_01_a_2007, SHI_01_a_2008, SHI_01_a_2009, SHI_01_a_2010, SHI_01_a_2011, SHI_01_a_2012, SHI_01_b_2007, SHI_01_b_2008, SHI_01_b_2009, SHI_01_b_2010, SHI_01_b_2011, SHI_01_b_2012, SHI_01_c_2007, SHI_01_c_2008, SHI_01_c_2009, SHI_01_c_2010, SHI_01_c_2011, SHI_01_c_2012, SHI_01_d_2007, SHI_01_d_2008, SHI_01_d_2009, SHI_01_d_2010, SHI_01_d_2011, SHI_01_d_2012, SHI_01_da_2010, SHI_01_db_2010, SHI_01_e_2007, SHI_01_e_2008, SHI_01_e_2009, SHI_01_e_2010, SHI_01_e_2011, SHI_01_e_2012, SHI_01_f_2007, SHI_01_f_2008, SHI_01_f_2009, SHI_01_f_2010, SHI_01_f_2011, SHI_01_f_2012, SHI_01_summary_b_2007, SHI_01_summary_b_2008, SHI_01_summary_b_2009, SHI_01_summary_b_2010, SHI_01_summary_b_2011, SHI_01_summary_b_2012, SHI_01_x_01a_2007, SHI_01_x_01a_2008, SHI_01_x_01a_2009, SHI_01_x_01a_2010, SHI_01_x_01a_2011, SHI_01_x_01a_2012, SHI_01_x_01b_2007, SHI_01_x_01b_2008, SHI_01_x_01b_2009, SHI_01_x_01b_2010, SHI_01_x_01b_2011, SHI_01_x_01b_2012, SHI_01_x_02_2007, SHI_01_x_02_2008, SHI_01_x_02_2009, SHI_01_x_02_2010, SHI_01_x_02_2011, SHI_01_x_02_2012, SHI_01_x_03_2007, SHI_01_x_03_2008, SHI_01_x_03_2009, SHI_01_x_03_2010, SHI_01_x_03_2011, SHI_01_x_03_2012, SHI_01_x_04_2007, SHI_01_x_04_2008, SHI_01_x_04_2009, SHI_01_x_04_2010, SHI_01_x_04_2011, SHI_01_x_04_2012, SHI_01_x_05_2007, SHI_01_x_05_2008, SHI_01_x_05_2009, SHI_01_x_05_2010, SHI_01_x_05_2011, SHI_01_x_05_2012, SHI_01_x_06_2007, SHI_01_x_06_2008, SHI_01_x_06_2009, SHI_01_x_06_2010, SHI_01_x_06_2011, SHI_01_x_06_2012, SHI_01_x_07_2007, SHI_01_x_07_2008, SHI_01_x_07_2009, SHI_01_x_07_2010, SHI_01_x_07_2011, SHI_01_x_07_2012, SHI_01_x_08_2007, SHI_01_x_08_2008, SHI_01_x_08_2009, SHI_01_x_08_2010, SHI_01_x_08_2011, SHI_01_x_08_2012, SHI_01_x_09_2007, SHI_01_x_09_2008, SHI_01_x_09_2009, SHI_01_x_09_2010, SHI_01_x_09_2011, SHI_01_x_09_2012, SHI_01_x_10_2007, SHI_01_x_10_2008, SHI_01_x_10_2009, SHI_01_x_10_2010, SHI_01_x_10_2011, SHI_01_x_10_2012, SHI_01_x_11_2007, SHI_01_x_11_2008, SHI_01_x_11_2009, SHI_01_x_11_2010, SHI_01_x_11_2011, SHI_01_x_11_2012, SHI_01_x_12_2007, SHI_01_x_12_2008, SHI_01_x_12_2009, SHI_01_x_12_2010, SHI_01_x_12_2011, SHI_01_x_12_2012, SHI_01_x_13_2007, SHI_01_x_13_2008, SHI_01_x_13_2009, SHI_01_x_13_2010, SHI_01_x_13_2011, SHI_01_x_13_2012, SHI_01_x_14_2007, SHI_01_x_14_2008, SHI_01_x_14_2009, SHI_01_x_15_2010, SHI_01_x_15_2011, SHI_01_x_15_2012, SHI_01_x_16_2010, SHI_01_x_16_2011, SHI_01_x_16_2012, SHI_01_x_17_2012, SHI_01_xG1_2007, SHI_01_xG1_2008, SHI_01_xG1_2009, SHI_01_xG1_2010, SHI_01_xG1_2011, SHI_01_xG1_2012, SHI_01_xG2_2007, SHI_01_xG2_2008, SHI_01_xG2_2009, SHI_01_xG2_2010, SHI_01_xG2_2011, SHI_01_xG2_2012, SHI_01_xG3_2007, SHI_01_xG3_2008, SHI_01_xG3_2009, SHI_01_xG3_2010, SHI_01_xG3_2011, SHI_01_xG3_2012, SHI_01_xG4_2007, SHI_01_xG4_2008, SHI_01_xG4_2009, SHI_01_xG4_2010, SHI_01_xG4_2011, SHI_01_xG4_2012, SHI_01_xG5_2007, SHI_01_xG5_2008, SHI_01_xG5_2009, SHI_01_xG5_2010, SHI_01_xG5_2011, SHI_01_xG5_2012, SHI_01_xG6_2007, SHI_01_xG6_2008, SHI_01_xG6_2009, SHI_01_xG6_2010, SHI_01_xG6_2011, SHI_01_xG6_2012, SHI_01_xG7_2007, SHI_01_xG7_2008, SHI_01_xG7_2009, SHI_01_xG7_2010, SHI_01_xG7_2011, SHI_01_xG7_2012, SHI_02_01_2007, SHI_02_01_2008, SHI_02_01_2009, SHI_02_01_2010, SHI_02_01_2011, SHI_02_01_2012, SHI_02_2007, SHI_02_2008, SHI_02_2009, SHI_02_2010, SHI_02_2011, SHI_02_2012, SHI_03_2007, SHI_03_2008, SHI_03_2009, SHI_03_2010, SHI_03_2011, SHI_03_2012, SHI_04_2007, SHI_04_2008, SHI_04_2009, SHI_04_2010, SHI_04_2011, SHI_04_2012, SHI_04_b_2007, SHI_04_b_2009, SHI_04_b_2010, SHI_04_b_2011, SHI_04_b_2012, SHI_04_c_2007, SHI_04_c_2008, SHI_04_c_2009, SHI_04_c_2010, SHI_04_c_2011, SHI_04_c_2012, SHI_04_d_2007, SHI_04_d_2008, SHI_04_d_2009, SHI_04_d_2010, SHI_04_d_2011, SHI_04_d_2012, SHI_04_da_2010, SHI_04_db_2010, SHI_04_e_2007, SHI_04_e_2008, SHI_04_e_2009, SHI_04_e_2010, SHI_04_e_2011, SHI_04_e_2012, SHI_04_f_2007, SHI_04_f_2008, SHI_04_f_2009, SHI_04_f_2010, SHI_04_f_2011, SHI_04_f_2012, SHI_04_x01_2010, SHI_04_x01_2011, SHI_04_x01_2012, SHI_05_2007, SHI_05_2008, SHI_05_2009, SHI_05_2010, SHI_05_2011, SHI_05_2012, SHI_05_b_2011, SHI_05_c_2007, SHI_05_c_2008, SHI_05_c_2009, SHI_05_c_2010, SHI_05_c_2011, SHI_05_c_2012, SHI_05_d_2007, SHI_05_d_2008, SHI_05_d_2009, SHI_05_d_2010, SHI_05_d_2011, SHI_05_d_2012, SHI_05_da_2010, SHI_05_db_2010, SHI_05_e_2007, SHI_05_e_2008, SHI_05_e_2009, SHI_05_e_2010, SHI_05_e_2011, SHI_05_e_2012, SHI_05_f_2007, SHI_05_f_2008, SHI_05_f_2009, SHI_05_f_2010, SHI_05_f_2011, SHI_05_f_2012, SHI_06_2007, SHI_06_2008, SHI_06_2009, SHI_06_2010, SHI_06_2011, SHI_06_2012, SHI_07_2007, SHI_07_2008, SHI_07_2009, SHI_07_2010, SHI_07_2011, SHI_07_2012, SHI_08_2007, SHI_08_2008, SHI_08_2009, SHI_08_2010, SHI_08_2011, SHI_08_2012, SHI_09_2007, SHI_09_2008, SHI_09_2009, SHI_09_2010, SHI_09_2011, SHI_09_2012, SHI_10_2007, SHI_10_2008, SHI_10_2009, SHI_10_2010, SHI_10_2011, SHI_10_2012, SHI_11_2007, SHI_11_2008, SHI_11_2009, SHI_11_2010, SHI_11_2011, SHI_11_2012, SHI_11_for_index_2007, SHI_11_for_index_2008, SHI_11_for_index_2009, SHI_11_for_index_2010, SHI_11_for_index_2011, SHI_11_for_index_2012, SHI_11_x_2010, SHI_11_x_2011, SHI_11_x_2012, SHI_12_2007, SHI_12_2008, SHI_12_2009, SHI_12_2010, SHI_12_2011, SHI_12_2012, SHI_13_2007, SHI_13_2008, SHI_13_2009, SHI_13_2010, SHI_13_2011, SHI_13_2012, SHI_scaled_2007, SHI_scaled_2008, SHI_scaled_2009, SHI_scaled_2010, SHI_scaled_2011, SHI_scaled_2012, SHX_14_01_2009, SHX_14_01_2010, SHX_14_02_2009, SHX_14_02_2010, SHX_14_03_2009, SHX_14_03_2010, SHX_14_04_2010, SHX_15_01_2009, SHX_15_01_2010, SHX_15_02_2009, SHX_15_02_2010, SHX_15_03_2009, SHX_15_03_2010, SHX_15_04_2009, SHX_15_04_2010, SHX_15_05_2009, SHX_15_05_2010, SHX_15_06_2009, SHX_15_06_2010, SHX_15_07_2009, SHX_15_07_2010, SHX_15_08_2009, SHX_15_08_2010, SHX_15_09_2009, SHX_15_09_2010, SHX_15_10_2009, SHX_15_10_2010, SHX_25_2010, SHX_25_2011, SHX_25_2012, SHX_26_2010, SHX_26_2011, SHX_26_2012, SHX_27_01_2010, SHX_27_01_2011, SHX_27_01_2012, SHX_27_02_2010, SHX_27_02_2011, SHX_27_02_2012, SHX_27_03_2010, SHX_27_03_2011, SHX_27_03_2012, SHX_28_01_2011, SHX_28_01_2012, SHX_28_02_2011, SHX_28_02_2012, SHX_28_03_2011, SHX_28_03_2012, SHX_28_04_2011, SHX_28_04_2012, SHX_28_05_2011, SHX_28_05_2012, SHX_28_06_2011, SHX_28_06_2012, SHX_28_07_2011, SHX_28_07_2012, SHX_28_08_2011, SHX_28_08_2012, XSG_01_xG1_2007, XSG_01_xG1_2008, XSG_01_xG1_2009, XSG_01_xG1_2010, XSG_01_xG1_2011, XSG_01_xG1_2012, XSG_01_xG2_2007, XSG_01_xG2_2008, XSG_01_xG2_2009, XSG_01_xG2_2010, XSG_01_xG2_2011, XSG_01_xG2_2012, XSG_01_xG3_2007, XSG_01_xG3_2008, XSG_01_xG3_2009, XSG_01_xG3_2010, XSG_01_xG3_2011, XSG_01_xG3_2012, XSG_01_xG4_2007, XSG_01_xG4_2008, XSG_01_xG4_2009, XSG_01_xG4_2010, XSG_01_xG4_2011, XSG_01_xG4_2012, XSG_01_xG5_2007, XSG_01_xG5_2008, XSG_01_xG5_2009, XSG_01_xG5_2010, XSG_01_xG5_2011, XSG_01_xG5_2012, XSG_01_xG6_2007, XSG_01_xG6_2008, XSG_01_xG6_2009, XSG_01_xG6_2010, XSG_01_xG6_2011, XSG_01_xG6_2012, XSG_01_xG7_2007, XSG_01_xG7_2008, XSG_01_xG7_2009, XSG_01_xG7_2010, XSG_01_xG7_2011, XSG_01_xG7_2012, XSG_24_2009, XSG_24_2010, XSG_24_2011, XSG_24_2012, XSG_S_01_2012, XSG_S_02_2012, XSG_S_03_2012, XSG_S_04_2012, XSG_S_05_2012, XSG_S_06_2012, XSG_S_07_2012, XSG_S_08_2012, XSG_S_09_2012, XSG_S_10_2012, XSG_S_11_2012, XSG_S_12_2012, XSG_S_13_2012, XSG_S_14_2012, XSG_S_15_2012, XSG_S_16_2012, XSG_S_17_2012, XSG_S_18_2012, XSG_S_19_2012, XSG_S_20_2012, XSG_S_21_2012, XSG_S_22_2012, XSG_S_23_2012
/***************************************************************************************************************************************************************/
)                                                                               /*** end of listing of variables                                             ***/
 )                                                                                                                                              AS   PivotedData
/*** < ends pivoting *******************************************************************************************************************************************/
/*** < variable data in wide format ****************************************************************************************************************************/
)                                                                                                                                           AS      V  /* VARS */
/*** matching criteria for joining *****************************************************************************************************************************/
ON 
     Nation_fk = NV
/***************************************************************************************************************************************************************/
                                                                                                                                                /* END OF CODE */

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[Vx_e_LongIndex]    Script Date: 04/05/2016 09:43:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[Vx_e_LongIndex]
AS
/***************************************************************************************************************************************************************/
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
      , [Index_Abbreviation] = [Variable]
      , [Index_Value]        = [Value]
      , [Question_Year]
FROM
/**********************************************************/
(
/**********************************************************/
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
/**********************************************************/
)                                                         B
/**********************************************************/
UNPIVOT
  (
     Value
FOR
     Variable
in (
               [GRI]  /*** GRI Yindex (d prec/scale)    ***/
             , [SHI]  /*** SHI Yindex (d prec/scale)    ***/
             , [GFI]  /*** GFI Yindex (d prec/scale)    ***/
                                               ) ) as UNPIVTD
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[Vx_f_Index_by_Var]    Script Date: 04/05/2016 09:44:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[Vx_f_Index_by_Var]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------SELECT 
          V6Row
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [Q_Number]
                           , [Variable]
                           , [Value]
                           ,  [INDX]    DESC
                                             )
      ,  [Q_Number]
      ,  [Variable]
      ,  [Value]
      ,  [Answer_wording]
      ,  [INDX]
      ,  [AVRG]
      ,  [NCtries]
      ,  [V7Row]
FROM
/***************************************************************************************************************************************************************/
(
/***************************************************************************************************************************************************************/
SELECT 
       Q.[Q_Number]
      ,V.[Variable]
      ,V.[Value]
      ,V.[Answer_wording]
      ,I.[INDX]
      ,  [AVRG]
      ,  [NCtries]
      ,  [V7Row]
  FROM
       [AllAnswers]            V
CROSS JOIN
(
             SELECT [INDX] = 'GRI'
       UNION SELECT [INDX] = 'SHI'
                                    )        I
LEFT
OUTER
JOIN
       [V8_AggIdx_by_VarVal]   D
ON
       V.[Variable]
     = D.[Variable]
AND
       V.[Value]
     = D.[Value]
AND
       I.[INDX]
     = D.[INDX]
JOIN
       [AllQuestions]          Q
ON
       V.[Variable]
     = Q.[Variable]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = 200.00
      ,  [Answer_wording] = 'Total'
      ,  [INDX]
      ,  [AVRG]
      ,  [NCtries]
      ,  [V7Row]          = 0
  FROM
       [AllQuestions]          Q
CROSS JOIN
       [V9_AggIdx_by_Yr]          I
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -6.00
      ,  [Answer_wording] = [Label_minus4]
      ,  [INDX]           = NULL
      ,  [AVRG]           = NULL
      ,  [NCtries]        = NULL
      ,  [V7Row]          = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -5.00
      ,  [Answer_wording] = [Wording_minus3]
      ,  [INDX]           = NULL
      ,  [AVRG]           = NULL
      ,  [NCtries]        = NULL
      ,  [V7Row]          = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -4.00
      ,  [Answer_wording] = 'Average Social Hostilities Index (SHI) and Government Restrictions Index (GRI)'
      ,  [INDX]           = NULL
      ,  [AVRG]           = NULL
      ,  [NCtries]        = 'Number of countries'
      ,  [V7Row]          = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -3.00
      ,  [Answer_wording] = 'scores, (Jan - Dec 2012)'
      ,  [INDX]           = NULL
      ,  [AVRG]           = NULL
      ,  [NCtries]        = 'by answer'
      ,  [V7Row]          = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = -2.00
      ,  [Answer_wording] = 'Answers'
      ,  [INDX]           = NULL
      ,  [AVRG]           = NULL
      ,  [NCtries]        = 'YEAR 2012'
      ,  [V7Row]          = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = 202.00
      ,  [Answer_wording] = [Notes1_plus201]
      ,  [INDX]           = NULL
      ,  [AVRG]           = NULL
      ,  [NCtries]        = NULL
      ,  [V7Row]          = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
SELECT 
         [Q_Number]
      ,  [Variable]
      ,  [Value]          = 500.00
      ,  [Answer_wording] = ''
      ,  [INDX]           = NULL
      ,  [AVRG]           = NULL
      ,  [NCtries]        = NULL
      ,  [V7Row]          = 0
  FROM 
       [AllQuestions]
/***************************************************************************************************************************************************************/
)                                                                                                                                                      AS     TL
/***************************************************************************************************************************************************************/
      --,[Notes2_plus202]
      --,[Notes3_plus203]
      --,[CtryVals_p300]

WHERE
Variable
IN
( 
  'GFI_scaled'
, 'GRI_scaled'
, 'SHI_scaled'
, 'GRI_01'
, 'GRI_02'
, 'GRI_03'
, 'GRI_04'
, 'GRI_05'
, 'GRI_06'
, 'GRI_07'
, 'GRI_08'
, 'GRI_09'
, 'GRI_10'
, 'GRI_11'
, 'GRI_12'
, 'GRI_13'
, 'GRI_14'
, 'GRI_15'
, 'GRI_16_ny'
, 'GRI_17'
, 'GRI_18'
, 'GRI_19_ny'
, 'GRI_19_summ_ny'
, 'GRI_20_top'
, 'GRI_20_01'
, 'GRI_20_02'
, 'GRI_20_03_top'
, 'GRI_20_03_a'
, 'GRI_20_03_b'
, 'GRI_20_03_c'
, 'GRI_20_04'
, 'GRI_20_05'
, 'SHI_01_summary_a_ny'
, 'SHI_01_summary_b'
, 'SHI_01_a_dummy'
, 'SHI_01_b_dummy'
, 'SHI_01_c_dummy'
, 'SHI_01_d_dummy'
, 'SHI_01_e_dummy'
, 'SHI_01_f_dummy'
, 'SHI_02'
, 'SHI_03'
, 'SHI_04_ny'
, 'SHI_05_ny'
, 'SHI_06'
, 'SHI_07_ny'
, 'SHI_08'
, 'SHI_09'
, 'SHI_10'
, 'SHI_11'
, 'SHI_12'
, 'SHI_13'
, 'GRX_22_ny'
, 'GRX_22_01_ny'
, 'GRX_22_02_ny'
, 'GRX_22_04_ny'
, 'GRX_22_03_ny'
, 'XSG_25n27_ny'
, 'GRX_25_ny'
, 'SHX_27_ny'
, 'XSG_242526_ny'
, 'GRX_24_ny'
, 'SHX_25_ny'
, 'SHX_26_ny'
 )
 /***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
USE [forum_ResAnal]
GO

/****** Object:  View [dbo].[Vx_g_End_TopLines]    Script Date: 04/05/2016 09:44:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
CREATE  VIEW
               [dbo].[Vx_g_End_TopLines]
AS
/***************************************************************************************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [V6Row]  =  ROW_NUMBER()
                   OVER(ORDER BY [V6Row] )
      ,[Variable]
      ,[Value]
      ,[Answer_wording]
      ,[NC_MID-2007]
      ,[PC_MID-2007]
      ,[NC_END-2011]
      ,[PC_END-2011]
      ,[NC_END-2012]
      ,[PC_END-2012]
      ,[V5Row]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  FROM 
       [Vx_b_TopLines]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
Variable
IN
( 
  'GRI_01'
, 'GRI_02'
, 'GRI_03'
, 'GRI_04'
, 'GRI_05'
, 'GRI_06'
, 'GRI_07'
, 'GRI_08_for_index'
, 'GRI_09'
, 'GRI_10'
, 'GRI_11'
, 'GRI_12'
, 'GRI_13'
, 'GRI_14'
, 'GRI_15'
, 'GRI_16_ny'
, 'GRI_17'
, 'GRI_18'
, 'GRI_19_ny'
, 'GRI_19_summ_ny'
, 'GRI_20_top'
, 'GRI_20_01'
, 'GRI_20_02'
, 'GRI_20_03_top'
, 'GRI_20_03_a'
, 'GRI_20_03_b'
, 'GRI_20_03_c'
, 'GRI_20_04'
, 'GRI_20_05'
, 'SHI_01_summary_a_ny'
, 'SHI_01_summary_b'
, 'SHI_02'
, 'SHI_03'
, 'SHI_04_ny'
, 'SHI_05_ny'
, 'SHI_06'
, 'SHI_07_ny'
, 'SHI_08'
, 'SHI_09'
, 'SHI_10'
, 'SHI_11_for_index'
, 'SHI_12'
, 'SHI_13'
, 'GRX_22_ny'
, 'GRX_22_01_ny'
, 'GRX_22_02_ny'
, 'GRX_22_04_ny'
, 'GRX_22_03_ny'
, 'XSG_25n27_ny'
, 'GRX_25_ny'
, 'SHX_27_ny'
, 'XSG_242526_ny'
, 'GRX_24_ny'
, 'SHX_25_ny'
, 'SHX_26_ny'
                                      )
/***************************************************************************************************************************************************************/

GO


-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------
-------




-------        + + +        -------




-------



