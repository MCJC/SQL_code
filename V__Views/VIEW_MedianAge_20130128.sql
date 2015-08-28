USE forum ;
GO

IF OBJECT_ID ('Pew_Medians_byCtry_and_Religion', 'V') IS NOT NULL
  DROP VIEW    Pew_Medians_byCtry_and_Religion;
GO
   
CREATE VIEW    Pew_Medians_byCtry_and_Religion
AS
/*********************************************************/
SELECT *
  FROM [juancarlos].[dbo].[ctry_medians_new]
