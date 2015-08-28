/*********************************************************************************************************/
USE forum ;
GO

IF OBJECT_ID ('Pew_Nation_Religion_Value', 'V') IS NOT NULL
  DROP VIEW    Pew_Nation_Religion_Value;
GO
   
CREATE VIEW    Pew_Nation_Religion_Value
AS
/*********************************************************************************************************/
SELECT 
       Nation_religion_age_sex_value_fk   = Nation_religion_age_sex_value_pk
      ,Nation_fk
      ,Religion_group_fk
       -- Fields for working data, 1990,
       -- 2000, 2010, 2020, & 2030
      ,Field_fk                           = CASE
                                                WHEN Field_fk = 25 THEN 24
                                                WHEN Field_fk = 26 THEN  8
                                                WHEN Field_fk = 27 THEN 21
                                                WHEN Field_fk = 28 THEN  7
                                                WHEN Field_fk = 29 THEN 22
                                                WHEN Field_fk = 30 THEN 23
                                            END
      ,nation_value                       = Percentage
      ,[nation_value_Source]
      ,[nation_value_Note]                = Notes              -- SUBSTRING(column, begin_position, length)
      ,[Base_source]                      = Source
      ,[Source_year]
      ,[Scenario_id]
      ,[Distribution_wave_id]
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
WHERE
       [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Field_fk]    IN (25, 26, 27, 28, 29, 30)
AND
       [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Scenario_id] IN (0, 1, 2, 3)
AND
       [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Age_fk]       =   0
AND
       [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Sex_fk]       =   0
/*********************************************************************************************************/
