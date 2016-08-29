/**************************************************************************************************************************/
USE       [forum]
GO

/**************************************************************************************************************************/
/*****                                              BackUp current Table                                              *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  DECLARE                          --  declare variable
          @TofI                    --  variable name
                   varchar(50)     --  data type of the variable
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT *
                INTO  [_bk_forum].[dbo].[Pew_Nation_Religion_Fertility_Value_' + @CrDt + ']
                FROM      [forum].[dbo].[Pew_Nation_Religion_Fertility_Value]' )
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/


/**************************************************************************************************************************/
-- On August 15, Conrad:
-- The high TFR value for other religions in Kazakhstan looks suspect.
-- Please adjust the filter so this value is not displayed.
-- Anne (August 18, 2014 9:43 AM)
-- 63 changes

UPDATE [Pew_Nation_Religion_Fertility_Value]
   SET [Display] = 0
-- select * from [Pew_Nation_Religion_Fertility_Value]
 WHERE      [Nation_fk]         = 105
   AND      [Religion_Group_fk] = 55   
   AND      [Notes]	            = 'Projected data by Pew/IIASA'
   AND      [Display]           = 1
GO
/**************************************************************************************************************************/
