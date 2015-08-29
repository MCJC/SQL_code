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
 /* 32 */ -- not any more
 /* 33 */ -- not any more
 /* 34 */ -- not any more
 /* 35 */               SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_ReportLinks_by_Region_or_Ctry]                )
                              ,[T] =                        'forum.        .[vi_ReportLinks_by_Region_or_Ctry]'
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi14a_vi_ReportLinks_by_Region_or_Ctry.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO