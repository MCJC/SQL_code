USE [forum_ResAnal]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  VIEW                      [dbo].[vr___09_]  AS
WITH  CTE01
AS
      (
          SELECT
                 [Q_Year]    =                  CAST(D.[Question_Year] AS VARCHAR)
                ,[QS_fk]     =                         [QSk]
                ,[Variable]  = CASE
                                   WHEN                [QA_std]     LIKE '%_ny%' 
                                    AND                [QA_std] NOT LIKE '%_ny' 
                                   THEN STUFF(         [QA_std]      ,         
                                   ((CHARINDEX('_ny',  [QA_std])) + 3) , 1, '')
                                   ELSE                [QA_std]
                               END
                ,[Q_Wording] =                         [QW_std]
                ,[Value]     = CASE
                                   WHEN
                                         (CAST((ISNULL([Answer_value], 0)) AS decimal(12,2)) > 1)
                                      AND(             [QA_std] LIKE 'GRI_19_'              +'[bcdefx]'
                                                    OR [QA_std] LIKE 'SHI_0'  +'[1,4,5]'+'_'+'[bcdefx]'  )
                                   THEN    '1.00'
                                   ELSE         ISNULL([Answer_value], '0.00')
                               END
                ,[A_Wording] = CASE
                                   WHEN
                                         (CAST((ISNULL([Answer_value], 0)) AS decimal(12,2))  = 0)
                                      AND(             [QA_std] LIKE 'GRI_19_'              +'[bcdefx]'
                                                    OR [QA_std] LIKE 'SHI_0'  +'[1,4,5]'+'_'+'[bcdefx]'  )
                                   THEN    'No cases were found'
                                   WHEN
                                         (CAST((ISNULL([Answer_value], 0)) AS decimal(12,2)) >= 1)
                                      AND(             [QA_std] LIKE 'GRI_19_'              +'[bcdefx]'
                                                    OR [QA_std] LIKE 'SHI_0'  +'[1,4,5]'+'_'+'[bcdefx]'  )
                                   THEN    '1+ cases were found'
                                   ELSE    [answer_wording_std]
                               END
                ,[CntWg]
                ,[WTWg]
            FROM [vr___06_cDB_LongData_ALL_byCYQ] D
               , [vr___08_cDB_Weights_f_TopLines] W
           WHERE          D.[Nation_fk]
                        = W.[Nation_fk]
             AND          D.[Question_Year]
                        = W.[Question_Year]
             AND          D.[Locality]
                       IN            (
                                        'aggregated by country'
                                      , 'not detailed'           )
             AND          D.[QA_std] NOT IN   ('GFI', 'GRI', 'SHI', 'GRI_20_05_x1')
             AND          D.[QA_std] NOT LIKE 'XSG_S_%'
             AND          D.[QA_std] NOT LIKE '%_d'+'[a,b]'
             AND          D.[QA_std] NOT LIKE '%_rd_1d'
      )
,  CTE02
AS
			    ( SELECT
				          DISTINCT
                          [NumYr]          = [Question_Year]
                        , [TxtYr]          = CAST(               [Question_Year]   AS VARCHAR)
                        , [Nations]        = CAST(COUNT(DISTINCT [Nation_fk]    )  AS VARCHAR)
                   FROM   [vr___06_cDB_LongData_ALL_byCYQ]
                  WHERE   [Nation_fk] < 1000
             GROUP BY  [Question_Year]
	)
,     CTE03
AS
      (
          SELECT
                 [RYCNT]       = 'N' + [Q_Year]
                ,[RYPCT]       = 'P' + [Q_Year]
                ,[Variable]
                ,[Value]
                ,[Number]      =     SUM([CntWg])
                ,[Percentage]  =     SUM([WTWg])
           FROM   
                 [CTE01]
        GROUP BY
                 [Q_Year]
                ,[Variable]
                ,[Value]
      )
,     CTE04
AS
      (
   SELECT                                                                       /*** SELECT statement                                                        ***/
                [M]
              , [x]  = '[' + [M] + '] = STR(ISNULL(MAX([' + [M] + [F]         /*** elements arranged to be used as code                                      ***/
              , [v]  = '[' + [M] + ']'                                        /*** field name to be used as code                                             ***/
              , [s]  = SUBSTRING([M],2,2) +'|'+ RIGHT([M],4) +'|'+ LEFT([M],1)
              , [a]  = SUBSTRING([M],2,2)
              , [y]  =                          RIGHT([M],4)
              , [f]  =                                             LEFT([M],1)
              , [e]  = ''
              , [d]  = CASE
                       WHEN  LEFT([M], 1  )  = 'N'
                       AND  RIGHT([M], 4  )  = 2007
                       THEN                         'baseline year,'
                       WHEN  LEFT([M], 1  )  = 'N'
                       AND  RIGHT([M], 4  )  = (SELECT ((MAX([NumYr])) - 1 ) FROM [CTE02] )
                       THEN                         'previous year,'
                       WHEN  LEFT([M], 1  )  = 'N'
                       AND  RIGHT([M], 4  )  = (SELECT ((MAX([NumYr]))     ) FROM [CTE02] )
                       THEN                         'latest year,'
                       WHEN  LEFT([M], 1  )  = 'N'
                       THEN                         'year'
                       ELSE ' ending'
                        END
              , [p]  = CASE
                       WHEN  LEFT([M], 1  )  = 'N'
                       AND  RIGHT([M], 4  ) <  2011
                       THEN                         'JUN '
                       WHEN  LEFT([M], 1  )  = 'N'
                       AND  RIGHT([M], 4  ) >= 2011
                       THEN                         'DEC '
                       ELSE RIGHT([M], 4  )
                        END
              , [n]  = [N]
              , [c]  = 'COUNTRIES'
              , [t]  = [T]
              , [l]  = 
      '--------------------------------------------------------------------------------------------------------------------------------------------------------'
FROM (
             SELECT                                                             /***                                                                         ***/
           DISTINCT [M] = [RYCNT]                                               /***                                                                         ***/
                  , [N] = '  %  OF  '
                  , [T] = '100 %'                                         /***                                                                         ***/
                  , [F] = ']),0),12,0)'                                         /***                                                                         ***/
               FROM                          [CTE03]                          /***                                                                         ***/
           UNION                                                                /***                                                                         ***/
           ALL                                                                  /***                                                                         ***/
           SELECT                                                               /***                                                                         ***/
           DISTINCT [M] = [RYPCT]                                               /***                                                                         ***/
                  , [N] = 'NUMBER OF'
                  , [T] = [Nations]                                         /***                                                                         ***/
                  , [F] = ']),0), 3,0)+''%'''                                   /***                                                                         ***/
               FROM                          [CTE03]                          /***                                                                         ***/
			                      ,   [CTE02]
                WHERE [RYCNT]       = 'N' + [TxtYr]
			   ) LongReshaped
      )
,     CTE05
AS
      (
SELECT
          DISTINCT
          [Variable]
         ,[Q_Wording]
         ,[Value]
         ,[A_Wording]
  FROM    [CTE01]
      )
,     CTE06
AS
      (
SELECT
          DISTINCT
          [QS_fk]
         ,[Variable]
         ,[Q_Wording]
  FROM    [CTE01]
      )
,     CTE07
AS
      (
         SELECT
                  [Variable]
                , [label]     = [attr]
           FROM
                  [CTE06]
            INNER
             JOIN [forum]..[Pew_Question_Attributes]
               ON [QS_fk]
                 =[Question_Std_fk]
            WHERE [attk]
                 ='TopLine label'
      )
,     CTE08
AS
      (
         SELECT
                  [Variable]
              ,   [note]      = CASE WHEN [attr] IS NOT NULL
                                     THEN [attr]
                                     ELSE ''                   END
           FROM
                  [CTE06]
        LEFT JOIN [forum]..[Pew_Question_Attributes]
               ON [QS_fk]
                 =[Question_Std_fk]
            WHERE [attk]
                 ='XNote01'
      )
,     CTE09
AS
      (
        SELECT
                  [V] = [Variable]
              ,   [S] = [attr]
          FROM
                  [CTE06]
        LEFT JOIN [forum]..[Pew_Question_Attributes]
               ON [QS_fk]
                 =[Question_Std_fk]
            WHERE [attk]
                 ='SortKey'
      )
,     CTE10
AS
      (
SELECT
          M.Variable
        , M.Value
        ,   Wording   =  L.A_Wording
,[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]
FROM
        [CTE05]                                                           L
INNER
JOIN
     (SELECT
          Variable
        , Value
,[N2007] = STR(ISNULL(MAX([N2007]),0),12,0),[P2007] = STR(ISNULL(MAX([P2007]),0), 3,0)+'%',[N2008] = STR(ISNULL(MAX([N2008]),0),12,0),[P2008] = STR(ISNULL(MAX([P2008]),0), 3,0)+'%',[N2009] = STR(ISNULL(MAX([N2009]),0),12,0),[P2009] = STR(ISNULL(MAX([P2009]),0), 3,0)+'%',[N2010] = STR(ISNULL(MAX([N2010]),0),12,0),[P2010] = STR(ISNULL(MAX([P2010]),0), 3,0)+'%',[N2011] = STR(ISNULL(MAX([N2011]),0),12,0),[P2011] = STR(ISNULL(MAX([P2011]),0), 3,0)+'%',[N2012] = STR(ISNULL(MAX([N2012]),0),12,0),[P2012] = STR(ISNULL(MAX([P2012]),0), 3,0)+'%',[N2013] = STR(ISNULL(MAX([N2013]),0),12,0),[P2013] = STR(ISNULL(MAX([P2013]),0), 3,0)+'%',[N2014] = STR(ISNULL(MAX([N2014]),0),12,0),[P2014] = STR(ISNULL(MAX([P2014]),0), 3,0)+'%'
FROM
                [CTE03]
  PIVOT   (       MAX([Percentage])
            FOR       [RYPCT]
            IN       (
 [P2007], [P2008], [P2009], [P2010], [P2011], [P2012], [P2013], [P2014]                       )   )   AS   pivt1       
  PIVOT   (       MAX([Number])
            FOR       [RYCNT]
            IN       (
 [N2007], [N2008], [N2009], [N2010], [N2011], [N2012], [N2013], [N2014]                       )   )   AS   pivt2         GROUP BY Variable, Value                                                                           )  M 
     ON   M.Variable = L.Variable
    AND   M.Value    = L.Value

      )
,     CTE11
AS
      (

SELECT
            [Variable]
        ,   [Value]
        ,   [Wording]   =  CASE
                              WHEN [Value] = 500
                              THEN
                                    '---------------------------------------------------'
                                  + '---------------------------------------------------'
                                  + '--------------------------------------------------'
                              ELSE  ''                                                        END
,[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]
FROM
        [CTE06] /* < #QWording*/                                                             Q
CROSS
JOIN
     (
       SELECT *
         FROM (SELECT  [Value] =  -5.00, [d]     ,[M] FROM [CTE04] /* heading */) H 
                PIVOT               (MAX([d]) FOR [M] IN (
[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]                                                     ) ) tpivoted 
       UNION ALL
       SELECT *
         FROM (SELECT  [Value] =  -4.00, [p]     ,[M] FROM [CTE04] /* heading */) H 
                PIVOT               (MAX([p]) FOR [M] IN (
[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]                                                     ) ) tpivoted 
       UNION ALL
       SELECT *
         FROM (SELECT  [Value] =  -3.00, [n]     ,[M] FROM [CTE04] /* heading */) H 
                PIVOT               (MAX([n]) FOR [M] IN (
[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]                                                     ) ) tpivoted 
       UNION ALL
       SELECT *
         FROM (SELECT  [Value] =  -2.00, [c]     ,[M] FROM [CTE04] /* heading */) H 
                PIVOT               (MAX([c]) FOR [M] IN (
[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]                                                     ) ) tpivoted 
       UNION ALL
       SELECT *
         FROM (SELECT  [Value] = 200.00, [t]     ,[M] FROM [CTE04] /* heading */) H 
                PIVOT               (MAX([t]) FOR [M] IN (
[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]                                                     ) ) tpivoted 
       UNION ALL
       SELECT *
         FROM (SELECT  [Value] = 500.00, [e]     ,[M] FROM [CTE04] /* heading */) H 
                PIVOT               (MAX([e]) FOR [M] IN (
[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]                                                     ) ) tpivoted                                                                   )  F
)
,     CTE12
AS
      (
SELECT
            Variable
        ,   Value
        ,   Wording   =  Q_Wording
,[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]
FROM
        [CTE06] /* < #QWording*/                                                             Q
CROSS
JOIN
     ( SELECT *
         FROM (  SELECT  [Value] = -6.00
                        ,[e]
                        ,[M]
                   FROM  [CTE04] /* heading */       )   e
       PIVOT (MAX([e]) FOR [M] IN (
[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]                                                     ) ) tpivoted )  F 
)
,     CTE13
AS
      (
SELECT
            Variable
        ,   Value
        ,   Wording   =  label
,[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]
FROM
        [CTE07] /* < #QLabel */                                                             Q
CROSS
JOIN
     ( SELECT *
         FROM (  SELECT  [Value] = -7.00
                        ,[e]
                        ,[M]
                   FROM  [CTE04] /* heading */       )   e
       PIVOT (MAX([e]) FOR [M] IN (
[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]                                                     ) ) tpivoted )  F
)
,     CTE14
AS
      (

SELECT
            Variable
        ,   Value
        ,   Wording   =  note
,[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]
FROM
        [CTE08] /* #QNote */                                                            Q
CROSS
JOIN
     ( SELECT *
         FROM (  SELECT  [Value] = 201.00
                        ,[e]
                        ,[M]
                   FROM  [CTE04] /* heading */       )   e
       PIVOT (MAX([e]) FOR [M] IN (
[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]                                                     ) ) tpivoted )  F 
)
SELECT
          vx1Row
          =  ROW_NUMBER()
             OVER(ORDER BY
                             [S]
                           , [Variable]
                           , [Value]
                                          )
        , Variable
        , Value
        , Wording
,[N2007],[P2007],[N2008],[P2008],[N2009],[P2009],[N2010],[P2010],[N2011],[P2011],[N2012],[P2012],[N2013],[P2013],[N2014],[P2014]
FROM
     (           SELECT * FROM [CTE10]
       UNION ALL SELECT * FROM [CTE11]
       UNION ALL SELECT * FROM [CTE12]
       UNION ALL SELECT * FROM [CTE13]
       UNION ALL SELECT * FROM [CTE14]  )   U
LEFT JOIN                      [CTE09]      S
       ON     [V] = [Variable]                 
GO
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___09_cDB_Basic_TopLines_All]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___09_cDB_Basic_TopLines_All]
SELECT * INTO    [forum_ResAnal].[dbo].[vr___09_cDB_Basic_TopLines_All]
            FROM                 [dbo].[vr___09_]
GO
