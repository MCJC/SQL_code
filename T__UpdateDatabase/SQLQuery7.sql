--USE [forum]
--GO
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***      The long set of data includes numeric values and descriptive wordings for GR&SH R                                                                  ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
--SELECT *
--FROM             [forum_ResAnal].[dbo].[vr_01w_DB_Long_NoAggregated]  --  170,623




----/********************************************************************************************************************/
----IF OBJECT_ID('tempdb..#DR2013')         IS NOT NULL
----DROP TABLE           [#DR2013]
----GO
----/********************************************************************************************************************/
----/*** Set of data coded in the working summer-period *****************************************************************/
SELECT
           entity              = 'CR&P'
      ,    link_fk             = 0
      ,   [Nation_fk]
      ,    Locality_fk         = NULL
      ,    Religion_fk         = NULL
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,    Locality            = ''
      ,    Religion            = ''
      ,   [Question_Year]      = SUBSTRING([Question_Year], 6, 4)
      ,   [QA_std]
      ,   [QW_std]
      ,   [Answer_value]       =      CAST([Answer_value]   AS DECIMAL(38,2))
      ,   [answer_wdg_NoStd]   =           [answer_wording]
      ,   [answer_wording_std]
      ,    Question_fk         = 0
      ,    Answer_fk           = 0
      ,   [Notes]              = 'January - December 2013' 
      ,   [QS_fk]
----  INTO [#DR2013]
------select *
  FROM [GRSHR2014].[dbo].[s13_AllLongVals&Desc]
WHERE
          [Question_Year] =     'Year_2013'                       ---- only 2013, other data added to include variables not used in 2013
----  AND
----          [QA_std]  NOT IN (  
----                                'SHI_01_summary_b'                ---- 32,076
----                              , 'GRI_19_x'                        ---- 31,878
----                              , 'SHI_01_x'                        ---- 31,680
----                              , 'SHI_04_x'                        ---- 31,482
----                              , 'SHI_05_x'                        ---- 31,284
------                              --, 'SHI_05_filter'
------                              --, 'GRI_02_filter'
------                              --, 'XSG_S_99_filter'
------                              --, 'SHI_04_filter'
------                              --, 'GRI_01_filter'
------                              --, 'GRI_19_filter'
------                              --, 'GRI_02_yBe'
------                              --, 'GRI_01_yBe'  
----                                      )                           ---- 31,086 
----                                                                  ---- 29 927 
----                                                                  ----  1 159 
----  AND NOT
----          (
----                QA_std LIKE 'XSG_S_99_0%'
----           AND  QW_std LIKE '%] used for coding government restrictions and social hostilities on religion?'
----           AND  Answer_value        IS NULL
----           AND  answer_wording      IS NULL
----           AND  answer_wording_std  IS NULL    )                  ----1,158
----/***************************************************************  Set of data coded in the working summer-period  ***/




--/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT [Answer_pk]
--      ,[Answer_value_NoStd]              =   [Answer_value]
--      ,[Answer_Wording]                  =   [answer_wording]
--      ,[Answer_Std_fk]                   =   [Answer_Std_pk]
--      ,[Question_fk]                     =   [Question_pk]
--  FROM [forum].[dbo].[Pew_Answer_NoStd]





/********************************************************************************************************************/
/********************************************************************************************************************/
IF OBJECT_ID('tempdb..#codedDR')         IS NOT NULL
DROP TABLE           [#codedDR]
GO
/********************************************************************************************************************/
SELECT *
INTO   [#codedDR]
FROM
(
/********************************************************************************************************************/
SELECT
          D13.[entity]
      ,   D13.[link_fk]
      ,   D13.[Nation_fk]
      ,   D13.[Locality_fk]
      ,   D13.[Religion_fk]
      ,   D13.[Region5]
      ,   D13.[Region6]
      ,   D13.[Ctry_EditorialName]
      ,   D13.[Locality]
      ,   D13.[Religion]
      ,   D13.[Question_Year]
      ,   D13.[QA_std]
      ,   D13.[QW_std]
      ,   AST.[Answer_value_std]
      ,   D13.[Answer_value]
/*==================================================================================================================*/
      ,       [answer_wdg_NoStd]    =  case
                                            when
/*----------------------------------------- nmeric variables -------------------------------------------------------*/
                                                 (    QST.[AnswerSet_num]      = 999999
                                                  and D13.[answer_wdg_NoStd]    IS NULL
                                                  and D13.[Answer_value]       =      0  )
/*----------------------------------------- variables with no descriptions coded -----------------------------------*/
                                              or (    D13.[QA_std]            in (  'GRI_08_a'
                                                                                  , 'GRI_19'
                                                                                  , 'GRI_20_05_x'
                                                                                  , 'GRX_29_01'
                                                                                  , 'SHI_05'
                                                                                  , 'SHI_11_a'   )  )   -- vars
/*----------------------------------------- sets of variables with no descriptions coded ---------------------------*/
                                              or (    D13.[QA_std]             like 'GRI_10_0%'     )   -- 1 to 3
                                              or (    D13.[QA_std]             like 'GRI_11_%'      )   -- 01a to 17
                                              or (    D13.[QA_std]             like 'GRI_20_01x_%'  )   -- 01a to 10
                                              or (    D13.[QA_std]             like 'SHI_01_x_%'    )   -- 01a to 17
                                              or (    D13.[QA_std]             like 'XSG_S_%'           -- 01 to 23
                                                  and D13.[QA_std]         not like 'XSG_S_99_0%'   )   -- ~ not 01-6
/*----------------------------------------- variables with value cero ----------------------------------------------*/
                                              or (    D13.[answer_wdg_NoStd]    IS NULL
                                                  and D13.[Answer_value]       =   0.00             )   -- ...
                                              -- GRI_03, GRI_04, GRI_05, GRI_06, GRI_07, GRI_08, GRI_09, GRI_10,
                                              -- GRI_11, GRI_12, GRI_13, GRI_14, GRI_15, GRI_16, GRI_17, GRI_18,
                                              -- GRX_30, GRX_31, GRX_32, GRX_33, SHI_02, SHI_03, SHI_04, SHI_06,
                                              -- SHI_07, SHI_08, SHI_09, SHI_10, SHI_11, SHI_12, SHI_13,
                                              -- GRI_01_x, GRI_16_01,
                                              -- GRI_20_01, GRI_20_02, GRI_20_03_a, GRI_20_03_b, GRI_20_03_c,
                                              -- GRI_20_04, GRI_20_04_x, GRI_20_05,
                                              -- GRX_22_01, GRX_22_02, GRX_22_03, GRX_22_04,
                                              -- GRX_29_02, GRX_29_03, GRX_29_04, GRX_29_05,
                                              -- SHI_01_a, SHI_02_01, SHI_04_x01, SHI_11_x, 
/*------------------------------------------------------------------------------------------------------------------*/
                                            then 'No description coded'
/*----------------------------------------- errors -----------------------------------------------------------------*/
                                            when
                                                 (    D13.[QA_std]              LIKE   'SHI_04_x01'
                                                  and D13.[answer_wdg_NoStd]    IS NULL
                                                  and D13.[Answer_Wording_Std]  LIKE   'One or more groups'   )
                                            then 'missing description: it should have been coded'
/*------------------------------------------------------------------------------------------------------------------*/
                                            else D13.[answer_wdg_NoStd]
/*------------------------------------------------------------------------------------------------------------------*/
                                        end
/*==================================================================================================================*/
      ,       [Answer_Wording_Std]  =  case when QST.[AnswerSet_num]      = 999999
                                            then AST.[Answer_Wording_Std]
                                            else D13.[answer_wording_std]
                                        end
/*==================================================================================================================*/
      ,   D13.[Question_fk]
      ,   D13.[Answer_fk]
      ,   D13.[Notes]
      ,   D13.[QS_fk]
      ,   QNS.[Question_Std_fk]
      ,   [Answer_Std_pk]
      ,   [Question_pk]
/*==================================================================================================================*/
  FROM [#DR2013]                           D13
/*==================================================================================================================*/
 inner
  join 
       [forum].[dbo].[Pew_Question_NoStd]  QNS
on 
      D13.[Question_Year]
    = QNS.[Question_Year]
and
      D13.[QA_std]
    = QNS.[Question_abbreviation]
/*==================================================================================================================*/
inner join 
       [forum].[dbo].[Pew_Question_Std]    QST
on 
      D13.[QA_std]
    = QST.[Question_abbreviation_std]
/*==================================================================================================================*/
inner join 
       [forum].[dbo].[Pew_Answer_Std]      AST
on 
      QST.[AnswerSet_num]
    = AST.[AnswerSet_number]
and
      case when QST.[AnswerSet_num] = 999999
            and D13.[Answer_value]  > 1      then 1     
           else D13.[Answer_value]
           end
    = AST.[Answer_value_std]
/*==================================================================================================================*/
/********************************************************************************************************************/
)   codedDR
/********************************************************************************************************************/
/********************************************************************************************************************/



  WHERE      NQ.Question_Year                    = 2012
         AND NV.Question_abbreviation_std NOT LIKE 'GRI_11_0%'
         AND NV.Question_abbreviation_std NOT LIKE 'GRI_19_%'
         AND NV.Question_abbreviation_std NOT LIKE 'GRI_20_01x%'
         AND NV.Question_abbreviation_std NOT LIKE 'SHI_01_x%'
         AND NV.Question_abbreviation_std NOT LIKE 'SHI_0[1, 4, 5]_[b-f]' 


         JOIN [forum_d].[dbo].[Pew_Nation_Locality]    NL
              ON NL.Nation_pk
               = NV.Nation_fk
  WHERE         NQ.Question_Year                    = 2012
         AND
           (    NV.Question_abbreviation_std     LIKE 'GRI_19_[b-f]'
             OR NV.Question_abbreviation_std     LIKE 'SHI_0[1, 4, 5]_[b-f]'  ) 


SELECT *
  FROM [#codedDR]
 WHERE
       [answer_wording_std]  is NULL
       or
       [answer_wdg_NoStd]    is NULL




[answer_wdg_NoStd]    =   'selectyprueba'


[QA_std] = 'SHI_05'
and
[answer_wdg_NoStd] is NULL





 -- [Answer_value]   = 0.00
   --and
[answer_wdg_NoStd] is NULL
and
[answer_wording_std] = 'No'





NULL

0.00	No description coded	No
'No description coded'

'No cases or events were found'
'1+ cases or events were found'






SELECT
       --distinct [QA_std], QW_std, [Answer_value_std], [answer_wording_std]
       *
  FROM [#codedDR]                                      ---- 155

where 
QA_std like 'GRI_04'

       --[answer_wording_std]  is NULL
       --or
       [answer_wdg_NoStd]    is NULL

order by  [QA_std], [Answer_value_std]



and QA_std like 'GRI_0[1-2]'



0.00	No description coded	No
'No description coded'

'No cases or events were found'
'1+ cases or events were found'




SELECT [Answer_pk]
SELECT
       distinct
       [QA_std]
      ,[QW_std]
      ,[Answer_value_NoStd]              =   [Answer_value]
      ,[Answer_Wording]                  =   [answer_wdg_NoStd]
      ,[Answer_Std_fk]                   =   [Answer_Std_pk]
      ,[Question_fk]                     =   [Question_pk]
  FROM [#codedDR]

where 
[answer_wdg_NoStd] is NULL



SELECT * from [forum_ResAnal].[dbo].[vrc_01_DB_Long_NoAggregated]
where [QA_std]  like  'SHI_05'
and
[Question_Year]  =  2012
order by
 [QA_std]
 
 

--where

--AST.[AnswerSet_number]  is  null

  

--/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT [Answer_Std_pk]
--      ,[AnswerSet_number]
--      ,[Answer_value_std]
--      ,[Answer_Wording_std]
--      ,[Full_set_of_Answers]
--      ,[NA_by_set_of_Answers]
--  FROM [forum].[dbo].[Pew_Answer_Std]
























--/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT [Question_Std_pk]
--      ,[Question_abbreviation_std]
--      ,[Question_wording_std]
--      ,[Question_short_wording_std]
--      ,[Display]
--      ,[AnswerSet_num]
--      ,[Editorially_Checked]

--      ,[Question_Label_80Chars]
--  FROM [forum].[dbo].[Pew_Question_Std]




--where 



--QNS.[Question_abbreviation] is null

--/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT [Question_pk]
--      ,[Question_abbreviation]
--      ,[Question_wording]
--      ,[Question_Year]
--      ,[Notes]
--      ,[Data_source_fk]
--      ,[Question_Std_fk]
--  FROM [forum].[dbo].[Pew_Question_NoStd]
  
--  where Question_Year
--= 2013