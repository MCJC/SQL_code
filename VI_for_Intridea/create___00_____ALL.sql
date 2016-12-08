/* ++> create___00_____ALL.sql <++ */
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the main script to run all scripts for creating tables & views for Intridea                                               <<<<<     ***/
/***             NOTICE:                                                                                                                                     ***/
/***                     This is a SQLCMD script which requires SQLCMD scripting mode to be enabled (from the toolbar icon or the Query menu)                ***/
/***                     Once SQLCMD scripting mode is enabled, check that actual SQL scripts listed in folder are coinsistent to the script                 ***/
/***                     We can also check first if all tables and views are working, before recreating anything!!!                                          ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
USE [forum]
GO
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--  TEST (this TABLE is the selection of counts or rows from the last complete execution and can work to check cionsistency):
--	SELECT * FROM [forum_ResAnal].[dbo].[vi_xxCountRows_of_AllViews] -- 
/***************************************************************************************************************************************************************/
/*--------------------------------------------- ----------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/
/***  This code (once SQLCMD scripting mode is enabled) lists scripts in folder (to check if they are coinsistent to the script)                             ***/
--	  !!dir/B /O "S:\Forum\Database\MANAGEMENT\common\ForumResAnal_&_Intridea\VI_for_Intridea" 
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  store working directory (path) in a variable:                                                                                                              */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
:setvar path "C:\Users\JC\Documents\SQL Server Management Studio\SQL_code_local\VI_for_Intridea"
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  execute scripts                                                                                                                                            */
/*                  (list can be updated from the files listed for the directory)                                                                              */
/*                  (notice some scripts are NOT necessary, since views get autolmatically updated if code doesn't change                                      */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	   :r  $(path)\x_chck_vi00.sql
	   :r  $(path)\create_vi01a_vi_Nation_Attributes.sql
	   :r  $(path)\x_chck_vi01a.sql
	   :r  $(path)\create_vi01c_vi_Nation_Flags.sql
	   :r  $(path)\x_chck_vi01c.sql
	   :r  $(path)\create_vi02_a__vi_AgeSexValue+AllYears.sql
	   :r  $(path)\x_chck_vi02_a.sql
	   :r  $(path)\create_vi02_a_b_vi_AgeSexValue+YrFilter+15Yrs.sql
	   :r  $(path)\x_chck_vi02_a_b.sql
	   :r  $(path)\create_vi02_a_c_vi_AgeSexValue+YrFilter+15Yrs+Pct_of_W.sql
	   :r  $(path)\x_chck_vi02_a_c.sql
	   :r  $(path)\create_vi02_b__vi_AgeSexValue+YrFilter.sql
	   :r  $(path)\x_chck_vi02_b.sql
	   :r  $(path)\create_vi03a_vi_Migrants_basic.sql
	   :r  $(path)\x_chck_vi03a.sql
	   :r  $(path)\create_vi03b_vi_Migrants.sql
	   :r  $(path)\x_chck_vi03b.sql
	   :r  $(path)\create_vi03c_vi_Migrants_by_Ctry.sql
	   :r  $(path)\x_chck_vi03c.sql
	   :r  $(path)\create_vi04_vi_MedianAge.sql
	   :r  $(path)\x_chck_vi04.sql
       /***  This view requires previous scripts in order to properly run ***/
	   :r  $(path)\create_vi01b_vi_Religion_Attributes.sql
	   :r  $(path)\x_chck_vi01b.sql

	   :r  $(path)\create_vi05_vi_Survey_Tables_Displayable.sql
	   :r  $(path)\x_chck_vi05.sql
	   :r  $(path)\create_vi06_vi_SurveyQuestions_Unique.sql
	   :r  $(path)\x_chck_vi06.sql
	   :r  $(path)\create_vi07_vi_SurveyQuestions_ByYear.sql
	   :r  $(path)\x_chck_vi07.sql
	   :r  $(path)\create_vi08_vi_SurveyQuestion&Answers_Unique.sql
	   :r  $(path)\x_chck_vi08.sql
	   :r  $(path)\create_vi09_vi_Restrictions_Ctry&Q&Yr_Displayable.sql
	   :r  $(path)\x_chck_vi09.sql
	   :r  $(path)\create_vi10_vi_Both_Svy&Rstr_Yr&Q&A_&_RstrQ&Yr_Displayable.sql
	   :r  $(path)\x_chck_vi10.sql
	   :r  $(path)\create_vi11_vi_Restrictions_byCtryYr.sql
	   :r  $(path)\x_chck_vi11.sql
	   :r  $(path)\create_vi12a_vi_Restrictions_Index_by_CtryRegion&Yr.sql
	   :r  $(path)\x_chck_vi12a.sql
	   :r  $(path)\create_vi13a_vi_FertilityRate.sql
	   :r  $(path)\x_chck_vi13a.sql
	   :r  $(path)\create_vi14a_vi_ReportLinks_by_Region_or_Ctry.sql
	   :r  $(path)\x_chck_vi14a.sql
	   :r  $(path)\create_vi14b_vi_ReportLinks_by_Religion.sql
	   :r  $(path)\x_chck_vi14b.sql
	   :r  $(path)\create_vi15_vi_CutPoints.sql
	   :r  $(path)\x_chck_vi15.sql
	   :r  $(path)\create_vi16_vi_Reportable_DataSource_Joins.sql
	   :r  $(path)\x_chck_vi16.sql
	   :r  $(path)\create_vi18a_vi_ForMoreInformationLinks_by_Region_or_Ctry.sql
	   :r  $(path)\x_chck_vi18a.sql
	   :r  $(path)\create_vi18b_vi_ForMoreInformationLinks_by_Religion.sql
	   :r  $(path)\x_chck_vi18b.sql
	   :r  $(path)\create_vi19_vi_Restrictions_Tables_by_region&world.sql
	   :r  $(path)\x_chck_vi19.sql
	   :r  $(path)\create_vi20___vi_Topic&Question&Related_Displayable.sql
	   :r  $(path)\x_chck_vi20.sql
	   :r  $(path)\create_vi20_a_vi_Topic&Question_Displayable.sql
	   :r  $(path)\x_chck_vi20_a.sql
	   :r  $(path)\create_vi20_b_vi_Topic&Question_link_RelatResearchRepts.sql
	   :r  $(path)\x_chck_vi20_b.sql
	   :r  $(path)\create_vi21_vi_QMetadata_Wording&Note&Source.sql
	   :r  $(path)\x_chck_vi21.sql
	   :r  $(path)\create_vi22_vi_QuestionMetadata_Svy&Restr.sql
	   :r  $(path)\x_chck_vi22.sql
	   :r  $(path)\create_vi23_vi_Sources_by_Tabs&Charts.sql
	   :r  $(path)\x_chck_vi23.sql
	   :r  $(path)\create_vi24_vi_Locations_by_Question.sql
	   :r  $(path)\x_chck_vi24.sql
	   :r  $(path)\create_vi25_vi_Thresholds.sql
	   :r  $(path)\x_chck_vi25.sql
	   :r  $(path)\create_vi26_vi_Field.sql
	   :r  $(path)\x_chck_vi26.sql
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
--  for TESTING: select the updated counts or rows:
--	SELECT * FROM [forum_ResAnal].[dbo].[vi_xxCountRows_of_AllViews] -- 
/***************************************************************************************************************************************************************/
