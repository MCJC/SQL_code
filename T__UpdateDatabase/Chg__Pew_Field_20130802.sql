/*** security backup ******************************************************************************************************/
SELECT *
  INTO  [_bk_forum].[dbo].[Pew_Field_2013_08_01]
  FROM      [forum].[dbo].[Pew_Field]
/**************************************************************************************************************************/

/*** update values to match migration flow data ***************************************************************************/
USE forum
GO

INSERT INTO [forum]..[Pew_Field]
  VALUES
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+1, 'Migration Flow', 'Pew Estimate', 'Final', '2010-2014', 64),
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+2, 'Migration Flow', 'Pew Estimate', 'Final', '2015-2019', 64),
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+3, 'Migration Flow', 'Pew Estimate', 'Final', '2020-2024', 64),
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+4, 'Migration Flow', 'Pew Estimate', 'Final', '2025-2029', 64),
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+5, 'Migration Flow', 'Pew Estimate', 'Final', '2030-2034', 64),
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+6, 'Migration Flow', 'Pew Estimate', 'Final', '2035-2039', 64),
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+7, 'Migration Flow', 'Pew Estimate', 'Final', '2040-2044', 64),
  ((SELECT DISTINCT MAX([Field_pk]) FROM forum.[dbo].[Pew_Field])+8, 'Migration Flow', 'Pew Estimate', 'Final', '2045-2049', 64)
/**************************************************************************************************************************/

