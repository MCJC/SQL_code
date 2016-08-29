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
-- On November 05, 2014
-- Fengyan:
-- We need to change the display guideline for Burkina Faso – not to display for unaffiliated and “other religions”.
-- (previously Conrad:
-- I think we shouldn't show either the unaffiliated or the other religion values for Burkina Faso - would you agree?

-- 126 changes

UPDATE [Pew_Nation_Religion_Fertility_Value]
   SET [Display] = 0
-- select * from [Pew_Nation_Religion_Fertility_Value]
WHERE      [Nation_fk]          = 32
   AND      [Religion_Group_fk] in (55, 57)   
   AND      [Notes]              = 'Projected data by Pew/IIASA'
   AND      [Display]            = 1
GO
/**************************************************************************************************************************/

