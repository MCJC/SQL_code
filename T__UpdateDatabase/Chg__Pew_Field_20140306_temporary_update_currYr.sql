----------------------------------------------------------------------------------------------------------------------------
USE              [forum]
GO
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
/*****                                           BackUp  current Table(s)                                             *****/
/**************************************************************************************************************************/
DECLARE @CrDt    varchar( 8)
SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT *
                INTO  [_bk_forum].[dbo].[Pew_Field_' + @CrDt + '_before_updating_currYR]
                FROM      [forum].[dbo].[Pew_Field]'                                     )
/**************************************************************************************************************************/
UPDATE [Pew_Field]
SET     Field_year = '2010'
WHERE   Field_name = 'Current_pop'
GO