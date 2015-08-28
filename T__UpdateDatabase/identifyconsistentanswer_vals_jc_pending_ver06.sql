USE juancarlos;
GO
/*********************************************************************************************************************************************************/
------SELECT
------       [id-in_table]
------     , [Ctry_pk]
------     , [Locality_pk]
------     , [QA_std]
------     , [VALUE]       = CASE 
------                            WHEN [VALUE] IS NULL
------                            THEN ''
------                            ELSE [VALUE]
------                            END
------     , [WORDING]     = CASE 
------                            WHEN [WORDING] IS NULL
------                            THEN ''
------                            ELSE [WORDING]
------                            END
--------INTO
--------        [dbo].[LS_all_extracted_data]
------FROM
------(
------SELECT
------       [id-in_table] = CASE 
------                            WHEN T.[ID] IS NOT NULL
------                            THEN T.[ID]
------                            ELSE V.[ID]
------                            END  
------     , [Ctry_pk]     = CASE 
------                            WHEN T.[Ctry_fk] IS NOT NULL
------                            THEN T.[Ctry_fk]
------                            ELSE V.[Ctry_fk]
------                            END  
------     , [Locality_pk] = CASE 
------                            WHEN T.[Locality_fk] IS NOT NULL
------                            THEN T.[Locality_fk]
------                            ELSE V.[Locality_fk]
------                            END  
------     , [QA_std]      = CASE 
------                            WHEN T.[QA_std_x] IS NOT NULL
------                            THEN T.[QA_std_x]
------                            ELSE V.[QA_std_x]
------                            END  
------     , [VALUE]       =           V.[expltext]
------     , [WORDING]     =           T.[expltext]
------     , [T_ID]        = T.[ID]
------     , [V_ID]        = V.[ID]  
------     , [T_rowid]     = T.[rowid]
------     , [V_rowid]     = V.[rowid]  
------     , [T_Name]      = T.[Name]
------     , [V_Name]      = V.[Name]
------     , [T_coder]     = T.[coder]
------     , [V_coder]     = V.[coder]
------     , [T_YEAR]      = T.[YEAR]
------     , [V_YEAR]      = V.[YEAR]
------     , [T_QA_std_x]  = T.[QA_std_x]
------     , [V_QA_std_x]  = V.[QA_std_x]
------     , [T_Ctry_fk]   = T.[Ctry_fk]
------     , [V_Ctry_fk]   = V.[Ctry_fk]
------     , [T_Localt_fk] = T.[Locality_fk]
------     , [V_Localt_fk] = V.[Locality_fk]
------     , [T_expltext]  = T.[expltext]
------     , [V_expltext]  = V.[expltext]
------     , [T_jckey1]    = T.[jckey1]
------     , [V_jckey1]    = V.[jckey1]
------     , [T_jckey2]    = T.[jckey2]
------     , [V_jckey2]    = V.[jckey2]
------     , [T_lsvarname] = T.[lsvarname]
------     , [V_lsvarname] = V.[lsvarname]
------/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
------FROM
------        [dbo].[LimeTxt]   T
------FULL OUTER JOIN
------        [dbo].[LimeVal]   V
------  ON
------       T.[ID]
------     = V.[ID]
------  AND  T.[QA_std_x]
------     = V.[QA_std_x]
------) AS ALLDATA
----/*********************************************************************************************************************************************************/
----/*********************************************************************************************************************************************************/
----IF OBJECT_ID('tempdb..#restriction_tmp') IS NOT NULL
----DROP TABLE            #restriction_tmp
----/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
----SELECT *
---- INTO [#restriction_tmp] 
----FROM
----(
----/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
----SELECT 
----       [Answer_pk]
----      ,[Question_pk]
----      ,[Year]          = [Question_Year]
----      ,[Question_Short_Wording_std]
----      ,[QA_std_x]      = [Question_abbreviation_std]
----      ,[Ctry_fk]       = [Nation_fk]
----      ,[Locality_fk]
----      ,[currvalue]     = [Answer_value]
----      ,[currwording]   = [Answer_wording]
----      ,[answer_wording_std]
----  FROM [forum].[dbo].[Pew_Answer]
----     , [forum].[dbo].[Pew_Question]
----     , [forum].[dbo].[Pew_Locality]
----     , [forum].[dbo].[Pew_Locality_Answer]
----where 
----question_fk = question_pk 
----and
----answer_fk = answer_pk 
----and
----locality_fk = locality_pk 
----/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
----UNION ALL
----/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
----SELECT 
----       [Answer_pk]
----      ,[Question_pk]
----      ,[Year]          = [Question_Year]
----      ,[Question_Short_Wording_std]
----      ,[QA_std_x]      = [Question_abbreviation_std]
----      ,[Ctry_fk]       = [Nation_fk]
----      ,[Locality_fk]   = 0
----      ,[currvalue]     = [Answer_value]
----      ,[currwording]   = [Answer_wording]
----      ,[answer_wording_std]
----  FROM [forum].[dbo].[Pew_Answer]
----     , [forum].[dbo].[Pew_Question]
----     , [forum].[dbo].[Pew_Nation_Answer]
----where 
----question_fk = question_pk 
----and
----answer_fk = answer_pk 
----/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
----) loc_and_ctry
----/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
----WHERE
----[Year] = 2011
----AND
----[QA_std_x]
----   NOT IN (
----            'GRX_22_01'
----           ,'GRX_22_02'
----           ,'GRX_22_03'
----           ,'GRX_22_04'
----                        )
----/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
--/*********************************************************************************************************************************************************/
--/*********************************************************************************************************************************************************/
--IF OBJECT_ID('tempdb..#limesurvey_tmp') IS NOT NULL
--DROP TABLE            #limesurvey_tmp
--/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
--SELECT 
--       [repeated]    = SUM([C]) OVER (PARTITION BY QA_std, Ctry_pk, Locality_pk)
--      ,[id-in_table]
--      ,[Ctry_pk]
--      ,[Locality_pk]
--      ,[QA_std]      = CASE
--                            WHEN [QA_std] = 'GRX_20_05x' THEN 'GRI_20_05_x'
--                            ELSE [QA_std]
--                            END

--      ,[VALUE]
--      ,[WORDING]
-- INTO [#limesurvey_tmp] 
-- FROM
--      ( SELECT
--                [C] = 1
--              , *
--        FROM [juancarlos].[dbo].[LS_all_extracted_data]  )   CPLUS
--/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
--select *
--from   [#limesurvey_tmp] 
--where  [repeated]          = 2
/*********************************************************************************************************************************************************/
/*--- start testing: "in LS but NOT loaded" -------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
-- in LS but NOT loaded
SELECT 
       [id-in_table]
      ,[YEAR]
      ,[Question_Short_Wording_std]
      ,[QA_std]
      ,[QA_std_x]
      ,[Ctry_pk]
      ,[Ctry_fk]
      ,[Locality_pk]
      ,[Locality_fk]
      ,[value]
      ,[currvalue]
      ,[wording]
      ,[currwording]
      ,[answer_wording_std]
      ,[repeated]
--      , err = case WHEN T2.currwording IS NULL THEN 1 END 
FROM
                --select * from                                            -- 13,836
                --select distinct QA_std, Ctry_pk, Locality_pk from        -- 13,786
                --select distinct QA_std                       from        --     97
                [#limesurvey_tmp]       T1
left OUTER JOIN 
                --select * from
                --select distinct QA_std_x, Ctry_fk, Locality_fk from      -- 17,113
                --select distinct QA_std_x                       from      --    102
                [#restriction_tmp]        T2
                --where QA_std_x LIKE 'SHI_04%' and Ctry_fk = 70

ON  T1.Ctry_pk     = T2.Ctry_fk 
AND T1.Locality_pk = T2.Locality_fk
AND T1.QA_std      = T2.QA_std_x
WHERE 
/*--- only not diplayed in datbase set: -----------------------------------------------------------------------------------------------------------------*/
          QA_std_x  IS NULL
/*--- exclude meaningless row added to province data after coding period --------------------------------------------------------------------------------*/
AND NOT
          [id-in_table]  = 797
/*--- exclude province data with no value nor wording ---------------------------------------------------------------------------------------------------*/
AND NOT
   (      
          QA_std IN ( 
                        'GRI_01_x2'
                      , 'GRI_19_b'
                      , 'GRI_19_c'
                      , 'GRI_19_d'
                      , 'GRI_19_e'
                      , 'GRI_19_f'
                      , 'SHI_01_b'
                      , 'SHI_01_c'
                      , 'SHI_01_d'
                      , 'SHI_01_e'
                      , 'SHI_01_f'
                      , 'SHI_04_b'
                      , 'SHI_04_c'
                      , 'SHI_04_d'
                      , 'SHI_04_e'
                      , 'SHI_04_f'
                      , 'SHI_05_b'
                      , 'SHI_05_c'
                      , 'SHI_05_d'
                      , 'SHI_05_e'
                      , 'SHI_05_f'
                                   )
      AND
         (value = '0' OR value = '')
      AND
          wording = ''
   )
/*--- exclude Angelina's corrections dropping data ------------------------------------------------------------------------------------------------------*/
AND NOT
   (      
          QA_std IN ( 
                        'GRI_19_c'
                      , 'GRI_19_d'
                      , 'GRI_19_e'
                      , 'GRI_19_f'
                                   )
      AND
          [Ctry_pk] = '100'
   )
/*--- provisionally exclude identified undocumented differences -----------------------------------------------------------------------------------------*/
AND NOT
   (      
          QA_std IN ( 
                        'SHI_04_b'
                      , 'SHI_04_e'
                                   )
      AND
          [Ctry_pk] = '70'
   )
/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/
AND NOT
   (      
          QA_std IN ( 
                        'SHI_04_b'
                                   )
      AND
          [Ctry_pk] = '145'
   )
/*-------------------------------------------------------------------------------------------------------------------------------------------------------*/

--QA_std	QA_std_x	Ctry_pk
--SHI_04_b	NULL	196
--SHI_04_e	NULL	196


--(      
--         T2.currwording IS NULL
--OR
--         T2.currvalue IS NULL
--)
--and NOT
--(      T1.QA_std_x = 'GRI_19_d'
--   AND T1.Ctry_fk  = 100
--)
--AND NOT
--(      T1.QA_std_x = 'SHI_04_b'
--   AND T1.Ctry_fk  = 145
--        -- in terms of "Was property damaged due to religion-related terrorism?"
--        -- The answer was dropped and is only at country level for explining value of 0.25:
--        --   Were religion-related terrorist groups active in the country?
--        --   Yes, but their activity was limited to recruitment and fundraising
--        --  Text is:
--        --          A crude bomb went off Tuesday afternoon (Nov. 22) in front of a leading Christian
--        --          charitable organization’s office in this capital city, sowing fresh fear and insecurity
--        --          among Christians ahead of a critical constitutional deadline. Police said they were 
--        --          investigating the explosion in front of the office of the United Mission to Nepal (UMN).
--        --          While the crude bomb claimed no casualties or damage to the UMN office, it shocked area 
--        --          Christians. The UMN, a Christian international non-governmental organization founded in 
--        --          1954 by Christian groups from almost 60 countries, has built hospitals, schools, hydropower 
--        --          plants and industrial development and training institutions in Nepal. At the site police found 
--        --          leaflets signed by someone calling himself a senior member of the Nepal Defense Army (NDA), a 
--        --          militant armed group that has terrorized Christians and Muslims, demanding that they leave Nepal. 
--        --          The leaflets asserted that the majority population in Nepal was Hindu and that therefore it should 
--        --          be a Hindu state. The leaflets also accused the UMN of converting Hindus to Christianity. (HRWF 2011). 
--)
ORDER BY
       T2.[QA_std_x]
      ,T1.[QA_std]
      ,T2.[Ctry_fk]
      ,T2.[Locality_fk]
/*********************************************************************************************************************************/
---- Not in LS
--SELECT T1.[rowid]
--      ,T1.[YEAR]
--      ,[Question_Short_Wording_std]
--      ,QA1 = T1.[QA_std_x]
--      ,T2.[QA_std_x]
--      ,T2.[Ctry_fk]
--      ,T1.[Locality_fk]
--      ,[Answer_value]
--      ,[expltext]
--         ,T2.currwording
--      ,[answer_wording_std]
--      , err = case WHEN T2.currwording IS NULL THEN 1 END 
----into  [juancarlos].[dbo].[test]
--FROM [LimeTemp_v] T1
--RIGHT OUTER JOIN #restriction_tmp T2
--ON T1.Ctry_fk = T2.Ctry_fk 
--AND T1.Locality_fk = T2.Locality_fk
--AND T1.QA_std_x = T2.QA_std_x
----WHERE 
----             T1.expltext IS NULL
----        AND
----             LTRIM(RTRIM(currwording)) != LTRIM(RTRIM(answer_wording_std))
----        AND
----             currwording != 'No description coded'
----        AND NOT
----             (     T2.QA_std_x     = 'SHI_05'
----               AND Answer_value	= 0.25
----               AND currwording  = 'Yes, with fewer than 10,000 casualties or people displaced from their homes'
----             )
-------  all later corrections  ------------------------------------------------------------------------------------
----        AND NOT ( T2.QA_std_x     = 'GRI_04' AND T2.Ctry_fk =87)
----        AND NOT ( T2.QA_std_x     = 'GRI_05' AND T2.Ctry_fk =79)
----        AND NOT ( T2.QA_std_x     = 'GRI_05' AND T2.Ctry_fk =218)
----        AND NOT ( T2.QA_std_x     = 'GRI_06' AND T2.Ctry_fk =17)
----        AND NOT ( T2.QA_std_x     = 'GRI_06' AND T2.Ctry_fk =65)
----        AND NOT ( T2.QA_std_x     = 'GRI_06' AND T2.Ctry_fk =216)
----        AND NOT ( T2.QA_std_x     = 'GRI_07' AND T2.Ctry_fk =113)
----        AND NOT ( T2.QA_std_x     = 'GRI_08' AND T2.Ctry_fk =34)
----        AND NOT ( T2.QA_std_x     = 'GRI_09' AND T2.Ctry_fk =1)
----        AND NOT ( T2.QA_std_x     = 'GRI_09' AND T2.Ctry_fk =79)
----        AND NOT ( T2.QA_std_x     = 'GRI_09' AND T2.Ctry_fk =87)
----        AND NOT ( T2.QA_std_x     = 'GRI_09' AND T2.Ctry_fk =160)
----        AND NOT ( T2.QA_std_x     = 'GRI_09' AND T2.Ctry_fk =216)
----        AND NOT ( T2.QA_std_x     = 'GRI_10' AND T2.Ctry_fk =17)
----        AND NOT ( T2.QA_std_x     = 'GRI_10' AND T2.Ctry_fk =65)
----        AND NOT ( T2.QA_std_x     = 'GRI_10' AND T2.Ctry_fk =218)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =8)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =17)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =18)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =34)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =49)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =51)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =57)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =87)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =126)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =157)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =158)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =176)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =177)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =179)
----        AND NOT ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =212)
----        AND NOT ( T2.QA_std_x     = 'GRI_12' AND T2.Ctry_fk =17)
----        AND NOT ( T2.QA_std_x     = 'GRI_12' AND T2.Ctry_fk =130)
----        AND NOT ( T2.QA_std_x     = 'GRI_13' AND T2.Ctry_fk =79)
----        AND NOT ( T2.QA_std_x     = 'GRI_13' AND T2.Ctry_fk =103)
----        AND NOT ( T2.QA_std_x     = 'GRI_13' AND T2.Ctry_fk =113)
----        AND NOT ( T2.QA_std_x     = 'GRI_13' AND T2.Ctry_fk =160)
----        AND NOT ( T2.QA_std_x     = 'GRI_13' AND T2.Ctry_fk =192)
----        AND NOT ( T2.QA_std_x     = 'GRI_13' AND T2.Ctry_fk =217)
----        AND NOT ( T2.QA_std_x     = 'GRI_13' AND T2.Ctry_fk =230)
----        AND NOT ( T2.QA_std_x     = 'GRI_13' AND T2.Ctry_fk =232)
----        AND NOT ( T2.QA_std_x     = 'GRI_14' AND T2.Ctry_fk =103)
----        AND NOT ( T2.QA_std_x     = 'GRI_14' AND T2.Ctry_fk =160)
----        AND NOT ( T2.QA_std_x     = 'GRI_14' AND T2.Ctry_fk =212)
----        AND NOT ( T2.QA_std_x     = 'GRI_15' AND T2.Ctry_fk =40)
----        AND NOT ( T2.QA_std_x     = 'GRI_15' AND T2.Ctry_fk =60)
----        AND NOT ( T2.QA_std_x     = 'GRI_16' AND T2.Ctry_fk =1)
----        AND NOT ( T2.QA_std_x     = 'GRI_16' AND T2.Ctry_fk =183)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =1)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =14)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =16)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =30)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =65)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =95)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =124)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =137)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =158)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =173)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =188)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =214)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =230)
----        AND NOT ( T2.QA_std_x     = 'GRI_17' AND T2.Ctry_fk =232)
----        AND NOT ( T2.QA_std_x     = 'GRI_18' AND T2.Ctry_fk =1)
----        AND NOT ( T2.QA_std_x     = 'GRI_18' AND T2.Ctry_fk =183)
----        AND NOT ( T2.QA_std_x     = 'SHI_02' AND T2.Ctry_fk =33)
----        AND NOT ( T2.QA_std_x     = 'SHI_02' AND T2.Ctry_fk =39)
----        AND NOT ( T2.QA_std_x     = 'SHI_02' AND T2.Ctry_fk =43)
----        AND NOT ( T2.QA_std_x     = 'SHI_02' AND T2.Ctry_fk =173)
----        AND NOT ( T2.QA_std_x     = 'SHI_03' AND T2.Ctry_fk =106)
----        AND NOT ( T2.QA_std_x     = 'SHI_03' AND T2.Ctry_fk =108)
----        AND NOT ( T2.QA_std_x     = 'SHI_03' AND T2.Ctry_fk =138)
----        AND NOT ( T2.QA_std_x     = 'SHI_03' AND T2.Ctry_fk =173)
----        AND NOT ( T2.QA_std_x     = 'SHI_03' AND T2.Ctry_fk =220)
----        AND NOT ( T2.QA_std_x     = 'SHI_04' AND T2.Ctry_fk =108)
----        AND NOT ( T2.QA_std_x     = 'SHI_04' AND T2.Ctry_fk =109)
----        AND NOT ( T2.QA_std_x     = 'SHI_04' AND T2.Ctry_fk =201)
----        AND NOT ( T2.QA_std_x     = 'SHI_06' AND T2.Ctry_fk =117)
----        AND NOT ( T2.QA_std_x     = 'SHI_06' AND T2.Ctry_fk =118)
----        AND NOT ( T2.QA_std_x     = 'SHI_07' AND T2.Ctry_fk =20)
----        AND NOT ( T2.QA_std_x     = 'SHI_07' AND T2.Ctry_fk =109)
----        AND NOT ( T2.QA_std_x     = 'SHI_07' AND T2.Ctry_fk =118)
----        AND NOT ( T2.QA_std_x     = 'SHI_07' AND T2.Ctry_fk =142)
----        AND NOT ( T2.QA_std_x     = 'SHI_07' AND T2.Ctry_fk =146)
----        AND NOT ( T2.QA_std_x     = 'SHI_07' AND T2.Ctry_fk =156)
----        AND NOT ( T2.QA_std_x     = 'SHI_08' AND T2.Ctry_fk =185)
----        AND NOT ( T2.QA_std_x     = 'SHI_09' AND T2.Ctry_fk =111)
----        AND NOT ( T2.QA_std_x     = 'SHI_09' AND T2.Ctry_fk =217)
----        AND NOT ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =33)
----        AND NOT ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =104)
----        AND NOT ( T2.QA_std_x     = 'SHI_11' AND T2.Ctry_fk =17)
----        AND NOT ( T2.QA_std_x     = 'SHI_11' AND T2.Ctry_fk =117)
----        AND NOT ( T2.QA_std_x     = 'SHI_11' AND T2.Ctry_fk =202)
----        AND NOT ( T2.QA_std_x     = 'SHI_11' AND T2.Ctry_fk =213)
----        AND NOT ( T2.QA_std_x     = 'SHI_12' AND T2.Ctry_fk =43)
----        AND NOT ( T2.QA_std_x     = 'SHI_12' AND T2.Ctry_fk =106)
----        AND NOT ( T2.QA_std_x     = 'SHI_12' AND T2.Ctry_fk =217)
----        AND NOT ( T2.QA_std_x     = 'SHI_13' AND T2.Ctry_fk =96)
----        AND NOT ( T2.QA_std_x     = 'SHI_13' AND T2.Ctry_fk =173)
----        AND NOT ( T2.QA_std_x     = 'SHI_13' AND T2.Ctry_fk =220)
-------  al later corrections  -------------------------------------------------------------------------------------
----ORDER BY
----       T2.[QA_std_x]
----      ,T2.[Ctry_fk]
----      ,T1.[Locality_fk]
--/*********************************************************************************************************************************/
---- differences




--SELECT T1.[rowid]
--      ,T1.[YEAR]
--      ,T1.[QA_std_x]
--      ,T1.[Ctry_fk]
--      ,T1.[Locality_fk]
--      ,[expltext]
--      ,T2.currwording
--      ,[Answer_value]
------INTO juancarlos.dbo.test
--FROM [LimeTemp] T1
--JOIN #restriction_tmp T2
--     ON    T1.Ctry_fk     = T2.Ctry_fk 
--       AND T1.Locality_fk = T2.Locality_fk
--       AND T1.QA_std_x    = T2.QA_std_x
--WHERE
--------------------------------------------------------------------------------------------------------------------------------
--                    T1.expltext 
--           NOT LIKE T2.currwording
------- corrected later: (do not over-write) -----------------------------------------------------------------------------------
--       and not ( T2.QA_std_x     = 'GRI_04' AND T2.Ctry_fk =65)
--       and not ( T2.QA_std_x     = 'GRI_05' AND T2.Ctry_fk =60)
--       and not ( T2.QA_std_x     = 'GRI_08' AND T2.Ctry_fk =60)
--       and not ( T2.QA_std_x     = 'GRI_09' AND T2.Ctry_fk =6)
--       and not ( T2.QA_std_x     = 'GRI_09' AND T2.Ctry_fk =91)
--       and not ( T2.QA_std_x     = 'GRI_10' AND T2.Ctry_fk =158)
--       and not ( T2.QA_std_x     = 'GRI_12' AND T2.Ctry_fk =49)
--       and not ( T2.QA_std_x     = 'GRI_13' AND T2.Ctry_fk =109)
--       and not ( T2.QA_std_x     = 'GRI_14' AND T2.Ctry_fk =1)
--       and not ( T2.QA_std_x     = 'GRI_15' AND T2.Ctry_fk =100)
--       and not ( T2.QA_std_x     = 'GRI_16' AND T2.Ctry_fk =60)
--       and not ( T2.QA_std_x     = 'GRI_18' AND T2.Ctry_fk =34)
--       and not ( T2.QA_std_x     = 'GRI_18' AND T2.Ctry_fk =216)
--       and not ( T2.QA_std_x     = 'SHI_02' AND T2.Ctry_fk =20)
--       and not ( T2.QA_std_x     = 'SHI_02' AND T2.Ctry_fk =109)
--       and not ( T2.QA_std_x     = 'SHI_02' AND T2.Ctry_fk =199)
--       and not ( T2.QA_std_x     = 'SHI_04' AND T2.Ctry_fk =183)
--       and not ( T2.QA_std_x     = 'SHI_06' AND T2.Ctry_fk =142)
--       and not ( T2.QA_std_x     = 'SHI_06' AND T2.Ctry_fk =28)
--       and not ( T2.QA_std_x     = 'SHI_06' AND T2.Ctry_fk =98)
--       and not ( T2.QA_std_x     = 'SHI_06' AND T2.Ctry_fk =135)
--       and not ( T2.QA_std_x     = 'SHI_07' AND T2.Ctry_fk =185)
--       and not ( T2.QA_std_x     = 'SHI_08' AND T2.Ctry_fk =221)
--       and not ( T2.QA_std_x     = 'SHI_08' AND T2.Ctry_fk =45)
--       and not ( T2.QA_std_x     = 'SHI_08' AND T2.Ctry_fk =184)
--       and not ( T2.QA_std_x     = 'SHI_09' AND T2.Ctry_fk =28)
--       and not ( T2.QA_std_x     = 'SHI_09' AND T2.Ctry_fk =90)
--       and not ( T2.QA_std_x     = 'SHI_09' AND T2.Ctry_fk =184)
--       and not ( T2.QA_std_x     = 'SHI_09' AND T2.Ctry_fk =167)
--       and not ( T2.QA_std_x     = 'SHI_09' AND T2.Ctry_fk =185)
--       and not ( T2.QA_std_x     = 'SHI_09' AND T2.Ctry_fk =227)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =221)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =19)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =20)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =36)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =44)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =54)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =70)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =90)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =138)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =184)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =201)
--       and not ( T2.QA_std_x     = 'SHI_10' AND T2.Ctry_fk =189)
--       and not ( T2.QA_std_x     = 'SHI_11' AND T2.Ctry_fk =36)
--       and not ( T2.QA_std_x     = 'SHI_11' AND T2.Ctry_fk =45)
--       and not ( T2.QA_std_x     = 'SHI_13' AND T2.Ctry_fk =17)
------- corrected later: (do not over-write) but not wording before ------------------------------------------------------------
----     and not ( T2.QA_std_x     = 'GRI_11' AND T2.Ctry_fk =65)
----     and not ( T2.QA_std_x     = 'SHI_04' AND T2.Ctry_fk =70)
----     and not ( T2.QA_std_x     = 'SHI_12' AND T2.Ctry_fk =135)
--------------------------------------------------------------------------------------------------------------------------------
------- wording removed & value changed, but it wast probably OK to delete it: -------------------------------------------------
--       and not ( T1.QA_std_x     = 'GRI_20_03_a' AND T1.Ctry_fk =  21 )  
--       -- wording removed:  
--       -- Every recognised religious community shall be entitled, at its own expense, to establish and maintain places of
--       -- education and to manage any place of education which it maintains; and no such community shall be prevented from 
--       -- providing religious instruction for persons of that community in the course of any education provided by that 
--       -- community whether or not it is in receipt of a government subsidy or other form of financial assistance designed 
--       -- to meet in whole or in part the cost of such course of education.
--       and not ( T1.QA_std_x     = 'SHI_08'      AND T1.Ctry_fk = 108 )
--       -- wording removed:  
--       -- On January 9, 2009, a group of nine ethnic Albanians belonging to a Wahhabist sect severely beat Muslim cleric
--       -- Mullah Osman Musliu while he was entering a mosque in the Gllogovc/Glogovac village of Zabeli i Ulet. Police 
--       -- detained nine suspects and arrested five of them. On January 16, 2009, Musliu told a local newspaper that he 
--       -- would not allow Wahhabists to take over other local mosques in Gllogovc. Musliu also criticized KIC head Naim 
--       -- Ternava for not standing up against Wahhabism. He told the media that there were some Wahhabist imams preaching 
--       -- without prior approval from the KIC. Also on January 16, 2009, another local newspaper published an article noting 
--       -- that the mosque where the attack took place had been closed. The Gllogovc/Glogovac Islamic Community office 
--       -- reportedly requested that the municipal government take action to prevent Islamic religious activities taking 
--       -- place without KIC approval, citing security concerns. (IRF 2009)
--       and not ( T1.QA_std_x     = 'SHI_09'      AND T1.Ctry_fk = 108 )
--       -- wording removed:  
--       -- Protestants reported the kidnapping and beating of a community member in the Decan municipality on December 25. 
--       -- The Protestant community reported that the attack was religiously motivated, and a group calling itself "Army of 
--       -- Allah" sent two threatening e-mails to the community member prior to the attack. At the end of the reporting period, 
--       -- a police investigation continued. The Protestant community raised concerns about the initial stages of the police 
--       -- investigation, reporting that officers asked the victim why he converted from Islam to Christianity. (IRF 2010.5)
--       --  | On January 9, 2009, a group of nine ethnic Albanians belonging to a Wahhabist sect severely beat Muslim cleric 
--       -- Mullah Osman Musliu while he was entering a mosque in the Gllogovc/Glogovac village of Zabeli i Ulet. Police 
--       -- detained nine suspects and arrested five of them. On January 16, 2009, Musliu told a local newspaper that he would 
--       -- not allow Wahhabists to take over other local mosques in Gllogovc. (IRF 2009)
--------------------------------------------------------------------------------------------------------------------------------
------- standard wording added where original wording was empty: ---------------------------------------------------------------
--        AND NOT
--                (       LTRIM(RTRIM(currwording))
--                      = LTRIM(RTRIM(answer_wording_std))
--                 AND
--                        expltext = ''                       )
--------------------------------------------------------------------------------------------------------------------------------
------- quasi-standard wording added where original wording was empty: ---------------------------------------------------------
--        AND NOT ( T2.QA_std_x     = 'GRX_25_01' AND currwording ='Yes, they contribute [Not selected]' AND Answer_Value = 1 )
--        AND NOT ( T2.QA_std_x     = 'GRX_25_01' AND currwording ='No [option selected]'                AND Answer_Value = 0 )
--        AND NOT ( T2.QA_std_x     = 'SHX_27_01' AND currwording ='Yes [Not selected]'                  AND Answer_Value = 1 )
--        AND NOT ( T2.QA_std_x     = 'SHX_27_01' AND currwording ='No [option selected]'                AND Answer_Value = 0 )
--------------------------------------------------------------------------------------------------------------------------------
------- cases for special attention since data do not corespond to the limesurvey : --------------------------------------------
--        AND NOT ( T2.QA_std_x = 'GRI_19_b'  AND T2.Ctry_fk =   60 AND T2.[Locality_fk] = 2894 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_c'  AND T2.Ctry_fk =   19 AND T2.[Locality_fk] = 2853 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_c'  AND T2.Ctry_fk =   43 AND T2.[Locality_fk] = 2877 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_c'  AND T2.Ctry_fk =   52 AND T2.[Locality_fk] = 2886 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_c'  AND T2.Ctry_fk =   63 AND T2.[Locality_fk] = 2897 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_c'  AND T2.Ctry_fk =   96 AND T2.[Locality_fk] = 2930 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_c'  AND T2.Ctry_fk =  137 AND T2.[Locality_fk] = 2971 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_c'  AND T2.Ctry_fk =  140 AND T2.[Locality_fk] = 2974 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_c'  AND T2.Ctry_fk =  183 AND T2.[Locality_fk] = 3017 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_c'  AND T2.Ctry_fk =  202 AND T2.[Locality_fk] = 3036 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_d'  AND T2.Ctry_fk =   24 AND T2.[Locality_fk] = 2858 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_d'  AND T2.Ctry_fk =   60 AND T2.[Locality_fk] = 2894 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_d'  AND T2.Ctry_fk =  183 AND T2.[Locality_fk] = 3017 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_d'  AND T2.Ctry_fk =  219 AND T2.[Locality_fk] = 3053 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_e'  AND T2.Ctry_fk =   43 AND T2.[Locality_fk] = 2877 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_e'  AND T2.Ctry_fk =   60 AND T2.[Locality_fk] = 2894 )
--        AND NOT ( T2.QA_std_x = 'GRI_19_e'  AND T2.Ctry_fk =  183 AND T2.[Locality_fk] = 3017 )
--        AND NOT ( T2.QA_std_x = 'SHI_01_b'  AND T2.Ctry_fk =   26 AND T2.[Locality_fk] = 2860 )
--        AND NOT ( T2.QA_std_x = 'SHI_01_e'  AND T2.Ctry_fk =   43 AND T2.[Locality_fk] = 2877 )
--        AND NOT ( T2.QA_std_x = 'SHI_01_e'  AND T2.Ctry_fk =   60 AND T2.[Locality_fk] = 2894 )
--        AND NOT ( T2.QA_std_x = 'SHI_01_e'  AND T2.Ctry_fk =  152 AND T2.[Locality_fk] = 2986 )
--        AND NOT ( T2.QA_std_x = 'SHI_04_c'  AND T2.Ctry_fk =  126 AND T2.[Locality_fk] = 2960 )
--        AND NOT ( T2.QA_std_x = 'SHI_05_f'  AND T2.Ctry_fk =  202 AND T2.[Locality_fk] = 3036 )




--GRI_19_c     | 043 | 00002877 V= 127453.00                     
--GRI_19_c     | 052 | 00002886 V= 26.00                         
--GRI_19_c     | 063 | 00002897 V= 5261.00                       
--GRI_19_c     | 096 | 00002930 V= 558.00                        
--GRI_19_c     | 137 | 00002971 V= 12.00                         
--GRI_19_c     | 140 | 00002974 V= 59.00                         
--GRI_19_c     | 183 | 00003017 V= 220.00                        
--GRI_19_c     | 202 | 00003036 V= 211.00                        
--GRI_19_d     | 024 | 00002858 V= 90000.00                      
--GRI_19_d     | 060 | 00002894 V= 343.00                        
--GRI_19_d     | 183 | 00003017 V= 4.00                          
--GRI_19_d     | 219 | 00003053 V= 9.00                          
--GRI_19_e     | 043 | 00002877 V= 7.00                          
--GRI_19_e     | 060 | 00002894 V= 594.00                        
--GRI_19_e     | 183 | 00003017 V= 7.00                          
--GRX_25_03    | 194 | 00000    V= 1.00                          
--SHI_01_b     | 026 | 00002860 V= 18.00                         
--SHI_01_e     | 043 | 00002877 V= 6.00                          
--SHI_01_e     | 060 | 00002894 V= 429.00                        
--SHI_01_e     | 152 | 00002986 V= 247.00                        
--SHI_04_c     | 126 | 00002960 V= 7.00                          
--SHI_05_f     | 202 | 00003036 V= 3748.00     
--------------------------------------------------------------------------------------------------------------------------------




















--USE [juancarlos]
--GO


-----------------------------------------------------------------------------
--SELECT 
--        [D] =  CASE  
--                    WHEN
--                           RTRIM(LTRIM(
--                           CAST([expltext]    AS NVARCHAR(MAX))
--                                                               ))
--                         =
--                           RTRIM(LTRIM(
--                           CAST([currwording] AS NVARCHAR(MAX))  
--                                                               ))
--                    THEN   1
--                    END
                        
--           --    substring((REPLACE((RTRIM(LTRIM(T1.expltext   ))),' ','')), 1, (len(REPLACE((RTRIM(LTRIM(T2.currwording))),' ',''))))
--           --NOT LIKE
--           --    substring((REPLACE((RTRIM(LTRIM(T2.currwording))),' ','')), 1, (len(REPLACE((RTRIM(LTRIM(T2.currwording))),' ',''))))
--           --  + ' | '
--           --  + RIGHT(('000' +        Ctry_fk                  ),  3 )  
--           --  + ' | '
--           --  + RIGHT(('0000' + CAST(Locality_fk  AS NCHAR(4) )), 12 )
--           --  + ' V= '
--           --  +                 CAST(Answer_value AS NCHAR)
--      , *
--FROM
--       juancarlos.dbo.test
-----------------------------------------------------------------------------
--WHERE
--                           SUBSTRING((
--                           REPLACE((
--                           RTRIM(LTRIM((
--                           CAST([expltext]    AS NVARCHAR(MAX))
--                                                               )))
--                                                                  ),' ','')
--                                                                           ), 1, (len(
--                           REPLACE((
--                           RTRIM(LTRIM((
--                           CAST([currwording] AS NVARCHAR(MAX))  
--                                                               )))
--                                                                  ),' ','')
--                                                                                                                  )))

--                         <>
--                           SUBSTRING((
--                           REPLACE((
--                           RTRIM(LTRIM((
--                           CAST([currwording] AS NVARCHAR(MAX))  
--                                                               )))
--                                                                  ),' ','')
--                                                                           ), 1, (len(
--                           REPLACE((
--                           RTRIM(LTRIM((
--                           CAST([currwording] AS NVARCHAR(MAX))  
--                                                               )))
--                                                                  ),' ','')
--                                                                                                                  )))


--order by 
--               CASE  
--                    WHEN   CAST([expltext]    AS NVARCHAR(MAX))
--                         = CAST([currwording] AS NVARCHAR(MAX))  
--                    THEN   1
--                    ELSE   0
--                    END
              







--/*************************************************************************/
-----------------------------------------------------------------------------
--SELECT 
--       [R]
--     , [Xv]                         /* newvar: stores setofvars_1 names  */    
--     , [expltext]                   /* newvar: stores setofvars_1 values */
-----------------------------------------------------------------------------
--INTO
--       juancarlos.dbo.MYT
-----------------------------------------------------------------------------
--FROM
-----------------------------------------------------------------------------
--(
-----------------------------------------------------------------------------
--SELECT 
--     [R] =      LEFT((               QA_std_x + '      '      ), 12 ) 
--             + ' | '
--             + RIGHT(('000' +        Ctry_fk                  ),  3 )  
--             + ' | '
--             + RIGHT(('0000' + CAST(Locality_fk  AS NCHAR(4) )), 12 )
--             + ' V= '
--             +                 CAST(Answer_value AS NCHAR)
--   , [LSv] = CAST([expltext]    AS NVARCHAR(MAX))  
--   , [CGv] = CAST([currwording] AS NVARCHAR(MAX))  
--FROM
--       juancarlos.dbo.test
-----------------------------------------------------------------------------
--)  ORT                              /* alias of table of data to be used */
-----------------------------------------------------------------------------
--unpivot (                           /* statement                         */
--           [expltext]               /* newvar: stores setofvars_1 values */
--       for                          /* statement                         */
--           [Xv]                     /* newvar: stores setofvars_1 names  */
--       in (                         /* statement                         */
--              [LSv]                 /* 1st name of the setofvars_1       */
--            , [CGv]                 /* last name of the setofvars_1      */
--          )                         /* statement                         */
--        )                           /* statement                         */
--       as                           /* statement                         */
--       UP1                          /* statement                         */
--/*************************************************************************/
--/*************************************************************************/





-----------------------------------------------------------------------------
--SELECT 
--        [D] =  CASE  
--                    WHEN
--                           RTRIM(LTRIM(
--                           CAST([expltext]    AS NVARCHAR(MAX))
--                                                               ))
--                         =
--                           RTRIM(LTRIM(
--                           CAST([currwording] AS NVARCHAR(MAX))  
--                                                               ))
--                    THEN   1
--                    END
--      , LEN(expltext)
--      , *
--FROM
--(
--/*************************************************************************/
--      select 
--                [R]
--              , [LSv] AS [expltext]
--              , [CGv] AS [currwording]
--        from 
--             [MYT]
--             pivot ( MAX([expltext]) 
--                     for [Xv]
--                      in ( 
--                           [LSv], [CGv] 
--                                        )) AS REPIV
--/*************************************************************************/
--) AS NEWJC
-----------------------------------------------------------------------------
--WHERE
--                           SUBSTRING((
--                           REPLACE((
--                           RTRIM(LTRIM((
--                           CAST([expltext]    AS NVARCHAR(MAX))
--                                                               )))
--                                                                  ),' ','')
--                                                                           ), 1, (len(
--                           REPLACE((
--                           RTRIM(LTRIM((
--                           CAST([currwording] AS NVARCHAR(MAX))  
--                                                               )))
--                                                                  ),' ','')
--                                                                                                                  )))

--                         <>
--                           SUBSTRING((
--                           REPLACE((
--                           RTRIM(LTRIM((
--                           CAST([currwording] AS NVARCHAR(MAX))  
--                                                               )))
--                                                                  ),' ','')
--                                                                           ), 1, (len(
--                           REPLACE((
--                           RTRIM(LTRIM((
--                           CAST([currwording] AS NVARCHAR(MAX))  
--                                                               )))
--                                                                  ),' ','')
--                                                                                                                  )))

--order by 
--[R]

--select * from       juancarlos.dbo.MYT









--        AND
--               substring((REPLACE((RTRIM(LTRIM(T1.expltext   ))),' ','')), 1, (len(REPLACE((RTRIM(LTRIM(T2.currwording))),' ',''))))
--           NOT LIKE
--               substring((REPLACE((RTRIM(LTRIM(T2.currwording))),' ','')), 1, (len(REPLACE((RTRIM(LTRIM(T2.currwording))),' ',''))))
----                                 RTRIM(LTRIM(T2.currwording))







--        AND
--               substring((REPLACE((RTRIM(LTRIM(T1.expltext   ))),' ','')), 1, (len(REPLACE((RTRIM(LTRIM(T2.currwording))),' ',''))))
--           NOT LIKE
--               substring((REPLACE((RTRIM(LTRIM(T2.currwording))),' ','')), 1, (len(REPLACE((RTRIM(LTRIM(T2.currwording))),' ',''))))
----                                 RTRIM(LTRIM(T2.currwording))







--                    LTRIM(RTRIM(T1.expltext ))
--           NOT LIKE T2.currwording
--             currwording != LTRIM(RTRIM(answer_wording_std))


----           REPLACE((RTRIM(LTRIMT1.expltext, 1, (len(RTRIM(LTRIM(T2.currwording)))))))),' ','')
--               substring((REPLACE((RTRIM(LTRIM(T1.expltext   ))),' ','')), 1, (len(REPLACE((RTRIM(LTRIM(T2.currwording))),' ',''))))
--           NOT LIKE
--                          REPLACE((RTRIM(LTRIM(T2.currwording))),' ','')
           
--       --    RTRIM(LTRIM(substring(T1.expltext, 1, (len(T2.currwording))))) NOT LIKE RTRIM(LTRIM(T2.currwording))
--       --    substring(T1.expltext, 1, 400) NOT LIKE substring(T2.currwording, 1, 400)
--             --T1.expltext IS NULL



--        --AND
--        --     currwording != 'No description coded'
--        --AND NOT
--        --     (     T2.QA_std_x     = 'SHI_05'
--        --       AND Answer_value	= 0.25
--        --       AND currwording  = 'Yes, with fewer than 10,000 casualties or people displaced from their homes'
------AND

----    T1.QA_std_x like 'GRX_27_0%'



----ORDER BY Ctry_fk



