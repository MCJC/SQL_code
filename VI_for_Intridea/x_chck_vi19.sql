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
 /* 41 */               SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_Restrictions_Tables_by_region&world]          )
                              ,[T] =                        'forum.        .[vi_Restrictions_Tables_by_region&world]'
 /* 42 */     UNION ALL SELECT [C] = (SELECT COUNT(*) FROM   forum_ResAnal..[vi_Restrictions_Tables_by_region&world]          )
                              ,[T] =                        'forum_ResAnal..[vi_Restrictions_Tables_by_region&world]'
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi19_vi_Restrictions_Tables_by_region&world.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO
