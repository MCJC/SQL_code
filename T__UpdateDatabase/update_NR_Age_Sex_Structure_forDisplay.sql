/*********************************************************************************************************/
SELECT *
  INTO   [_bk_forum].[dbo].[Pew_Migration_2013_02_15]
  FROM       [forum].[dbo].[Pew_Migration]
/*********************************************************************************************************/
-- add new column
ALTER TABLE
             [forum].[dbo].[Pew_Migration]
ADD          Display
                                                   int
/*********************************************************************************************************/
-- Update all display to 1

UPDATE
             [forum].[dbo].[Pew_Migration]
SET
             [forum].[dbo].[Pew_Migration].[Display]
         =   1
/*********************************************************************************************************/
-- Update all display to 0 when they should not be displayed

UPDATE
             [forum].[dbo].[Pew_Migration]
SET
             [forum].[dbo].[Pew_Migration].[Display]
         =   0
WHERE
            ( destination_nation_fk = 204 AND Pew_religion_group_fk = 42)   -- Tajikistan - christian_d
       OR   ( destination_nation_fk = 204 AND Pew_religion_group_fk = 49)   -- Tajikistan - christian_d
       OR   ( destination_nation_fk = 204 AND Pew_religion_group_fk = 50)   -- Tajikistan - christian_d
       OR   ( destination_nation_fk =  10 AND Pew_religion_group_fk = 47)   -- Armenia - muslim_d
       OR   ( destination_nation_fk =  19 AND Pew_religion_group_fk = 47)   -- Belarus - muslim_d
       OR   ( destination_nation_fk = 167 AND Pew_religion_group_fk = 47)   -- Poland - muslim_d
       OR   ( destination_nation_fk = 195 AND Pew_religion_group_fk = 47)   -- Spain - muslim_d
       OR   ( destination_nation_fk = 218 AND Pew_religion_group_fk = 47)   -- Ukraine - muslim_d
       OR   ( destination_nation_fk = 158 AND Pew_religion_group_fk = 57)   -- Pakistan - unaffiliated_d
       OR   ( destination_nation_fk = 109 AND Pew_religion_group_fk = 44)   -- Kuwait - buddhist_d
       OR   ( destination_nation_fk = 158 AND Pew_religion_group_fk = 44)   -- Pakistan - buddhist_d
       OR   ( destination_nation_fk = 183 AND Pew_religion_group_fk = 44)   -- Saudi Arabia - buddhist_d
       OR   ( destination_nation_fk = 195 AND Pew_religion_group_fk = 44)   -- Spain - buddhist_d
       OR   ( destination_nation_fk =  70 AND Pew_religion_group_fk = 48)   -- France - hindu_d
       OR   ( destination_nation_fk = 113 AND Pew_religion_group_fk = 48)   -- Lebanon - hindu_d
       OR   ( destination_nation_fk = 183 AND Pew_religion_group_fk = 48)   -- Saudi Arabia - hindu_d
       OR   ( destination_nation_fk =  74 AND Pew_religion_group_fk = 61)   -- Gambia - other_d
       OR   ( destination_nation_fk =  76 AND Pew_religion_group_fk = 61)   -- Germany - other_d
       OR   ( destination_nation_fk = 100 AND Pew_religion_group_fk = 61)   -- Israel - other_d
       OR   ( destination_nation_fk = 151 AND Pew_religion_group_fk = 61)   -- Niger - other_d
       OR   ( destination_nation_fk = 158 AND Pew_religion_group_fk = 61)   -- Pakistan - other_d
       OR   ( destination_nation_fk = 184 AND Pew_religion_group_fk = 61)   -- Senegal - other_d
       OR   ( destination_nation_fk = 195 AND Pew_religion_group_fk = 61)   -- Spain - other_d
       OR   ( destination_nation_fk = 206 AND Pew_religion_group_fk = 61)   -- Thailand - other_d
/*********************************************************************************************************/

/*********************************************************************************************************/
-- check results
SELECT 
       distinct
       destination_nation_fk
      ,Pew_religion_group_fk
  FROM
             [forum].[dbo].[Pew_Migration]
WHERE
             [forum].[dbo].[Pew_Migration].[Display] 
         =   0












