/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This script adds row(s) to the table [forum_ResAnal]..[vi_xCountRows_of_AllViews]                                                 <<<<<     ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
INSERT
INTO
       [forum_ResAnal].[dbo].[vi_xxCountRows_of_AllViews]
 /* 23 */               SELECT [C] = (SELECT COUNT(*) FROM   forum_ResAnal..[vi_Both_Svy&Rstr_Yr&Q&A_Displayable]             )
                              ,[T] =                        'forum_ResAnal..[vi_Both_Svy&Rstr_Yr&Q&A_Displayable]'
 /* 24 */     UNION ALL SELECT [C] = (SELECT COUNT(*) FROM   forum_ResAnal..[vi_Restrictions_Yr&Q&A_Displayable]              )
                              ,[T] =                        'forum_ResAnal..[vi_Restrictions_Yr&Q&A_Displayable]'
 /* 25 */     UNION ALL SELECT [C] = (SELECT COUNT(*) FROM   forum_ResAnal..[vi_Survey_Yr&Q&A_Displayable]                    )
                              ,[T] =                        'forum_ResAnal..[vi_Survey_Yr&Q&A_Displayable]'
 /* 26 */     UNION ALL SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_Restrictions_Q&Yr_Displayable]                )
                              ,[T] =                        'forum.        .[vi_Restrictions_Q&Yr_Displayable]'
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi10_vi_Both_Svy&Rstr_Yr&Q&A_&_RstrQ&Yr_Displayable.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO

