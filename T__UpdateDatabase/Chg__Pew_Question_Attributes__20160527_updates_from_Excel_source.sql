/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
/*****                                                    STEP 000                                                    *****/
/*****                                           BackUp  current Table(s)                                             *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Attributes' + '_' + @CrDt + ']
                  FROM      [forum].[dbo].[Pew_Question_Attributes]'                      )
/**************************************************************************************************************************/

/**************************************************************************************************************************/
-- Update from joined data/table:
--   Other table cannot be directly used when having the same exposed name
--   We use correlation names--if necessary--to distinguish them.
UPDATE
                            [forum].[dbo].[Pew_Question_Attributes]
SET
                            [forum].[dbo].[Pew_Question_Attributes].[attr]
                          =                                 [newdt].[x]
--select *
FROM
                            [forum].[dbo].[Pew_Question_Attributes]                                                            AS mydbt
                JOIN
                       (          SELECT [k] =   949, [x] = 'Nested categories add to more than total because countries can'
                                                           + ' have multiple types of cases of government force.'
                                                           + CHAR(10)
                                                           + '^ This line represents the number or percentage of countries '
                                                           + 'in which at least one of the following types of government fo'
                                                           + 'rce occurred.'
                        UNION ALL SELECT [k] =  1063, [x] = 'This is a summary table that captures the types of religious h'
                                                           + 'atred or bias.'
                                                           + CHAR(10)
                                                           + 'Nested categories add to more than total because countries ca'
                                                           + 'n have multiple types of hostilities.'
                                                           + CHAR(10)
                                                           + '^ This line represents the number or percentage of countries '
                                                           + 'in which at least one of the following hostilities occurred.'
                                                           + CHAR(10)
                                                           + 'Each country''s score for each type of religious hatred or bia'
                                                           + 's is available in SHI.Q.1a-f in the Results by Country (online'
                                                           + ').'
                        UNION ALL SELECT [k] =   453, [x] =  'This is a summary table that captures the severity of religiou'
                                                           + 'S hatred or bias.'
                                                           + CHAR(10)
                                                           + 'Each country''s score based on how many of the six types of re'
                                                           + 'ligious hatred or bias were documented is available in SHI.Q.1'
                                                           + ' in the Results by Country (online).'
                        UNION ALL SELECT [k] =  1097, [x] =  'Religion-related terrorism is defined as politically motivated'
                                                           + ' violence agaisnt noncombatants by subnational groups or cland'
                                                           + 'estine agents with a religious justification or intent.'                        UNION ALL SELECT [k] =  1103, [x] =  'Religion-related war is defined as armed conflict (involving s'
                                                           + 'ustained casualties over time or more than 1,000 battle deaths'
                                                           + ') in which religious rhetoric is commonly employed to justify '
                                                           + 'the use of force, or in which one or more of the combatants pr'
                                                           + 'imarily identifies itself or the opposings side by religion.'
                        UNION ALL SELECT [k] =   592, [x] =  'The data for each year also take into account information from'
                                                           + ' the two previous years.'
                        UNION ALL SELECT [k] =  1108, [x] =  'The data for each year also take into account information from'
                                                           + ' the two previous years.'
                        UNION ALL SELECT [k] =   607, [x] =  'The data for each year also take into account information from'
                                                           + ' the two previous years.'
                        UNION ALL SELECT [k] =   615, [x] =  'The data for each year also take into account information from'
                                                           + ' the two previous years.'
                        UNION ALL SELECT [k] =   623, [x] =  'The data for each year also take into account information from'
                                                          + ' the two previous years.'
                        UNION ALL SELECT [k] =   906, [x] =  'The data for each year also take into account information from'
                                                           + ' the two previous years.'
                        UNION ALL SELECT [k] =   638, [x] =  'The data for each year also take into account information from'
                                                           + ' the two previous years.'
                        UNION ALL SELECT [k] =   646, [x] =  'The data for each year also take into account information from'
                                                           + ' the two previous years.'                                      ) AS newdt
            ON
                  mydbt.[Question_Attributes_pk]
              =   newdt.[k]
/**************************************************************************************************************************/
