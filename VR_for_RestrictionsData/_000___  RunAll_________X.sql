/***************************************************************************************************************************************************************/
Print 
'==> ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' start running all scripts                                                                                 --- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the master script to run all scripts for re-creating views and tables related to GRSHR                                    <<<<<     ***/
/***                                                                                                                                                         ***/
/***        NOTICE:                                                                                                                                          ***/
/***                All tables are created from their corresponding BASE-VIEW                                                                                ***/
/***                Views are updated unless there is a change in structure (adding/removing field, etc.)                                                    ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE              [GRSHRcode]
GO
/***************************************************************************************************************************************************************/
--	Print 
--	'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  sub-script 001    ---------------------------------------------------------------------------------- '
--	IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]', N'U') IS NOT NULL
--	DROP TABLE       [forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]
--	SELECT * 	INTO [forum_ResAnal].[dbo].[vr___00a____NationLocalityTOOL]
--	            FROM                 [dbo].[vr___00a]
--	GO
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





-- * 001 Script all views
-- * 002 Backup all tables
 






/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the main script to run all scripts for creating tables & views for Restrictions Data Reports & Tools                      <<<<<     ***/
/***             NOTICE:                                                                                                                                     ***/
/***                     This is a SQLCMD script which requires SQLCMD scripting mode to be enabled (from the toolbar icon or the Query menu)                ***/
/***                     Once SQLCMD scripting mode is enabled, check that actual SQL scripts listed in folder are coinsistent to the script                 ***/
/***                     We can also check first if all tables and views are working, before recreating anything!!!                                          ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***  This code (once SQLCMD scripting mode is enabled) lists scripts in folder (to check if they are coinsistent to the script)                             ***/
	  !!dir/B /O "S:\Forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData"
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  store working directory (path) in a variable:                                                                                                              */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/--
--	:setvar path "S:\Forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData"
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
	   :r  $(path)\_015_lt__PubTopLines____R.sql
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/















--/**************************************************************************************************************************************************/
--/***  This code (once SQLCMD scripting mode is enabled) lists scripts in folder (to check if they are coinsistent to the script)                ***/
----	  !!dir/B /O "S:\Forum\AccessDataBase\CodingTool_2015\restriction_religion\SQL_GRSHR" 
--/**************************************************************************************************************************************************/
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--/*  store working directory (path) in a variable:                                                                                                 */
--:setvar path "S:\Forum\AccessDataBase\CodingTool_2015\restriction_religion\SQL_GRSHR"
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--/*  execute scripts:                                                             => (list can be updated from the files listed for the directory) */
--	   :r  $(path)\set_00_t&v_cleanGRSHRYYYY.sql
--	   :r  $(path)\set_01_t01_DB&Blank_ResDt.sql
--	   :r  $(path)\set_02_t02_SIX_toolTABLES.sql
--	   :r  $(path)\set_03_t03_WideTable_____.sql
--	   :r  $(path)\set_04_t04_coders_cleanTs.sql
--	   :r  $(path)\set_05_v01_EnteredValues_.sql
--	   :r  $(path)\set_06_v02_AllCodedValues.sql
--	   :r  $(path)\set_07_v03_WideChanges___.sql
--	   :r  $(path)\set_08_v04_Descriptions__.sql
--	   :r  $(path)\set_09_v05_ReportData____.sql
--	   :r  $(path)\set_10_v06_NDLongNoAggreg.sql
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--/**************************************************************************************************************************************************/
--Print 
--'==> ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' end running all scripts !!!                                                                  --- '
--/**************************************************************************************************************************************************/




/***   R E S U L T S :


==> 2015-06-02 07:49:57 start running all scripts                                                                    --- 
--- 2015-06-02 07:49:57 ==> remove all tables & set all views to [a]                                                 --- 
   DROP TABLE                 [AllLongData]
   DROP TABLE                 [Countries]
   DROP TABLE                 [All_Questions]
   DROP TABLE                 [All_Answers]
   DROP TABLE                 [Values]
   DROP TABLE                 [WT_VNs]
   DROP TABLE                 [CQ]
   DROP TABLE                 [GRSH_C]
   DROP TABLE                 [GRI_Ctry]
   DROP TABLE                 [SHI_Ctry]
   DROP TABLE                 [Sources]
ALTER VIEW [v01_EnteredValues] AS SELECT [a] = 'a' 
ALTER VIEW [v02_AllCodedValues] AS SELECT [a] = 'a' 
ALTER VIEW [v03_WideChanges] AS SELECT [a] = 'a' 
ALTER VIEW [v04_Descriptions] AS SELECT [a] = 'a' 
ALTER VIEW [v05_ReportData] AS SELECT [a] = 'a' 
ALTER VIEW [v06_NDLongNoAggreg] AS SELECT [a] = 'a' 
--- 2015-06-02 07:49:58 ==> creating view [AllLongData]                                                              --- 

(161279 row(s) affected)

(30888 row(s) affected)

(396 row(s) affected)

(5346 row(s) affected)

(197909 row(s) affected)
--- 2015-06-02 07:50:12 ==> creating tables [Countries], [All_Questions], [All_Answers], [Values], [WT_VNs] & [CQ]   --- 

(198 row(s) affected)

(185 row(s) affected)

(440 row(s) affected)

(406 row(s) affected)

(266 row(s) affected)

(35046 row(s) affected)
--- 2015-06-02 07:50:17 ==> creating table [GRSH_C]                                                                  --- 

(197909 row(s) affected)

(164922 row(s) affected)

(30615 row(s) affected)

(104421 row(s) affected)

(261 row(s) affected)

(1580 row(s) affected)

(1580 row(s) affected)

(1580 row(s) affected)

(1580 row(s) affected)
--- 2015-06-02 07:57:03 ==> creating tables [GRI_Ctry], [SHI_Ctry] & [Sources]                                       --- 

(198 row(s) affected)

(198 row(s) affected)

(198 row(s) affected)
--- 2015-06-02 07:57:04 ==> creating view [v01_EnteredValues]                                                        --- 
--- 2015-06-02 07:57:04 ==> creating view [v02_AllCodedValues]                                                       --- 
--- 2015-06-02 07:57:04 ==> creating view [v03_WideChanges]                                                          --- 
--- 2015-06-02 07:57:04 ==> creating view [v04_Descriptions]                                                         --- 
--- 2015-06-02 07:57:05 ==> creating view [v05_ReportData]                                                           --- 
--- 2015-06-02 07:57:05 ==> creating view [v06_NDLongNoAggreg]                                                       --- 
==> 2015-06-02 07:57:06 end running all scripts !!!                                                                  --- 


                                                                                                                                                ***/