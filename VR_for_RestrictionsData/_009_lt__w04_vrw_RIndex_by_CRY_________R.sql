/******************************************************************************************************************************/
/***                                                                                                                        ***/
/***    >>>>> This is the script for the lookup table [forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]    <<<<<    ***/
/***                                                                                                                        ***/
/***     NOTES:                                                                                                             ***/
/***     For calculating the median value for the world or for a region:                                                    ***/
/***           The median is the numerical value separating the higher half from the lower half of the data                 ***/
/***           (it can differ from the mean). We find it by arranging all the observations from lowest value                ***/
/***           to highest value and picking the middle one. If there is an even number of observations,                     ***/
/***           median is defined  to be the mean of the two middle values.                                                  ***/
/***                                                                                                                        ***/
/***                                     > > >     lookup tables  work faster     < < <                                     ***/
/***                                                                                                                        ***/
/******************************************************************************************************************************/
USE [forum_ResAnal]
GO
/******************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]
GO
/******************************************************************************************************************************/
WITH PREv4
  AS
      (
/******************************************************************************************************************************/
        SELECT
/*----------------------------------------------------------------------------------------------------------------------------*/
                [Nation_fk]
              , [Region5_code]   
                 =   CASE
                          WHEN [Region5] = 'Americas'                  THEN 1000
                          WHEN [Region5] = 'Europe'                    THEN 1003
                          WHEN [Region5] = 'Middle East-North Africa'  THEN 1004
                          WHEN [Region5] = 'Sub-Saharan Africa'        THEN 1005
                          WHEN [Region5] = 'Asia-Pacific'              THEN 1006
                          END
              , [Region6_code]
                 =   CASE
                          WHEN [Region6] = 'North America'             THEN 1001
                          WHEN [Region6] = 'Latin America-Caribbean'   THEN 1002
                          WHEN [Region6] = 'Europe'                    THEN 1003
                          WHEN [Region6] = 'Middle East-North Africa'  THEN 1004
                          WHEN [Region6] = 'Sub-Saharan Africa'        THEN 1005
                          WHEN [Region6] = 'Asia-Pacific'              THEN 1006
                          END
              , [Region5]
              , [Region6]
              , [Ctry_EditorialName]
              , [Index_Year]
                 =   CASE
                          WHEN [Question_Year] <  2011 THEN 'MID-' + STR([Question_Year], 4,0)
                          ELSE                              'END-' + STR([Question_Year], 4,0)
                          END
              , [Index_Abbreviation]
              , [Index_Name]
                 =   CASE
                          WHEN [Index_Abbreviation] = 'GRI' THEN 'Government Restrictions Index'
                          WHEN [Index_Abbreviation] = 'SHI' THEN 'Social Hostilities Index'
                          WHEN [Index_Abbreviation] = 'GFI' THEN 'Government Favoritism Index'
                          END
              , [Index_Value]
              , [I_Rounded_Value]
              , [I_Scaled_Value]
              , [Year]                   = [Question_Year]
        FROM
/******************************************************************************************************************************/
        (
/******************************************************************************************************************************/
        SELECT 
                  [Nation_fk]
              ,   [Ctry_EditorialName]
              ,   [Region5]
              ,   [Region6]
              ,   [Question_Year]
              ,   [GRI] -- as float works for rounding: don't re-cast
              ,   [SHI] -- as float works for rounding: don't re-cast
              ,   [GFI] -- as float works for rounding: don't re-cast
          FROM    [vr_03w_W&Extras_by_Ctry&Year]
/******************************************************************************************************************************/
        )                                                         B
/******************************************************************************************************************************/
        UNPIVOT
          (
             [Index_Value]
        FOR
             [Index_Abbreviation]
        in (
                       [GRI]  /*** GRI Yindex (d prec/scale)    ***/
                     , [SHI]  /*** SHI Yindex (d prec/scale)    ***/
                     , [GFI]  /*** GFI Yindex (d prec/scale)    ***/
                                                       ) ) as UNPIVTD1
/******************************************************************************************************************************/
        JOIN
/******************************************************************************************************************************/
        (
/******************************************************************************************************************************/
        SELECT 
                  [N2]        = [Nation_fk]
              ,   [Y2]        = [Question_Year]
              ,   [GRI]       = [GRI_rd_1d]    -- already rounded: don't re-cast
              ,   [SHI]       = [SHI_rd_1d]    -- already rounded: don't re-cast
              ,   [GFI]       = [GFI_rd_1d]    -- already rounded: don't re-cast
          FROM    [vr_03w_W&Extras_by_Ctry&Year]
/******************************************************************************************************************************/
        )                                                         B
/******************************************************************************************************************************/
        UNPIVOT
          (
             [I_Rounded_Value]
        FOR
             [I2]
        in (
                       [GRI]  /*** GRI Yindex rounded ***/
                     , [SHI]  /*** SHI Yindex rounded ***/
                     , [GFI]  /*** GFI Yindex rounded ***/
                                                       ) ) as UNPIVTD2
/******************************************************************************************************************************/
        ON        [N2]        = [Nation_fk]
        AND       [Y2]        = [Question_Year]
        AND       [I2]        = [Index_Abbreviation]
/******************************************************************************************************************************/
        JOIN
/******************************************************************************************************************************/
        (
/******************************************************************************************************************************/
        SELECT 
                  [N3]        = [Nation_fk]
              ,   [Y3]        = [Question_Year]
              ,   [GRI]       = [GRI_scaled]    -- already scaled: don't re-cast
              ,   [SHI]       = [SHI_scaled]    -- already scaled: don't re-cast
              ,   [GFI]       = [GFI_scaled]    -- already scaled: don't re-cast
          FROM    [vr_03w_W&Extras_by_Ctry&Year]
/******************************************************************************************************************************/
        )                                                         B
/******************************************************************************************************************************/
        UNPIVOT
          (
             [I_Scaled_Value]
        FOR
             [I3]
        in (
                       [GRI]  /*** GRI Yindex scaled ***/
                     , [SHI]  /*** SHI Yindex scaled ***/
                     , [GFI]  /*** GFI Yindex scaled ***/
                                                       ) ) as UNPIVTD3
/******************************************************************************************************************************/
        ON        [N3]        = [Nation_fk]
        AND       [Y3]        = [Question_Year]
        AND       [I3]        = [Index_Abbreviation]
/******************************************************************************************************************************/
      )
/******************************************************************************************************************************/
/******************************************************************************************************************************/

/******************************************************************************************************************************/
SELECT * INTO    [forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]
FROM
--------------------------------------------------------------------------------------------------------------------------------
(
/******************************************************************************************************************************/
SELECT
--------------------------------------------------------------------------------------------------------------------------------
         [RIYv_row]           =  ROW_NUMBER()
                                 OVER(ORDER BY
                                                 [level]              DESC
                                               , [Nation_fk]
                                               , [Index_abbreviation]
                                               , [Year]                     )
--------------------------------------------------------------------------------------------------------------------------------
       , [Index_Year]
       , [level]
       , [Region5_code]
       , [Region6_code]
       , [Nation_fk]
       , [Region5]
       , [Region6]
       , [Ctry_EditorialName]
       , [Index_abbreviation]
       , [Index_name]
       , [Index_value]
       , [I_Rounded_value]
       , [I_Scaled_value]     = CASE
                                    WHEN     [I_Scaled_value] IS NOT NULL         THEN [I_Scaled_value]
                                    WHEN     [Index_value] >= [low|lowest]
                                         AND [Index_value] <= [low|highest]       THEN 1
                                    WHEN     [Index_value] >= [moderate|lowest]
                                         AND [Index_value] <= [moderate|highest]  THEN 2
                                    WHEN     [Index_value] >= [high|lowest]
                                         AND [Index_value] <= [high|highest]      THEN 3
                                    WHEN     [Index_value] >= [very high|lowest]
                                         AND [Index_value] <= [very high|highest] THEN 4
                                END
       , [Year]
       , [ByRegion6]          = CASE
                                    WHEN [level] IN ( 1, 2   ) THEN 1
                                    ELSE                            0
                                END
       , [ByRegion5]          = CASE
                                    WHEN [level] IN ( 1, 2.5 ) THEN 1
                                    ELSE                            0
                                END
       , [ByWorld]           = CASE
                                    WHEN [level] IN ( 1, 3   ) THEN 1
                                    ELSE                            0
                                END
       , [ByWorld&Region]    = CASE
                                    WHEN [level] IN ( 2, 3   ) THEN 1
                                    ELSE                            0
                                END
FROM
/*** >>> country, region, and world joined to set of cutpoints ****************************************************************/
/******************************************************************************************************************************/
/*** country, region, and world  **********************************************************************************************/
(
/*** country level ************************************************************************************************************/
SELECT
--------------------------------------------------------------------------------------------------------------------------------
         [Index_Year]
       , [level]                 =  1
       , [Region5_code]
       , [Region6_code]
       , [Nation_fk]
       , [Region5]
       , [Region6]
       , [Ctry_EditorialName]
       , [Index_abbreviation]
       , [Index_name]
       , [Index_value]
       , [I_Rounded_value]
       , [I_Scaled_value]
       , [Year]
--------------------------------------------------------------------------------------------------------------------------------
  FROM
--------------------------------------------------------------------------------------------------------------------------------
       PREv4                                                                                   /*** common table expression ***/
/************************************************************************************************************ country level ***/
UNION ALL
/*** median index by year and region 6 ****************************************************************************************/
SELECT
--------------------------------------------------------------------------------------------------------------------------------
         [Index_Year]
       , [level]                 =  2
       , [Region5_code]          =  CASE
                                        WHEN [Region6_code] = 1001                   THEN 1000
                                        WHEN [Region6_code] = 1002                   THEN 1000
                                        ELSE [Region6_code]
                                    END
       , [Region6_code]
       , [Nation_fk]             =           [Region6_code]
       , [Region5]               =  CASE
                                        WHEN [Region6] = 'North America'             THEN 'Americas'
                                        WHEN [Region6] = 'Latin America-Caribbean'   THEN 'Americas'
                                        ELSE [Region6]
                                    END
       , [Region6]
       , [Ctry_EditorialName]    =  'All countires in ' + [Region6]
       , [Index_abbreviation]
       , [Index_name]
       , [Index_value]           =       (AVG([Index_value]))    /* avg 2 middle values if needed */
       , [I_Rounded_value]       = round((AVG([Index_value])),1) /* avg 2 middle values if needed */
       , [I_Scaled_value]        = NULL
       , [Year]
--------------------------------------------------------------------------------------------------------------------------------
FROM
--------------------------------------------------------------------------------------------------------------------------------
/******************************************************************************************************************************/
(
/*** > include StOrd & MedPos *************************************************************************************************/
/*     Notice that:                                                                                                           */
/*                  [StOrd]  will have the numeric sorting order of rows by values                                            */
/*                  [MedPos] will have the position in the sorted list:                                                       */
/*                           in three cases:  | 1  |  2  | 3 |                                                                */
/*                           the median is the second value:  (3+1)/2 = 2                                                     */
/******************************************************************************************************************************/
SELECT 
--------------------------------------------------------------------------------------------------------------------------------
       [StOrd]                = ROW_NUMBER()
                                OVER 
                                (PARTITION BY  
                                               [Index_abbreviation]
                                              ,[Index_Year]
                                              ,[Region6]
                                 ORDER BY
                                               [Index_abbreviation]
                                              ,[Index_Year]
                                              ,[Region6]
                                              ,[Index_value]
                                                                                )                     /**/
      ,[MedPos]               = (((CAST
                                 ((COUNT(*)
                                   OVER 
                                   (PARTITION BY  [Index_abbreviation]
                                                 ,[Index_Year]
                                                 ,[Region6]
                                                                       )) AS DECIMAL (6,2)))+1) / 2)  /**/
      ,[Region6_code]
      ,[Nation_fk]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Year]
      ,[Index_Year]
      ,[Index_name]
      ,[Index_abbreviation]
      ,[Index_value]
  FROM
--------------------------------------------------------------------------------------------------------------------------------
       PREv4                                                                                   /*** common table expression ***/
--------------------------------------------------------------------------------------------------------------------------------
/************************************************************************************************* < include StOrd & MedPos ***/
)                                                                                                                             B
/******************************************************************************************************************************/
/*     Notice that: In an odd number of observations, the position is an integer, then we can say:                            */
/*                  [StOrd] = [MedPos]                                                                                        */
/*                  In an even number of observations, the position is between the two middle values, then we need:           */
/*                  [StOrd] = ([MedPos] +/- 0.5)                                                                              */
/******************************************************************************************************************************/
WHERE
      StOrd >= (MedPos - 0.5)
  AND
      StOrd <= (MedPos + 0.5)
/******************************************************************************************************************************/
/*  We can have one or two middle values, we group by the other variables                                                     */
/******************************************************************************************************************************/
GROUP BY
         [Region6_code]
       , [Region6]
       , [Year]
       , [Index_Year]
       , [Index_name]
       , [Index_abbreviation]
/****************************************************************************************** median index by year and region ***/
UNION ALL
/*** median index by year and region 5 ****************************************************************************************/
SELECT
--------------------------------------------------------------------------------------------------------------------------------
         [Index_Year]
       , [level]                 =  2.5
       , [Region5_code]
       , [Region6_code]          =  CASE
                                        WHEN [Region5_code] = 1000                   THEN NULL
                                        ELSE [Region5_code]
                                    END
       , [Nation_fk]             =           [Region5_code]
       , [Region5]
       , [Region6]               =  CASE
                                        WHEN [Region5] = 'Americas'                  THEN 'N.A. & L.A.-C.'
                                        ELSE [Region5]
                                    END
       , [Ctry_EditorialName]    =  'All countires in ' + [Region5]
       , [Index_abbreviation]
       , [Index_name]
       , [Index_value]           =       (AVG([Index_value]))    /* avg 2 middle values if needed */
       , [I_Rounded_value]       = round((AVG([Index_value])),1) /* avg 2 middle values if needed */
       , [I_Scaled_value]        = NULL
       , [Year]
--------------------------------------------------------------------------------------------------------------------------------
FROM
--------------------------------------------------------------------------------------------------------------------------------
/******************************************************************************************************************************/
(
/*** > include StOrd & MedPos *************************************************************************************************/
/*     Notice that:                                                                                                           */
/*                  [StOrd]  will have the numeric sorting order of rows by values                                            */
/*                  [MedPos] will have the position in the sorted list:                                                       */
/*                           in three cases:  | 1  |  2  | 3 |                                                                */
/*                           the median is the second value:  (3+1)/2 = 2                                                     */
/******************************************************************************************************************************/
SELECT 
--------------------------------------------------------------------------------------------------------------------------------
       [StOrd]                = ROW_NUMBER()
                                OVER 
                                (PARTITION BY  
                                               [Index_abbreviation]
                                              ,[Index_Year]
                                              ,[Region5]
                                 ORDER BY
                                               [Index_abbreviation]
                                              ,[Index_Year]
                                              ,[Region5]
                                              ,[Index_value]
                                                                                )                     /**/
      ,[MedPos]               = (((CAST
                                 ((COUNT(*)
                                   OVER 
                                   (PARTITION BY  [Index_abbreviation]
                                                 ,[Index_Year]
                                                 ,[Region5]
                                                                       )) AS DECIMAL (6,2)))+1) / 2)  /**/
      ,[Region5_code]
      ,[Nation_fk]
      ,[Region5]
      ,[Ctry_EditorialName]
      ,[Year]
      ,[Index_Year]
      ,[Index_name]
      ,[Index_abbreviation]
      ,[Index_value]
  FROM
--------------------------------------------------------------------------------------------------------------------------------
       PREv4                                                                                   /*** common table expression ***/
--------------------------------------------------------------------------------------------------------------------------------
/************************************************************************************************* < include StOrd & MedPos ***/
)                                                                                                                             B
/******************************************************************************************************************************/
/*     Notice that: In an odd number of observations, the position is an integer, then we can say:                            */
/*                  [StOrd] = [MedPos]                                                                                        */
/*                  In an even number of observations, the position is between the two middle values, then we need:           */
/*                  [StOrd] = ([MedPos] +/- 0.5)                                                                              */
/******************************************************************************************************************************/
WHERE
      StOrd >= (MedPos - 0.5)
  AND
      StOrd <= (MedPos + 0.5)
/******************************************************************************************************************************/
/*  We can have one or two middle values, we group by the other variables                                                     */
/******************************************************************************************************************************/
GROUP BY
         [Region5_code]
       , [Region5]
       , [Year]
       , [Index_Year]
       , [Index_name]
       , [Index_abbreviation]
/****************************************************************************************** median index by year and region ***/
UNION ALL
/*** world median index by year ***********************************************************************************************/
SELECT
--------------------------------------------------------------------------------------------------------------------------------
         [Index_Year]
       , [level]                 =  3
       , [Region5_code]          =  10000
       , [Region6_code]          =  10000
       , [Nation_fk]             =  10000
       , [Region5]               =  'World'
       , [Region6]               =  'World'
       , [Ctry_EditorialName]    =  'All countires in the world'
       , [Index_abbreviation]
       , [Index_name]
       , [Index_value]           =       (AVG([Index_value]))    /* avg 2 middle values if needed */
       , [I_Rounded_value]       = round((AVG([Index_value])),1) /* avg 2 middle values if needed */
       , [I_Scaled_value]        = NULL
       , [Year]
--------------------------------------------------------------------------------------------------------------------------------
FROM
--------------------------------------------------------------------------------------------------------------------------------
/******************************************************************************************************************************/
(
/*** > include StOrd & MedPos *************************************************************************************************/
/*     Notice that:                                                                                                           */
/*                  [StOrd]  will have the numeric sorting order of rows by values                                            */
/*                  [MedPos] will have the position in the sorted list:                                                       */
/*                           in three cases:  | 1  |  2  | 3 |                                                                */
/*                           the median is the second value:  (3+1)/2 = 2                                                     */
/******************************************************************************************************************************/
SELECT 
--------------------------------------------------------------------------------------------------------------------------------
       [StOrd]                = ROW_NUMBER()
                                OVER 
                                (PARTITION BY  
                                               [Index_abbreviation]
                                              ,[Index_Year]
                                 ORDER BY
                                               [Index_abbreviation]
                                              ,[Index_Year]
                                              ,[Index_value]
                                                                                )                     /**/
      ,[MedPos]               = (((CAST
                                 ((COUNT(*)
                                   OVER 
                                   (PARTITION BY  [Index_abbreviation]
                                                 ,[Index_Year]
                                                                       )) AS DECIMAL (6,2)))+1) / 2)  /**/
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Year]
      ,[Index_Year]
      ,[Index_name]
      ,[Index_abbreviation]
      ,[Index_value]
  FROM
--------------------------------------------------------------------------------------------------------------------------------
       PREv4                                                                                   /*** common table expression ***/
--------------------------------------------------------------------------------------------------------------------------------
/************************************************************************************************* < include StOrd & MedPos ***/
)                                                                                                                             B
/******************************************************************************************************************************/
/*     Notice that: In an odd number of observations, the position is an integer, then we can say:                            */
/*                  [StOrd] = [MedPos]                                                                                        */
/*                  In an even number of observations, the position is between the two middle values, then we need:           */
/*                  [StOrd] = ([MedPos] +/- 0.5)                                                                              */
/******************************************************************************************************************************/
WHERE
      StOrd >= (MedPos - 0.5)
  AND
      StOrd <= (MedPos + 0.5)
/******************************************************************************************************************************/
/*  We can have one or two middle values, we group by the other variables                                                     */
/******************************************************************************************************************************/
GROUP BY
         [Year]
       , [Index_Year]
       , [Index_name]
       , [Index_abbreviation]
/******************************************************************************************************************************/
)                                                                                                                           CRW
/*********************************************************************************************** country, region, and world ***/
JOIN
(
/*** > set of cutpoints to calculate scaled values ****************************************************************************/
  SELECT *
    FROM
         (
           SELECT 
                   DISTINCT                                            /* so, no need to select year   */
                   [LP]         = [Level] + '|' + [Point]
                  ,[CutPoint]
                  ,[Field_type]
              FROM [forum].[dbo].[Pew_Index_Cut_Points]
                 , [forum].[dbo].[Pew_Field]
             WHERE
                   [Field_fk]
                  =[Field_pk]
                                                                ) AS P /* alias of table to be pivoted */
    PIVOT (AVG ([CutPoint]) 
           FOR  [LP]
            IN (
                      [low|lowest]
                    , [low|highest]
                    , [moderate|lowest]
                    , [moderate|highest]
                    , [high|lowest]
                    , [high|highest]
                    , [very high|lowest]
                    , [very high|highest]
                                            ))  as pivoted
/**************************************************************************** < set of cutpoints to calculate scaled values ***/
)                                                                                                                            CP
/******************************************************************************************************************************/
ON
         [Index_abbreviation]
       = [Field_type]
/******************************************************************************************************************************/
/**************************************************************** <<< country, region, and world joined to set of cutpoints ***/
/******************************************************************************************************************************/
)  formerview
--------------------------------------------------------------------------------------------------------------------------------