----USE [SHIdb];
----GO

------ import display tables for age and fertility

----IF OBJECT_ID('[SHIdb].[dbo].[display_fertility]') IS NOT NULL
----DROP TABLE  display_fertility 

------ import fertility display table
----CREATE TABLE [SHIdb].[dbo].[display_fertility]
----(
----Nation_fk INT NOT NULL,
----Religion_fk INT NOT NULL,
----Display_fert INT NULL
----)
----GO

----BULK
---- INSERT [SHIdb].[dbo].[display_fertility]
---- FROM 'C:\data\display_rev\display_fer.csv'
---- WITH
---- (
---- FIELDTERMINATOR = ',',
---- ROWTERMINATOR = '\n',
---- FIRSTROW = 2 -- so headers not imported
---- )
---- GO

 USE [forum]
 GO

-- revise display field for [Pew_Nation_Religion_Fertility_Value]
 
UPDATE [Pew_Nation_Religion_Fertility_Value] 
SET [Pew_Nation_Religion_Fertility_Value].Display = 0

UPDATE [Pew_Nation_Religion_Fertility_Value] 
SET [Pew_Nation_Religion_Fertility_Value].Display = [SHIdb].[dbo].[display_fertility].Display_fert
FROM [Pew_Nation_Religion_Fertility_Value], [SHIdb].[dbo].[display_fertility] 
WHERE [Pew_Nation_Religion_Fertility_Value].Nation_fk = [SHIdb].[dbo].[display_fertility].Nation_fk
AND [Pew_Nation_Religion_Fertility_Value].Religion_group_fk = [SHIdb].[dbo].[display_fertility].Religion_fk
AND [Pew_Nation_Religion_Fertility_Value].[Scenario_id] = 4
AND [Pew_Nation_Religion_Fertility_Value].[Field_fk] >= 87
AND [Pew_Nation_Religion_Fertility_Value].[Field_fk] <= 95
