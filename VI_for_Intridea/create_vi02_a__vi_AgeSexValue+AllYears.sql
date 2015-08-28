/* ++> create_vi02_a__vi_AgeSexValue+AllYears.sql <++ */
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the table [forum_ResAnal]..[vi_AgeSexValue_AllYears]                                            <<<<<     ***/
/***             NOTE:  This is a fixed table hosted at the default place for auxiliary fixed tables: [forum_ResAnal]                                        ***/
/***                                                                                                                                                         ***/
/***             Notice that display field to filter used here is:                                                                                           ***/
/***                                                                           [Display_AgeStr_15Yrs]                                                        ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/**** database name specification for data sources (once) *****************************************************************/
----------------------------------------------------------------------------------------------------------------------------
USE              [forum]
GO
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/*****                               BackUp & ReCreate current Table in [forum_ResAnal]                               *****/
/**************************************************************************************************************************/
-- exec used to include date & time:
  DECLARE @CrDt    varchar( 8)                                    --  declare variable name & data type (current date)
  DECLARE @CrTm    varchar( 5)                                    --  declare variable name & data type (current date)
  DECLARE @TofI    varchar(50)                                    --  declare variable name & data type (table of interest)
  SET     @CrDt =           (CONVERT(VARCHAR(8),GETDATE(),112))                   --  set variable value
  SET     @CrTm = (REPLACE( (CONVERT(VARCHAR(5),GETDATE(),108)) ,':','') )        --  set variable value
/*------------------------------------------------------------------------------------------------------------------------*/
  SET     @TofI = 'vi_AgeSexValue_AllYears'                                       --  set variable value
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC('
IF OBJECT_ID (N''[forum_ResAnal].[dbo].[' + @TofI + ']'', N''U'') IS NOT NULL
SELECT *
           INTO  [forum_ResAnal].[dbo].[' + @TofI + '_until_' + @CrDt + 'h' + @CrTm + ']
           FROM  [forum_ResAnal].[dbo].[' + @TofI                                   + ']' )   -- backup table if existent
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC('
IF OBJECT_ID (N''[forum_ResAnal].[dbo].[' + @TofI + ']'', N''U'') IS NOT NULL
DROP   TABLE     [forum_ResAnal].[dbo].[' + @TofI + ']' )                                     -- drop table if existent
/*------------------------------------------------------------------------------------------------------------------------*/
GO
/**************************************************************************************************************************/
IF OBJECT_ID('tempdb..#Pew_Nation_Religion_Age_Sex_Value_psf')  IS NOT NULL
DROP TABLE            #Pew_Nation_Religion_Age_Sex_Value_psf               -- drop temporary table if existent
IF OBJECT_ID('tempdb..#PNASV_CPACP_psf')                        IS NOT NULL
DROP TABLE            #PNASV_CPACP_psf                                     -- drop temporary table if existent
IF OBJECT_ID('tempdb..#PNASV_CPCAPC_psf')                       IS NOT NULL
DROP TABLE            #PNASV_CPCAPC_psf                                    -- drop temporary table if existent
----------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#TPRPartI')                               IS NOT NULL
DROP TABLE            #TPRPartI                                            -- drop temporary table if existent
IF OBJECT_ID('tempdb..#TPRPartII')                              IS NOT NULL
DROP TABLE            #TPRPartII                                           -- drop temporary table if existent
IF OBJECT_ID('tempdb..#TPRPartIII')                             IS NOT NULL
DROP TABLE            #TPRPartIII                                          -- drop temporary table if existent
----------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#CPRPartI')                               IS NOT NULL
DROP TABLE            #CPRPartI                                            -- drop temporary table if existent
IF OBJECT_ID('tempdb..#CPRPartII')                              IS NOT NULL
DROP TABLE            #CPRPartII                                           -- drop temporary table if existent
IF OBJECT_ID('tempdb..#CPRPartIII')                             IS NOT NULL
DROP TABLE            #CPRPartIII                                          -- drop temporary table if existent
----------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#A1_TPR_C')                               IS NOT NULL
DROP TABLE            #A1_TPR_C                                            -- drop temporary table if existent
IF OBJECT_ID('tempdb..#A2_TPR_R')                               IS NOT NULL
DROP TABLE            #A2_TPR_R                                            -- drop temporary table if existent
IF OBJECT_ID('tempdb..#A3_TPR_W')                               IS NOT NULL
DROP TABLE            #A3_TPR_W                                            -- drop temporary table if existent
IF OBJECT_ID('tempdb..#B1_CPR_C')                               IS NOT NULL
DROP TABLE            #B1_CPR_C                                            -- drop temporary table if existent
IF OBJECT_ID('tempdb..#B2_CPR_R')                               IS NOT NULL
DROP TABLE            #B2_CPR_R                                            -- drop temporary table if existent
IF OBJECT_ID('tempdb..#B3_CPR_W')                               IS NOT NULL
DROP TABLE            #B3_CPR_W                                            -- drop temporary table if existent
----------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#A_TPR')                                  IS NOT NULL
DROP TABLE            #A_TPR                                               -- drop temporary table if existent
IF OBJECT_ID('tempdb..#B_CPR')                                  IS NOT NULL
DROP TABLE            #B_CPR                                               -- drop temporary table if existent
IF OBJECT_ID('tempdb..#C_APR')                                  IS NOT NULL
DROP TABLE            #C_APR                                               -- drop temporary table if existent
IF OBJECT_ID('tempdb..#D_SPR')                                  IS NOT NULL
DROP TABLE            #D_SPR                                               -- drop temporary table if existent
IF OBJECT_ID('tempdb..#E_4PR')                                  IS NOT NULL
DROP TABLE            #E_4PR                                               -- drop temporary table if existent
IF OBJECT_ID('tempdb..#F_2PR')                                  IS NOT NULL
DROP TABLE            #F_2PR                                               -- drop temporary table if existent
----------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('tempdb..#Basic_Age_Sex_Value')                    IS NOT NULL
DROP TABLE            #Basic_Age_Sex_Value                                 -- drop temporary table if existent
----------------------------------------------------------------------------------------------------------------------------
GO
/**************************************************************************************************************************/
/***   RELIGION EXTRACT FROM BIG TABLE   **********************************************************************************/
/**************************************************************************************************************************/
SELECT 
       RV.[Nation_Religion_age_sex_value_pk]
      ,RV.[Field_fk]
      ,RV.[Scenario_id]
      ,RV.[Nation_fk]
      ,RV.[Religion_group_fk]
      ,RV.[Distribution_Wave_id]
      ,RV.[Sex_fk]
      ,RV.[Age_fk]
      ,RV.[Percentage]
      ,RV.[Cases]
      ,RV.[Cases_Notes]
      ,RV.[Source]
      ,RV.[Source_year]
      ,RV.[Nation_Value_Source]
      ,RV.[Notes]
      ,   [Display]                 = RV.[Display_AgeStr_15Yrs]
    INTO #Pew_Nation_Religion_Age_Sex_Value_psf
	FROM  Pew_Nation_Religion_Age_Sex_Value     AS RV
	    , Pew_Preferred_Scenario                AS PS
WHERE
		    RV.Field_fk    = PS.Field_fk
		AND RV.Nation_fk   = PS.Nation_fk
		AND RV.Scenario_id = PS.Preferred_Scenario_id
/**************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
-- select distinct [Age_fk] FROM #Pew_Nation_Religion_Age_Sex_Value_psf
----------------------------------------------------------------------------------------------------------------------------
-- select *                 from #Pew_Nation_Religion_Age_Sex_Value_psf -- where Field_fk=65
--  1 *  32 * 10 * 8 =   2,560
-- 41 * 202 * 10 * 8 = 662,560
-- 41 * 234 *  1 * 8 =  76,752
--                   = 741,872
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/***   POPULATION EXTRACTS FROM BIG TABLE   *******************************************************************************/
/**************************************************************************************************************************/
-- all population data can be considered to be by age and sex when including 0|0
/***  country popuations & aggregated country populations *****************************************************************/
SELECT 
----------------------------------------------------------------------------------------------------------------------------
       NV.[Nation_age_sex_value_pk]
      ,NV.[Field_fk]
      ,NV.[Scenario_id]
      ,NV.[Nation_fk]
      ,    Region                   = N.[SubRegion6]
      ,    Country                  = N.[Ctry_EditorialName]
      ,NV.[Sex_fk]
      ,NV.[Age_fk]
      ,NV.[Cnt]
      ,NV.[Data_source]
      ,   [Display]                 = NV.[Display_AgeStr_15Yrs]
----------------------------------------------------------------------------------------------------------------------------
      ,   [TP_by_FNSA]      =  SUM([Cnt]) OVER
                                  (PARTITION BY
                                     NV.[Field_fk]
                                   , NV.[Scenario_id]
                                   , NV.[Nation_fk]
                                   , NV.[Sex_fk]
                                   , NV.[Age_fk]       )
      ,   [TP_by_FRSA]      =  SUM([Cnt]) OVER
                                  (PARTITION BY
                                     NV.[Field_fk]
                                   , NV.[Scenario_id]
                                   ,    [SubRegion6]
                                   , NV.[Sex_fk]
                                   , NV.[Age_fk]       )
      ,   [TP_by_FWSA]      =  SUM([Cnt]) OVER
                                  (PARTITION BY
                                     NV.[Field_fk]
                                   , NV.[Scenario_id]
                                   , NV.[Sex_fk]
                                   , NV.[Age_fk]       )
----------------------------------------------------------------------------------------------------------------------------
    INTO #PNASV_CPACP_psf
----------------------------------------------------------------------------------------------------------------------------
	FROM  Pew_Nation_Age_Sex_Value     AS NV
       ,  Pew_Preferred_Scenario       AS PS
       ,  Pew_Nation                            AS N
WHERE
		    NV.Field_fk    = PS.Field_fk
		AND NV.Nation_fk   = PS.Nation_fk
		AND NV.Scenario_id = PS.Preferred_Scenario_id
		AND NV.Nation_fk   =  N.Nation_pk
/************************ Filter only ALL (w/o sex/age cohorts): **********************************************************/
        AND NV.Sex_fk      = 0 /* implies that [Age+fk]= 0, meaning 'all' */
/**************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
-- select distinct [Age_fk] FROM #PNASV_CPACP_psf
----------------------------------------------------------------------------------------------------------------------------
-- select *                 from #PNASV_CPACP_psf -- where Field_fk=65
--  1 * 234 * 11 =  2,574
/**************************************************************************************************************************/

/***  country popuations by cohort & aggregated populations  by cohort  ***************************************************/
SELECT 
----------------------------------------------------------------------------------------------------------------------------
       NV.[Nation_age_sex_value_pk]
      ,NV.[Field_fk]
      ,NV.[Scenario_id]
      ,NV.[Nation_fk]
      ,    Region                   = N.[SubRegion6]
      ,    Country                  = N.[Ctry_EditorialName]
      ,NV.[Sex_fk]
      ,NV.[Age_fk]
      ,NV.[Cnt]
      ,NV.[Data_source]
      ,   [Display]                 = NV.[Display_AgeStr_15Yrs]
----------------------------------------------------------------------------------------------------------------------------
      ,   [TP_by_FNSA]      =  SUM([Cnt]) OVER
                                  (PARTITION BY
                                     NV.[Field_fk]
                                   , NV.[Scenario_id]
                                   , NV.[Nation_fk]
                                   , NV.[Sex_fk]
                                   , NV.[Age_fk]       )
      ,   [TP_by_FRSA]      =  SUM([Cnt]) OVER
                                  (PARTITION BY
                                     NV.[Field_fk]
                                   , NV.[Scenario_id]
                                   ,    [SubRegion6]
                                   , NV.[Sex_fk]
                                   , NV.[Age_fk]       )
      ,   [TP_by_FWSA]      =  SUM([Cnt]) OVER
                                  (PARTITION BY
                                     NV.[Field_fk]
                                   , NV.[Scenario_id]
                                   , NV.[Sex_fk]
                                   , NV.[Age_fk]       )
----------------------------------------------------------------------------------------------------------------------------
    INTO #PNASV_CPCAPC_psf
----------------------------------------------------------------------------------------------------------------------------
	FROM  Pew_Nation_Age_Sex_Value     AS NV
       ,  Pew_Preferred_Scenario       AS PS
       ,  Pew_Nation                            AS N
WHERE
		    NV.Field_fk    = PS.Field_fk
		AND NV.Nation_fk   = PS.Nation_fk
		AND NV.Scenario_id = PS.Preferred_Scenario_id
		AND NV.Nation_fk   =  N.Nation_pk
/************************ Filter only 40 sex/age cohorts: *****************************************************************/
        AND NV.Sex_fk     <> 0 /* implies that [Age+fk]<> 0, meaning all rows except for 'all' */
/**************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
-- select distinct [Age_fk] FROM #PNASV_CPCAPC_psf
----------------------------------------------------------------------------------------------------------------------------
-- select *                 from #PNASV_CPCAPC_psf -- where Field_fk=65
-- 40 * 202 * 10 = 80,800
-- 40 * 234 *  1 =  9,360
--               = 90,160
/**************************************************************************************************************************/



/**************************************************************************************************************************/
/***   SUBSETS BY TOTAL POPULATION   **************************************************************************************/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
----- part I all religions toghether ---------------------------------------------------------------------------------------
	SELECT 
	      F2.Field_year          AS [Year]
		, NV.Nation_fk
		, NV.Region
		, NV.Country
		, Religion_fk            = 52   -- hard coded, table will not change
		, Religion               = 'All Religions'
		, SubReligion            = ' N.A.'

		, NV.Sex_fk
		, NV.Age_fk

		, X.Sex
		, AG.Age

		, Population             = NV.Cnt
		, Percentage             = 100

		, F2.Data_source_fk
		, NV.Display             AS NV_Display
		, RV_Display             = 1

        , [TP_by_FNSA]
        , [TP_by_FRSA]
        , [TP_by_FWSA]
----------------------------------------------------------------------------------------------------------------------------
    INTO #TPRPartI
----------------------------------------------------------------------------------------------------------------------------
	FROM #PNASV_CPACP_psf                       AS NV
	   ,  Pew_Sex                               AS X
	   ,  Pew_Age                               AS AG
	   ,  Pew_Field                             AS F2
----------------------------------------------------------------------------------------------------------------------------
WHERE
-- somehow, this speeds up the query: --------------------------------------------------------------------------------------
            NV.Nation_fk = NV.Nation_fk
----------------------------------------------------------------------------------------------------------------------------
-- match NV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  NV.Field_fk 
		  =  F2.Field_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV to its field (in order of filter & match same field year for NV & RV): not necessary! --------------------------
----------------------------------------------------------------------------------------------------------------------------
-- match NV to RV using table fields as well as field year: not necessary!  ------------------------------------------------
-- match (RV) NV in order to retreive sex labels ---------------------------------------------------------------------------
		AND  NV.Sex_fk
	      =   X.Sex_pk
-- match (RV) NV in order to retreive age labels ---------------------------------------------------------------------------
        AND  NV.Age_fk
          =  AG.Age_pk
-- match RV (religion) or RD (sub religion) in order to retreive labels: not necessary! ------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- match RV and RD to distribute population and percentage by subreligion: not necessary! ----------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- filter out religions w/0 subrel in lev02_5_display: not necessary! ------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- filter out subdistributions other than those for mid-range: not necessary! ----------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- GROUP BY: not necessary! ---
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
-- select distinct [Age_fk] FROM #TPRPartI
----------------------------------------------------------------------------------------------------------------------------
-- select *                 from #TPRPartI
--  1 * 234 * 11 =  2,574
/**************************************************************************************************************************/



/**************************************************************************************************************************/
----- part II major religions ----------------------------------------------------------------------------------------------
	SELECT 
	      F2.Field_year          AS [Year]
		, NV.Nation_fk
		, NV.Region
		, NV.Country
		, R.Religion_group_pk    AS Religion_fk
		, R.Pew_RelL02_display   AS Religion
		, SubReligion            = ' N.A.'

		, NV.Sex_fk
		, NV.Age_fk

		, X.Sex
		, AG.Age

		, Population             = (NV.Cnt * RV.Percentage / 100)
		, RV.Percentage

		, F1.Data_source_fk
		, NV.Display             AS NV_Display
		, RV.Display             AS RV_Display

        , [TP_by_FNSA]
        , [TP_by_FRSA]
        , [TP_by_FWSA]
----------------------------------------------------------------------------------------------------------------------------
    INTO #TPRPartII
----------------------------------------------------------------------------------------------------------------------------
	FROM #PNASV_CPACP_psf                       AS NV
	   , #Pew_Nation_Religion_Age_Sex_Value_psf AS RV
	   ,  Pew_Religion_Group                    AS R
	   ,  Pew_Sex                               AS X
	   ,  Pew_Age                               AS AG
	   ,  Pew_Field                             AS F1
	   ,  Pew_Field                             AS F2
----------------------------------------------------------------------------------------------------------------------------
WHERE
-- somehow, this speeds up the query: --------------------------------------------------------------------------------------
            NV.Nation_fk = NV.Nation_fk
----------------------------------------------------------------------------------------------------------------------------
-- match NV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  NV.Field_fk 
		  =  F2.Field_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  RV.Field_fk
		  =  F1.Field_pk
----------------------------------------------------------------------------------------------------------------------------
-- match NV to RV using table fields as well as field year -----------------------------------------------------------------
        AND  F1.Field_year
          =  F2.Field_year
        AND  NV.Nation_fk
          =  RV.Nation_fk
        AND  NV.Sex_fk
          =  RV.Sex_fk
        AND  NV.Age_fk
          =  RV.Age_fk
-- match RV & RV in order to retreive sex labels ---------------------------------------------------------------------------
		AND  RV.Sex_fk
	      =   X.Sex_pk
		AND  NV.Sex_fk
	      =   X.Sex_pk
-- match RV & RV in order to retreive age labels ---------------------------------------------------------------------------
        AND  RV.Age_fk
          =  AG.Age_pk
        AND  NV.Age_fk
          =  AG.Age_pk
-- match RV (religion) or RD (sub religion) in order to retreive labels ----------------------------------------------------
      AND  RV.Religion_group_fk         -- not linked subreligion, we link religion instead
        =   R.Religion_group_pk
--      AND  RD.Sub_Religion_fk           -- not linked religion, we link subreligion instead
--        =   R.Religion_group_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV and RD to distribute population and percentage by subreligion: not necessary! ----------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- filter out religions w/0 subrel in lev02_5_display: not necessary! ------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- filter out subdistributions other than those for mid-range: not necessary! ----------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- GROUP BY: not necessary! ---
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
-- select distinct [Age_fk] FROM #TPRPartII
----------------------------------------------------------------------------------------------------------------------------
-- select *                 from #TPRPartII
--  1 *  32 * 10 * 8 =   2,560
--  1 * 202 * 10 * 8 =  16,160
--  1 * 234 *  1 * 8 =   1,872
------------------------------
--  1 * 234 * 11 * 8 =  20,592
/**************************************************************************************************************************/


/**************************************************************************************************************************/
--- part III subreligions --------------------------------------------------------------------------------------------------
	SELECT 
	      F2.Field_year          AS [Year]
		, NV.Nation_fk
		, NV.Region
		, NV.Country
		, Religion_fk            = NULL
		, R.Pew_RelL02_display   AS Religion
		, R.Pew_RelL02_5_display AS SubReligion

		, NV.Sex_fk
		, NV.Age_fk

		, X.Sex
		, AG.Age

		, Population =  SUM(((NV.Cnt * RV.Percentage / 100) * RD.Proportion / 100))
		, Percentage = (SUM(RD.Proportion) * RV.Percentage) / 100

		, F1.Data_source_fk
		, NV.Display             AS NV_Display
		, RV.Display             AS RV_Display

        , [TP_by_FNSA]
        , [TP_by_FRSA]
        , [TP_by_FWSA]
----------------------------------------------------------------------------------------------------------------------------
    INTO #TPRPartIII
----------------------------------------------------------------------------------------------------------------------------
	FROM #PNASV_CPACP_psf                       AS NV
	   , #Pew_Nation_Religion_Age_Sex_Value_psf AS RV
	   ,  Pew_Religion_Group                    AS R
	   ,  Pew_Sex                               AS X
	   ,  Pew_Age                               AS AG
	   ,  Pew_Field                             AS F1
	   ,  Pew_Field                             AS F2
       ,  Pew_Nation_Subreligion_Distribution   AS RD
----------------------------------------------------------------------------------------------------------------------------
WHERE
-- somehow, this speeds up the query: --------------------------------------------------------------------------------------
            NV.Nation_fk = NV.Nation_fk
----------------------------------------------------------------------------------------------------------------------------
-- match NV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  NV.Field_fk 
		  =  F2.Field_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  RV.Field_fk
		  =  F1.Field_pk
----------------------------------------------------------------------------------------------------------------------------
-- match NV to RV using table fields as well as field year -----------------------------------------------------------------
        AND  F1.Field_year
          =  F2.Field_year
        AND  NV.Nation_fk
          =  RV.Nation_fk
        AND  NV.Sex_fk
          =  RV.Sex_fk
        AND  NV.Age_fk
          =  RV.Age_fk
-- match RV & RV in order to retreive sex labels ---------------------------------------------------------------------------
		AND  RV.Sex_fk
	      =   X.Sex_pk
		AND  NV.Sex_fk
	      =   X.Sex_pk
-- match RV & RV in order to retreive age labels ---------------------------------------------------------------------------
        AND  RV.Age_fk
          =  AG.Age_pk
        AND  NV.Age_fk
          =  AG.Age_pk
-- match RV (religion) or RD (sub religion) in order to retreive labels ----------------------------------------------------
--      AND  RV.Religion_group_fk         -- not linked subreligion, we link religion instead
--        =   R.Religion_group_pk
      AND  RD.Sub_Religion_fk           -- not linked religion, we link subreligion instead
        =   R.Religion_group_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV and RD to distribute population and percentage by subreligion --------------------------------------------------
        AND RV.Nation_fk
          = RD.Nation_fk
        AND RV.Religion_group_fk
          = RD.Aggregated_Religion_fk
        AND RV.Distribution_Wave_id
          = RD.Distribution_Wave_id
----------------------------------------------------------------------------------------------------------------------------
-- filter out religions w/0 subrel in lev02_5_display ----------------------------------------------------------------------
        AND   R.Pew_RelL02_5_display           -- data should be aggregated later, because the original
         !=   R.Pew_RelL02_display             -- subdistribution is at level 03  /* corrected Sept12/2014 */
----------------------------------------------------------------------------------------------------------------------------
-- filter out subdistributions other than those for mid-range --------------------------------------------------------------
        AND  RD.Majority_SubReligion_Range
          =     'mid'
----------------------------------------------------------------------------------------------------------------------------
GROUP BY 
           F2.Field_year
         , NV.Nation_fk
         , NV.Region
		 , NV.Country
		 , R.Pew_RelL02_display
         , R.Pew_RelL02_5_display
		 , RV.Percentage
         , NV.Sex_fk
         , NV.Age_fk
         , X.Sex 
         , AG.Age
		 , F1.Data_source_fk
         , NV.Display
         , RV.Display
        , [TP_by_FNSA]
        , [TP_by_FRSA]
        , [TP_by_FWSA]
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
-- select distinct [Age_fk] FROM #TPRPartIII
----------------------------------------------------------------------------------------------------------------------------
-- select *                 from #TPRPartIII
--  1 * 234 * 11 * 4 =  10,296
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET A1: By country, total population (no sex-age differentials) --------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]           = 1
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TotPopulat]      = [TP_by_FNSA]
          ,    [Population]
          ,    [Percentage]
          ,    [Data_source_fk]
          ,    [NV_Display]
          ,    [RV_Display]
----------------------------------------------------------------------------------------------------------------------------
INTO    #A1_TPR_C
----------------------------------------------------------------------------------------------------------------------------
FROM
      ( SELECT * FROM #TPRPartI
        UNION ALL
        SELECT * FROM #TPRPartII
        UNION ALL
        SELECT * FROM #TPRPartIII ) AS TPR
----------------------------------------------------------------------------------------------------------------------------
-- NO AGGREGATION
/**************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
-- select distinct [Age_fk] FROM #A1_TPR_C
----------------------------------------------------------------------------------------------------------------------------
-- select *                 from #A1_TPR_C
--  1 * 234 * 11     =   2,574            #TPRPartI
--  1 * 234 * 11 * 8 =  20,592            #TPRPartII
--  1 * 234 * 11 * 4 =  10,296            #TPRPartIII
--                   =  33,462
/**************************************************************************************************************************/



/**************************************************************************************************************************/
--- SET A2: By region, total population (no sex-age differentials) ---------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]           = 2
          ,    [Nation_fk]       =  CASE
                                    WHEN Region = 'North America'             THEN 1001
                                    WHEN Region = 'Latin America-Caribbean'   THEN 1002
                                    WHEN Region = 'Europe'                    THEN 1003
                                    WHEN Region = 'Middle East-North Africa'  THEN 1004
                                    WHEN Region = 'Sub-Saharan Africa'        THEN 1005
                                    WHEN Region = 'Asia-Pacific'              THEN 1006
                                    END
          ,    [Region]
          ,    [Country]         = ' All Countries'
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TotPopulat]      =                        [TP_by_FRSA]
          ,    [Population]      =   SUM([Population])
          ,    [Percentage]      = ((SUM([Population])) / [TP_by_FRSA]) * 100
          ,    [Data_source_fk]
          ,    [NV_Display]      = 1
          ,    [RV_Display]      = 1
----------------------------------------------------------------------------------------------------------------------------
INTO    #A2_TPR_R
----------------------------------------------------------------------------------------------------------------------------
FROM
      ( SELECT * FROM #TPRPartI
        UNION ALL
        SELECT * FROM #TPRPartII
        UNION ALL
        SELECT * FROM #TPRPartIII ) AS TPR
----------------------------------------------------------------------------------------------------------------------------
   GROUP BY 
               [Year]
          ,    [Region]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TP_by_FRSA]
          ,    [Data_source_fk]
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET A3: By wave, total population (no sex-age differentials) -----------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]           = 3
          ,    [Nation_fk]       =  10000
          ,    [Region]          = ' World'
          ,    [Country]         = ' All Countries'
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TotPopulat]      =                        [TP_by_FWSA]
          ,    [Population]      =   SUM([Population])
          ,    [Percentage]      = ((SUM([Population])) / [TP_by_FWSA]) * 100
          ,    [Data_source_fk]
          ,    [NV_Display]      = 1
          ,    [RV_Display]      = 1
----------------------------------------------------------------------------------------------------------------------------
INTO    #A3_TPR_W
----------------------------------------------------------------------------------------------------------------------------
FROM
      ( SELECT * FROM #TPRPartI
        UNION ALL
        SELECT * FROM #TPRPartII
        UNION ALL
        SELECT * FROM #TPRPartIII ) AS TPR
----------------------------------------------------------------------------------------------------------------------------
   GROUP BY 
               [Year]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TP_by_FWSA]
          ,    [Data_source_fk]
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET A: three levles of total population (no sex-age differentials) -----------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          *
----------------------------------------------------------------------------------------------------------------------------
INTO    #A_TPR
----------------------------------------------------------------------------------------------------------------------------
FROM
      ( SELECT * FROM #A1_TPR_C
        UNION ALL
        SELECT * FROM #A2_TPR_R
        UNION ALL
        SELECT * FROM #A3_TPR_W   ) AS TPR123
----------------------------------------------------------------------------------------------------------------------------
-- NO AGGREGATION
/**************************************************************************************************************************/

/**************************************************************************************************************************/
------------------------------------------------------
--select * from #TPRPartI     -- 234 * 11     =  2,574
--select * from #TPRPartII    -- 234 * 11 * 8 = 20,592
--select * from #TPRPartIII   -- 234 * 11 * 4 = 10,296
--                                            --------
--select * from #A1_TPR_C     --              = 33,462
------------------------------------------------------
--select * from #A2_TPR_R     --   6 * 11           66
--                            -- + 6 * 11 * 8      528
--                            -- + 6 * 11 * 4      264
--                            --              =    858
------------------------------------------------------
--select * from #A3_TPR_W     --       11           11
--                            -- +     11 * 8       88
--                            -- +     11 * 4       44
--                            --              =    143
------------------------------------------------------
------------------------------------------------------
--select * from #A_TPR        --                33,462
--                            --                   858
--                            --                   143
--                            --              = 34,463
------------------------------------------------------
/**************************************************************************************************************************/



/**************************************************************************************************************************/
/***   SUBSETS BY SEX AND AGE COHORTS   ***********************************************************************************/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
----- part I all religions toghether ---------------------------------------------------------------------------------------
	SELECT 
	      F2.Field_year          AS [Year]
		, NV.Nation_fk
		, NV.Region
		, NV.Country
		, Religion_fk            = 52   -- hard coded, table will not change
		, Religion               = 'All Religions'
		, SubReligion            = ' N.A.'

		, NV.Sex_fk
		, NV.Age_fk

		, X.Sex
		, AG.Age

		, Population             = NV.Cnt
		, Percentage             = 100

		, F2.Data_source_fk
		, NV.Display             AS NV_Display
		, RV_Display             = 1

        , [TP_by_FNSA]
        , [TP_by_FRSA]
        , [TP_by_FWSA]
----------------------------------------------------------------------------------------------------------------------------
    INTO #CPRPartI
----------------------------------------------------------------------------------------------------------------------------
	FROM #PNASV_CPCAPC_psf                      AS NV
	   ,  Pew_Sex                               AS X
	   ,  Pew_Age                               AS AG
	   ,  Pew_Field                             AS F2
----------------------------------------------------------------------------------------------------------------------------
WHERE
-- somehow, this speeds up the query: --------------------------------------------------------------------------------------
            NV.Nation_fk = NV.Nation_fk
----------------------------------------------------------------------------------------------------------------------------
-- match NV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  NV.Field_fk 
		  =  F2.Field_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV to its field (in order of filter & match same field year for NV & RV): not necessary! --------------------------
----------------------------------------------------------------------------------------------------------------------------
-- match NV to RV using table fields as well as field year: not necessary!  ------------------------------------------------
-- match (RV) NV in order to retreive sex labels ---------------------------------------------------------------------------
		AND  NV.Sex_fk
	      =   X.Sex_pk
-- match (RV) NV in order to retreive age labels ---------------------------------------------------------------------------
        AND  NV.Age_fk
          =  AG.Age_pk
-- match RV (religion) or RD (sub religion) in order to retreive labels: not necessary! ------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- match RV and RD to distribute population and percentage by subreligion: not necessary! ----------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- filter out religions w/0 subrel in lev02_5_display: not necessary! ------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- filter out subdistributions other than those for mid-range: not necessary! ----------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- GROUP BY: not necessary! ---
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/

/**************************************************************************************************************************/
----- part II major religions ----------------------------------------------------------------------------------------------
	SELECT 
	      F2.Field_year          AS [Year]
		, NV.Nation_fk
		, NV.Region
		, NV.Country
		, R.Religion_group_pk    AS Religion_fk
		, R.Pew_RelL02_display   AS Religion
		, SubReligion            = ' N.A.'

		, NV.Sex_fk
		, NV.Age_fk

		, X.Sex
		, AG.Age

		, Population             = (NV.Cnt * RV.Percentage / 100)
		, RV.Percentage

		, F1.Data_source_fk
		, NV.Display             AS NV_Display
		, RV.Display             AS RV_Display

        , [TP_by_FNSA]
        , [TP_by_FRSA]
        , [TP_by_FWSA]
----------------------------------------------------------------------------------------------------------------------------
    INTO #CPRPartII
----------------------------------------------------------------------------------------------------------------------------
	FROM #PNASV_CPCAPC_psf                      AS NV
	   , #Pew_Nation_Religion_Age_Sex_Value_psf AS RV
	   ,  Pew_Religion_Group                    AS R
	   ,  Pew_Sex                               AS X
	   ,  Pew_Age                               AS AG
	   ,  Pew_Field                             AS F1
	   ,  Pew_Field                             AS F2
----------------------------------------------------------------------------------------------------------------------------
WHERE
-- somehow, this speeds up the query: --------------------------------------------------------------------------------------
            NV.Nation_fk = NV.Nation_fk
----------------------------------------------------------------------------------------------------------------------------
-- match NV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  NV.Field_fk 
		  =  F2.Field_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  RV.Field_fk
		  =  F1.Field_pk
----------------------------------------------------------------------------------------------------------------------------
-- match NV to RV using table fields as well as field year -----------------------------------------------------------------
        AND  F1.Field_year
          =  F2.Field_year
        AND  NV.Nation_fk
          =  RV.Nation_fk
        AND  NV.Sex_fk
          =  RV.Sex_fk
        AND  NV.Age_fk
          =  RV.Age_fk
-- match RV & RV in order to retreive sex labels ---------------------------------------------------------------------------
		AND  RV.Sex_fk
	      =   X.Sex_pk
		AND  NV.Sex_fk
	      =   X.Sex_pk
-- match RV & RV in order to retreive age labels ---------------------------------------------------------------------------
        AND  RV.Age_fk
          =  AG.Age_pk
        AND  NV.Age_fk
          =  AG.Age_pk
-- match RV (religion) or RD (sub religion) in order to retreive labels ----------------------------------------------------
      AND  RV.Religion_group_fk         -- not linked subreligion, we link religion instead
        =   R.Religion_group_pk
--      AND  RD.Sub_Religion_fk           -- not linked religion, we link subreligion instead
--        =   R.Religion_group_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV and RD to distribute population and percentage by subreligion: not necessary! ----------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- filter out religions w/0 subrel in lev02_5_display: not necessary! ------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- filter out subdistributions other than those for mid-range: not necessary! ----------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
-- GROUP BY: not necessary! ---
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET B1: By country, population by sex and age cohorts ------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]           = 1
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TotPopulat]      = [TP_by_FNSA]
          ,    [Population]
          ,    [Percentage]
          ,    [Data_source_fk]
          ,    [NV_Display]
          ,    [RV_Display]
----------------------------------------------------------------------------------------------------------------------------
INTO    #B1_CPR_C
----------------------------------------------------------------------------------------------------------------------------
FROM
      ( SELECT * FROM #CPRPartI
        UNION ALL
        SELECT * FROM #CPRPartII  ) AS CPR
----------------------------------------------------------------------------------------------------------------------------
-- NO AGGREGATION
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET B2: By region, population by sex and age cohorts -------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
             U.[Year]
          ,  U.[level]
          ,  U.[Nation_fk]
          ,  U.[Region]
          ,  U.[Country]
          ,  U.[Religion_fk]
          ,  U.[Religion]
          ,  U.[SubReligion]
          ,  U.[Sex_fk]
          ,  U.[Age_fk]
          ,  U.[Sex]
          ,  U.[Age]
          ,  U.[TotPopulat]
          ,  U.[Population]
          ,  U.[Percentage]
          ,  U.[Data_source_fk]
          ,  U.[NV_Display]
          ,    [RV_Display]      = ISNULL(F.[15YrsAgeStr_Data], 1)
----------------------------------------------------------------------------------------------------------------------------
INTO    #B2_CPR_R
----------------------------------------------------------------------------------------------------------------------------
----select *
FROM
----------------------------------------------------------------------------------------------------------------------------
    [forum].[dbo].[Pew_Display_by_Nation&Religion]                                                        F   -- PewFilter
----------------------------------------------------------------------------------------------------------------------------
FULL
JOIN
  ( SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]           = 2
          ,    [Nation_fk]       =  CASE
                                    WHEN Region = 'North America'             THEN 1001
                                    WHEN Region = 'Latin America-Caribbean'   THEN 1002
                                    WHEN Region = 'Europe'                    THEN 1003
                                    WHEN Region = 'Middle East-North Africa'  THEN 1004
                                    WHEN Region = 'Sub-Saharan Africa'        THEN 1005
                                    WHEN Region = 'Asia-Pacific'              THEN 1006
                                    END
          ,    [Region]
          ,    [Country]         = ' All Countries'
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TotPopulat]      =                        [TP_by_FRSA]
          ,    [Population]      =   SUM([Population])
          ,    [Percentage]      = ((SUM([Population])) / [TP_by_FRSA]) * 100
          ,    [Data_source_fk]
          ,    [NV_Display]      = 1
--        ,    [RV_Display]      = 1   no longed defaulted to 1 jceo/Mar2015
----------------------------------------------------------------------------------------------------------------------------
FROM
      ( SELECT * FROM #CPRPartI
        UNION ALL
        SELECT * FROM #CPRPartII  ) AS CPR
----------------------------------------------------------------------------------------------------------------------------
   GROUP BY 
               [Year]
          ,    [Region]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TP_by_FRSA]
          ,    [Data_source_fk]
----------------------------------------------------------------------------------------------------------------------------
                                                                                                       )  U   -- UnFiltered
----------------------------------------------------------------------------------------------------------------------------
ON     [F].[Nation_fk]
     = [U].[Nation_fk]
  AND  [F].[Religion_fk]
     = [U].[Religion_fk]
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET B3: By wave, population by sex and age cohorts -------------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]           = 3
          ,    [Nation_fk]       =  10000
          ,    [Region]          = ' World'
          ,    [Country]         = ' All Countries'
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TotPopulat]      =                        [TP_by_FWSA]
          ,    [Population]      =   SUM([Population])
          ,    [Percentage]      = ((SUM([Population])) / [TP_by_FWSA]) * 100
          ,    [Data_source_fk]
          ,    [NV_Display]      = 1
          ,    [RV_Display]      = 1
----------------------------------------------------------------------------------------------------------------------------
INTO    #B3_CPR_W
----------------------------------------------------------------------------------------------------------------------------
FROM
      ( SELECT * FROM #CPRPartI
        UNION ALL
        SELECT * FROM #CPRPartII  ) AS CPR
----------------------------------------------------------------------------------------------------------------------------
   GROUP BY 
               [Year]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TP_by_FWSA]
          ,    [Data_source_fk]
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET B: three levles of population by sex and age cohorts ---------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
          *
----------------------------------------------------------------------------------------------------------------------------
INTO    #B_CPR
----------------------------------------------------------------------------------------------------------------------------
FROM
      ( SELECT * FROM #B1_CPR_C
        UNION ALL
        SELECT * FROM #B2_CPR_R
        UNION ALL
        SELECT * FROM #B3_CPR_W   ) AS CPR123
----------------------------------------------------------------------------------------------------------------------------
-- NO AGGREGATION
/**************************************************************************************************************************/

/**************************************************************************************************************************/
-----------------------------------------------------------------------
--select * from #CPRPartI     --  40 * 202 * 10     = 80,800
--                            --  40 * 234 *  1     =  9,360
--                            --                              =  90,160
--select * from #CPRPartII    --  40 * 202 * 10 * 8 = 646,400
--                            --  40 * 234 *  1 * 8 =  74,880
--                            --                              = 721,280
--                                                   ------------------
--select * from #B1_CPR_C     --                              = 811,440
-----------------------------------------------------------------------
--select * from #B2_CPR_R     --  40 *   6 * 11     =   2,640
--                            --  40 *   6 * 11 * 8 =  21,120
--                            --                              =  23,760
-----------------------------------------------------------------------
--select * from #B3_CPR_W     --  40 *   1 * 11     =     440
--                            --  40 *   1 * 11 * 8 =   3,520
--                            --                              =   3,960
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--select * from #B_CPR        --                              = 839,160
-----------------------------------------------------------------------
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/***   SUBSET BY AGE COHORTS (NO SEX DIFFERENTIALS)  **********************************************************************/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET C: three levles of population by age cohorts (no sex differentials) ------------------------------------------------
--- from the aggregation of SET B (population by sex and age) --------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]          = 0
          ,    [Age_fk]
          ,    [Sex]             = 'all'
          ,    [Age]
          ,    [TotPopulat]      =                                    SUM([TotPopulat])
          ,    [Population]      =               SUM([Population])
          ,    [Percentage]      = CASE
                                        WHEN                          SUM([TotPopulat]) =  0
                                        THEN                                               0
                                        ELSE ( ((SUM([Population])) / SUM([TotPopulat])) * 100 )
                                    END
          ,    [Data_source_fk]
          ,    [NV_Display]      =   MIN([NV_Display])
          ,    [RV_Display]      =   MIN([RV_Display])
----------------------------------------------------------------------------------------------------------------------------
INTO    #C_APR
----------------------------------------------------------------------------------------------------------------------------
FROM
        #B_CPR
----------------------------------------------------------------------------------------------------------------------------
   GROUP BY 
               [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Age_fk]
          ,    [Age]
          ,    [Data_source_fk]
/**************************************************************************************************************************/
-------------------------------------------------------
--select * from #C_APR        --  839,160 / 2 = 419,580
-------------------------------------------------------
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/***   SUBSET BY SEX COHORTS (NO AGE DIFFERENTIALS)  **********************************************************************/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET D: three levles of population by sex cohorts (no age differentials) ------------------------------------------------
--- from the aggregation of SET B (population by sex and age) --------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]          = 0
          ,    [Sex]
          ,    [Age]             = 'all'
          ,    [TotPopulat]      =                                    SUM([TotPopulat])
          ,    [Population]      =               SUM([Population])
          ,    [Percentage]      = CASE
                                        WHEN                          SUM([TotPopulat]) =  0
                                        THEN                                               0
                                        ELSE ( ((SUM([Population])) / SUM([TotPopulat])) * 100 )
                                    END
          ,    [Data_source_fk]
          ,    [NV_Display]      =   MIN([NV_Display])
          ,    [RV_Display]      =   MIN([RV_Display])
----------------------------------------------------------------------------------------------------------------------------
INTO    #D_SPR
----------------------------------------------------------------------------------------------------------------------------
FROM
        #B_CPR
----------------------------------------------------------------------------------------------------------------------------
   GROUP BY 
               [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Sex]
          ,    [Data_source_fk]
/**************************************************************************************************************************/
-------------------------------------------------------
--select * from #D_SPR        --  839,160 / 20 = 41,958
-------------------------------------------------------
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/***   SUBSET BY 0-to-29 & 30+ AGE COHORTS AND BY SEX  ********************************************************************/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET E: three levles of population by <30 & 30+ age cohorts and by sex --------------------------------------------------
--- from the aggregation of SET B (population by sex and age) --------------------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [TotPopulat]      =                                    SUM([TotPopulat])
          ,    [Population]      =               SUM([Population])
          ,    [Percentage]      = CASE
                                        WHEN                          SUM([TotPopulat]) =  0
                                        THEN                                               0
                                        ELSE ( ((SUM([Population])) / SUM([TotPopulat])) * 100 )
                                    END
          ,    [Data_source_fk]
          ,    [NV_Display]      =   MIN([NV_Display])
          ,    [RV_Display]      =   MIN([RV_Display])
----------------------------------------------------------------------------------------------------------------------------
INTO    #E_4PR
----------------------------------------------------------------------------------------------------------------------------
FROM
----------------------------------------------------------------------------------------------------------------------------
      ( SELECT
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
               [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]          = CASE
                                        WHEN  [Age_fk] <= 15
                                        THEN              91
                                        WHEN  [Age_fk] >= 16
                                        THEN              92
                                    END
          ,    [Sex]
          ,    [Age]             = CASE
                                        WHEN  [Age_fk] <= 15
                                        THEN              '0-29'
                                        WHEN  [Age_fk] >= 16
                                        THEN              '30+'
                                    END
          ,    [TotPopulat]
          ,    [Population]
          ,    [Percentage]
          ,    [Data_source_fk]
          ,    [NV_Display]
          ,    [RV_Display]
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
         FROM    #B_CPR                                                                                         )  AS  AC30
----------------------------------------------------------------------------------------------------------------------------
   GROUP BY 
               [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]
          ,    [Age_fk]
          ,    [Sex]
          ,    [Age]
          ,    [Data_source_fk]
/**************************************************************************************************************************/
-------------------------------------------------------
--select * from #E_4PR        --  839,160 / 10 = 83,916
-------------------------------------------------------
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/***   SUBSET BY 0-to-29 & 30+ AGE COHORTS (NO SEX DIFFERENTIALS)  ********************************************************/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--- SET F: three levles of population by <30 & 30+ age cohorts (no sex differentials) --------------------------------------
--- from the aggregation of SET E (by <30 & 30+ age cohorts and by sex) ----------------------------------------------------
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Sex_fk]          = 0
          ,    [Age_fk]
          ,    [Sex]             = 'all'
          ,    [Age]
          ,    [TotPopulat]      =                                    SUM([TotPopulat])
          ,    [Population]      =               SUM([Population])
          ,    [Percentage]      = CASE
                                        WHEN                          SUM([TotPopulat]) =  0
                                        THEN                                               0
                                        ELSE ( ((SUM([Population])) / SUM([TotPopulat])) * 100 )
                                    END
          ,    [Data_source_fk]
          ,    [NV_Display]      =   MIN([NV_Display])
          ,    [RV_Display]      =   MIN([RV_Display])
----------------------------------------------------------------------------------------------------------------------------
INTO    #F_2PR
----------------------------------------------------------------------------------------------------------------------------
FROM
        #E_4PR
----------------------------------------------------------------------------------------------------------------------------
   GROUP BY 
               [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Region]
          ,    [Country]
          ,    [Religion_fk]
          ,    [Religion]
          ,    [SubReligion]
          ,    [Age_fk]
          ,    [Age]
          ,    [Data_source_fk]
/**************************************************************************************************************************/
-------------------------------------------------------
--select * from #F_2PR        --   83,916 /  2 = 41,958 
-------------------------------------------------------
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/***      COMPLETE DATA SET BY YEAR, COUNTRY, RELIGION, SEX, AND AGE COHORTS (INCLUDING ALL LEVELS OF AGGREGATION)      ***/
/**************************************************************************************************************************/
SELECT
----------------------------------------------------------------------------------------------------------------------------
          *
----------------------------------------------------------------------------------------------------------------------------
INTO    #Basic_Age_Sex_Value
----------------------------------------------------------------------------------------------------------------------------
FROM
      ( SELECT * FROM #A_TPR
        UNION ALL
        SELECT * FROM #B_CPR
        UNION ALL
        SELECT * FROM #C_APR
        UNION ALL
        SELECT * FROM #D_SPR
        UNION ALL
        SELECT * FROM #E_4PR
        UNION ALL
        SELECT * FROM #F_2PR      ) AS ABCDE
----------------------------------------------------------------------------------------------------------------------------
-- NO AGGREGATION
/**************************************************************************************************************************/

/**************************************************************************************************************************/
--------------------------------------------------------
--select * from #A_TPR                --        34,463
--select * from #B_CPR                --       839,160
--select * from #C_APR                --       419,580
--select * from #D_SPR                --        41,958
--select * from #E_4PR                --        83,916
--select * from #F_2PR                --        41,958 
--------------------------------------------------------
--select * from #Basic_Age_Sex_Value  --   = 1,461,035
--------------------------------------------------------
/**************************************************************************************************************************/
/**************************************************************************************************************************/

--- PERMANENT TABLE --------------------------------------------------------------------------------------------------------
SELECT
          ASVv_row
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [year]
                           , [level] DESC
                           , [Nation_fk]
                           , [Religion]
                           , [SubReligion]
                           , [Sex_fk]
                           , [Age_fk]        )
	    , [Year]
        , [level]
		, [Nation_fk]
        , [Region]
		, [Country]
        , [Religion_fk]
		, [Religion]
		, [SubReligion]
		, [Sex]
		, [Age]
		, [TotPopulat]
		, [Population]
		, [Percentage]
		, [Data_source_fk]
		, [NV_Display_AgeStr_15Yrs] = [NV_Display]
		, [RV_Display_AgeStr_15Yrs] = [RV_Display]
        , [Sex_fk]
        , [Age_fk]
----------------------------------------------------------------------------------------------------------------------------
    INTO  [forum_ResAnal].[dbo].[vi_AgeSexValue_AllYears]    -- 1,419,077
----------------------------------------------------------------------------------------------------------------------------
FROM
          #Basic_Age_Sex_Value
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
go