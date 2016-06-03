/***************************************************************************************************************************************************************/
Print 
'==> ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' start running all scripts                                                                                 --- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the master script to run all scripts for re-creating views and tables related to GRSHR                                    <<<<<     ***/
/***                                                                                                                                                         ***/
/***        NOTICE:                                                                                                                                          ***/
/***                All tables are createdfrom their corresponding BASE-VIEW                                                                                 ***/
/***                Views are updated unless there is a change in structure (adding/removing field, etc.)                                                    ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/


--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]
--SELECT * 	INTO [forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]
--            FROM                 [dbo].[vr___00a]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___00b____QuestnReligionTOOL]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___00b____QuestnReligionTOOL]
--SELECT * 	INTO [forum_ResAnal].[dbo].[vr___00b____QuestnReligionTOOL]
--            FROM                 [dbo].[vr___00b]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--/*-----   BackUp current Table     ---------------------------------------------------------------------------------------------------------------*/
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( '  INSERT INTO   [forum_ResAnal].[dbo].[vr___00x____Long__NoAgg___BkUp]
--               SELECT   [BkUp_date]  = ''' + @CrDt + '''
--                      , * 	
--                 FROM   [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]  ' )
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--/*--    TRUNCATE TABLE  [forum_ResAnal].[dbo].[vr___00x____Long__NoAgg___BkUp]    ----------------------------------------------------------------*/
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
--SELECT * 	INTO [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
--            FROM                 [dbo].[vr___01_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]
--SELECT * INTO    [forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]
--            FROM                 [dbo].[vr___02_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___03_cDB_W&Xtra_byCtry&Year]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___03_cDB_W&Xtra_byCtry&Year]
--SELECT * INTO    [forum_ResAnal].[dbo].[vr___03_cDB_W&Xtra_byCtry&Year]
--            FROM                 [dbo].[vr___03_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___04_cDB_SemiWide_byCtry&Yr]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___04_cDB_SemiWide_byCtry&Yr]
--SELECT *    INTO [forum_ResAnal].[dbo].[vr___04_cDB_SemiWide_byCtry&Yr]
--            FROM                 [dbo].[vr___04_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___04v_labSemiWide_byCtry&Yr]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___04v_labSemiWide_byCtry&Yr]
--SELECT * INTO    [forum_ResAnal].[dbo].[vr___04v_labSemiWide_byCtry&Yr]
--            FROM                 [dbo].[vr___04v]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vrp__01_cDB_SelDataBYCtry&Year]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vrp__01_cDB_SelDataBYCtry&Year]
--SELECT * INTO    [forum_ResAnal].[dbo].[vrp__01_cDB_SelDataBYCtry&Year]
--            FROM                 [dbo].[vrp__01_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vrp__01v_labSelDataBYCtry&Year]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vrp__01v_labSelDataBYCtry&Year]
--SELECT * INTO    [forum_ResAnal].[dbo].[vrp__01v_labSelDataBYCtry&Year]
--            FROM                 [dbo].[vrp__01v]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___05_cDB_Index_byCtryReg&Yr]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___05_cDB_Index_byCtryReg&Yr]
--SELECT * INTO    [forum_ResAnal].[dbo].[vr___05_cDB_Index_byCtryReg&Yr]
--            FROM                 [dbo].[vr___05_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]
--SELECT * INTO    [forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]
--            FROM                 [dbo].[vr___06_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___07_cDB_MainLongData_byCYQ]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___07_cDB_MainLongData_byCYQ]
--SELECT * 	INTO [forum_ResAnal].[dbo].[vr___07_cDB_MainLongData_byCYQ]
--            FROM                 [dbo].[vr___07_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___08_cDB_Weights_f_TopLines]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___08_cDB_Weights_f_TopLines]
--SELECT * 	INTO [forum_ResAnal].[dbo].[vr___08_cDB_Weights_f_TopLines]
--            FROM                 [dbo].[vr___08_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___09_cDB_Basic_TopLines_All]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___09_cDB_Basic_TopLines_All]
--SELECT * INTO    [forum_ResAnal].[dbo].[vr___09_cDB_Basic_TopLines_All]
--            FROM                 [dbo].[vr___09_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]
--SELECT * INTO    [forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]
--            FROM                 [dbo].[vr___10_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___11_cDB_RHIndexScore_byReg]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vr___11_cDB_RHIndexScore_byReg]
--SELECT * INTO    [forum_ResAnal].[dbo].[vr___11_cDB_RHIndexScore_byReg]
--            FROM                 [dbo].[vr___11_]
--/***************************************************************************************************************************************************************/
--GO
--/***************************************************************************************************************************************************************/










USE              [GRSHRcode]
GO

/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  sub-script 001    -------------------------------------------------------------------------------------- '
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]
SELECT * 	INTO [forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]
            FROM                 [dbo].[vr___00a]
GO
/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 002    ------------------------------------------------------------------------------------------ '
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___00b____QuestnReligionTOOL]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___00b____QuestnReligionTOOL]
SELECT * 	INTO [forum_ResAnal].[dbo].[vr___00b____QuestnReligionTOOL]
            FROM                 [dbo].[vr___00b]
GO
/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 003    ------------------------------------------------------------------------------------------ '
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
SELECT * 	INTO [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
            FROM                 [dbo].[vr___01_]
GO
/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 004    ------------------------------------------------------------------------------------------ '
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]
SELECT * INTO    [forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]
            FROM                 [dbo].[vr___02_]
GO
/***************************************************************************************************************************************************************/












/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the main script to run all scripts for creating tables & views for Restrictions Data Reports & Tools                      <<<<<     ***/
/***             NOTICE:                                                                                                                                     ***/
/***                     This is a SQLCMD script which requires SQLCMD scripting mode to be enabled (from the toolbar icon or the Query menu)                ***/
/***                     Once SQLCMD scripting mode is enabled, check that actual SQL scripts listed in folder are coinsistent to the script                 ***/
/***                     We can also check first if all tables and views are working, before recreating anything!!!                                          ***/


--BEFORE RECREATING ALL 
-- * 001 Script all views
-- * 002 Backup all tables
 
 /****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [TABLE_CATALOG]
      ,[TABLE_SCHEMA]
      ,[TABLE_NAME]
      ,[TABLE_TYPE]
  FROM [forum].[INFORMATION_SCHEMA].[TABLES]

/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***  This code (once SQLCMD scripting mode is enabled) lists scripts in folder (to check if they are coinsistent to the script)                             
           	    !!dir/B /O "S:\Forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData"
				                                                                             	                                                             ***/
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  store working directory (path) in a variable:                                                                                                              */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/--
	:setvar path "S:\Forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData"
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  execute scripts                                                                                                                                            */
/*                  (list can be updated from the files listed for the directory)                                                                              */
/*                  (notice some scripts are NOT necessary, since views get autolmatically updated if code doesn't change                                      */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	   :r  $(path)\_001_lt__NatLocTOOL_____R.sql
	   :r  $(path)\_002_lt__QstRelTOOL_____R.sql
	   :r  $(path)\_003_lt__DBLongNoAggr___R.sql
	   :r  $(path)\_004_lt__DBWide_byCnY___R.sql
	   :r  $(path)\_005_lt__DBWnXt_byCnY___R.sql
	   :r  $(path)\_006_lt__DBSemiW_byCY___R.sql
	   :r  $(path)\_007_lt__DBSemiW_VLab___R.sql
	   :r  $(path)\_008_lt__PubSelVarDat___R.sql
	   :r  $(path)\_009_lt__PubSelVarLab___R.sql
	   :r  $(path)\_010_lt__DBIndexbyCRY___R.sql
	   :r  $(path)\_011_lt__LongData_ALL___R.sql
	   :r  $(path)\_012_lt__LD_forRTeam____R.sql
	   :r  $(path)\_013_lt__weighted_LD____R.sql
	   :r  $(path)\_014_lt__BTopLines_W____R.sql
	   :r  $(path)\_014_lt__BTopLines_W____R_work.sql
_015_lt__PubTopLines____R.sql
_016_lt__IdxScoreReg____R.sql
_020_lt__1601__YScId____R.sql
_020_lt__1602__YMGRI____R.sql
_020_lt__1603__YMSHI____R.sql
_020_lt__1605__YTerr____R.sql
_C01__V__corr_QNotes____R.sql
allscripts.txt
Backupalldata_Tables_and_Views__.sql
CODE_FOR_ALL_VIEWS.sql
CREATEFUNCTION_GetAncestors.sql
Extract_and_Label__Public_GRSHR_dataset.do
Extract_and_Label__workng_GRSHR_dataset.do
Extraction_of_PublicData.log
Extraction_of_WorkingData.log
GetAncestors____into___vx_00_dependencies.sql
GRSHscripts.txt
myworkito.sql
SQLQuery2.sql
test.sql


/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/









/**************************************************************************************************************************************************/
/***      Create TEMPORARY database                                                                                                             ***/
/**************************************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	USE [master]
	GO
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	CREATE DATABASE [Rbkup];
	GO
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
	 ALTER DATABASE [Rbkup] SET RECOVERY SIMPLE 
	GO
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************************/

USE [Rbkup]
GO

/**************************************************************************************************************************************************/
select * into [vr___0______NationLocalityTOOL]                  from [forum_ResAnal]..[vr___0______NationLocalityTOOL]
select * into [vr___0______QuestiReligionTOOL]                  from [forum_ResAnal]..[vr___0______QuestiReligionTOOL]
select * into [vr___01_cDB_Long__NoAggregated]                  from [forum_ResAnal]..[vr___01_cDB_Long__NoAggregated]
select * into [vr___02_cDB_Wide__by_Ctry&Year]                  from [forum_ResAnal]..[vr___02_cDB_Wide__by_Ctry&Year]
select * into [vr___03_cDB_W&Xtra_byCtry&Year]                  from [forum_ResAnal]..[vr___03_cDB_W&Xtra_byCtry&Year]
select * into [vr___asked20160113]                              from [forum_ResAnal]..[vr___asked20160113]
select * into [vr_00_GRSHR_Q&A]                                 from [forum_ResAnal]..[vr_00_GRSHR_Q&A]
select * into [vr_00_GRSHR_QLabels]                             from [forum_ResAnal]..[vr_00_GRSHR_QLabels]
select * into [vr_04w_R&H_Index_by_CtryRegion&Yr]               from [forum_ResAnal]..[vr_04w_R&H_Index_by_CtryRegion&Yr]
select * into [vr_05w_SemiWide_by_Ctry&Year]                    from [forum_ResAnal]..[vr_05w_SemiWide_by_Ctry&Year]
select * into [vr_06w_LongData_ALL]                             from [forum_ResAnal]..[vr_06w_LongData_ALL]
select * into [vr_06w_LongData_ALL_bkup]                        from [forum_ResAnal]..[vr_06w_LongData_ALL_bkup]
select * into [vr_07w_weights]                                  from [forum_ResAnal]..[vr_07w_weights]
select * into [vr_08__QAttributes]                              from [forum_ResAnal]..[vr_08__QAttributes]
select * into [vrd_w_01_proGRSHRadm_01]                         from [forum_ResAnal]..[vrd_w_01_proGRSHRadm_01]
select * into [vrp__01_cDB_SelDataBYCtry&Year]                  from [forum_ResAnal]..[vrp__01_cDB_SelDataBYCtry&Year]
select * into [vrp__02_cDB_Label_of_Variables]                  from [forum_ResAnal]..[vrp__02_cDB_Label_of_Variables]
select * into [vrx_w_01_Basic_TopLinesAll_00]                   from [forum_ResAnal]..[vrx_w_01_Basic_TopLinesAll_00]
select * into [vrx_w_02_proTopLines_00]                         from [forum_ResAnal]..[vrx_w_02_proTopLines_00]
select * into [vrx_w_03_Basic_TopLines_by_Region_00]            from [forum_ResAnal]..[vrx_w_03_Basic_TopLines_by_Region_00]
select * into [vrx_w_04_Vars_by_Ctry_source_00]                 from [forum_ResAnal]..[vrx_w_04_Vars_by_Ctry_source_00]
select * into [vrx_w_05_proRRIdxSbyR_00]                        from [forum_ResAnal]..[vrx_w_05_proRRIdxSbyR_00]
select * into [vrx_w_06_proRRIdxMedians_00]                     from [forum_ResAnal]..[vrx_w_06_proRRIdxMedians_00]
select * into [V1_DB_Long]                                      from [forum_ResAnal]..[V1_DB_Long]
select * into [V2_W_by_Ctry&Year]                               from [forum_ResAnal]..[V2_W_by_Ctry&Year]
--select * into [V3_W&Extras_by_Ctry&Year]                        from [forum_ResAnal]..[V3_W&Extras_by_Ctry&Year]               ---exceeds table row size
select * into [V4_L_by_CYV]                                     from [forum_ResAnal]..[V4_L_by_CYV]
select * into [V5_LRestr_by_CYV]                                from [forum_ResAnal]..[V5_LRestr_by_CYV]
select * into [V6_Basic&Index]                                  from [forum_ResAnal]..[V6_Basic&Index]
select * into [V7_LRestr_by_CV]                                 from [forum_ResAnal]..[V7_LRestr_by_CV]
select * into [V7_LRestr_by_VarVal]                             from [forum_ResAnal]..[V7_LRestr_by_VarVal]
select * into [V8_AggIdx_by_VarVal]                             from [forum_ResAnal]..[V8_AggIdx_by_VarVal]
select * into [V9_AggIdx_by_Yr]                                 from [forum_ResAnal]..[V9_AggIdx_by_Yr]
select * into [vr_01_DB_Long_NoAggregated]                      from [forum_ResAnal]..[vr_01_DB_Long_NoAggregated]
select * into [vr_02_W_by_Ctry&Year]                            from [forum_ResAnal]..[vr_02_W_by_Ctry&Year]
select * into [vr_03_W&Extras_by_Ctry&Year]                     from [forum_ResAnal]..[vr_03_W&Extras_by_Ctry&Year]
select * into [vr_LongCodedData_in_DB]                          from [forum_ResAnal]..[vr_LongCodedData_in_DB]

/**************************************************************************************************************************************************/
          SELECT [a] = (select count(*) from [vr_05w_SemiWide_by_Ctry&Year]),           [b] = (select count(*) from [forum_ResAnal]..[vr_05w_SemiWide_by_Ctry&Year]) 
--UNION ALL SELECT [a] = (select count(*) from [V3_W&Extras_by_Ctry&Year]),               [b] = (select count(*) from [forum_ResAnal]..[V3_W&Extras_by_Ctry&Year]) 
UNION ALL SELECT [a] = (select count(*) from [V4_L_by_CYV]),                            [b] = (select count(*) from [forum_ResAnal]..[V4_L_by_CYV]) 
UNION ALL SELECT [a] = (select count(*) from [vrp__01_cDB_SelDataBYCtry&Year]),         [b] = (select count(*) from [forum_ResAnal]..[vrp__01_cDB_SelDataBYCtry&Year]) 
UNION ALL SELECT [a] = (select count(*) from [vrd_w_01_proGRSHRadm_01]),                [b] = (select count(*) from [forum_ResAnal]..[vrd_w_01_proGRSHRadm_01]) 
UNION ALL SELECT [a] = (select count(*) from [vrp__02_cDB_Label_of_Variables]),         [b] = (select count(*) from [forum_ResAnal]..[vrp__02_cDB_Label_of_Variables]) 
UNION ALL SELECT [a] = (select count(*) from [V5_LRestr_by_CYV]),                       [b] = (select count(*) from [forum_ResAnal]..[V5_LRestr_by_CYV]) 
UNION ALL SELECT [a] = (select count(*) from [V6_Basic&Index]),                         [b] = (select count(*) from [forum_ResAnal]..[V6_Basic&Index]) 
UNION ALL SELECT [a] = (select count(*) from [V7_LRestr_by_CV]),                        [b] = (select count(*) from [forum_ResAnal]..[V7_LRestr_by_CV]) 
UNION ALL SELECT [a] = (select count(*) from [vr___asked20160113]),                     [b] = (select count(*) from [forum_ResAnal]..[vr___asked20160113]) 
UNION ALL SELECT [a] = (select count(*) from [vr_06w_LongData_ALL_bkup]),               [b] = (select count(*) from [forum_ResAnal]..[vr_06w_LongData_ALL_bkup]) 
UNION ALL SELECT [a] = (select count(*) from [V8_AggIdx_by_VarVal]),                    [b] = (select count(*) from [forum_ResAnal]..[V8_AggIdx_by_VarVal]) 
UNION ALL SELECT [a] = (select count(*) from [V9_AggIdx_by_Yr]),                        [b] = (select count(*) from [forum_ResAnal]..[V9_AggIdx_by_Yr]) 
UNION ALL SELECT [a] = (select count(*) from [V7_LRestr_by_VarVal]),                    [b] = (select count(*) from [forum_ResAnal]..[V7_LRestr_by_VarVal]) 
UNION ALL SELECT [a] = (select count(*) from [vr___0______NationLocalityTOOL]),         [b] = (select count(*) from [forum_ResAnal]..[vr___0______NationLocalityTOOL]) 
UNION ALL SELECT [a] = (select count(*) from [vr___0______QuestiReligionTOOL]),         [b] = (select count(*) from [forum_ResAnal]..[vr___0______QuestiReligionTOOL]) 
UNION ALL SELECT [a] = (select count(*) from [vr___03_cDB_W&Xtra_byCtry&Year]),         [b] = (select count(*) from [forum_ResAnal]..[vr___03_cDB_W&Xtra_byCtry&Year]) 
--UNION ALL SELECT [a] = (select count(*) from [vr_LongCodedData_in_DB]),                 [b] = (select count(*) from [forum_ResAnal]..[vr_LongCodedData_in_DB]) 
UNION ALL SELECT [a] = (select count(*) from [vr_01_DB_Long_NoAggregated]),             [b] = (select count(*) from [forum_ResAnal]..[vr_01_DB_Long_NoAggregated]) 
UNION ALL SELECT [a] = (select count(*) from [vr_02_W_by_Ctry&Year]),                   [b] = (select count(*) from [forum_ResAnal]..[vr_02_W_by_Ctry&Year]) 
UNION ALL SELECT [a] = (select count(*) from [V1_DB_Long]),                             [b] = (select count(*) from [forum_ResAnal]..[V1_DB_Long]) 
UNION ALL SELECT [a] = (select count(*) from [vr___01_cDB_Long__NoAggregated]),         [b] = (select count(*) from [forum_ResAnal]..[vr___01_cDB_Long__NoAggregated]) 
UNION ALL SELECT [a] = (select count(*) from [vr_06w_LongData_ALL]),                    [b] = (select count(*) from [forum_ResAnal]..[vr_06w_LongData_ALL]) 
UNION ALL SELECT [a] = (select count(*) from [vr___02_cDB_Wide__by_Ctry&Year]),         [b] = (select count(*) from [forum_ResAnal]..[vr___02_cDB_Wide__by_Ctry&Year]) 
UNION ALL SELECT [a] = (select count(*) from [vr_03_W&Extras_by_Ctry&Year]),            [b] = (select count(*) from [forum_ResAnal]..[vr_03_W&Extras_by_Ctry&Year]) 
UNION ALL SELECT [a] = (select count(*) from [vr_04w_R&H_Index_by_CtryRegion&Yr]),      [b] = (select count(*) from [forum_ResAnal]..[vr_04w_R&H_Index_by_CtryRegion&Yr]) 
UNION ALL SELECT [a] = (select count(*) from [vr_07w_weights]),                         [b] = (select count(*) from [forum_ResAnal]..[vr_07w_weights]) 
UNION ALL SELECT [a] = (select count(*) from [vr_00_GRSHR_Q&A]),                        [b] = (select count(*) from [forum_ResAnal]..[vr_00_GRSHR_Q&A]) 
UNION ALL SELECT [a] = (select count(*) from [vr_08__QAttributes]),                     [b] = (select count(*) from [forum_ResAnal]..[vr_08__QAttributes]) 
UNION ALL SELECT [a] = (select count(*) from [vr_00_GRSHR_QLabels]),                    [b] = (select count(*) from [forum_ResAnal]..[vr_00_GRSHR_QLabels]) 
UNION ALL SELECT [a] = (select count(*) from [vrx_w_02_proTopLines_00]),                [b] = (select count(*) from [forum_ResAnal]..[vrx_w_02_proTopLines_00]) 
UNION ALL SELECT [a] = (select count(*) from [vrx_w_01_Basic_TopLinesAll_00]),          [b] = (select count(*) from [forum_ResAnal]..[vrx_w_01_Basic_TopLinesAll_00]) 
UNION ALL SELECT [a] = (select count(*) from [vrx_w_03_Basic_TopLines_by_Region_00]),   [b] = (select count(*) from [forum_ResAnal]..[vrx_w_03_Basic_TopLines_by_Region_00]) 
UNION ALL SELECT [a] = (select count(*) from [vrx_w_04_Vars_by_Ctry_source_00]),        [b] = (select count(*) from [forum_ResAnal]..[vrx_w_04_Vars_by_Ctry_source_00]) 
UNION ALL SELECT [a] = (select count(*) from [V2_W_by_Ctry&Year]),                      [b] = (select count(*) from [forum_ResAnal]..[V2_W_by_Ctry&Year]) 
UNION ALL SELECT [a] = (select count(*) from [vrx_w_05_proRRIdxSbyR_00]),               [b] = (select count(*) from [forum_ResAnal]..[vrx_w_05_proRRIdxSbyR_00]) 
UNION ALL SELECT [a] = (select count(*) from [vrx_w_06_proRRIdxMedians_00]),            [b] = (select count(*) from [forum_ResAnal]..[vrx_w_06_proRRIdxMedians_00]) 



SELECT [TABLE_NAME]
FROM   [INFORMATION_SCHEMA].[TABLES]  
order by
[TABLE_TYPE], [TABLE_NAME]

/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/


USE [forum_ResAnal]
GO

DROP TABLE  [vr___0______NationLocalityTOOL]
DROP TABLE  [vr___0______QuestiReligionTOOL]
DROP TABLE  [vr___01_cDB_Long__NoAggregated]
DROP TABLE  [vr___02_cDB_Wide__by_Ctry&Year]
DROP TABLE  [vr___03_cDB_W&Xtra_byCtry&Year]
DROP TABLE  [vr___asked20160113]
DROP TABLE  [vr_00_GRSHR_Q&A]
DROP TABLE  [vr_00_GRSHR_QLabels]
DROP TABLE  [vr_04w_R&H_Index_by_CtryRegion&Yr]
DROP TABLE  [vr_05w_SemiWide_by_Ctry&Year]
DROP TABLE  [vr_06w_LongData_ALL]
DROP TABLE  [vr_06w_LongData_ALL_bkup]
DROP TABLE  [vr_07w_weights]
DROP TABLE  [vr_08__QAttributes]
DROP TABLE  [vrd_w_01_proGRSHRadm_01]
DROP TABLE  [vrp__01_cDB_SelDataBYCtry&Year]
DROP TABLE  [vrp__02_cDB_Label_of_Variables]
DROP TABLE  [vrx_w_01_Basic_TopLinesAll_00]
DROP TABLE  [vrx_w_02_proTopLines_00]
DROP TABLE  [vrx_w_03_Basic_TopLines_by_Region_00]
DROP TABLE  [vrx_w_04_Vars_by_Ctry_source_00]
DROP TABLE  [vrx_w_05_proRRIdxSbyR_00]
DROP TABLE  [vrx_w_06_proRRIdxMedians_00]
DROP VIEW  [V1_DB_Long]
DROP VIEW  [V2_W_by_Ctry&Year]
DROP VIEW  [V3_W&Extras_by_Ctry&Year]
DROP VIEW  [V4_L_by_CYV]
DROP VIEW  [V5_LRestr_by_CYV]
DROP VIEW  [V6_Basic&Index]
DROP VIEW  [V7_LRestr_by_CV]
DROP VIEW  [V7_LRestr_by_VarVal]
DROP VIEW  [V8_AggIdx_by_VarVal]
DROP VIEW  [V9_AggIdx_by_Yr]
DROP VIEW  [vr_01_DB_Long_NoAggregated]
DROP VIEW  [vr_02_W_by_Ctry&Year]
DROP VIEW  [vr_03_W&Extras_by_Ctry&Year]
DROP VIEW  [vr_LongCodedData_in_DB]

/**************************************************************************************************************************************************/
