/**************************************************************************************************************************/
/***                                                                                                                    ***/
/***     >>>>>   This is the script used to create the table [forum_ResAnal]..[vi_AgeSexValue_AllYears]       <<<<<     ***/
/**** database name specification for data sources (once) *****************************************************************/
/**** database name specification for data target (three times) ***********************************************************/
----------------------------------------------------------------------------------------------------------------------------
USE              [forum]
GO
/**************************************************************************************************************************/
IF OBJECT_ID('tempdb..#PNRASV_psf')  IS NOT NULL
DROP TABLE            #PNRASV_psf               -- drop temporary table if existent
IF OBJECT_ID('tempdb..#PNASV_psf')   IS NOT NULL
DROP TABLE            #PNASV_psf                -- drop temporary table if existent
/*------------------------------------------------------------------------------------------------------------------------*/
IF OBJECT_ID (N'[forum_ResAnal].[dbo].[vp_AgeSexValue]', N'U') IS NOT NULL
DROP   TABLE    [forum_ResAnal].[dbo].[vp_AgeSexValue]         -- drop table if existent
/*------------------------------------------------------------------------------------------------------------------------*/
GO
/**************************************************************************************************************************/
/***   RELIGION EXTRACT FROM BIG TABLE   **********************************************************************************/
/**************************************************************************************************************************/
SELECT 
       RV.[Nation_Religion_age_sex_value_pk]
      ,F1.[Field_year]
      ,RV.[Scenario_id]
      ,   [ScenarioDesc]          = SC.[Scenario_description]
      ,   [Scenario]              = CASE WHEN RV.[Scenario_ID] =  1 THEN 'Working data'
                                         WHEN RV.[Scenario_ID] =  2 THEN 'Unique'
                                         WHEN RV.[Scenario_ID] =  3 THEN 'UNPopulation'
                                         WHEN RV.[Scenario_ID] =  4 THEN 'MainScenario'
                                         WHEN RV.[Scenario_ID] =  5 THEN 'EqualFertility'
                                         WHEN RV.[Scenario_ID] =  6 THEN 'ZeroMigration'
                                         WHEN RV.[Scenario_ID] =  7 THEN 'NoSwitching'
                                         WHEN RV.[Scenario_ID] =  8 THEN 'Published2013'
                                         WHEN RV.[Scenario_ID] =  9 THEN 'UNPop2010Rev'
                                         WHEN RV.[Scenario_ID] = 10 THEN 'ExtraSwitching'
                                     END
      ,RV.[Nation_fk]
      ,   [Religion_fk]           = RV.[Religion_group_fk]
      ,   [Religion]              =  R.[Pew_RelL02_Display]
      ,RV.[Distribution_Wave_id]
      ,RV.[Sex_fk]
      ,RV.[Age_fk]
      ,RV.[Percentage]
      ,RV.[Cases]
      ,RV.[Cases_Notes]
      ,   [RelDistSource]         = RV.[Source]
      ,   [RelDistSourceYr]       = RV.[Source_year]
      ,   [RelDistNotes]          = RV.[Notes]
    INTO #PNRASV_psf
	FROM  Pew_Nation_Religion_Age_Sex_Value     AS RV
	    , Pew_Religion_Group                    AS R
        , Pew_Field                             AS F1
        , Pew_Scenario                          AS SC
----------------------------------------------------------------------------------------------------------------------------
WHERE
----------------------------------------------------------------------------------------------------------------------------
-- match RV to religion names ----------------------------------------------------------------------------------------------
             RV.Religion_Group_fk
          =   R.Religion_group_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  RV.Field_fk
		  =  F1.Field_pk
----------------------------------------------------------------------------------------------------------------------------
-- match RV to its field (in order of filter & match same field year for NV & RV) ------------------------------------------
		AND  RV.Scenario_id
		  =  SC.Scenario_id
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/***   POPULATION EXTRACT FROM BIG TABLE   ********************************************************************************/
/**************************************************************************************************************************/
SELECT 
----------------------------------------------------------------------------------------------------------------------------
       NV.[Nation_age_sex_value_pk]
      ,F2.[Field_year]
      ,NV.[Scenario_id]
      ,NV.[Nation_fk]
      ,    Region                   =  N.[SubRegion6]
      ,    Country                  =  N.[Ctry_EditorialName]
      ,NV.[Sex_fk]
      , X.[Sex]
      ,NV.[Age_fk]
      ,AG.[Age]
      ,NV.[Cnt]
      ,   [PopSource]               = NV.[Data_source]
----------------------------------------------------------------------------------------------------------------------------
    INTO #PNASV_psf
----------------------------------------------------------------------------------------------------------------------------
	FROM  Pew_Nation_Age_Sex_Value              AS NV
       ,  Pew_Nation                            AS N
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
        AND  NV.Nation_fk
          =   N.Nation_pk
-- match RV & RV in order to retreive sex labels ---------------------------------------------------------------------------
		AND  NV.Sex_fk
	      =   X.Sex_pk
-- match RV & RV in order to retreive age labels ---------------------------------------------------------------------------
        AND  NV.Age_fk
          =  AG.Age_pk
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
	SELECT 
----------------------------------------------------------------------------------------------------------------------------
          [YEAR]                 = NV.[Field_year]
--    ,NV.[Scenario_id]
--    ,RV.[ScenarioDesc]
      ,RV.[Scenario]
      ,NV.[Region]
      ,NV.[Country]
      ,RV.[Religion]
      ,NV.[Sex]
      ,NV.[Age]
	  ,   [Population]           = (NV.Cnt * RV.Percentage / 100)
      ,RV.[Percentage]
--    ,NV.[Nation_fk]
--    ,RV.[Religion_fk]
--    ,NV.[Sex_fk]
--    ,NV.[Age_fk]
--    ,RV.[Cases]
--    ,RV.[Cases_Notes]
--    ,RV.[RelDistSource]
--    ,RV.[RelDistSourceYr]
--    ,RV.[RelDistNotes]
      ,NV.[PopSource]
----------------------------------------------------------------------------------------------------------------------------
    INTO [forum_ResAnal].[dbo].[vp_AgeSexValue]
----------------------------------------------------------------------------------------------------------------------------
	FROM #PNASV_psf    AS NV
	   , #PNRASV_psf   AS RV
----------------------------------------------------------------------------------------------------------------------------
WHERE
-- somehow, this speeds up the query: --------------------------------------------------------------------------------------
            NV.Nation_fk = NV.Nation_fk
----------------------------------------------------------------------------------------------------------------------------
-- match NV to RV using table fields as well as field year -----------------------------------------------------------------
        AND  NV.Field_year
          =  RV.Field_year
        AND  NV.Scenario_ID
          =  RV.Scenario_ID
        AND  NV.Nation_fk
          =  RV.Nation_fk
        AND  NV.Sex_fk
          =  RV.Sex_fk
        AND  NV.Age_fk
          =  RV.Age_fk
----------------------------------------------------------------------------------------------------------------------------
        AND  NV.Sex_fk <> 0
        AND  RV.Sex_fk <> 0
        AND  NV.Age_fk <> 0
        AND  RV.Age_fk <> 0
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------


-- select *
-- from  [forum_ResAnal].[dbo].[vp_AgeSexValue]
