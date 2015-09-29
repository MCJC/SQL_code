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


/***************************************************************************************************************************************/
/*****                                                        text strings                                                        *****/
/**************************************************************************************************************************************/

UPDATE [RLS]..[Pew_Answer_Std]
SET [Answer_Wording_std]  = LTRIM(RTRIM([Answer_Wording_std]))

/**************************************************************************************************************************************/

UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10458 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10459 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10476 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10477 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10478 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10479 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10491 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10492 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10493 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10540 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10541 ;
UPDATE [RLS]..[Pew_Answer_Std]   SET [Answer_Wording_std]  = REPLACE([Answer_Wording_std], ':', ';')   WHERE Answer_Std_pk  = 10542 ;

/**************************************************************************************************************************************/

UPDATE [RLS]..[Pew_Question_Std]
SET [Question_wording_std]  = LTRIM(RTRIM([Question_wording_std]))

UPDATE [RLS]..[Pew_Question_Std]
SET [Question_short_wording_std]  = LTRIM(RTRIM([Question_short_wording_std]))

/**************************************************************************************************************************************/

UPDATE [RLS]..[Pew_Question_Std]   SET Question_Wording_std  = 'Frequency of Feeling Spiritual Peace and Wellbeing'                                  WHERE Question_Std_pk  = 101 ;
UPDATE [RLS]..[Pew_Question_Std]   SET Question_Wording_std  = 'Frequency of Feeling Wonder about the Universe'                                      WHERE Question_Std_pk  = 102 ;
UPDATE [RLS]..[Pew_Question_Std]   SET Question_Wording_std  = 'Interpreting Scripture'                                                              WHERE Question_Std_pk  = 99 ;
UPDATE [RLS]..[Pew_Question_Std]   SET Question_Wording_std  = 'Belief in Absolute Standards for Right and Wrong'                                    WHERE Question_Std_pk  = 90 ;
UPDATE [RLS]..[Pew_Question_Std]   SET Question_Wording_std  = 'Views about Environmental Regulation'                                                WHERE Question_Std_pk  = 89 ;
UPDATE [RLS]..[Pew_Question_Std]   SET Question_Wording_std  = 'Views about Same-Sex Marriage'                                                       WHERE Question_Std_pk  = 110 ;
UPDATE [RLS]..[Pew_Question_Std]   SET Question_Wording_std  = 'Frequency of Participation in Prayer, Scripture Study or Religious Education Groups' WHERE Question_Std_pk  = 106 ;

/**************************************************************************************************************************************/

UPDATE [RLS]..[Pew_Question_Std] SET Question_short_Wording_std ='Frequency of Feeling Spiritual Peace and Wellbeing'                                  WHERE Question_Std_pk = 101 ;
UPDATE [RLS]..[Pew_Question_Std] SET Question_short_Wording_std ='Frequency of Feeling Wonder about the Universe'                                      WHERE Question_Std_pk = 102 ;
UPDATE [RLS]..[Pew_Question_Std] SET Question_short_Wording_std ='Interpreting Scripture'                                                              WHERE Question_Std_pk = 99 ;
UPDATE [RLS]..[Pew_Question_Std] SET Question_short_Wording_std ='Belief in Absolute Standards for Right and Wrong'                                    WHERE Question_Std_pk = 90 ;
UPDATE [RLS]..[Pew_Question_Std] SET Question_short_Wording_std ='Views about Environmental Regulation'                                                WHERE Question_Std_pk = 89 ;
UPDATE [RLS]..[Pew_Question_Std] SET Question_short_Wording_std ='Views about Same-Sex Marriage'                                                       WHERE Question_Std_pk = 110 ;
UPDATE [RLS]..[Pew_Question_Std] SET Question_short_Wording_std ='Frequency of Participation in Prayer, Scripture Study or Religious Education Groups' WHERE Question_Std_pk = 106 ;

/**************************************************************************************************************************************/

UPDATE [RLS]..[Pew_Question_Std]   SET Question_Wording_std         = 'Frequency of Meditation' WHERE [Question_abbreviation_std] = 'RLSx5_214_meditate4cat'
UPDATE [RLS]..[Pew_Question_Std]   SET [Question_short_wording_std] = 'Frequency of Meditation' WHERE [Question_abbreviation_std] = 'RLSx5_214_meditate4cat'

/**************************************************************************************************************************************/
