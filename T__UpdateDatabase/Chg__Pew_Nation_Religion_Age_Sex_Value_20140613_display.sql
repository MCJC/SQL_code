----USE [SHIdb];
----GO

------ import display tables for age 

----IF OBJECT_ID('[SHIdb].[dbo].[display_age]') IS NOT NULL
----DROP TABLE  display_age 


---- -- import age display table

---- CREATE TABLE [SHIdb].[dbo].[display_age]
----(
----Nation_fk INT NOT NULL,
----Religion_fk INT NOT NULL,
----Display_age INT NULL
----)
----GO

---- BULK
---- INSERT [SHIdb].[dbo].[display_age]
---- FROM 'C:\data\display_rev\display_age.csv'
---- WITH
---- (
---- FIELDTERMINATOR = ',',
---- ROWTERMINATOR = '\n',
---- FIRSTROW = 2 -- so headers not imported
---- )
---- GO

 USE [forum]
 GO

-- revise display field for [Pew_Nation_Religion_Age_Sex_Value]

UPDATE [Pew_Nation_Religion_Age_Sex_Value] 
SET 
[Pew_Nation_Religion_Age_Sex_Value].[Display_AgeSex_Str] = 0,
[Pew_Nation_Religion_Age_Sex_Value].[Display_AgeStr_15Yrs] = 0,
[Pew_Nation_Religion_Age_Sex_Value].[Display_MedianAge] = 0
WHERE Scenario_id != 8

UPDATE [Pew_Nation_Religion_Age_Sex_Value] 
SET 
[Pew_Nation_Religion_Age_Sex_Value].[Display_AgeStr_15Yrs] = [SHIdb].[dbo].[display_age].Display_age,
[Pew_Nation_Religion_Age_Sex_Value].[Display_MedianAge] = [SHIdb].[dbo].[display_age].Display_age
FROM [Pew_Nation_Religion_Age_Sex_Value], [SHIdb].[dbo].[display_age]
WHERE [Pew_Nation_Religion_Age_Sex_Value].Nation_fk = [SHIdb].[dbo].[display_age].Nation_fk
AND [Pew_Nation_Religion_Age_Sex_Value].Religion_group_fk = [SHIdb].[dbo].[display_age].Religion_fk
AND [Pew_Nation_Religion_Age_Sex_Value].[Scenario_id] = 4
AND [Pew_Nation_Religion_Age_Sex_Value].[Field_fk] >= 76
AND [Pew_Nation_Religion_Age_Sex_Value].[Field_fk] <= 84

