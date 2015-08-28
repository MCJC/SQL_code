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
-- Conrad asks us to change fertility display rules for Hindus and Buddhists in US and North America
-- from “display” to “not display”. 
-- Anne (August 11, 2014 11:02 AM)

UPDATE [Pew_Nation_Religion_Fertility_Value]
   SET [Display] = 0
-- select * from [Pew_Nation_Religion_Fertility_Value]
 WHERE      [Nation_fk]         = 221
   AND (    [Religion_Group_fk] = 26 
         OR [Religion_Group_fk] = 27   )
   AND      [Notes]	            = 'Projected data by Pew/IIASA'
   AND      [Display]           = 1
GO
/**************************************************************************************************************************/
