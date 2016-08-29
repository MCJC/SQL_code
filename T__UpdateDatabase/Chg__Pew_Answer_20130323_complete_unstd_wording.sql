-- Answers by country having missing text (non-zero value)
----> Text should be added later and both answer & nation-answer keys be reassigned.

                      SELECT  
                               --distinct
                              KN.[Nation_answer_pk]
                            , KN.[Answer_fk]
                            , KN.[Nation_fk]
                            , KN.[display]
                            ,  Q.[Question_Year]
                            ,  Q.[Question_abbreviation_std]
                            ,  Q.[Question_short_wording_std]
                            ,  A.[Answer_pk]
                            ,  A.[Answer_value]
                            ,  A.[Answer_wording]
                            ,  A.[answer_wording_std]
                            ,  A.[Question_fk]
                        FROM
                             [forum].[dbo].[Pew_Answer]            A
                      LEFT OUTER JOIN
                             [forum].[dbo].[Pew_Nation_Answer]     KN
                        ON     A.[Answer_pk]
                            = KN.[Answer_fk]
                      LEFT OUTER JOIN
                             [forum].[dbo].[Pew_Question]          Q
                        ON     A.[Question_fk]
                            =  Q.[Question_pk]
                      WHERE
                               A.Answer_pk   IN (
                                                    3475
                                                  , 3517
                                                  , 3877
                                                  , 3922
                                                  , 10354
                                                  , 10499
                                                  , 10610
                                                  , 10649
                                                  , 10798
                                                  , 10812
                                                  , 13816
                                                  , 13854
                                                  , 14062
                                                          )
                          OR
                               A.Answer_pk   IN (
                                                   7235
                                                 , 8298
                                                 , 8047
                                                 , 7211
                                                 , 7013
                                                 , 10273
                                                 , 13207
                                                 , 7418
                                                          )
order by 
                               Q.[Question_abbreviation_std]
                            ,  Q.[Question_Year]
                            , KN.[Nation_fk]
                            ,  A.[Answer_value]
