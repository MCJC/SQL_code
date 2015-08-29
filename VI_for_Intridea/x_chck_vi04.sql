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
 /* 16 */               SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_MedianAge]                                    )
                              ,[T] =                        'forum.        .[vi_MedianAge]'
 /* 17 */     UNION ALL SELECT [C] = (SELECT COUNT(*) FROM   forum_ResAnal..[vi_MedianAge]                                    )
                              ,[T] =                        'forum_ResAnal..[vi_MedianAge]'
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi04_vi_MedianAge.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO