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
 /* -- */               SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_Field]                                        )
                              ,[T] =                        'forum.        .[vi_Field]'
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi26_vi_Field.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO
