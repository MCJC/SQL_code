--USE forum ;
--GO

--IF OBJECT_ID ('Restrictions_byCtry', 'V') IS NOT NULL
--  DROP VIEW    Restrictions_byCtry;
--GO
   
--CREATE VIEW    Restrictions_byCtry
--AS
--SELECT
--        ARD.Q_Level
--      , ARD.Nation_fk
--      , ARD.Ctry_EditorialName
--      , ARD.Question_Year
--      , ARD.Question_abbreviation_std
--      , ARD.Question_short_wording_std
--      , ARD.Answer_value
--      , ARD.answer_wording_std
--      , ARD.Question_fk
--      , ARD.Answer_fk


SELECT
        distinct
        ARD.Question_abbreviation_std
      , ARD.[Question_short_wording_std]
      , ARD.[Answer_value]
      , ARD.[answer_wording_std]
      --, ARD.Question_fk
      --, ARD.Answer_fk
      --, ARD.Question_Year
FROM
(
/***  Get ALL restrictions data  *********************************************************************************************************/

/***  NON-AGGREGATED variables  **********************************************************************************************************/
SELECT     Q_Level     = 'Country'
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = NULL
      ,    Religion_fk = NULL
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
      ,    Locality_fk = NULL
      ,    Religion_fk = NULL
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
      ,    Locality_fk = NULL
      ,    Religion_fk = NULL
      , AG2.Question_Year
      ,     Question_abbreviation_std  = 'GRI_20_3_summary'
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
      ,    Locality_fk = NULL
      ,    Religion_fk = NULL
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


/***  GRI_20_summary  ********************************************************************************************************************/

SELECT     Q_Level     = 'aggregated'
      ,    Nation_fk   = N.[Nation_pk]
      , N.[Ctry_EditorialName]
      ,    Locality    = 'not detailed'
      ,    Religion    = G.[Pew_religion]
      , Q.[Question_Year]
      , Q.[Question_abbreviation_std]
      , Q.[Question_short_wording_std]
      , A.[Answer_value]
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
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
/*********************************************************************************************************  Get ALL restrictions data  ***/
)
                                                   AS ARD

JOIN [forum].[dbo].[Pew_Question_Displayable] AS PQD
  ON ARD.Question_abbreviation_std
   = PQD.Question_abbreviation_std
 AND ARD.Question_Year
   = PQD.Question_Year


WHERE      ARD.Question_abbreviation_std like 'GRI_20%'
ORDER BY   ARD.Question_abbreviation_std
         , ARD.Answer_value



