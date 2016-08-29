/****** NEW Table:  [forum].[dbo].[Pew_Thresholds]    Script Date: 03/10/2015 *************************************************/
USE [forum]
GO
/******************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************************************************************/
CREATE TABLE [dbo].[Pew_Thresholds](
                                       [Pew_Thresholds_pk] [int]          NOT NULL
                                     , [Datatype]          [nvarchar](15)     NULL
                                     , [Point]             [nvarchar](40)     NULL
                                     , [Threshold]         [decimal] (32, 24) NULL
                                     , [Display_text]      [nvarchar](15)     NULL
                                     , [Notes]             [varchar] (255)    NULL
                                     , CONSTRAINT
                                       [PK_Pew_Thresholds]
                                       PRIMARY KEY CLUSTERED
                                     ( [Pew_Thresholds_pk]  ASC )
                                       WITH (  PAD_INDEX              = OFF,
                                               STATISTICS_NORECOMPUTE = OFF,
                                               IGNORE_DUP_KEY         = OFF,
                                               ALLOW_ROW_LOCKS        = ON ,
                                               ALLOW_PAGE_LOCKS       = ON  )  ON [PRIMARY]
                                                                             ) ON [PRIMARY]
GO
/******************************************************************************************************************************/
SET ANSI_PADDING OFF
GO
/******************************************************************************************************************************/
/******************************************************************************************************************************/
INSERT
INTO   [Pew_Thresholds]
SELECT [Pew_Thresholds_pk] = K
      ,[Datatype]          = d
      ,[Point]             = p
      ,[Threshold]         = x
      ,[Display_text]      = t
      ,[Notes]             = n
  FROM
( SELECT [K] =  1, [d] = 'Population' , [p] = 'minimum' , [x] = 10000 , [t] = '<10,000'  , [n] = ''
  UNION
  ALL
  SELECT [K] =  2, [d] = 'Population' , [p] = 'maximum'  , [x] = NULL  , [t] = ''         , [n] = 'Max pop rounded'
  UNION
  ALL
  SELECT [K] =  3, [d] = 'Percentage' , [p] = 'minimum'  , [x] =  1    , [t] = '< 1.0'    , [n] = ''
  UNION
  ALL
  SELECT [K] =  4, [d] = 'Percentage' , [p] = 'maximum'  , [x] = 99    , [t] = '>99.0'    , [n] = ''
  UNION
  ALL
  SELECT [K] =  5, [d] = 'Popul_Gain' , [p] = 'negative'
                                            + '-minimum' , [x] = -1000 , [t] = '- <1,000', [n] = ''
  UNION
  ALL
  SELECT [K] =  6, [d] = 'Popul_Gain' , [p] = 'positive'
                                            + '-minimum' , [x] =  1000 , [t] =   '<1,000', [n] = ''
  UNION
  ALL
  SELECT [K] =  7, [d] = 'Popul_Gain' , [p] = 'maximum'  , [x] = NULL  , [t] = ''        , [n] = 'Max pop rounded'
                                                                                                                     ) MyData
/******************************************************************************************************************************/
