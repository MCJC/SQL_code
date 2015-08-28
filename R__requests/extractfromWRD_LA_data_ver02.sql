------/****** Script for SelectTopNRows command from SSMS  ******/
------SELECT [Nation_pk]
------      ,[Ctry_EditorialName]
------      ,[TPop1910]
------      ,[Christian_pct1910]
------      ,[Evangelical_pct2010]
------  FROM [forum].[dbo].[Pew_Nation]
------  where SubRegion6 = 'Latin America-Caribbean'
------  and   Nation_pk  = 9


SELECT
       [Country_fk]     = CASE
                              WHEN A.[Country_fk] IS NOT NULL
                              THEN A.[Country_fk]
                              ELSE B.[Country_fk]
                     END
   ,   [class]          = CASE
                              WHEN A.[class]      IS NOT NULL
                              THEN A.[class]
                              ELSE B.[class]
                     END
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1910]
   ,   [Pop_1910_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pop_1910]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pop_1910_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pop_1910]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_1910]
   ,   [Pct_1910_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pct_1910]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_1910_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pct_1910]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1950]
   ,   [Pop_1950_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pop_1950]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pop_1950_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pop_1950]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_1950]
   ,   [Pct_1950_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pct_1950]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_1950_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pct_1950]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1970]       = CASE
                              WHEN   [Aff_1970]   IS NOT NULL
                              THEN   [Aff_1970]
                              ELSE   [Pop_1970]
                     END
   ,   [Pop_1970_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pop_1970]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pop_1970_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pop_1970]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Aff_1970]
   ,   [Aff_1970_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Aff_1970]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Aff_1970_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Aff_1970]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_1970]
   ,   [Pct_1970_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pct_1970]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_1970_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pct_1970]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [PAf_1970]
   ,   [PAf_1970_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [PAf_1970]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [PAf_1970_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [PAf_1970]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_2000]
   ,   [Pop_2000_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pop_2000]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pop_2000_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pop_2000]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Aff_2000]
   ,   [Aff_2000_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Aff_2000]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Aff_2000_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Aff_2000]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_2000]
   ,   [Pct_2000_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pct_2000]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_2000_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pct_2000]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [PAf_2000]
   ,   [PAf_2000_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [PAf_2000]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [PAf_2000_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [PAf_2000]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_2010]
   ,   [Pop_2010_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pop_2010]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pop_2010_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pop_2010]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Aff_2010]
   ,   [Aff_2010_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Aff_2010]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Aff_2010_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Aff_2010]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_2010]
   ,   [Pct_2010_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [Pct_2010]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [Pct_2010_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [Pct_2010]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [PAf_2010]
   ,   [PAf_2010_d2]    = SUM(CASE
                              WHEN A.[class]      =  '-- 2'
                              THEN   [PAf_2010]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
   ,   [PAf_2010_dx]    = SUM(CASE
                              WHEN A.[class]      =  '-- x'
                              THEN   [PAf_2010]
                              ELSE    0
                              END)                         OVER(
                                                           PARTITION BY (CASE
                                                                         WHEN A.[Country_fk] IS NOT NULL
                                                                         THEN A.[Country_fk]
                                                                         ELSE B.[Country_fk]
                                                                         END)                             )
/*----------------------------------------------------------------------------------------------------------------------------*/
FROM
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
(       
/******************************************************************************************************************************/
/******************************************************************************************************************************/
SELECT
    [Country_fk]
,   [class]
,   [Pop_1910]      = SUM([Pop_1910])
,   [Pct_1910]      = SUM([Pct_1910])
,   [Pop_1950]      = SUM([Pop_1950])
,   [Pct_1950]      = SUM([Pct_1950])
,   [Pop_1970]      = SUM([Pop_1970])
,   [Pct_1970]      = SUM([Pct_1970])
,   [Pop_2000]      = SUM([Pop_2000])
,   [Pct_2000]      = SUM([Pct_2000])
,   [Pop_2010]      = SUM([Pop_2010])
,   [Pct_2010]      = SUM([Pct_2010])
FROM(
/******************************************************************************************************************************/
SELECT
  r.[Country_fk]
,   [class]              = CASE
                               WHEN [Religion_1] IN ( 'Q', 'a' )
                               THEN 'Unaffiliated'
                               WHEN [Religion_1] IN ( 'L', 'B', 'F', 'G', 'T', 'H', 'J', 'M', 'N', 'K', 'U', 'S' )
                               THEN 'OTHER'
                               WHEN [Religion_2] IN ( 'R' )
                               THEN 'Catholics'
                               WHEN [Religion_2] IN ( 'U', 'A', 'I', 'P' )
                               THEN 'Protestant'
                               WHEN [Religion_2] IN ( 'O' )
                               THEN 'Other Christians'
                               WHEN [Religion_2] IN ( '2' )
                               THEN '-- 2'
                               WHEN [Religion_2] IN ( 'x' )
                               THEN '-- x'
                         END
, r.[Religion_Name]
, r.[Religion_1]
, r.[Religion_2]
, r.Pop_1910
, r.Pct_1910
, r.Pop_1950
, r.Pct_1950
, r.Pop_1970
, r.Pct_1970
, r.Pop_2000
, r.Pct_2000
, r.Pop_2010
, r.Pct_2010
from          religion        r
WHERE
r.[Country_fk] IN (
					  'arge'
					, 'boli'
					, 'braz'
					, 'chil'
					, 'colo'
					, 'cost'
					, 'domr'
					, 'ecua'
					, 'elsa'
					, 'guat'
					, 'hond'
					, 'mexi'
					, 'nica'
					, 'pana'
					, 'para'
					, 'peru'
					, 'puer'
					, 'urug'
					, 'vene'
								)
--ORDER BY [class]
/******************************************************************************************************************************/
)
Y1910andY1950
GROUP BY
    [Country_fk]
,   [class]
/******************************************************************************************************************************/
/******************************************************************************************************************************/
) A
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
FULL JOIN
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
(
/******************************************************************************************************************************/
/******************************************************************************************************************************/
SELECT
    [Country_fk]
,   [class]
,   [Aff_1970]      = SUM([Aff_1970])
,   [PAf_1970]      = SUM([Aff_pct_1970])
,   [Aff_2000]      = SUM([Aff_2000])
,   [PAf_2000]      = SUM([Aff_pct_2000])
,   [Aff_2010]      = SUM([Aff_2010])
,   [PAf_2010]      = SUM([Aff_pct_2010])
FROM(
/******************************************************************************************************************************/
SELECT
  d.[Country_fk]
,   [class]              = CASE
                               WHEN [Religion_2] IN ( 'R' )
                               THEN 'Catholics'
                               WHEN [Denom_name] LIKE '%Cat%li%'    /* other Catholic churches or communities */
                               THEN 'Catholics'
                               WHEN [Religious_tradition] = 'Jeh'   /* Jehova's Witnesses                     */
                               THEN 'Other Christians'
                               WHEN [Religious_tradition] = 'LDS'   /* Mormons                                */
                               THEN 'Other Christians'
                               WHEN [Religion_2] IN ( 'U', 'A', 'I', 'P' )
                               THEN 'Protestant'
                               WHEN [Religion_2] IN ( 'O' )
                               THEN 'Other Christians'
                               WHEN [Religion_2] IN ( '2' )
                               THEN '-- 2'
                               WHEN [Religion_2] IN ( 'x' )
                               THEN '-- x'
                         END
, d.[Religion_2]
, d.Denom_name
, d.Religious_tradition
, d.Aff_1970
, d.[Aff_pct_1970]
, d.Aff_2000
, d.[Aff_pct_2000]
, d.Aff_2010 
, d.[Aff_pct_2010]
from          Denomination    d
WHERE
d.[Country_fk] IN (
					  'arge'
					, 'boli'
					, 'braz'
					, 'chil'
					, 'colo'
					, 'cost'
					, 'domr'
					, 'ecua'
					, 'elsa'
					, 'guat'
					, 'hond'
					, 'mexi'
					, 'nica'
					, 'pana'
					, 'para'
					, 'peru'
					, 'puer'
					, 'urug'
					, 'vene'
								)
--ORDER BY [class], [Religious_tradition], [Denom_name]
/******************************************************************************************************************************/
)
Y1970toY2010
GROUP BY
    [Country_fk]
,   [class]
/******************************************************************************************************************************/
/******************************************************************************************************************************/
) B
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
ON   A.[Country_fk]
   = B.[Country_fk]
AND  A.[class]
   = B.[class]
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
ORDER BY 
        CASE
                              WHEN A.[Country_fk] IS NOT NULL
                              THEN A.[Country_fk]
                              ELSE B.[Country_fk]
                     END
   ,    CASE
                              WHEN A.[class]      IS NOT NULL
                              THEN A.[class]
                              ELSE B.[class]
                     END


