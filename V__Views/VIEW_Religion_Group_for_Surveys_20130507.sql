/*****************************************************************************************************************************************************/
USE [forum]
GO
/*****************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****************************************************************************************************************************************************/
ALTER VIEW    [dbo].[v_Religion_Group_for_Surveys]
AS
/*****************************************************************************************************************************************************/
SELECT
        Religion_fk                        = [Religion_group_pk]
      , Detailed_Name                      = [Pew_religion]
      , Standard_Name                      = [Pew_religion_lev05] 
      , Lowest_Aggregation_Level           = [Pew_religion_lev04] 
      , Second_Aggregation_Level           = [Pew_religion_lev03]
      , Third_Aggregation_Level            = [Pew_religion_lev02_5]
      , Fourth_Aggregation_Level           = [Pew_religion_lev02]
      , Fifth_Aggregation_Level            = [Pew_religion_lev01_5]
      , Highest_Aggregation_Level          = [Pew_religion_lev01]
      , ROW                                =   'CurrentRow_is_'
                                             + STR((
                                               ROW_NUMBER()
                                               OVER(ORDER BY
                                                             [Pew_religion_lev01]
                                                            ,[Pew_religion_lev01_5]
                                                            ,[Pew_religion_lev02]
                                                            ,[Pew_religion_lev02_5]
                                                            ,[Pew_religion_lev03]
                                                            ,[Pew_religion_lev04]
                                                            ,[Pew_religion_lev05]
                                                            ,[Pew_religion]
                                                                                     )), 4,0 )
  FROM [forum].[dbo].[Pew_Religion_Group]
WHERE [Pew_religion] NOT IN (
                               'Total'
                             , 'Affiliated'
                             , 'Other Religions and Folk Religionists'
                             , 'Buddhists and Hindus'
                             , 'Abrahamic Religions '
                                                                            )
/*****************************************************************************************************************************************************/
