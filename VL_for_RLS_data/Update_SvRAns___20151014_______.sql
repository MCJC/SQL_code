/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Svy_RespAnswer_pk]
      ,[Svy_Respondent_fk]
      ,[Answer_fk]
  FROM [RLS].[dbo].[Pew_Survey_Respondent_Answer]

  where Answer_fk >= 1
    and Answer_fk <= 17

