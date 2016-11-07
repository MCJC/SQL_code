/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 004    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>         This script creates semi-WIDE set of STORED data from the 'Global Restriction on Religion Study'                            <<<<<     ***/
/***                    -  Data of each row are by country-year                                                                                              ***/
/***                    -  Any wide/semi-wide set of data includes only numeric values for GR&SH R                                                           ***/
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
ALTER  VIEW                      [dbo].[vr___02_]        AS
SELECT * FROM
'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  Long NPR aggregated by country and null values recoded as zero in known count variables  *****************************************************************/
N'
(
/***************************************************************************************************************************************************************/
SELECT 
       [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(                                                                                /*** parenthesis to include query for the cell to be stuffed                ***/
/***************************************************************************************************************************************************************/
/*** Begin selection (into text, in a cell) of a comma delimited list of fields from a system view *************************************************************/
/***************************************************************************************************************************************************************/
    SELECT                                                                      /*** SELECT statement (notice THERE IS alias for the recoded field           ***/
          DISTINCT                                                              /*** should be distinct to include once each variable name                   ***/
          CASE                                                                  /*** CASE to select two different wordings...                                ***/
          WHEN        [QA_std]     LIKE 'GRI_19_[b-f]'                          /*** when count variables GRI_19                                             ***/
                 OR   [QA_std]     LIKE 'SHI_01_[b-f]'                          /*** or   count variables SHI_01                                             ***/
                 OR   [QA_std]     LIKE 'SHI_04_[b-f]'                          /*** or   count variables SHI_04                                             ***/
                 OR   [QA_std]     LIKE 'SHI_05_[c-f]'                          /*** or   count variables SHI_05                                             ***/
          THEN ', ' + [QA_std] + ' = ISNULL(' + [QA_std] + ', 0)'               /*** as comma delimited code to include null values as ceros                 ***/
          ELSE ', ' + [QA_std]                                                  /*** else comma delimited field for all other QA Std (StdVarName)            ***/
          END                                                                   /*** end of CASE section, used to include two different wordings             ***/
    FROM                                                                        /*** from...                                                                 ***/
          [vr___01_cDB_Long__NoAggregated]                                      /*** name of the table which includes all field (var) names as rows          ***/
                                                                                /*** NO FILTERS needed                                                       ***/
         ORDER BY                                                               /*** sorting order using exact final field, including:                       ***/
          CASE                                                                  /*** CASE to sort using two different wordings...                            ***/
          WHEN        [QA_std]     LIKE 'GRI_19_[b-f]'                          /*** when count variables GRI_19                                             ***/
                 OR   [QA_std]     LIKE 'SHI_01_[b-f]'                          /*** or   count variables SHI_01                                             ***/
                 OR   [QA_std]     LIKE 'SHI_04_[b-f]'                          /*** or   count variables SHI_04                                             ***/
                 OR   [QA_std]     LIKE 'SHI_05_[c-f]'                          /*** or   count variables SHI_05                                             ***/
          THEN ', ' + [QA_std] + ' = ISNULL(' + [QA_std] + ', 0)'               /*** as comma delimited code to include null values as ceros                 ***/
          ELSE ', ' + [QA_std]                                                  /*** else comma delimited field for all other QA Std (StdVarName)            ***/
          END                                                                   /*** end of CASE, used to sort list of fields by two different wordings      ***/
         for xml path('')                                                       /*** Modifies the selected rowset nesting all cells into an XML string cell  ***/
/***************************************************************************************************************************************************************/
/*** End of the selection (into text, in a cell) of a comma delimited list of fields ***************************************************************************/
/***************************************************************************************************************************************************************/
)                                                                                /*** parenthesis to include query for the cell to be stuffed                ***/
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  all this from...  ****************************************************************************************************************************************/
N'
FROM ( 
'
/****************************************************************************************************************************************  all this from...  ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  Long NPR aggregated by country (& religion due to variable names)  ***************************************************************************************/
N'
SELECT 
       [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[QA_std]
      ,[Answer_value]      = SUM([Answer_value])
  FROM
            [vr___01_cDB_Long__NoAggregated]
GROUP BY
       [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[QA_std]
)                                                                                                                                                      AS   lnpr
'
/***************************************************************************************  Long NPR aggregated by country (& religion due to variable names)  ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
N'
PIVOT
(
  MAX([Answer_value])
  FOR [QA_std]
                   in (
'
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                /*** start listing of variables                                              ***/
/***************************************************************************************************************************************************************/
-- select                                                                       /*** SELECT statement to TEST stuffing procedure...                          ***/
/*** Begin stuffing function to remove the first comma in the list of fields to be retrieved (parenthesis not needed) ******************************************/
STUFF(                                                                          /*** begining of the "stuff: function                                        ***/
/***************************************************************************************************************************************************************/
(                                                                                /*** parenthesis to include query for the cell to be stuffed                ***/
/***************************************************************************************************************************************************************/
/*** Begin selection (into text, in a cell) of a comma delimited list of fields from a system view *************************************************************/
/***************************************************************************************************************************************************************/
    SELECT                                                                      /*** SELECT statement (notice THERE IS alias for the recoded field           ***/
          DISTINCT                                                              /*** should be distinct to include once each variable name                   ***/
          ', '                                                                  /*** comma delimiter                                                         ***/
        +                                                                       /*** concatenated to...                                                      ***/
          [QA_std]                                                              /*** Fiels including all Q Abb Std (StdVarName)                              ***/
    FROM                                                                        /*** from...                                                                 ***/
          [vr___01_cDB_Long__NoAggregated]                                      /*** name of the table which includes all field (var) names as rows          ***/
                                                                                /*** NO FILTERS needed                                                       ***/
         ORDER BY                                                               /*** sorting order using exact final field, including:                       ***/
          ', '                                                                  /*** comma delimiter                                  -> as part of sorting  ***/
        +                                                                       /*** concatenated to...                               -> as part of sorting  ***/
          [QA_std]                                                              /*** Fiels including all Q Abb Std (StdVarName)       -> as part of sorting  ***/
         for xml path('')                                                       /*** Modifies the selected rowset nesting all cells into an XML string cell  ***/
/***************************************************************************************************************************************************************/
/*** End of the selection (into text, in a cell) of a comma delimited list of fields ***************************************************************************/
/***************************************************************************************************************************************************************/
)                                                                                /*** parenthesis to include query for the cell to be stuffed                ***/
/***************************************************************************************************************************************************************/
, 1, 1, '')                                                                     /*** from STUFF: from position 1, change 1 character into ''                 ***/
/****************************************************************************************************************************** stuffing function ends here! ***/
                                                                                /*** end of listing of variables                                             ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
N'
)
 )                                                                                                                                                     AS   pivt
  )                                                                                                                                                    AS   berc
'
/***************************************************************************************************************************************************************/
/*** checking / executing SQL statement that has been stored as a string variable ******************************************************************************/
--	EXEC dbo.LongPrint @ALLCODE                                     /***        display the currently stored code (to be executed)                           ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
	EXEC              (@ALLCODE)                                    /***        execute the code that has been stored as text                                ***/
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/








/***************************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]
SELECT * INTO    [forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]
            FROM                 [dbo].[vr___02_]
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/
--	SELECT* FROM [forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]
/***************************************************************************************************************************************************************/
