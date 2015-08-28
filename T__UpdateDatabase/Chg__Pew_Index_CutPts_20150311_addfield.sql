/**************************************************************************************************************************/
/*****                                              BackUp current Table                                              *****/
/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT *
                INTO  [_bk_forum].[dbo].[Pew_Index_Cut_Points_' + @CrDt + ']
                FROM      [forum].[dbo].[Pew_Index_Cut_Points]'               )
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
SELECT [Pew_Index_CutPoints_pk]
      ,[Field_fk]
      ,[Level]
      ,[Scaled_Level_value] = CASE WHEN [Level] = 'low'       THEN 1
                                   WHEN [Level] = 'moderate'  THEN 2
                                   WHEN [Level] = 'high'      THEN 3
                                   WHEN [Level] = 'very high' THEN 4 END
      ,[Point]
      ,[CutPoint]
  INTO               [#___Index_Cut_Points]
  FROM [forum].[dbo].[Pew_Index_Cut_Points]
/**************************************************************************************************************************/
  SELECT * FROM      [#___Index_Cut_Points]
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 002                                                    *****/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
DROP   TABLE   [dbo].[Pew_Index_Cut_Points]
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 003                                                    *****/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
/**************************************************************************************************************************/
CREATE TABLE
    [Pew_Index_Cut_Points]
(
	[Pew_Index_CutPoints_pk]    [int]          NOT NULL
  , [Field_fk]                  [int]              NULL
  , [Level]                     [nvarchar](50)     NULL
  , [Scaled_Level_value]        [int]              NULL
  , [Point]                     [nvarchar](50)     NULL
  , [CutPoint]                  [decimal](8,4)     NULL
  , CONSTRAINT
    [PK_Index_CutPoints]
    PRIMARY KEY CLUSTERED 
    (
	  [Pew_Index_CutPoints_pk]
	                      ASC
                         )WITH (  PAD_INDEX              = OFF,
                                  STATISTICS_NORECOMPUTE = OFF,
                                  IGNORE_DUP_KEY         = OFF,
                                  ALLOW_ROW_LOCKS        = ON ,
                                  ALLOW_PAGE_LOCKS       = ON  ) ON [PRIMARY]
                                                                               ) ON [PRIMARY]
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
SET ANSI_PADDING OFF
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 004                                                    *****/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
INSERT
  INTO [forum].[dbo].[Pew_Index_Cut_Points]
SELECT *
  FROM               [#___Index_Cut_Points]
ORDER
BY  
	[Pew_Index_CutPoints_pk]
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    THE  END                                                    *****/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
