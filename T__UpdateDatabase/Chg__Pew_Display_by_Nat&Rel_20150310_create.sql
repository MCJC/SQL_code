/****** NEW Table:  [forum].[dbo].[Pew_Display_by_Nation&Religion]    Script Date: 03/10/2015 *********************************/
USE [forum]
GO
/******************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************************************************************/
CREATE TABLE [dbo].[Pew_Display_by_Nation&Religion]
                                    (
                                       [Display_by_N&R_pk]      [int]          NOT NULL
                                     , [Nation_fk]              [int]              NULL
                                     , [Religion_fk]            [int]              NULL
                                     , [MedianAge_Data]         [int]              NULL
                                     , [15YrsAgeStr_Data]       [int]              NULL
                                     , [Fertilty_Data]          [int]              NULL
                                     , [Migration_Data]         [int]              NULL
                                     , [Switching_Data]         [int]              NULL
                                     , CONSTRAINT
                                       [PK_Display_by_N&R]
                                       PRIMARY KEY CLUSTERED
                                     ( [Display_by_N&R_pk]  ASC )
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
INTO   [Pew_Display_by_Nation&Religion]
SELECT
           [Display_by_N&R_pk] = ROW_NUMBER()OVER(ORDER BY
                                 A.[Nation_fk]
                               , A.[Religion_fk]          )
       , A.[Nation_fk]
       , A.[Religion_fk]
       ,   [MedianAge_Data]    = A.[Display]
       ,   [15YrsAgeStr_Data]  = A.[Display]
       ,   [Fertilty_Data]     = F.[Display]
       ,   [Migration_Data]    = M.[Display]
       ,   [Switching_Data]    = S.[Display]
/******************************************************************************************************************************/
--select *
FROM
/******************************************************************************************************************************/
( SELECT [Nation_fk]
        ,[Datatype]
        ,[Religion_fk]
        ,[Display]
    FROM [SHIdb].[dbo].[GRLdisplayRegion] 
   WHERE [Datatype] = 'Age'                ) A
inner
join
( SELECT [Nation_fk]
        ,[Datatype]
        ,[Religion_fk]
        ,[Display]
    FROM [SHIdb].[dbo].[GRLdisplayRegion] 
   WHERE [Datatype] = 'Fertility'          ) F
ON      A.[Nation_fk]
      = F.[Nation_fk]
AND     A.[Religion_fk]
      = F.[Religion_fk]
inner
join
( SELECT [Nation_fk]
        ,[Datatype]
        ,[Religion_fk]
        ,[Display]
    FROM [SHIdb].[dbo].[GRLdisplayRegion] 
   WHERE [Datatype] = 'Migration'          ) M
ON      A.[Nation_fk]
      = M.[Nation_fk]
AND     A.[Religion_fk]
      = M.[Religion_fk]
inner
join
( SELECT [Nation_fk]
        ,[Datatype]
        ,[Religion_fk]
        ,[Display]
    FROM [SHIdb].[dbo].[GRLdisplayRegion] 
   WHERE [Datatype] = 'Switch'          ) S
ON      A.[Nation_fk]
      = S.[Nation_fk]
AND     A.[Religion_fk]
      = S.[Religion_fk]
/******************************************************************************************************************************/
