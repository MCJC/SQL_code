/***************************************************************************************************************************************************************/
Print 
'==> ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' start running all scripts                                                                                 --- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>   This is the master script to run all scripts for re-creating tables & views in [GRSHRYYYY]                           <<<<<     ***/
/***             10 scripts re-create 11 tables (8 lookup & 3 for data entering) and update 6 views from entered data                           ***/
/***                                                                                                                                            ***/
/***        NOTICE:                                                                                                                             ***/
/***                This is a SQLCMD script which requires SQLCMD scripting mode to be enabled (from the toolbar icon or the Query menu)        ***/
/***                Once SQLCMD scripting mode is enabled, check that actual SQL scripts listed in folder are coinsistent to the script         ***/
/***                We can also check first if all tables and views are working, before recreating anything!!!                                  ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
USE              [GRSHRcode]
GO








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
USE [forum]
GO
/***************************************************************************************************************************************************************/
/***  This code (once SQLCMD scripting mode is enabled) lists scripts in folder (to check if they are coinsistent to the script)                             ***/
--	  !!dir/B /O "S:\Forum\Database\MANAGEMENT\common\ForumResAnal_&_Intridea\VR_for_RestrictionsData" 
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  store working directory (path) in a variable:                                                                                                              */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
:setvar path "S:\Forum\Database\MANAGEMENT\common\ForumResAnal_&_Intridea\VR_for_RestrictionsData"
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  execute scripts                                                                                                                                            */
/*                  (list can be updated from the files listed for the directory)                                                                              */
/*                  (notice some scripts are NOT necessary, since views get autolmatically updated if code doesn't change                                      */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--	   :r  $(path)\create_vr00a__vr___LongCoded_in_DB_____.sql     /*this is not for working data, should be fr step 6 in final data  */
--	   :r  $(path)\create_vr00b__vr___Set_of_QLabels_______R.sql
--	   :r  $(path)\create_vr00c__vr___Set_of_Q&A__________R.sql
--	   :r  $(path)\create_vr01___vrf__DB_Long_NoAggr______.sql
	   :r  $(path)\create_vr01w_vrw_DB_Long_NoAggr_____R.sql
	   :r  $(path)\create_vr02w_vrw_W_byC&Y_____________R.sql
	   :r  $(path)\create_vr03w_vrw_XW_byC&Y___________R.sql
	   :r  $(path)\create_vr04w_vrw_RIndex_by_CRY________R.sql
	   :r  $(path)\create_vr05w_vrw_SemiWd_byC&Yr_____R.sql
	   :r  $(path)\create_vr06w_vrw_LongData_ALL________R.sql
	   :r  $(path)\create_vr99w_trw____AFTER__ALL________R.sql
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/















/**************************************************************************************************************************************************/
/***  This code (once SQLCMD scripting mode is enabled) lists scripts in folder (to check if they are coinsistent to the script)                ***/
--	  !!dir/B /O "S:\Forum\AccessDataBase\CodingTool_2015\restriction_religion\SQL_GRSHR" 
/**************************************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  store working directory (path) in a variable:                                                                                                 */
:setvar path "S:\Forum\AccessDataBase\CodingTool_2015\restriction_religion\SQL_GRSHR"
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*  execute scripts:                                                             => (list can be updated from the files listed for the directory) */
	   :r  $(path)\set_00_t&v_cleanGRSHRYYYY.sql
	   :r  $(path)\set_01_t01_DB&Blank_ResDt.sql
	   :r  $(path)\set_02_t02_SIX_toolTABLES.sql
	   :r  $(path)\set_03_t03_WideTable_____.sql
	   :r  $(path)\set_04_t04_coders_cleanTs.sql
	   :r  $(path)\set_05_v01_EnteredValues_.sql
	   :r  $(path)\set_06_v02_AllCodedValues.sql
	   :r  $(path)\set_07_v03_WideChanges___.sql
	   :r  $(path)\set_08_v04_Descriptions__.sql
	   :r  $(path)\set_09_v05_ReportData____.sql
	   :r  $(path)\set_10_v06_NDLongNoAggreg.sql
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************************/
Print 
'==> ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' end running all scripts !!!                                                                  --- '
/**************************************************************************************************************************************************/




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