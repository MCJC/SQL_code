USE [RLS]
GO


/****************************************************************************************************************************************************************************/
/*****                                                                         Pew_Question_Std                                                                         *****/
/*****                                                                       BackUp current Table                                                                       *****/
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)                                                            /* declare variable to store current date                                         */
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                                     /* store date in format YYYYMMDD                                                  */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
EXEC                                                                                      /* exec statement to run string s script                                          */
     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Question_Std_' + @CrDt + 'RLS]'             /* select into backup                                                             */
         + '      FROM                   [Pew_Question_Std]'               )              /* select into backup from current table                                          */
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/
/*****                                                                          -> U P D A T E                                                                          *****/
/*****                                                         notice:  this UPDATES questions previously added                                                         *****/
/****************************************************************************************************************************************************************************/
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Parents of Children Under 18'                                              WHERE [Question_Std_pk] = 95
UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Frequency of Feeling Spiritual Peace and Well-being'                       WHERE [Question_Std_pk] = 101
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/****************************************************************************************************************************************************************************/
SELECT * FROM [Questio&Answer_wordings]
        WHERE [Question_Std_fk]        IN (          /* check results in modified table         */
                                            95       /* check results in modified table         */
                                           ,101      /* check results in modified table         */
                                                  )  /* check results in modified table         */
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/



/****************************************************************************************************************************************************************************/
/*****                                                                          Pew_Answer_Std                                                                          *****/
/*****                                                                       BackUp current Table                                                                       *****/
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)                                                            /* declare variable to store current date                                         */
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                                     /* store date in format YYYYMMDD                                                  */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
EXEC                                                                                      /* exec statement to run string s script                                          */
     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Answer_Std_' + @CrDt + 'RLS]'               /* select into backup                                                             */
         + '      FROM                   [Pew_Answer_Std]'               )                /* select into backup from current table                                          */
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/
/*****                                                                          -> U P D A T E                                                                          *****/
/*****                                                          notice:  this UPDATES answers previously added                                                          *****/
/****************************************************************************************************************************************************************************/
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Other/mixed race'                                                                    WHERE [Answer_Std_pk] = 10142
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Postgraduate degree'                                                                 WHERE [Answer_Std_pk] = 10044
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Non-parents'                                                                         WHERE [Answer_Std_pk] = 10474
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Parents'                                                                             WHERE [Answer_Std_pk] = 10475
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Believe in God; don''t know how certain'                                             WHERE [Answer_Std_pk] = 10479
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Believe in heaven'                                                                   WHERE [Answer_Std_pk] = 10511
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Don''t believe in heaven'                                                            WHERE [Answer_Std_pk] = 10512
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Believe in hell'                                                                     WHERE [Answer_Std_pk] = 10514
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Don''t believe in hell'                                                              WHERE [Answer_Std_pk] = 10515
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Greatest (born before 1928)'                                                         WHERE [Answer_Std_pk] = 10548
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Silent (born 1928-1945)'                                                             WHERE [Answer_Std_pk] = 10549
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Baby Boomer (born 1946-1964)'                                                        WHERE [Answer_Std_pk] = 10550
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Generation X (born 1965-1980)'                                                       WHERE [Answer_Std_pk] = 10551
UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Older Millennial (born 1981-1989)'                                                   WHERE [Answer_Std_pk] = 10552
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/****************************************************************************************************************************************************************************/
SELECT * FROM [Questio&Answer_wordings]
        WHERE [Answer_Std_fk]        IN (               /* check results in modified table         */
                                            10142       /* check results in modified table         */
                                           ,10044       /* check results in modified table         */
                                           ,10474       /* check results in modified table         */
                                           ,10475       /* check results in modified table         */
                                           ,10479       /* check results in modified table         */
                                           ,10511       /* check results in modified table         */
                                           ,10512       /* check results in modified table         */
                                           ,10514       /* check results in modified table         */
                                           ,10515       /* check results in modified table         */
                                           ,10548       /* check results in modified table         */
                                           ,10549       /* check results in modified table         */
                                           ,10550       /* check results in modified table         */
                                           ,10551       /* check results in modified table         */
                                           ,10552       /* check results in modified table         */
                                                     )  /* check results in modified table         */
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/


