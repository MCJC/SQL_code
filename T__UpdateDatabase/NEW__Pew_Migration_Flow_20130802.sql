/*** no security backup needed ********************************************************************************************/

/*** create migration flow data *******************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
--DROP TABLE [dbo].[Pew_Migration_Flow]
/**************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************************************************************************************/
CREATE TABLE [dbo].[Pew_Migration_Flow](

       [migration_flow_pk]            [int] NOT NULL,
       [origin_nation_fk]             [int] NULL,
       [destination_nation_fk]        [int] NULL,
       [pew_religion_group_fk]        [int] NULL,
       [migrant_count]                [decimal](12, 4) NULL,
       [field_fk]                     [int] NULL,
       [sex_fk]                       [int] NULL,
       [Display_by_Religion]          [int] NULL,
       [Display_as_Destination_Ctry]  [int] NULL,
       [Display_as_Origin_Ctry]       [int] NULL,
CONSTRAINT [PK_Pew_Migration_Flow] PRIMARY KEY CLUSTERED 
(
       [migration_flow_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
--TRUNCATE TABLE forum.[dbo].[Pew_Migration_Flow]
/**************************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 55
     ,  [sex_fk]                       = 1
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 55
     ,  [sex_fk]                       = 2
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 56
     ,  [sex_fk]                       = 1
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 56
     ,  [sex_fk]                       = 2
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 57
     ,  [sex_fk]                       = 1
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 57
     ,  [sex_fk]                       = 2
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 58
     ,  [sex_fk]                       = 1
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 58
     ,  [sex_fk]                       = 2
FROM forum..Pew_Migration S
GO

/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 59
     ,  [sex_fk]                       = 1
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 59
     ,  [sex_fk]                       = 2
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 60
     ,  [sex_fk]                       = 1
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 60
     ,  [sex_fk]                       = 2
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 61
     ,  [sex_fk]                       = 1
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 61
     ,  [sex_fk]                       = 2
FROM forum..Pew_Migration S
GO

/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 62
     ,  [sex_fk]                       = 1
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
INSERT INTO
            forum.[dbo].[Pew_Migration_Flow]
   (
        [migration_flow_pk]
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]
     ,  [sex_fk]
                                  )
SELECT
        [migration_flow_pk]            = ROW_NUMBER()
                                         OVER(ORDER BY   
                                                  S.[origin_nation_fk]
                                                , S.[destination_nation_fk]
                                                , S.[pew_religion_group_fk]
                                    --          , S.[sex_fk]
                                                , S.[field_fk]                      ) 
                                       + (SELECT DISTINCT
                                                 MAX([migration_flow_pk])
                                          FROM forum.[dbo].[Pew_Migration_Flow]     )
     ,  [origin_nation_fk]
     ,  [destination_nation_fk]
     ,  [pew_religion_group_fk]
     ,  [migrant_count]
     ,  [field_fk]                     = 62
     ,  [sex_fk]                       = 2
FROM forum..Pew_Migration S
GO
/*****************************************************************************************************************/
-- Update display filters 0/1 for the proper cases:
UPDATE
            forum.[dbo].[Pew_Migration_Flow]
SET
            forum.[dbo].[Pew_Migration_Flow].[Display_by_Religion]
         =  0
       ,
            forum.[dbo].[Pew_Migration_Flow].[Display_as_Origin_Ctry]
         =  0
       ,
            forum.[dbo].[Pew_Migration_Flow].[Display_as_Destination_Ctry]
         =  0
/*****************************************************************************************************************/
--UPDATE
--            forum.[dbo].[Pew_Migration_Flow]
--SET
--            forum.[dbo].[Pew_Migration_Flow].[Display_by_Religion]
--         =  1
--WHERE
--            ( origin_nation_fk      =  41 )   -- Channel Islands
--       OR   ( origin_nation_fk      =  67 )   -- Falkland Islands (Malvinas)
--       OR   ( origin_nation_fk      =  78 )   -- Gibraltar
--       OR   ( origin_nation_fk      =  83 )   -- Guam
--       OR   ( origin_nation_fk      =  99 )   -- Isle of Man
--       OR   ( origin_nation_fk      = 154 )   -- North Korea
--       OR   ( origin_nation_fk      = 175 )   -- St. Helena
--       OR   ( origin_nation_fk      = 176 )   -- St. Kitts and Nevis
--       OR   ( origin_nation_fk      = 177 )   -- St. Lucia
--       OR   ( origin_nation_fk      = 222 )   -- U.S. Virgin Islands
--       OR   ( origin_nation_fk      =  89 )   -- Vatican City
--       OR   ( origin_nation_fk      = 228 )   -- Wallis and Futuna
--GO
/**************************************************************************************************************************/