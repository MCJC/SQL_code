 USE [forum]
 GO

-- correct display field for [Pew_Nation_Religion_Age_Sex_Value]
-- display all religion at the national level

UPDATE [Pew_Nation_Religion_Age_Sex_Value] 
SET 
[Pew_Nation_Religion_Age_Sex_Value].[Display_AgeStr_15Yrs] = 1,
[Pew_Nation_Religion_Age_Sex_Value].[Display_MedianAge] = 1
WHERE [Pew_Nation_Religion_Age_Sex_Value].[Scenario_id] = 4
AND [Pew_Nation_Religion_Age_Sex_Value].[Field_fk] >= 76
AND [Pew_Nation_Religion_Age_Sex_Value].[Field_fk] <= 84
AND [Sex_fk] = 0
AND [Age_fk] = 0

