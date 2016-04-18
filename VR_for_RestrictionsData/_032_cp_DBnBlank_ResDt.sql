/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 2.002    ---------------------------------------------------------------------------------------- '
/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>   This is the script used to create the table view [GRSHRcode].[dbo].[AllLongData]                                     <<<<<     ***/
/***             (extracted data from [forum] and filter fields)                                                                                ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
USE              [GRSHRcode]
GO
/**************************************************************************************************************************************************/

---- NOTES: 
  -- this code should be modified after...
  -- these variables, calculated as persisted during coding period, should be also used in the aggregated data 
  -- currently used from [forum_ResAnal].[dbo].[vr_06w_LongData_ALL] but from final [forum] data once loaded...
  --    [GRI_19_x]
  --    [SHI_04_x]
  --    [SHI_05_x]
  --    [SHI_01_x]
  --    [SHI_01_summary_b]    --- should be rescaled to 1-6 for coding or scaled 1-6 for lookup table?




/**************************************************************************************************************************************************/
IF OBJECT_ID  ('tempdb..#LCD_DB')                        IS NOT NULL
DROP TABLE              #LCD_DB
/**************************************************************************************************************************************************/
/* >   1st long SET: current data in database *****************************************************************************************************/
SELECT
          [entity]
      ,   [link_fk]
      ,   [Nation_fk]
      ,   [Locality_fk]
      ,   [Religion_fk]
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Locality]
      ,   [Religion]
      ,   [Question_Year]
      ,   [QS_fk]            =           [Question_Std_pk]
      ,   [QA_std]           =
                                /* [QA_std] is provisionally recoded here...       */
                                CASE
                                    WHEN [QA_std]       =    'SHI_11'
                                    THEN                     'SHI_11_b'
                                    ELSE [QA_std]
                                END
      ,   [QW_std]           =
                                /* [QA_std] is provisionally recoded here...       */
                                CASE
                                    WHEN [QA_std] = 'GRI_19_x'
                                    THEN            '0 - Total N of incidents resulting from government force'
                                    WHEN [QA_std] = 'SHI_11_a'
                                    THEN            'Were religious women harassed for violating secular dress norms?'
                                    ELSE [QW_std]
                                END
      ,   [Answer_value]     =
                                /* [Answer_value] is provisionally recoded here, 
                                   before we actually recode it in the database
                                   inorder to have just a consistent distridution
                                   Other variable will be added, if needed, for
                                   catching nuances.                               */
                                CASE
                                    WHEN       [QA_std]                       IN ( 'GRI_08' )
                                     AND CAST( [Answer_value] as decimal (38,2)) = '0.50'
                                    THEN CAST( [Answer_value] as decimal (38,2)) +  0.50
                                    WHEN       [QA_std]                       IN ( 'SHI_11' )
                                     AND CAST( [Answer_value] as decimal (38,2)) = '0.50'
                                    THEN CAST( [Answer_value] as decimal (38,2)) -  0.50
                                    ELSE CAST( [Answer_value] as decimal (38,2))
                                END
      ,   [answer_wording]
      ,   [answer_wording_std] =
                                /* [AW_std] is provisionally recoded here...       */
                                CASE
                                    WHEN       [QA_std]                          = 'SHI_11'
                                     AND CAST( [Answer_value] as decimal (38,2)) = '0.50'
                                    THEN                                           'No'
                                    ELSE       [answer_wording_std]
                                END
      ,   [Question_fk]
      ,   [Answer_fk]
      ,   [Notes]
      ,   [DB]                 =  1
/**************************************************************************************************************************************************/
INTO      [#LCD_DB]
/**************************************************************************************************************************************************/
FROM      [forum_ResAnal].[dbo].[vr_06w_LongData_ALL]                        /* NOTICE THIS IS 2014 WORKING DATA => DATA FROM DB AFTER RLS REMOVED*/ 
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
LEFT JOIN [forum].[dbo].[Pew_Question_Std]                                   /* NOTICE WE'LL INCLUDE QS_fk IN FUTURE VERSION OF [...LongData_ALL] */ 
       ON
          [QA_std]
        = [Question_abbreviation_std]
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************************/
WHERE
          [Ctry_EditorialName] NOT LIKE 'All count%'
      AND 
          [QA_std]
           NOT IN   (   
                         'GFI'                                                          --  aggregated/calculated
                       , 'GFI_rd_1d'                                                    --  aggregated/calculated
                       , 'GFI_scaled'                                                   --  aggregated/calculated
                       , 'GRI'                                                          --  aggregated/calculated
                       , 'GRI_01_x2'                                                    --  never used
                       , 'GRI_08_for_index'                                             --  will be calculated
                       , 'GRI_11_14'                                                    --  no longer used
                       , 'GRI_11_xG1'                                                   --  aggregated/calculated
                       , 'GRI_11_xG2'                                                   --  aggregated/calculated
                       , 'GRI_11_xG3'                                                   --  aggregated/calculated
                       , 'GRI_11_xG4'                                                   --  aggregated/calculated
                       , 'GRI_11_xG5'                                                   --  aggregated/calculated
                       , 'GRI_11_xG6'                                                   --  aggregated/calculated
                       , 'GRI_11_xG7'                                                   --  aggregated/calculated
                       , 'GRI_16_ny1'                                                   --  aggregated/calculated
                       , 'GRI_16_ny2'                                                   --  aggregated/calculated
                       , 'GRI_19_b__p'                                                  --  provincial data no longer coded
                       , 'GRI_19_c__p'                                                  --  provincial data no longer coded
                       , 'GRI_19_d__p'                                                  --  provincial data no longer coded
                       , 'GRI_19_da'                                                    --  no longer used
                       , 'GRI_19_da__p'                                                 --  no longer used
                       , 'GRI_19_db'                                                    --  no longer used
                       , 'GRI_19_db__p'                                                 --  no longer used
                       , 'GRI_19_e__p'                                                  --  provincial data no longer coded
                       , 'GRI_19_f__p'                                                  --  provincial data no longer coded
                       , 'GRI_19_filter'                                                --  aggregated/calculated & DIFFERRENT WORDING
                       , 'GRI_19_ny1'                                                   --  aggregated/calculated
                       , 'GRI_19_ny2'                                                   --  aggregated/calculated
                       , 'GRI_19_summ_ny1'                                              --  aggregated/calculated
                       , 'GRI_19_summ_ny2'                                              --  aggregated/calculated
                       , 'GRI_19_summ_ny3'                                              --  aggregated/calculated
                       , 'GRI_19_summ_ny4'                                              --  aggregated/calculated
                       , 'GRI_19_summ_ny5'                                              --  aggregated/calculated
                       , 'GRI_19_summ_ny6'                                              --  aggregated/calculated
                       , 'GRI_20'                                                       --  aggregated/calculated
                       , 'GRI_20_03_top'                                                --  aggregated/calculated
                       , 'GRI_20_05_x1'                                                 --  no longer used
                       , 'GRI_20_05_x1__p'                                              --  no longer used
                       , 'GRI_20_top'                                                   --  aggregated/calculated
                       , 'GRI_rd_1d'                                                    --  aggregated/calculated
                       , 'GRI_scaled'                                                   --  aggregated/calculated
                       , 'GRX_21_01'                                                    --  no longer used
                       , 'GRX_21_02'                                                    --  no longer used
                       , 'GRX_21_03'                                                    --  no longer used
                       , 'GRX_22'                                                       --  no longer used
                       , 'GRX_22_01_ny1'                                                --  aggregated/calculated
                       , 'GRX_22_01_ny2'                                                --  aggregated/calculated
                       , 'GRX_22_02_ny1'                                                --  aggregated/calculated
                       , 'GRX_22_02_ny2'                                                --  aggregated/calculated
                       , 'GRX_22_03_ny1'                                                --  aggregated/calculated
                       , 'GRX_22_03_ny2'                                                --  aggregated/calculated
                       , 'GRX_22_04_ny1'                                                --  aggregated/calculated
                       , 'GRX_22_04_ny2'                                                --  aggregated/calculated
                       , 'GRX_22_ny1'                                                   --  no longer used
                       , 'GRX_23'                                                       --  no longer used
                       , 'GRX_24'                                                       --  no longer used
                       , 'GRX_24_ny1'                                                   --  no longer used
                       , 'GRX_24_ny2'                                                   --  no longer used
                       , 'GRX_25_01'                                                    --  no longer used
                       , 'GRX_25_02'                                                    --  no longer used
                       , 'GRX_25_03'                                                    --  no longer used
                       , 'GRX_25_ny1'                                                   --  no longer used
                       , 'GRX_25_ny2'                                                   --  no longer used
                       , 'GRX_25_ny3'                                                   --  no longer used
                       , 'GRX_26_01'                                                    --  no longer used
                       , 'GRX_26_02'                                                    --  no longer used
                       , 'GRX_26_03'                                                    --  no longer used
                       , 'GRX_26_04'                                                    --  no longer used
                       , 'GRX_26_05'                                                    --  no longer used
                       , 'GRX_26_06'                                                    --  no longer used
                       , 'GRX_26_07'                                                    --  no longer used
                       , 'GRX_26_08'                                                    --  no longer used
                       , 'GRX_27_01'                                                    --  no longer used
                       , 'GRX_27_02'                                                    --  no longer used
                       , 'GRX_27_03'                                                    --  no longer used
                       , 'GRX_28_01'                                                    --  no longer used
                       , 'GRX_28_02'                                                    --  no longer used
                       , 'GRX_28_03'                                                    --  no longer used
                       , 'GRX_33'                                                       --  no longer used (summer 2015)
                       , 'SHI'                                                          --  aggregated/calculated
                       , 'SHI_01'                                                       --  aggregated/calculated
                       , 'SHI_01_a_dummy'                                               --  aggregated/calculated
                       , 'SHI_01_b__p'                                                  --  provincial data no longer coded
                       , 'SHI_01_b_dummy'                                               --  aggregated/calculated
                       , 'SHI_01_c__p'                                                  --  provincial data no longer coded
                       , 'SHI_01_c_dummy'                                               --  aggregated/calculated
                       , 'SHI_01_d__p'                                                  --  provincial data no longer coded
                       , 'SHI_01_d_dummy'                                               --  aggregated/calculated
                       , 'SHI_01_da'                                                    --  aggregated/calculated
                       , 'SHI_01_da__p'                                                 --  aggregated/calculated
                       , 'SHI_01_db'                                                    --  aggregated/calculated
                       , 'SHI_01_db__p'                                                 --  aggregated/calculated
                       , 'SHI_01_e__p'                                                  --  provincial data no longer coded
                       , 'SHI_01_e_dummy'                                               --  aggregated/calculated
                       , 'SHI_01_f__p'                                                  --  provincial data no longer coded
                       , 'SHI_01_f_dummy'                                               --  aggregated/calculated
                       , 'SHI_01_summary_a_ny0'                                         --  aggregated/calculated
                       , 'SHI_01_summary_a_ny1'                                         --  aggregated/calculated
                       , 'SHI_01_summary_a_ny2'                                         --  aggregated/calculated
                       , 'SHI_01_summary_a_ny3'                                         --  aggregated/calculated
                       , 'SHI_01_summary_a_ny4'                                         --  aggregated/calculated
                       , 'SHI_01_summary_a_ny5'                                         --  aggregated/calculated
                       , 'SHI_01_summary_a_ny6'                                         --  aggregated/calculated
                       , 'SHI_01_summary_b'                                             --  calculated as persisted
                       , 'SHI_01_x_14'                                                  --  aggregated/calculated
                       , 'SHI_01_xG1'                                                   --  aggregated/calculated
                       , 'SHI_01_xG2'                                                   --  aggregated/calculated
                       , 'SHI_01_xG3'                                                   --  aggregated/calculated
                       , 'SHI_01_xG4'                                                   --  aggregated/calculated
                       , 'SHI_01_xG5'                                                   --  aggregated/calculated
                       , 'SHI_01_xG6'                                                   --  aggregated/calculated
                       , 'SHI_01_xG7'                                                   --  aggregated/calculated
                       , 'SHI_04_b__p'                                                  --  provincial data no longer coded
                       , 'SHI_04_c__p'                                                  --  provincial data no longer coded
                       , 'SHI_04_d__p'                                                  --  provincial data no longer coded
                       , 'SHI_04_da'                                                    --  no longer used
                       , 'SHI_04_da__p'                                                 --  no longer used
                       , 'SHI_04_db'                                                    --  no longer used
                       , 'SHI_04_db__p'                                                 --  no longer used
                       , 'SHI_04_e__p'                                                  --  provincial data no longer coded
                       , 'SHI_04_f__p'                                                  --  provincial data no longer coded
                       , 'SHI_04_ny0'                                                   --  aggregated/calculated
                       , 'SHI_04_ny1'                                                   --  aggregated/calculated
                       , 'SHI_05_b'                                                     --  aggregated/calculated
                       , 'SHI_05_b__p'                                                  --  provincial data no longer coded
                       , 'SHI_05_c__p'                                                  --  provincial data no longer coded
                       , 'SHI_05_d__p'                                                  --  provincial data no longer coded
                       , 'SHI_05_da'                                                    --  aggregated/calculated
                       , 'SHI_05_da__p'                                                 --  no longer used
                       , 'SHI_05_db'                                                    --  no longer used
                       , 'SHI_05_db__p'                                                 --  no longer used
                       , 'SHI_05_e__p'                                                  --  no longer used
                       , 'SHI_05_f__p'                                                  --  provincial data no longer coded
                       , 'SHI_05_ny0'                                                   --  aggregated/calculated
                       , 'SHI_05_ny1'                                                   --  aggregated/calculated
                       , 'SHI_07_ny0'                                                   --  aggregated/calculated
                       , 'SHI_07_ny1'                                                   --  aggregated/calculated
                --     , 'SHI_11'                                                       --  will be calculated
                --     , 'SHI_11_a'                                                     --  will be modified later to include DES (summer 2015)
                       , 'SHI_11_for_index'                                             --  will be calculated
                       , 'SHI_11_x'                                                     --  no longer used AS IT IS will be modified later to exclude 11_a (summer 2015)
                       , 'SHI_rd_1d'                                                    --  aggregated/calculated
                       , 'SHI_scaled'                                                   --  aggregated/calculated
                       , 'SHX_14_01'                                                    --  no longer used
                       , 'SHX_14_02'                                                    --  no longer used
                       , 'SHX_14_03'                                                    --  no longer used
                       , 'SHX_14_04'                                                    --  no longer used
                       , 'SHX_15_01'                                                    --  no longer used
                       , 'SHX_15_02'                                                    --  no longer used
                       , 'SHX_15_03'                                                    --  no longer used
                       , 'SHX_15_04'                                                    --  no longer used
                       , 'SHX_15_05'                                                    --  no longer used
                       , 'SHX_15_06'                                                    --  no longer used
                       , 'SHX_15_07'                                                    --  no longer used
                       , 'SHX_15_08'                                                    --  no longer used
                       , 'SHX_15_09'                                                    --  no longer used
                       , 'SHX_15_10'                                                    --  no longer used
                       , 'SHX_25'                                                       --  no longer used
                       , 'SHX_25_ny1'                                                   --  no longer used
                       , 'SHX_25_ny2'                                                   --  no longer used
                       , 'SHX_26'                                                       --  no longer used
                       , 'SHX_26_ny1'                                                   --  no longer used
                       , 'SHX_26_ny2'                                                   --  no longer used
                       , 'SHX_27_01'                                                    --  no longer used
                       , 'SHX_27_02'                                                    --  no longer used
                       , 'SHX_27_03'                                                    --  no longer used
                       , 'SHX_27_ny1'                                                   --  no longer used
                       , 'SHX_27_ny2'                                                   --  no longer used
                       , 'SHX_27_ny3'                                                   --  no longer used
                       , 'SHX_28_01'                                                    --  no longer used
                       , 'SHX_28_02'                                                    --  no longer used
                       , 'SHX_28_03'                                                    --  no longer used
                       , 'SHX_28_04'                                                    --  no longer used
                       , 'SHX_28_05'                                                    --  no longer used
                       , 'SHX_28_06'                                                    --  no longer used
                       , 'SHX_28_07'                                                    --  no longer used
                       , 'SHX_28_08'                                                    --  no longer used
                       , 'XSG_01_xG1'                                                   --  aggregated/calculated
                       , 'XSG_01_xG2'                                                   --  aggregated/calculated
                       , 'XSG_01_xG3'                                                   --  aggregated/calculated
                       , 'XSG_01_xG4'                                                   --  aggregated/calculated
                       , 'XSG_01_xG5'                                                   --  aggregated/calculated
                       , 'XSG_01_xG6'                                                   --  aggregated/calculated
                       , 'XSG_01_xG7'                                                   --  aggregated/calculated
                       , 'XSG_24'                                                       --  no longer used
                       , 'XSG_242526_ny0'                                               --  no longer used
                       , 'XSG_242526_ny1'                                               --  no longer used
                       , 'XSG_25n27_ny1'                                                --  no longer used
                       , 'XSG_25n27_ny2'                                                --  no longer used
                       , 'XSG_25n27_ny3'                                                --  no longer used
                                                                                                                                  )
/* <   1st long SET: current data in database *****************************************************************************************************/
--select * from [#LCD_DB] where [QA_std]       IN ( 'GRI_08' , 'SHI_11' )  AND [Answer_value]  =   0.50
/**************************************************************************************************************************************************/



/**************************************************************************************************************************************************/
IF OBJECT_ID  ('tempdb..#LND_CC')                        IS NOT NULL
DROP TABLE              #LND_CC
/**************************************************************************************************************************************************/
/* >   2nd long SET: new data to be entered comparable to data in database ************************************************************************/
SELECT 
          [entity]             = 'Not Yet Stored in DB'
      ,   [link_fk]            = 0
      ,   [Nation_fk]
      ,   [Locality_fk]
      ,   [Religion_fk]
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Locality]
      ,   [Religion]
      ,   [Question_Year]      =  (SELECT  DISTINCT
                                      MAX([Question_Year])
                                     FROM [#LCD_DB]        ) + 1  -- past year + 1
      ,   [QS_fk]
      ,   [QA_std]
      ,   [QW_std]
      ,   [Answer_value]       = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_08_a'
                                        OR [QA_std] LIKE 'GRI_10_0[1-3]'
                                        OR [QA_std] LIKE 'GRI_11_01[a-b]'
                                        OR [QA_std] LIKE 'GRI_11_[0-1][0-9]'
                                        OR [QA_std] LIKE 'GRI_19_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'GRI_20_01x_01[a-b]'
                                        OR [QA_std] LIKE 'GRI_20_01x_[0-1][0-9]'
--                                      OR [QA_std] LIKE 'GRI_0[1-2]_filter'
--                                      OR [QA_std] LIKE 'GRX_34_02_[a-g]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                        OR [QA_std] LIKE 'SHI_01_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_01_x_01[a-b]'
                                        OR [QA_std] LIKE 'SHI_01_x_[0-1][0-9]'
                                        OR [QA_std] LIKE 'SHI_04_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_05_[c-f&x]'                  -- no x
--                                      OR [QA_std] LIKE 'SHI_09_n'
--                                      OR [QA_std] LIKE 'SHI_10_n'
--                                      OR [QA_std] LIKE 'SHI_11_[a-b]_n'
                                        OR [QA_std] LIKE 'XSG_S_99_0[1-6]'                 -- NEW ROW/STATEMENT
                                      THEN 0.00
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRX_29_0[2-5]'
                                      THEN 1.00
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      ELSE NULL
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [answer_wording]     = ''
      ,   [answer_wording_std] = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_08_a'
                                        OR [QA_std] LIKE 'GRI_10_0[1-3]'
                                        OR [QA_std] LIKE 'GRI_11_01[a-b]'
                                        OR [QA_std] LIKE 'GRI_11_[0-1][0-9]'
                                        OR [QA_std] LIKE 'GRI_20_01x_01[a-b]' 
                                        OR [QA_std] LIKE 'GRI_20_01x_[0-1][0-9]'
--                                      OR [QA_std] LIKE 'GRI_0[1-2]_filter'
--                                      OR [QA_std] LIKE 'GRX_34_02_[a-g]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                        OR [QA_std] LIKE 'SHI_01_x_01[a-b]'
                                        OR [QA_std] LIKE 'SHI_01_x_[0-1][0-9]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                        OR [QA_std] LIKE 'GRX_29_0[2-5]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN 'No'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_19_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_01_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_04_[b-f&x]'                  -- no x
                                        OR [QA_std] LIKE 'SHI_05_[c-f&x]'                  -- no x
--                                       OR [QA_std] LIKE 'SHI_09_n'
--                                       OR [QA_std] LIKE 'SHI_10_n'
--                                       OR [QA_std] LIKE 'SHI_11_[a-b]_n'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN '0 to N incidents'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'XSG_S_99_0[1-6]'                 -- NEW ROW/STATEMENT
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN 'No supplemental source'                        -- ADD AS a new STANDARD ANSWER
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      ELSE ''
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [Question_fk]        = 0
      ,   [Answer_fk]          = 0
      ,   [Notes]              = ''
      ,   [DB]                 =  1
/**************************************************************************************************************************************************/
INTO      [#LND_CC]
/**************************************************************************************************************************************************/
FROM      [#LCD_DB]

/**************************************************************************************************************************************************/
WHERE
          [Question_Year] =  (SELECT  DISTINCT
                                 MAX([Question_Year])
                                FROM [#LCD_DB]                   )  -- included questions for past year
/* <   2nd long SET: new data to be entered comparable to data in database ************************************************************************/



/**************************************************************************************************************************************************/
IF OBJECT_ID  ('tempdb..#LYD_CC')                        IS NOT NULL
DROP TABLE              #LYD_CC
/**************************************************************************************************************************************************/
/* >   3rd long SET: former year's data to be used if necessary in GRI_01 & GRI_02 ****************************************************************/
SELECT
          [entity]             = ''
      ,   [link_fk]            = 0
      ,   [Nation_fk]
      ,   [Locality_fk]
      ,   [Religion_fk]
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Locality]
      ,   [Religion]
      ,   [Question_Year]       = [Question_Year] + 1                      -- past year + 1
      ,   [QS_fk]
      ,   [QA_std]             = [QA_std]        + '_yBe'
      ,   [QW_std]             = [QW_std]        + ' (*the prevoius year)'
      ,   [Answer_value]
      ,   [answer_wording]
      ,   [answer_wording_std]
      ,   [Question_fk]        = 0
      ,   [Answer_fk]          = 0
      ,   [Notes]              = ''
      ,   [DB]                 =  -1
/**************************************************************************************************************************************************/
INTO      [#LYD_CC]
/**************************************************************************************************************************************************/
FROM      [#LCD_DB]
/**************************************************************************************************************************************************/
WHERE
          [Question_Year] =  (SELECT  DISTINCT
                                 MAX([Question_Year])
                                FROM [#LCD_DB]                   )  -- included questions for past year
      AND
          [QA_std]              LIKE 'GRI_0[1-2]'
/* <   3rd long SET: former year's data to be used if necessary in GRI_01 & GRI_02 ****************************************************************/



/**************************************************************************************************************************************************/
IF OBJECT_ID  ('tempdb..#LND_NQ')                        IS NOT NULL
DROP TABLE              #LND_NQ
/**************************************************************************************************************************************************/
/* >   4th long SET: new data to be entered from added questions **********************************************************************************/
SELECT 
          [entity]             = 'Not Yet Stored in DB'
      ,   [link_fk]            = 0
      ,   [Nation_fk]
      ,   [Locality_fk]        = NULL
      ,   [Religion_fk]        = NULL
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Locality]           = 'not detailed'
      ,   [Religion]           = 'not detailed'
      ,   [Question_Year]
      ,   [QS_fk]              = 0
      ,   [QA_std]
      ,   [QW_std]
      ,   [Answer_value]       = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_0[1-2]_filter'
--                                      OR [QA_std] LIKE 'GRI_08_a'
--                                      OR [QA_std] LIKE 'GRI_10_0[1-3]'
--                                      OR [QA_std] LIKE 'GRI_11_01[a-b]'
--                                      OR [QA_std] LIKE 'GRI_11_[0-1][0-9]'
--                                      OR [QA_std] LIKE 'GRI_19_[b-f&x]'
--                                      OR [QA_std] LIKE 'GRI_20_01x_01[a-b]'
--                                      OR [QA_std] LIKE 'GRI_20_01x_[0-1][0-9]'
                                        OR [QA_std] LIKE 'GRX_34_02_[a-g]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                        OR [QA_std] LIKE 'SHI_01_[b-f&x]'            --  x
--                                      OR [QA_std] LIKE 'SHI_01_x_01[a-b]'
--                                      OR [QA_std] LIKE 'SHI_01_x_[0-1][0-9]'
                                        OR [QA_std] LIKE 'SHI_04_[b-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_05_[c-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_09_n'
                                        OR [QA_std] LIKE 'SHI_10_n'
                                        OR [QA_std] LIKE 'SHI_11_[a-b]_n'
                                      THEN 0.00
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--                                    WHEN [QA_std] LIKE 'GRX_29_0[2-5]'
--                                    THEN 1.00
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      ELSE NULL
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [answer_wording]     = ''
      ,   [answer_wording_std] = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'GRI_0[1-2]_filter'
--                                      OR [QA_std] LIKE 'GRI_08_a'
--                                      OR [QA_std] LIKE 'GRI_10_0[1-3]'
--                                      OR [QA_std] LIKE 'GRI_11_01[a-b]'
--                                      OR [QA_std] LIKE 'GRI_11_[0-1][0-9]'
--                                      OR [QA_std] LIKE 'GRI_19_[b-f&x]'
--                                      OR [QA_std] LIKE 'GRI_20_01x_01[a-b]'
--                                      OR [QA_std] LIKE 'GRI_20_01x_[0-1][0-9]'
                                        OR [QA_std] LIKE 'GRX_34_02_[a-g]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--                                      OR [QA_std] LIKE 'SHI_01_x_01[a-b]'
--                                      OR [QA_std] LIKE 'SHI_01_x_[0-1][0-9]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--                                      OR [QA_std] LIKE 'GRX_29_0[2-5]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN 'No'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE 'SHI_01_[b-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_04_[b-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_05_[c-f&x]'            --  x
                                        OR [QA_std] LIKE 'SHI_09_n'
                                        OR [QA_std] LIKE 'SHI_10_n'
                                        OR [QA_std] LIKE 'SHI_11_[a-b]_n'
--                                      OR [QA_std] LIKE 'GRI_19_[b-f]'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      THEN '0 to N incidents'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      ELSE ''
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [Question_fk]        = 0
      ,   [Answer_fk]          = 0
      ,   [Notes]              = ''
      ,   [DB]                 = CASE
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                      WHEN [QA_std] LIKE '%_filter'
                                      THEN -1
                                      ELSE 0
                                       END
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************************/
INTO      [#LND_NQ]
/**************************************************************************************************************************************************/
FROM
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
(SELECT 
          DISTINCT
          [Nation_fk]
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Question_Year]
                                 FROM      [#LYD_CC]               )  LYD
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
  CROSS JOIN 
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
(
/*--- filter questions ---------------------------------------------------------------------------------------------------------------------------*/
           SELECT QA_std = 'GRI_01_filter'    , QW_std =  '(If GRI_01_x is "yes") Did the change in the constitution alter any statement '
                                                        + 'of specific provision "freedom of religion"?'
 UNION ALL SELECT QA_std = 'GRI_02_filter'    , QW_std =  '(If GRI_01_x is "yes") Did the change in the constitution alter any '
                                                        + 'stipulation that appears to qualify or substantially contradict the concept '
                                                        + 'of "religious freedom"'
 UNION ALL SELECT QA_std = 'GRI_19_filter'    , QW_std =  'Were there incidents when any level of government use force toward religious '
                                                        + 'groups that resulted in individuals being killed, physically abused, '
                                                        + 'imprisoned, detained or displaced from their homes, or having their personal '
                                                        + 'or religious properties damaged or destroyed?'
 UNION ALL SELECT QA_std = 'SHI_04_filter'    , QW_std =  'Were religion-related terrorist groups active in the country?'
 UNION ALL SELECT QA_std = 'SHI_05_filter'    , QW_std =  'Was there a religion-related war or armed conflict in the country (including '
                                                        + 'ongoing displacements from previous wars)?'
 UNION ALL SELECT QA_std = 'XSG_S_99_filter'  , QW_std =  'How many supplemental sources have been used?'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*--- persisted questions ------------------------------------------------------------------------------------------------------------------------*/
-- UNION ALL SELECT QA_std = 'GRI_19_x'         , QW_std = '0 - Total N of incidents resulting from government force'
   /* already there... should others be there? */
 UNION ALL SELECT QA_std = 'SHI_01_x'         , QW_std = '0 - Total N of incidents motivated by religious hatred or bias'
 UNION ALL SELECT QA_std = 'SHI_01_summary_b' , QW_std = '0-6 Types of incidents motivated by religious hatred or bias'
 UNION ALL SELECT QA_std = 'SHI_04_x'         , QW_std = '0 - Total N of incidents resulting from religion related terrorism'
 UNION ALL SELECT QA_std = 'SHI_05_x'         , QW_std = '0 - Total N of incidents resulting from religiously-related war'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*--- NEW questions ------------------------------------------------------------------------------------------------------------------------------*/
 UNION ALL SELECT QA_std = 'GRX_34_01'         , QW_std =  'Does the government provide exemptions for religious groups from otherwise '
                                                        + 'universal laws?'
 UNION ALL SELECT QA_std = 'GRX_34_02'        , QW_std =  'If so, what areas do the exemptions cover? (check all that apply)'
 UNION ALL SELECT QA_std = 'GRX_34_02_a'      , QW_std =  'Work on religious holidays (for example, Christians being allowed to take off work '
                                                        + 'on Sundays)'
 UNION ALL SELECT QA_std = 'GRX_34_02_b'      , QW_std =  'Anti-discrimination laws (for example, giving religious business the right to not '
                                                        + 'serve or provide benefits to same-sex couples)'
 UNION ALL SELECT QA_std = 'GRX_34_02_c'      , QW_std =  'Military service (for example, allowing religious groups that oppose war or national '
                                                        + 'service to not participate in military training or activities)'
 UNION ALL SELECT QA_std = 'GRX_34_02_d'      , QW_std =  'Taxes (for example, allowing religious groups opposed to supporting states to not'
                                                        + ' pay taxes)'
 UNION ALL SELECT QA_std = 'GRX_34_02_e'      , QW_std =  'Health care provision (for example, allowing doctors to opt out of providing '
                                                        + 'contraception or abortion services, or allowing religious organizations to exclude '
                                                        + 'contraception of abortion services from health insurance coverage)'
 UNION ALL SELECT QA_std = 'GRX_34_02_f'      , QW_std =  'Education (for example, sending children to public schools)'
 UNION ALL SELECT QA_std = 'GRX_34_02_g'      , QW_std =  'Unknown (the sources indicate religious groups are granted exemptions, but provide '
                                                        + 'no details)'
 UNION ALL SELECT QA_std = 'GRX_34_03'        , QW_std =  'Were there any cases in which individuals challenged the lack of religious'
                                                        + ' exemptions from otherwise universal laws?'
 UNION ALL SELECT QA_std = 'GRX_35'           , QW_std =  'Does the government restrict individuals'' access to the internet?'
 UNION ALL SELECT QA_std = 'GRX_35_01'        , QW_std =  'Does the government restrict individuals'' access to the internet through arrests based'
                                                        + ' on internet activity?'
 UNION ALL SELECT QA_std = 'GRX_35_02'        , QW_std =  'Does the government restrict individuals'' access to the internet through censoring '
                                                        + 'of websites?'
 UNION ALL SELECT QA_std = 'SHI_09_n'         , QW_std =  'How many incidents in which individuals used violence or the threat of violence'
                                                        + '—including so-called honor killings—to try to enforce religious norms were directed'
                                                        + ' against women?'
 UNION ALL SELECT QA_std = 'SHI_10_n'         , QW_std =  'How many incidents in which individuals were assaulted or displaced from their '
                                                        + 'homes in retaliation for religious activities considered offensive or threatening '
                                                        + 'to the majority faith were directed against women?'
 UNION ALL SELECT QA_std = 'SHI_11_a_n'       , QW_std =  'How many incidents occurred in which women were harassed for violating secular '
                                                        + 'dress norms?'
 UNION ALL SELECT QA_std = 'SHI_11_b_n'       , QW_std =  'How many incidents occurred in which women were harassed for violating religious '
                                                        + 'dress codes?'
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
)                                                                                                                                                 Q
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/* <   4th long SET: new data to be entered from added questions **********************************************************************************/




/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'AllLongData'                      ) = 1
DROP              TABLE         [AllLongData]
/***  All Long Data *******************************************************************************************************************************/
SELECT
          [entity]
      ,   [link_fk]
      ,   [Nation_fk]
      ,   [Locality_fk]
      ,   [Religion_fk]
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,   [Locality]
      ,   [Religion]
      ,   [Question_Year]
      ,   [QS_fk]
      ,   [QA_std]
      ,   [QW_std]
      ,   [Answer_value]
      ,   [answer_wording]     = CASE WHEN [answer_wording] = ''
                                      THEN NULL
                                      ELSE [answer_wording]
                                 END
      ,   [answer_wording_std] = CASE WHEN [answer_wording_std] = ''
                                      THEN NULL 
                                      ELSE [answer_wording_std]
                                 END
      ,   [Question_fk]
      ,   [Answer_fk]
      ,   [Notes]
      ,   [DB]
/**************************************************************************************************************************************************/
INTO    [AllLongData]
/**************************************************************************************************************************************************/
FROM
/**************************************************************************************************************************************************/
  (
          SELECT * FROM [#LCD_DB]
    UNION SELECT * FROM [#LND_CC]
    UNION SELECT * FROM [#LYD_CC]
    UNION SELECT * FROM [#LND_NQ]
                                   ) THE4SETS

/**************************************************************************************************************************************************/
/***  All Long Data *******************************************************************************************************************************/
/**************************************************************************************************************************************************/
GO


-- select * from [AllLongData]



