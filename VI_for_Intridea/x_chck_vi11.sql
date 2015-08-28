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
 /* 27 */               SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_Restrictions_byCtryYr]                        )
                              ,[T] =                        'forum.        .[vi_Restrictions_byCtryYr]'
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi11_vi_Restrictions_byCtryYr.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO
