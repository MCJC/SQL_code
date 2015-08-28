/*********************************************************************************************************/
SELECT *
  INTO  [_bk_forum].[dbo].[Pew_Question_NoStd_2013_03_20]
  FROM      [forum].[dbo].[Pew_Question_NoStd]
SELECT *
  INTO  [_bk_forum].[dbo].[Pew_Question_Std_2013_03_20]
  FROM      [forum].[dbo].[Pew_Question_Std]
/*********************************************************************************************************/
SELECT *
  INTO [juancarlos].[dbo].[Pew_Question_NoStd]
  FROM      [forum].[dbo].[Pew_Question_NoStd]
SELECT *
  INTO [juancarlos].[dbo].[Pew_Question_Std]
  FROM      [forum].[dbo].[Pew_Question_Std]
/*********************************************************************************************************/



/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Question_Std_pk]
      ,[Question_abbreviation_std]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
  FROM [forum].[dbo].[Pew_Question_Std]
where  Question_abbreviation_std like 'GRX_25_01%'  


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Question_pk]
      ,[Question_abbreviation]
      ,[Question_wording]
      ,[Data_source_fk]
      ,[Question_Year]
      ,[Short_wording]
      ,[Notes]
      ,[Default_response]
      ,[Question_Std_fk]
  FROM [forum].[dbo].[Pew_Question_NoStd]
where  [Question_Std_fk] IN ( 119, 120)



/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Answer_pk]
      ,[Answer_value]
      ,[Question_fk]
      ,[Answer_wording]
      ,[answer_wording_std]
  FROM [forum].[dbo].[Pew_Answer]
where [Question_fk] in (417, 1077)  





/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Question_Std_pk]
      ,[Question_abbreviation_std]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
  FROM [forum].[dbo].[Pew_Question_Std]
where  Question_abbreviation_std like 'SHX_27_01%'  


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Question_pk]
      ,[Question_abbreviation]
      ,[Question_wording]
      ,[Data_source_fk]
      ,[Question_Year]
      ,[Short_wording]
      ,[Notes]
      ,[Default_response]
      ,[Question_Std_fk]
  FROM [forum].[dbo].[Pew_Question_NoStd]
where  [Question_Std_fk] IN ( 255, 256 )



/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Answer_pk]
      ,[Answer_value]
      ,[Question_fk]
      ,[Answer_wording]
      ,[answer_wording_std]
  FROM [forum].[dbo].[Pew_Answer]
where [Question_fk] in (497, 1187 )



