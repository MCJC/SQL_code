/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 003    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>         This script creates long set of data from the 'Global Restriction on Religion Study'                                        <<<<<     ***/
/***                   The long set of data includes numeric values and descriptive wordings for GR&SH R                                                     ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
declare @CODE__1 nvarchar(max)
declare @CODE_2a nvarchar(max)
declare @CODE_2b nvarchar(max)
declare @CODE_2c nvarchar(max)
declare @CODE__3 nvarchar(max)
declare @ALLCODE nvarchar(max)
/***************************************************************************************************************************************************************/

/***************************************************************************************************************************************************************/
set     @CODE__1 = 
/**************************************************************************************************************************************************/
/*** Selection statement for sets of data at country, country/religion or country/province levels into a view **************************************************/
N'
ALTER  VIEW                      [dbo].[vr___01_]        AS
SELECT * FROM
'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
N'('
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/

/*** extracted data ********************************************************************************************************************************************/
set     @CODE_2a = 
/***************************************************************************************************************************************************************/
N'
SELECT
        [entity]                 =   ''Ctry''
      , [QA_fk]                  =   Q.[QA_pk]
      , [link_fk]                =   K.[Nation_answer_pk]
      , [Nation_fk]              =   N.[Nation_pk]
      , [Locality_fk]            =   ''''
      , [Religion_fk]            =   ''''
      , [Region5]                =   N.[Region]
      , [Region6]                =   N.[SubRegion6]
      , [Ctry_EditorialName]     =   N.[Ctry_EditorialName]
      , [Locality]               =   ''''
      , [Religion]               =   ''''
      , [Question_Year]          =   Q.[Question_Year]
      , [QA_std]                 =   Q.[Question_abbreviation_std]
      , [QW_std]                 =   Q.[Question_short_wording_std]
      , [Answer_value]           =   Q.[Answer_value]
      , [Answer_value_Std]       =   Q.[Answer_value_Std]
      , [Answer_value_NoStd]     =   Q.[Answer_value_NoStd]
      , [answer_wording]         =   Q.[answer_wording]
      , [answer_wording_std]     =   Q.[answer_wording_std]
      , [Data_source_name]       =   Q.[Data_source_name]
      , [Question_Std_fk]        =   Q.[Question_Std_fk]
      , [Question_fk]            =   Q.[Question_fk]
      , [Answer_Std_fk]          =   Q.[Answer_Std_fk]
      , [Answer_fk]              =   Q.[Answer_fk]
      , [AnswerSet_number]       =   Q.[AnswerSet_number]
      , [Question_wording_std]   =   Q.[Question_wording_std]
      , [Question_wording]       =   Q.[Question_wording]
      , [Question_abbreviation]  =   Q.[Question_abbreviation]
      , [NA_by_set_of_Answers]   =   Q.[NA_by_set_of_Answers]
      , [Full_set_of_Answers]    =   Q.[Full_set_of_Answers]
      , [Display_by_StdQ]        =   Q.[Display]
      , [Display_by_NoSQ]        =   Q.[Display_NoStd]
      , [Display_by_Ans]         =   K.[Display]
      , [Editorially_Checked]    =   Q.[Editorially_Checked]
      , [Notes]                  =   Q.[Notes]
'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
N'
  FROM [forum].[dbo].[Pew_Q&A]                      Q
      ,[forum].[dbo].[Pew_Nation]                   N
      ,[forum].[dbo].[Pew_Nation_Answer]            K
'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
N'
    WHERE Q.[Answer_fk]           = K.[Answer_fk]
      AND Q.[Pew_Data_Collection] = ''Global Restriction on Religion Study''
      AND K.[Nation_fk]           =  N.[Nation_pk]
'
/***************************************************************************************************************************************************************/
 +
  N'UNION ALL'

/***************************************************************************************************************************************************************/
set     @CODE_2b = 
/***************************************************************************************************************************************************************/
	N'
	SELECT
			[entity]                 =   ''RGrp''
		  , [QA_fk]                  =   Q.[QA_pk]
	      , [link_fk]                =   K.[Nation_religion_answer_pk]
		  , [Nation_fk]              =   N.[Nation_pk]
		  , [Locality_fk]            =   ''''
		  , [Religion_fk]            =   G.[Religion_group_pk]
		  , [Region5]                =   N.[Region]
		  , [Region6]                =   N.[SubRegion6]
		  , [Ctry_EditorialName]     =   N.[Ctry_EditorialName]
		  , [Locality]               =   ''''
		  , [Religion]               =   G.[Pew_religion]
		  , [Question_Year]          =   Q.[Question_Year]
		  , [QA_std]                 =   Q.[Question_abbreviation_std]
		  , [QW_std]                 =   Q.[Question_short_wording_std]
		  , [Answer_value]           =   Q.[Answer_value]
		  , [Answer_value_Std]       =   Q.[Answer_value_Std]
		  , [Answer_value_NoStd]     =   Q.[Answer_value_NoStd]
		  , [answer_wording]         =   Q.[answer_wording]
		  , [answer_wording_std]     =   Q.[answer_wording_std]
		  , [Data_source_name]       =   Q.[Data_source_name]
		  , [Question_Std_fk]        =   Q.[Question_Std_fk]
		  , [Question_fk]            =   Q.[Question_fk]
		  , [Answer_Std_fk]          =   Q.[Answer_Std_fk]
		  , [Answer_fk]              =   Q.[Answer_fk]
		  , [AnswerSet_number]       =   Q.[AnswerSet_number]
		  , [Question_wording_std]   =   Q.[Question_wording_std]
		  , [Question_wording]       =   Q.[Question_wording]
		  , [Question_abbreviation]  =   Q.[Question_abbreviation]
		  , [NA_by_set_of_Answers]   =   Q.[NA_by_set_of_Answers]
		  , [Full_set_of_Answers]    =   Q.[Full_set_of_Answers]
		  , [Display_by_StdQ]        =   Q.[Display]
		  , [Display_by_NoSQ]        =   Q.[Display_NoStd]
		  , [Display_by_Ans]         =   K.[Display]
		  , [Editorially_Checked]    =   Q.[Editorially_Checked]
		  , [Notes]                  =   Q.[Notes]
	'
	/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	+
	/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	N'
	  FROM [forum].[dbo].[Pew_Q&A]                      Q
		  ,[forum].[dbo].[Pew_Nation]                   N
		  ,[forum].[dbo].[Pew_Nation_Religion_Answer]   K
		  ,[forum].[dbo].[Pew_Religion_Group]           G
	'
	/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	+
	/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	N'
		WHERE Q.[Answer_fk]           = K.[Answer_fk]
		  AND Q.[Pew_Data_Collection] = ''Global Restriction on Religion Study''
		  AND K.[Religion_group_fk]   = G.[Religion_group_pk]
		  AND K.[Nation_fk]           =  N.[Nation_pk]
	'
/**************************************************************************************************************************************************/
     +
      N'UNION ALL'

/**************************************************************************************************************************************************/
set     @CODE_2c = 
/**************************************************************************************************************************************************/
		N'
		SELECT
				[entity]                 =   ''Prov''
			  , [QA_fk]                  =   Q.[QA_pk]
		      , [link_fk]                =   K.[Locality_answer_pk]
			  , [Nation_fk]              =   N.[Nation_pk]
			  , [Locality_fk]            =   L.[Locality_pk]
			  , [Religion_fk]            =   ''''
			  , [Region5]                =   N.[Region]
			  , [Region6]                =   N.[SubRegion6]
			  , [Ctry_EditorialName]     =   N.[Ctry_EditorialName]
			  , [Locality]               =   L.[Locality]
			  , [Religion]               =   ''''
			  , [Question_Year]          =   Q.[Question_Year]
			  , [QA_std]                 =   Q.[Question_abbreviation_std]
			  , [QW_std]                 =   Q.[Question_short_wording_std]
			  , [Answer_value]           =   Q.[Answer_value]
			  , [Answer_value_Std]       =   Q.[Answer_value_Std]
			  , [Answer_value_NoStd]     =   Q.[Answer_value_NoStd]
			  , [answer_wording]         =   Q.[answer_wording]
			  , [answer_wording_std]     =   Q.[answer_wording_std]
			  , [Data_source_name]       =   Q.[Data_source_name]
			  , [Question_Std_fk]        =   Q.[Question_Std_fk]
			  , [Question_fk]            =   Q.[Question_fk]
			  , [Answer_Std_fk]          =   Q.[Answer_Std_fk]
			  , [Answer_fk]              =   Q.[Answer_fk]
			  , [AnswerSet_number]       =   Q.[AnswerSet_number]
			  , [Question_wording_std]   =   Q.[Question_wording_std]
			  , [Question_wording]       =   Q.[Question_wording]
			  , [Question_abbreviation]  =   Q.[Question_abbreviation]
			  , [NA_by_set_of_Answers]   =   Q.[NA_by_set_of_Answers]
			  , [Full_set_of_Answers]    =   Q.[Full_set_of_Answers]
			  , [Display_by_StdQ]        =   Q.[Display]
			  , [Display_by_NoSQ]        =   Q.[Display_NoStd]
			  , [Display_by_Ans]         =   K.[Display]
			  , [Editorially_Checked]    =   Q.[Editorially_Checked]
			  , [Notes]                  =   Q.[Notes]
		'
		/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		+
		/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		N'
		  FROM [forum].[dbo].[Pew_Q&A]                      Q
			  ,[forum].[dbo].[Pew_Nation]                   N
			  ,[forum].[dbo].[Pew_Locality_Answer]          K
			  ,[forum].[dbo].[Pew_Locality]                 L
		'
		/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		+
		/*------------------------------------------------------------------------------------------------------------------------------------------------*/
		N'
			WHERE Q.[Answer_fk]           = K.[Answer_fk]
			  AND Q.[Pew_Data_Collection] = ''Global Restriction on Religion Study''
			  AND K.[Locality_fk]          =  L.[Locality_pk]
			  AND N.[Nation_pk]           =
										    CASE
										    WHEN L.[Nation_fk]     = 237
										     AND Q.[Question_Year] < 201
										    THEN     197
										    ELSE L.[Nation_fk]
										    END
'
/***************************************************************************************************************************************************************/

/***************************************************************************************************************************************************************/
set     @CODE__3 = 
/*** extracted data ********************************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
N') ExDa'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/
/*  >   filters to exclude from the analysis: North Korea, South Sudan data for 2010 and internal/external displacements coeded in 2010 -----------------------*/
N'
WHERE   Ctry_EditorialName                                   != ''North Korea''
  AND   Ctry_EditorialName +''_/_''+ STR(Question_Year, 4,0) != ''South Sudan_/_2010''
  AND   QA_std                                 NOT LIKE       ''%_d'' + ''[a,b]''
'
/*  <   filters  ----------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/




/***************************************************************************************************************************************************************/
set     @ALLCODE = 
					  @CODE__1
					+ @CODE_2a
					+ @CODE_2b
					+ @CODE_2c
					+ @CODE__3
/***************************************************************************************************************************************************************/



/***************************************************************************************************************************************************************/
/*** checking / executing SQL statement that has been stored as a string variable ******************************************************************************/
--	EXEC dbo.LongPrint @ALLCODE                                     /***        display the currently stored code (to be executed)                           ***/
	EXEC              (@ALLCODE)                                    /***        execute the code that has been stored as text                                ***/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/








/**************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
SELECT * 	INTO [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
            FROM                 [dbo].[vr___01_]
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
