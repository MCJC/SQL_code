USE master;
GO
ALTER DATABASE GRSHR2016
Modify Name = GRSHRcode ;
GO



/*  First set the database to single user mode  */

ALTER DATABASE GRSHR2016
SET SINGLE_USER WITH ROLLBACK IMMEDIATE

Now we will try to rename the database

ALTER DATABASE dbName MODIFY NAME = dbNewName


Finally we will set the database to Multiuser mode


ALTER DATABASE GRSHRcode
SET MULTI_USER WITH ROLLBACK IMMEDIATE
 

Hope you are able to rename your database without any issues now!!!



/*********************************************************     >>>>>> extract year to be used                                                   ***/
/**************************************************************************************************************************************************/
DECLARE @CrY    varchar( 4)                               /***        declare variable for storing current YEAR (as text)                       ***/
SET     @CrY  =(SELECT STR(MAX(Question_Year)+3, 4,0)     /***        set value to current year ( coded yr + 1[yr to be coded[ + 1[current]     ***/
                FROM  [forum].[dbo].[Pew_Q&A]             /***        extracted frm Q&A lookup table                                            ***/
                WHERE [Pew_Data_Collection]               /***        filtering,,,                                                              ***/
                = 'Global Restriction on Religion Study') /***        restrictions data                                                         ***/
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the code to be executed                                           ***/
N'
CREATE DATABASE [GRSHR' + @CrY + '];
 ALTER DATABASE [GRSHR' + @CrY + '] SET RECOVERY SIMPLE 
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO


