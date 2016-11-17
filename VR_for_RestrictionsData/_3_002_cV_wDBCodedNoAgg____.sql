/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 3.002    ---------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the VIEW vr___01_cDB_Long__NoAggregated




                                                       lookup table [forum_ResAnal].[dbo].[vr_05w_SemiWide_by_Ctry&Year]                           <<<<<     ***/
/***             This table only includes numeric values aggregated by country/religion & year (does not include descriptive wordings).                      ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [GRSHRcode]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
ALTER VIEW     [v07_CodedNoAggregated]
AS


WITH  
TUValues AS  
(
  SELECT
          [V5].[Nation_fk]
        ,      [Variable]  = CASE
                                  WHEN [V5].[Variable] = 'SHI_04_d_x_1_n'
                                  THEN                   'SHI_04_d_x_1'
                                  WHEN [V5].[Variable] = 'SHI_04_d_x_2_n'
                                  THEN                   'SHI_04_d_x_2'
                                  WHEN [V5].[Variable] = 'SHI_05_d_x_1_n'
                                  THEN                   'SHI_05_d_x_1'
                                  WHEN [V5].[Variable] = 'SHI_05_d_x_2_n'
                                  THEN                   'SHI_05_d_x_2'
                             END
        , [V5].[Value2015]
    FROM       [v05_ReportData]               [V5]
   WHERE  [V5].[Variable]
    IN (
           'SHI_04_d_x_1_n'
         , 'SHI_04_d_x_2_n'
         , 'SHI_05_d_x_1_n'
         , 'SHI_05_d_x_2_n'                             )
)
,
NTValues AS  
(
  SELECT
          *
    FROM       [v05_ReportData]
   WHERE
   /***  exclude variables storing numeric values to be added to binary variables  ***/ 
               [Variable]
                           NOT IN (
                                      'SHI_04_d_x_1_n'
                                    , 'SHI_04_d_x_2_n'
                                    , 'SHI_05_d_x_1_n'
                                    , 'SHI_05_d_x_2_n'   )
        AND NOT
   --/***  exclude variables storing numeric values to be added to binary variables  ***/ 
   /***  exclude variables corresponding to EXTRA SOURCES referred ONLY for the previous year  ***/ 
            (
              [Variable]          LIKE 'XSG_S_99_0%'
             AND
              [Value2015]         IS     NULL
             AND
              [DecodedValue_2015] IS     NULL
             AND
              [Descr_2015]        IS     NULL            )
)
,
QsnCoded AS
(  
  SELECT
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
          [CRL]                                                      = [AQ].[QbyCRL]
        , [dsn]                                                      = [DS].[Data_source_name]
        , [R_5]                                                      = [Cs].[Region5]
        , [R_6]                                                      = [Cs].[Region6]
        , [Nfk]                                                      = [V5].[Nation_fk]
        , [Rfk]                                                      = [AQ].[Religion_fk]
        , [Lfk] =  CASE
                        WHEN               [AQ].[QbyCRL]             = 'Prov'
                        THEN                                           [Cs].[Locality_fk]
                    END
        , [QSk]                                                      = [QS].[Question_Std_pk]
        , [QRk]                                                      = [QR].[Question_pk]
      --, [ASk]
      --, [ARp]
        , [CEN]                                                      = [V5].[Ctry_EditorialName]
        , [rel]                                                      = [AQ].[Religion]
        , [loc] =  CASE
                        WHEN               [AQ].[QbyCRL]             = 'Prov'
                        THEN                                           [Cs].[Locality]
                    END
        , [QAs]                                                      = [V5].[Variable]
      --, [AVs]
        , [AVn] =  CASE
                        WHEN               [tu].[Value2015]         IS NULL
                        THEN               [V5].[Value2015]
                        WHEN               [V5].[Value2015]          = 0
                         AND               [tu].[Value2015]          = 0
                        THEN                                           0.00
                        WHEN               [V5].[Value2015]          = 1
                         AND               [tu].[Value2015]          > 0
                        THEN               [tu].[Value2015]
                    END
        , [AWs] =  CASE
/*                     ----------------------------------------------------------------------------------------------------------------------------------------*/
                        WHEN               [V5].[Variable]        LIKE 'GRI_19_[b-f]'
                          OR               [V5].[Variable]        LIKE 'SHI_0[1,4,5]_[b-f]'
                          OR               [V5].[Variable]        LIKE 'SHI_05_[c-f]'
                          OR               [V5].[Variable]        LIKE 'SHI_09_n'
                          OR               [V5].[Variable]        LIKE 'SHI_10_n'
                          OR               [V5].[Variable]        LIKE 'SHI_11_[a-b]_n'
                        THEN   STUFF(      [V5].[DecodedValue_2015], 1, 12, '')
/*                     ----------------------------------------------------------------------------------------------------------------------------------------*/
                        WHEN  (            [V5].[DecodedValue_2015] =  '0.00   - No (not mentioned in the sources)'
                                 OR        [V5].[DecodedValue_2015] =  '0.00   - No (specifically mentioned in the sources)'   )
                         AND               [V5].[Variable]        LIKE 'SHI_0[4,5]_d_x_[1,2]'
                        THEN                                           'No cases or events were found'
/*                     ----------------------------------------------------------------------------------------------------------------------------------------*/
                        WHEN               [V5].[Value2015]          = 0
                         AND               [QS].[AnswerSet_num]      = 14
                        THEN                                           'No groups'
                        WHEN               [V5].[Value2015]          = 1
                         AND               [QS].[AnswerSet_num]      = 14
                        THEN                                           'One or more groups'
/*                     ----------------------------------------------------------------------------------------------------------------------------------------*/
                        WHEN               [V5].[DecodedValue_2015]  = '0.25   - Yes, with fewer than 10,000 casualties or people displaced from their homes'
                        THEN                                           'Yes, with fewer than 10,000 casualties or people displaced'
/*                     ----------------------------------------------------------------------------------------------------------------------------------------*/
                        WHEN               [V5].[DecodedValue_2015]  = '0.00   - No (not mentioned in the sources)'
                        THEN                                           'No'
                        WHEN               [V5].[DecodedValue_2015]  = '0.00   - No (specifically mentioned in the sources)'
                        THEN                                           'No'
/*                     ----------------------------------------------------------------------------------------------------------------------------------------*/
                        WHEN               [V5].[DecodedValue_2015] != ''
                        THEN REPLACE(      [V5].[DecodedValue_2015],
                                     (CAST([V5].[Value2015]         AS VARCHAR (MAX))) + '   - ', '')
/*                     ----------------------------------------------------------------------------------------------------------------------------------------*/
                        WHEN               [V5].[DecodedValue_2015]  = ''
                         AND               [V5].[Value2015]          = 0
                        THEN                                           'No cases were found'
                        WHEN               [V5].[DecodedValue_2015]  = ''
                         AND               [V5].[Value2015]          > 0
                        THEN                                           '1+ cases or events were found'
/*                     ----------------------------------------------------------------------------------------------------------------------------------------*/
                    END
        , [AWn] =  CASE
                        WHEN               [V5].[DecodedValue_2015]  = '0.00   - No (not mentioned in the sources)'
                        THEN                                           'No (not mentioned in the sources)'
                        WHEN               [V5].[DecodedValue_2015]  = '0.00   - No (specifically mentioned in the sources)'
                        THEN                                           'No (specifically mentioned in the sources)'
                        WHEN               [V5].[Descr_2015]        IS NULL
                        THEN                                           'No description coded'
                        WHEN               [V5].[Descr_2015]         = ''
                        THEN                                           'No description coded'
                        ELSE               [V5].[Descr_2015]
                    END
        , [dcv]                                                      = [V5].[DecodedValue_2015]
        , [dsc]                                                      = [V5].[Descr_2015]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [qs_Question_Std_pk]                                       = [QS].[Question_Std_pk]
        , [qs_Question_abbreviation_std]                             = [QS].[Question_abbreviation_std]
        , [qs_Question_wording_std]                                  = [QS].[Question_wording_std]
        , [qs_Question_short_wording_std]                            = [QS].[Question_short_wording_std]
        , [qs_Display]                                               = [QS].[Display]
        , [qs_AnswerSet_num]                                         = [QS].[AnswerSet_num]
        , [qs_Editorially_Checked]                                   = [QS].[Editorially_Checked]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [qr_Question_pk]                                           = [QR].[Question_pk]
        , [qr_Question_abbreviation]                                 = [QR].[Question_abbreviation]
        , [qr_Question_wording]                                      = [QR].[Question_wording]
        , [qr_Question_Year]                                         = [QR].[Question_Year]
        , [qr_Notes]                                                 = [QR].[Notes]
        , [qr_Display]                                               = [QR].[Display]
        , [qr_Data_source_fk]                                        = [QR].[Data_source_fk]
        , [qr_Question_Std_fk]                                       = [QS].[Question_Std_pk]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
      --, [as_Answer_Std_pk]
        , [as_AnswerSet_number]                                      = [QS].[AnswerSet_num]
      --, [as_Answer_value_std]
      --, [as_Answer_Wording_std]
      --, [as_Full_set_of_Answers]
      --, [as_NA_by_set_of_Answers]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
      --, [ar_Answer_pk]
      --, [ar_Answer_value_NoStd]
      --, [ar_Answer_Wording]
      --, [ar_Answer_Std_fk]
        , [ar_Question_fk]                                           = [QR].[Question_pk]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
      --, [na_Nation_answer_pk]
        , [na_Nation_fk]                                             = [V5].[Nation_fk]
      --, [na_Answer_fk]
        , [na_display]                                               = 0
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
      --, [la_Locality_answer_pk]
        , [la_Locality_fk]                                           = [Cs].[Locality_fk]
      --, [la_Answer_fk]
        , [la_display]                                               = 0
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
      --, [ra_Nation_religion_answer_pk]
        , [ra_Nation_fk]                                             = [V5].[Nation_fk]
        , [ra_Religion_group_fk]                                     = [AQ].[Religion_fk]
      --, [ra_Answer_fk]
        , [ra_display]                                               = 0
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
    FROM                                        [NTValues]                                                   [V5]
  LEFT
  JOIN
                                                [TUValues]                                                   [tu]
      ON
          [V5].[Variable]
        = [tu].[Variable]
     AND
          [V5].[Nation_fk]
        = [tu].[Nation_fk]
INNER
JOIN
                                                [v06_CompletedCtry]                                          [V6]
    ON
        [V5].[Nation_fk]
      = [V6].[Nation_fk]
--left
JOIN
                                                [forum]..[Pew_Question_Std]                                  [QS]
    ON
        [V5].[Variable]
      = [QS].[Question_abbreviation_std]
--left
JOIN
                                                [forum]..[Pew_Question_NoStd]                                [QR]
    ON
        [QS].[Question_Std_pk]
      = [QR].[Question_Std_fk]
   AND  2015
      = [QR].[Question_Year]
--left
JOIN
                                                [forum]..[Pew_Data_Source]                                  [DS]
    ON
        [QR].[Data_source_fk]
      = [DS].[Data_source_pk]
--left
JOIN
                                                [All_Questions]                                              [AQ]
    ON
        [QS].[Question_Std_pk]
      = [AQ].[Question_Std_fk]
--left
JOIN
                                                [Countries]                                                  [Cs]
    ON
        [V5].[Nation_fk]
      = [Cs].[Nation_fk]


)
--
--select * from QsnCoded
--
,
LnkdVals AS
(  
  SELECT
/*                     -->    selection for testing consistency     -------------------------------------------------------------------------------------------*/
                              --   [QAs],
                              --   [AWs],
                              --   [AS].[Answer_Wording_std],
                              --   [AVn],
                              --   [AVs]                      = CASE WHEN [qs_AnswerSet_num] = 999999
                              --                                      AND [AVn]              > 1       THEN 1
                              --                                                                       ELSE [AVn]  END  ,
                              --   [qs_AnswerSet_num],
                              --   [DecodedValue_2015]
/*                     <--    selection for testing consistency     -------------------------------------------------------------------------------------------*/
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
          [CRL]
        , [dsn]
        , [R_5]
        , [R_6]
        , [Nfk]
        , [Rfk]
        , [Lfk]
        , [QSk]
        , [QRk]
        , [ASk]                                                      = [AS].[Answer_Std_pk]
        , [ARp]         =                DENSE_RANK() OVER (ORDER BY  
                                                                       [QRk]
                                                                     , [AVn]
                                                                     , [AWn] )
                                                         + (SELECT MAX([Answer_pk]) FROM [forum]..[Pew_Answer_NOStd])
        , [CEN]
        , [rel]
        , [loc]
        , [QAs]
        , [AVs]         = CASE 
                               WHEN
                                   [qs_AnswerSet_num] = 999999
                                AND
                                   [AVn]              > 1
                                                                  THEN 1
                                                                  ELSE [AVn]
                          END
        , [AVn]
        , [AWs]
        , [AWn]
        , [dcv]
        , [dsc]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [qs_Question_Std_pk]
        , [qs_Question_abbreviation_std]
        , [qs_Question_wording_std]
        , [qs_Question_short_wording_std]
        , [qs_Display]
        , [qs_AnswerSet_num]
        , [qs_Editorially_Checked]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [qr_Question_pk]
        , [qr_Question_abbreviation]
        , [qr_Question_wording]
        , [qr_Question_Year]
        , [qr_Notes]
        , [qr_Display]
        , [qr_Data_source_fk]
        , [qr_Question_Std_fk]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [as_Answer_Std_pk]                                         = [AS].[Answer_Std_pk]
        , [as_AnswerSet_number]
        , [as_Answer_value_std]                                      = [AS].[Answer_value_std]
        , [as_Answer_Wording_std]                                    = [AWs]
        , [as_Full_set_of_Answers]                                   = [AS].[Full_set_of_Answers]
        , [as_NA_by_set_of_Answers]                                  = [AS].[NA_by_set_of_Answers]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
      --, [ar_Answer_pk]
        , [ar_Answer_value_NoStd]                                    = [AVn]
        , [ar_Answer_Wording]                                        = [AWn]
        , [ar_Answer_Std_fk]                                         = [AS].[Answer_Std_pk]
        , [ar_Question_fk]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
      --, [na_Nation_answer_pk]
        , [na_Nation_fk]
      --, [na_Answer_fk]
        , [na_display]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
      --, [la_Locality_answer_pk]
        , [la_Locality_fk]
      --, [la_Answer_fk]
        , [la_display]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
      --, [ra_Nation_religion_answer_pk]
        , [ra_Nation_fk]
        , [ra_Religion_group_fk]
      --, [ra_Answer_fk]
        , [ra_display]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
    FROM                                        [QsnCoded]                                                   [QC]
--left
JOIN
                                                [forum]..[Pew_Answer_Std]                                    [AS]
    ON
        [qs_AnswerSet_num]
      = [AS].[AnswerSet_number]
   AND
		CASE 
        WHEN
        [qs_AnswerSet_num] = 999999
        AND
        [AVn]              > 1
        THEN                            1
        ELSE                           [AVn]
        END
      = [AS].[Answer_value_std]
   AND
                  [AWs]
      = LEFT([AS].[Answer_Wording_std],246)         /* Access field allows only 255 ch -- =246 when leaving only std wording of selected answer                */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*                     -->    selection for testing consistency     -------------------------------------------------------------------------------------------*/
                              --     WHERE [AS].[Answer_value_std]  IS     NULL
                              ------ WHERE      [AVs]               IS     NULL
                              ------ WHERE      [QAs]               LIKE 'XSG_S_99_0%'
/*                     <--    selection for testing consistency     -------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
)
--
--   select *               from [LnkdVals] order by [ARp] 
--   select distinct [ARp]  from [LnkdVals] order by [ARp] 
--           where QAs in   (  )
--
,
CNA AS
(
  SELECT
          [CRL]
        , [dsn]
        , [R_5]
        , [R_6]
        , [Nfk]
        , [Rfk]
        , [Lfk]
        , [QSk]
        , [QRk]
        , [ASk]
        , [ARp]
        , [CEN]
        , [rel]
        , [loc]
        , [QAs]
        , [AVs]
        , [AVn]
        , [AWs]
        , [AWn]
        , [dcv]
        , [dsc]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [qs_Question_Std_pk]
        , [qs_Question_abbreviation_std]
        , [qs_Question_wording_std]
        , [qs_Question_short_wording_std]
        , [qs_Display]
        , [qs_AnswerSet_num]
        , [qs_Editorially_Checked]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [qr_Question_pk]
        , [qr_Question_abbreviation]
        , [qr_Question_wording]
        , [qr_Question_Year]
        , [qr_Notes]
        , [qr_Display]
        , [qr_Data_source_fk]
        , [qr_Question_Std_fk]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [as_Answer_Std_pk]
        , [as_AnswerSet_number]
        , [as_Answer_value_std]
        , [as_Answer_Wording_std]
        , [as_Full_set_of_Answers]
        , [as_NA_by_set_of_Answers]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [ar_Answer_pk]                                             = [ARp]
        , [ar_Answer_value_NoStd]
        , [ar_Answer_Wording]
        , [ar_Answer_Std_fk]
        , [ar_Question_fk]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [na_Nation_answer_pk]          = CASE WHEN                   [CRL] = 'Ctry' 
                                                THEN     ROW_NUMBER( )
                                                         OVER(ORDER BY [ARp])
                                                         + (SELECT MAX([Nation_answer_pk]) FROM [forum]..[Pew_Nation_Answer]) END
        , [na_Nation_fk]
        , [na_Answer_fk]                                             = [ARp]
        , [na_display]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [la_Locality_answer_pk]        = CASE WHEN                   [CRL] = 'Prov' 
                                                THEN     ROW_NUMBER( )
                                                         OVER(ORDER BY [ARp])
                                                         + (SELECT MAX([Locality_answer_pk]) FROM [forum]..[Pew_Locality_Answer]) END
        , [la_Locality_fk]
        , [la_Answer_fk]                                             = [ARp]
        , [la_display]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
        , [ra_Nation_religion_answer_pk] = CASE WHEN                   [CRL] = 'RGrp' 
                                                THEN     ROW_NUMBER( )
                                                         OVER(ORDER BY [ARp])
                                                         + (SELECT MAX([Nation_religion_answer_pk]) FROM [forum]..[Pew_Nation_Religion_Answer]) END
        , [ra_Nation_fk]
        , [ra_Religion_group_fk]
        , [ra_Answer_fk]                                             = [ARp]
        , [ra_display]
/*    ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
    FROM                                        [LnkdVals]                                                   [LV]

)

SELECT *
  FROM [CNA]

