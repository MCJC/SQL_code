/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>         This is the script used to recreate lookup tables in the database  [GRSHR_admin]                               <<<<<     ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
USE [GRSHR_admin]
GO
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  cursor                                                                    ***/
DECLARE @CODEmain1 nvarchar(max)                          /***        declare variable for storing code during each data retreival              ***/
DECLARE @tablename nvarchar(max)                          /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor   CURSOR FOR                             /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
SELECT      [TABLE_NAME]                                  /*** >>>    select table names                                                        ***/
FROM        [INFORMATION_SCHEMA].[TABLES]                 /***        from the system view listing tables & views in the database               ***/
WHERE       [TABLE_TYPE] =    'BASE TABLE'                /*** <<<    filter to display only tables (excluding views)                           ***/
  AND  (    [TABLE_NAME] LIKE 'EnteredData_%'             /*** <<<    filter to display only selected tables (following name pattern)           ***/
         OR [TABLE_NAME] LIKE 'Index_by_%'                /*** <<<    filter to display only selected tables (following name pattern)           ***/
         OR [TABLE_NAME] LIKE 'AllData_%'           )     /*** <<<    filter to display only selected tables (following name pattern)           ***/


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
N'
       DROP TABLE [' + @tablename + ']
 '                                                        /*** <      the code to be stored as string ends here                                 ***/
PRINT  (@CODEmain1)                                       /***        display the currently stored code (to be executed)                        ***/
EXEC   (@CODEmain1)                                       /***        execute the code that has been stored as text                             ***/
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
/**************************************************************************************************************************************************/
DECLARE @CrDt      varchar(8)                             /***        declare variable for storing current date as YYYYMMDD                     ***/
SET     @CrDt      = (CONVERT(VARCHAR(8),GETDATE(),112))  /***        set variable value as current date (YYYYMMDD)                             ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
          SELECT *
                 INTO    [GRSHR_admin].[dbo].[EnteredData_long_wkv_not_loaded_yet_in_DB]
                 FROM  [forum_ResAnal].[dbo].[vr_01w_DB_Long_NoAggregated]
EXEC ( ' SELECT *
                 INTO    [GRSHR_admin].[dbo].[EnteredData_long_wkv_not_loaded_yet_in_DB_' + @CrDt + '_BackUp]
                 FROM  [forum_ResAnal].[dbo].[vr_01w_DB_Long_NoAggregated]'                                  )
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
          SELECT *
                 INTO    [GRSHR_admin].[dbo].[Index_by_CtryRegion&Yr_wkv_not_loaded_yet_in_DB]
                 FROM  [forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]
EXEC ( ' SELECT *
                 INTO    [GRSHR_admin].[dbo].[Index_by_CtryRegion&Yr_wkv_not_loaded_yet_in_DB_' + @CrDt + '_BackUp]
                 FROM  [forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]'                   )
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
          SELECT *
                 INTO    [GRSHR_admin].[dbo].[AllData_workversion_not_loaded_yet_in_DB]
                 FROM  [forum_ResAnal].[dbo].[vr_05w_SemiWide_by_Ctry&Year]
EXEC ( ' SELECT *
                 INTO    [GRSHR_admin].[dbo].[AllData_workversion_not_loaded_yet_in_DB_' + @CrDt + ']
                 FROM  [forum_ResAnal].[dbo].[vr_05w_SemiWide_by_Ctry&Year]'                                  )
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
          SELECT *
                 INTO    [GRSHR_admin].[dbo].[AllData_longversion_not_loaded_yet_in_DB]
                 FROM  [forum_ResAnal].[dbo].[vr_06w_LongData_ALL]
EXEC ( ' SELECT *
                 INTO    [GRSHR_admin].[dbo].[AllData_longversion_not_loaded_yet_in_DB_' + @CrDt + ']
                 FROM  [forum_ResAnal].[dbo].[vr_06w_LongData_ALL]'                                  )
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
