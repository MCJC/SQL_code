USE [RLS]
GO
/****************************************************************************************************************************************************************************/
/*****                                                                         Pew_Question_Std                                                                         *****/
/*****                                                                       BackUp current Table                                                                       *****/
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)                                                            /* declare variable to store current date                                         */
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                                     /* store date in format YYYYMMDD                                                  */
--/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--EXEC                                                                                      /* exec statement to run strings script                                           */
--     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Question_Std_' + @CrDt + 'RLS]'             /* select into backup                                                             */
--         + '      FROM                   [Pew_Question_Std]'               )              /* select into backup from current table                                          */
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/
/*****                                                                          -> U P D A T E                                                                          *****/
/*****                                                         notice:  this UPDATES questions previously added                                                         *****/
/****************************************************************************************************************************************************************************/
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Census region'                                                                       WHERE [Question_Std_pk] = 1
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'State'                                                                               WHERE [Question_Std_pk] = 2
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Marital status'                                                                      WHERE [Question_Std_pk] = 19
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Age'                                                                                 WHERE [Question_Std_pk] = 64
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Household income'                                                                    WHERE [Question_Std_pk] = 66
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Sex'                                                                                 WHERE [Question_Std_pk] = 77
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Race and ethnicity'                                                                  WHERE [Question_Std_pk] = 81
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Education level'                                                                     WHERE [Question_Std_pk] = 82
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Metro area'                                                                          WHERE [Question_Std_pk] = 86
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Views about homosexuality'                                                           WHERE [Question_Std_pk] = 87
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Views about government aid to the poor'                                              WHERE [Question_Std_pk] = 88
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Views about environmental regulation'                                                WHERE [Question_Std_pk] = 89
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Belief in absolute standards for right and wrong'                                    WHERE [Question_Std_pk] = 90
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Views about size of government'                                                      WHERE [Question_Std_pk] = 91
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Sources of guidance on right and wrong'                                              WHERE [Question_Std_pk] = 92
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Importance of religion in one''s life'                                               WHERE [Question_Std_pk] = 93
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Educational distribution'                                                            WHERE [Question_Std_pk] = 94
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Parents of children under 18'                                                        WHERE [Question_Std_pk] = 95
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Attendance at religious services'                                                    WHERE [Question_Std_pk] = 97
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Frequency of prayer'                                                                 WHERE [Question_Std_pk] = 98
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Interpreting scripture'                                                              WHERE [Question_Std_pk] = 99
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Frequency of meditation'                                                             WHERE [Question_Std_pk] = 100
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Frequency of feeling spiritual peace and well-being'                                 WHERE [Question_Std_pk] = 101
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Frequency of feeling wonder about the universe'                                      WHERE [Question_Std_pk] = 102
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Belief in heaven'                                                                    WHERE [Question_Std_pk] = 103
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Belief in hell'                                                                      WHERE [Question_Std_pk] = 104
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Frequency of reading scripture'                                                      WHERE [Question_Std_pk] = 105
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Frequency of participation in prayer, scripture study or religious education groups' WHERE [Question_Std_pk] = 106
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Party affiliation'                                                                   WHERE [Question_Std_pk] = 107
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Political ideology'                                                                  WHERE [Question_Std_pk] = 108
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Views about abortion'                                                                WHERE [Question_Std_pk] = 109
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Views about same-sex marriage'                                                       WHERE [Question_Std_pk] = 110
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Views about human evolution'                                                         WHERE [Question_Std_pk] = 111
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Immigrant status'                                                                    WHERE [Question_Std_pk] = 112
--UPDATE [Pew_Question_Std] SET [Question_short_wording_std] = 'Generational cohort'                                                                 WHERE [Question_Std_pk] = 113
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/****************************************************************************************************************************************************************************/
--SELECT * FROM [Pew_Question]
--        WHERE [Question_Std_fk]        IN (          /* check results in modified table         */
--                                                                                1       /* modify row in selecteded table                         */
--                                                                             ,  2       /* modify row in selecteded table                         */
--                                                                             , 19       /* modify row in selecteded table                         */
--                                                                             , 64       /* modify row in selecteded table                         */
--                                                                             , 66       /* modify row in selecteded table                         */
--                                                                             , 77       /* modify row in selecteded table                         */
--                                                                             , 81       /* modify row in selecteded table                         */
--                                                                             , 82       /* modify row in selecteded table                         */
--                                                                             , 86       /* modify row in selecteded table                         */
--                                                                             , 87       /* modify row in selecteded table                         */
--                                                                             , 88       /* modify row in selecteded table                         */
--                                                                             , 89       /* modify row in selecteded table                         */
--                                                                             , 90       /* modify row in selecteded table                         */
--                                                                             , 91       /* modify row in selecteded table                         */
--                                                                             , 92       /* modify row in selecteded table                         */
--                                                                             , 93       /* modify row in selecteded table                         */
--                                                                             , 94       /* modify row in selecteded table                         */
--                                                                             , 95       /* modify row in selecteded table                         */
--                                                                             , 97       /* modify row in selecteded table                         */
--                                                                             , 98       /* modify row in selecteded table                         */
--                                                                             , 99       /* modify row in selecteded table                         */
--                                                                             ,100       /* modify row in selecteded table                         */
--                                                                             ,101       /* modify row in selecteded table                         */
--                                                                             ,102       /* modify row in selecteded table                         */
--                                                                             ,103       /* modify row in selecteded table                         */
--                                                                             ,104       /* modify row in selecteded table                         */
--                                                                             ,105       /* modify row in selecteded table                         */
--                                                                             ,106       /* modify row in selecteded table                         */
--                                                                             ,107       /* modify row in selecteded table                         */
--                                                                             ,108       /* modify row in selecteded table                         */
--                                                                             ,109       /* modify row in selecteded table                         */
--                                                                             ,110       /* modify row in selecteded table                         */
--                                                                             ,111       /* modify row in selecteded table                         */
--                                                                             ,112       /* modify row in selecteded table                         */
--                                                                             ,113       /* modify row in selecteded table                         */
--                                                  )  /* check results in modified table         */
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/



/****************************************************************************************************************************************************************************/
/*****                                                                          Pew_Answer_Std                                                                          *****/
/*****                                                                       BackUp current Table                                                                       *****/
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)                                                            /* declare variable to store current date                                         */
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                                     /* store date in format YYYYMMDD                                                  */
--/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--EXEC                                                                                      /* exec statement to run string s script                                          */
--     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Answer_Std_' + @CrDt + 'RLS]'               /* select into backup                                                             */
--         + '      FROM                   [Pew_Answer_Std]'               )                /* select into backup from current table                                          */
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/
/*****                                                                          -> U P D A T E                                                                          *****/
/*****                                                          notice:  this UPDATES answers previously added                                                          *****/
/****************************************************************************************************************************************************************************/
--/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Don''t know/refused'                                                                 WHERE [Answer_Std_pk] = 10441
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Other/mixed race'                                                                    WHERE [Answer_Std_pk] = 10142
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Postgraduate degree'                                                                 WHERE [Answer_Std_pk] = 10044
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Atlanta metro area'                                                                  WHERE [Answer_Std_pk] = 10224
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Boston metro area'                                                                   WHERE [Answer_Std_pk] = 10225
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Chicago metro area'                                                                  WHERE [Answer_Std_pk] = 10226
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Washington, D.C., metro area'                                                        WHERE [Answer_Std_pk] = 10227
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Dallas/Fort Worth metro area'                                                        WHERE [Answer_Std_pk] = 10228
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Detroit metro area'                                                                  WHERE [Answer_Std_pk] = 10229
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Houston metro area'                                                                  WHERE [Answer_Std_pk] = 10230
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Los Angeles metro area'                                                              WHERE [Answer_Std_pk] = 10231
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Miami metro area'                                                                    WHERE [Answer_Std_pk] = 10232
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Minneapolis/St. Paul metro area'                                                     WHERE [Answer_Std_pk] = 10233
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'New York City metro area'                                                            WHERE [Answer_Std_pk] = 10234
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Philadelphia metro area'                                                             WHERE [Answer_Std_pk] = 10235
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Phoenix metro area'                                                                  WHERE [Answer_Std_pk] = 10236
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Riverside, Calif., metro area'                                                       WHERE [Answer_Std_pk] = 10237
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'San Diego metro area'                                                                WHERE [Answer_Std_pk] = 10238
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'San Francisco metro area'                                                            WHERE [Answer_Std_pk] = 10239
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Seattle metro area'                                                                  WHERE [Answer_Std_pk] = 10240
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Baltimore metro area'                                                                WHERE [Answer_Std_pk] = 10554
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Pittsburgh metro area'                                                               WHERE [Answer_Std_pk] = 10555
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Providence metro area'                                                               WHERE [Answer_Std_pk] = 10556
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'St. Louis metro area'                                                                WHERE [Answer_Std_pk] = 10557
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Tampa metro area'                                                                    WHERE [Answer_Std_pk] = 10558
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Believe in God; don''t know how certain'                                             WHERE [Answer_Std_pk] = 10479
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Believe in heaven'                                                                   WHERE [Answer_Std_pk] = 10511
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Don''t believe in heaven'                                                            WHERE [Answer_Std_pk] = 10512
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Believe in hell'                                                                     WHERE [Answer_Std_pk] = 10514
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Don''t believe in hell'                                                              WHERE [Answer_Std_pk] = 10515
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Strongly oppose/oppose'                                                              WHERE [Answer_Std_pk] = 10538
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Greatest (born before 1928)'                                                         WHERE [Answer_Std_pk] = 10548
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Silent (born 1928-1945)'                                                             WHERE [Answer_Std_pk] = 10549
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Baby Boomer (born 1946-1964)'                                                        WHERE [Answer_Std_pk] = 10550
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Generation X (born 1965-1980)'                                                       WHERE [Answer_Std_pk] = 10551
--UPDATE [Pew_Answer_Std] SET [Answer_Wording_std] = 'Older Millennial (born 1981-1989)'                                                   WHERE [Answer_Std_pk] = 10552
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/****************************************************************************************************************************************************************************/
--SELECT * FROM [Pew_Answer]
--        WHERE [Answer_Std_fk]        IN (                                                 /* check results in modified table                        */
--                                                                              10441       /* modify row in selecteded table                         */
--                                                                             ,10142       /* modify row in selecteded table                         */
--                                                                             ,10044       /* modify row in selecteded table                         */
--                                                                             ,10224       /* modify row in selecteded table                         */
--                                                                             ,10225       /* modify row in selecteded table                         */
--                                                                             ,10226       /* modify row in selecteded table                         */
--                                                                             ,10227       /* modify row in selecteded table                         */
--                                                                             ,10228       /* modify row in selecteded table                         */
--                                                                             ,10229       /* modify row in selecteded table                         */
--                                                                             ,10230       /* modify row in selecteded table                         */
--                                                                             ,10231       /* modify row in selecteded table                         */
--                                                                             ,10232       /* modify row in selecteded table                         */
--                                                                             ,10233       /* modify row in selecteded table                         */
--                                                                             ,10234       /* modify row in selecteded table                         */
--                                                                             ,10235       /* modify row in selecteded table                         */
--                                                                             ,10236       /* modify row in selecteded table                         */
--                                                                             ,10237       /* modify row in selecteded table                         */
--                                                                             ,10238       /* modify row in selecteded table                         */
--                                                                             ,10239       /* modify row in selecteded table                         */
--                                                                             ,10240       /* modify row in selecteded table                         */
--                                                                             ,10554       /* modify row in selecteded table                         */
--                                                                             ,10555       /* modify row in selecteded table                         */
--                                                                             ,10556       /* modify row in selecteded table                         */
--                                                                             ,10557       /* modify row in selecteded table                         */
--                                                                             ,10558       /* modify row in selecteded table                         */
--                                                                             ,10479       /* modify row in selecteded table                         */
--                                                                             ,10511       /* modify row in selecteded table                         */
--                                                                             ,10512       /* modify row in selecteded table                         */
--                                                                             ,10514       /* modify row in selecteded table                         */
--                                                                             ,10515       /* modify row in selecteded table                         */
--                                                                             ,10538       /* modify row in selecteded table                         */
--                                                                             ,10548       /* modify row in selecteded table                         */
--                                                                             ,10549       /* modify row in selecteded table                         */
--                                                                             ,10550       /* modify row in selecteded table                         */
--                                                                             ,10551       /* modify row in selecteded table                         */
--                                                                             ,10552       /* modify row in selecteded table                         */
--                                                     )  /* check results in modified table         */
--ORDER BY   [AnswerSet_num]
--          ,[Answer_Std_fk]
--          ,[Answer_value_std]
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--SELECT 
--        DISTINCT
--       [Answer_Std_fk]
--      ,[AnswerSet_num]
--      ,[Answer_Wording_std]
--      ,[Answer_Wording]
--      ,[Full_set_of_Answers]
--      ,[NA_by_set_of_Answers]
--  FROM [RLS].[dbo].[Pew_Answer]
--        WHERE [Answer_Wording]      LIKE '%t know/Refused%'
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/


