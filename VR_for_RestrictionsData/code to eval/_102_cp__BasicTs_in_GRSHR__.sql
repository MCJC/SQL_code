/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 2.002    ---------------------------------------------------------------------------------------- '
/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
USE              [GRSHRcode]
GO
/***                                                                                                                                            ***/
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






/**************************************************************************************************************************************************/
/***                                                          *************************************************************/
/***     [All_Answers]                                        *************************************************************/
/***                                                          *************************************************************/
/**************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'All_Answers'                     ) = 1
DROP              TABLE         [All_Answers]
GO
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
                          [Q] LIKE 'XSG_S_99_0[1-6]'
                       OR [Q] LIKE 'GRI_11'
                       OR [Q] LIKE 'GRI_11_%'
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
           , [W] = 'No supplemental source ' + SUBSTRING([Q], 10, 2) ----  NOTICE NO TWO OPTIONS
           , [N]
     FROM
             NSV
    WHERE       [V] = 0.00
      AND  (
                [Q] LIKE 'XSG_S_99_0[1-6]'
                                                                  )
/*------------------------------------------------------------------------------------------------------------------------*/
UNION ALL
/*------------------------------------------------------------------------------------------------------------------------*/
   SELECT                                                                      /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
             [Q]
           , [V]
           , [W] = 'No (not mentioned in the sources)'            ---- vs. 'No (specifically mentioned in the sources)'
           , [N]
     FROM
             NSV
    WHERE       [V] = 0.00
      AND  (
                [Q] LIKE 'GRI_11'
             OR [Q] LIKE 'GRI_11_%'
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
           , [W] = 'No (specifically mentioned in the sources)'   ---- vs. 'No (not mentioned in the sources)'
           , [N]
     FROM
             NSV
    WHERE       [V] = 0.00
      AND  (
                [Q] LIKE 'GRI_11'
             OR [Q] LIKE 'GRI_11_%'
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



/**************************************************************************************************************************/
/***                                                          *************************************************************/
/***     [All_Questions]                                      *************************************************************/
/***                                                          *************************************************************/
/**************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'All_Questions'                          ) = 1
DROP              TABLE         [All_Questions]
/**************************************************************************************************************************/
SELECT 
----------------------------------------------------------------------------------------------------------------------------
          [Q_Number]
          =  ROW_NUMBER()
             OVER(ORDER BY S.[Attr])
----------------------------------------------------------------------------------------------------------------------------
        , S.[Question_Std_fk]
        ,   [Question_fk]                =          Q.[Question_pk]
        , Q.[Question_abbreviation_std]
        , Q.[Question_wording_std]
----------------------------------------------------------------------------------------------------------------------------
        , [QClass]                       =       CASE
                                                 WHEN [Question_abbreviation_std] LIKE 'GRI_19_x'
                                                   OR [Question_abbreviation_std] LIKE 'SHI_0[1,4,5]_x'
                                                   OR [Question_abbreviation_std] LIKE 'SHI_01_summary_b'    THEN 'PERSI'
                                                 WHEN [Question_abbreviation_std] LIKE '%_yBe'               THEN 'preyr'
                                                 WHEN [AnswerSet_num]                =  999999               THEN 'COUNT'
                                                                                                             ELSE 'CODED'   END 
----------------------------------------------------------------------------------------------------------------------------
        , [QDescr]                       =          D.[Attr]
        , [QTools]                       =          T.[Attr]
        , [QTable]                       =  SUBSTRING([Question_abbreviation_std], 1, 2)
        , [QDftlt]                       =          F.[Attr]
----------------------------------------------------------------------------------------------------------------------------
	INTO
	          [All_Questions]
----------------------------------------------------------------------------------------------------------------------------
--  select *
    FROM
----------------------------------------------------------------------------------------------------------------------------
             ( SELECT * FROM [forum]..[Pew_Question]         WHERE [Question_Year] = 2015
                                                                OR [Question_Year] IS NULL )    Q
----------------------------------------------------------------------------------------------------------------------------
    INNER JOIN
             ( SELECT * FROM [forum]..[Pew_Question_Attributes] WHERE [attk]='Access_sort' )    S
                          ON        Q.[Question_Std_fk]
                                 =  S.[Question_Std_fk]
----------------------------------------------------------------------------------------------------------------------------
    LEFT  JOIN
             ( SELECT * FROM [forum]..[Pew_Question_Attributes] WHERE [attk]='Access_DESC' )    D
                          ON        Q.[Question_Std_fk]
                                 =  D.[Question_Std_fk]
----------------------------------------------------------------------------------------------------------------------------
    LEFT  JOIN
             ( SELECT * FROM [forum]..[Pew_Question_Attributes] WHERE [attk]='Access_TOOL' )    T
                          ON        Q.[Question_Std_fk]
                                 =  T.[Question_Std_fk]
----------------------------------------------------------------------------------------------------------------------------
    LEFT  JOIN
             ( SELECT * FROM [forum]..[Pew_Question_Attributes] WHERE [attk]='Access_DFLT' )    F
                          ON        Q.[Question_Std_fk]
                                 =  F.[Question_Std_fk]
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
               SELECT * FROM [GRSHRcode]..[All_Questions]
/**************************************************************************************************************************/




                       
               

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
       , [VarName]   = [Question_abbreviation_std]
       , [Answer]    = STR((
                       CAST([Answer_value] as decimal (4,2))) , 4,2 ) + '   - ' + [Answer_wording_std]
----------------------------------------------------------------------------------------------------------------------------
	  INTO
	          [Values]
--------------------------------------------------------------------------------------------------------------------------
  FROM 
----------------------------------------------------------------------------------------------------------------------------
         [All_Answers]
----------------------------------------------------------------------------------------------------------------------------
WHERE    [Question_abbreviation_std] IN ( SELECT [Question_abbreviation_std]
                                            FROM [All_Questions]
                                           WHERE [QClass] = 'CODED'           )
/**************************************************************************************************************************/
/**************************************************************************************************************************/
               SELECT * FROM [GRSHRcode]..[Values]
/**************************************************************************************************************************/




IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'AT_Qs'                          ) = 1
DROP              TABLE         [AT_Qs]
/**************************************************************************************************************************/
SELECT * INTO                   [AT_Qs]
------------------------------------------------------------------------------------------------------------------------------
  FROM (  
/**************************************************************************************************************************************************/
SELECT
/*------------------------------------------------------------------------------------------------------------------------*/
        [row]                        =  ROW_NUMBER()
                                        OVER(ORDER BY [Q_Number], [QAS]    )
/*------------------------------------------------------------------------------------------------------------------------*/
      , [QAS]
      , [Q_Number]
      , [Question_Std_fk]
      , [Question_fk]
      , [Question_wording_std]
      , [QClass]               = CASE 
                                      WHEN [QAS]   LIKE '%_DES'  THEN 'DESCR'
                                      WHEN [QClass]   = 'preyr'  THEN 'CODED'
                                      ELSE [QClass]                               END
      , [QTools]
      , [QTable]
      , [QDftlt]
  FROM
(
/**************************************************************************************************************************/
               SELECT [QAS]=[Question_abbreviation_std], * FROM [GRSHRcode]..[All_Questions]
UNION ALL
               SELECT [QAS]=[QDescr]                   , * FROM [GRSHRcode]..[All_Questions] WHERE [QDescr] IS NOT NULL
/**************************************************************************************************************************/
) ADDED
) TSORTED

---SELECT * FROM                   [AT_Qs]


--dbo.GRI_Ctry
--dbo.GRSH_C
--dbo.SHI_Ctry
--dbo.Sources
--dbo.WT_VNs



/**************************************************************************************************************************/
/***                                                          *************************************************************/
/***     [FYLDS]    (former year long data set)                                         *************************************************************/
/***                                                          *************************************************************/
/**************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'FYLDS'                          ) = 1
DROP              TABLE         [FYLDS]
/**************************************************************************************************************************/
SELECT * INTO                   [FYLDS]
------------------------------------------------------------------------------------------------------------------------------
  FROM (  
/**************************************************************************************************************************/
SELECT 
                [lkk]                  = LASTYR.[link_fk]
               ,[N_k]                  = LASTYR.[Nation_fk]
      ,[Re5]                  = LASTYR.[Region5]
      ,[Re6]                  = LASTYR.[Region6]
      ,[CEN]                  = LASTYR.[Ctry_EditorialName]
      ,[QYr]                  = LASTYR.[Question_Year]
      ,[QSk]
      ,[Quk]                  = LASTYR.[Question_fk]
      ,[Auk]                  = LASTYR.[Answer_fk]
      ,[QAS]                  = LASTYR.[QA_std]
      ,[AVa]                  = LASTYR.[Answer_value]
      ,[AWS]                  = LASTYR.[Answer_wording_std]
      ,[AWu]                  = LASTYR.[Answer_wording]
      ,[QCl]                  = ALLCQS.[QClass]
      ,[QDe]                  = ALLCQS.[QDescr]
      ,[QTo]                  = ALLCQS.[QTools]
      ,[QTb]                  = ALLCQS.[QTable]
/**************************************************************************************************************************************************/
FROM
            ( SELECT * FROM [forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]
	                  WHERE [Question_Year]
			              = (SELECT MAX([Question_Year]) FROM [forum_ResAnal]..[vr___06_cDB_LongData_ALL_byCYQ])   )   LASTYR
INNER JOIN
               [GRSHRcode].[dbo].[All_Questions]                                                                        ALLCQS
           ON                   LASTYR.[QSk]
                             =  ALLCQS.[Question_Std_fk]
/**************************************************************************************************************************************************/
       )  SelData 
------------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************************************/





/**************************************************************************************************************************/
/***                                                          *************************************************************/
/***     [TwoYD]    (two years od data; former year and current coding period -- long data set)                                         *************************************************************/
/***                                                          *************************************************************/
/**************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'TwoYD'                          ) = 1
DROP              TABLE         [TwoYD]
/**************************************************************************************************************************/
SELECT * INTO                   [TwoYD]
------------------------------------------------------------------------------------------------------------------------------
  FROM (  
/**************************************************************************************************************************************************/
/* >   1st long SET: coding-period data, including blank & defaulted   ****************************************************************************/
/**************************************************************************************************************************************************/
         SELECT 
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
                [lkk]                  =              NULL
               ,[N_k]                  =          CD.[Nation_fk]
               ,[Re5]                  =          CD.[Region5]
               ,[Re6]                  =          CD.[Region6]
               ,[CEN]                  =          CD.[Ctry_EditorialName]
               ,[QYr]                  = (SELECT MAX([QYr]) FROM  [FYLDS]) + 1
               ,[QSk]                  =          AQ.[Question_Std_fk]
               ,[Quk]                  =          AQ.[Question_pk]
               ,[Auk]                  =              NULL
               ,[QAS]                  =          AQ.[Question_abbreviation_std]
               ,[AVa]                  = CASE
                                             WHEN AQ.[Question_abbreviation_std]
                                             LIKE 'GRI_0[1-2]_yBe'
                                             THEN PY.[AVa]
                                             WHEN SQ.[QDftlt] IS NULL 
                                             THEN     NULL
                                             ElSE DA.[Answer_value]                      END
               ,[AWS]                  = CASE
                                             WHEN AQ.[Question_abbreviation_std]
                                             LIKE 'GRI_0[1-2]_yBe'
                                             THEN PY.[AWS]
                                             WHEN SQ.[QDftlt] IS NULL 
                                             THEN     ''
                                             ElSE DA.[Answer_wording_std]                 END
               ,[AWu]                  = CASE
                                             WHEN AQ.[Question_abbreviation_std]
                                             LIKE 'GRI_0[1-2]_yBe'
                                             THEN PY.[AWu]
                                             ElSE ''                                       END
               ,[QCl]                  =          SQ.[QClass]
               ,[QDe]                  =          SQ.[QDescr]
               ,[QTo]                  =          SQ.[QTools]
               ,[QTb]                  =          SQ.[QTable]
  FROM
                [forum]..[Pew_Question]                                                       AQ
----------------------------------------------------------------------------------------------------------------------------
    INNER JOIN
               [GRSHRcode]..[All_Questions]                                                   SQ
                          ON        AQ.[Question_STd_fk]
                                 =  SQ.[Question_Std_fk]
                          AND       ISNULL(AQ.[Question_pk], 0)
                                 =  ISNULL(SQ.[Question_fk], 0)
----------------------------------------------------------------------------------------------------------------------------
    INNER JOIN

              (SELECT * FROM (
                               SELECT 
                                      *
                                     ,[RFilt] = MIN([A_row])OVER(PARTITION BY
	                                            [Question_abbreviation_std])
                                 FROM [GRSHRcode].[dbo].[All_Answers]
                                                                              ) QsAs
                        WHERE    [A_row] = [RFilt]
                                                                                            ) DA
                          ON        SQ.[Question_abbreviation_std]
                                 =  DA.[Question_abbreviation_std]
----------------------------------------------------------------------------------------------------------------------------
    CROSS JOIN
               [GRSHRcode]..[Countries]                                                       CD
----------------------------------------------------------------------------------------------------------------------------
    LEFT  JOIN

              (       SELECT [V_yBe] = [QAS] + '_yBe', * FROM [GRSHRcode]..[FYLDS]          ) PY
                          ON        AQ.[Question_abbreviation_std]
                                 =  PY.[V_yBe]
                          AND       CD.[Nation_fk]
                                 =  PY.[N_k]
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************************************/
union all
/**************************************************************************************************************************************************/
/* >   1st long SET: coding-period data, including defaulted and blank (NO-VARS from prev yr 'GRI_0[1-2]_yBe') ************************************/
/**************************************************************************************************************************************************/
         SELECT * FROM [GRSHRcode]..[FYLDS]
/**************************************************************************************************************************************************/
       ) D2Y

/**************************************************************************************************************************/
SELECT * FROM                   [TwoYD]
/**************************************************************************************************************************/


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/





