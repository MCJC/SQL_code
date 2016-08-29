/**************************************************************************************************************************/
/*****                                              BackUp current Table                                              *****/
/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT *
                INTO  [_bk_forum].[dbo].[Pew_Field_' + @CrDt + ']
                FROM      [forum].[dbo].[Pew_Field]'               )
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
/*** add GRSHR index values reference for 2013 data ***********************************************************************/
INSERT INTO [forum]..[Pew_Field]
  VALUES
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+1, 'GRI2013', NULL, 'GRI', '2013', 3),
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+2, 'SHI2013', NULL, 'SHI', '2013', 3),
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+3, 'GFI2013', NULL, 'GFI', '2013', 3)
/**************************************************************************************************************************/


/**************************************************************************************************************************/
/*****                                                    STEP 002                                                    *****/
/**************************************************************************************************************************/
-- check results
SELECT * FROM [Pew_Field]
WHERE         [Field_type] IN ( 'GRI', 'SHI', 'GFI')
/**************************************************************************************************************************/
