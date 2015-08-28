-- in Mar 01, 2013:
/*********************************************************************************************************/
SELECT *
  INTO [_bk_forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value_2013_03_01]
  FROM     [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
/*********************************************************************************************************/
-- Update Display for 2010 as follows:

UPDATE
             [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
SET
             [Display]
         =   0
WHERE      Field_fk	          =  28
  AND      Sex_fk            !=   0
  AND      Age_fk            !=   0
  AND      Nation_fk          = 174
  AND      Religion_Group_fk  =  57
-----------------------------------------------------------------------------------------------------------
-- check results:
SELECT 
       distinct *
  FROM
             [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
WHERE
           Display     = 0
  AND      Field_fk	   =  28
  AND      Nation_fk   = 174
  AND      Religion_Group_fk  =  57

ORDER BY
           Field_fk
        ,  Sex_fk
        ,  Age_fk

/*********************************************************************************************************/
