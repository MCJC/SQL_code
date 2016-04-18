/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 007    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the lookup table [forum_ResAnal].[dbo].[vrp__01_cDB_SelDataBYCtry&Year]                         <<<<<     ***/
/***             This table filters selected values from [vr___03_cDB_W&Xtra_byCtry&Year] aggregated by country/religion & year                              ***/
/***             The data will be available for public download                                                                                              ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
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
declare @ALLCODE nvarchar(max)
/***************************************************************************************************************************************************************/
set     @ALLCODE = 
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
N'
ALTER  VIEW                      [dbo].[vr___07_]        AS
SELECT * FROM
'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
N'(
   SELECT
          [Nation_fk]
         ,[Region5]
         ,[Region6]
         ,[Ctry_EditorialName]
         ,[Question_Year]
'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*** Begin selection (into text, in a cell) of a comma delimited list of fields from a system view *************************************************************/
/***************************************************************************************************************************************************************/
(                                                                               /*** parenthesis to include query for the cell to be stuffed                ***/
    SELECT                                                                      /*** SELECT statement                                                        ***/
          ', '                                                                  /*** comma delimiter                                                         ***/
        +                                                                       /*** concatenated to...                                                      ***/


          [COLUMN_NAME]                                                         /*** Fiels including all Q Abb Std (StdVarName)                              ***/
    FROM                                                                        /*** from...                                                                 ***/
          [INFORMATION_SCHEMA].[COLUMNS]                                        /*** name of the sys view which includes all field (var) names as rows       ***/
WHERE                                                                           /*** FILTER:                                                                 ***/
          [TABLE_NAME] = 'vr___03_cDB_W&Xtra_byCtry&Year'                       /*** only the view vr_03                                                     ***/
  AND                                                                           /*** FILTER:                                                                 ***/
          [COLUMN_NAME] NOT IN (  'Nation_fk'                                   /*** exclude fileds initialy listed                                          ***/
                                 ,'Region5'                                     /***                                                                         ***/
                                 ,'Region6'                                     /***                                                                         ***/
                                 ,'Ctry_EditorialName'                          /***                                                                         ***/
                                 ,'Question_Year'                               /***                                                                         ***/
                                 ,'GRI'                                         /***                                                                         ***/
                                 ,'GRI_rd_1d'                                   /***                                                                         ***/
                                 ,'GRI_scaled'                                  /***                                                                         ***/
                                 ,'SHI'                                         /***                                                                         ***/
                                 ,'SHI_rd_1d'                                   /***                                                                         ***/
                                 ,'SHI_scaled'            )                     /***                                                                         ***/
         ORDER BY                                                               /*** sorting order usesd to order stored & extra variables alphabetically    ***/
          ', '                                                                  /*** including comma delimiter                        -> as part of sorting  ***/
        +                                                                       /*** concatenated to...                               -> as part of sorting  ***/
          [COLUMN_NAME]                                                         /*** Fiels including all Q Abb Std (StdVarName)       -> as part of sorting  ***/
         for xml path('')                                                       /*** Modifies the selected rowset nesting all cells into an XML string cell  ***/
/***************************************************************************************************************************************************************/
/*** End of the selection (into text, in a cell) of a comma delimited list of fields ***************************************************************************/
/***************************************************************************************************************************************************************/
)                                                                                /*** parenthesis to include query for the cell to be stuffed                ***/
/****************************************************************************************************************************** stuffing function ends here! ***/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*--- > main dataset ------------------------------------------------------------------------------------------------------------------------------------------*/









/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
         ,[GRI_Q_1]                        = [GRI_01]
         ,[GRI_Q_2]                        = [GRI_02]
         ,[GRI_Q_3]                        = [GRI_03]
         ,[GRI_Q_4]                        = [GRI_04]
         ,[GRI_Q_5]                        = [GRI_05]
         ,[GRI_Q_6]                        = [GRI_06]
         ,[GRI_Q_7]                        = [GRI_07]
         ,[GRI_Q_8]                        = [GRI_08_for_index]
         ,[GRI_Q_9]                        = [GRI_09]
         ,[GRI_Q_10]                       = [GRI_10]
         ,[GRI_Q_11]                       = [GRI_11]
         ,[GRI_Q_11_Christianity]          = [GRI_11_xG1]
         ,[GRI_Q_11_Islam]                 = [GRI_11_xG2]
         ,[GRI_Q_11_Buddhism]              = [GRI_11_xG3]
         ,[GRI_Q_11_Hinduism]              = [GRI_11_xG4]
         ,[GRI_Q_11_Judaism]               = [GRI_11_xG5]
         ,[GRI_Q_11_Folk_Religions]        = [GRI_11_xG7]
         ,[GRI_Q_11_Other_Religions]       = [GRI_11_xG6]
         ,[GRI_Q_12]                       = [GRI_12]
         ,[GRI_Q_13]                       = [GRI_13]
         ,[GRI_Q_14]                       = [GRI_14]
         ,[GRI_Q_15]                       = [GRI_15]
         ,[GRI_Q_16]                       = [GRI_16_ny]       * 100  --   fromerly rescaled [GRI_16_ny1]
         ,[GRI_Q_16_reasons]               = [GRI_16]
         ,[GRI_Q_17]                       = [GRI_17]
         ,[GRI_Q_18]                       = [GRI_18]
         ,[GRI_Q_19]                       = [GRI_19_ny]       * 100  --   fromerly rescaled [GRI_19_ny1]
         ,[GRI_Q_19_extent]                = [GRI_19]
         ,[GRI_Q_19_Abuse]                 = [GRI_19_e_scaled]
         ,[GRI_Q_19_Deaths]                = [GRI_19_f_scaled]
         ,[GRI_Q_19_Displacements]         = [GRI_19_d_scaled]
         ,[GRI_Q_19_Detentions]            = [GRI_19_c_scaled]
         ,[GRI_Q_19_Property_Damage]       = [GRI_19_b_scaled]
         ,[GRI_Q_20_1]                     = [GRI_20_01]
         ,[GRI_Q_20_2]                     = [GRI_20_02]
         ,[GRI_Q_20_3]                     = [GRI_20_03_top]
         ,[GRI_Q_20_3_a]                   = [GRI_20_03_a]
         ,[GRI_Q_20_3_b]                   = [GRI_20_03_b]
         ,[GRI_Q_20_3_c]                   = [GRI_20_03_c]
         ,[GRI_Q_20_4]                     = [GRI_20_04]
         ,[GRI_Q_20_5]                     = [GRI_20_05]
         ,[SHI_Q_1_Harassment]             = [SHI_01_a_dummy]
         ,[SHI_Q_1_PropertyDamage]         = [SHI_01_b_dummy]
         ,[SHI_Q_1_Detentions]             = [SHI_01_c_dummy]
         ,[SHI_Q_1_Displacements]          = [SHI_01_d_dummy]
         ,[SHI_Q_1_Assaults]               = [SHI_01_e_dummy]
         ,[SHI_Q_1_Deaths]                 = [SHI_01_f_dummy]
         ,[SHI_Q_1_Extent]                 = [SHI_01]
         ,[SHI_Q_1_harass_Christianity]    = [SHI_01_xG1]
         ,[SHI_Q_1_harass_Islam]           = [SHI_01_xG2]
         ,[SHI_Q_1_harass_Buddhism]        = [SHI_01_xG3]
         ,[SHI_Q_1_harass_Hinduism]        = [SHI_01_xG4]
         ,[SHI_Q_1_harass_Judaism]         = [SHI_01_xG5]
         ,[SHI_Q_1_harass_Folk_Religions]  = [SHI_01_xG7]
         ,[SHI_Q_1_harass_Other_Religions] = [SHI_01_xG6]
         ,[SHI_Q_2]                        = [SHI_02]
         ,[SHI_Q_3]                        = [SHI_03]
         ,[SHI_Q_4]                        = [SHI_04_ny]       * 100  --   fromerly rescaled [SHI_04_ny0]
         ,[SHI_Q_4_extent]                 = [SHI_04]
         ,[SHI_Q_5]                        = [SHI_05_ny]       * 100  --   fromerly rescaled [SHI_05_ny0]
         ,[SHI_Q_5_extent]                 = [SHI_05]
         ,[SHI_Q_6]                        = [SHI_06]
         ,[SHI_Q_7]                        = [SHI_07]
         ,[SHI_Q_8]                        = [SHI_08]
         ,[SHI_Q_9]                        = [SHI_09]
         ,[SHI_Q_10]                       = [SHI_10]
         ,[SHI_Q_11]                       = [SHI_11_for_index]
         ,[SHI_Q_12]                       = [SHI_12]
         ,[SHI_Q_13]                       = [SHI_13]
         ,[GRX_22_blasphemy]               = [GRX_22_01_ny]    * 100  --   fromerly rescaled [GRX_22_01_ny1]
         ,[GRX_22_apostasy]                = [GRX_22_02_ny]    * 100  --   fromerly rescaled [GRX_22_02_ny1]
         ,[GRX_22_hate_speech]             = [GRX_22_03_ny]    * 100  --   fromerly rescaled [GRX_22_03_ny1]
         ,[GRX_22_criticism_of_religion]   = [GRX_22_04_ny]    * 100  --   fromerly rescaled [GRX_22_04_ny1]
         ,[GRX_30]                         = [GRX_30]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
FROM
                 [forum_ResAnal].[dbo].[vr___03_cDB_W&Xtra_byCtry&Year]
/*=============================================================================================================================================================*/
                                                                                     ) SelPubDS
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/



--USE [forum_ResAnal]
--GO
--/***************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vrp__01_cDB_SelDataBYCtry&Year]', N'U') IS NOT NULL
--DROP TABLE       [forum_ResAnal].[dbo].[vrp__01_cDB_SelDataBYCtry&Year]
--SELECT * INTO    [forum_ResAnal].[dbo].[vrp__01_cDB_SelDataBYCtry&Year]
--FR