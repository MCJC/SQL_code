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
 /* 29 */               SELECT [C] = (SELECT COUNT(*) FROM   forum.        .[vi_FertilityRate]                                )
                              ,[T] =                        'forum.        .[vi_FertilityRate]'
 /* 30 */     UNION ALL SELECT [C] = (SELECT COUNT(*) FROM   forum_ResAnal..[vi_WRCRel_ASFR]                                  )
                              ,[T] =                        'forum_ResAnal..[vi_WRCRel_ASFR]'
 /* 31 */     UNION ALL SELECT [C] = (SELECT COUNT(*) FROM   forum_ResAnal..[vi_FertilityRate]                                )
                              ,[T] =                        'forum_ResAnal..[vi_FertilityRate]'
 /* 32 */ -- not any more
 /* 33 */ -- not any more
 /* 34 */ -- not any more
GO
/***************************************************************************************************************************************************************/
Print 'script ''create_vi13a_vi_FertilityRate.sql'' has ben executed'
/***************************************************************************************************************************************************************/
GO
