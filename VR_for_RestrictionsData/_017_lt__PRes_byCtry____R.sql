/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 017    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [forum_ResAnal].[dbo].[vr___17_cDB_                  ]                                 <<<<<     ***/
/***             This view includes ...                                                                                                                      ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***************************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
--  DECLARE @PYr    varchar(4)
--  DECLARE @CYr    varchar(4)
--  SET     @PYr = (CONVERT(VARCHAR(4),(SELECT MAX([Question_Year])-1 FROM [vr___06_cDB_LongData_ALL_byCYQ])))
--  SET     @CYr = (CONVERT(VARCHAR(4),(SELECT MAX([Question_Year])   FROM [vr___06_cDB_LongData_ALL_byCYQ])))
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
ALTER  VIEW                      [dbo].[vr___12_]
AS
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
WITH
         YS
      AS
         (  
            SELECT 
                   DISTINCT
                   TOP 2
                   [Question_Year] AS [Y]
              FROM [vr___06_cDB_LongData_ALL_byCYQ]
          ORDER BY [Question_Year] DESC
         )
   ,     AllAtts
      AS
         (  
           SELECT 
                    [Q]  =           [Question_abbreviation_std]
                  , [E4] =        A4.[attr]
                  , [E3] =           [Question_wording_std]
                  , [E2] =        A2.[attr]
                  , [Ex] = ISNULL(Ax.[attr]                      , '')
            FROM
                                 [forum]..[Pew_Question_Std]
            INNER
            JOIN 
                 ( SELECT * FROM [forum]..[Pew_Question_Attributes]
                            WHERE [attk]
                                = 'RbyC_scale'                        )  A2
              ON      [Question_Std_pk]
                 = A2.[Question_Std_fk]
            LEFT
            JOIN 
                 ( SELECT * FROM [forum]..[Pew_Question_Attributes]
                            WHERE [attk]
                                = 'TopLine label'                     )  A4
              ON      [Question_Std_pk]
                 = A4.[Question_Std_fk]
            LEFT
            JOIN 
                 ( SELECT * FROM [forum]..[Pew_Question_Attributes]
                            WHERE [attk]
                                = 'XNote_RbyC'                        )  Ax
              ON      [Question_Std_pk]
                 = Ax.[Question_Std_fk]
         )
   ,     Headngs
      AS
         (  
           SELECT 
                    [m]
                  , [Q]
                  , [k1]    =     NULL
                  , [c1]
                  , [rY_1]  =     ''
                  , [pY_1]  =     ''
                  , [cY_1]  =     ''
                  , [k2]    =     NULL
                  , [c2]    =     ''
                  , [rY_2]  =     ''
                  , [pY_2]  =     ''
                  , [cY_2]  =     ''
                  , [k3]    =     NULL
                  , [c3]    =     ''
                  , [rY_3]  =     ''
                  , [pY_3]  =     ''
                  , [cY_3]  =     ''
            FROM
                 (           
                             SELECT 
                                    [m]     =     -4
                                  , [Q]
                                  , [c1]    =     [E4]
                               FROM [AllAtts]
                   UNION ALL SELECT 
                                    [m]     =     -3
                                  , [Q]
                                  , [c1]    =     [E3]
                               FROM [AllAtts]
                   UNION ALL SELECT 
                                    [m]     =     -2
                                  , [Q]
                                  , [c1]    =     [E2]
                               FROM [AllAtts]
                   UNION ALL SELECT 
                                    [m]     =      99
                                  , [Q]
                                  , [c1]    =     [Ex]
                               FROM [AllAtts]
                 ) AA
           UNION 
           ALL 
           SELECT 
                    [m]
                  , [Q]
                  , [k1]    =     NULL
                  , [c1]    =     'Country / Territory'
                  , [rY_1]  =     'baseline' + CHAR(10) + 'year,' + CHAR(10) + 'ending' + CHAR(10) + 'JUN ' + '2007'
                  , [pY_1]  =     'previous' + CHAR(10) + 'year,' + CHAR(10) + 'ending' + CHAR(10) + 'DEC ' + (CONVERT(VARCHAR(4),(SELECT MIN([Y]) FROM [YS])))
                  , [cY_1]  =     'latest'   + CHAR(10) + 'year,' + CHAR(10) + 'ending' + CHAR(10) + 'DEC ' + (CONVERT(VARCHAR(4),(SELECT MAX([Y]) FROM [YS])))
                  , [k2]    =     NULL
                  , [c2]    =     'Country / Territory'
                  , [rY_2]  =     'baseline' + CHAR(10) + 'year,' + CHAR(10) + 'ending' + CHAR(10) + 'JUN ' + '2007'
                  , [pY_2]  =     'previous' + CHAR(10) + 'year,' + CHAR(10) + 'ending' + CHAR(10) + 'DEC ' + (CONVERT(VARCHAR(4),(SELECT MIN([Y]) FROM [YS])))
                  , [cY_2]  =     'latest'   + CHAR(10) + 'year,' + CHAR(10) + 'ending' + CHAR(10) + 'DEC ' + (CONVERT(VARCHAR(4),(SELECT MAX([Y]) FROM [YS])))
                  , [k3]    =     NULL
                  , [c3]    =     'Country / Territory'
                  , [rY_3]  =     'baseline' + CHAR(10) + 'year,' + CHAR(10) + 'ending' + CHAR(10) + 'JUN ' + '2007'
                  , [pY_3]  =     'previous' + CHAR(10) + 'year,' + CHAR(10) + 'ending' + CHAR(10) + 'DEC ' + (CONVERT(VARCHAR(4),(SELECT MIN([Y]) FROM [YS])))
                  , [cY_3]  =     'latest'   + CHAR(10) + 'year,' + CHAR(10) + 'ending' + CHAR(10) + 'DEC ' + (CONVERT(VARCHAR(4),(SELECT MAX([Y]) FROM [YS])))
            FROM
                 (           
                             SELECT 
                                    [m]     =     -1
                                  , [Q] ---    =     [Question_abbreviation_std]
                               FROM [AllAtts]
                              ---- FROM [forum]..[Pew_Question_Std]
                              ----INNER
                              ----JOIN 
                              ----     ( SELECT * FROM [forum]..[Pew_Question_Attributes]
                              ----               WHERE [attk]
                              ----             = 'RbyC_scale'                             )  A
                              ----  ON      [Question_Std_pk]
                              ----      = A.[Question_Std_fk]
                 ) A0
         )
   ,     AllNfks
      AS
         (  
           SELECT 
                      DISTINCT   [Nation_fk]          AS [k]
                               , [Ctry_EditorialName] AS [C]
             FROM     [vr___06_cDB_LongData_ALL_byCYQ]
            WHERE     [Nation_fk] < 500
         )
   ,     NumNfks
      AS
         (  
           SELECT 
                      [k]
                    , [C]
                    , [n] =  ROW_NUMBER() OVER(ORDER BY [C])
                    , [t] =  (SELECT COUNT(k) FROM [AllNfks])
             FROM     [AllNfks]
         )
   ,     CodNfks
      AS

--select * into #CodNfks
--         from

         (  
           SELECT 
                      [k]
                    , [C]
                    , [t]
                    , [s] =  CASE WHEN [n] <= (1*([t]/3)) THEN '_1'
                                  WHEN [n] <= (2*([t]/3)) THEN '_2'
                                  WHEN [n] <= (3*([t]/3)) THEN '_3'
                                                          END
                    , [m] =  CASE WHEN [n] <= (1*([t]/3)) THEN [n] - (0*([t]/3))
                                  WHEN [n] <= (2*([t]/3)) THEN [n] - (1*([t]/3))
                                  WHEN [n] <= (3*([t]/3)) THEN [n] - (2*([t]/3))
                                                          END
             FROM     [NumNfks]
         )

--            CTE3

   ,     CtyCols
      AS

--select * into #CtyCols
--         from

         (  
           SELECT 
                      [ma]   =     [m]
                    , [k1]   = MAX([k_1])
                    , [c1]   = MAX([c_1] )
                    , [k2]   = MAX([k_2])
                    , [c2]   = MAX([c_2] )
                    , [k3]   = MAX([k_3])
                    , [c3]   = MAX([c_3] )
             FROM 
                  (
                   SELECT 
                          [m]
                         ,[k]
                         ,[C]
                         ,[cs] = 'c' + [s]
                         ,[ks] = 'k' + [s]

                     FROM  [CodNfks]

--                     FROM  [#CodNfks]
                                     ) SelCs1


                                 PIVOT
                                         (MAX ([C] ) 
                                          FOR  [cs]
                                          IN ( [c_1]
                                              ,[c_2]
                                              ,[c_3] ))  AS P1
                                 PIVOT
                                         (MAX ([k] ) 
                                          FOR  [ks]
                                          IN ( [k_1]
                                              ,[k_2]
                                              ,[k_3] ))  AS P2

            GROUP
               BY [m]
         )

--            CTE4

   ,     NumData
      AS

--select * into #NumData
--         from

         (  
           SELECT 
                      *
        --          , [n]
             FROM     (
                       SELECT 
                          [mb] = [m]
                         ,[Q]  = [QA_std]
                         ,[AV] = STR([Answer_value] , 6,2)
                         ,[QY] = 
                          CASE
                          WHEN [Question_Year]   = 2007                                                                THEN 'rY' + [s]
                          WHEN [Question_Year]+1 = (SELECT MAX([Question_Year]) FROM [vr___06_cDB_LongData_ALL_byCYQ]) THEN 'pY' + [s]
                          WHEN [Question_Year]   = (SELECT MAX([Question_Year]) FROM [vr___06_cDB_LongData_ALL_byCYQ]) THEN 'cY' + [s]
                           END
                         FROM  [vr___06_cDB_LongData_ALL_byCYQ]
                    INNER
                     JOIN 
  --                          [#CodNfks]
                            [CodNfks]
                       ON   [Nation_fk]
                          = [k]
                    INNER
                     JOIN 
                          ( SELECT * FROM [forum]..[Pew_Question_Attributes]
                                    WHERE [attk]
                                        = 'TLC label'                           )  ATT
                       ON   [QSk]
                          = [Question_Std_fk]

                    WHERE
                            [Question_Year] IN (   
                                                   2007 
                                                , (    SELECT MAX([Question_Year]) FROM [vr___06_cDB_LongData_ALL_byCYQ] )
                                                , (-1+(SELECT MAX([Question_Year]) FROM [vr___06_cDB_LongData_ALL_byCYQ]))
                                               )
                           ) CDDB
                                   PIVOT
                                         (MAX ([AV]) 
                                          FOR  [QY]
                                          IN ( 
                                               [rY_1]
                                              ,[pY_1]
                                              ,[cY_1]
                                              ,[rY_2]
                                              ,[pY_2]
                                              ,[cY_2]
                                              ,[rY_3]
                                              ,[pY_3]
                                              ,[cY_3]
                                                      ))  AS VPY
         )

--            CTE5

   --,     NumData
   --   AS

SELECT
          vRow
          =  ROW_NUMBER()
             OVER(ORDER BY   CASE WHEN [Q] = 'GRI_20_03_top'
                                  THEN       'GRI_20_03'
                                  ELSE [Q]
                              END
                           ,           [m]                                          )
        , *
   FROM
         (  
            SELECT 
                      [m]    =     [ma]
                    , [Q]
                    , [k1]
                    , [c1]
                    , [rY_1]
                    , [pY_1]
                    , [cY_1]
                    , [k2]
                    , [c2]
                    , [rY_2]
                    , [pY_2]
                    , [cY_2]
                    , [k3]
                    , [c3]
                    , [rY_3] = ISNULL([rY_3], ' n/a')
                    , [pY_3]
                    , [cY_3]




             FROM     

--                             [#CtyCols]
                             [CtyCols]

                        INNER
                         JOIN 

--                             [#NumData]
                             [NumData]

                       ON   
                            [ma]   =     [mb]
 UNION ALL SELECT     *
             FROM     

                             [Headngs]
  
         ) UNSORTDATA 
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/










/***************************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___12_cDB_Results_by_Country]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___12_cDB_Results_by_Country]
SELECT * 	INTO [forum_ResAnal].[dbo].[vr___12_cDB_Results_by_Country]
            FROM                 [dbo].[vr___12_]
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/
--	SELECT* FROM [forum_ResAnal].[dbo].
/***************************************************************************************************************************************************************/
