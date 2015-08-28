/*****************************************************************************************************************************************************/
/*****************************************************************************************************************************************************/
/***                                                                                                                                               ***/
/***     >>>>>   This is the script used to load data into the table [NPew_Survey_Respondent]                                            <<<<<     ***/
/***                                                                                                                                               ***/
/*****************************************************************************************************************************************************/
USE [x_LoadRLS1cUS]
GO
/**************************************************************************************************************************************************/
SELECT [M_pk]
      ,[SVY_psraid]
      ,[DetRel]
      ,[weight]
      ,[interview_date]
      ,[VarName]
      ,[Value]
      ,[ValueLabel]
  INTO                                              [microdata]
  FROM
      (
                  SELECT * FROM [xDataLoaded].[dbo].[microdata_RLS1cUS]
        UNION ALL SELECT * FROM [xDataLoaded].[dbo].[microdata_RLS1AnH]
        UNION ALL SELECT * FROM [xDataLoaded].[dbo].[microdata_RLS2All]
      )                                                        RLS
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
select 
 SVY_psraid	
,VarName	
,Value	
,ValueLabel
 from
[xDataLoaded].[dbo].[microdata_RLS_both]
select 
 SVY_psraid	
,VarName	
,Value	
,ValueLabel
from
[xDataLoaded].[dbo].[microdata_RLS_2014]

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [SVY_psraid]
      ,[VarName]
      ,[Value]
      ,[ValueLabel]
--      ,[M_pk]
--      ,[DetRel]
--      ,[weight]
--      ,[interview_date]
  FROM [xDataLoaded].[dbo].[microdata_RLS1cUS]
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [SVY_psraid]
      ,[VarName]
      ,[Value]
      ,[ValueLabel]
--      ,[M_pk]
--      ,[DetRel]
--      ,[weight]
--      ,[interview_date]
  FROM [xDataLoaded].[dbo].[microdata_RLS1AnH]

