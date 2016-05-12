/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>   This is the script used to create the view [GRSHRYYYY].[dbo].[v02_AllCodedValues]                                    <<<<<     ***/
/***             (all new & formerly enetered values in wide format by country/year)                                                            ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
/*                                                                                                                                                */
/*  REFERENCE to 2015 appears JUST ONCE in the script                                                                                             */
/*                                                                                                                                                */
/**************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==> creating view [v02_AllCodedValues]                                                       --- '
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
ALTER VIEW     [v02_AllCodedValues]
AS



other select adding the new variable here...



  SELECT
          [Nation_fk]	
        , [Ctry_EditorialName]
        , [Question_Year]      = ''Year_'' + STR([Question_Year] , 4,0 )
        , [Q_Yr]               =                 [Question_Year]
          '
/*********************************************************     <<<<<  this has been the first part of the code                                  ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this section creates code corresponding to coded questions                ***/
DECLARE @CODEvar1 nvarchar(max)                           /***        declare variable for storing code during each data retreival              ***/
DECLARE @varname1 nvarchar(max)                           /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor  CURSOR FOR                              /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
SELECT      [WQA_std]                                     /*** >>>    select variable name (once since comes from the selection of questions    ***/
FROM        [WT_VNs]                                      /***        statement refered to the main source (of unique questions)                ***/
WHERE       [QClass] IN ( 'CODED', 'preyr' )              /*** <<<    filter questions to be selected and finalize select statement             ***/
/**************************************************************************************************************************************************/
OPEN             MyCursor                                 /*** >>>    open cursor by its name                                                   ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @varname1                                /***        store it into the corresponding variable(s)                               ***/
          WHILE  @@FETCH_STATUS = 0                       /***        while the status of the last retreival has been successful                ***/
BEGIN                                                     /*** >>     BEGIN the procedures using values of each row of the cursor               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
SET     @CODEvar1 =                                       /*** >      the code to be stored as string (for each row of the cursor) begins here: ***/
N'
        , '
          + @varname1 + '
                                  = CASE
                                         WHEN left('      + @varname1 + '
                                                                        , 4) = '''' THEN NULL
                                         ELSE CAST(left(' + @varname1 + '
                                                                        , 4)AS DECIMAL (12,2)) END
 '                                                        /*** <      the code to be stored as string ends here                                 ***/
/* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
set     @CODEmain = @CODEmain + @CODEvar1                 /***        this adds from 'CODEvar' to code already stored in 'CODEmain' (by row)    ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <<     ENDING of the procedures using values of each row of the cursor           ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @varname1                                /***        store it into the corresponding variable(s)                               ***/
           END                                            /***        and end when last row has been retreived                                  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
   CLOSE         MyCursor                                 /*** <<<    close cursor by its name                                                  ***/
DEALLOCATE       MyCursor                                 /*** <<<<   remove reference and relase from memory by cursor name                    ***/
/*********************************************************     <<<<<  this section has created code for coded questions                         ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this section creates code corresponding to numeric/count questions        ***/
DECLARE @CODEvar2 nvarchar(max)                           /***        declare variable for storing code during each data retreival              ***/
DECLARE @varname2 nvarchar(max)                           /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor  CURSOR FOR                              /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
SELECT      [WQA_std]                                     /*** >>>    select variable name (once since comes from the selection of questions    ***/
FROM        [WT_VNs]                                      /***        statement refered to the main source (of unique questions)                ***/
WHERE       [QClass] IN ( 'COUNT', 'PERSI' )              /*** <<<    filter questions to be selected and finalize select statement             ***/
/**************************************************************************************************************************************************/
OPEN             MyCursor                                 /*** >>>    open cursor by its name                                                   ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @varname2                                /***        store it into the corresponding variable(s)                               ***/
          WHILE  @@FETCH_STATUS = 0                       /***        while the status of the last retreival has been successful                ***/
BEGIN                                                     /*** >>     BEGIN the procedures using values of each row of the cursor               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
SET     @CODEvar2 =                                       /*** >      the code to be stored as string (for each row of the cursor) begins here: ***/
N'
        , '
          + @varname2 + '
                                  = CAST( ' + @varname2 + '
                                                          AS DECIMAL (12,2))
 '                                                        /*** <      the code to be stored as string ends here                                 ***/
/* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
set     @CODEmain = @CODEmain + @CODEvar2                 /***        this adds from 'CODEvar' to code already stored in 'CODEmain' (by row)    ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <<     ENDING of the procedures using values of each row of the cursor           ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @varname2                                /***        store it into the corresponding variable(s)                               ***/
           END                                            /***        and end when last row has been retreived                                  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
   CLOSE         MyCursor                                 /*** <<<    close cursor by its name                                                  ***/
DEALLOCATE       MyCursor                                 /*** <<<<   remove reference and relase from memory by cursor name                    ***/
/*********************************************************     <<<<<  this section has created code for numeric/count questions                 ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this section creates code corresponding to descriptive texts              ***/
DECLARE @CODEvar3 nvarchar(max)                           /***        declare variable for storing code during each data retreival              ***/
DECLARE @varname3 nvarchar(max)                           /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor  CURSOR FOR                              /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
SELECT      [WQA_std]                                     /*** >>>    select variable name (once since comes from the selection of questions    ***/
FROM        [WT_VNs]                                      /***        statement refered to the main source (of unique questions)                ***/
WHERE       [QClass] IN ( 'DESCR' )                       /*** <<<    filter questions to be selected and finalize select statement             ***/
/**************************************************************************************************************************************************/
OPEN             MyCursor                                 /*** >>>    open cursor by its name                                                   ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @varname3                                /***        store it into the corresponding variable(s)                               ***/
          WHILE  @@FETCH_STATUS = 0                       /***        while the status of the last retreival has been successful                ***/
BEGIN                                                     /*** >>     BEGIN the procedures using values of each row of the cursor               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
SET     @CODEvar3 =                                       /*** >      the code to be stored as string (for each row of the cursor) begins here: ***/
N'
        , ' + @varname3 + '
 '                                                        /*** <      the code to be stored as string ends here                                 ***/
/* -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - */
set     @CODEmain = @CODEmain + @CODEvar3                 /***        this adds from 'CODEvar' to code already stored in 'CODEmain' (by row)    ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <<     ENDING of the procedures using values of each row of the cursor           ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @varname3                                /***        store it into the corresponding variable(s)                               ***/
           END                                            /***        and end when last row has been retreived                                  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
   CLOSE         MyCursor                                 /*** <<<    close cursor by its name                                                  ***/
DEALLOCATE       MyCursor                                 /*** <<<<   remove reference and relase from memory by cursor name                    ***/
/*********************************************************     <<<<<  this section has created code for numeric/count questions                 ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
                                                          /*** >>>                                                                              ***/
/*********************************************************     >>>>>  this adds the final part of the code                                      ***/
set     @CODEmain = @CODEmain 
+ N'
                    from ( '
                                                          /*** >>>    this is the first section of the final part of the code to be executed    ***/
+ N'
SELECT
       [Nation_fk]
      ,[Ctry_EditorialName]
      ,[Question_Year]
'                                                         /*** <<<<<  this completes the first section of the final part of the code            ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the second section of the final part of the code to be executed   ***/
+
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
    (        SELECT ', ' + [WQA_std]                      /*** >      Begin selection (into text, in a cell, comma delimited list: add string)  ***/
               FROM [WT_VNs]                              /***        from previously filtered ('CODED'/'COUNT'/'PERSI') questions              ***/
             FOR XML PATH('')           )                 /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <<<<<  this completes the second section of the final part of the code           ***/
/**************************************************************************************************************************************************/
                                                          /*** >>>>>  this is the third section of the final part of the code to be executed    ***/
+ N'
 FROM [GRSH_C]
 WHERE [Question_Year] < (SELECT MAX([Question_Year]) FROM [AllLongData])

UNION ALL

SELECT
       [Nation_fk]
      ,[Ctry_EditorialName]
      ,[Question_Year]
'                                                         /*** <<<<<  this completes the third section of the final part of the code            ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the fourth section of the final part of the code to be executed   ***/
+
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
    (        SELECT ', ' + [WQA_std]                      /*** >      Begin selection (into text, in a cell, comma delimited list: add string)  ***/
               FROM [WT_VNs]                              /***        from previously filtered ('CODED'/'COUNT'/'PERSI') questions              ***/
             FOR XML PATH('')           )                 /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+ N'
 FROM [v01_EnteredValues]  ) EV
'                                                         /*** <<<<<  this completes the fourth section of the final part of the code           ***/
/**************************************************************************************************************************************************/
/*********************************************************     <<<<<  this added the final part of the code                                     ***/
/**************************************************************************************************************************************************/
/*********************************************************     <<<<<< this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
