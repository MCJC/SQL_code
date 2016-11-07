/**************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 2.001    --------------------------------------------------------------------------- '
/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>         This script creates the database [GRSHRcode], removes all tables & views, and sets views to [a] = 'a'          <<<<<     ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/

/**************************************************************************************************************************************************/
/***      Create working database for GR&SH R                                                                                                   ***/
/**************************************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--	USE [master]
--	GO
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--	CREATE DATABASE [GRSHRcode];
--	GO
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--	 ALTER DATABASE [GRSHRcode] SET RECOVERY SIMPLE 
--	GO
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************************/

USE [GRSHRcode]
GO

/**************************************************************************************************************************************************/
/***      Remove all tables and views                                                                                                           ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>> these are general variables to be used                                    ***/
/**************************************************************************************************************************************************/
DECLARE @CrDt varchar( 8)                                 /***        declare variable for storing current date (as text)                       ***/
SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))       /***        set value to current date in the format YYYYMMDD                          ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  cursor                                                                    ***/
DECLARE @CODEmain1 nvarchar(max)                          /***        declare variable for storing code during each data retreival              ***/
DECLARE @tablename nvarchar(max)                          /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor   CURSOR FOR                             /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
SELECT [ct] =                                             /*** >>>    select concatenated text                                                  ***/
                REPLACE([TABLE_TYPE], 'BASE ', '')        /***               edited table type (base )"TABLE' or "VIEW"                         ***/
              + '  [' + [TABLE_NAME] + ']'                /***               table/view names                                                   ***/
FROM        [INFORMATION_SCHEMA].[TABLES]                 /*** <<<    from the system view listing tables & views in the database               ***/
/**************************************************************************************************************************************************/
OPEN             MyCursor                                 /*** >>>    open cursor by its name                                                   ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @tablename                               /***        store it into the corresponding variable(s)                               ***/
          WHILE  @@FETCH_STATUS = 0                       /***        while the status of the last retreival has been successful                ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
BEGIN                                                     /*** >>     BEGIN the procedures using values of each row of the cursor               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
SET     @CODEmain1 =                                      /*** >      the code to be stored as string (for each row of the cursor) begins here: ***/
--/*----------------------------------------------------------------------------------------------------------------------------------------------*/
--   N'SELECT * INTO [_bk_forum]..[XR_'+@tablename+'_'+@CrDt+']' /*        selection into backup table                                            */
-- + CHAR(10)                                                    /*         add CR (& spaces)                                                     */
-- + N'    FROM                      ['+@tablename+']'           /*        from table to be deleted                                               */
-- + CHAR(10)                                                    /*         add CR                                                                */
-- +                                                             /*         add...                                                                */
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
     N'                        DROP   '+@tablename+''            /*        drop the table to be deleted                                           */
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <      the code to be stored as string ends here                                 ***/
	PRINT  (@CODEmain1)                                   /***        display the currently stored code (to be executed)                        ***/
	EXEC   (@CODEmain1)                                   /***        execute the code that has been stored as text                             ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <<     ENDING of the procedures using values of each row of the cursor           ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @tablename                               /***        store it into the corresponding variable(s)                               ***/
           END                                            /***        and end when last row has been retreived                                  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
   CLOSE         MyCursor                                 /*** <<<    close cursor by its name                                                  ***/
DEALLOCATE       MyCursor                                 /*** <<<<   remove reference and relase from memory by cursor name                    ***/
/*********************************************************     <<<<<  cursor                                                                    ***/
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
/***      Create views setting them to 'a'                                                                                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  cursor                                                                    ***/
DECLARE @CODEmain2 nvarchar(max)                          /***        declare variable for storing code during each data retreival              ***/
DECLARE @viewname  nvarchar(max)                          /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor   CURSOR FOR                             /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
      SELECT [VAR] =  'v01_EnteredValues'                 /*** >>>    select view names                                                         ***/
UNION SELECT [VAR] =  'v02_AllCodedValues'                /*** >>>       ... view names                                                         ***/
UNION SELECT [VAR] =  'v03_WideChanges'                   /*** >>>       ... view names                                                         ***/
UNION SELECT [VAR] =  'v04_Descriptions'                  /*** >>>       ... view names                                                         ***/
UNION SELECT [VAR] =  'v05_ReportData'                    /*** >>>       ... view names                                                         ***/
UNION SELECT [VAR] =  'v06_NDLongNoAggreg'                /*** >>>       ... view names                                                         ***/
/**************************************************************************************************************************************************/
OPEN             MyCursor                                 /*** >>>    open cursor by its name                                                   ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @viewname                                /***        store it into the corresponding variable(s)                               ***/
          WHILE  @@FETCH_STATUS = 0                       /***        while the status of the last retreival has been successful                ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
BEGIN                                                     /*** >>     BEGIN the procedures using values of each row of the cursor               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
SET     @CODEmain2 =                                      /*** >      the code to be stored as string (for each row of the cursor) begins here: ***/
N'CREATE VIEW [' + @viewname + '] AS SELECT [a] = ''a'' ' /*               set the view to be blanked to "a"                                      */
                                                          /*** <      the code to be stored as string ends here                                 ***/
PRINT  (@CODEmain2)                                       /***        display the currently stored code (to be executed)                        ***/
EXEC   (@CODEmain2)                                       /***        execute the code that has been stored as text                             ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <<     ENDING of the procedures using values of each row of the cursor           ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @viewname                                /***        store it into the corresponding variable(s)                               ***/
           END                                            /***        and end when last row has been retreived                                  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
   CLOSE         MyCursor                                 /*** <<<    close cursor by its name                                                  ***/
DEALLOCATE       MyCursor                                 /*** <<<<   remove reference and relase from memory by cursor name                    ***/
/*********************************************************     <<<<<  cursor                                                                    ***/
/**************************************************************************************************************************************************/
GO
