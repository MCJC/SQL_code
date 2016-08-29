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
 /* 14 */               SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_Migrants_by_Ctry]                             )
                              ,[T] =                        'forum.        .[vi_Migrants_by_Ctry]'
 /* 15 */     UNION ALL SELECT [C] = (SELECT COUNT(*) FROM   forum_ResAnal..[vi_Migrants_by_Ctry]                             )
                              ,[T] =                        'forum_ResAnal..[vi_Migrants_by_Ctry]'
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi03c_vi_Migrants_by_Ctry.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO
