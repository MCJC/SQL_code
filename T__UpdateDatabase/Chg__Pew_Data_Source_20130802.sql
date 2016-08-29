/*** security backup ******************************************************************************************************/
SELECT *
  INTO  [_bk_forum].[dbo].[Pew_Data_Source_2013_08_02]
  FROM      [forum].[dbo].[Pew_Data_Source]
/**************************************************************************************************************************/

/*** update values to match migration flow data ***************************************************************************/
INSERT INTO
            [forum].[dbo].[Pew_Data_Source]
  VALUES
  ((SELECT DISTINCT MAX([Data_Source_pk]) FROM [forum].[dbo].[Pew_Data_Source])+1
, 'Global Religious Futures - Migration'
, 'Projection of Migration Counts by Country and Region'
, NULL
, 'Migration Flows for Global Religious Futures')
/**************************************************************************************************************************/
