/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 007    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the lookup table [forum_ResAnal].[dbo].[vr___04_lab_SemiWide_byCtry&Yr]                         <<<<<     ***/
/***             This table has Stata statements for labeling variables included in dataset for public download                                              ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [GRSHRcode]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/ALTER  VIEW                      [dbo].[vr___04_wlabSemiWide_byCtry&Yr]        AS
SELECT * FROM
(
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  SELECT                                                                        /*** SELECT statement                                                        ***/
 	        [k]         =  ROW_NUMBER() OVER(ORDER BY [COLUMN_NAME])            /***        sorting by field names                                           ***/
          , [VarName]   =  SUBSTRING( (S.[COLUMN_NAME]                          /***        field names, including Q Abb Std in vr_04 (also CY, *nyN, *ny@ ) ***/
                                    +  '                         ' ),1, 25)     /***        add spaces for aligig next secion of code                        ***/
          , [VarLabel]  =  ' "' + L.[attr] + '" '                               /***        Q wordings for labeling Stata variables                          ***/
    FROM                                                                        /*** from...                                                                 ***/
            [INFORMATION_SCHEMA].[COLUMNS]                            S         /*** [FResAn] Sys view which includes all field names as rows                ***/
 INNER JOIN                                                                     /*** join                                                                    ***/
            [forum]..[Pew_Question_Std]                               Q         /*** Q Std Table: adds PK and excludes vars as *nyN, *ny@ or region-CY, etc. ***/
         ON S.[COLUMN_NAME] = Q.[Question_abbreviation_std]                     /***       (join by Std Q Name)                                              ***/
 INNER JOIN                                                                     /*** join                                                                    ***/
            [forum]..[Pew_Question_Attributes]                        L         /*** Q Attributes                                                            ***/
		 ON Q.[Question_Std_pk] = L.[Question_Std_fk]                           /***       (join by PK/FK)                                                   ***/
    WHERE                                                                       /*** FILTER:                                                                 ***/
              S.[TABLE_NAME]   = 'vr___04_wDB_SemiWide_byCtry&Yr'               /***          only fields for the view vr_04 ( from System View )            ***/
      AND     L.[attk]         = '80CharsLabel'                                 /***          only Qs with Stata (80Chars) var name ( from Attrib table )    ***/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
)  SETA
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/
