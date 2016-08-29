--/*********************************************************************************************************************************************************/
--SELECT
--       [id-in_table]
--     , [Ctry_pk]
--     , [Locality_pk]
--     , [QA_std]
--     , [VALUE]       = CASE 
--                            WHEN [VALUE] IS NULL
--                            THEN ''
--                            ELSE [VALUE]
--                            END
--     , [WORDING]     = CASE 
--                            WHEN [WORDING] IS NULL
--                            THEN ''
--                            ELSE [WORDING]
--                            END
--     , [T_ID]       
--     , [V_ID]       
--     , [T_rowid]    
--     , [V_rowid]    
--     , [T_Name]     
--     , [V_Name]     
--     , [T_coder]    
--     , [V_coder]    
--     , [T_YEAR]     
--     , [V_YEAR]     
--     , [T_QA_std_x] 
--     , [V_QA_std_x] 
--     , [T_Ctry_fk]  
--     , [V_Ctry_fk]  
--     , [T_datestamp]
--     , [V_datestamp]
--     , [T_Localt_fk]
--     , [V_Localt_fk]
--     , [T_expltext] 
--     , [V_expltext] 
--     , [T_jckey1]   
--     , [V_jckey1]   
--     , [T_jckey2]   
--     , [V_jckey2]   
--     , [T_lsvarname]
--     , [V_lsvarname]
--INTO
--        [dbo].[LS_all_extracted_data]
--FROM
--(
--SELECT
--       [id-in_table] = CASE 
--                            WHEN T.[ID] IS NOT NULL
--                            THEN T.[ID]
--                            ELSE V.[ID]
--                            END  
--     , [Ctry_pk]     = CASE 
--                            WHEN T.[Ctry_fk] IS NOT NULL
--                            THEN T.[Ctry_fk]
--                            ELSE V.[Ctry_fk]
--                            END  
--     , [Locality_pk] = CASE 
--                            WHEN T.[Locality_fk] IS NOT NULL
--                            THEN T.[Locality_fk]
--                            ELSE V.[Locality_fk]
--                            END  
--     , [QA_std]      = CASE 
--                            WHEN T.[QA_std_x] IS NOT NULL
--                            THEN T.[QA_std_x]
--                            ELSE V.[QA_std_x]
--                            END  
--     , [VALUE]       =           V.[expltext]
--     , [WORDING]     =           T.[expltext]
--     , [T_ID]        = T.[ID]
--     , [V_ID]        = V.[ID]  
--     , [T_rowid]     = T.[rowid]
--     , [V_rowid]     = V.[rowid]  
--     , [T_Name]      = T.[Name]
--     , [V_Name]      = V.[Name]
--     , [T_coder]     = T.[coder]
--     , [V_coder]     = V.[coder]
--     , [T_YEAR]      = T.[YEAR]
--     , [V_YEAR]      = V.[YEAR]
--     , [T_QA_std_x]  = T.[QA_std_x]
--     , [V_QA_std_x]  = V.[QA_std_x]
--     , [T_Ctry_fk]   = T.[Ctry_fk]
--     , [V_Ctry_fk]   = V.[Ctry_fk]
--     , [T_datestamp] = T.[datestamp]
--     , [V_datestamp] = V.[datestamp]
--     , [T_Localt_fk] = T.[Locality_fk]
--     , [V_Localt_fk] = V.[Locality_fk]
--     , [T_expltext]  = T.[expltext]
--     , [V_expltext]  = V.[expltext]
--     , [T_jckey1]    = T.[jckey1]
--     , [V_jckey1]    = V.[jckey1]
--     , [T_jckey2]    = T.[jckey2]
--     , [V_jckey2]    = V.[jckey2]
--     , [T_lsvarname] = T.[lsvarname]
--     , [V_lsvarname] = V.[lsvarname]
--/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
--FROM
--        [dbo].[LimeTxt]   T
--FULL OUTER JOIN
--        [dbo].[LimeVal]   V
--  ON
--       T.[ID]
--     = V.[ID]
--  AND  T.[QA_std_x]
--     = V.[QA_std_x]
--) AS ALLDATA
--/*********************************************************************************************************************************************************/



IF OBJECT_ID('tempdb..#limesurvey_tmp') IS NOT NULL
DROP TABLE            #limesurvey_tmp
/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
       [repeated]    = SUM([C]) OVER (PARTITION BY QA_std, Ctry_pk, Locality_pk                                               )
      ,[NEWEST]      = RANK()   OVER (PARTITION BY QA_std, Ctry_pk, Locality_pk          ORDER BY [T_YEAR], [T_datestamp] DESC)
      ,[selected]    = CASE 
                       WHEN
                       RANK()   OVER (PARTITION BY QA_std, Ctry_pk, Locality_pk, [T_YEAR] ORDER BY           [T_datestamp] DESC)
                       =1
                       THEN  'YES'
                       ELSE  'NO'
                       END
      , *
-- INTO [#limesurvey_tmp] 
 FROM
      ( SELECT
                [C] = 1
              , *
        FROM [juancarlos].[dbo].[LS_all_extracted_data]  )   CPLUS
/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/


select
       S1.[QA_std]
      ,S1.[Ctry_pk]
      ,S1.[Locality_pk]
      ,S1.[WORDING]
      ,S2.[WORDING]
      ,S1.[VALUE]
      ,S2.[VALUE]
      , *
from

(
select *
from   [#limesurvey_tmp] 
where  [repeated]          = 2
and    [NEWEST]            = 1  ) S1
JOIN
(
select *
from   [#limesurvey_tmp] 
where  [repeated]          = 2
and    [NEWEST]            = 2  ) S2
ON
       S1.[QA_std]
      =S2.[QA_std]
AND       
       S1.[Ctry_pk]
      =S2.[Ctry_pk]
AND
       S1.[Locality_pk]
      =S2.[Locality_pk]

