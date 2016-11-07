/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the pro-access-tool table [vrx_w_01_proGRSHRadm_01]                                             <<<<<     ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
---- THIS SCRIPT IS NOT CLEAN


USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vrx_w_01_proGRSHRadm_01]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vrx_w_01_proGRSHRadm_01]
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
/***************************************************************************************************************************************************************/
CREATE TABLE 
      [dbo].[vrx_w_01_proGRSHRadm_01]
(
      [Basic_updatable_data_pk]            [int]            NOT NULL
 	, [entity]                             [varchar](45)        NULL
	, [note]                               [varchar](60)        NULL
	, [link_fk]                            [int]                NULL
	, [Nation_fk]                          [int]                NULL
	, [Locality_fk]                        [int]                NULL
	, [Religion_fk]                        [int]                NULL
	, [Ctry_EditorialName]                 [nvarchar](50)       NULL
	, [Locality]                           [nvarchar](50)       NULL
	, [Religion]                           [nvarchar](255)      NULL
	, [Question_Year]                      [int]                NULL
	, [QA_std]                             [nvarchar](50)       NULL
	, [QW_std]                             [nvarchar](500)      NULL
	, [Answer_value]                       [decimal](38, 2)     NULL
	, [answer_wording]                     [nvarchar](max)      NULL
	, [Question_fk]                        [int]                NULL
	, [Answer_fk]                          [int]                NULL
	, [Notes]                              [nvarchar](1000)     NULL
	, [v_000]                              [nvarchar](400)      NULL
	, [v_020]                              [nvarchar](400)      NULL
	, [v_025]                              [nvarchar](400)      NULL
	, [v_033]                              [nvarchar](400)      NULL
	, [v_040]                              [nvarchar](400)      NULL
	, [v_050]                              [nvarchar](400)      NULL
	, [v_060]                              [nvarchar](400)      NULL
	, [v_067]                              [nvarchar](400)      NULL
	, [v_075]                              [nvarchar](400)      NULL
	, [v_080]                              [nvarchar](400)      NULL
	, [v_100]                              [nvarchar](400)      NULL
	, [v_plu]                              [nvarchar](400)      NULL
	, [AV_std_CURRENT]                     [decimal](38, 2)     NULL
    , [AW_std_CURRENT]                     [nvarchar](400)      NULL
    , [AW_CURRENT]                         [nvarchar](max)      NULL
    , [editable]                           [int]                NULL
    , CONSTRAINT
      [PK_Basic_updatable_data]
    PRIMARY KEY CLUSTERED 
    (
	  [Basic_updatable_data_pk]
	                      ASC
                         ) WITH (  PAD_INDEX             = OFF,
                                  STATISTICS_NORECOMPUTE = OFF,
                                  IGNORE_DUP_KEY         = OFF,
                                  ALLOW_ROW_LOCKS        = ON ,
                                  ALLOW_PAGE_LOCKS       = ON  ) ON [PRIMARY]
                                                                               ) ON [PRIMARY]
GO
/***************************************************************************************************************************************************************/
SET ANSI_PADDING OFF
GO


IF OBJECT_ID('tempdb..#ACDAC') IS NOT NULL
DROP TABLE           [#ACDAC]
GO

/***************************************************************************************************************************************************************/
/*** all combinations + distinct actual combinations of Q&A ****************************************************************************************************/
SELECT *
INTO   [#ACDAC]
FROM
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
(
SELECT

           [QA_lnk]   = [QA_std]
      ,    [AV_std]
      ,    [AW_std]   = CASE
                             WHEN [Answer_Wording_std] IS NOT NULL
                             THEN [Answer_Wording_std]
                             ELSE 'THE VALUE IS NOT A VALID ANSWER'
                         END
FROM
(
SELECT *
  FROM
(
SELECT 
       DISTINCT
       [QA_std]
     , [QA_lnk] = CASE 
                       WHEN              [QA_std] LIKE '%__p' 
                       THEN STUFF(       [QA_std]      ,         
                       (CHARINDEX('__p', [QA_std])), 3, '')
                       ELSE              [QA_std]
                  END
  FROM [forum_ResAnal].[dbo].[vr_06w_LongData_ALL_bkup]
WHERE  [note] LIKE '%this field can be edited'                       )  KL

cross join

(SELECT * FROM
 (       SELECT [AV_std] = '0.00'
   UNION SELECT [AV_std] = '0.20'
   UNION SELECT [AV_std] = '0.25'
   UNION SELECT [AV_std] = '0.33'
   UNION SELECT [AV_std] = '0.40'
   UNION SELECT [AV_std] = '0.50'
   UNION SELECT [AV_std] = '0.60'
   UNION SELECT [AV_std] = '0.67'
   UNION SELECT [AV_std] = '0.75'
   UNION SELECT [AV_std] = '0.80'
   UNION SELECT [AV_std] = '1.00'   )  DE ) JJ
LEFT JOIN


( SELECT 
                           [Question_abbreviation_std]
                         , [Answer_Wording_std]
                         , [Answer_value_std]
    FROM
         [forum].[dbo].[Pew_Q&A_Std]   )   IIJIJ
ON
      [QA_lnk] = [Question_abbreviation_std]
AND   [AV_std] = [Answer_value_std]

) KKKL

/*********************** all combinations + distinct actual combinations of Q&A ***/

)                                                                         ACplusDAC
/**********************************************************************************/
pivot (MAX ([AW_std]) 
       for  [AV_std] in (
                                 [0.00]
                               , [0.20]
                               , [0.25]
                               , [0.33]
                               , [0.40]
                               , [0.50]
                               , [0.60]
                               , [0.67]
                               , [0.75]
                               , [0.80]
                               , [1.00]
                                          ))  AS ValidValues
/**********************************************************************************/
/**********************************************************************************/






-----------------------------------------------------------------------------------------------------------------------------------------------------------------


/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************** all combinations + distinct actual combinations of Q&A ***/
GO
/***************************************************************************************************************************************************************/






/***************************************************************************************************************************************************************/
/***  Complete 1st step of Table [Basic] ***********************************************************************************************************************/
INSERT INTO 
       [vrx_w_01_proGRSHRadm_01]
SELECT

       [Basic_updatable_data_pk]     = ROW_NUMBER()OVER(ORDER BY 
                                                                    [Question_Year] DESC
                                                                  , [Nation_fk]     DESC
                                                                  , [QA_std]             )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
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
      ,[Question_fk]
      ,[Answer_fk]
      ,[Notes]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      ,[v_000]                       =  [0.00]
      ,[v_020]                       =  [0.20]
      ,[v_025]                       =  [0.25]
      ,[v_033]                       =  [0.33]
      ,[v_040]                       =  [0.40]
      ,[v_050]                       =  [0.50]
      ,[v_060]                       =  [0.60]
      ,[v_067]                       =  [0.67]
      ,[v_075]                       =  [0.75]
      ,[v_080]                       =  [0.80]
      ,[v_100]                       =  [1.00]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      ,[v_plu]                       =  ''
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      ,[AV_std_CURRENT]              =  [Answer_value]
      ,[AW_std_CURRENT]              =  [answer_wording_std]
      ,[AW_CURRENT]                  =  [answer_wording]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
      ,[editable]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
       [forum_ResAnal].[dbo].[vr_06w_LongData_ALL]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
LEFT
JOIN
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       [#ACDAC]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
ON
	   [QA_std]
	=  [QA_lnk]


GO




/**************************************************************************************************************************************************/
/***                                                     ******************************************************************************************/
/***                    S T E P     2                    ******************************************************************************************/
/***                                                     ******************************************************************************************/
/**************************************************************************************************************************************************/
/***  Add Computed Columns PERSISTED  *************************************************************************************************************/
SET ANSI_PADDING ON
GO
----------------------------------------------------------------------------------------------------------------------------------------------------
ALTER
TABLE
       [vrx_w_01_proGRSHRadm_01]
ADD
----------------------------------------------------------------------------------------------------------------------------------------------------
       [Answer_Wording_std]
                             AS
                               CASE 
                                   WHEN [Answer_value]  = [Av_STD_CURRENT] THEN [AW_std_CURRENT]
                                   -------------------------------------------------------------------------------------------
                                   WHEN [note]   LIKE    '%NOT be edited%'
                                    AND [Answer_value] != [Av_STD_CURRENT] THEN 'VALUE SHOULD NOT BE EDITED !!!'
                                   -------------------------------------------------------------------------------------------
                                   WHEN [note]   LIKE    '%can be edited%'
                                    AND [Answer_value] != [Av_STD_CURRENT]
                                    AND [Answer_value]  < 1.00
                                    AND [Answer_value]    NOT IN (
                                                                    0.00
                                                                  , 0.20
                                                                  , 0.25
                                                                  , 0.33
                                                                  , 0.40
                                                                  , 0.50
                                                                  , 0.60
                                                                  , 0.67
                                                                  , 0.75
                                                                  , 0.80
                                                                         ) THEN 'THE VALUE IS NOT A VALID ANSWER'
                                   -------------------------------------------------------------------------------------------
                                   WHEN [Answer_value]  = 0.00             THEN [v_000]
                                   WHEN [Answer_value]  = 0.20             THEN [v_020]
                                   WHEN [Answer_value]  = 0.25             THEN [v_025]
                                   WHEN [Answer_value]  = 0.33             THEN [v_033]
                                   WHEN [Answer_value]  = 0.40             THEN [v_040]
                                   WHEN [Answer_value]  = 0.50             THEN [v_050]
                                   WHEN [Answer_value]  = 0.60             THEN [v_060]
                                   WHEN [Answer_value]  = 0.67             THEN [v_067]
                                   WHEN [Answer_value]  = 0.75             THEN [v_075]
                                   WHEN [Answer_value]  = 0.80             THEN [v_080]
                                   WHEN [Answer_value] >= 1.00             THEN [v_100]
---                                   WHEN [Answer_value]  > 0.00             THEN [v_plu]
                                   -------------------------------------------------------------------------------------------
                                   ELSE                                         'program error: tell JC!'
                                                                                                               END   PERSISTED
----------------------------------------------------------------------------------------------------------------------------------------------------
    , [changeV]
                             AS
                               CASE 
                                   WHEN [AV_std_CURRENT] !=  [Answer_value] THEN 'value has been updated'
                                   WHEN [AV_std_CURRENT]  =  [Answer_value] THEN ''
                                   ELSE                                          'error!'
                                                                                                               END   PERSISTED
----------------------------------------------------------------------------------------------------------------------------------------------------
    , [changeW]
                             AS
                               CASE 
                                   WHEN [AW_CURRENT]     IS     NULL
                                    AND [Answer_Wording] IS     NULL      THEN ''
                                   WHEN [AW_CURRENT]     IS     NULL
                                    AND [Answer_Wording] IS NOT NULL      THEN 'descriptive wording has been updated'
                                   WHEN [AW_CURRENT]     IS NOT NULL
                                    AND [Answer_Wording] IS     NULL      THEN 'descriptive wording has been removed'
                                   WHEN [AW_CURRENT]  =  [Answer_Wording] THEN ''
                                   WHEN [AW_CURRENT] !=  [Answer_Wording] THEN 'descriptive wording has been updated'
                                   ELSE                                        'error!'
                                                                                                               END   PERSISTED
----------------------------------------------------------------------------------------------------------------------------------------------------
GO
/**************************************************************************************************************************************************/
SET ANSI_PADDING OFF
GO
/*************************************************************************************************************  Add Computed Columns PERSISTED  ***/
/**************************************************************************************************************************************************/


