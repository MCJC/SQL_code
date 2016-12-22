/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 3.003    ---------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the VIEW and the  LOOKUP TABLE vr___01_wDB_Long__NoAggregated




                                                       lookup table [forum_ResAnal].[dbo].[vr_05w_SemiWide_by_Ctry&Year]                           <<<<<     ***/
/***             This table only includes numeric values aggregated by country/religion & year (does not include descriptive wordings).                      ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [GRSHRcode]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
ALTER VIEW     [vr___01_]
AS
SELECT
       *
  FROM [forum_ResAnal]..[vr___01_]
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/**********

            USE    [GRSHRcode]
            DROP
             TABLE [GRSHRcode].[dbo].[tr___01_]
            SELECT
                 *
              INTO [GRSHRcode].[dbo].[tr___01_]
              FROM [GRSHRcode].[dbo].[vr___01_]

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/