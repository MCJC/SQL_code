/* ++> create_vi04_vi_MedianAge.sql <++ */
--/**************************************************************************************************************************/
--/*****                                                                                                                *****/
--/*****                                              Step by Step: STEP 5                                              *****/
--/*****                                                                                                                *****/
--/**************************************************************************************************************************/
--USE [forum]
--GO
--/**************************************************************************************************************************/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--/**************************************************************************************************************************/
--ALTER  VIEW
--                      [dbo].[vi_MedianAge]
--AS
------------------------------------------------------------------------------------------------------------------------------
--SELECT
--          [MAv_row]      =  ROW_NUMBER()OVER(ORDER BY
--                                          Year
--                                        , level     DESC
--                                        , Nation_fk
--                                        , Religion
--                                        , Sex            )
--         , [YEAR]	
--         , [level]	
--         , [Nation_fk]	
--         , [Country]	
--         , [Religion_fk]	
--         , [Religion]	
--         , [Sex]	
--         , [MedianAge]	--      = CAST ( ROUND([MedianAge], 0) AS DECIMAL ( 2,0) )
--         , [MedAgeCohort]	
------------------------------------------------------------------------------------------------------------------------------
--   FROM [forum_ResAnal].[dbo].[vi_MedianAge]
------------------------------------------------------------------------------------------------------------------------------
--WHERE
--        [RV_Display_MedianAge]  = 1      /* data can be displayed for median age */
-- AND
--        [Sex]     = 'all'                /* data cannot be displayed by gender   */
------------------------------------------------------------------------------------------------------------------------------
--/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [forum]..[vi_MedianAge]   (temporary: for_d)                                           <<<<<     ***/
/***             NOTE:  The view is based on a fixed table hosted at [forum_ResAnal]                                                                                 ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/**** database name specification (once because [forum_ResAnal] is the default place for auxiliary fixed tables) ***********************************************/
----------------------------------------------------------------------------------------------------------------------------
USE              [forum]
GO
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/*****                                                                                                                *****/
/*****                                              Step by Step: STEP 1                                              *****/
/*****                                                                                                                *****/
/**************************************************************************************************************************/

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
  SET     @TofI = 'vi_MedianAge'                                                  --  set variable value
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

/**************************************************************************************************************************/
/*****                                                                                                                *****/
/*****                                              Step by Step: STEP 2                                              *****/
/*****                                                                                                                *****/
/**************************************************************************************************************************/

/*** PREPARE TEMPORARY TABLES *********************************************************************************************/
IF OBJECT_ID('tempdb..#MAIN') IS NOT NULL
DROP TABLE            #MAIN                                 -- drop temporary table if existent
IF OBJECT_ID('tempdb..#TEMP') IS NOT NULL
DROP TABLE            #TEMP                                 -- drop temporary table if existent
IF OBJECT_ID('tempdb..#medians') IS NOT NULL
DROP TABLE            #medians                              -- drop temporary table if existent
IF OBJECT_ID('tempdb..#MyFinalTable') IS NOT NULL
DROP TABLE            #MyFinalTable                         -- drop temporary table if existent
-- create empty temporary table to provisionally store data
CREATE TABLE #medians (
                          Year          int            null
                        , level         int            null
                        , Nation_fk     int            null
                        , Country       varchar(50)    null
                        , Religion      varchar(50)    null
                        , Sex           nvarchar(255)  null
                        , MedianAge     numeric(6,2)   null
                        , MedAgeCohort  nvarchar(255)  null
                        , median_pos    numeric(38,18) null
                        , Pos_inCRge    numeric(38,18) null
                        , NV_Display    int            null
                        , RV_Display    int            null
                                                               )
/**************************************************************************************************************************/
/*  TEMPORARY TABLE << #MAIN >> including ALL cohorts:  *******************************************************************/
-- For a comprehensive table for Median Age, include: world, regions & gountries; males, females and all 
----------------------------------------------------------------------------------------------------------------------------
-- Sets of 20 cohorts:
-- Total number of sets of 20 cohorts would be (but we filter out some by country&religion):
--                    all         by region/country              ( 1 + 6 + 232 ) * 1 =   239
--                    females     by region/country              ( 1 + 6 + 232 ) * 1 =   239
--                    males       by region/country              ( 1 + 6 + 232 ) * 1 =   239
--                    all         by region/country & religion   ( 1 + 6 + 232 ) * 8 = 1,912
--                    females     by region/country & religion   ( 1 + 6 + 232 ) * 8 = 1,912
--                    males       By region/country & religion   ( 1 + 6 + 232 ) * 8 = 1,912
--                                                                                    _______
--
--                                                                            TOTAL:   6,453
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
SELECT
----------------------------------------------------------------------------------------------------------------------------
               [ProvOrd]    = ROW_NUMBER()OVER(ORDER BY
                                           Year
                                         , level
                                         , Nation_fk
                                         , Religion
                                         , Sex
                                         , Age          )
          ,    [Year]
          ,    [level]
          ,    [Nation_fk]
          ,    [Country]    = CASE
                                   WHEN Nation_fk > 1000
                                   THEN LTRIM(Region)
                                   ELSE       Country
                              END
          ,    [Religion_fk]
          ,    [Religion]
          ,    [N]          =  [Population]
          ,    [Sex]
          ,    [Age]
          ,    [LowBound]   =  CASE 
                                    WHEN ISNUMERIC( left(Age, 2)) = 1
                                    THEN CAST(      left(Age, 2)    AS INT)
                                    WHEN ISNUMERIC( left(Age, 1)) = 1
                                    THEN CAST(      left(Age, 1)    AS INT)
                               END
          ,    [HghBound]   =  CASE 
                                    WHEN                 Age      = '95+'
                                    THEN 100
                                    WHEN ISNUMERIC( left(Age, 2)) = 1
                                     AND ISNUMERIC(right(Age, 2)) = 1
                                    THEN CAST(     right(Age, 2)    AS INT) 
                                    WHEN ISNUMERIC(right(Age, 1)) = 1
                                    THEN CAST(     right(Age, 1)    AS INT)
                               END
          ,    [NV_Display]  = [NV_Display_MedianAge]
          ,    [RV_Display]  = [RV_Display_MedianAge]
----------------------------------------------------------------------------------------------------------------------------
INTO    #MAIN
----------------------------------------------------------------------------------------------------------------------------
FROM [forum_ResAnal].[dbo].[vi_AgeSexValue]
/************************   Filters:   ************************************************************************************/
WHERE
       [Age_fk]        <> 0            /* exclude [Age] = 'all' (not used for age structure)   */
AND
       [Religion_fk]      IS NOT NULL  /* exclude subreligions: ne differential age structure  */
/**************************************************************************************************************************/
--     Observations for:
--                           11  Years
--                            3  levels
--                          241  nations/territories
--                            9  religions
--                            3  sex groups
/********************************************************************************** TEMPORARY TABLE << #MAIN >> CREATED ***/
/**************************************************************************************************************************/
GO

/**************************************************************************************************************************/
/*****                                                                                                                *****/
/*****                                              Step by Step: STEP 3                                              *****/
/*****                                                                                                                *****/
/**************************************************************************************************************************/

/***********************************************************************************************************************/
/**************************************                                           **************************************/
/**************************************    PROCEDURES TO CALCULATE  MEDIAN AGE    **************************************/
/**************************************                                           **************************************/
/***********************************************************************************************************************/
/***  CURSOR  **********************************************************************************************************/
-- Declare the variables needed for cursor to store data
  DECLARE                          --  declare variable
          @Y_k                     --  variable name
                          INT      --  data type of the variable
        , @lev                     --  variable name
                          INT      --  data type of the variable
        , @N_k                     --  variable name
                          INT      --  data type of the variable
        , @R_k                     --  variable name
                          VARCHAR(MAX)      --  data type of the variable
        , @S_k                     --  variable name
                          VARCHAR(MAX)      --  data type of the variable
-- Declare the Cursor MyCursor
   DECLARE                                -- declare the cursor
              MyCursor                    -- cursor name
                             CURSOR FOR   -- as a cursor to take values from
-- SELECT the data that will be represented by cursor
--    (i.e. "select query" to produce the table)
--    each row of the resuklting table will be stored in the cursor
--    then, from the cursor, the data will be stored in the corresponding variable(s)
SELECT
         DISTINCT
         Year
       , level
       , Nation_fk
       , Religion
       , Sex
  FROM   #MAIN
  ORDER BY 
             Year
           , level
           , Nation_fk
           , Religion
           , Sex
/*************************************************************************************************************/
-- OPEN the cursor 
   OPEN                                   -- open
              MyCursor                    -- cursor name
	-- RETRIEVE the FIRST row from cursor & STORE it into the variable(s): 
						   FETCH NEXT                                 -- retrieve the first row
								 FROM                                 -- from cursor
										MyCursor                      -- cursor name
								 INTO                                 -- store it into the variable(s)
                                       @Y_k                          --  variable name for year
									 , @lev                          --  variable name for level
									 , @N_k                          --  variable name for country
									 , @R_k                          --  variable name for religion
									 , @S_k                          --  variable name for sex
	-- @@FETCH_STATUS returns the status of the last cursor FETCH statement issued against  
	-- any cursor currently opened by the connection. 
	--     @@FETCH_STATUS =  0 means The FETCH statement was successful. 
	--     @@FETCH_STATUS = -1 means The FETCH statement failed or the row was beyond the result set. 
	--     @@FETCH_STATUS = -2 means The row fetched is missing. 
			 WHILE  @@FETCH_STATUS = 0
  /***********************************************************************************************************/
	  -- BEGIN the procedures to be done using the values of each row of the cursor
					BEGIN
	  -- Procedures to be done
/*********************************   B E G I N N I N G   O F   D A T A   I N S E R T I O N   *********************************/
SELECT  *
INTO #TEMP
FROM #MAIN
WHERE
          Year      = @Y_k            /* CHOICE of year of the data      */
      AND level     = @lev            /* CHOICE of level of aggregation  */
      AND Nation_fk = @N_k            /* CHOICE of Country/Region        */
      AND Religion  = @R_k            /* CHOICE of Religion              */
      AND Sex       = @S_k            /* CHOICE of Sex                   */
------------------------------------------------------------------------------------------------
----------SELECT  *
----------INTO #TEMP
----------FROM #MAIN
----------WHERE
----------          Year      = 2010            /* CHOICE of year of the data      */
----------      AND level     =    3            /* CHOICE of level of aggregation  */
----------      AND Nation_fk = 10000           /* CHOICE of Country/Region        */
----------      AND Religion  = 'All Religions' /* CHOICE of Religion              */
----------      AND Sex       = 'All'           /* CHOICE of Sex                   */
------------------------------------------------------------------------------------------------
/*** STORE MEDIAN AGE *************************************************************************/
INSERT INTO #medians
/*** CALCULATE MEDIAN AGE ***********************************************************************************************/
/*----------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------*/
/*- T6 -----------------------------------------------------------------------------------------------------------------*/
SELECT
        Year
      , level
      , Nation_fk
      , Country
      , Religion
      , Sex
      , MedianAge     = ROUND (( LowBound + ( 5 * PosInRange ) ), 0)     /* <<---- this is the BEST PLACE for ROUNDING  */
      , MedAgeCohort  = Age
      , median_pos    = median
      , Pos_inCRge    = PosInRange
      , NV_Display
      , RV_Display
  FROM
(
/*----------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------*/
/*- T5 -----------------------------------------------------------------------------------------------------------------*/
SELECT
        Year
      , level
      , Country
      , Nation_fk
      , Religion
      , Sex
      , Age
      , LowBound
      , HghBound
      , LowBndCount
      , HghBndCount
      , median
      , MedCohort
      , PosInRange = (median-LowBndCount)/(HghBndCount-LowBndCount)
      , NV_Display
      , RV_Display
  FROM
(
/*----------------------------------------------------------------------------------------------------------------------*/
/*- T4 -----------------------------------------------------------------------------------------------------------------*/
SELECT
        Year
      , level
      , Country
      , Nation_fk
      , Religion
      , Sex
      , Age
      , LowBound
      , HghBound
      , LowBndCount
      , HghBndCount
      , median
      ,  case 
              WHEN median >= LowBndCount
               AND median <  HghBndCount
              THEN 1
              ELSE 0                                           
              END                                               AS   MedCohort
      , NV_Display
      , RV_Display
  FROM
(
/*- T1 & T2 ------------------------------------------------------------------------------------------------------------*/
SELECT
        Year
      , level
      , Country
      , Nation_fk
      , Religion
      , Sex
      , Age
      , LowBound
      , HghBound
      , (select sum(N) from #TEMP 
                          where LowBound <= T1.LowBound) - N    AS   LowBndCount       -- LowBound, HghBound or age_pk
      , (select sum(N) from #TEMP 
                          where HghBound <= T1.HghBound)        AS   HghBndCount       -- LowBound, HghBound or age_pk
      , ((total) / 2)                                           AS   median            -- change: continuos, not +1
      , N
      , NV_Display
      , RV_Display
  FROM   #TEMP                                                  AS   T1   
CROSS JOIN
(
SELECT  SUM(N)                                                  AS   total
  FROM   #TEMP
)                                                               AS   T2
-- ORDER BY LowBound
/*- T1 & T2 = T3 -------------------------------------------------------------------------------------------------------*/
)                                                               AS   T3
/*- T4 -----------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------*/
)                                                               AS   T4
/*- T5 -----------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------*/
)                                                               AS   T5
WHERE   MedCohort                     =   1
/*- T6 -----------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------------------*/
/********************************************************************************************** MEDIAN AGE CALCULATED ***/
DROP TABLE            #TEMP                                             -- drop temporary table
/**********************************************************************************************/

	  -- RETRIEVE the NEXT row from cursor & STORE it into the variable(s): 
						   FETCH NEXT                                 -- retrieve the next row
								 FROM                                 -- from cursor
										MyCursor                      -- cursor name
								 INTO                                 -- store it into the variable(s)
                                       @Y_k                          --  variable name for year
									 , @lev                          --  variable name for level
									 , @N_k                          --  variable name for country
									 , @R_k                          --  variable name for religion
									 , @S_k                          --  variable name for sex
	  -- END the procedures to be done using the values of each row of the cursor
					END
  /***********************************************************************************************************/

-- CLOSE the cursor 
   CLOSE                                  -- close
              MyCursor                    -- cursor name
/*************************************************************************************************************/
-- REMOVE the cursor reference and relase cursor from memory
-- (very Important )
DEALLOCATE                                -- remove reference and relase from memory
              MyCursor                    -- cursor name

/*************************************************************************************************************/
GO
/************************************************************************************************  CURSOR ends here  ***/

--select * from #medians
--order by 
--                     Year
--                   , level
--                   , Nation_fk
--                   , Country
--                   , Religion
--                   , Sex

/**************************************************************************************************************************/
/*****                                                                                                                *****/
/*****                                              Step by Step: STEP 4                                              *****/
/*****                                                                                                                *****/
/**************************************************************************************************************************/

/***********************************************************************************************************************/
SELECT
   --    DISTINCT
         MMM.Year
       , MMM.level
       , MMM.Nation_fk
       , MMM.Country
       , MMM.Religion_fk
       , MMM.Religion
       , MMM.Sex
       , FIN.MedianAge
       ,     MedAgeCohort
                      = CASE 
                             WHEN FIN.MedianAge IS NULL THEN 'Data Not Available'
                             ELSE FIN.MedAgeCohort
                        END
      , FIN.NV_Display
      , FIN.RV_Display
-- Temporary table to save results for Intridea
  INTO   #MyFinalTable
  FROM   
           (
            SELECT
                   DISTINCT
                     Year
                   , level
                   , Religion_fk
                   , Nation_fk
                   , Country
                   , Religion
                   , Sex
              FROM   #MAIN     ) AS MMM
LEFT JOIN
                     #medians    AS FIN
ON 
               MMM.Year       = FIN.Year
       AND     MMM.level      = FIN.level 
       AND     MMM.Nation_fk  = FIN.Nation_fk
       AND     MMM.Country    = FIN.Country
       AND     MMM.Religion   = FIN.Religion
       AND     MMM.Sex        = FIN.Sex

ORDER BY  
         MMM.Year
       , MMM.level
       , MMM.Nation_fk
       , MMM.Country
       , MMM.Religion
       , MMM.Sex
/***********************************************************************************************************************/
/***********************************************************************************************************************/
-- Final fixed table to save results in [forum_ResAnal]
--SELECT * FROM #MyFinalTable
/***********************************************************************************************************************/
SELECT 
-------------------------------------------------------------------------------------------------------------------------
        [MdAge_row]       =  ROW_NUMBER()OVER(ORDER BY
                                             [YEAR]	
                                           , [level]       DESC
                                           , [Nation_fk]
                                           , [Religion_fk]	
                                           , [Sex]	
                                                                )
-------------------------------------------------------------------------------------------------------------------------
      , [YEAR]	
      , [level]	
      , [Nation_fk]	
      , [Country]	
      , [Religion_fk]	
      , [Religion]	
      , [Sex]	
      , [MedianAge]	
      , [MedAgeCohort]	
      , [NV_Display]     AS [NV_Display_MedianAge]
      , [RV_Display]     AS [RV_Display_MedianAge]
INTO [forum_ResAnal].[dbo].[vi_MedianAge]
FROM #MyFinalTable
/***********************************************************************************************************************/
--select * from #main
--select * from #medians
--SELECT * FROM #MyFinalTable
--SELECT distinct sex, rv_display FROM #MyFinalTable order by religion
GO