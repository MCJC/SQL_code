USE [for_x]
GO

/****** Object:  View [dbo].[Vw_ChangeInConstitution]    Script Date: 08/27/2013 11:13:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
create  VIEW
               [dbo].[Vw_ChangeInConstitution]
AS
/***************************************************************************************************************************************************************/
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [RowID]
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Question_Year]

      ,[GRI_01_x]

      ,[GRI_01_x2_a]
      ,[GRI_01_y2011]
      ,[GRI_01]
      ,[GRI_01_DSCPTN_y2011]
      ,[GRI_01_DSCPTN]

      ,[GRI_01_x2_b]
      ,[GRI_02_y2011]
      ,[GRI_02]
      ,[GRI_02_DSCPTN_y2011]
      ,[GRI_02_DSCPTN]

      --,[GRI_01_x_DSCPTN]
      --,[GRI_01_x2_DSCPTN]
      --,[GRI_03]

  FROM [GRSHR].[dbo].[GRI_Ctry]
where 
GRI_01_x LIKE '1.00%'
GO


