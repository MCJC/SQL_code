/*********************************************************************************************************/
SELECT *
  INTO   [_bk_forum].[dbo].[Pew_Migration_2013_02_21]
  FROM       [forum].[dbo].[Pew_Migration]
/*********************************************************************************************************/
-- add new columns:
ALTER TABLE
             [forum].[dbo].[Pew_Migration]
ADD
             Display_by_Religion
                                                   int
         ,   Display_as_Destination_Ctry
                                                   int
         ,   Display_as_Origin_Ctry
                                                   int
                                                   
/*********************************************************************************************************/
-- Update display by religion:

UPDATE
             [forum].[dbo].[Pew_Migration]
SET
             [forum].[dbo].[Pew_Migration].[Display_by_Religion]
         =   [forum].[dbo].[Pew_Migration].[Display]

-- remove old column:
ALTER TABLE
             [forum].[dbo].[Pew_Migration]
DROP COLUMN
             Display
/*********************************************************************************************************/
-- Update all display by country of origin and by country of destination to 1:

UPDATE
             [forum].[dbo].[Pew_Migration]
SET
             [forum].[dbo].[Pew_Migration].[Display_as_Destination_Ctry]
         =   1
      ,      [forum].[dbo].[Pew_Migration].[Display_as_Origin_Ctry]
         =   1
/*********************************************************************************************************/
-- Update display by country to 0 for the proper countries of origin/destination:
UPDATE
             [forum].[dbo].[Pew_Migration]
SET
             [forum].[dbo].[Pew_Migration].[Display_as_Origin_Ctry]
         =   0
WHERE
            ( origin_nation_fk      =  41 )   -- Channel Islands
       OR   ( origin_nation_fk      =  67 )   -- Falkland Islands (Malvinas)
       OR   ( origin_nation_fk      =  78 )   -- Gibraltar
       OR   ( origin_nation_fk      =  83 )   -- Guam
       OR   ( origin_nation_fk      =  99 )   -- Isle of Man
       OR   ( origin_nation_fk      = 154 )   -- North Korea
       OR   ( origin_nation_fk      = 175 )   -- St. Helena
       OR   ( origin_nation_fk      = 176 )   -- St. Kitts and Nevis
       OR   ( origin_nation_fk      = 177 )   -- St. Lucia
       OR   ( origin_nation_fk      = 222 )   -- U.S. Virgin Islands
       OR   ( origin_nation_fk      =  89 )   -- Vatican City
       OR   ( origin_nation_fk      = 228 )   -- Wallis and Futuna

UPDATE
             [forum].[dbo].[Pew_Migration]
SET
             [forum].[dbo].[Pew_Migration].[Display_as_Destination_Ctry]
         =   0
WHERE
            ( destination_nation_fk =   3 )   -- Algeria
       OR   ( destination_nation_fk =   6 )   -- Angola
       OR   ( destination_nation_fk =  16 )   -- Bahrain
       OR   ( destination_nation_fk =  17 )   -- Bangladesh
       OR   ( destination_nation_fk =  26 )   -- Bosnia-Herzegovina
       OR   ( destination_nation_fk =  27 )   -- Botswana
       OR   ( destination_nation_fk =  33 )   -- Burundi
       OR   ( destination_nation_fk =  35 )   -- Cameroon
       OR   ( destination_nation_fk =  39 )   -- Central African Republic
       OR   ( destination_nation_fk =  43 )   -- China
       OR   ( destination_nation_fk =  62 )   -- Equatorial Guinea
       OR   ( destination_nation_fk =  63 )   -- Eritrea
       OR   ( destination_nation_fk =  65 )   -- Ethiopia
       OR   ( destination_nation_fk =  68 )   -- Fiji
       OR   ( destination_nation_fk =  72 )   -- French Polynesia
       OR   ( destination_nation_fk =  77 )   -- Ghana
       OR   ( destination_nation_fk =  81 )   -- Grenada
       OR   ( destination_nation_fk =  88 )   -- Haiti
       OR   ( destination_nation_fk = 108 )   -- Kosovo
       OR   ( destination_nation_fk = 109 )   -- Kuwait
       OR   ( destination_nation_fk = 113 )   -- Lebanon
       OR   ( destination_nation_fk = 115 )   -- Liberia
       OR   ( destination_nation_fk = 116 )   -- Libya
       OR   ( destination_nation_fk = 125 )   -- Maldives
       OR   ( destination_nation_fk = 130 )   -- Mauritania
       OR   ( destination_nation_fk = 135 )   -- Moldova
       OR   ( destination_nation_fk = 140 )   -- Morocco
       OR   ( destination_nation_fk = 148 )   -- New Caledonia
       OR   ( destination_nation_fk = 154 )   -- North Korea
       OR   ( destination_nation_fk = 158 )   -- Pakistan
       OR   ( destination_nation_fk = 170 )   -- Qatar
       OR   ( destination_nation_fk = 181 )   -- San Marino
       OR   ( destination_nation_fk = 184 )   -- Senegal
       OR   ( destination_nation_fk = 192 )   -- Somalia
       OR   ( destination_nation_fk = 196 )   -- Sri Lanka
       OR   ( destination_nation_fk = 202 )   -- Syria
       OR   ( destination_nation_fk = 208 )   -- Togo
       OR   ( destination_nation_fk = 210 )   -- Tonga
       OR   ( destination_nation_fk = 214 )   -- Turkmenistan
       OR   ( destination_nation_fk = 219 )   -- United Arab Emirates
       OR   ( destination_nation_fk = 224 )   -- Uzbekistan
       OR   ( destination_nation_fk = 89 )   -- Vatican City
       OR   ( destination_nation_fk = 227 )   -- Vietnam
       OR   ( destination_nation_fk = 229 )   -- Western Sahara
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
             [forum].[dbo].[Pew_Migration].[Display_by_Religion] 
         =   0

SELECT 
       distinct
       destination_nation_fk
  FROM
             [forum].[dbo].[Pew_Migration]
WHERE
             [forum].[dbo].[Pew_Migration].[Display_as_Destination_Ctry] 
         =   0

SELECT 
       distinct
       origin_nation_fk
  FROM
             [forum].[dbo].[Pew_Migration]
WHERE
             [forum].[dbo].[Pew_Migration].[Display_as_Origin_Ctry] 
         =   0










