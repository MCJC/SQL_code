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
 /* 40 */               SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_ForMoreInformationLinks_by_Religion]          )
                              ,[T] =                        'forum.        .[vi_ForMoreInformationLinks_by_Religion]'
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi18b_vi_ForMoreInformationLinks_by_Religion.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO