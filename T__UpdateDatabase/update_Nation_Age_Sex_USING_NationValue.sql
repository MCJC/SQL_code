/*********************************************************************************************************/
SELECT *
  INTO [_bk_forum].[dbo].[Pew_Nation_Religion_Value_2013_02_08]
  FROM     [forum].[dbo].[Pew_Nation_Religion_Value]
-----------------------------------------------------------------------------------------------------------
SELECT *
  INTO [_bk_forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value_2013_02_08]
  FROM     [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
/*********************************************************************************************************/
-- add new columns
ALTER TABLE  [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
ADD          Nation_Value_Source 
                                                   varchar(100)
-----------------------------------------------------------------------------------------------------------
ALTER TABLE  [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
ADD          Distribution_Wave_id 
                                                   int
/*********************************************************************************************************/
-- Update
--     Nation_Value_Source as '' (empty) for all rows
--     Distribution_Wave_id as 1


UPDATE
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
SET
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Nation_Value_Source]
       =   ''
     ,
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Distribution_Wave_id]
       =   1


/*********************************************************************************************************/
-- Get
--     values
--     source (base source)
--     source year
--     Nation_Value_Source
--     Distribution_Wave_id
--     Notes (Nation_Value_Note) when available

--        from current [Pew_Nation_Religion_Value] table:
UPDATE
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
SET
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Percentage]
       =   [forum].[dbo].[Pew_Nation_Religion_Value]        .[nation_value]
     ,
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Source]
       =   'base source: '
         + [forum].[dbo].[Pew_Nation_Religion_Value]        .[Base_source]
     ,
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Source_year]
       =   [forum].[dbo].[Pew_Nation_Religion_Value]        .[Source_year]
     ,
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Nation_Value_Source]
       =   [forum].[dbo].[Pew_Nation_Religion_Value]        .[nation_value_Source]
     ,
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Notes]
       =   CASE 
           WHEN
                [nation_value_Note] =   ''
           THEN
                'no nation value note'
           ELSE
			    'nation value note: '
			  + [forum].[dbo].[Pew_Nation_Religion_Value].[nation_value_Note]
           END
FROM
          [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
 JOIN
          [forum].[dbo].[Pew_Nation_Religion_Value]

ON
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Nation_fk]
       =   [forum].[dbo].[Pew_Nation_Religion_Value]        .[Nation_fk]
AND
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Religion_group_fk]
       =   [forum].[dbo].[Pew_Nation_Religion_Value]        .[Religion_group_fk]
WHERE
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Field_fk] =   25
AND
           [forum].[dbo].[Pew_Nation_Religion_Value]        .[Field_fk] =   24
AND
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Age_fk]   =    0
AND
           [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value].[Sex_fk]   =    0
/*********************************************************************************************************/

/*********************************************************************************************************/
-- check results


SELECT 
       distinct
       [Nation_fk]
      ,[Religion_group_fk]
      ,[nation_value]
      ,[Base_source]
      ,[Source_year]
      ,[nation_value_Source]
      ,[nation_value_Note]
      ,[Distribution_wave_id]
  FROM [forum].[dbo].[Pew_Nation_Religion_Value]
order by
       [Nation_fk]
      ,[Religion_group_fk]


SELECT 
       PK = [Nation_religion_age_sex_value_pk]
      ,[Nation_fk]
      ,[Religion_group_fk]
      ,[Percentage]
      ,[Source]
      ,[Source_year]
      ,[nation_value_Source]
      ,[Notes]
      ,[Distribution_wave_id]
      ,[Field_fk]
      ,[Scenario_id]
      ,[Display]
      ,[Cases]
      ,[Cases_Notes]
      ,[Sex_fk]
      ,[Age_fk]
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
where
       [Sex_fk]   = 0
and
       [Field_fk] = 25
order by
       [Nation_fk]
      ,[Religion_group_fk]












