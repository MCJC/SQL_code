--SELECT distinct id, DENSE_RANK() OVER (ORDER BY  id) AS RowNum
--FROM table
--WHERE fid = 64





/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 3.002    ---------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the 




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
          [Nfk]                                                        =  [V5].[Nation_fk]
        , [na_Nation_fk]                                               =  [V5].[Nation_fk]
        , [ra_Nation_fk]                                               =  [V5].[Nation_fk]
        , [CEN] =  [V5].[Ctry_EditorialName]
        , [QAs] =  [V5].[Variable]
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
        ,                                                              [V5].[DecodedValue_2015]
        ,                                                              [V5].[Descr_2015]
        , [QSk]                                                      = [QS].[Question_Std_pk]
        , [qs_Question_Std_pk]                                       = [QS].[Question_Std_pk]
        , [qr_Question_Std_fk]                                       = [QS].[Question_Std_pk]
        , [QRk]                                                      = [QR].[Question_pk]
        , [qr_Question_pk]                                           = [QR].[Question_pk]
        , [ar_Question_fk]                                           = [QR].[Question_pk]
        , [qs_Display]                                               = [QS].[Display]
        , [qr_Display]                                               = [QR].[Display]
        , [na_display]                                               = 0
        , [la_display]                                               = 0
        , [ra_display]                                               = 0
        , [qs_Question_abbreviation_std]                             = [QS].[Question_abbreviation_std]
        , [qs_Question_wording_std]                                  = [QS].[Question_wording_std]
        , [qs_Question_short_wording_std]                            = [QS].[Question_short_wording_std]
        , [qs_AnswerSet_num]                                         = [QS].[AnswerSet_num]
        , [as_AnswerSet_number]                                      = [QS].[AnswerSet_num]
        , [qs_Editorially_Checked]                                   = [QS].[Editorially_Checked]
        , [qr_Question_abbreviation]                                 = [QR].[Question_abbreviation]
        , [qr_Question_wording]                                      = [QR].[Question_wording]
        , [qr_Question_Year]                                         = [QR].[Question_Year]
        , [qr_Notes]                                                 = [QR].[Notes]
        , [qr_Data_source_fk]                                        = [QR].[Data_source_fk]
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
          [Nfk]
        , [CEN]
        , [QAs]
        , [AVn]
        , [AVs]         = CASE 
                               WHEN
                                   [qs_AnswerSet_num] = 999999
                                AND
                                   [AVn]              > 1
                                                                  THEN 1
                                                                  ELSE [AVn]
                          END
        , [AWs]
        , [AWn]
        , [QSk]
        , [QRk]
        , [ASk]                                                      = [AS].[Answer_Std_pk]
        , [ARp]                                                      =  
		                                        DENSE_RANK() OVER (ORDER BY  
                                                                            [QRk]
                                                                          , [AVn]
                                                                          , [AWn] )
                                                              + (SELECT MAX([Answer_pk]) FROM [forum]..[Pew_Answer_NOStd])
        , [as_Answer_Std_pk]                                         = [AS].[Answer_Std_pk]
        , [ar_Answer_Std_fk]                                         = [AS].[Answer_Std_pk]
        , [DecodedValue_2015]
        , [Descr_2015]
        , [na_Nation_fk]
        , [ra_Nation_fk]
        , [qs_Question_Std_pk]
        , [qr_Question_Std_fk]
        , [qr_Question_pk]
        , [ar_Question_fk]
        , [qs_Display]
        , [qr_Display]
        , [na_display]
        , [la_display]
        , [ra_display]
        , [qs_Question_abbreviation_std]
        , [qs_Question_wording_std]
        , [qs_Question_short_wording_std]
        , [qs_AnswerSet_num]
        , [as_AnswerSet_number]
        , [qs_Editorially_Checked]
        , [qr_Question_abbreviation]
        , [qr_Question_wording]
        , [qr_Question_Year]
        , [qr_Notes]
        , [qr_Data_source_fk]
        , [ar_Answer_value_NoStd]                                    = [AVn]
        , [ar_Answer_Wording]                                        = [AWn]
        , [as_Answer_value_std]                                      = [AS].[Answer_value_std]
        , [as_Answer_Wording_std]                                    = [AWs]
        , [as_Full_set_of_Answers]                                   = [AS].[Full_set_of_Answers]
        , [as_NA_by_set_of_Answers]                                  = [AS].[NA_by_set_of_Answers]


          [Nfk]
        , [CEN]
        , [QAs]
        , [AVs]
        , [AWs]
        , [QSk]
        , [ASk]
        , [DecodedValue_2015]
        , [Descr_2015]
        , [qs_Question_Std_pk]
        , [qs_Question_abbreviation_std]
        , [qs_Question_wording_std]
        , [qs_Question_short_wording_std]
        , [qs_Display]
        , [qs_AnswerSet_num]
        , [qs_Editorially_Checked]
        , [qr_Question_pk]
        , [qr_Question_abbreviation]
        , [qr_Question_wording]
        , [qr_Question_Year]
        , [qr_Notes]
        , [qr_Display]
        , [qr_Data_source_fk]
        , [qr_Question_Std_fk]
        , [as_Answer_Std_pk]
        , [as_AnswerSet_number]
        , [as_Answer_value_std]
        , [as_Answer_Wording_std]
        , [as_Full_set_of_Answers]
        , [as_NA_by_set_of_Answers]
        , [ar_Answer_pk]                                             = [ARp]
        , [ar_Answer_value_NoStd]
        , [ar_Answer_Wording]
        , [ar_Answer_Std_fk]
        , [ar_Question_fk]
        --, [na_Nation_answer_pk]
        , [na_Nation_fk]
        , [na_Answer_fk]                                             = [ARp]
        , [na_display]
        --, [la_Locality_answer_pk]
        --, [la_Locality_fk]
        , [la_Answer_fk]                                             = [ARp]
        , [la_display]
        --, [ra_Nation_religion_answer_pk]
        , [ra_Nation_fk]
        --, [ra_Religion_group_fk]
        , [ra_Answer_fk]                                             = [ARp]
        , [ra_display]




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
   select distinct [ARp]  from [LnkdVals] order by [ARp] 
--           where QAs in   (  )
--
/*
,
SrtdAnsK AS
(
  SELECT
          [ARp] =   ROW_NUMBER ( ) OVER  
                     (ORDER BY  
                                [QRk]
                              , [AVn]
                              , [AWn] )
                  + (SELECT MAX([Answer_pk]) FROM [forum]..[Pew_Answer_NOStd])
        , *
    FROM
          (


            SELECT
                                    DISTINCT
                                    [QRk]
                                  , [AVn]
                                  , [AWn]
/*                           -->    added variable for testing consistency    ---------------------------------------------------------------------------------*/
                             --   , [ASk]
/*                           <--    added variable for testing consistency    ---------------------------------------------------------------------------------*/
              FROM                  [LnkdVals]


			                                   )  SelVals
)
--,
--NewCVals AS
--(
  SELECT
          [Nfk]
        , [CEN]
        , [QAs]
        , [AVs]
        , [AWs]
        , [QSk]
        , [ASk]
        , [DecodedValue_2015]
        , [Descr_2015]
        , [qs_Question_Std_pk]
        , [qs_Question_abbreviation_std]
        , [qs_Question_wording_std]
        , [qs_Question_short_wording_std]
        , [qs_Display]
        , [qs_AnswerSet_num]
        , [qs_Editorially_Checked]
        , [qr_Question_pk]
        , [qr_Question_abbreviation]
        , [qr_Question_wording]
        , [qr_Question_Year]
        , [qr_Notes]
        , [qr_Display]
        , [qr_Data_source_fk]
        , [qr_Question_Std_fk]
        , [as_Answer_Std_pk]
        , [as_AnswerSet_number]
        , [as_Answer_value_std]
        , [as_Answer_Wording_std]
        , [as_Full_set_of_Answers]
        , [as_NA_by_set_of_Answers]
        , [ar_Answer_pk]                                             = [ARp]
        , [ar_Answer_value_NoStd]
        , [ar_Answer_Wording]
        , [ar_Answer_Std_fk]
        , [ar_Question_fk]
        --, [na_Nation_answer_pk]
        , [na_Nation_fk]
        , [na_Answer_fk]                                             = [ARp]
        , [na_display]
        --, [la_Locality_answer_pk]
        --, [la_Locality_fk]
        , [la_Answer_fk]                                             = [ARp]
        , [la_display]
        --, [ra_Nation_religion_answer_pk]
        , [ra_Nation_fk]
        --, [ra_Religion_group_fk]
        , [ra_Answer_fk]                                             = [ARp]
        , [ra_display]

    FROM                                        [LnkdVals]                                                   [LV]
--left
  JOIN
                                                [SrtdAnsK]                                                   [AR]
      ON
          [LV].[AVn]
        = [AR].[AVn]
     AND
          [LV].[AWn]
        = [AR].[AWn]
     AND
          [LV].[QRk]
        = [AR].[QRk]

/*
/*
)


select * from NewCVals

/*

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[GRI_01]
      ,[GRI_01_x]
      ,[GRI_01_x2]
      ,[GRI_02]
      ,[GRI_03]
      ,[GRI_04]
      ,[GRI_05]
      ,[GRI_06]
      ,[GRI_07]
      ,[GRI_08]
      ,[GRI_08_a]
      ,[GRI_09]
      ,[GRI_10]
      ,[GRI_10_01]
      ,[GRI_10_02]
      ,[GRI_10_03]
      ,[GRI_11]
      ,[GRI_11_01a]
      ,[GRI_11_01b]
      ,[GRI_11_02]
      ,[GRI_11_03]
      ,[GRI_11_04]
      ,[GRI_11_05]
      ,[GRI_11_06]
      ,[GRI_11_07]
      ,[GRI_11_08]
      ,[GRI_11_09]
      ,[GRI_11_10]
      ,[GRI_11_11]
      ,[GRI_11_12]
      ,[GRI_11_13]
      ,[GRI_11_14]
      ,[GRI_11_15]
      ,[GRI_11_16]
      ,[GRI_11_17]
      ,[GRI_12]
      ,[GRI_13]
      ,[GRI_14]
      ,[GRI_15]
      ,[GRI_16]
      ,[GRI_16_01]
      ,[GRI_17]
      ,[GRI_18]
      ,[GRI_19]
      ,[GRI_19_b]
      ,[GRI_19_c]
      ,[GRI_19_d]
      ,[GRI_19_e]
      ,[GRI_19_f]
      ,[GRI_20_01]
      ,[GRI_20_01x_01a]
      ,[GRI_20_01x_01b]
      ,[GRI_20_01x_02]
      ,[GRI_20_01x_03]
      ,[GRI_20_01x_04]
      ,[GRI_20_01x_05]
      ,[GRI_20_01x_06]
      ,[GRI_20_01x_07]
      ,[GRI_20_01x_08]
      ,[GRI_20_01x_09]
      ,[GRI_20_01x_10]
      ,[GRI_20_02]
      ,[GRI_20_03_a]
      ,[GRI_20_03_b]
      ,[GRI_20_03_c]
      ,[GRI_20_04]
      ,[GRI_20_04_x]
      ,[GRI_20_05]
      ,[GRI_20_05_x]
      ,[GRI_20_05_x1]
      ,[GRX_21_01]
      ,[GRX_21_02]
      ,[GRX_21_03]
      ,[GRX_22]
      ,[GRX_22_01]
      ,[GRX_22_02]
      ,[GRX_22_03]
      ,[GRX_22_04]
      ,[GRX_23]
      ,[GRX_24]
      ,[GRX_25_01]
      ,[GRX_25_02]
      ,[GRX_25_03]
      ,[GRX_26_01]
      ,[GRX_26_02]
      ,[GRX_26_03]
      ,[GRX_26_04]
      ,[GRX_26_05]
      ,[GRX_26_06]
      ,[GRX_26_07]
      ,[GRX_26_08]
      ,[GRX_27_01]
      ,[GRX_27_02]
      ,[GRX_27_03]
      ,[GRX_28_01]
      ,[GRX_28_02]
      ,[GRX_28_03]
      ,[GRX_29_01]
      ,[GRX_29_02]
      ,[GRX_29_03]
      ,[GRX_29_04]
      ,[GRX_29_05]
      ,[GRX_30]
      ,[GRX_31]
      ,[GRX_32]
      ,[GRX_33]
      ,[GRX_34_01]
      ,[GRX_34_02_a]
      ,[GRX_34_02_b]
      ,[GRX_34_02_c]
      ,[GRX_34_02_d]
      ,[GRX_34_02_e]
      ,[GRX_34_02_f]
      ,[GRX_34_02_g]
      ,[GRX_34_03]
      ,[GRX_35_01]
      ,[GRX_35_02]
      ,[SHI_01_a]
      ,[SHI_01_b]
      ,[SHI_01_c]
      ,[SHI_01_d]
      ,[SHI_01_e]
      ,[SHI_01_f]
      ,[SHI_01_x_01a]
      ,[SHI_01_x_01b]
      ,[SHI_01_x_02]
      ,[SHI_01_x_03]
      ,[SHI_01_x_04]
      ,[SHI_01_x_05]
      ,[SHI_01_x_06]
      ,[SHI_01_x_07]
      ,[SHI_01_x_08]
      ,[SHI_01_x_09]
      ,[SHI_01_x_10]
      ,[SHI_01_x_11]
      ,[SHI_01_x_12]
      ,[SHI_01_x_13]
      ,[SHI_01_x_14]
      ,[SHI_01_x_15]
      ,[SHI_01_x_16]
      ,[SHI_01_x_17]
      ,[SHI_02]
      ,[SHI_02_01]
      ,[SHI_03]
      ,[SHI_04]
      ,[SHI_04_b]
      ,[SHI_04_c]
      ,[SHI_04_d]
      ,[SHI_04_e]
      ,[SHI_04_f]
      ,[SHI_04_x01]
      ,[SHI_05]
      ,[SHI_05_b]
      ,[SHI_05_c]
      ,[SHI_05_d]
      ,[SHI_05_e]
      ,[SHI_05_f]
      ,[SHI_06]
      ,[SHI_07]
      ,[SHI_08]
      ,[SHI_09]
      ,[SHI_09_n]
      ,[SHI_10]
      ,[SHI_10_n]
      ,[SHI_11]
      ,[SHI_11_a]
      ,[SHI_11_a_n]
      ,[SHI_11_b]
      ,[SHI_11_b_n]
      ,[SHI_11_x]
      ,[SHI_12]
      ,[SHI_13]
      ,[SHX_14_01]
      ,[SHX_14_02]
      ,[SHX_14_03]
      ,[SHX_14_04]
      ,[SHX_15_01]
      ,[SHX_15_02]
      ,[SHX_15_03]
      ,[SHX_15_04]
      ,[SHX_15_05]
      ,[SHX_15_06]
      ,[SHX_15_07]
      ,[SHX_15_08]
      ,[SHX_15_09]
      ,[SHX_15_10]
      ,[SHX_25]
      ,[SHX_26]
      ,[SHX_27_01]
      ,[SHX_27_02]
      ,[SHX_27_03]
      ,[SHX_28_01]
      ,[SHX_28_02]
      ,[SHX_28_03]
      ,[SHX_28_04]
      ,[SHX_28_05]
      ,[SHX_28_06]
      ,[SHX_28_07]
      ,[SHX_28_08]
      ,[XSG_24]
      ,[XSG_S_01]
      ,[XSG_S_02]
      ,[XSG_S_03]
      ,[XSG_S_04]
      ,[XSG_S_05]
      ,[XSG_S_06]
      ,[XSG_S_07]
      ,[XSG_S_08]
      ,[XSG_S_09]
      ,[XSG_S_10]
      ,[XSG_S_11]
      ,[XSG_S_12]
      ,[XSG_S_13]
      ,[XSG_S_14]
      ,[XSG_S_15]
      ,[XSG_S_16]
      ,[XSG_S_17]
      ,[XSG_S_18]
      ,[XSG_S_19]
      ,[XSG_S_20]
      ,[XSG_S_21]
      ,[XSG_S_22]
      ,[XSG_S_23]
      ,[XSG_S_99_01]
      ,[XSG_S_99_02]
      ,[XSG_S_99_03]
      ,[XSG_S_99_04]
      ,[XSG_S_99_05]
      ,[XSG_S_99_06]
  FROM [forum_ResAnal].[dbo].[vr___02_]


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
         =                                            [SHI_11_b]






---classified values, get PANS k using groed by
select * from 
--[LnkdVals]
NewCVals






/* NOTE: scaled GRI_19_ b to f requested by Peter Henne in 2015 */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_19_b, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
                   GRI_19_b_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_b   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_b   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_b   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_b   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_b   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_b   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
/* GRI_19_c, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
       ,           GRI_19_c_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_c   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_c   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_c   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_c   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_c   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_c   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
/* GRI_19_d, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
       ,           GRI_19_d_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_d   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_d   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_d   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_d   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_d   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_d   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
/* GRI_19_e, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
       ,           GRI_19_e_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_e   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_e   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_e   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_e   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_e   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_e   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
/* GRI_19_f, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
       ,           GRI_19_f_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_f   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_f   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_f   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_f   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_f   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_f   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* NOTE: scaled GRI_19_ b to f requested by Peter Henne in 2015 ends here */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* NOTE: scaled index values based in year 2007 */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_scaled index */
      ,  GRI_scaled 
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_rounded index */
      ,  GRI_rd_1d 
         =        CAST ((
                                  GRI 
                                                               ) AS DECIMAL (38,1))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI_rounded index */
      ,  SHI_rd_1d 
         =        CAST ((
                                  SHI 
                                                               ) AS DECIMAL (38,1))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI_rounded index */
      ,  GFI_rd_1d 
         =        CAST ((
                                  GFI
                                                               ) AS DECIMAL (38,1))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , *

FROM
/***************************************************************************************************************************************************************/
(
/*** table including numeric values + Step-2 calculated variables **********************************************************************************************/
SELECT
/* Indexes wiolll NOT fit previously published data  ----------------------------------------------------------------------------------------------------------*/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI index */
         GRI 
         =
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
                                                                  ) AS DECIMAL (38,32))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI index */
       , SHI 
         =        CAST ((((
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
                                                                  ) AS DECIMAL (38,32))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI index */
       , GFI 
         =        CAST ((((
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
                                                                  ) AS DECIMAL (38,32))
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
       ,           SHI_01_summary_a_ny
       = CAST ((
         CASE 
              WHEN SHI_01     =  0.00
              THEN               0.00
              WHEN SHI_01     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nya
       = CAST ((
         CASE 
              WHEN SHI_01_a   >  0.00
              THEN               1.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nyb
       = CAST ((
         CASE 
              WHEN SHI_01_b   >  0.00
              THEN               1.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nyc
       = CAST ((
         CASE 
              WHEN SHI_01_c   >  0.00
              THEN               1.03
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nyd
       = CAST ((
         CASE 
              WHEN SHI_01_d   >  0.00
              THEN               1.04
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nye
       = CAST ((
         CASE 
              WHEN SHI_01_e   >  0.00
              THEN               1.05
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nyf
       = CAST ((
         CASE 
              WHEN SHI_01_f   >  0.00
              THEN               1.06
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 XSG_242526_ny           for toplines */
--       ,           XSG_242526_ny
--       = CAST ((
--         CASE WHEN GRX_24     = 0.00
--               AND SHX_25     = 0.00
--               AND SHX_26     = 0.00
--              THEN              0.00
--              WHEN GRX_24     > 0.00
--                OR SHX_25     > 0.00
--                OR SHX_26     > 0.00
--              THEN              0.01
--              END
--                                                               ) AS DECIMAL (38,2))
--       ,           XSG_242526_ny1
--       = CAST ((
--         CASE WHEN GRX_24     = 0.00
--               AND SHX_25     = 0.00
--               AND SHX_26     = 0.00
--              THEN              NULL
--              WHEN GRX_24     = 1.00
--                OR SHX_25     = 1.00
--                OR SHX_26     = 1.00
--              THEN              1.00
--              WHEN GRX_24     = 0.67
--                OR SHX_25     = 0.67
--                OR SHX_26     = 0.67
--              THEN              0.67
--              WHEN GRX_24     = 0.33
--                OR SHX_25     = 0.33
--                OR SHX_26     = 0.33
--              THEN              0.33
--              END
--                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 XSG_25n27_ny           for toplines */
--       ,           XSG_25n27_ny
--       = CAST ((
--         CASE WHEN GRX_25_ny  = 0.00
--               AND SHX_27_ny  = 0.00
--              THEN              0.00
--              WHEN GRX_25_ny  = 0.01
--                OR SHX_27_ny  = 0.01
--              THEN              0.01
--              END
--                                                               ) AS DECIMAL (38,2))
--       ,           XSG_25n27_ny2
--       = CAST ((
--         CASE WHEN GRX_25_ny2 = 0.02
--                OR SHX_27_ny2 = 0.02
--              THEN              0.02
--              END
--                                                               ) AS DECIMAL (38,2))
--       ,           XSG_25n27_ny3
--       = CAST ((
--         CASE WHEN GRX_25_ny3 = 0.03
--                OR SHX_27_ny3 = 0.03
--              THEN              0.03
--              END
--                                                               ) AS DECIMAL (38,2))
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


--       , SHI_01_summary_b
--         =        CAST ((
--                  (
--                  CAST ((
--                    ( CASE
--                      WHEN SHI_01_a > 0 THEN 1
--                      ELSE                   0
--                       END                     )
--                  + ( CASE
--                      WHEN SHI_01_b > 0 THEN 1
--                      ELSE                   0
--                       END                     )
--                  + ( CASE
--                      WHEN SHI_01_c > 0 THEN 1
--                      ELSE                   0
--                       END                     )
--                  + ( CASE
--                      WHEN SHI_01_d > 0 THEN 1
--                      ELSE                   0
--                       END                     )
--                  + ( CASE
--                      WHEN SHI_01_e > 0 THEN 1
--                      ELSE                   0
--                       END                     )
--                  + ( CASE
--                      WHEN SHI_01_f > 0 THEN 1
--                      ELSE                   0
--                       END                     )
                                                       
--                                                               ) AS DECIMAL (38,2))
--                                                                                    / 6 )
--                                                               ) AS DECIMAL (38,2))
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
                  --     + isnull(GRI_11_14, 0)
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
                  --     + isnull(SHI_01_x_14, 0)
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
         =                                            [SHI_11_b]
         --         CAST ((
         --         CASE
         --         WHEN SHI_11  = 0.5
         --         THEN           1
         --         ELSE SHI_11
         --         END
         --                                                      ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_16               for toplines */
       ,           GRI_16_ny
       = CAST ((
         CASE 
              WHEN GRI_16     =  0.00
              THEN               0.00
              WHEN GRI_16     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_16_ny1
       = CAST ((
         CASE 
              WHEN GRI_16     =  0.00
              THEN               NULL
              WHEN GRI_16     >  0.00
              THEN               GRI_16
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19               for toplines */
       ,           GRI_19_ny
       = CAST ((
         CASE 
              WHEN GRI_19     =  0.00
              THEN               0.00
              WHEN GRI_19     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_ny1
       = CAST ((
         CASE 
              WHEN GRI_19     =  0.00
              THEN               NULL
              WHEN GRI_19     >  0.00
              THEN               GRI_19
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19_summ_ny          for toplines */
       ,           GRI_19_summ_ny
       = CAST ((
         CASE 
              WHEN GRI_19     =  0.00
              THEN               0.00
              WHEN GRI_19     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nyb
       = CAST ((
         CASE 
              WHEN GRI_19_b   >  0.00
              THEN               1.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nyc
       = CAST ((
         CASE 
              WHEN GRI_19_c   >  0.00
              THEN               1.03
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nyd
       = CAST ((
         CASE 
              WHEN GRI_19_d   >  0.00
              THEN               1.04
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nye
       = CAST ((
         CASE 
              WHEN GRI_19_e   >  0.00
              THEN               1.05
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nyf
       = CAST ((
         CASE 
              WHEN GRI_19_f   >  0.00
              THEN               1.06
         END
                                                               ) AS DECIMAL (38,2))
---------------------------
/*                 SHI_04_ny          for toplines */
       ,           SHI_04_ny
       = CAST ((
         CASE 
              WHEN SHI_04     =  0.00
              THEN               0.00
              WHEN SHI_04     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_04_ny1
       = CAST ((
         CASE 
              WHEN SHI_04     =  0.00
              THEN               NULL
              WHEN SHI_04     >  0.00
              THEN               SHI_04
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_05_ny          for toplines */
       ,           SHI_05_ny
       = CAST ((
         CASE 
              WHEN SHI_05     =  0.00
              THEN               0.00
              WHEN SHI_05     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_05_ny1
       = CAST ((
         CASE 
              WHEN SHI_05     =  0.00
              THEN               NULL
              WHEN SHI_05     >  0.00
              THEN               SHI_05
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_07_ny          for toplines */
       ,           SHI_07_ny
       = CAST ((
         CASE 
              WHEN SHI_07     =  0.00
              THEN               0.00
              WHEN SHI_07     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_07_ny1
       = CAST ((
         CASE 
              WHEN SHI_07     =  0.00
              THEN               NULL
              WHEN SHI_07     >  0.00
              THEN               SHI_07
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_01_x              for toplines??? - added on Dec2015  */
--       ,           SHI_01_x
--       =           ISNULL(SHI_01_b, 0)
--                 + ISNULL(SHI_01_c, 0)
--                 + ISNULL(SHI_01_d, 0)
--                 + ISNULL(SHI_01_e, 0)
--                 + ISNULL(SHI_01_f, 0)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22               for toplines */
--     ,           GRX_22_ny1    => this was the former name
       ,           GRX_22_aggreg
       = CAST ((
         CASE WHEN --ISNULL(GRX_22   , 9)  = 9
               --AND
                   ISNULL(GRX_22_01, 9)  = 9
               AND ISNULL(GRX_22_02, 9)  = 9
               AND ISNULL(GRX_22_04, 9)  = 9
              THEN               NULL
              WHEN --ISNULL(GRX_22   , 0)  < 0.66
               --AND 
                   ISNULL(GRX_22_01, 0)  < 0.66
               AND ISNULL(GRX_22_02, 0)  < 0.66
               AND ISNULL(GRX_22_04, 0)  < 0.66
              THEN              0
              WHEN --ISNULL(GRX_22   , 0)  < 1.00
               --AND 
                   ISNULL(GRX_22_01, 0)  < 1.00
               AND ISNULL(GRX_22_02, 0)  < 1.00
               AND ISNULL(GRX_22_04, 0)  < 1.00
              THEN              0.67
              WHEN --GRX_22     = 1.00
                --OR 
                   GRX_22_01  = 1.00
                OR GRX_22_02  = 1.00
                OR GRX_22_04  = 1.00
              THEN              1.00
--              ELSE 1000                       /*this for checking any value non-recoded*/
              END
                                                               ) AS DECIMAL (38,2))
/* current does not display "NO" -- this would be just a dummy but it has NOT BEEN TESTED: */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_01               for toplines */
       ,           GRX_22_01_ny
       = CAST ((
         CASE WHEN GRX_22_01  < 0.66
              THEN              0
              WHEN GRX_22_01 >= 0.66
              THEN              0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_01_ny1
       = CAST ((
         CASE WHEN GRX_22_01  < 0.66
              THEN              NULL
              WHEN GRX_22_01 >= 0.66
              THEN              GRX_22_01
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_02               for toplines */
       ,           GRX_22_02_ny
       = CAST ((
         CASE WHEN GRX_22_02  < 0.66
              THEN              0
              WHEN GRX_22_02 >= 0.66
              THEN              0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_02_ny1
       = CAST ((
         CASE WHEN GRX_22_02  < 0.66
              THEN              NULL
              WHEN GRX_22_02 >= 0.66
              THEN              GRX_22_02
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_03               for toplines */
       ,           GRX_22_03_ny
       = CAST ((
         CASE WHEN GRX_22_03  <  0.66
              THEN               0
              WHEN GRX_22_03 >=  0.66
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_03_ny1
       = CAST ((
         CASE WHEN GRX_22_03  <  0.66
              THEN               NULL
              WHEN GRX_22_03 >=  0.66
              THEN               GRX_22_03
        END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_04               for toplines */
       ,           GRX_22_04_ny
       = CAST ((
         CASE WHEN GRX_22_04  <  0.66
              THEN               0
              WHEN GRX_22_04 >=  0.66
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_04_ny1
       = CAST ((
         CASE WHEN GRX_22_04  <  0.66
              THEN               NULL
              WHEN GRX_22_04 >=  0.66
              THEN               GRX_22_04
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , *
FROM





--SELECT TOP 1000 [Answer_pk]
--      ,[Answer_value_NoStd]
--      ,[Answer_Wording]
--      ,[Answer_Std_fk]
--      ,[Question_fk]
--  FROM [forum].[dbo].[Pew_Answer_NoStd]











----SrtdAnsR AS
----(
----  SELECT
----          [Answer_pk_TEMP]       = ROW_NUMBER ( )   
----    OVER ( ORDER BY  
----                                    [QRk]
----                                  , [AVs]
----                                  , [AWn] )
----        , [Answer_value_NoStd]   =  [AVs]
----        , [Answer_Wording]       =  [AWn]
----        , [Answer_Std_fk]        =  [ASk]
----        , [Question_fk]          =  [QRk]--, *
----    FROM
----          ( SELECT
----                                    DISTINCT
----                                    [QRk]
----                                  , [AVs]
----                                  , [AWn]
----                                  , [ASk]
----              FROM                  [LnkdVals] )  SelVals
----)




*/

*/
*/
*/