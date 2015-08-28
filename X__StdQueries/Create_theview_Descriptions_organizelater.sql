USE [_Admin]
GO

/****** Object:  View [dbo].[Descriptions]    Script Date: 06/21/2013 14:37:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*****************************************************************************************************************************************************/
ALTER VIEW       [dbo].[Descriptions]
AS
/*****************************************************************************************************************************************************/
SELECT * FROM
                 [_Admin].[dbo].[Describe_Table_and_Fields]
--      UNION
--SELECT * FROM
--                 [_Admin].[dbo].[Describe_Table_and_Fields_WRD]
/*****************************************************************************************************************************************************/
/*** << Create reference metadata table [Descriptions] storing descriptions of tables and fields *****************************************************/
/*****************************************************************************************************************************************************/

GO


