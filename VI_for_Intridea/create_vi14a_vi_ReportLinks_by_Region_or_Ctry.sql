/* ++> create_vi14a_vi_ReportLinks_by_Region_or_Ctry.sql <++ */
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [forum]..[vi_ReportLinks_by_Region_or_Ctry]                                            <<<<<     ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [forum]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
ALTER  VIEW
               [dbo].[vi_ReportLinks_by_Region_or_Ctry]
AS
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
          [RLCv_row]
          =  ROW_NUMBER()
             OVER(ORDER BY
                            N.[Nation_fk]
                          , R.[Report_SortingNumber]      )
--       , Display_Reports_fk           = R.Display_Reports_pk
--       , R.Data_source_fk
       , N.Nation_fk
       , N.Ctry_EditorialName
       , R.Report_SortingNumber
--       , S.Data_source_name
--       , S.Data_source_description
       , S.Source_Display_Name
       , S.Data_source_url
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
FROM
     [Pew_Data_Source]              AS S
JOIN [Pew_Display_Reports]          AS R
  ON    Data_source_fk
      = Data_source_pk
JOIN [vi_Nation_Attributes]         AS N
  ON    R.Nation_fk
      = N.Nation_fk
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
WHERE
        GRF_Level = 'reports'
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
go