/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This script creates lookup table [__Displayable_NewWideVersion]                                                                   <<<<<     ***/
/***     >>>>>                       backup table [_until YYYYMMDD  WideVersion]                                                                   <<<<<     ***/
/***     >>>>>                       VIEW         [  Displayable_NewWideVersion]                                                                   <<<<<     ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [RLS]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
/*****                                                                BackUp  current Table                                                                *****/
/***************************************************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)                                                                                    /*   declare variable to store current date  */
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                                                             /*   store date in format YYYYMMDD           */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
IF OBJECT_ID (N'[RLS].[dbo].[__Displayable_NewWideVersion]', N'U') IS NOT NULL                                    /*   statement of condition                  */
EXEC     ( ' SELECT * INTO  [_until' +@CrDt+ 'WideVersion]  '                                                     /*   select into backup                      */
             + '      FROM  [__Displayable_NewWideVersion]  '                                                     /*   selection from current table            */
             + 'DROP TABLE  [__Displayable_NewWideVersion]  '                  )                                  /*   and DELETE current table                */
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/
declare @ALLCODE nvarchar(max)
/***************************************************************************************************************************************************************/
set     @ALLCODE = 
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***  select statement for pivoted RLS microdata (into wide format)  *******************************************************************************************/
N'
SELECT 
       [RLS_DNWV_pk]                      = ROW_NUMBER() OVER (ORDER BY [RLSx0_001_main_ID])
      , *
INTO   [__Displayable_NewWideVersion]
FROM 
'
/***************************************************************************************************************************************************************/
+
/*** >  Long RLS microdata  ************************************************************************************************************************************/
N'
(

SELECT 
       [RLSx0_001_main_ID]                =           [PSR].[SVY_psraid]
      ,[RLSx1_001_year]                   = CAST(
                                            SUBSTRING([PSR].[SVY_psraid],3,4) AS int)
      ,[RLSx2_001_WEIGHT]                 =           [PSR].[weight]
      ,[RLSx2_002_akhiweight2007]         =           [PSR].[weight_akhi2007]
      ,[RLSx2_003_WGT_all_MSA]            =           [PSR].[weight_all_MSA]
      ,[RLSx3_000_other_and_christian]    =           [PRG].[RLSx3_001_otherfaithfordisplay]
                                                    + ''/''
                                                    + [PRG].[RLSx3_002_christianfordisplay]
      ,[RLSx3_001_otherfaithfordisplay]
      ,[RLSx3_002_christianfordisplay]
      ,[RLSx3_003_protestantfordisplay]
      ,[RLSx4_001_reltradfordisplay_v]
      ,[RLSx4_001_reltradfordisplay_w]
      ,[RLSx4_002_protfamfordisplay_v]
      ,[RLSx4_002_protfamfordisplay_w]
      ,[RLSx4_003_familyfordisplay_v]
      ,[RLSx4_003_familyfordisplay_w]
      ,[RLSx4_004_denomfordisplay2_v]
      ,[RLSx4_004_denomfordisplay2_w]
      ,[PQA].[Question_abbreviation_std]
      ,[PQA].[Answer_Wording_std]
  FROM [RLS].[dbo].[Pew_Survey_Respondent]            PSR
LEFT
JOIN
       [RLS].[dbo].[Pew_Religion_Group]               PRG
  ON   [PSR].[Religion_fk]
      =[PRG].[RLS_Religion_pk]
LEFT
JOIN
       [RLS].[dbo].[Pew_Survey_Respondent_Answer]     SRA
  ON   [PSR].[Svy_Respondent_pk]
      =[SRA].[Svy_Respondent_fk]
LEFT
JOIN
       [RLS].[dbo].[Pew_Q&A]                          PQA
  ON   [PQA].[Answer_fk]
      =[SRA].[Answer_fk]

) LONG_DATA
'
/*** <  Long RLS microdata  ************************************************************************************************************************************/
+
/***    code for pivoting data *********************************************************************************************************************************/
N'
PIVOT 
(MAX ([Answer_Wording_std])
 FOR  [Question_abbreviation_std]
  IN( 
'
/***    code for pivoting data *********************************************************************************************************************************/
+
/*** >> stuffing procedure to list fields coded to display  ****************************************************************************************************/
-- select                                                                                                         /*** statement to TEST stuffing procedure  ***/
STUFF(                                                                                                            /*** begining of the "stuff: function      ***/
/***************************************************************************************************************************************************************/
(                                                                                                                 /*** parenthesis: XML cell to be stuffed   ***/
/***************************************************************************************************************************************************************/
/*** BEGIN selection (into text, in a cell) of a comma delimited list of fields ********************************************************************************/
  SELECT                                                                                                          /*** SELECT statement (THERE IS NO alias)  ***/
          ', '                                                                                                    /*** comma delimiter                       ***/
        +                                                                                                         /*** concatenated to...                    ***/
          [Question_abbreviation_std]                                                                             /*** field includes Q Abb Std (StdVarName) ***/
    FROM                                                                                                          /*** from...                               ***/
          [Pew_Question_Std]                                                                                      /*** name of table including QAS as rows   ***/
   WHERE                                                                                                          /*** filter to include only...             ***/
          [Display] = 1                                                                                           /*** questions that should be displayed    ***/  
ORDER BY                                                                                                          /*** sorting using exact final field, as:  ***/
          ', '                                                                                                    /*** comma delimiter                       ***/
        +                                                                                                         /*** concatenated to...                    ***/
          [Question_abbreviation_std]                                                                             /*** field includes Q Abb Std (StdVarName) ***/
FOR XML PATH('')                                                                                                  /*** Modifies rowset nesting into XML cell ***/
/***************************************************************************************************************************************************************/
/*** END of the selection (into text, in a cell) of a comma delimited list of fields ***************************************************************************/
/***************************************************************************************************************************************************************/
)                                                                                                                 /*** parenthesis: XML cell to be stuffed   ***/
/***************************************************************************************************************************************************************/
, 1, 1, '')                                                                                                       /*** STUFF: from position 1, 1 charinto '' ***/
/*** << stuffing procedure to list fields coded to display  ****************************************************************************************************/
/***************************************************************************************************************************************************************/
+
/***    code for pivoting data *********************************************************************************************************************************/
N'
    )) 
       as VARStobePIVOTED
'
/***    code for pivoting data *********************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/*=============================================================================================================================================================*/
/***************************************************************************************************************************************************************/
/*** This is a way for checking the SQL statement that has been stored as a string variable ********************************************************************/
--  SELECT @ALLCODE
/***************************************************************************************************************************************************************/
/*** The complete SQL statement stored as a string variable is executed as a character string ******************************************************************/
/***************************************************************************************************************************************************************/
EXEC  (@ALLCODE)
/***************************************************************************************************************************************************************/
------SELECT * FROM [RLS].[dbo].[Displayable_NewWideVersion]
GO
/***************************************************************************************************************************************************************/



/***************************************************************************************************************************************************************/
declare @VIEWCODE nvarchar(max)
/***************************************************************************************************************************************************************/
set     @VIEWCODE = 
/***************************************************************************************************************************************************************/
/***  view from select statement *******************************************************************************************************************************/
N'
ALTER VIEW                [dbo].[Displayable_NewWideVersion]
AS
SELECT * FROM                 [__Displayable_NewWideVersion]
'
/***  view from select statement *******************************************************************************************************************************/
/*=============================================================================================================================================================*/
/***************************************************************************************************************************************************************/
/*** This is a way for checking the SQL statement that has been stored as a string variable ********************************************************************/
--  SELECT @VIEWCODE
/***************************************************************************************************************************************************************/
/*** The complete SQL statement stored as a string variable is executed as a character string ******************************************************************/
EXEC  (@VIEWCODE)
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/
