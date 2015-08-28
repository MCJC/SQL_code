/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [for_x].[dbo].[Vx_i_RRIndexMedians]                                                            <<<<<     ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [for_x]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
ALTER  VIEW
               [dbo].[Vx_i_RRIndexMedians]
AS
/***************************************************************************************************************************************************************/

/****************************************************************************/
/***  Query for calculating the median value:                             ***/
/****************************************************************************/
/***  The median is the numerical value separating the higher half from   ***/
/***  the lower half of the data (it can differ from the mean).           ***/
/***  We find it by arranging all the observations from lowest value to   ***/
/***  highest value and picking the middle one. If there is an even       ***/
/***  number of observations, median is defined to be the mean of the two ***/
/***  middle values.                                                      ***/
/****************************************************************************/

/*** >> query to select the median index by year and region: ***************************************************************************************************/
SELECT
        RowN                 = ROW_NUMBER() 
                               OVER 
                               (ORDER BY   
                                           [Question_Year]
                                         , [Index_abbreviation]
                                         , [Region]
                                                                 )
      , [Question_Year]
      , [Index_Year]
      , [Region]
      , [Index_abbreviation]
      , [Median]    = round((AVG([Index_value])),1) /* avg 2 middle values if needed */
FROM
/****************************************************************************/
(
/*** > include StOrd & MedPos ***********************************************/
/*     Notice that:                                                         */
/*      [StOrd]  will have the numeric sorting order of rows by values      */
/*      [MedPos] will have the position in the sorted list:                 */
/*               in three cases:  | 1  |  2  | 3 |                          */
/*               the median is the secong value:  (3+1)/2 = 2               */
/****************************************************************************/
SELECT 
       [StOrd]                = ROW_NUMBER()
                                OVER 
                                (PARTITION BY  
                                               [Index_abbreviation]
                                              ,[Index_Year]
                                              ,[Region]
                                 ORDER BY
                                               [Index_abbreviation]
                                              ,[Index_Year]
                                              ,[Region]
                                              ,[Index_value]
                                                                                )                     /**/
      ,[MedPos]               = (((CAST
                                 ((COUNT(*)
                                   OVER 
                                   (PARTITION BY  [Index_abbreviation]
                                                 ,[Index_Year]
                                                 ,[Region]
                                                                       )) AS DECIMAL (6,2)))+1) / 2)  /**/
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Region]
      ,[Question_Year]
      ,[Index_Year]
      ,[Index_name]
      ,[Index_abbreviation]
      ,[Index_value]
--      ,[I_Rounded_value]
  FROM
       [forum].[dbo].[Pew_Indexes]
WHERE  
       [Index_abbreviation] IN ('GRI' , 'SHI')
/*** < include StOrd & MedPos ***********************************************/
)                                                                 B
/****************************************************************************/
/*  Notice that:                                                            */
/*  In an odd number of observations, the position is an integer,           */
/*  then we can say: [StOrd] = [MedPos]                                     */
/*  In an even number of observations, the position is between the two      */
/*  middle values, then we need: [StOrd] = ([MedPos] +/- 0.5)               */
/****************************************************************************/
WHERE
      StOrd >= (MedPos - 0.5)
  AND
      StOrd <= (MedPos + 0.5)
/****************************************************************************/
/*  We can have one or two middle values, we group by the other variables   */
/****************************************************************************/
GROUP BY
         [Region]
        ,[Question_Year]
        ,[Index_Year]
        ,[Index_abbreviation]
/*** << query to select the median index by year and region: ***************************************************************************************************/
