/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
SELECT
       [Country_Name]
   ,   [class]
   --,   [Country_fk]
   --,   [chtn]
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1910_a]
   ,   [Pct_1910_a]
   ,   [Pop_1910_b]
   ,   [Pct_1910_b]
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1950_a]
   ,   [Pct_1950_a]
   ,   [Pop_1950_b]
   ,   [Pct_1950_b]
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1970_a]
   ,   [Pct_1970_a]
   ,   [Pop_1970_b]
   ,   [Pct_1970_b]
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_2000_a]
   ,   [Pct_2000_a]
   ,   [Pop_2000_b]
   ,   [Pct_2000_b]
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_2010_a]
   ,   [Pct_2010_a]
   ,   [Pop_2010_b]
   ,   [Pct_2010_b]
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1910unad]
   ,   [Pop_1910_R]
   ,   [Pct_1910unad]
   ,   [Pct_1910_R]
   ,   [Pop_1950unad]
   ,   [Pop_1950_R]
   ,   [Pct_1950unad]
   ,   [Pct_1950_R]
   ,   [Pop_1970unad]
   ,   [Pop_1970_R]
   ,   [Pct_1970unad]
   ,   [Pct_1970_R]
   ,   [Pop_2000unad]
   ,   [Pop_2000_R]
   ,   [Pct_2000unad]
   ,   [Pct_2000_R]
   ,   [Pop_2010unad]
   ,   [Pop_2010_R]
   ,   [Pct_2010unad]
   ,   [Pct_2010_R]
/*----------------------------------------------------------------------------------------------------------------------------*/
FROM
       [wcd_database].[dbo].[bak_Country],
(
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
SELECT
       [Country_fk]
   ,   [class]
   ,   [chtn]
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1910_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pop_1910] + (   (     [Pop_1910]
                                                   /SUM([Pop_1910]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_1910_d2]
                                                   +    [Pop_1910_dx])                                      )
                            ELSE                        [Pop_1910]
                       END
   ,   [Pop_1910_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pop_1910] + (   (     [Pop_1910]
                                                   /SUM([Pop_1910]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_1910_d2])                                      )
                                                   +    [Pop_1910_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pop_1910] + (   (     [Pop_1910]
                                                   /SUM([Pop_1910]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_1910_d2])                                      )
                            ELSE                        [Pop_1910]
                       END
   ,   [Pop_1910unad]=                                  [Pop_1910]
   ,   [Pop_1910_R]  =                            (     [Pop_1910]
                                                   /SUM([Pop_1910]) OVER(PARTITION BY [Country_fk],[chtn]))
   ,   [Pct_1910_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pct_1910] + (   (     [Pct_1910]
                                                   /SUM([Pct_1910]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_1910_d2]
                                                   +    [Pct_1910_dx])                                      )
                            ELSE                        [Pct_1910]
                       END
   ,   [Pct_1910_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pct_1910] + (   (     [Pct_1910]
                                                   /SUM([Pct_1910]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_1910_d2])                                      )
                                                   +    [Pct_1910_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pct_1910] + (   (     [Pct_1910]
                                                   /SUM([Pct_1910]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_1910_d2])                                      )
                            ELSE                        [Pct_1910]
                       END
   ,   [Pct_1910unad]=                                  [Pct_1910]
   ,   [Pct_1910_R]  =                            (     [Pct_1910]
                                                   /SUM([Pct_1910]) OVER(PARTITION BY [Country_fk],[chtn]))
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1950_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pop_1950] + (   (     [Pop_1950]
                                                   /SUM([Pop_1950]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_1950_d2]
                                                   +    [Pop_1950_dx])                                      )
                            ELSE                        [Pop_1950]
                       END
   ,   [Pop_1950_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pop_1950] + (   (     [Pop_1950]
                                                   /SUM([Pop_1950]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_1950_d2])                                      )
                                                   +    [Pop_1950_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pop_1950] + (   (     [Pop_1950]
                                                   /SUM([Pop_1950]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_1950_d2])                                      )
                            ELSE                        [Pop_1950]
                       END
   ,   [Pop_1950unad]=                                  [Pop_1950]
   ,   [Pop_1950_R]  =                            (     [Pop_1950]
                                                   /SUM([Pop_1950]) OVER(PARTITION BY [Country_fk],[chtn]))
   ,   [Pct_1950_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pct_1950] + (   (     [Pct_1950]
                                                   /SUM([Pct_1950]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_1950_d2]
                                                   +    [Pct_1950_dx])                                      )
                            ELSE                        [Pct_1950]
                       END
   ,   [Pct_1950_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pct_1950] + (   (     [Pct_1950]
                                                   /SUM([Pct_1950]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_1950_d2])                                      )
                                                   +    [Pct_1950_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pct_1950] + (   (     [Pct_1950]
                                                   /SUM([Pct_1950]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_1950_d2])                                      )
                            ELSE                        [Pct_1950]
                       END
   ,   [Pct_1950unad]=                                  [Pct_1950]
   ,   [Pct_1950_R]  =                            (     [Pct_1950]
                                                   /SUM([Pct_1950]) OVER(PARTITION BY [Country_fk],[chtn]))
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_1970_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pop_1970] + (   (     [Pop_1970]
                                                   /SUM([Pop_1970]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_1970_d2]
                                                   +    [Pop_1970_dx])                                      )
                            ELSE                        [Pop_1970]
                       END
   ,   [Pop_1970_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pop_1970] + (   (     [Pop_1970]
                                                   /SUM([Pop_1970]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_1970_d2])                                      )
                                                   +    [Pop_1970_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pop_1970] + (   (     [Pop_1970]
                                                   /SUM([Pop_1970]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_1970_d2])                                      )
                            ELSE                        [Pop_1970]
                       END
   ,   [Pop_1970unad]=                                  [Pop_1970]
   ,   [Pop_1970_R]  =                            (     [Pop_1970]
                                                   /SUM([Pop_1970]) OVER(PARTITION BY [Country_fk],[chtn]))
   ,   [Pct_1970_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pct_1970] + (   (     [Pct_1970]
                                                   /SUM([Pct_1970]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_1970_d2]
                                                   +    [Pct_1970_dx])                                      )
                            ELSE                        [Pct_1970]
                       END
   ,   [Pct_1970_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pct_1970] + (   (     [Pct_1970]
                                                   /SUM([Pct_1970]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_1970_d2])                                      )
                                                   +    [Pct_1970_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pct_1970] + (   (     [Pct_1970]
                                                   /SUM([Pct_1970]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_1970_d2])                                      )
                            ELSE                        [Pct_1970]
                       END
   ,   [Pct_1970unad]=                                  [Pct_1970]
   ,   [Pct_1970_R]  =                            (     [Pct_1970]
                                                   /SUM([Pct_1970]) OVER(PARTITION BY [Country_fk],[chtn]))
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_2000_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pop_2000] + (   (     [Pop_2000]
                                                   /SUM([Pop_2000]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_2000_d2]
                                                   +    [Pop_2000_dx])                                      )
                            ELSE                        [Pop_2000]
                       END
   ,   [Pop_2000_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pop_2000] + (   (     [Pop_2000]
                                                   /SUM([Pop_2000]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_2000_d2])                                      )
                                                   +    [Pop_2000_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pop_2000] + (   (     [Pop_2000]
                                                   /SUM([Pop_2000]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_2000_d2])                                      )
                            ELSE                        [Pop_2000]
                       END
   ,   [Pop_2000unad]=                                  [Pop_2000]
   ,   [Pop_2000_R]  =                            (     [Pop_2000]
                                                   /SUM([Pop_2000]) OVER(PARTITION BY [Country_fk],[chtn]))
   ,   [Pct_2000_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pct_2000] + (   (     [Pct_2000]
                                                   /SUM([Pct_2000]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_2000_d2]
                                                   +    [Pct_2000_dx])                                      )
                            ELSE                        [Pct_2000]
                       END
   ,   [Pct_2000_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pct_2000] + (   (     [Pct_2000]
                                                   /SUM([Pct_2000]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_2000_d2])                                      )
                                                   +    [Pct_2000_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pct_2000] + (   (     [Pct_2000]
                                                   /SUM([Pct_2000]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_2000_d2])                                      )
                            ELSE                        [Pct_2000]
                       END
   ,   [Pct_2000unad]=                                  [Pct_2000]
   ,   [Pct_2000_R]  =                            (     [Pct_2000]
                                                   /SUM([Pct_2000]) OVER(PARTITION BY [Country_fk],[chtn]))
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_2010_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pop_2010] + (   (     [Pop_2010]
                                                   /SUM([Pop_2010]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_2010_d2]
                                                   +    [Pop_2010_dx])                                      )
                            ELSE                        [Pop_2010]
                       END
   ,   [Pop_2010_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pop_2010] + (   (     [Pop_2010]
                                                   /SUM([Pop_2010]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_2010_d2])                                      )
                                                   +    [Pop_2010_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pop_2010] + (   (     [Pop_2010]
                                                   /SUM([Pop_2010]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pop_2010_d2])                                      )
                            ELSE                        [Pop_2010]
                       END
   ,   [Pop_2010unad]=                                  [Pop_2010]
   ,   [Pop_2010_R]  =                            (     [Pop_2010]
                                                   /SUM([Pop_2010]) OVER(PARTITION BY [Country_fk],[chtn]))
   ,   [Pct_2010_a]  = CASE WHEN [chtn]     = 1
                            THEN [Pct_2010] + (   (     [Pct_2010]
                                                   /SUM([Pct_2010]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_2010_d2]
                                                   +    [Pct_2010_dx])                                      )
                            ELSE                        [Pct_2010]
                       END
   ,   [Pct_2010_b]  = CASE WHEN [chtn]     = 1
                             AND [class]    = 'Catholics'
                            THEN [Pct_2010] + (   (     [Pct_2010]
                                                   /SUM([Pct_2010]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_2010_d2])                                      )
                                                   +    [Pct_2010_dx]
                            WHEN [chtn]     = 1
                             AND [class]   != 'Catholics'
                            THEN [Pct_2010] + (   (     [Pct_2010]
                                                   /SUM([Pct_2010]) OVER(PARTITION BY [Country_fk],[chtn]))
                                                * (     [Pct_2010_d2])                                      )
                            ELSE                        [Pct_2010]
                       END
   ,   [Pct_2010unad]=                                  [Pct_2010]
   ,   [Pct_2010_R]  =                            (     [Pct_2010]
                                                   /SUM([Pct_2010]) OVER(PARTITION BY [Country_fk],[chtn]))
/*----------------------------------------------------------------------------------------------------------------------------*/
FROM
(
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
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
   ,   [chtn]           = CASE
                              WHEN ( CASE
                                     WHEN A.[class] IS NOT NULL
                                     THEN A.[class]
                                     ELSE B.[class]
                                     END              ) IN ( 'Catholics', 'Other Christians', 'Protestant' )
                              THEN 1
                              ELSE 0
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
   ,   [Pct_1970]       = CASE
                              WHEN   [PAf_1970]   IS NOT NULL
                              THEN   [PAf_1970]
                              ELSE   [Pct_1970]
                     END
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
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_2000]       = CASE
                              WHEN   [Aff_2000]   IS NOT NULL
                              THEN   [Aff_2000]
                              ELSE   [Pop_2000]
                     END
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
   ,   [Pct_2000]       = CASE
                              WHEN   [PAf_2000]   IS NOT NULL
                              THEN   [PAf_2000]
                              ELSE   [Pct_2000]
                     END
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
/*----------------------------------------------------------------------------------------------------------------------------*/
   ,   [Pop_2010]       = CASE
                              WHEN   [Aff_2010]   IS NOT NULL
                              THEN   [Aff_2010]
                              ELSE   [Pop_2010]
                     END
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
   ,   [Pct_2010]       = CASE
                              WHEN   [PAf_2010]   IS NOT NULL
                              THEN   [PAf_2010]
                              ELSE   [Pct_2010]
                     END
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
) MYAGG
WHERE 
       [class] NOT IN ( '-- 2', '-- x' )
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
) ENDCALC
WHERE 
       [Country_fk]
     = [Country_ID]
ORDER BY 
           [Country_fk]
         , [chtn]  DESC
         , [class]
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
/******************************************************************************************************************************/
