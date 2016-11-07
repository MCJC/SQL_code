USE [GRSHR_admin]
GO
/**************************************************************************************************************************************************/
IF OBJECT_ID  (N'[GRSHR_admin].[dbo].[Basic]', N'U') IS NOT NULL
DROP   TABLE     [GRSHR_admin].[dbo].[Basic]
/**************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
/**************************************************************************************************************************************************/
CREATE TABLE 
      [dbo].[Basic]
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
/**************************************************************************************************************************************************/
SET ANSI_PADDING OFF
GO
/**************************************************************************************************************************************************/
/***  Complete 1st step of Table [Basic] **********************************************************************************************************/
INSERT INTO 
       [GRSHR_admin].[dbo].[Basic]
                                   (   [Basic_updatable_data_pk]
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
                                      ,[AV_std_CURRENT]
                                      ,[AW_std_CURRENT]
                                      ,[AW_CURRENT]
                                      ,[editable]                  )
SELECT
       [Basic_updatable_data_pk]     = ROW_NUMBER()OVER(ORDER BY 
                                                                    Question_Year DESC
                                                                  , Nation_fk     DESC
                                                                  , QA_std             )
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
      ,[AV_std_CURRENT]              =  [Answer_value]
      ,[AW_std_CURRENT]              =  [answer_wording_std]
      ,[AW_CURRENT]                  =  [answer_wording]
      --,[Region5]
      --,[Region6]
      ,[editable]
FROM
       [GRSHR_admin].[dbo].[v_Basic]
-- (select top 100 * from [GRSHR_admin].[dbo].[v_Basic] ) T100
/**********************************************************************************************************  Complete 1st step of Table [Basic] ***/
