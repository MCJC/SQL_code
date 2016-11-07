/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 1.000    ---------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     Each year we start by updating tables in the main database [forum] in order to include changes for such a coding period                             ***/
/***                                                                                                                                                         ***/
/***     We should know in advance about new questions to be added: such questions involve changes in:                                                       ***/
/***        --      [forum].[dbo].[Pew_Answer_Std]                                                                                                           ***/
/***        --      [forum].[dbo].[Pew_Question_Std]                                                                                                         ***/
/***     We should also know about questions to be removed from the former year; the new list should be addd to:                                             ***/
/***        --      [forum].[dbo].[Pew_Question_NoStd]                                                                                                       ***/
/***                                                                                                                                                         ***/
/***     Once the former tables have been updated, we should also update--if necesssary--the corrsponding references in:                                     ***/
/***        --      [forum].[dbo].[Pew_Question_Attributes]                                                                                                  ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/

--                                                          NOTE:
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
XSG_S_99_filter*/
/* 2015-data coding period: */
--SHI_04_d_x_1_n
--SHI_04_d_x_2_n
--SHI_05_d_x_1_n
--SHI_05_d_x_2_n




-----hhhhhhhhhhhhhhhhhhhhhhhhhhhhh
--- NOT REPLICABLE
--   should we finally add [QA_std] LIKE 'GRI_0[1-2]_yBe'
--
-- ad std questions fom this coding period
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--/*****                                                    STEP 000                                                    *****/
--/*****                                           BackUp  current Table(s)                                             *****/
--/**************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
--/*------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Std' + '_' + @CrDt + 'b]
--                  FROM      [forum].[dbo].[Pew_Question_Std]'                      )
--/**************************************************************************************************************************/
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Std]                                           /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Question_Std_pk]            =    ROW_NUMBER()OVER(
--                                         ORDER BY[Question_Std_pk])            /* number all rows                         */
--                                      + (SELECT MAX([Question_Std_pk])         /* add currently max pk                    */
--                                           FROM [Pew_Question_Std])            /* from StdQuestions                       */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Question_abbreviation_std]  =   [Question_abbreviation_std] + '_yBe'
--      ,[Question_wording_std]       =   [Question_abbreviation_std] + 'from past year - (BkUp vaue)'
--      ,[Question_short_wording_std] =   [Question_abbreviation_std] + 'from past year - (BkUp vaue)'
--      ,[Display]                    =   0
--      ,[AnswerSet_num]              =   [AnswerSet_num]
--      ,[Editorially_Checked]        = 'NO!'                                    /* label as not editorially checked        */
--  FROM [forum].[dbo].[Pew_Question_Std]
--WHERE [Question_abbreviation_std] LIKE 'GRI_0[1-2]'
--/**************************************************************************************************************************/
--SELECT * FROM [Pew_Question_Std]                                               /* check results in modified table         */
--/**************************************************************************************************************************/
--
--
--
--
--
--
-- ADD STD ANSWERS
--
--/**************************************************************************************************************************/
--/*****                                              BackUp current Table                                              *****/
--/**************************************************************************************************************************/
--  USE [forum]                                                                  /* use final database                      */
--GO
--/**************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)                                                 /* declare variable to store current date  */
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                          /* store date in format YYYYMMDD           */
--/*------------------------------------------------------------------------------------------------------------------------*/
--EXEC                                                                           /* exec statement to run string s script   */
--     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Answer_Std_' + @CrDt + ']
--                  FROM     [forum].[dbo].[Pew_Answer_Std]'               )     /* select into backup from current table   */
--/**************************************************************************************************************************/
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
--(                                                                              /* >   Set of Values begins...             */
--
--        SELECT N =  1, V =  0.00 , W = 'No official or favored religion(s), and the state attempts to strictly control religion'
--  UNION SELECT N =  1, V =  0.33 , W = 'No official religion, and there is separation of church and state'
--  UNION SELECT N =  1, V =  0.67 , W = 'State has a preferred or approved religion(s)'
--  UNION SELECT N =  1, V =  1.00 , W = 'State recognizes one official religion'
--
--  UNION SELECT N =  2, V =  0.00 , W = 'There is no official religion.'
--  UNION SELECT N =  2, V =  0.25 , W = 'The official religion is not mandatory, and it receives more or less the same benefits as other religions.'
--  UNION SELECT N =  2, V =  0.50 , W = 'The official religion is not mandatory, but the state regulates other religious groups and the official religion receives more benefits than other religions.'
--  UNION SELECT N =  2, V =  0.75 , W = 'The official religion is not mandatory, but the state creates a hostile environment for other religions.'
--  UNION SELECT N =  2, V =  1.00 , W = 'The official religion is mandatory for all citizens.'
--
--  UNION SELECT N =  3, V =  0.00 , W = 'No.'
--  UNION SELECT N =  3, V =  0.50 , W = 'Yes, but involvement was limited to providing weapons or financial support.'
--  UNION SELECT N =  3, V =  1.00 , W = 'Yes, and involvement included troops.'
----
--  UNION SELECT N =  4, V =  0.00 , W = 'No.'
--  UNION SELECT N =  4, V =  0.50 , W = 'Yes, but but not only for the official/preferred religion.'
--  UNION SELECT N =  4, V =  1.00 , W = 'Yes, and disproportionately benefits the official/preferred religion.'
--
--)                                                                              /* <   Set of Values ends!                 */
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	               [Pew_Answer_Std]                                            /* table in working database               */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Answer_Std_pk]          =   (ROW_NUMBER ()                             /* number all rows                         */
--                                           OVER (ORDER BY [N], [V] ))          /* sorted by answer set number & value     */
--                                  + (SELECT MAX([Answer_Std_pk])               /* add currently max pk                    */
--                                       FROM     [Pew_Answer_Std]               /* from Std Answers                        */
--                                      WHERE     [Answer_Std_pk] < 999990)      /* excluding Un-Coded Numeric/Count vals   */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[AnswerSet_number]       =   [N]                                        /* conventional answer set number          */
--                                  + (SELECT MAX([AnswerSet_number])            /* add currently max answer set number     */
--                                       FROM     [Pew_Answer_Std]               /* from Std Answers                        */
--                                      WHERE     [AnswerSet_number] < 999990)   /* excluding Un-Coded Numeric/Count vals   */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Answer_value_std]       =   [V]                                        /* conventional answer standard value      */
--      ,[Answer_Wording_std]     =   [W]                                        /* conventional answer standard wording    */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Full_set_of_Answers]    =   [A]                                        /* nested set of values & wordings by set  */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[NA_by_set_of_Answers]   =   [X]                                        /* count of values by answer set number    */
--/*------------------------------------------------------------------------------------------------------------------------*/
--FROM
--/*------------------------------------------------------------------------------------------------------------------------*/
--        [NSV]                                                     AS SetVs     /* main reference to CTE (New Set of Vals) */
--/*------------------------------------------------------------------------------------------------------------------------*/
-- JOIN
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ( SELECT                                                                 /* sub-query for nested & aggegated values */
--               [r] = [N]                                                       /* answer set number - join to main query  */
--              ,[X] = COUNT(*)                                                  /* aggregate by counting rows              */
--              ,[A] = STUFF(                                                    /* begin stuffing procedure...             */
--                           ( SELECT '   ||'                                    /* begin selection into XML nested cell(s) */
--                                  + STR(S2.[V], 7,2 )                          /* add value as string...                  */
--                                  + ': '                                       /* concatenate using colon...              */
--                                  +        [W]                                 /* to the corresponding wording            */
--                              FROM         [NSV]          S2                   /* secondary reference to CTE in sub-query */
--                             WHERE      S1.[N]                                 /* correspondence on main CTE reference... */
--                                      = S2.[N]                                 /* to secondary reference in sub-query     */
--                          ORDER BY      S1.[N]                                 /* sorting order by answer set number      */
--                          FOR XML PATH('') )                                   /* nest in one XML string cell             */
--                                            , 1, 8, '')                        /* end stuffing proced. by dropping chars  */
--          FROM     [NSV]                                  S1                   /* main reference to CTE in sub-query      */
--          GROUP BY [N]                                        )   AS nstdV     /* aggregate values & alias of sub-query   */
--/*------------------------------------------------------------------------------------------------------------------------*/
--ON         SetVs.[N]  =   nstdV.[r]                                            /* joint b/w main ref to CTE & sub-query   */
--/*------------------------------------------------------------------------------------------------------------------------*/
--/**************************************************************************************************************************/
--
--/**************************************************************************************************************************/
--/*****                                                    STEP 002                                                    *****/
--/**************************************************************************************************************************/
--SELECT * FROM [Pew_Answer_Std]                                                 /* check results in modified table         */
--/**************************************************************************************************************************/
--
-- ad std questions fom this coding period
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--/*****                                                    STEP 000                                                    *****/
--/*****                                           BackUp  current Table(s)                                             *****/
--/**************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
--/*------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Std' + '_' + @CrDt + ']
--                  FROM      [forum].[dbo].[Pew_Question_Std]'                      )
--/**************************************************************************************************************************/
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
--(                                                                              /* >   Set of Values begins...             */
--
--        SELECT N =     47, Q = 'GRI_20_01x_11'     , W = 'Is atheism recognized as a favored religioous perspective by the constitution or law that functions in the place of constitution?'
--  UNION SELECT N =    242, Q = 'GRI_20_01_x_01'    , W = 'What is the relationship between religion and the state?'
--  UNION SELECT N =    243, Q = 'GRI_20_01_x_02'    , W = 'If the state has one official religion, which best characterizes the religion-state relationship?'
--  UNION SELECT N =     25, Q = 'GRX_22_x'          , W = 'Does any level of government penalize the defamation of religion, including penalizing such things as blasphemy, apostasy, and criticisms or critiques of the official or preferred state religion specifically? '
--  UNION SELECT N =     25, Q = 'GRX_22_x_01'       , W = 'Does any level of government penalize blasphemy about the official or preferred state religion specifically?'
--  UNION SELECT N =     25, Q = 'GRX_22_x_02'       , W = 'Does any level of government penalize apostasy from the official or preferred state religion specifically?'
--  UNION SELECT N =     25, Q = 'GRX_22_x_03'       , W = 'Does any level of government penalize hate speech about the the official or preferred state religion specifically?'
--  UNION SELECT N =     25, Q = 'GRX_22_x_04'       , W = 'Does any level of government penalize criticism or critiques of the the official or preferred state religion specifically?'
--  UNION SELECT N =     47, Q = 'GRX_36'            , W = 'Does the government provide exemptions for religious groups from military service?'
--  UNION SELECT N = 999999, Q = 'SHI_04_d_x_1'      , W = 'Count for SHI_04_d_x_1: Displaced from their homes (code displacements from previous reporting periods only for citizens or permanent residents)  - NOTE: REPORT NUMBER FROM UNHCR DATASET'
--  UNION SELECT N = 999999, Q = 'SHI_04_d_x_2'      , W = 'Count for SHI_04_d_x_2: Displaced from their homes (code displacements from previous reporting periods only for citizens or permanent residents)  - NOTE: REPORT NUMBER FROM IDMC DATASET'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_01a'    , W = 'Were Orthodox Christians physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_01b'    , W = 'Were Catholics physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_02'     , W = 'Were Protestants or Anglicans physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_03'     , W = 'Were Christians (unspecified) physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_04'     , W = 'Were Sunni Muslims physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_05'     , W = 'Were Shia Muslims physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_06'     , W = 'Were Muslims (unspecified) physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_07'     , W = 'Were Buddhists physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_08'     , W = 'Were Hindus physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_09'     , W = 'Were Jews physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_10'     , W = 'Were Scientologists, Baha''is or followers of other "new" religions physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_11'     , W = 'Were Mormons, Jehovah''s Witnesses or other schismatic Christian sects physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_12'     , W = 'Were Ahmadiyya, Druze or other schismatic Muslim sects physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_13'     , W = 'Were followers of ethnic or tribal religions physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_16'     , W = 'Were Zoroastrians physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_15'     , W = 'Were Sikhs physically abused due to religion-related terrorism?'
--  UNION SELECT N =     47, Q = 'SHI_04_f_x_17'     , W = 'Were atheists physically abused due to religion-related terrorism?'
--  UNION SELECT N = 999999, Q = 'SHI_05_d_x_1'      , W = 'Count for SHI_05_d_x_1: Displaced from their homes (includes those deported or denied entry or return; code displacements from previous reporting periods only for citizens or permanent residents) (total of next two) and/or personal or religious properties damaged or destroyed (includes property defaced, confiscated, closed or raided) - NOTE: REPORT NUMBER FROM UNHCR DATASET'
--  UNION SELECT N = 999999, Q = 'SHI_05_d_x_2'      , W = 'Count for SHI_05_d_x_2: Displaced from their homes (includes those deported or denied entry or return; code displacements from previous reporting periods only for citizens or permanent residents) (total of next two) and/or personal or religious properties damaged or destroyed (includes property defaced, confiscated, closed or raided) - NOTE: REPORT NUMBER FROM IDMC DATASET'
--  UNION SELECT N =    244, Q = 'SHI_05_01'         , W = 'Was the government involved in a religion-related war in another country?'
--  UNION SELECT N =     47, Q = 'SHI_06_01'         , W = 'Did the score for SHI_06 this question depend solely on information from the two IRF reports before this year''s repport?'
--  UNION SELECT N =     47, Q = 'SHI_13_01'         , W = 'Did the score for SHI_13 this question depend solely on information from the two IRF reports before this year''s repport?'
--  UNION SELECT N =     47, Q = 'SHI_12_01'         , W = 'Did the score for SHI_12 this question depend solely on information from the two IRF reports before this year''s repport?'
--  UNION SELECT N =     47, Q = 'SHI_08_01'         , W = 'Did the score for SHI_08 this question depend solely on information from the two IRF reports before this year''s repport?'
--  UNION SELECT N =     47, Q = 'SHI_07_01'         , W = 'Did the score for SHI_07 this question depend solely on information from the two IRF reports before this year''s repport?'
--  UNION SELECT N =     47, Q = 'SHI_11_b_01'       , W = 'Did the score for SHI_11_b this question depend solely on information from the two IRF reports before this year''s repport?'
--  UNION SELECT N =     47, Q = 'SHI_09_01'         , W = 'Did the score for SHI_09 this question depend solely on information from the two IRF reports before this year''s repport?'
--  UNION SELECT N =     47, Q = 'SHI_10_01'         , W = 'Did the score for SHI_10 this question depend solely on information from the two IRF reports before this year''s repport?'
--
--)                                                                              /* <   Set of Values ends!                 */
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Std]                                           /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Question_Std_pk]            =    ROW_NUMBER () OVER(ORDER BY [Q] )     /* number all rows                         */
--                                      + (SELECT MAX([Question_Std_pk])         /* add currently max pk                    */
--                                           FROM [Pew_Question_Std])            /* from StdQuestions                       */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Question_abbreviation_std]  = [Q]
--      ,[Question_wording_std]       = [W]
--      ,[Question_short_wording_std] = [W]
--      ,[Display]                    = 0                                        /* set display to zero (provisionally)     */
--	  ,[AnswerSet_num]              = [N]                                      /*                                         */
--      ,[Editorially_Checked]        = 'NO!'                                    /* label as not editorially checked        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--FROM
--/*------------------------------------------------------------------------------------------------------------------------*/
--        [NSV]                                                     AS SetVs     /* main reference to CTE (New Set of Vals) */
--/*------------------------------------------------------------------------------------------------------------------------*/
--
--/**************************************************************************************************************************/
--/*****                                                    STEP 004                                                    *****/
--/**************************************************************************************************************************/
--SELECT * FROM [Pew_Question_Std]                                               /* check results in modified table         */
--/**************************************************************************************************************************/
--
--
-- clone some new std questions fom this coding period
--/**************************************************************************************************************************/
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
--(                                                                              /* >   Set of Values begins...             */
--
--  SELECT N = 245
--        ,Q = 'GRI_20_03_a_xx' 
--        ,L = 'Does any level of government provide funds or other resources for religious education programs and/or religious schools?'
--        ,S ='Does the government provide funds or resources for religious education or religious schools?'
--UNION
--  SELECT N = 245
--        ,Q = 'GRI_20_03_b_xx' 
--        ,L = 'Does any level of government provide funds or other resources for religious property (e.g., buildings, upkeep, repair or land)?'
--        ,S = 'Does the government provide funds or resources for religious property?'
--UNION
--  SELECT N = 245
--        ,Q = 'GRI_20_03_c_xx' 
--        ,L = 'Does any level of government provide funds or other resources for religious activities other than education or property?'
--        ,S = 'Does the government provide funds or resources for religious activities other than education or property?'
--
--)                                                                              /* <   Set of Values ends!                 */
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Std]                                           /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Question_Std_pk]            =    ROW_NUMBER () OVER(ORDER BY [Q] )     /* number all rows                         */
--                                      + (SELECT MAX([Question_Std_pk])         /* add currently max pk                    */
--                                           FROM [Pew_Question_Std])            /* from StdQuestions                       */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Question_abbreviation_std]  = [Q]
--      ,[Question_wording_std]       = [L]
--      ,[Question_short_wording_std] = [S]
--      ,[Display]                    = 0                                        /* set display to zero (provisionally)     */
--	  ,[AnswerSet_num]              = [N]                                      /*                                         */
--      ,[Editorially_Checked]        = 'NO!'                                    /* label as not editorially checked        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--FROM
--/*------------------------------------------------------------------------------------------------------------------------*/
--        [NSV]                                                     AS SetVs     /* main reference to CTE (New Set of Vals) */
--/*------------------------------------------------------------------------------------------------------------------------*/
--
--/**************************************************************************************************************************/
--/*****                                                    STEP 004                                                    *****/
--/**************************************************************************************************************************/
--SELECT * FROM [Pew_Question_Std]                                               /* check results in modified table         */
--/**************************************************************************************************************************/
--
--
--
--
-- add currrent year no-std questions (from this coding period)
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--/*****                                                    STEP 000                                                    *****/
--/*****                                           BackUp  current Table(s)                                             *****/
--/**************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
--/*------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_NoStd' + '_' + @CrDt + ']
--                  FROM      [forum].[dbo].[Pew_Question_NoStd]'                      )
--/**************************************************************************************************************************/
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_NoStd]                                         /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Question_pk]  =  ROW_NUMBER()OVER(ORDER BY[Question_abbreviation_std]) /* number all rows                         */
--                       + (SELECT MAX([Question_pk]) FROM [Pew_Question_NoStd]) /* add currently max pk from NoStdQuestions*/
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Question_abbreviation]           =  [Question_abbreviation_std]
--      ,[Question_wording]                =  [Question_short_wording_std]
--      ,[Question_Year]                   =          1 + (SELECT MAX([Question_Year]) FROM [Pew_Question_NoStd]) /*---2015  */
--      ,[Notes]                           =  'January - December '
--                                            + CAST((1 + (SELECT MAX([Question_Year]) FROM [Pew_Question_NoStd]))
--                                              AS VARCHAR(4))
--      ,[Display]                         =  0
--      ,[Data_source_fk]                  =  [Data_source_fk]
--      ,[Question_Std_fk]                 =  [Question_Std_fk]
--FROM
-- (
-- /*- New added questions --------------------------------------------------------------*/
--  SELECT
--         [Question_Std_fk]
--        =[Question_Std_pk]
--        ,[Question_abbreviation_std]
--        ,[Question_short_wording_std]
--        ,[Data_source_fk] =
--         CASE 
--         WHEN [Question_abbreviation_std] LIKE 'GRI_20%'   THEN 25
--         WHEN [Question_abbreviation_std] LIKE 'GRX_22%'   THEN 27
--         WHEN [Question_abbreviation_std] LIKE 'GRX_36%'   THEN 25
--         WHEN [Question_abbreviation_std] LIKE 'SHI_04%'   THEN 29
--         WHEN [Question_abbreviation_std] LIKE 'SHI_05%'   THEN 29
--                                                           ELSE 30
--          END
--    FROM (
--             SELECT TOP 44 *
--               FROM [forum].[dbo].[Pew_Question_Std]
--           ORDER BY [Question_Std_pk]   DESC                          ) ND
-- /*- New added questions --------------------------------------------------------------*/
--
--  UNION
--
-- /*- Former questions not included last year ------------------------------------------*/
--  SELECT
--         [Question_Std_fk]
--        =[Question_Std_pk]
--        ,[Question_abbreviation_std]
--        ,[Question_short_wording_std]
--        ,[Data_source_fk]                =  57
--    FROM (
--             SELECT *
--               FROM [forum].[dbo].[Pew_Question_Std]
--              WHERE [Question_abbreviation_std] LIKE 'XSG_S_99_0[4-6]') FD
-- /*- Former questions not included last year ------------------------------------------*/
--
--  UNION
--
-- /*- Still-current questions from last year -------------------------------------------*/
--  SELECT
--         [Question_Std_fk]
--        ,[Question_abbreviation_std]
--        ,[Question_short_wording_std]
--        ,[Data_source_fk]
--    FROM (
--             SELECT *
--               FROM [forum].[dbo].[Pew_Question]
--             WHERE
--               (    [Question_abbreviation_std] LIKE 'GR%'
--                 OR [Question_abbreviation_std] LIKE 'SH%'
--                 OR [Question_abbreviation_std] LIKE 'XS%' )
--               AND
--                    [Question_Year]  =   2014
--               AND  /* cluded from last year :                     */
--                    [Question_abbreviation_std] NOT LIKE 'GRX_34_0%'
--               AND  /* cluded from last year :                     */
--                    [Question_abbreviation_std] NOT LIKE 'GRX_35_0%'  ) CD
-- /*- Still-current questions from last year -------------------------------------------*/
--                                                                            )  NCD
--/*------------------------------------------------------------------------------------------------------------------------*/
--
--/**************************************************************************************************************************/
--/*****                                                    STEP 004                                                    *****/
--/**************************************************************************************************************************/
--SELECT * FROM [Pew_Question_NoStd]                                             /* check results in modified table         */
--/**************************************************************************************************************************/
--/* add to year variables te following toool variables:
--GRI_01_filter
--GRI_01_yBe
--GRI_02_filter
--GRI_02_yBe
--GRI_19_filter
--GRI_19_x
--SHI_01_x
--SHI_01_summary_b
--SHI_04_filter
--SHI_04_x
--SHI_05_filter
--SHI_05_x
--XSG_S_99_filter
--*/
--
--
-- UPDATE SORTING ORDER IN [Pew_Question_Attributes]
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--/*****                                                    STEP 000                                                    *****/
--/*****                                           BackUp  current Table(s)                                             *****/
--/**************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
--/*------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Attributes' + '_' + @CrDt + ']
--                  FROM      [forum].[dbo].[Pew_Question_Attributes]'                      )
--/**************************************************************************************************************************/
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--/*****                                                    STEP 000                                                    *****/
--/*****                                           BackUp  current Table(s)                                             *****/
--/**************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
--/*------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Attributes' + '_' + @CrDt + ']
--                  FROM      [forum].[dbo].[Pew_Question_Attributes]'                      )
--/**************************************************************************************************************************/

--DELETE            FROM      [forum].[dbo].[Pew_Question_Attributes]
--WHERE                                     [attk]                     =  'Access_sort'
--/**************************************************************************************************************************/
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
--(                                                                              /* >   Set of Values begins...             */
--
--            SELECT [K] =     3, [N] =  '001'
--  UNION ALL SELECT [K] =   967, [N] =  '002'
--  UNION ALL SELECT [K] =     1, [N] =  '003'
--  UNION ALL SELECT [K] =  1037, [N] =  '004'
--  UNION ALL SELECT [K] =   968, [N] =  '005'
--  UNION ALL SELECT [K] =     7, [N] =  '006'
--  UNION ALL SELECT [K] =  1038, [N] =  '007'
--  UNION ALL SELECT [K] =     9, [N] =  '008'
--  UNION ALL SELECT [K] =    76, [N] =  '009'
--  UNION ALL SELECT [K] =    78, [N] =  '010'
--  UNION ALL SELECT [K] =    79, [N] =  '011'
--  UNION ALL SELECT [K] =    80, [N] =  '012'
--  UNION ALL SELECT [K] =    81, [N] =  '013'
--  UNION ALL SELECT [K] =    82, [N] =  '014'
--  UNION ALL SELECT [K] =    83, [N] =  '015'
--  UNION ALL SELECT [K] =    84, [N] =  '016'
--  UNION ALL SELECT [K] =    85, [N] =  '017'
--  UNION ALL SELECT [K] =    86, [N] =  '018'
--  UNION ALL SELECT [K] =    87, [N] =  '019'
--  UNION ALL SELECT [K] =   997, [N] =  '020'
--  UNION ALL SELECT [K] =    88, [N] =  '021'
--  UNION ALL SELECT [K] =   995, [N] =  '022'
--  UNION ALL SELECT [K] =   996, [N] =  '023'
--  UNION ALL SELECT [K] =    89, [N] =  '024'
--  UNION ALL SELECT [K] =    91, [N] =  '025'
--  UNION ALL SELECT [K] =  1034, [N] =  '026'
--  UNION ALL SELECT [K] =    93, [N] =  '027'
--  UNION ALL SELECT [K] =  1035, [N] =  '028'
--  UNION ALL SELECT [K] =    95, [N] =  '029'
--  UNION ALL SELECT [K] =  1036, [N] =  '030'
--  UNION ALL SELECT [K] =   100, [N] =  '031'
--  UNION ALL SELECT [K] =    98, [N] =  '032'
--  UNION ALL SELECT [K] =   101, [N] =  '033'
--  UNION ALL SELECT [K] =   103, [N] =  '034'
--  UNION ALL SELECT [K] =    23, [N] =  '035'
--  UNION ALL SELECT [K] =    24, [N] =  '036'
--  UNION ALL SELECT [K] =    25, [N] =  '037'
--  UNION ALL SELECT [K] =    26, [N] =  '038'
--  UNION ALL SELECT [K] =    13, [N] =  '039'
--  UNION ALL SELECT [K] =    15, [N] =  '040'
--  UNION ALL SELECT [K] =    19, [N] =  '041'
--  UNION ALL SELECT [K] =   910, [N] =  '042'
--  UNION ALL SELECT [K] =    21, [N] =  '043'
--  UNION ALL SELECT [K] =    17, [N] =  '044'
--  UNION ALL SELECT [K] =    11, [N] =  '045'
--  UNION ALL SELECT [K] =    61, [N] =  '046'
--  UNION ALL SELECT [K] =    56, [N] =  '047'
--  UNION ALL SELECT [K] =    57, [N] =  '048'
--  UNION ALL SELECT [K] =    54, [N] =  '049'
--  UNION ALL SELECT [K] =    28, [N] =  '050'
--  UNION ALL SELECT [K] =    29, [N] =  '051'
--  UNION ALL SELECT [K] =    30, [N] =  '052'
--  UNION ALL SELECT [K] =    31, [N] =  '053'
--  UNION ALL SELECT [K] =    32, [N] =  '054'
--  UNION ALL SELECT [K] =    33, [N] =  '055'
--  UNION ALL SELECT [K] =    34, [N] =  '056'
--  UNION ALL SELECT [K] =    35, [N] =  '057'
--  UNION ALL SELECT [K] =    36, [N] =  '058'
--  UNION ALL SELECT [K] =    37, [N] =  '059'
--  UNION ALL SELECT [K] =    38, [N] =  '060'
--  UNION ALL SELECT [K] =    39, [N] =  '061'
--  UNION ALL SELECT [K] =    40, [N] =  '062'
--  UNION ALL SELECT [K] =    41, [N] =  '063'
--  UNION ALL SELECT [K] =    42, [N] =  '064'
--  UNION ALL SELECT [K] =    45, [N] =  '065'
--  UNION ALL SELECT [K] =    44, [N] =  '066'
--  UNION ALL SELECT [K] =   636, [N] =  '067'
--  UNION ALL SELECT [K] =    59, [N] =  '068'
--  UNION ALL SELECT [K] =    48, [N] =  '069'
--  UNION ALL SELECT [K] =    50, [N] =  '070'
--  UNION ALL SELECT [K] =    52, [N] =  '071'
--  UNION ALL SELECT [K] =   111, [N] =  '072'
--  UNION ALL SELECT [K] =   112, [N] =  '073'
--  UNION ALL SELECT [K] =   113, [N] =  '074'
--  UNION ALL SELECT [K] =   114, [N] =  '075'
--  UNION ALL SELECT [K] =   998, [N] =  '076'
--  UNION ALL SELECT [K] =   999, [N] =  '077'
--  UNION ALL SELECT [K] =  1000, [N] =  '078'
--  UNION ALL SELECT [K] =  1001, [N] =  '079'
--  UNION ALL SELECT [K] =  1002, [N] =  '080'
--  UNION ALL SELECT [K] =   637, [N] =  '081'
--  UNION ALL SELECT [K] =   638, [N] =  '082'
--  UNION ALL SELECT [K] =   639, [N] =  '083'
--  UNION ALL SELECT [K] =   640, [N] =  '084'
--  UNION ALL SELECT [K] =   641, [N] =  '085'
--  UNION ALL SELECT [K] =   794, [N] =  '086'
--  UNION ALL SELECT [K] =   795, [N] =  '087'
--  UNION ALL SELECT [K] =   796, [N] =  '088'
--  UNION ALL SELECT [K] =  1003, [N] =  '089'
--  UNION ALL SELECT [K] =   969, [N] =  '090'
--  UNION ALL SELECT [K] =    64, [N] =  '091'
--  UNION ALL SELECT [K] =    66, [N] =  '092'
--  UNION ALL SELECT [K] =    68, [N] =  '093'
--  UNION ALL SELECT [K] =    72, [N] =  '094'
--  UNION ALL SELECT [K] =    74, [N] =  '095'
--  UNION ALL SELECT [K] =   924, [N] =  '096'
--  UNION ALL SELECT [K] =    63, [N] =  '097'
--  UNION ALL SELECT [K] =   153, [N] =  '098'
--  UNION ALL SELECT [K] =   170, [N] =  '099'
--  UNION ALL SELECT [K] =   171, [N] =  '100'
--  UNION ALL SELECT [K] =   172, [N] =  '101'
--  UNION ALL SELECT [K] =   173, [N] =  '102'
--  UNION ALL SELECT [K] =   174, [N] =  '103'
--  UNION ALL SELECT [K] =   175, [N] =  '104'
--  UNION ALL SELECT [K] =   176, [N] =  '105'
--  UNION ALL SELECT [K] =   177, [N] =  '106'
--  UNION ALL SELECT [K] =   178, [N] =  '107'
--  UNION ALL SELECT [K] =   179, [N] =  '108'
--  UNION ALL SELECT [K] =   180, [N] =  '109'
--  UNION ALL SELECT [K] =   181, [N] =  '110'
--  UNION ALL SELECT [K] =   182, [N] =  '111'
--  UNION ALL SELECT [K] =   183, [N] =  '112'
--  UNION ALL SELECT [K] =   186, [N] =  '113'
--  UNION ALL SELECT [K] =   185, [N] =  '114'
--  UNION ALL SELECT [K] =   761, [N] =  '115'
--  UNION ALL SELECT [K] =   155, [N] =  '116'
--  UNION ALL SELECT [K] =   157, [N] =  '117'
--  UNION ALL SELECT [K] =   159, [N] =  '118'
--  UNION ALL SELECT [K] =   163, [N] =  '119'
--  UNION ALL SELECT [K] =   165, [N] =  '120'
--  UNION ALL SELECT [K] =   169, [N] =  '121'
--  UNION ALL SELECT [K] =   168, [N] =  '122'
--  UNION ALL SELECT [K] =   187, [N] =  '123'
--  UNION ALL SELECT [K] =   188, [N] =  '124'
--  UNION ALL SELECT [K] =   190, [N] =  '125'
--  UNION ALL SELECT [K] =   982, [N] =  '126'
--  UNION ALL SELECT [K] =   206, [N] =  '127'
--  UNION ALL SELECT [K] =   193, [N] =  '128'
--  UNION ALL SELECT [K] =   195, [N] =  '129'
--  UNION ALL SELECT [K] =   197, [N] =  '130'
--  UNION ALL SELECT [K] =  1004, [N] =  '131'
--  UNION ALL SELECT [K] =  1005, [N] =  '132'
--  UNION ALL SELECT [K] =   202, [N] =  '133'
--  UNION ALL SELECT [K] =   204, [N] =  '134'
--  UNION ALL SELECT [K] =  1006, [N] =  '135'
--  UNION ALL SELECT [K] =  1007, [N] =  '136'
--  UNION ALL SELECT [K] =  1008, [N] =  '137'
--  UNION ALL SELECT [K] =  1009, [N] =  '138'
--  UNION ALL SELECT [K] =  1010, [N] =  '139'
--  UNION ALL SELECT [K] =  1011, [N] =  '140'
--  UNION ALL SELECT [K] =  1012, [N] =  '141'
--  UNION ALL SELECT [K] =  1013, [N] =  '142'
--  UNION ALL SELECT [K] =  1014, [N] =  '143'
--  UNION ALL SELECT [K] =  1015, [N] =  '144'
--  UNION ALL SELECT [K] =  1016, [N] =  '145'
--  UNION ALL SELECT [K] =  1017, [N] =  '146'
--  UNION ALL SELECT [K] =  1018, [N] =  '147'
--  UNION ALL SELECT [K] =  1019, [N] =  '148'
--  UNION ALL SELECT [K] =  1021, [N] =  '149'
--  UNION ALL SELECT [K] =  1020, [N] =  '150'
--  UNION ALL SELECT [K] =  1022, [N] =  '151'
--  UNION ALL SELECT [K] =   965, [N] =  '152'
--  UNION ALL SELECT [K] =   192, [N] =  '153'
--  UNION ALL SELECT [K] =   983, [N] =  '154'
--  UNION ALL SELECT [K] =   210, [N] =  '155'
--  UNION ALL SELECT [K] =   212, [N] =  '156'
--  UNION ALL SELECT [K] =  1024, [N] =  '157'
--  UNION ALL SELECT [K] =  1025, [N] =  '158'
--  UNION ALL SELECT [K] =   216, [N] =  '159'
--  UNION ALL SELECT [K] =   218, [N] =  '160'
--  UNION ALL SELECT [K] =  1023, [N] =  '161'
--  UNION ALL SELECT [K] =   966, [N] =  '162'
--  UNION ALL SELECT [K] =   207, [N] =  '163'
--  UNION ALL SELECT [K] =   220, [N] =  '164'
--  UNION ALL SELECT [K] =  1026, [N] =  '165'
--  UNION ALL SELECT [K] =   235, [N] =  '166'
--  UNION ALL SELECT [K] =  1033, [N] =  '167'
--  UNION ALL SELECT [K] =   233, [N] =  '168'
--  UNION ALL SELECT [K] =  1032, [N] =  '169'
--  UNION ALL SELECT [K] =   224, [N] =  '170'
--  UNION ALL SELECT [K] =  1028, [N] =  '171'
--  UNION ALL SELECT [K] =   222, [N] =  '172'
--  UNION ALL SELECT [K] =  1027, [N] =  '173'
--  UNION ALL SELECT [K] =   994, [N] =  '174'
--  UNION ALL SELECT [K] =  1031, [N] =  '175'
--  UNION ALL SELECT [K] =   987, [N] =  '176'
--  UNION ALL SELECT [K] =   912, [N] =  '177'
--  UNION ALL SELECT [K] =   986, [N] =  '178'
--  UNION ALL SELECT [K] =   226, [N] =  '179'
--  UNION ALL SELECT [K] =  1029, [N] =  '180'
--  UNION ALL SELECT [K] =   984, [N] =  '181'
--  UNION ALL SELECT [K] =   228, [N] =  '182'
--  UNION ALL SELECT [K] =  1030, [N] =  '183'
--  UNION ALL SELECT [K] =   985, [N] =  '184'
--  UNION ALL SELECT [K] =   762, [N] =  '185'
--  UNION ALL SELECT [K] =   763, [N] =  '186'
--  UNION ALL SELECT [K] =   764, [N] =  '187'
--  UNION ALL SELECT [K] =   765, [N] =  '188'
--  UNION ALL SELECT [K] =   766, [N] =  '189'
--  UNION ALL SELECT [K] =   767, [N] =  '190'
--  UNION ALL SELECT [K] =   768, [N] =  '191'
--  UNION ALL SELECT [K] =   769, [N] =  '192'
--  UNION ALL SELECT [K] =   770, [N] =  '193'
--  UNION ALL SELECT [K] =   771, [N] =  '194'
--  UNION ALL SELECT [K] =   772, [N] =  '195'
--  UNION ALL SELECT [K] =   773, [N] =  '196'
--  UNION ALL SELECT [K] =   774, [N] =  '197'
--  UNION ALL SELECT [K] =   775, [N] =  '198'
--  UNION ALL SELECT [K] =   776, [N] =  '199'
--  UNION ALL SELECT [K] =   777, [N] =  '200'
--  UNION ALL SELECT [K] =   778, [N] =  '201'
--  UNION ALL SELECT [K] =   779, [N] =  '202'
--  UNION ALL SELECT [K] =   780, [N] =  '203'
--  UNION ALL SELECT [K] =   781, [N] =  '204'
--  UNION ALL SELECT [K] =   782, [N] =  '205'
--  UNION ALL SELECT [K] =   783, [N] =  '206'
--  UNION ALL SELECT [K] =   784, [N] =  '207'
--  UNION ALL SELECT [K] =   988, [N] =  '208'
--  UNION ALL SELECT [K] =   785, [N] =  '209'
--  UNION ALL SELECT [K] =   786, [N] =  '210'
--  UNION ALL SELECT [K] =   787, [N] =  '211'
--  UNION ALL SELECT [K] =   788, [N] =  '212'
--  UNION ALL SELECT [K] =   789, [N] =  '213'
--  UNION ALL SELECT [K] =   790, [N] =  '214'
--  --
--)                                                                              /* <   Set of Values ends!                 */
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Attributes]                                    /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[N])               /* number all rows                         */
--                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
--                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Question_Std_fk]        =  [K]
--      ,[attk]                   =  'Access_sort'
--      ,[attr]                   =  [N]
--/*------------------------------------------------------------------------------------------------------------------------*/
--  FROM [NSV]
--/*------------------------------------------------------------------------------------------------------------------------*/
--
--/**************************************************************************************************************************/
--SELECT * FROM [Pew_Question_Attributes]
--/**************************************************************************************************************************/
--
--
--
--
--
--
-- UPDATE list of Qs whith description in [Pew_Question_Attributes]
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Attributes]                                    /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[Question_Std_pk]) /* number all rows                         */
--                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
--                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Question_Std_fk]        =  [Question_Std_pk]
--      ,[attk]                   =  'Access_DESC'
--      ,[attr]                   =  [Question_abbreviation_std] + '_DES'
--/*------------------------------------------------------------------------------------------------------------------------*/
----select *
--  FROM
--       [forum]..[Pew_Question_Std]                   Q
--WHERE
--[Question_Std_pk]
--IN 
--(
--1,
--3,
--7,
--9,
--11,
--13,
--15,
--17,
--19,
--21,
--23,
--28,
--48,
--50,
--52,
--54,
--56,
--57,
--59,
--61,
--64,
--66,
--68,
--72,
--74,
--76,
--89,
--91,
--93,
--95,
--98,
--100,
--101,
--111,
--112,
--113,
--114,
--153,
--155,
--157,
--159,
--163,
--165,
--187,
--190,
--193,
--195,
--197,
--202,
--204,
--206,
--210,
--212,
--216,
--218,
--220,
--222,
--224,
--226,
--228,
--233,
--235,
--638,
--639,
--640,
--641,
--785,
--786,
--787,
--788,
--789,
--790,
--794,
--795,
--796,
--912,
--982,
--994,
--995,
--996,
--1003,
--1023,
--1037,
--1038
--)
--/*------------------------------------------------------------------------------------------------------------------------*/
--
--/**************************************************************************************************************************/
--SELECT * FROM [Pew_Question_Attributes]
--/**************************************************************************************************************************/
--
--
--
--
--
--
--
-- UPDATE list of tool-Qs in [Pew_Question_Attributes]
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Attributes]                                    /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[Question_Std_pk]) /* number all rows                         */
--                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
--                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Question_Std_fk]        =  [Question_Std_pk]
--      ,[attk]                   =  'Access_TOOL'
--      ,[attr]                   =  [Question_abbreviation_std]
--/*------------------------------------------------------------------------------------------------------------------------*/
----select *
--  FROM
--       [forum]..[Pew_Question_Std]                   Q
--WHERE
--[Question_Std_pk]
--IN 
--(
--967,
--968,
--969,
--982,
--983,
--988,
--1037,
--1038
--)
--/*------------------------------------------------------------------------------------------------------------------------*/
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT * FROM     [Pew_Question_Attributes]                                    /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--
--
--
--
--
--
--
-- UPDATE list of DEFULTED-AND-VAUE questions in [Pew_Question_Attributes]
-- (curr 111)
------SELECT 
------       Q.[Question_Std_fk]
------  FROM
------             [forum].[dbo].[Pew_Question]                                                       Q
------    INNER JOIN
------             ( SELECT * FROM [forum]..[Pew_Question_Attributes] WHERE [attk]='Access_sort' )    S
------                          ON        Q.[Question_Std_fk]
------                                 =  S.[Question_Std_fk]
------where
------(
------      [Question_Year]  = 2015
------   OR [Question_Year]  is null
------)
------and
------(
------[AnswerSet_num]  = 999999
------OR [Question_abbreviation_std] LIKE 'GRI_0[1-2]_filter'
------OR [Question_abbreviation_std] LIKE 'GRI_08_a'
------OR [Question_abbreviation_std] LIKE 'GRI_10_0[1-3]'
------OR [Question_abbreviation_std] LIKE 'GRI_11_01[a-b]'
------OR [Question_abbreviation_std] LIKE 'GRI_11_[0-1][0-9]'
------OR [Question_abbreviation_std] LIKE 'GRI_20_01x_01[a-b]'
------OR [Question_abbreviation_std] LIKE 'GRI_20_01x_[0-1][0-9]'
------OR [Question_abbreviation_std] LIKE 'GRX_29_0[1-5]'
------OR [Question_abbreviation_std] LIKE 'SHI_01_x_01[a-b]'
------OR [Question_abbreviation_std] LIKE 'SHI_01_x_[0-1][0-9]'
------OR [Question_abbreviation_std] LIKE 'SHI_04_f_x_%'
------OR [Question_abbreviation_std] LIKE 'XSG_S_99_0[1-6]'
------)
------order by [Question_abbreviation_std]
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Attributes]                                    /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[Question_Std_pk]) /* number all rows                         */
--                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
--                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Question_Std_fk]        =  [Question_Std_pk]
--      ,[attk]                   =  'Access_DFLT'
--      ,[attr]                   =  [Question_abbreviation_std]
--/*------------------------------------------------------------------------------------------------------------------------*/
----select *
--  FROM
--       [forum]..[Pew_Question_Std]                   Q
--WHERE
--[Question_Std_pk]
--IN 
--(
--24,
--25,
--26,
--29,
--30,
--31,
--32,
--33,
--34,
--35,
--36,
--37,
--38,
--39,
--40,
--41,
--42,
--44,
--45,
--64,
--66,
--68,
--72,
--74,
--78,
--79,
--80,
--81,
--82,
--83,
--84,
--85,
--86,
--87,
--88,
--155,
--157,
--159,
--163,
--165,
--169,
--170,
--171,
--172,
--173,
--174,
--175,
--176,
--177,
--178,
--179,
--180,
--181,
--182,
--183,
--185,
--186,
--193,
--195,
--197,
--202,
--204,
--210,
--212,
--216,
--218,
--636,
--637,
--638,
--639,
--640,
--641,
--761,
--785,
--786,
--787,
--788,
--789,
--790,
--910,
--924,
--965,
--966,
--967,
--968,
--984,
--985,
--986,
--987,
--997,
--1004,
--1005,
--1006,
--1007,
--1008,
--1009,
--1010,
--1011,
--1012,
--1013,
--1014,
--1015,
--1016,
--1017,
--1018,
--1019,
--1020,
--1021,
--1022,
--1024,
--1025
--)
--/*------------------------------------------------------------------------------------------------------------------------*/
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT * FROM     [Pew_Question_Attributes]                                    /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
-- CORRECT STD ANSWERS
--
--/**************************************************************************************************************************/
--/*****                                              BackUp current Table                                              *****/
--/**************************************************************************************************************************/
--  USE [forum]                                                                  /* use final database                      */
--GO
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)                                                 /* declare variable to store current date  */
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                          /* store date in format YYYYMMDD           */
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC                                                                           /* exec statement to run string s script   */
     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Answer_Std_' + @CrDt + ']
                  FROM     [forum].[dbo].[Pew_Answer_Std]'               )     /* select into backup from current table   */
/**************************************************************************************************************************/
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'There is no official religion'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'There is no official religion.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'The official religion is not mandatory, and it receives more or less the same benefits as other religions'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'The official religion is not mandatory, and it receives more or less the same benefits as other religions.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'The official religion is not mandatory, but the state regulates other religious groups and the official religion receives more benefits than other religions'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'The official religion is not mandatory, but the state regulates other religious groups and the official religion receives more benefits than other religions.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'The official religion is not mandatory, but the state creates a hostile environment for other religions'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'The official religion is not mandatory, but the state creates a hostile environment for other religions.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'The official religion is mandatory for all citizens'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'The official religion is mandatory for all citizens.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'No'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'No.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'Yes, but involvement was limited to providing weapons or financial support'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'Yes, but involvement was limited to providing weapons or financial support.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'Yes, and involvement included troops'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'Yes, and involvement included troops.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'Yes, but but not only for the official/preferred religion'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'Yes, but but not only for the official/preferred religion.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--UPDATE     [forum].[dbo].[Pew_Answer_Std]
--SET        [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'Yes, and disproportionately benefits the official/preferred religion'
--select * from [forum]..[Pew_Answer_Std]
--   WHERE   [forum].[dbo].[Pew_Answer_Std].[Answer_Wording_std]            
--     =     'Yes, and disproportionately benefits the official/preferred religion.'
--/*------------------------------------------------------------------------------------------------------------------------*/
--/**************************************************************************************************************************/
--
--
--/**************************************************************************************************************************/
--SELECT * FROM [Pew_Answer_Std] WHERE [AnswerSet_number] IN (243, 244, 245)     /* check results in modified table         */
--/**************************************************************************************************************************/
--
--
--







-- ad other std questions fom this coding period  ---- for entering numbers which will be coded in other qustions
-- SEP 8
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
WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
(                                                                              /* >   Set of Values begins...             */
----
          SELECT Q = 'SHI_04_d_x_1_n', W = 'Enter the NUMBER for SHI_04_d_x_1 FROM UNHCR DATASET'
UNION ALL SELECT Q = 'SHI_04_d_x_2_n', W = 'Enter the NUMBER for SHI_04_d_x_2 FROM IDMC DATASET'
UNION ALL SELECT Q = 'SHI_05_d_x_1_n', W = 'Enter the NUMBER for SHI_05_d_x_1 FROM UNHCR DATASET'
UNION ALL SELECT Q = 'SHI_05_d_x_2_n', W = 'Enter the NUMBER for SHI_05_d_x_2 FROM IDMC DATASET'
----
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
      ,[AnswerSet_num]              = 999999                                   /*                                         */
      ,[Editorially_Checked]        = 'NO!'                                    /* label as not editorially checked        */
/*------------------------------------------------------------------------------------------------------------------------*/
FROM
/*------------------------------------------------------------------------------------------------------------------------*/
        [NSV]                                                     AS SetVs     /* main reference to CTE (New Set of Vals) */
/*------------------------------------------------------------------------------------------------------------------------*/

/**************************************************************************************************************************/
/*****                                                    STEP 004                                                    *****/
/**************************************************************************************************************************/
--		SELECT * FROM [Pew_Question_Std]                                        /* check results in modified table         */
/**************************************************************************************************************************/



/*     FOUR CHANGES IN [Pew_Question_Attributes]:
                                                  1. UPDATE sorting order
                                                  2. UPDATE list of Qs whith description
                                                  3. UPDATE list of tool-Qs
                                                  4. UPDATE list of DEFULTED-AND-VALUE questions
*/
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

-- UPDATE SORTING ORDER IN [Pew_Question_Attributes]
/**************************************************************************************************************************/
--DELETE            FROM      [forum].[dbo].[Pew_Question_Attributes]
--WHERE                                     [attk]                     =  'Access_sort'
/**************************************************************************************************************************/
-- Update
UPDATE                      [forum].[dbo].[Pew_Question_Attributes]
SET                         [forum].[dbo].[Pew_Question_Attributes].[attr] = [attr] + 4
                              WHERE [attk] = 'Access_sort'      AND [attr] > 158

UPDATE                      [forum].[dbo].[Pew_Question_Attributes]
SET                         [forum].[dbo].[Pew_Question_Attributes].[attr] = [attr] + 3
                              WHERE [attk] = 'Access_sort'      AND [attr] = 158

UPDATE                      [forum].[dbo].[Pew_Question_Attributes]
SET                         [forum].[dbo].[Pew_Question_Attributes].[attr] = [attr] + 2
                              WHERE [attk] = 'Access_sort'      AND [attr] > 133         -------  > 132
                                                                AND [attr] < 158

UPDATE                      [forum].[dbo].[Pew_Question_Attributes]
SET                         [forum].[dbo].[Pew_Question_Attributes].[attr] = [attr] + 1
                              WHERE [attk] = 'Access_sort'      AND [attr] = 132

-----------
--- for wrong order
UPDATE                      [forum].[dbo].[Pew_Question_Attributes]
SET                         [forum].[dbo].[Pew_Question_Attributes].[attr] = [attr] + 2
                              WHERE [attk] = 'Access_sort'      AND [attr] = 133         -------  > original 133
                                AND [Question_Attributes_pk] = 1503
/**************************************************************************************************************************/
WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
(                                                                              /* >   Set of Values begins...             */
            SELECT [K] = 1039, [N] =  '132'       ----- SHI_04_d_x_1_n
  UNION ALL SELECT [K] = 1040, [N] =  '134'       ----- SHI_04_d_x_2_n
  UNION ALL SELECT [K] = 1041, [N] =  '160'       ----- SHI_05_d_x_1_n
  UNION ALL SELECT [K] = 1042, [N] =  '162'       ----- SHI_05_d_x_2_n
)                                                                              /* <   Set of Values ends!                 */
/*------------------------------------------------------------------------------------------------------------------------*/
	INSERT INTO                                                                /* insert statement                        */
	              [Pew_Question_Attributes]                                    /* target table in current database        */
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

--
-- UPDATE list of Qs whith description in [Pew_Question_Attributes]
--/**************************************************************************************************************************/
--/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	              [Pew_Question_Attributes]                                    /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT                                                                         /* select statement...                     */
--/*------------------------------------------------------------------------------------------------------------------------*/
--       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[Question_Std_pk]) /* number all rows                         */
--                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
--                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
--/*------------------------------------------------------------------------------------------------------------------------*/
--      ,[Question_Std_fk]        =  [Question_Std_pk]
--      ,[attk]                   =  'Access_DESC'
--      ,[attr]                   =  [Question_abbreviation_std] + '_DES'
--/*------------------------------------------------------------------------------------------------------------------------*/
----select *
--  FROM
--       [forum]..[Pew_Question_Std]                   Q
--WHERE
--[Question_Std_pk]
--IN 
--(
--1038
--)
--/*------------------------------------------------------------------------------------------------------------------------*/
--
--/**************************************************************************************************************************/
--SELECT * FROM [Pew_Question_Attributes]
--/**************************************************************************************************************************/
--
--
--
-- UPDATE list of tool-Qs in [Pew_Question_Attributes]
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--/*****                                                    STEP 001                                                    *****/
--/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
	INSERT INTO                                                                /* insert statement                        */
	              [Pew_Question_Attributes]                                    /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[Question_Std_pk]) /* number all rows                         */
                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_Std_fk]        =  [Question_Std_pk]
      ,[attk]                   =  'Access_TOOL'
      ,[attr]                   =  [Question_abbreviation_std]
/*------------------------------------------------------------------------------------------------------------------------*/
--select *
  FROM
       [forum]..[Pew_Question_Std]                   Q
WHERE
[Question_Std_pk]
IN 
(
1039,
1040,
1041,
1042
)
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT * FROM     [Pew_Question_Attributes]                                    /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
-- Update
UPDATE                      [forum].[dbo].[Pew_Question_Attributes]
SET                         [forum].[dbo].[Pew_Question_Attributes].[attr] = [attr] + 4
                              WHERE [attk] = 'Access_sort'      AND [attr] > 158


--
--
--
--
--
--
-- UPDATE list of DEFULTED-AND-VAUE questions in [Pew_Question_Attributes]
-- (curr 111)
------SELECT 
------       Q.[Question_Std_fk]
------  FROM
------             [forum].[dbo].[Pew_Question]                                                       Q
------    INNER JOIN
------             ( SELECT * FROM [forum]..[Pew_Question_Attributes] WHERE [attk]='Access_sort' )    S
------                          ON        Q.[Question_Std_fk]
------                                 =  S.[Question_Std_fk]
------where
------(
------      [Question_Year]  = 2015
------   OR [Question_Year]  is null
------)
------and
------(
------[AnswerSet_num]  = 999999
------OR [Question_abbreviation_std] LIKE 'GRI_0[1-2]_filter'
------OR [Question_abbreviation_std] LIKE 'GRI_08_a'
------OR [Question_abbreviation_std] LIKE 'GRI_10_0[1-3]'
------OR [Question_abbreviation_std] LIKE 'GRI_11_01[a-b]'
------OR [Question_abbreviation_std] LIKE 'GRI_11_[0-1][0-9]'
------OR [Question_abbreviation_std] LIKE 'GRI_20_01x_01[a-b]'
------OR [Question_abbreviation_std] LIKE 'GRI_20_01x_[0-1][0-9]'
------OR [Question_abbreviation_std] LIKE 'GRX_29_0[1-5]'
------OR [Question_abbreviation_std] LIKE 'SHI_01_x_01[a-b]'
------OR [Question_abbreviation_std] LIKE 'SHI_01_x_[0-1][0-9]'
------OR [Question_abbreviation_std] LIKE 'SHI_04_f_x_%'
------OR [Question_abbreviation_std] LIKE 'XSG_S_99_0[1-6]'
------)
------order by [Question_abbreviation_std]
--/**************************************************************************************************************************/
--



/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
	INSERT INTO                                                                /* insert statement                        */
	              [Pew_Question_Attributes]                                    /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[Question_Std_pk]) /* number all rows                         */
                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_Std_fk]        =  [Question_Std_pk]
      ,[attk]                   =  'Access_DFLT'
      ,[attr]                   =  [Question_abbreviation_std]
/*------------------------------------------------------------------------------------------------------------------------*/
--select *
  FROM
       [forum]..[Pew_Question_Std]                   Q
WHERE
[Question_Std_pk]
IN 
(
1039,
1040,
1041,
1042
)
--/*------------------------------------------------------------------------------------------------------------------------*/
--/*------------------------------------------------------------------------------------------------------------------------*/
--SELECT * FROM     [Pew_Question_Attributes]                                    /* target table in current database        */
--/*------------------------------------------------------------------------------------------------------------------------*/


-- correct wording of std answers
-- SEP 9
/***************************************************************************************************************************************************************/
/* Update */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Answer_Std]
SET       [Answer_wording_std]
= REPLACE([Answer_wording_std]
         ,' but but '
         ,' but '                        )
--select * from [Pew_Answer_Std]
WHERE     [Answer_wording_std]
     LIKE '% but but %'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/


-- correct wording of std questions
-- SEP 9
/***************************************************************************************************************************************************************/
/* Update */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Question_Std]
SET       [Question_wording_std]
= REPLACE([Question_wording_std]
         ,' this question depend solely on information from the two IRF reports before this year''s repport?'
         ,              ' depend solely on information from the two IRF reports before this year''s report?'  )
--select * from [Pew_Question_Std]
WHERE     [Question_wording_std]
     LIKE '% this question depend solely on information from the two IRF reports before this year''s repport?'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Question_Std]
SET       [Question_short_wording_std]
= REPLACE([Question_short_wording_std]
         ,' this question depend solely on information from the two IRF reports before this year''s repport?'
         ,              ' depend solely on information from the two IRF reports before this year''s report?'  )
--select * from [Pew_Question_Std]
WHERE     [Question_short_wording_std]
     LIKE '% this question depend solely on information from the two IRF reports before this year''s repport?'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Question_Std]
SET       [Question_wording_std]
= REPLACE([Question_wording_std]
         ,', phhysical abuse, detendtions and'
         , ', physical abuse, detentions and'                                                                 )
--select * from [Pew_Question_Std]
WHERE     [Question_wording_std]
     LIKE '%, phhysical abuse, detendtions and%'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Question_Std]
SET       [Question_wording_std]
= REPLACE([Question_wording_std]
         ,', phhysical abuse, detendtions, displacements and property damge)'
         , ', physical abuse, detentions, displacements and property damage)'                                                                 )
--select * from [Pew_Question_Std]
WHERE     [Question_wording_std]
     LIKE '%, phhysical abuse, detendtions, displacements and property damge)%'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Question_Std]
SET       [Question_wording_std]
= REPLACE([Question_wording_std]
         , ', physcal assaults'
         , ', physical assaults'                                                                                                               )
--select * from [Pew_Question_Std]
WHERE     [Question_wording_std]
     LIKE '%, physcal assaults%'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Question_Std]
SET       [Question_wording_std]
= REPLACE([Question_wording_std]
         , ' the the '
         , ' the '                                                                                                                   )
--select * from [Pew_Question_Std]
WHERE     [Question_wording_std]
     LIKE '% the the %'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Question_Std]
SET       [Question_short_wording_std]
= REPLACE([Question_short_wording_std]
         , ' the the '
         , ' the '                                                                                                                   )
--select * from [Pew_Question_Std]
WHERE     [Question_short_wording_std]
     LIKE '% the the %'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/


-- correct wording of no-std questions
-- SEP 9
/***************************************************************************************************************************************************************/
/* Update */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Question_NoStd]
SET       [Question_wording]
= REPLACE([Question_wording]
         ,' this question depend solely on information from the two IRF reports before this year''s repport?'
         ,              ' depend solely on information from the two IRF reports before this year''s report?'  )
--select * from [Pew_Question_NoStd]
WHERE     [Question_wording]
     LIKE '% this question depend solely on information from the two IRF reports before this year''s repport?'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE    [forum].[dbo].[Pew_Question_NoStd]
SET       [Question_wording]
= REPLACE([Question_wording]
         , ' the the '
         , ' the '                                                                                                                   )
--select * from [Pew_Question_NoStd]
WHERE     [Question_wording]
     LIKE '% the the %'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/
---- finalized here on Sept 14, 2016



-- Sep 19
-- UPDATE Q whith description in [Pew_Question_Attributes]
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
/*------------------------------------------------------------------------------------------------------------------------*/
	INSERT INTO                                                                /* insert statement                        */
	              [Pew_Question_Attributes]                                    /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Question_Attributes_pk] =  ROW_NUMBER()OVER(ORDER BY[Question_Std_pk]) /* number all rows                         */
                                 + (SELECT MAX([Question_Attributes_pk])       /* add currently max pk                    */
                                      FROM [Pew_Question_Attributes])          /* from Pew_Question_Attributes            */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_Std_fk]        =  [Question_Std_pk]
      ,[attk]                   =  'Access_DESC'
      ,[attr]                   =  [Question_abbreviation_std] + '_DES'
/*------------------------------------------------------------------------------------------------------------------------*/
--select *
  FROM
       [forum]..[Pew_Question_Std]                   Q
WHERE
[Question_Std_pk]
IN 
(
1023
)
/*------------------------------------------------------------------------------------------------------------------------*/

/**************************************************************************************************************************/
--SELECT * FROM [Pew_Question_Attributes]
/**************************************************************************************************************************/






-- Sep 21
-- it was unnecessary to UPDATE Q whith description in [Pew_Question_Attributes]
/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Attributes' + '_' + @CrDt + ']
                  FROM      [forum].[dbo].[Pew_Question_Attributes]'                      )
/**************************************************************************************************************************/
--	DELETE FROM   -- select * from
	              [Pew_Question_Attributes]                                    /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
          WHERE   [Question_Std_fk]           = 1023
            AND   [attk]                      = 'Access_DESC'
            AND   [attr]                      = 'SHI_05_01_DES'
/*------------------------------------------------------------------------------------------------------------------------*/
            AND   [Question_Attributes_pk]    = 1800                           /* duplicated!!!!!!                        */
/**************************************************************************************************************************/
--SELECT * FROM [Pew_Question_Attributes]
/**************************************************************************************************************************/

