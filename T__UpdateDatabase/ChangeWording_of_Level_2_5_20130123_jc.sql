/****************************************************************************************************************/
-- January 23, 2013
/****************************************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Religion_Group]

SET   Pew_religion_lev02_5 = 'Protestants'
WHERE Pew_religion_lev02_5 = 'Inclusive Protestants'

UPDATE     [forum].[dbo].[Pew_Religion_Group]

SET   Pew_religion_lev02_5 = 'Catholics'
WHERE Pew_religion_lev02_5 = 'Roman Catholics'


/****************************************************************************************************************/

