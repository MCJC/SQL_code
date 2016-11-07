/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [for_x].[dbo].[V4_LRestr_by_CYV]                                                       <<<<<     ***/
/***             This view only includes numeric values aggregated by country/religion & year & variable (long format).                                      ***/
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
N'
/***************************************************************************************************************************************************************/
ALTER  VIEW
               [dbo].[V4_L_by_CYV]
AS
/***************************************************************************************************************************************************************/
'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  Begining of select statement (values by country/year/question)  ******************************************************************************************/
N'
/***************************************************************************************************************************************************************/
SELECT
        [Nation_fk]
      , [Ctry_EditorialName]
      , [Region5Yr]
         =        [Region5] + ''_'' + STR([Question_Year], 4,0)
      , [Region6Yr]
         =        [Region6] + ''_'' + STR([Question_Year], 4,0)
      , [Region5]
      , [Region6]
      , [YEAR]
         =        CASE
                  WHEN [Question_Year] <  2011 THEN ''MID-'' + STR([Question_Year], 4,0)
                  ELSE                              ''END-'' + STR([Question_Year], 4,0)
                  END
      , [Question_Year]
      , [GRI]
      , [SHI]
      , [GFI]
      , [Variable]
         =        
                  CASE
                  WHEN                 [Variable] LIKE ''%_ny%'' 
                  THEN STUFF(          [Variable]      ,         
                  ((CHARINDEX(''_ny'', [Variable])) + 3) , 1, '''')
                  ELSE                 [Variable]
                  END
      , [Value]
      , [PctWg]
         =        
                  CAST ((
                            100.000000000000
                           /SUM([CntWg]) 
                            OVER(
                            PARTITION BY  [Question_Year]
                                        , [Variable]      )
                                                            ) AS DECIMAL (38,12))
      , [PctWgR5]
         =        
                  CAST ((
                            100.000000000000
                           /SUM([CntWg]) 
                            OVER(
                            PARTITION BY  [Region5]
                                        , [Question_Year]
                                        , [Variable]      )
                                                            ) AS DECIMAL (38,12))
      , [PctWgR6]
         =        
                  CAST ((
                            100.000000000000
                           /SUM([CntWg]) 
                            OVER(
                            PARTITION BY  [Region6]
                                        , [Question_Year]
                                        , [Variable]      )
                                                            ) AS DECIMAL (38,12))
      , [CntWg] 
FROM
(
SELECT  
        *
      , [CntWg] 
         =        1
  FROM [V3_W&Extras_by_Ctry&Year]
) NR
UNPIVOT
  (
     Value
FOR
     Variable
in (
/***************************************************************************************************************************************************************/
'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- select                                                                       /*** SELECT statement to TEST stuffing procedure...                          ***/
/*** Begin stuffing function to remove the first comma in the list of fields to be retrieved (parenthesis not needed) ******************************************/
STUFF(                                                                          /*** begining of the "stuff: function                                        ***/
/***************************************************************************************************************************************************************/
(                                                                                /*** parenthesis to include query for the cell to be stuffed                ***/
/***************************************************************************************************************************************************************/
/*** Begin selection (into text, in a cell) of a comma delimited list of fields from a system view *************************************************************/
/***************************************************************************************************************************************************************/
    SELECT                                                                      /*** SELECT statement                                                        ***/
          ', '                                                                  /*** comma delimiter                                                         ***/
        +                                                                       /*** concatenated to...                                                      ***/
          [COLUMN_NAME]                                                         /*** field in system view which includes all field names                     ***/
    FROM                                                                        /*** from...                                                                 ***/
          [INFORMATION_SCHEMA].[COLUMNS]                                        /*** name of the system view which includes all field names                  ***/
    WHERE                                                                       /*** begining of filters to be applied...                                    ***/
          [TABLE_NAME]                                                          /*** field in system view which includes all table names                     ***/
                        IN     (                                                /*** FITER TO INCLUDE ONLY:                                                  ***/
                                 'V3_W&Extras_by_Ctry&Year'                     /*** desired view (restrictions/indexes and extras by country and year)      ***/
                                                                         )      /*** end filter "in"                                                         ***/
    AND                                                                         /*** second filter to be applied...                                          ***/
          [COLUMN_NAME]                                                         /*** field in system view which includes all field names                     ***/
                        NOT IN (                                                /*** FITER TO EXCLUDE ALL variables not to be unpivoted:                     ***/
                                    'Nation_fk'                                 /*** Exclude field: PK of Pew_Nation (countries)                             ***/
                                  , 'Region5'                                   /*** Exclude field: 5-Regions categorization of countries                    ***/
                                  , 'Region6'                                   /*** Exclude field: 6-Regions categorization of countries                    ***/
                                  , 'Ctry_EditorialName'                        /*** Exclude field: Editorial Name of Country (in Pew_Nation)                ***/
                                  , 'Question_Year'                             /*** Exclude field: Year corresponding to the coded data                     ***/
                                  , 'GRI'                                       /*** Exclude field: GRI Year index (different number precision and scale)    ***/
                                  , 'SHI'                                       /*** Exclude field: SHI Year index (different number precision and scale)    ***/
                                  , 'GFI'                                       /*** Exclude field: GFI Year index (different number precision and scale)    ***/
                                  , 'GRI_rd_1d'                                 /*** Exclude field: GRI round index (different number precision and scale)   ***/
                                  , 'SHI_rd_1d'                                 /*** Exclude field: SHI round index (different number precision and scale)   ***/
                                  , 'GFI_rd_1d'                                 /*** Exclude field: GFI round index (different number precision and scale)   ***/
                                                                         )      /*** end filter "not in"                                                     ***/
    ORDER BY                                                                    /*** sorting order by variables names, including:                            ***/
          ', '                                                                  /*** comma delimiter                                  -> as part of sorting  ***/
        +                                                                       /*** concatenated to...                               -> as part of sorting  ***/
          [COLUMN_NAME]                                                         /*** field in system view which includes all field names                     ***/
    FOR XML PATH('')                                                            /*** Modifies the selected rowset nesting all cells into an XML string cell  ***/
/***************************************************************************************************************************************************************/
/*** End of the selection (into text, in a cell) of a comma delimited list of fields ***************************************************************************/
/***************************************************************************************************************************************************************/
)                                                                                /*** parenthesis to include query for the cell to be stuffed                ***/
/***************************************************************************************************************************************************************/
, 1, 1, '')                                                                     /*** from STUFF: from position 1, change 1 character into ''                 ***/
/****************************************************************************************************************************** stuffing function ends here! ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
N'
/***************************************************************************************************************************************************************/
)                                                                               /*** end of listing of variables                                             ***/
 )                                                                                                                                                      AS   pivt
/***************************************************************************************************************************************************************/
'
/*


Nation_fk	Ctry_EditorialName
154	North Korea

Nation_fk	Ctry_EditorialName
237	South Sudan
*/


/***************************************************************************************************************************************************************/
/*** This is a way for checking the SQL statement that has been stored as a string variable ********************************************************************/
--  SELECT @ALLCODE
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
/*** The complete SQL statement stored as a string variable is executed as a character string ******************************************************************/
/***************************************************************************************************************************************************************/
EXEC  (@ALLCODE)
/***************************************************************************************************************************************************************/
