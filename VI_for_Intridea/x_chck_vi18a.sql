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
 /* 39 */               SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_ForMoreInformationLinks_by_Region_or_Ctry]    )
                              ,[T] =                        'forum.        .[vi_ForMoreInformationLinks_by_Region_or_Ctry]'
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi18a_vi_ForMoreInformationLinks_by_Region_or_Ctry.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO
