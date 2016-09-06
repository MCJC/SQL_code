/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 2.002    ---------------------------------------------------------------------------------------- '
/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/


--   should we finally add [QA_std] LIKE 'GRI_0[1-2]_yBe'

-- ad std questions fom this coding period
/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
/*****                                                    STEP 000                                                    *****/
/*****                                           BackUp  current Table(s)                                             *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Std' + '_' + @CrDt + 'b]
                  FROM      [forum].[dbo].[Pew_Question_Std]'                      )
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Std]                                           /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Question_Std_pk]            =    ROW_NUMBER()OVER(
                                         ORDER BY[Question_Std_pk])            /* number all rows                         */
                                      + (SELECT MAX([Question_Std_pk])         /* add currently max pk                    */
                                           FROM [Pew_Question_Std])            /* from StdQuestions                       */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_abbreviation_std]  =   [Question_abbreviation_std] + '_yBe'
      ,[Question_wording_std]       =   [Question_abbreviation_std] + 'from past year - (BkUp vaue)'
      ,[Question_short_wording_std] =   [Question_abbreviation_std] + 'from past year - (BkUp vaue)'
      ,[Display]                    =   0
      ,[AnswerSet_num]              =   [AnswerSet_num]
      ,[Editorially_Checked]        = 'NO!'                                    /* label as not editorially checked        */
  FROM [forum].[dbo].[Pew_Question_Std]
WHERE [Question_abbreviation_std] LIKE 'GRI_0[1-2]'
/**************************************************************************************************************************/
SELECT * FROM [Pew_Question_Std]                                               /* check results in modified table         */
/**************************************************************************************************************************/






-- ADD STD ANSWERS

/**************************************************************************************************************************/
/*****                                              BackUp current Table                                              *****/
/**************************************************************************************************************************/
  USE [forum]                                                                  /* use final database                      */
GO
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)                                                 /* declare variable to store current date  */
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                          /* store date in format YYYYMMDD           */
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC                                                                           /* exec statement to run string s script   */
     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Answer_Std_' + @CrDt + ']
                  FROM     [forum].[dbo].[Pew_Answer_Std]'               )     /* select into backup from current table   */
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
(                                                                              /* >   Set of Values begins...             */
--
        SELECT N =  1, V =  0.00 , W = 'No official or favored religion(s), and the state attempts to strictly control religion'
  UNION SELECT N =  1, V =  0.33 , W = 'No official religion, and there is separation of church and state'
  UNION SELECT N =  1, V =  0.67 , W = 'State has a preferred or approved religion(s)'
  UNION SELECT N =  1, V =  1.00 , W = 'State recognizes one official religion'
--
  UNION SELECT N =  2, V =  0.00 , W = 'There is no official religion.'
  UNION SELECT N =  2, V =  0.25 , W = 'The official religion is not mandatory, and it receives more or less the same benefits as other religions.'
  UNION SELECT N =  2, V =  0.50 , W = 'The official religion is not mandatory, but the state regulates other religious groups and the official religion receives more benefits than other religions.'
  UNION SELECT N =  2, V =  0.75 , W = 'The official religion is not mandatory, but the state creates a hostile environment for other religions.'
  UNION SELECT N =  2, V =  1.00 , W = 'The official religion is mandatory for all citizens.'
--
  UNION SELECT N =  3, V =  0.00 , W = 'No.'
  UNION SELECT N =  3, V =  0.50 , W = 'Yes, but involvement was limited to providing weapons or financial support.'
  UNION SELECT N =  3, V =  1.00 , W = 'Yes, and involvement included troops.'
----
  UNION SELECT N =  4, V =  0.00 , W = 'No.'
  UNION SELECT N =  4, V =  0.50 , W = 'Yes, but but not only for the official/preferred religion.'
  UNION SELECT N =  4, V =  1.00 , W = 'Yes, and disproportionately benefits the official/preferred religion.'
--
)                                                                              /* <   Set of Values ends!                 */
/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	               [Pew_Answer_Std]                                            /* table in working database               */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Answer_Std_pk]          =   (ROW_NUMBER ()                             /* number all rows                         */
                                           OVER (ORDER BY [N], [V] ))          /* sorted by answer set number & value     */
                                  + (SELECT MAX([Answer_Std_pk])               /* add currently max pk                    */
                                       FROM     [Pew_Answer_Std]               /* from Std Answers                        */
                                      WHERE     [Answer_Std_pk] < 999990)      /* excluding Un-Coded Numeric/Count vals   */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[AnswerSet_number]       =   [N]                                        /* conventional answer set number          */
                                  + (SELECT MAX([AnswerSet_number])            /* add currently max answer set number     */
                                       FROM     [Pew_Answer_Std]               /* from Std Answers                        */
                                      WHERE     [AnswerSet_number] < 999990)   /* excluding Un-Coded Numeric/Count vals   */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Answer_value_std]       =   [V]                                        /* conventional answer standard value      */
      ,[Answer_Wording_std]     =   [W]                                        /* conventional answer standard wording    */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Full_set_of_Answers]    =   [A]                                        /* nested set of values & wordings by set  */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[NA_by_set_of_Answers]   =   [X]                                        /* count of values by answer set number    */
/*------------------------------------------------------------------------------------------------------------------------*/
FROM
/*------------------------------------------------------------------------------------------------------------------------*/
        [NSV]                                                     AS SetVs     /* main reference to CTE (New Set of Vals) */
/*------------------------------------------------------------------------------------------------------------------------*/
 JOIN
/*------------------------------------------------------------------------------------------------------------------------*/
      ( SELECT                                                                 /* sub-query for nested & aggegated values */
               [r] = [N]                                                       /* answer set number - join to main query  */
              ,[X] = COUNT(*)                                                  /* aggregate by counting rows              */
              ,[A] = STUFF(                                                    /* begin stuffing procedure...             */
                           ( SELECT '   ||'                                    /* begin selection into XML nested cell(s) */
                                  + STR(S2.[V], 7,2 )                          /* add value as string...                  */
                                  + ': '                                       /* concatenate using colon...              */
                                  +        [W]                                 /* to the corresponding wording            */
                              FROM         [NSV]          S2                   /* secondary reference to CTE in sub-query */
                             WHERE      S1.[N]                                 /* correspondence on main CTE reference... */
                                      = S2.[N]                                 /* to secondary reference in sub-query     */
                          ORDER BY      S1.[N]                                 /* sorting order by answer set number      */
                          FOR XML PATH('') )                                   /* nest in one XML string cell             */
                                            , 1, 8, '')                        /* end stuffing proced. by dropping chars  */
          FROM     [NSV]                                  S1                   /* main reference to CTE in sub-query      */
          GROUP BY [N]                                        )   AS nstdV     /* aggregate values & alias of sub-query   */
/*------------------------------------------------------------------------------------------------------------------------*/
ON         SetVs.[N]  =   nstdV.[r]                                            /* joint b/w main ref to CTE & sub-query   */
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 002                                                    *****/
/**************************************************************************************************************************/
SELECT * FROM [Pew_Answer_Std]                                                 /* check results in modified table         */
/**************************************************************************************************************************/

-- ad std questions fom this coding period
/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
/*****                                                    STEP 000                                                    *****/
/*****                                           BackUp  current Table(s)                                             *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Std' + '_' + @CrDt + ']
                  FROM      [forum].[dbo].[Pew_Question_Std]'                      )
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
(                                                                              /* >   Set of Values begins...             */
--
        SELECT N =     47, Q = 'GRI_20_01x_11'     , W = 'Is atheism recognized as a favored religioous perspective by the constitution or law that functions in the place of constitution?'
  UNION SELECT N =    242, Q = 'GRI_20_01_x_01'    , W = 'What is the relationship between religion and the state?'
  UNION SELECT N =    243, Q = 'GRI_20_01_x_02'    , W = 'If the state has one official religion, which best characterizes the religion-state relationship?'
  UNION SELECT N =     25, Q = 'GRX_22_x'          , W = 'Does any level of government penalize the defamation of religion, including penalizing such things as blasphemy, apostasy, and criticisms or critiques of the official or preferred state religion specifically? '
  UNION SELECT N =     25, Q = 'GRX_22_x_01'       , W = 'Does any level of government penalize blasphemy about the official or preferred state religion specifically?'
  UNION SELECT N =     25, Q = 'GRX_22_x_02'       , W = 'Does any level of government penalize apostasy from the official or preferred state religion specifically?'
  UNION SELECT N =     25, Q = 'GRX_22_x_03'       , W = 'Does any level of government penalize hate speech about the the official or preferred state religion specifically?'
  UNION SELECT N =     25, Q = 'GRX_22_x_04'       , W = 'Does any level of government penalize criticism or critiques of the the official or preferred state religion specifically?'
  UNION SELECT N =     47, Q = 'GRX_36'            , W = 'Does the government provide exemptions for religious groups from military service?'
  UNION SELECT N = 999999, Q = 'SHI_04_d_x_1'      , W = 'Count for SHI_04_d_x_1: Displaced from their homes (code displacements from previous reporting periods only for citizens or permanent residents)  - NOTE: REPORT NUMBER FROM UNHCR DATASET'
  UNION SELECT N = 999999, Q = 'SHI_04_d_x_2'      , W = 'Count for SHI_04_d_x_2: Displaced from their homes (code displacements from previous reporting periods only for citizens or permanent residents)  - NOTE: REPORT NUMBER FROM IDMC DATASET'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_01a'    , W = 'Were Orthodox Christians physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_01b'    , W = 'Were Catholics physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_02'     , W = 'Were Protestants or Anglicans physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_03'     , W = 'Were Christians (unspecified) physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_04'     , W = 'Were Sunni Muslims physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_05'     , W = 'Were Shia Muslims physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_06'     , W = 'Were Muslims (unspecified) physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_07'     , W = 'Were Buddhists physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_08'     , W = 'Were Hindus physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_09'     , W = 'Were Jews physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_10'     , W = 'Were Scientologists, Baha''is or followers of other "new" religions physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_11'     , W = 'Were Mormons, Jehovah''s Witnesses or other schismatic Christian sects physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_12'     , W = 'Were Ahmadiyya, Druze or other schismatic Muslim sects physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_13'     , W = 'Were followers of ethnic or tribal religions physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_16'     , W = 'Were Zoroastrians physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_15'     , W = 'Were Sikhs physically abused due to religion-related terrorism?'
  UNION SELECT N =     47, Q = 'SHI_04_f_x_17'     , W = 'Were atheists physically abused due to religion-related terrorism?'
  UNION SELECT N = 999999, Q = 'SHI_05_d_x_1'      , W = 'Count for SHI_05_d_x_1: Displaced from their homes (includes those deported or denied entry or return; code displacements from previous reporting periods only for citizens or permanent residents) (total of next two) and/or personal or religious properties damaged or destroyed (includes property defaced, confiscated, closed or raided) - NOTE: REPORT NUMBER FROM UNHCR DATASET'
  UNION SELECT N = 999999, Q = 'SHI_05_d_x_2'      , W = 'Count for SHI_05_d_x_2: Displaced from their homes (includes those deported or denied entry or return; code displacements from previous reporting periods only for citizens or permanent residents) (total of next two) and/or personal or religious properties damaged or destroyed (includes property defaced, confiscated, closed or raided) - NOTE: REPORT NUMBER FROM IDMC DATASET'
  UNION SELECT N =    244, Q = 'SHI_05_01'         , W = 'Was the government involved in a religion-related war in another country?'
  UNION SELECT N =     47, Q = 'SHI_06_01'         , W = 'Did the score for SHI_06 this question depend solely on information from the two IRF reports before this year''s repport?'
  UNION SELECT N =     47, Q = 'SHI_13_01'         , W = 'Did the score for SHI_13 this question depend solely on information from the two IRF reports before this year''s repport?'
  UNION SELECT N =     47, Q = 'SHI_12_01'         , W = 'Did the score for SHI_12 this question depend solely on information from the two IRF reports before this year''s repport?'
  UNION SELECT N =     47, Q = 'SHI_08_01'         , W = 'Did the score for SHI_08 this question depend solely on information from the two IRF reports before this year''s repport?'
  UNION SELECT N =     47, Q = 'SHI_07_01'         , W = 'Did the score for SHI_07 this question depend solely on information from the two IRF reports before this year''s repport?'
  UNION SELECT N =     47, Q = 'SHI_11_b_01'       , W = 'Did the score for SHI_11_b this question depend solely on information from the two IRF reports before this year''s repport?'
  UNION SELECT N =     47, Q = 'SHI_09_01'         , W = 'Did the score for SHI_09 this question depend solely on information from the two IRF reports before this year''s repport?'
  UNION SELECT N =     47, Q = 'SHI_10_01'         , W = 'Did the score for SHI_10 this question depend solely on information from the two IRF reports before this year''s repport?'
--
)                                                                              /* <   Set of Values ends!                 */
/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Std]                                           /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Question_Std_pk]            =    ROW_NUMBER () OVER(ORDER BY [Q] )     /* number all rows                         */
                                      + (SELECT MAX([Question_Std_pk])         /* add currently max pk                    */
                                           FROM [Pew_Question_Std])            /* from StdQuestions                       */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_abbreviation_std]  = [Q]
      ,[Question_wording_std]       = [W]
      ,[Question_short_wording_std] = [W]
      ,[Display]                    = 0                                        /* set display to zero (provisionally)     */
	  ,[AnswerSet_num]              = [N]                                      /*                                         */
      ,[Editorially_Checked]        = 'NO!'                                    /* label as not editorially checked        */
/*------------------------------------------------------------------------------------------------------------------------*/
FROM
/*------------------------------------------------------------------------------------------------------------------------*/
        [NSV]                                                     AS SetVs     /* main reference to CTE (New Set of Vals) */
/*------------------------------------------------------------------------------------------------------------------------*/

/**************************************************************************************************************************/
/*****                                                    STEP 004                                                    *****/
/**************************************************************************************************************************/
SELECT * FROM [Pew_Question_Std]                                               /* check results in modified table         */
/**************************************************************************************************************************/


-- clone some new std questions fom this coding period
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
(                                                                              /* >   Set of Values begins...             */
--
  SELECT N = 245
        ,Q = 'GRI_20_03_a_xx' 
        ,L = 'Does any level of government provide funds or other resources for religious education programs and/or religious schools?'
        ,S ='Does the government provide funds or resources for religious education or religious schools?'
UNION
  SELECT N = 245
        ,Q = 'GRI_20_03_b_xx' 
        ,L = 'Does any level of government provide funds or other resources for religious property (e.g., buildings, upkeep, repair or land)?'
        ,S = 'Does the government provide funds or resources for religious property?'
UNION
  SELECT N = 245
        ,Q = 'GRI_20_03_c_xx' 
        ,L = 'Does any level of government provide funds or other resources for religious activities other than education or property?'
        ,S = 'Does the government provide funds or resources for religious activities other than education or property?'
--
)                                                                              /* <   Set of Values ends!                 */
/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Std]                                           /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Question_Std_pk]            =    ROW_NUMBER () OVER(ORDER BY [Q] )     /* number all rows                         */
                                      + (SELECT MAX([Question_Std_pk])         /* add currently max pk                    */
                                           FROM [Pew_Question_Std])            /* from StdQuestions                       */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_abbreviation_std]  = [Q]
      ,[Question_wording_std]       = [L]
      ,[Question_short_wording_std] = [S]
      ,[Display]                    = 0                                        /* set display to zero (provisionally)     */
	  ,[AnswerSet_num]              = [N]                                      /*                                         */
      ,[Editorially_Checked]        = 'NO!'                                    /* label as not editorially checked        */
/*------------------------------------------------------------------------------------------------------------------------*/
FROM
/*------------------------------------------------------------------------------------------------------------------------*/
        [NSV]                                                     AS SetVs     /* main reference to CTE (New Set of Vals) */
/*------------------------------------------------------------------------------------------------------------------------*/

/**************************************************************************************************************************/
/*****                                                    STEP 004                                                    *****/
/**************************************************************************************************************************/
SELECT * FROM [Pew_Question_Std]                                               /* check results in modified table         */
/**************************************************************************************************************************/




-- add currrent year no-std questions (from this coding period)
/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
/*****                                                    STEP 000                                                    *****/
/*****                                           BackUp  current Table(s)                                             *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_NoStd' + '_' + @CrDt + ']
                  FROM      [forum].[dbo].[Pew_Question_NoStd]'                      )
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_NoStd]                                         /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Question_pk]  =  ROW_NUMBER()OVER(ORDER BY[Question_abbreviation_std]) /* number all rows                         */
                       + (SELECT MAX([Question_pk]) FROM [Pew_Question_NoStd]) /* add currently max pk from NoStdQuestions*/
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_abbreviation]           =  [Question_abbreviation_std]
      ,[Question_wording]                =  [Question_short_wording_std]
      ,[Question_Year]                   =          1 + (SELECT MAX([Question_Year]) FROM [Pew_Question_NoStd]) /*---2015  */
      ,[Notes]                           =  'January - December '
                                            + CAST((1 + (SELECT MAX([Question_Year]) FROM [Pew_Question_NoStd]))
                                              AS VARCHAR(4))
      ,[Display]                         =  0
      ,[Data_source_fk]                  =  [Data_source_fk]
      ,[Question_Std_fk]                 =  [Question_Std_fk]
FROM
 (
 /*- New added questions --------------------------------------------------------------*/
  SELECT
         [Question_Std_fk]
        =[Question_Std_pk]
        ,[Question_abbreviation_std]
        ,[Question_short_wording_std]
        ,[Data_source_fk] =
         CASE 
         WHEN [Question_abbreviation_std] LIKE 'GRI_20%'   THEN 25
         WHEN [Question_abbreviation_std] LIKE 'GRX_22%'   THEN 27
         WHEN [Question_abbreviation_std] LIKE 'GRX_36%'   THEN 25
         WHEN [Question_abbreviation_std] LIKE 'SHI_04%'   THEN 29
         WHEN [Question_abbreviation_std] LIKE 'SHI_05%'   THEN 29
                                                           ELSE 30
          END
    FROM (
             SELECT TOP 44 *
               FROM [forum].[dbo].[Pew_Question_Std]
           ORDER BY [Question_Std_pk]   DESC                          ) ND
 /*- New added questions --------------------------------------------------------------*/

  UNION

 /*- Former questions not included last year ------------------------------------------*/
  SELECT
         [Question_Std_fk]
        =[Question_Std_pk]
        ,[Question_abbreviation_std]
        ,[Question_short_wording_std]
        ,[Data_source_fk]                =  57
    FROM (
             SELECT *
               FROM [forum].[dbo].[Pew_Question_Std]
              WHERE [Question_abbreviation_std] LIKE 'XSG_S_99_0[4-6]') FD
 /*- Former questions not included last year ------------------------------------------*/

  UNION

 /*- Still-current questions from last year -------------------------------------------*/
  SELECT
         [Question_Std_fk]
        ,[Question_abbreviation_std]
        ,[Question_short_wording_std]
        ,[Data_source_fk]
    FROM (
             SELECT *
               FROM [forum].[dbo].[Pew_Question]
             WHERE
               (    [Question_abbreviation_std] LIKE 'GR%'
                 OR [Question_abbreviation_std] LIKE 'SH%'
                 OR [Question_abbreviation_std] LIKE 'XS%' )
               AND
                    [Question_Year]  =   2014
               AND  /* cluded from last year :                     */
                    [Question_abbreviation_std] NOT LIKE 'GRX_34_0%'
               AND  /* cluded from last year :                     */
                    [Question_abbreviation_std] NOT LIKE 'GRX_35_0%'  ) CD
 /*- Still-current questions from last year -------------------------------------------*/
                                                                            )  NCD
/*------------------------------------------------------------------------------------------------------------------------*/

/**************************************************************************************************************************/
/*****                                                    STEP 004                                                    *****/
/**************************************************************************************************************************/
SELECT * FROM [Pew_Question_NoStd]                                             /* check results in modified table         */
/**************************************************************************************************************************/
/* add to year variables te following toool variables:
GRI_01_filter
GRI_01_yBe
GRI_02_filter
GRI_02_yBe
GRI_19_filter
GRI_19_x
SHI_01_x
SHI_01_summary_b
SHI_04_filter
SHI_04_x
SHI_05_filter
SHI_05_x
XSG_S_99_filter
*/


-- UPDATE SORTING ORDER IN [Pew_Question_Attributes]
/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
/*****                                                    STEP 000                                                    *****/
/*****                                           BackUp  current Table(s)                                             *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Attributes' + '_' + @CrDt + ']
                  FROM      [forum].[dbo].[Pew_Question_Attributes]'                      )
/**************************************************************************************************************************/
--DELETE            FROM      [forum].[dbo].[Pew_Question_Attributes]
--WHERE                                     [attk]                     =  'Access_sort'
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
(                                                                              /* >   Set of Values begins...             */
--
            SELECT [K] =     3, [N] =  '001'
  UNION ALL SELECT [K] =   967, [N] =  '002'
  UNION ALL SELECT [K] =     1, [N] =  '003'
  UNION ALL SELECT [K] =  1037, [N] =  '004'
  UNION ALL SELECT [K] =   968, [N] =  '005'
  UNION ALL SELECT [K] =     7, [N] =  '006'
  UNION ALL SELECT [K] =  1038, [N] =  '007'
  UNION ALL SELECT [K] =     9, [N] =  '008'
  UNION ALL SELECT [K] =    76, [N] =  '009'
  UNION ALL SELECT [K] =    78, [N] =  '010'
  UNION ALL SELECT [K] =    79, [N] =  '011'
  UNION ALL SELECT [K] =    80, [N] =  '012'
  UNION ALL SELECT [K] =    81, [N] =  '013'
  UNION ALL SELECT [K] =    82, [N] =  '014'
  UNION ALL SELECT [K] =    83, [N] =  '015'
  UNION ALL SELECT [K] =    84, [N] =  '016'
  UNION ALL SELECT [K] =    85, [N] =  '017'
  UNION ALL SELECT [K] =    86, [N] =  '018'
  UNION ALL SELECT [K] =    87, [N] =  '019'
  UNION ALL SELECT [K] =   997, [N] =  '020'
  UNION ALL SELECT [K] =    88, [N] =  '021'
  UNION ALL SELECT [K] =   995, [N] =  '022'
  UNION ALL SELECT [K] =   996, [N] =  '023'
  UNION ALL SELECT [K] =    89, [N] =  '024'
  UNION ALL SELECT [K] =    91, [N] =  '025'
  UNION ALL SELECT [K] =  1034, [N] =  '026'
  UNION ALL SELECT [K] =    93, [N] =  '027'
  UNION ALL SELECT [K] =  1035, [N] =  '028'
  UNION ALL SELECT [K] =    95, [N] =  '029'
  UNION ALL SELECT [K] =  1036, [N] =  '030'
  UNION ALL SELECT [K] =   100, [N] =  '031'
  UNION ALL SELECT [K] =    98, [N] =  '032'
  UNION ALL SELECT [K] =   101, [N] =  '033'
  UNION ALL SELECT [K] =   103, [N] =  '034'
  UNION ALL SELECT [K] =    23, [N] =  '035'
  UNION ALL SELECT [K] =    24, [N] =  '036'
  UNION ALL SELECT [K] =    25, [N] =  '037'
  UNION ALL SELECT [K] =    26, [N] =  '038'
  UNION ALL SELECT [K] =    13, [N] =  '039'
  UNION ALL SELECT [K] =    15, [N] =  '040'
  UNION ALL SELECT [K] =    19, [N] =  '041'
  UNION ALL SELECT [K] =   910, [N] =  '042'
  UNION ALL SELECT [K] =    21, [N] =  '043'
  UNION ALL SELECT [K] =    17, [N] =  '044'
  UNION ALL SELECT [K] =    11, [N] =  '045'
  UNION ALL SELECT [K] =    61, [N] =  '046'
  UNION ALL SELECT [K] =    56, [N] =  '047'
  UNION ALL SELECT [K] =    57, [N] =  '048'
  UNION ALL SELECT [K] =    54, [N] =  '049'
  UNION ALL SELECT [K] =    28, [N] =  '050'
  UNION ALL SELECT [K] =    29, [N] =  '051'
  UNION ALL SELECT [K] =    30, [N] =  '052'
  UNION ALL SELECT [K] =    31, [N] =  '053'
  UNION ALL SELECT [K] =    32, [N] =  '054'
  UNION ALL SELECT [K] =    33, [N] =  '055'
  UNION ALL SELECT [K] =    34, [N] =  '056'
  UNION ALL SELECT [K] =    35, [N] =  '057'
  UNION ALL SELECT [K] =    36, [N] =  '058'
  UNION ALL SELECT [K] =    37, [N] =  '059'
  UNION ALL SELECT [K] =    38, [N] =  '060'
  UNION ALL SELECT [K] =    39, [N] =  '061'
  UNION ALL SELECT [K] =    40, [N] =  '062'
  UNION ALL SELECT [K] =    41, [N] =  '063'
  UNION ALL SELECT [K] =    42, [N] =  '064'
  UNION ALL SELECT [K] =    45, [N] =  '065'
  UNION ALL SELECT [K] =    44, [N] =  '066'
  UNION ALL SELECT [K] =   636, [N] =  '067'
  UNION ALL SELECT [K] =    59, [N] =  '068'
  UNION ALL SELECT [K] =    48, [N] =  '069'
  UNION ALL SELECT [K] =    50, [N] =  '070'
  UNION ALL SELECT [K] =    52, [N] =  '071'
  UNION ALL SELECT [K] =   111, [N] =  '072'
  UNION ALL SELECT [K] =   112, [N] =  '073'
  UNION ALL SELECT [K] =   113, [N] =  '074'
  UNION ALL SELECT [K] =   114, [N] =  '075'
  UNION ALL SELECT [K] =   998, [N] =  '076'
  UNION ALL SELECT [K] =   999, [N] =  '077'
  UNION ALL SELECT [K] =  1000, [N] =  '078'
  UNION ALL SELECT [K] =  1001, [N] =  '079'
  UNION ALL SELECT [K] =  1002, [N] =  '080'
  UNION ALL SELECT [K] =   637, [N] =  '081'
  UNION ALL SELECT [K] =   638, [N] =  '082'
  UNION ALL SELECT [K] =   639, [N] =  '083'
  UNION ALL SELECT [K] =   640, [N] =  '084'
  UNION ALL SELECT [K] =   641, [N] =  '085'
  UNION ALL SELECT [K] =   794, [N] =  '086'
  UNION ALL SELECT [K] =   795, [N] =  '087'
  UNION ALL SELECT [K] =   796, [N] =  '088'
  UNION ALL SELECT [K] =  1003, [N] =  '089'
  UNION ALL SELECT [K] =   969, [N] =  '090'
  UNION ALL SELECT [K] =    64, [N] =  '091'
  UNION ALL SELECT [K] =    66, [N] =  '092'
  UNION ALL SELECT [K] =    68, [N] =  '093'
  UNION ALL SELECT [K] =    72, [N] =  '094'
  UNION ALL SELECT [K] =    74, [N] =  '095'
  UNION ALL SELECT [K] =   924, [N] =  '096'
  UNION ALL SELECT [K] =    63, [N] =  '097'
  UNION ALL SELECT [K] =   153, [N] =  '098'
  UNION ALL SELECT [K] =   170, [N] =  '099'
  UNION ALL SELECT [K] =   171, [N] =  '100'
  UNION ALL SELECT [K] =   172, [N] =  '101'
  UNION ALL SELECT [K] =   173, [N] =  '102'
  UNION ALL SELECT [K] =   174, [N] =  '103'
  UNION ALL SELECT [K] =   175, [N] =  '104'
  UNION ALL SELECT [K] =   176, [N] =  '105'
  UNION ALL SELECT [K] =   177, [N] =  '106'
  UNION ALL SELECT [K] =   178, [N] =  '107'
  UNION ALL SELECT [K] =   179, [N] =  '108'
  UNION ALL SELECT [K] =   180, [N] =  '109'
  UNION ALL SELECT [K] =   181, [N] =  '110'
  UNION ALL SELECT [K] =   182, [N] =  '111'
  UNION ALL SELECT [K] =   183, [N] =  '112'
  UNION ALL SELECT [K] =   186, [N] =  '113'
  UNION ALL SELECT [K] =   185, [N] =  '114'
  UNION ALL SELECT [K] =   761, [N] =  '115'
  UNION ALL SELECT [K] =   155, [N] =  '116'
  UNION ALL SELECT [K] =   157, [N] =  '117'
  UNION ALL SELECT [K] =   159, [N] =  '118'
  UNION ALL SELECT [K] =   163, [N] =  '119'
  UNION ALL SELECT [K] =   165, [N] =  '120'
  UNION ALL SELECT [K] =   169, [N] =  '121'
  UNION ALL SELECT [K] =   168, [N] =  '122'
  UNION ALL SELECT [K] =   187, [N] =  '123'
  UNION ALL SELECT [K] =   188, [N] =  '124'
  UNION ALL SELECT [K] =   190, [N] =  '125'
  UNION ALL SELECT [K] =   982, [N] =  '126'
  UNION ALL SELECT [K] =   206, [N] =  '127'
  UNION ALL SELECT [K] =   193, [N] =  '128'
  UNION ALL SELECT [K] =   195, [N] =  '129'
  UNION ALL SELECT [K] =   197, [N] =  '130'
  UNION ALL SELECT [K] =  1004, [N] =  '131'
  UNION ALL SELECT [K] =  1005, [N] =  '132'
  UNION ALL SELECT [K] =   202, [N] =  '133'
  UNION ALL SELECT [K] =   204, [N] =  '134'
  UNION ALL SELECT [K] =  1006, [N] =  '135'
  UNION ALL SELECT [K] =  1007, [N] =  '136'
  UNION ALL SELECT [K] =  1008, [N] =  '137'
  UNION ALL SELECT [K] =  1009, [N] =  '138'
  UNION ALL SELECT [K] =  1010, [N] =  '139'
  UNION ALL SELECT [K] =  1011, [N] =  '140'
  UNION ALL SELECT [K] =  1012, [N] =  '141'
  UNION ALL SELECT [K] =  1013, [N] =  '142'
  UNION ALL SELECT [K] =  1014, [N] =  '143'
  UNION ALL SELECT [K] =  1015, [N] =  '144'
  UNION ALL SELECT [K] =  1016, [N] =  '145'
  UNION ALL SELECT [K] =  1017, [N] =  '146'
  UNION ALL SELECT [K] =  1018, [N] =  '147'
  UNION ALL SELECT [K] =  1019, [N] =  '148'
  UNION ALL SELECT [K] =  1021, [N] =  '149'
  UNION ALL SELECT [K] =  1020, [N] =  '150'
  UNION ALL SELECT [K] =  1022, [N] =  '151'
  UNION ALL SELECT [K] =   965, [N] =  '152'
  UNION ALL SELECT [K] =   192, [N] =  '153'
  UNION ALL SELECT [K] =   983, [N] =  '154'
  UNION ALL SELECT [K] =   210, [N] =  '155'
  UNION ALL SELECT [K] =   212, [N] =  '156'
  UNION ALL SELECT [K] =  1024, [N] =  '157'
  UNION ALL SELECT [K] =  1025, [N] =  '158'
  UNION ALL SELECT [K] =   216, [N] =  '159'
  UNION ALL SELECT [K] =   218, [N] =  '160'
  UNION ALL SELECT [K] =  1023, [N] =  '161'
  UNION ALL SELECT [K] =   966, [N] =  '162'
  UNION ALL SELECT [K] =   207, [N] =  '163'
  UNION ALL SELECT [K] =   220, [N] =  '164'
  UNION ALL SELECT [K] =  1026, [N] =  '165'
  UNION ALL SELECT [K] =   235, [N] =  '166'
  UNION ALL SELECT [K] =  1033, [N] =  '167'
  UNION ALL SELECT [K] =   233, [N] =  '168'
  UNION ALL SELECT [K] =  1032, [N] =  '169'
  UNION ALL SELECT [K] =   224, [N] =  '170'
  UNION ALL SELECT [K] =  1028, [N] =  '171'
  UNION ALL SELECT [K] =   222, [N] =  '172'
  UNION ALL SELECT [K] =  1027, [N] =  '173'
  UNION ALL SELECT [K] =   994, [N] =  '174'
  UNION ALL SELECT [K] =  1031, [N] =  '175'
  UNION ALL SELECT [K] =   987, [N] =  '176'
  UNION ALL SELECT [K] =   912, [N] =  '177'
  UNION ALL SELECT [K] =   986, [N] =  '178'
  UNION ALL SELECT [K] =   226, [N] =  '179'
  UNION ALL SELECT [K] =  1029, [N] =  '180'
  UNION ALL SELECT [K] =   984, [N] =  '181'
  UNION ALL SELECT [K] =   228, [N] =  '182'
  UNION ALL SELECT [K] =  1030, [N] =  '183'
  UNION ALL SELECT [K] =   985, [N] =  '184'
  UNION ALL SELECT [K] =   762, [N] =  '185'
  UNION ALL SELECT [K] =   763, [N] =  '186'
  UNION ALL SELECT [K] =   764, [N] =  '187'
  UNION ALL SELECT [K] =   765, [N] =  '188'
  UNION ALL SELECT [K] =   766, [N] =  '189'
  UNION ALL SELECT [K] =   767, [N] =  '190'
  UNION ALL SELECT [K] =   768, [N] =  '191'
  UNION ALL SELECT [K] =   769, [N] =  '192'
  UNION ALL SELECT [K] =   770, [N] =  '193'
  UNION ALL SELECT [K] =   771, [N] =  '194'
  UNION ALL SELECT [K] =   772, [N] =  '195'
  UNION ALL SELECT [K] =   773, [N] =  '196'
  UNION ALL SELECT [K] =   774, [N] =  '197'
  UNION ALL SELECT [K] =   775, [N] =  '198'
  UNION ALL SELECT [K] =   776, [N] =  '199'
  UNION ALL SELECT [K] =   777, [N] =  '200'
  UNION ALL SELECT [K] =   778, [N] =  '201'
  UNION ALL SELECT [K] =   779, [N] =  '202'
  UNION ALL SELECT [K] =   780, [N] =  '203'
  UNION ALL SELECT [K] =   781, [N] =  '204'
  UNION ALL SELECT [K] =   782, [N] =  '205'
  UNION ALL SELECT [K] =   783, [N] =  '206'
  UNION ALL SELECT [K] =   784, [N] =  '207'
  UNION ALL SELECT [K] =   988, [N] =  '208'
  UNION ALL SELECT [K] =   785, [N] =  '209'
  UNION ALL SELECT [K] =   786, [N] =  '210'
  UNION ALL SELECT [K] =   787, [N] =  '211'
  UNION ALL SELECT [K] =   788, [N] =  '212'
  UNION ALL SELECT [K] =   789, [N] =  '213'
  UNION ALL SELECT [K] =   790, [N] =  '214'
  --
)                                                                              /* <   Set of Values ends!                 */
/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Attributes]                                    /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[N])               /* number all rows                         */
                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_Std_fk]        =  [K]
      ,[attk]                   =  'Access_sort'
      ,[attr]                   =  [N]
/*------------------------------------------------------------------------------------------------------------------------*/
  FROM [NSV]
/*------------------------------------------------------------------------------------------------------------------------*/




/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Attributes]                                    /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[Question_Std_pk]) /* number all rows                         */
                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_Std_fk]        =  [Question_Std_pk]
      ,[attk]                   =  'Access_DESC'
      ,[attr]                   =  '[N]'
/*------------------------------------------------------------------------------------------------------------------------*/
----select *
  FROM
       [forum]..[Pew_Question_Std]                   Q
WHERE
[Question_Std_pk]
IN 
(

1,
3,
7,
9,
11,
13,
15,
17,
19,
21,
23,
28,
48,
50,
52,
54,
56,
57,
59,
61,
64,
66,
68,
72,
74,
76,
89,
91,
93,
95,
98,
100,
101,
111,
112,
113,
114,
153,
155,
157,
159,
163,
165,
187,
190,
193,
195,
197,
202,
204,
206,
210,
212,
216,
218,
220,
222,
224,
226,
228,
233,
235,
638,
639,
640,
641,
785,
786,
787,
788,
789,
790,
794,
795,
796,
912,
982,
994,
995,
996,
1003,
1023,
1037,
1038

)

/*------------------------------------------------------------------------------------------------------------------------*/









/*------------------------------------------------------------------------------------------------------------------------*/
SELECT * FROM     [Pew_Question_Attributes]                                    /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/









/***     >>>>>   This is the script used to create the tables:                                                                        <<<<<     ***/
/***                                                           [GRSHRYYYY].[dbo].[Countries]                                                    ***/
USE              [GRSHRcode]
GO
/**************************************************************************************************************************************************/

/**************************************************************************************************************************/
/***                                                          *************************************************************/
/***     [Countries]                                          *************************************************************/
/***                                                          *************************************************************/
/**************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'Countries'                          ) = 1
DROP              TABLE         [Countries]
/**************************************************************************************************************************/
SELECT 
----------------------------------------------------------------------------------------------------------------------------
        [Nation_fk]
      , [Region5]             = [Region]
      , [Region6]             = [SubRegion6]
      , [Ctry_EditorialName]

----------------------------------------------------------------------------------------------------------------------------
INTO
          [Countries]
----------------------------------------------------------------------------------------------------------------------------
  FROM  
       [forum_ResAnal]..[vr___00a____NationLocalityTOOL]
      ,[forum].        .[Pew_Nation]
----------------------------------------------------------------------------------------------------------------------------
  WHERE
         [Nation_fk]
       = [Nation_pk]
----------------------------------------------------------------------------------------------------------------------------
ORDER BY [Nation_fk]
/**************************************************************************************************************************/
/**************************************************************************************************************************/
SELECT * FROM [GRSHRcode]..[Countries]
/**************************************************************************************************************************/







USE              [GRSHRcode]
GO
/**************************************************************************************************************************************************/
/***                                                          *************************************************************/
/***     [All_Answers]                                        *************************************************************/
/***                                                          *************************************************************/
/**************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'All_Answers'                     ) = 1
DROP              TABLE         [All_Answers]
/**************************************************************************************************************************/
/*****                                                    STEP 000                                                    *****/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
(                                                                              /* >   Set of Values begins...             */
SELECT 
        [Q]               = [Question_abbreviation_std]
      , [V]               = [Answer_value_std]
      , [W]               = [Answer_Wording_std]
      , [N]               = [attr]
FROM
       [forum]..[Pew_Q&A_Std]                   Q
      ,[forum]..[Pew_Question_Attributes]       T
WHERE 
       Q.[Question_Std_fk]
      =T.[Question_Std_fk]
  AND
       T.[attk]
      =  'Access_sort' 

--ORDER BY [attr]
--
)                                                                              /* <   Set of Values ends!                 */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
        [A_row]                      =  ROW_NUMBER()
                                        OVER(ORDER BY [N], [V], [W]   )
/*------------------------------------------------------------------------------------------------------------------------*/
      , [Question_abbreviation_std]  = [Q]
      , [Answer_value]               = [V]
      , [Answer_wording_std]         = [W]
/*------------------------------------------------------------------------------------------------------------------------*/
INTO
          [All_Answers]
/*------------------------------------------------------------------------------------------------------------------------*/
FROM
(
/*------------------------------------------------------------------------------------------------------------------------*/
   SELECT                                                                      /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
             [Q]
           , [V]
           , [W]
           , [N]
     FROM
             NSV
    WHERE NOT (  [V] = 0.00
                AND  (
                          [Q] LIKE 'GRI_11%'
                       OR [Q] LIKE 'GRI_19_filter'
                       OR [Q] LIKE 'GRI_19_[b-f]'
                       OR [Q] LIKE 'SHI_01_a'
                       OR [Q] LIKE 'SHI_01_x_%'
                       OR [Q] LIKE 'SHI_01_[b-f]'
                       OR [Q] LIKE 'SHI_03%'
                       OR [Q] LIKE 'SHI_04_filter'
                       OR [Q] LIKE 'SHI_04_x01'
                       OR [Q] LIKE 'SHI_04_[b-f]'
                       OR [Q] LIKE 'SHI_04_f_x_%'
                       OR [Q] LIKE 'SHI_05_filter'
                       OR [Q] LIKE 'SHI_05_[c-f]'
                       OR [Q] LIKE 'SHI_05_01'
                       OR [Q] LIKE 'SHI_06'
                       OR [Q] LIKE 'SHI_07'
                       OR [Q] LIKE 'SHI_08'
                       OR [Q] LIKE 'SHI_09'
                       OR [Q] LIKE 'SHI_10'
                       OR [Q] LIKE 'SHI_11_[a-b]'
                       OR [Q] LIKE 'SHI_12'
                       OR [Q] LIKE 'SHI_13'
                                                                  ) )
/*------------------------------------------------------------------------------------------------------------------------*/
UNION ALL
/*------------------------------------------------------------------------------------------------------------------------*/
   SELECT                                                                      /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
             [Q]
           , [V]
           , [W] = CASE
                   WHEN [Q] LIKE 'GRI_11'        THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'GRI_11_%'      THEN 'No (and there are no data about this group)'     ----  'No (but there is evidence on this group)'
                   WHEN [Q] LIKE 'GRI_19_filter' THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of cero incidents)'
                   WHEN [Q] LIKE 'GRI_19_[b-f]'  THEN 'No (and there are no data about this incident)'  ----  'No (but there is evidence of cero incidents)'
                   WHEN [Q] LIKE 'SHI_01_a'      THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_01_x_%'    THEN 'No (and there are no data about this group)'     ----  'No (but there is evidence on this group)'
                   WHEN [Q] LIKE 'SHI_01_[b-f]'  THEN 'No (and there are no data about this incident)'  ----  'No (but there is evidence of cero incidents)'
                   WHEN [Q] LIKE 'SHI_03'        THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_04_filter' THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_04_x01'    THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of cero groups)'
                   WHEN [Q] LIKE 'SHI_04_[b-f]'  THEN 'No (and there are no data about this incident)'  ----  'No (but there is evidence of cero incidents)'
                   WHEN [Q] LIKE 'SHI_04_f_x_%'  THEN 'No (and there are no data about this group)'     ----  'No (but there is evidence on this group)'
                   WHEN [Q] LIKE 'SHI_05_filter' THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of cero incidents)'
                   WHEN [Q] LIKE 'SHI_05_[c-f]'  THEN 'No (and there are no data about this incident)'  ----  'No (but there is evidence of cero incidents)'
                   WHEN [Q] LIKE 'SHI_05_01'     THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of cero groups)'
                   WHEN [Q] LIKE 'SHI_06'        THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_07'        THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_08'        THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_09'        THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_10'        THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_11_[a-b]'  THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_12'        THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
                   WHEN [Q] LIKE 'SHI_13'        THEN 'No (and there are no data about this)'           ----  'No (but there is evidence of this)'
             END
           , [N]
     FROM
             NSV
    WHERE       [V] = 0.00
      AND  (
                [Q] LIKE 'GRI_11%'
             OR [Q] LIKE 'GRI_19_filter'
             OR [Q] LIKE 'GRI_19_[b-f]'
             OR [Q] LIKE 'SHI_01_a'
             OR [Q] LIKE 'SHI_01_x_%'
             OR [Q] LIKE 'SHI_01_[b-f]'
             OR [Q] LIKE 'SHI_03%'
             OR [Q] LIKE 'SHI_04_filter'
             OR [Q] LIKE 'SHI_04_x01'
             OR [Q] LIKE 'SHI_04_[b-f]'
             OR [Q] LIKE 'SHI_04_f_x_%'
             OR [Q] LIKE 'SHI_05_filter'
             OR [Q] LIKE 'SHI_05_[c-f]'
             OR [Q] LIKE 'SHI_05_01'
             OR [Q] LIKE 'SHI_06'
             OR [Q] LIKE 'SHI_07'
             OR [Q] LIKE 'SHI_08'
             OR [Q] LIKE 'SHI_09'
             OR [Q] LIKE 'SHI_10'
             OR [Q] LIKE 'SHI_11_[a-b]'
             OR [Q] LIKE 'SHI_12'
             OR [Q] LIKE 'SHI_13'
                                                                  )
/*------------------------------------------------------------------------------------------------------------------------*/
UNION ALL
/*------------------------------------------------------------------------------------------------------------------------*/
   SELECT                                                                      /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
             [Q]
           , [V]
           , [W] = CASE
                   WHEN [Q] LIKE 'GRI_11'        THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'GRI_11_%'      THEN 'No (but there is evidence on this group)'        ----  'No (and there are no data about this group)'
                   WHEN [Q] LIKE 'GRI_19_filter' THEN 'No (but there is evidence of cero incidents)'    ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'GRI_19_[b-f]'  THEN 'No (but there is evidence of cero incidents)'    ----  'No (and there are no data about this incident)'
                   WHEN [Q] LIKE 'SHI_01_a'      THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_01_x_%'    THEN 'No (but there is evidence on this group)'        ----  'No (and there are no data about this group)'
                   WHEN [Q] LIKE 'SHI_01_[b-f]'  THEN 'No (but there is evidence of cero incidents)'    ----  'No (and there are no data about this incident)'
                   WHEN [Q] LIKE 'SHI_03'        THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_04_filter' THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_04_x01'    THEN 'No (but there is evidence of cero groups)'       ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_04_[b-f]'  THEN 'No (but there is evidence of cero incidents)'    ----  'No (and there are no data about this incident)'
                   WHEN [Q] LIKE 'SHI_04_f_x_%'  THEN 'No (but there is evidence on this group)'        ----  'No (and there are no data about this group)'
                   WHEN [Q] LIKE 'SHI_05_filter' THEN 'No (but there is evidence of cero incidents)'    ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_05_[c-f]'  THEN 'No (but there is evidence of cero incidents)'    ----  'No (and there are no data about this incident)'
                   WHEN [Q] LIKE 'SHI_05_01'     THEN 'No (but there is evidence of cero groups)'       ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_06'        THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_07'        THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_08'        THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_09'        THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_10'        THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_11_[a-b]'  THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_12'        THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
                   WHEN [Q] LIKE 'SHI_13'        THEN 'No (but there is evidence of this)'              ----  'No (and there are no data about this)'
             END
           , [N]
     FROM
             NSV
    WHERE       [V] = 0.00
      AND  (
                [Q] LIKE 'GRI_11%'
             OR [Q] LIKE 'GRI_19_filter'
             OR [Q] LIKE 'GRI_19_[b-f]'
             OR [Q] LIKE 'SHI_01_a'
             OR [Q] LIKE 'SHI_01_x_%'
             OR [Q] LIKE 'SHI_01_[b-f]'
             OR [Q] LIKE 'SHI_03%'
             OR [Q] LIKE 'SHI_04_filter'
             OR [Q] LIKE 'SHI_04_x01'
             OR [Q] LIKE 'SHI_04_[b-f]'
             OR [Q] LIKE 'SHI_04_f_x_%'
             OR [Q] LIKE 'SHI_05_filter'
             OR [Q] LIKE 'SHI_05_[c-f]'
             OR [Q] LIKE 'SHI_05_01'
             OR [Q] LIKE 'SHI_06'
             OR [Q] LIKE 'SHI_07'
             OR [Q] LIKE 'SHI_08'
             OR [Q] LIKE 'SHI_09'
             OR [Q] LIKE 'SHI_10'
             OR [Q] LIKE 'SHI_11_[a-b]'
             OR [Q] LIKE 'SHI_12'
             OR [Q] LIKE 'SHI_13'
                                                                  )
/*------------------------------------------------------------------------------------------------------------------------*/
) data
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************************/
SELECT * FROM [GRSHRcode]..[All_Answers]
/**************************************************************************************************************************************************/




/***                                                           [GRSHRYYYY].[dbo].[All_Questions]                                                ***/
/***             (working tables for being used by the Access coding tool)                                                                      ***/
/**************************************************************************************************************************************************/
/***     [All_Questions]                                      *************************************************************/
/***                                                          *************************************************************/
/**************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'All_Questions'                          ) = 1
DROP              TABLE         [All_Questions]
/**************************************************************************************************************************/
















































/***                                                           [GRSHRYYYY].[dbo].[Values]                                                       ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
/*                                                                                                                                                */

/**************************************************************************************************************************/
/***                                                          *************************************************************/
/***     [Values]                                             *************************************************************/
/***                                                          *************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'Values'                          ) = 1
DROP              TABLE         [Values]
/**************************************************************************************************************************/
/**************************************************************************************************************************/
SELECT 
----------------------------------------------------------------------------------------------------------------------------
         DISTINCT
        [V_row]     =  ROW_NUMBER()
                       OVER(ORDER BY  [A_row] )
----------------------------------------------------------------------------------------------------------------------------
      , [VarName] = [Question_abbreviation_std]
      , [Answer]  = STR((
                    CAST([Answer_value] as decimal (4,2))) , 4,2 ) + '   - ' + [Answer_wording_std]
----------------------------------------------------------------------------------------------------------------------------
  INTO
          [Values]
----------------------------------------------------------------------------------------------------------------------------
  FROM 
----------------------------------------------------------------------------------------------------------------------------
         [All_Answers]
----------------------------------------------------------------------------------------------------------------------------
WHERE    [Question_abbreviation_std] IN ( SELECT [Question_abbreviation_std]
                                            FROM [All_Questions]
                                           WHERE [QClass] = 'CODED'           )
/**************************************************************************************************************************/





































/***                                                           [GRSHRYYYY].[dbo].[WT_VNs] WideT: Var Names&Values                               ***/
/***                                                           [GRSHRYYYY].[dbo].[CQ]     Curr Questions to be CODED                            ***/

---- finalmente

/***     >>>>>   This is the script used to create the table view [GRSHRcode].[dbo].[AllLongData]                                     <<<<<     ***/
/***             (extracted data from [forum] and filter fields)                                                                                ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
USE              [GRSHRcode]
GO
/**************************************************************************************************************************************************/

---- NOTES: 
  -- this code should be modified after...
  -- these variables, calculated as persisted during coding period, should be also used in the aggregated data 
  -- currently used from [forum_ResAnal].[dbo].[vr_06w_LongData_ALL] but from final [forum] data once loaded...
  --    [GRI_19_x]
  --    [SHI_04_x]
  --    [SHI_05_x]
  --    [SHI_01_x]
  --    [SHI_01_summary_b]    --- should be rescaled to 1-6 for coding or scaled 1-6 for lookup table?




/**************************************************************************************************************************************************/
IF OBJECT_ID  ('tempdb..#LCD_DB')                        IS NOT NULL
DROP TABLE              #LCD_DB
/**************************************************************************************************************************************************/
/* >   1st long SET: current data in database *****************************************************************************************************/
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
       [entity]
      --,[v_Basic_row]
      --,[ValSource]
      --,[note]
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
      ,[QS_fk]                       = [QSk]
      --,[QAS]
      ,[QA_std]
      ,[QW_std]
      ,[Answer_value]
      ,[answer_wording]
      ,[answer_wording_std]
      ,[Question_fk]
      ,[Answer_fk]
      ,[Notes]
      --,[editable]
      --,[CntWg]
      ,[DB]                          =  1
/**************************************************************************************************************************************************/
INTO      [#LCD_DB]
/**************************************************************************************************************************************************/
FROM
          [forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]             /* NOTICE THIS IS 2014 WORKING DATA => DATA FROM DB AFTER RLS REMOVED*/ 
        , [forum].[dbo].[Pew_Question_Attributes]
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
WHERE 
          [QSk] = [Question_Std_fk]
/* <   1st long SET: current data in database *****************************************************************************************************/



/**************************************************************************************************************************************************/
IF OBJECT_ID  ('tempdb..#LND_CC')                        IS NOT NULL
DROP TABLE              #LND_CC
/**************************************************************************************************************************************************/
/* >   2nd long SET: defaultd and null data  new data to be entered comparable to data in database ************************************************************************/
SELECT 
       [entity]
      --,[v_Basic_row]
      --,[ValSource]
      --,[note]
      ,[link_fk]
      ,[Nation_fk]
      ,[Locality_fk]
      ,[Religion_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]
      ,[Religion]
      ,[Question_Year]               = [Question_Year]
      ,[QS_fk]                       = [Question_Std_fk]
      ,[QA_std]                      = [Question_abbreviation_std]
      ,[QW_std]                      = [Question_wording_std]




      ,[Question_pk]
      ,[Question_abbreviation]
      ,[Question_short_wording_std]
      ,[Question_wording]
      ,
      ,[AnswerSet_num]
      ,[Data_source_fk]
      ,[Editorially_Checked]
      ,[Display]
      ,[Display_NoStd]


      --,[QAS]
      ,[Answer_value]
      ,[answer_wording]
      ,[answer_wording_std]
      ,[Question_fk]
      ,[Answer_fk]                   =  NULL
      ,[Notes]                       = [Notes]
      ,[DB]                          =  0
/**************************************************************************************************************************************************/
INTO      [#LCD_DB]
/**************************************************************************************************************************************************/

SELECT * 
FROM
       ( SELECT * FROM [forum].[dbo].[Pew_Question]
                 WHERE [Question_Year] IS NULL
                    OR [Question_Year] = (SELECT MAX([Question_Year]) 
                                            FROM [forum]..[Pew_Question_NoStd])  )  Q
/*------------------------------------------------------------------------------------------------------------------------*/
INNER
JOIN
/*------------------------------------------------------------------------------------------------------------------------*/
       ( SELECT * FROM [forum].[dbo].[Pew_Question_Attributes]
                 WHERE [attk]          =  'Access_sort'                          )  A
/*------------------------------------------------------------------------------------------------------------------------*/
      ON   A.[Question_Std_fk]
       =   Q.[Question_Std_fk]
        
      ,
      ,[attr]                   =  [N]

       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[N])               /* number all rows                         */
                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_Std_fk]        =  [K]
      ,[attk]                   =  'Access_sort'
      ,[attr]                   =  [N]
       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[N])               /* number all rows                         */
                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_Std_fk]        =  [K]
      ,[attk]                   =  'Access_sort'
      ,[attr]                   =  [N]

INNER 
UNION
                      


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Q_pk]


  FROM [forum].[dbo].[Pew_Question]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Religion_fk]
      ,[Religion]
      ,[QA_std]
      ,[QW_std]
  FROM [forum_ResAnal].[dbo].[vr___00b____QuestnReligionTOOL]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Nation_fk]
      ,[Locality_fk]
      ,[Locality]
  FROM [forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]



SELECT 
          [entity]             = 'Not Yet Stored in DB'
      ,   [link_fk]            = 0
      ,   [Nation_fk]
      ,   [Locality_fk]
      ,   [Religion_fk]
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Locality]
      ,   [Religion]
      ,   [Question_Year]      =  (SELECT  DISTINCT
                                      MAX([Question_Year])
                                     FROM [#LCD_DB]        ) + 1  -- past year + 1
      ,   [QS_fk]
      ,   [QA_std]
      ,   [QW_std]
      ,   [Answer_value]       = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_08_a'
                                        OR [QA_std] LIKE 'GRI_10_0[1-3]'
                                        OR [QA_std] LIKE 'GRI_11_01[a-b]'
                                        OR [QA_std] LIKE 'GRI_11_[0-1][0-9]'
                                        OR [QA_std] LIKE 'GRI_19_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'GRI_20_01x_01[a-b]'
                                        OR [QA_std] LIKE 'GRI_20_01x_[0-1][0-9]'
--                                      OR [QA_std] LIKE 'GRI_0[1-2]_filter'
--                                      OR [QA_std] LIKE 'GRX_34_02_[a-g]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                        OR [QA_std] LIKE 'SHI_01_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_01_x_01[a-b]'
                                        OR [QA_std] LIKE 'SHI_01_x_[0-1][0-9]'
                                        OR [QA_std] LIKE 'SHI_04_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_05_[c-f&x]'                  -- no x
--                                      OR [QA_std] LIKE 'SHI_09_n'
--                                      OR [QA_std] LIKE 'SHI_10_n'
--                                      OR [QA_std] LIKE 'SHI_11_[a-b]_n'
                                        OR [QA_std] LIKE 'XSG_S_99_0[1-6]'                 -- NEW ROW/STATEMENT
                                      THEN 0.00
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRX_29_0[2-5]'
                                      THEN 1.00
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      ELSE NULL
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [answer_wording]     = ''
      ,   [answer_wording_std] = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_08_a'
                                        OR [QA_std] LIKE 'GRI_10_0[1-3]'
                                        OR [QA_std] LIKE 'GRI_11_01[a-b]'
                                        OR [QA_std] LIKE 'GRI_11_[0-1][0-9]'
                                        OR [QA_std] LIKE 'GRI_20_01x_01[a-b]' 
                                        OR [QA_std] LIKE 'GRI_20_01x_[0-1][0-9]'
--                                      OR [QA_std] LIKE 'GRI_0[1-2]_filter'
--                                      OR [QA_std] LIKE 'GRX_34_02_[a-g]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                        OR [QA_std] LIKE 'SHI_01_x_01[a-b]'
                                        OR [QA_std] LIKE 'SHI_01_x_[0-1][0-9]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                        OR [QA_std] LIKE 'GRX_29_0[2-5]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN 'No'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_19_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_01_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_04_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_05_[c-f&x]'                  -- no x
--                                       OR [QA_std] LIKE 'SHI_09_n'
--                                       OR [QA_std] LIKE 'SHI_10_n'
--                                       OR [QA_std] LIKE 'SHI_11_[a-b]_n'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN '0 to N incidents'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'XSG_S_99_0[1-6]'                 -- NEW ROW/STATEMENT
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN 'No supplemental source'                        -- ADD AS a new STANDARD ANSWER
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      ELSE ''
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [Question_fk]        = 0
      ,   [Answer_fk]          = 0
      ,   [Notes]              = ''
      ,   [DB]                 =  1
/**************************************************************************************************************************************************/
INTO      [#LND_CC]
/**************************************************************************************************************************************************/
FROM      [#LCD_DB]

/**************************************************************************************************************************************************/




WHERE
          [Question_Year] =  (SELECT  DISTINCT
                                 MAX([Question_Year])
                                FROM [#LCD_DB]                   )  -- included questions for past year
/* <   2nd long SET: new data to be entered comparable to data in database ************************************************************************/



/**************************************************************************************************************************************************/
IF OBJECT_ID  ('tempdb..#LYD_CC')                        IS NOT NULL
DROP TABLE              #LYD_CC
/**************************************************************************************************************************************************/
/* >   3rd long SET: former year's data to be used if necessary in GRI_01 & GRI_02 ****************************************************************/
SELECT
          [entity]             = ''
      ,   [link_fk]            = 0
      ,   [Nation_fk]
      ,   [Locality_fk]
      ,   [Religion_fk]
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Locality]
      ,   [Religion]
      ,   [Question_Year]       = [Question_Year] + 1                      -- past year + 1
      ,   [QS_fk]
      ,   [QA_std]             = [QA_std]        + '_yBe'
      ,   [QW_std]             = [QW_std]        + ' (*the prevoius year)'
      ,   [Answer_value]
      ,   [answer_wording]
      ,   [answer_wording_std]
      ,   [Question_fk]        = 0
      ,   [Answer_fk]          = 0
      ,   [Notes]              = ''
      ,   [DB]                 =  -1
/**************************************************************************************************************************************************/
INTO      [#LYD_CC]
/**************************************************************************************************************************************************/
FROM      [#LCD_DB]
/**************************************************************************************************************************************************/
WHERE
          [Question_Year] =  (SELECT  DISTINCT
                                 MAX([Question_Year])
                                FROM [#LCD_DB]                   )  -- included questions for past year
      AND
          [QA_std]              LIKE 'GRI_0[1-2]'
/* <   3rd long SET: former year's data to be used if necessary in GRI_01 & GRI_02 ****************************************************************/



/**************************************************************************************************************************************************/
IF OBJECT_ID  ('tempdb..#LND_NQ')                        IS NOT NULL
DROP TABLE              #LND_NQ
/**************************************************************************************************************************************************/
/* >   4th long SET: new data to be entered from added questions **********************************************************************************/
SELECT 
          [entity]             = 'Not Yet Stored in DB'
      ,   [link_fk]            = 0
      ,   [Nation_fk]
      ,   [Locality_fk]        = NULL
      ,   [Religion_fk]        = NULL
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Locality]           = 'not detailed'
      ,   [Religion]           = 'not detailed'
      ,   [Question_Year]
      ,   [QS_fk]              = 0
      ,   [QA_std]
      ,   [QW_std]
      ,   [Answer_value]       = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_0[1-2]_filter'
--                                      OR [QA_std] LIKE 'GRI_08_a'
--                                      OR [QA_std] LIKE 'GRI_10_0[1-3]'
--                                      OR [QA_std] LIKE 'GRI_11_01[a-b]'
--                                      OR [QA_std] LIKE 'GRI_11_[0-1][0-9]'
--                                      OR [QA_std] LIKE 'GRI_19_[b-f&x]'
--                                      OR [QA_std] LIKE 'GRI_20_01x_01[a-b]'
--                                      OR [QA_std] LIKE 'GRI_20_01x_[0-1][0-9]'
                                        OR [QA_std] LIKE 'GRX_34_02_[a-g]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                        OR [QA_std] LIKE 'SHI_01_[b-f&x]'            --  x
--                                      OR [QA_std] LIKE 'SHI_01_x_01[a-b]'
--                                      OR [QA_std] LIKE 'SHI_01_x_[0-1][0-9]'
                                        OR [QA_std] LIKE 'SHI_04_[b-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_05_[c-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_09_n'
                                        OR [QA_std] LIKE 'SHI_10_n'
                                        OR [QA_std] LIKE 'SHI_11_[a-b]_n'
                                      THEN 0.00
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--                                    WHEN [QA_std] LIKE 'GRX_29_0[2-5]'
--                                    THEN 1.00
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      ELSE NULL
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [answer_wording]     = ''
      ,   [answer_wording_std] = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_0[1-2]_filter'
--                                      OR [QA_std] LIKE 'GRI_08_a'
--                                      OR [QA_std] LIKE 'GRI_10_0[1-3]'
--                                      OR [QA_std] LIKE 'GRI_11_01[a-b]'
--                                      OR [QA_std] LIKE 'GRI_11_[0-1][0-9]'
--                                      OR [QA_std] LIKE 'GRI_19_[b-f&x]'
--                                      OR [QA_std] LIKE 'GRI_20_01x_01[a-b]'
--                                      OR [QA_std] LIKE 'GRI_20_01x_[0-1][0-9]'
                                        OR [QA_std] LIKE 'GRX_34_02_[a-g]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--                                      OR [QA_std] LIKE 'SHI_01_x_01[a-b]'
--                                      OR [QA_std] LIKE 'SHI_01_x_[0-1][0-9]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--                                      OR [QA_std] LIKE 'GRX_29_0[2-5]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN 'No'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'SHI_01_[b-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_04_[b-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_05_[c-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_09_n'
                                        OR [QA_std] LIKE 'SHI_10_n'
                                        OR [QA_std] LIKE 'SHI_11_[a-b]_n'
--                                      OR [QA_std] LIKE 'GRI_19_[b-f]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN '0 to N incidents'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      ELSE ''
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [Question_fk]        = 0
      ,   [Answer_fk]          = 0
      ,   [Notes]              = ''
      ,   [DB]                 = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE '%_filter'
                                      THEN -1
                                      ELSE 0
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************************/
INTO      [#LND_NQ]
/**************************************************************************************************************************************************/
FROM
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
(SELECT 
          DISTINCT
          [Nation_fk]
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Question_Year]
                                 FROM      [#LYD_CC]               )  LYD
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
  CROSS JOIN 
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
(
/*--- filter questions ---------------------------------------------------------------------------------------------------------------------------*/
           SELECT QA_std = 'GRI_01_filter'    , QW_std =  '(If GRI_01_x is "yes") Did the change in the constitution alter any statement '
                                                        + 'of specific provision "freedom of religion"?'
 UNION ALL SELECT QA_std = 'GRI_02_filter'    , QW_std =  '(If GRI_01_x is "yes") Did the change in the constitution alter any '
                                                        + 'stipulation that appears to qualify or substantially contradict the concept '
                                                        + 'of "religious freedom"'
 UNION ALL SELECT QA_std = 'GRI_19_filter'    , QW_std =  'Were there incidents when any level of government use force toward religious '
                                                        + 'groups that resulted in individuals being killed, physically abused, '
                                                        + 'imprisoned, detained or displaced from their homes, or having their personal '
                                                        + 'or religious properties damaged or destroyed?'
 UNION ALL SELECT QA_std = 'SHI_04_filter'    , QW_std =  'Were religion-related terrorist groups active in the country?'
 UNION ALL SELECT QA_std = 'SHI_05_filter'    , QW_std =  'Was there a religion-related war or armed conflict in the country (including '
                                                        + 'ongoing displacements from previous wars)?'
 UNION ALL SELECT QA_std = 'XSG_S_99_filter'  , QW_std =  'How many supplemental sources have been used?'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*--- persisted questions ------------------------------------------------------------------------------------------------------------------------*/
-- UNION ALL SELECT QA_std = 'GRI_19_x'         , QW_std = '0 - Total N of incidents resulting from government force'
   /* already there... should others be there? */
 UNION ALL SELECT QA_std = 'SHI_01_x'         , QW_std = '0 - Total N of incidents motivated by religious hatred or bias'
 UNION ALL SELECT QA_std = 'SHI_01_summary_b' , QW_std = '0-6 Types of incidents motivated by religious hatred or bias'
 UNION ALL SELECT QA_std = 'SHI_04_x'         , QW_std = '0 - Total N of incidents resulting from religion related terrorism'
 UNION ALL SELECT QA_std = 'SHI_05_x'         , QW_std = '0 - Total N of incidents resulting from religiously-related war'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*--- NEW questions ------------------------------------------------------------------------------------------------------------------------------*/
 UNION ALL SELECT QA_std = 'GRX_34_01'         , QW_std =  'Does the government provide exemptions for religious groups from otherwise '
                                                        + 'universal laws?'
 UNION ALL SELECT QA_std = 'GRX_34_02'        , QW_std =  'If so, what areas do the exemptions cover? (check all that apply)'
 UNION ALL SELECT QA_std = 'GRX_34_02_a'      , QW_std =  'Work on religious holidays (for example, Christians being allowed to take off work '
                                                        + 'on Sundays)'
 UNION ALL SELECT QA_std = 'GRX_34_02_b'      , QW_std =  'Anti-discrimination laws (for example, giving religious business the right to not '
                                                        + 'serve or provide benefits to same-sex couples)'
 UNION ALL SELECT QA_std = 'GRX_34_02_c'      , QW_std =  'Military service (for example, allowing religious groups that oppose war or national '
                                                        + 'service to not participate in military training or activities)'
 UNION ALL SELECT QA_std = 'GRX_34_02_d'      , QW_std =  'Taxes (for example, allowing religious groups opposed to supporting states to not'
                                                        + ' pay taxes)'
 UNION ALL SELECT QA_std = 'GRX_34_02_e'      , QW_std =  'Health care provision (for example, allowing doctors to opt out of providing '
                                                        + 'contraception or abortion services, or allowing religious organizations to exclude '
                                                        + 'contraception of abortion services from health insurance coverage)'
 UNION ALL SELECT QA_std = 'GRX_34_02_f'      , QW_std =  'Education (for example, sending children to public schools)'
 UNION ALL SELECT QA_std = 'GRX_34_02_g'      , QW_std =  'Unknown (the sources indicate religious groups are granted exemptions, but provide '
                                                        + 'no details)'
 UNION ALL SELECT QA_std = 'GRX_34_03'        , QW_std =  'Were there any cases in which individuals challenged the lack of religious'
                                                        + ' exemptions from otherwise universal laws?'
 UNION ALL SELECT QA_std = 'GRX_35'           , QW_std =  'Does the government restrict individuals'' access to the internet?'
 UNION ALL SELECT QA_std = 'GRX_35_01'        , QW_std =  'Does the government restrict individuals'' access to the internet through arrests based'
                                                        + ' on internet activity?'
 UNION ALL SELECT QA_std = 'GRX_35_02'        , QW_std =  'Does the government restrict individuals'' access to the internet through censoring '
                                                        + 'of websites?'
 UNION ALL SELECT QA_std = 'SHI_09_n'         , QW_std =  'How many incidents in which individuals used violence or the threat of violence'
                                                        + '—including so-called honor killings—to try to enforce religious norms were directed'
                                                        + ' against women?'
 UNION ALL SELECT QA_std = 'SHI_10_n'         , QW_std =  'How many incidents in which individuals were assaulted or displaced from their '
                                                        + 'homes in retaliation for religious activities considered offensive or threatening '
                                                        + 'to the majority faith were directed against women?'
 UNION ALL SELECT QA_std = 'SHI_11_a_n'       , QW_std =  'How many incidents occurred in which women were harassed for violating secular '
                                                        + 'dress norms?'
 UNION ALL SELECT QA_std = 'SHI_11_b_n'       , QW_std =  'How many incidents occurred in which women were harassed for violating religious '
                                                        + 'dress codes?'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
)                                                                                                                                                 Q
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/* <   4th long SET: new data to be entered from added questions **********************************************************************************/




/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'AllLongData'                      ) = 1
DROP              TABLE         [AllLongData]
/***  All Long Data *******************************************************************************************************************************/
SELECT
          [entity]
      ,   [link_fk]
      ,   [Nation_fk]
      ,   [Locality_fk]
      ,   [Religion_fk]
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Locality]
      ,   [Religion]
      ,   [Question_Year]
      ,   [QS_fk]
      ,   [QA_std]
      ,   [QW_std]
      ,   [Answer_value]
      ,   [answer_wording]     = CASE WHEN [answer_wording] = ''
                                      THEN NULL
                                      ELSE [answer_wording]
                                 END
      ,   [answer_wording_std] = CASE WHEN [answer_wording_std] = ''
                                      THEN NULL 
                                      ELSE [answer_wording_std]
                                 END
      ,   [Question_fk]
      ,   [Answer_fk]
      ,   [Notes]
      ,   [DB]
/**************************************************************************************************************************************************/
INTO    [AllLongData]
/**************************************************************************************************************************************************/
FROM
/**************************************************************************************************************************************************/
  (
          SELECT * FROM [#LCD_DB]
    UNION SELECT * FROM [#LND_CC]
    UNION SELECT * FROM [#LYD_CC]
    UNION SELECT * FROM [#LND_NQ]
                                   ) THE4SETS

/**************************************************************************************************************************************************/
/***  All Long Data *******************************************************************************************************************************/
/**************************************************************************************************************************************************/
GO


-- select * from [AllLongData]



