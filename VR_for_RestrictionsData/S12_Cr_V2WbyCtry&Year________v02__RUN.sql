/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [for_x].[dbo].[V2_WRestr_by_Ctry&Year]                                                    <<<<<     ***/
/***             This view only includes numeric values aggregated by country/religion & year (does not include descriptive wordings).                       ***/
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
               [dbo].[V2_W_by_Ctry&Year]
AS
/***************************************************************************************************************************************************************/
'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
N'
/***************************************************************************************************************************************************************/
SELECT
       *
FROM
/***************************************************************************************************************************************************************/
'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***  Long NPR aggregated by country (& religion due to variable names)  ***************************************************************************************/
N'
(
/***************************************************************************************************************************************************************/
SELECT 
       [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[QA_std]
      ,[Answer_value]      = SUM([Answer_value])
  FROM
/***  Basic Data: Long NPR *************************************************************************************************************************************/
            [V1_DB_Long]
/************************************************************************************************************************************  Basic Data: Long NPR  ***/
GROUP BY
       [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[QA_std]
/***************************************************************************************************************************************************************/
)                                                                                                                                                      AS   lnpr
'
/***************************************************************************************  Long NPR aggregated by country (& religion due to variable names)  ***/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
N'
/***************************************************************************************************************************************************************/
PIVOT
(
  MAX([Answer_value])
  FOR [QA_std]
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
    SELECT                                                                      /*** SELECT statement (notice THERE IS alias for the recoded field           ***/
          DISTINCT                                                              /*** should be distinct to include once each variable name                   ***/
          ', '                                                                  /*** comma delimiter                                                         ***/
        +                                                                       /*** concatenated to...                                                      ***/
          [QA_std]                                                              /*** Fiels including all Q Abb Std (StdVarName)                              ***/
    FROM                                                                        /*** from...                                                                 ***/
          [V1_DB_Long]                                                          /*** name of the table which includes all field (var) names as rows          ***/
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
+
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
N'
/***************************************************************************************************************************************************************/
)                                                                               /*** end of listing of variables                                             ***/
 )                                                                                                                                                      AS   pivt
/***************************************************************************************************************************************************************/
'
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
