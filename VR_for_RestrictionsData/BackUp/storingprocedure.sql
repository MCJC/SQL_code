USE [GRSHR2016]
GO

/****** Object:  StoredProcedure [dbo].[uspGetAddress]    Script Date: 08/05/2015 09:01:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





USE [master]
GO



alter PROCEDURE [dbo].[sp_uspGetAddress]
AS

go

use GRSHR2016

GO
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
USE [GRSHR' + @CrY + '];
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/

GO
use GRSHR2016

GO


CREATE SYNONYM WKRESTRDB
FOR GRSHR2016;
GO

USE [WKRESTRDB]