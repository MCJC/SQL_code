/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>   This is the script used to create the view [GRSHRYYYY].[dbo].[v04_Descriptions]                                      <<<<<     ***/
/***             (descriptions provided current year & descriptions enetered the former coding year - in wide format by country)                ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
/*                                                                                                                                                */
/*  REFERENCE to 2015 appears JUST ONCE in the script                                                                                             */
/*                                                                                                                                                */
/**************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==> creating view [v04_Descriptions]                                                         --- '
/**************************************************************************************************************************************************/
USE              [GRSHR2015]
GO
/**************************************************************************************************************************************************/
declare @CURR nvarchar(4)                                 /***        declare variable for storing current year (number as text)                ***/
set     @CURR = (SELECT (MAX([Q_Yr]) - 0)                 /***        set value to current year                                                 ***/
                 FROM [v02_AllCodedValues]  )             /***        from main view used as source                                             ***/
declare @PAST nvarchar(4)                                 /***        declare variable for storing former year (number as text)                 ***/
set     @PAST = (SELECT (MAX([Q_Yr]) - 1)                 /***        set value to former year = current year minus 1                           ***/
                 FROM [v02_AllCodedValues]  )             /***        from main view used as source                                             ***/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the first part w/temp. set known as common table expression CTE   ***/
N'
ALTER VIEW     [v04_Descriptions]     AS
WITH [CTE]
  AS
    (
      SELECT [Nation_fk]
            ,[Ctry_EditorialName]
            ,[Year]                = SUBSTRING([Question_Year], 6, 8)
           '
/*********************************************************     <<<<<  this has been the first part of the code                                  ***/
/**************************************************************************************************************************************************/
/*-------------------------------------------------------*     >>>>>  this is the second part of the code to be executed                        ***/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                    ', ' + [WQA_std]                      /***        distinct comma delimiter concatenated to field QA modified (as varname)   ***/
          FROM      [WT_VNs]                              /***        from table including var names & classifications as rows                  ***/
          WHERE     [QClass]     IN (   'DESCR'  )        /***        include Q with descriptions                                               ***/
            AND     [QTable] NOT IN (    'xs'    )        /***        vars to be excluded: sources (and former year's ???)                      ***/
             FOR XML PATH('')                       )     /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*-------------------------------------------------------*     <<<<<  this has been the second part of the code                                 ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the third part of the code to be executed                         ***/
+ N'
FROM  [v02_AllCodedValues]
WHERE [Q_Yr] > ( SELECT (MAX([Q_Yr]) - 2) FROM [v02_AllCodedValues] )     )
          '
/*********************************************************     <<<<<  this has been the third part of the code (end of  CTA)                    ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the fourth part of the code to be executed                        ***/
+ N'
SELECT CURR.[Nation_fk]
      ,CURR.[Ctry_EditorialName]
          '
/*********************************************************     <<<<<  this has been the fourth part of the code                                 ***/
/**************************************************************************************************************************************************/
/*-------------------------------------------------------*     >>>>>  this is the fifth part of the code to be executed                         ***/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                    ', ' + [WQA_std]                      /***        distinct comma delimiter concatenated to field QA modified (as varname)   ***/
         + '_' + @PAST                                    /***        adding numeric-code identifier for former year                            ***/
         +    ' = PAST.' + [WQA_std]                      /***        set equal to former year description                                      ***/
          FROM      [WT_VNs]                              /***        from table including var names & classifications as rows                  ***/
          WHERE     [QClass]     IN (   'DESCR'  )        /***        include Q with descriptions                                               ***/
            AND     [QTable] NOT IN (    'xs'    )        /***        vars to be excluded: sources (and former year's ???)                      ***/
             FOR XML PATH('')                       )     /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*-------------------------------------------------------*     <<<<<  this has been the fifth part of the code                                  ***/
/**************************************************************************************************************************************************/
/*-------------------------------------------------------*     >>>>>  this is the sixth part of the code to be executed                         ***/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                    ', ' + [WQA_std]                      /***        distinct comma delimiter concatenated to field QA modified (as varname)   ***/
         + '_' + @CURR                                    /***        adding numeric-code identifier for former year                            ***/
         +    ' = CURR.' + [WQA_std]                      /***        set equal to former year description                                      ***/
          FROM      [WT_VNs]                              /***        from table including var names & classifications as rows                  ***/
          WHERE     [QClass]     IN (   'DESCR'  )        /***        include Q with descriptions                                               ***/
            AND     [QTable] NOT IN (    'xs'    )        /***        vars to be excluded: sources (and former year's ???)                      ***/
             FOR XML PATH('')                       )     /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*-------------------------------------------------------*     <<<<<  this has been the sixth part of the code                                  ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the seventh part of the code to be executed                       ***/
+ N'
FROM  [CTE]  CURR
JOIN  [CTE]  PAST
ON    CURR.Nation_fk
    = PAST.Nation_fk
WHERE CURR.[Year] = ( SELECT (MAX([Q_Yr]) - 0) FROM [v02_AllCodedValues] )
  AND PAST.[Year] = ( SELECT (MAX([Q_Yr]) - 1) FROM [v02_AllCodedValues] )
          '
/*********************************************************     <<<<<  this has been the seventh and final part of the code                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO
