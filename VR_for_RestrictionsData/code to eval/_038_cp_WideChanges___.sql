/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>   This is the script used to create the view [GRSHRYYYY].[dbo].[v03_WideChanges]                                       <<<<<     ***/
/***             (compare all new entered values to formerly entered values and display differences in wide format by country)                  ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
/*                                                                                                                                                */
/*  REFERENCE to 2015 appears JUST ONCE in the script                                                                                             */
/*                                                                                                                                                */
/**************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==> creating view [v03_WideChanges]                                                          --- '
/**************************************************************************************************************************************************/
USE              [GRSHR2015]
GO
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the first part of the code                                        ***/
N'
ALTER VIEW     [v03_WideChanges]
AS
SELECT [Nation_fk]
      ,[Ctry_EditorialName]
          '
/*********************************************************     <<<<<  this has been the first part of the code                                  ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the second part of the code to be executed                        ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                    ', ' + [WQA_std] + ' = CASE '         /***        distinct comma delimiter concatenated to field QA modified (as varname)   ***/
              + ' WHEN ' + [WQA_std] + '_curr IS NULL'    /***        condition: no data for current year                                       ***/
              + '  AND ' + [WQA_std] + '_past IS NULL'    /***        condition: no data for former year                                        ***/
              + ' THEN ''both_NULL'' '                    /***        message                                                                   ***/
              + ' WHEN ' + [WQA_std] + '_curr IS NULL'    /***        condition: no data for current year                                       ***/
              + ' THEN ''curr_NULL'' '                    /***        message                                                                   ***/
              + ' WHEN ' + [WQA_std] + '_past IS NULL'    /***        condition: no data for former year                                        ***/
              + ' THEN ''past_NULL'' '                    /***        message                                                                   ***/
              + ' WHEN ' + [WQA_std] + '_curr != '        /***        diffeerent data for current year...                                       ***/
                         + [WQA_std] + '_past    '        /***        compared to data for former year                                          ***/
              + ' THEN ''difference'' '                   /***        message                                                                   ***/
              + ' WHEN ' + [WQA_std] + '_curr  = '        /***        same data for current year...                                             ***/
                         + [WQA_std] + '_past    '        /***        compared to data for former year                                          ***/
              + ' THEN    ''same''   '                    /***        message                                                                   ***/
              + ' ELSE ''ERROR !!!''              END'    /***        final message and end of 'when'                                           ***/
          FROM      [WT_VNs]                              /***        from table including var names & classifications as rows                  ***/
          WHERE     [QClass]     IN (   'CODED'           /***        include Q with coded answers                                              ***/
                                      , 'COUNT'           /***        include Q with count answers                                              ***/
                                      , 'PERSI'  )        /***        and include Q with answers automatically calculated                       ***/
            AND     [QTools] NOT IN (   'filter'  )       /***        vars to be excluded: filter questions (usually coded)                     ***/
             FOR XML PATH('')                       )     /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*********************************************************     <<<<<  this has been the second part of the code                                 ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the third part of the code to be executed                         ***/
+ N'
FROM
(
SELECT [Nation_fk]
      ,[Ctry_EditorialName]
          '
/*********************************************************     <<<<<  this has been the first part of the code                                  ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the second part of the code to be executed                        ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                    ', ' + [WQA_std] + '_curr ='          /***        distinct comma delimiter concatenated to field QA modified (as varname)   ***/ 
                         + [WQA_std]                      /***        equal to the original field QA (current varname)                          ***/
          FROM      [WT_VNs]                              /***        from table including var names & classifications as rows                  ***/
          WHERE     [QClass]     IN (   'CODED'           /***        include Q with coded answers                                              ***/
                                      , 'COUNT'           /***        include Q with count answers                                              ***/
                                      , 'PERSI'  )        /***        and include Q with answers automatically calculated                       ***/
            AND     [QTools] NOT IN (   'filter'  )       /***        vars to be excluded: filter questions (usually coded)                     ***/
             FOR XML PATH('')                       )     /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*********************************************************     <<<<<  this has been the second part of the code                                 ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the third part of the code to be executed                         ***/
+ N'
  FROM [v02_AllCodedValues]
 WHERE [Question_Year] = ''Year_'' + CAST((SELECT MAX([Question_Year]) FROM [AllLongData]) AS NVARCHAR)
) AS DCURR

INNER JOIN 

(
SELECT [Nk2] = [Nation_fk]
          '
/*********************************************************     <<<<<  this has been the first part of the code                                  ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the second part of the code to be executed                        ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                    ', ' + [WQA_std] + '_past =' 
                         + [WQA_std]                      /***        distinct comma delimiter concatenated to field QA (as varname)            ***/
          FROM      [WT_VNs]                              /***        from table including var names & classifications as rows                  ***/
          WHERE     [QClass]     IN (   'CODED'           /***        include Q with coded answers                                              ***/
                                      , 'COUNT'           /***        include Q with count answers                                              ***/
                                      , 'PERSI'  )        /***        and include Q with answers automatically calculated                       ***/
            AND     [QTools] NOT IN (   'filter'  )       /***        vars to be excluded: filter questions (usually coded)                     ***/
             FOR XML PATH('')                       )     /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*********************************************************     <<<<<  this has been the second part of the code                                 ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the third part of the code to be executed                         ***/
+ N'
  FROM [v02_AllCodedValues]
 WHERE [Question_Year] = ''Year_'' + CAST( ((SELECT MAX([Question_Year]) FROM [AllLongData]) - 1) AS NVARCHAR)
) AS DPAST
    ON [Nation_fk]  = [Nk2]
'                                                         /*** <<<<<  this completes the seventh and final part of the code                     ***/
/**************************************************************************************************************************************************/
/*********************************************************     <<<<<< this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO
