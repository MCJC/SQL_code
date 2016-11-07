/***************************************************************************************************************************************************************/
Print '--- '+CONVERT(VARCHAR(19),SYSDATETIME())+' ==>  script 2.003    ---------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>   This is the script used to create the view [GRSHRYYYY].[dbo].[v03_WideChanges]                                       <<<<<     ***/
/***             (compare all new entered values to formerly entered values and display differences in wide format by country)                  ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
USE              [GRSHRcode]
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
SELECT EV.[Nation_fk]                 202-552-5782
      ,EV.[Ctry_EditorialName]
          '
/*********************************************************     <<<<<  this has been the first part of the code                                  ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the second part of the code to be executed                        ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                       ', ' + [QAS] + ' = CASE '         /***        distinct comma delimiter concatenated to field QA modified (as varname)   ***/
              + ' WHEN EV.' + [QAS] + ' IS NULL'    /***        condition: no data for current year                                       ***/
              + '  AND PV.' + [QAS] + ' IS NULL'    /***        condition: no data for former year                                        ***/
              + ' THEN                          ''both__NULL'' '                    /***        message                                                                   ***/
              + ' WHEN EV.' + [QAS] + ' IS NULL'          /***        condition: no data for current year                                       ***/
              + ' THEN                          ''curr__NULL'' '                    /***        message                                                                   ***/
              + ' WHEN PV.' + [QAS] + ' IS NULL'             /***        condition: no data for former year                                        ***/
              + ' THEN                          ''past__NULL'' '   /***        message                                                                   ***/
              + ' WHEN EV.' + [QAS]                          /***        diffeerent data for current year...                                       ***/
              + '  !=  PV.' + [QAS]                          /***        compared to data for former year                                          ***/
              + ' THEN                          ''difference'' '                   /***        message                                                                   ***/
              + ' WHEN EV.' + [QAS]                       /***        same data for current year...                                             ***/
              + '   =  PV.' + [QAS]                       /***        compared to data for former year                                          ***/
              + ' THEN                          ''same_VALUE''   '                    /***        message                                                                   ***/
              + ' ELSE                          ''->ERROR!!!''              END'    /***        final message and end of 'when'                                           ***/
/**************************************************************************************************************************************************/
          FROM      [AT_Qs]                               /***        from table including var names & classifications as rows                  ***/
          WHERE     [QAS]    NOT LIKE '%_DES'               /***        include Q with coded answers                                              ***/
               AND  [QAS]    NOT LIKE '%_yBe'           /***        include Q with count answers                                              ***/
               AND  [QAS]    NOT LIKE '%_filter'         /***        vars to be excluded: filter questions (usually coded)                     ***/
                             FOR XML PATH('')    )     /*** <      End of the selection, nesting all cells into an XML string cell              ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/*********************************************************     <<<<<  this has been the second part of the code                                 ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the third part of the code to be executed                         ***/
+ N'
FROM
    ( SELECT
               EV.[Question_Year]
             , EV.[Nation_fk]
             , EV.[Ctry_EditorialName]
             ' +
/**************************************************************************************************************************************************/
(           SELECT ', ' + [QAS] FROM [AT_Qs]           /*** >      Begin selection (into text, in a cell, comma delimited list of varnames)     ***/
                             FOR XML PATH('')    )     /*** <      End of the selection, nesting all cells into an XML string cell              ***/
/**************************************************************************************************************************************************/
+N'                FROM [v01_EnteredValues]            EV                               ) EV


INNER JOIN 


    ( SELECT
               PV.[Question_Year]
             , PV.[Nation_fk]
             , PV.[Ctry_EditorialName]
             ' +
/**************************************************************************************************************************************************/
(           SELECT ', ' + [QAS] FROM [AT_Qs]           /*** >      Begin selection (into text, in a cell, comma delimited list of varnames)     ***/
                             FOR XML PATH('')    )     /*** <      End of the selection, nesting all cells into an XML string cell              ***/
/**************************************************************************************************************************************************/
+N'                FROM [GRSH_C]                       PV
                  WHERE [Question_Year] = (SELECT MIN([Question_Year]) FROM [GRSH_C]))    PV 

    ON EV.[Nation_fk]  = PV.[Nation_fk]
      AND EV.[Ctry_EditorialName] = PV.[Ctry_EditorialName]

'                                                         /*** <<<<<  this completes the seventh and final part of the code                     ***/
/**************************************************************************************************************************************************/
/*********************************************************     <<<<<< this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/
Print                    '------------------------------------------------------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
GO