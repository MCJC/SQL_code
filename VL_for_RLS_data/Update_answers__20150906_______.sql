USE [RLS]
GO
/**************************************************************************************************************************/
/*****                                              BackUp current Table                                              *****/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)                                                 /* declare variable to store current date  */
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                          /* store date in format YYYYMMDD           */
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC                                                                           /* exec statement to run string s script   */
     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Answer_Std_' + @CrDt + 'RLS]
                  FROM                   [Pew_Answer_Std]'               )     /* select into backup from current table   */
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                 numeric values                                                 *****/
/**************************************************************************************************************************/

UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 0  
WHERE Answer_Std_pk  = 10475 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 1  
WHERE Answer_Std_pk  = 10474 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 3  
WHERE Answer_Std_pk  = 10528 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 2  
WHERE Answer_Std_pk  = 10529 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 6  
WHERE Answer_Std_pk  = 10548 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 5  
WHERE Answer_Std_pk  = 10549 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 4  
WHERE Answer_Std_pk  = 10550 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 3  
WHERE Answer_Std_pk  = 10551 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 2  
WHERE Answer_Std_pk  = 10552 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_value_std  = 1  
WHERE Answer_Std_pk  = 10553 ;



/**************************************************************************************************************************/
/*****                                                  text strings                                                  *****/
/**************************************************************************************************************************/

UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = 'Does more good than harm'  
WHERE Answer_Std_pk  = 10447 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = 'Neither/both equally'  
WHERE Answer_Std_pk  = 10448 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = ' Don''t know'  
WHERE Answer_Std_pk  = 10471 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = 'At least daily'  
WHERE Answer_Std_pk  = 10486 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = 'Weekly'  
WHERE Answer_Std_pk  = 10487 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = 'Monthly'  
WHERE Answer_Std_pk  = 10488 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = 'Seldom/never'  
WHERE Answer_Std_pk  = 10489 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = 'Don''t know'  
WHERE Answer_Std_pk  = 10490 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = 'Independent/no lean'  
WHERE Answer_Std_pk  = 10529 ;
UPDATE [RLS]..[Pew_Answer_Std]
SET Answer_Wording_std  = 'Evolved: due to natural process'  
WHERE Answer_Std_pk  = 10540 ;

/**************************************************************************************************************************/
/**************************************************************************************************************************/
SELECT *
  FROM [RLS].[dbo].[Displayable_NewWideVersion]
where 
RLSx0_001_main_ID
in
(
 'ID2007000001'
,'ID2007000002'
,'ID2014000001'
,'ID2014000002'
)

/**************************************************************************************************************************/
/**************************************************************************************************************************/
