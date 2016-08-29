/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 005    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the lookup table [forum_ResAnal].[dbo].[vr_03w_W&Extras_by_Ctry&Year]                           <<<<<     ***/
/***             This table only includes numeric values aggregated by country/religion & year (does not include descriptive wordings).                      ***/
/***             The table adds calculated variables using the basic variables stored in the database.                                                       ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
ALTER  VIEW                      [dbo].[vr___03_]        AS
SELECT * FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
/***************************************************************************************************************************************************************/
--*** May need to:
--    Clean XSG_25n27  as rowmax(GRX_25_01_2010 SHX_27_01_2010)
/*** main select statement *************************************************************************************************************************************/
/*** table including numeric values + Step-3 calculated variables **********************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* NOTE: scaled GRI_19_ b to f requested by Peter Henne in 2015 */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_19_b, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
                   GRI_19_b_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_b   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_b   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_b   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_b   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_b   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_b   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
/* GRI_19_c, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
       ,           GRI_19_c_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_c   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_c   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_c   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_c   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_c   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_c   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
/* GRI_19_d, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
       ,           GRI_19_d_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_d   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_d   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_d   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_d   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_d   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_d   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
/* GRI_19_e, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
       ,           GRI_19_e_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_e   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_e   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_e   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_e   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_e   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_e   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
/* GRI_19_f, scaled (0 = None, .2 = 1-9 cases, .4 = 10-200 cases, .6 = 201 - 1000 cases, .8 = 1001 - 9999 cases, 1 = 10000+ cases) */
       ,           GRI_19_f_scaled
       = CAST ((
         CASE 
              WHEN GRI_19_f   >  10000 THEN 1     -- (1   = 10000+      cases)
              WHEN GRI_19_f   >   1000 THEN 0.8   -- ( .8 =  1001 - 9999 cases)
              WHEN GRI_19_f   >    200 THEN 0.6   -- ( .6 =   201 - 1000 cases)
              WHEN GRI_19_f   >     10 THEN 0.4   -- ( .4 =    10 -  200 cases)
              WHEN GRI_19_f   >      0 THEN 0.2   -- ( .2 =     1 -    9 cases)
              WHEN GRI_19_f   =      0 THEN 0.0   -- (0   =  None             )
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* NOTE: scaled GRI_19_ b to f requested by Peter Henne in 2015 ends here */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* NOTE: scaled index values based in year 2007 */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_scaled index */
      ,  GRI_scaled 
         =        CAST ((
                  CASE
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'low'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 1.00
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'moderate'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 2.00
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 3.00
                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'very high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GRI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 4.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI_scaled index */
      ,  SHI_scaled 
         =        CAST ((
                  CASE
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'low'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 1.00
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'moderate'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 2.00
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 3.00
                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'very high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'SHI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 4.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI_scaled index */
      ,  GFI_scaled 
         =        CAST ((
                  CASE
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'low'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 1.00
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'moderate'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 2.00
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 3.00
                  WHEN GFI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
                                WHERE  [Field_fk]   = [Field_pk]
                                  AND  [Level]      = 'very high'
                                  AND  [Point]      = 'highest'
                                  AND  [Field_type] = 'GFI'
                                  AND  [Field_year] = '2007'
                              )
                  THEN 4.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI_rounded index */
      ,  GRI_rd_1d 
         =        CAST ((
                                  GRI 
                                                               ) AS DECIMAL (38,1))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI_rounded index */
      ,  SHI_rd_1d 
         =        CAST ((
                                  SHI 
                                                               ) AS DECIMAL (38,1))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI_rounded index */
      ,  GFI_rd_1d 
         =        CAST ((
                                  GFI
                                                               ) AS DECIMAL (38,1))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , *

FROM
/***************************************************************************************************************************************************************/
(
/*** table including numeric values + Step-2 calculated variables **********************************************************************************************/
SELECT
/* Indexes wiolll NOT fit previously published data  ----------------------------------------------------------------------------------------------------------*/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GRI index */
         GRI 
         =
                  CAST ((((
                                [GRI_01]
                         +      [GRI_02]
                         +      [GRI_03]
                         +      [GRI_04]
                         +      [GRI_05]
                         +      [GRI_06]
                         +      [GRI_07]
                         +      [GRI_08_for_index]
                         +      [GRI_09]
                         +      [GRI_10]
                         +      [GRI_11]
                         +      [GRI_12]
                         +      [GRI_13]
                         +      [GRI_14]
                         +      [GRI_15]
                         +      [GRI_16]
                         +      [GRI_17]
                         +      [GRI_18]
                         +      [GRI_19]
                         +      [GRI_20]
                                                       ) / 2    )
                                                                  ) AS DECIMAL (38,32))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* SHI index */
       , SHI 
         =        CAST ((((
                                [SHI_01]
                         +      [SHI_02]
                         +      [SHI_03]
                         +      [SHI_04]
                         +      [SHI_05]
                         +      [SHI_06]
                         +      [SHI_07]
                         +      [SHI_08]
                         +      [SHI_09]
                         +      [SHI_10]
                         +      [SHI_11_for_index]
                         +      [SHI_12]
                         +      [SHI_13]
                                                       ) / 1.3  )
                                                                  ) AS DECIMAL (38,32))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* GFI index */
       , GFI 
         =        CAST ((((
                                [GRI_20_01]
                         +      [GRI_20_02]
                         + ( (  [GRI_20_03_a]
                              + [GRI_20_03_b]
                              + [GRI_20_03_c]
                                               ) / 3 )
                         +      [GRI_20_04]
                         +      [GRI_20_05]
                                                       ) / 5 ) 
                                                              * 10
                                                                  ) AS DECIMAL (38,32))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Christianity */
       , XSG_01_xG1 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG1 + SHI_01_xG1 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Islam */
       , XSG_01_xG2 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG2 + SHI_01_xG2 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Buddhism */
       , XSG_01_xG3 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG3 + SHI_01_xG3 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Hinduism */
       , XSG_01_xG4 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG4 + SHI_01_xG4 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Judaism */
       , XSG_01_xG5 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG5 + SHI_01_xG5 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Other ('New' Religions, Ancient Religions, Sikhs, Zoroastrianism) */
       , XSG_01_xG6 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG6 + SHI_01_xG6 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Government & Social harassment of Ethnic or Tribal Religions */
       , XSG_01_xG7 
         =        CAST ((
                  CASE
                  WHEN GRI_11_xG7 + SHI_01_xG7 > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_01_summary_a_ny           for toplines */
       ,           SHI_01_summary_a_ny
       = CAST ((
         CASE 
              WHEN SHI_01     =  0.00
              THEN               0.00
              WHEN SHI_01     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nya
       = CAST ((
         CASE 
              WHEN SHI_01_a   >  0.00
              THEN               1.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nyb
       = CAST ((
         CASE 
              WHEN SHI_01_b   >  0.00
              THEN               1.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nyc
       = CAST ((
         CASE 
              WHEN SHI_01_c   >  0.00
              THEN               1.03
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nyd
       = CAST ((
         CASE 
              WHEN SHI_01_d   >  0.00
              THEN               1.04
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nye
       = CAST ((
         CASE 
              WHEN SHI_01_e   >  0.00
              THEN               1.05
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_summary_a_nyf
       = CAST ((
         CASE 
              WHEN SHI_01_f   >  0.00
              THEN               1.06
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 XSG_242526_ny           for toplines */
       ,           XSG_242526_ny
       = CAST ((
         CASE WHEN GRX_24     = 0.00
               AND SHX_25     = 0.00
               AND SHX_26     = 0.00
              THEN              0.00
              WHEN GRX_24     > 0.00
                OR SHX_25     > 0.00
                OR SHX_26     > 0.00
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
       ,           XSG_242526_ny1
       = CAST ((
         CASE WHEN GRX_24     = 0.00
               AND SHX_25     = 0.00
               AND SHX_26     = 0.00
              THEN              NULL
              WHEN GRX_24     = 1.00
                OR SHX_25     = 1.00
                OR SHX_26     = 1.00
              THEN              1.00
              WHEN GRX_24     = 0.67
                OR SHX_25     = 0.67
                OR SHX_26     = 0.67
              THEN              0.67
              WHEN GRX_24     = 0.33
                OR SHX_25     = 0.33
                OR SHX_26     = 0.33
              THEN              0.33
              END
                                                               ) AS DECIMAL (38,2))
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 XSG_25n27_ny           for toplines */
       ,           XSG_25n27_ny
       = CAST ((
         CASE WHEN GRX_25_ny  = 0.00
               AND SHX_27_ny  = 0.00
              THEN              0.00
              WHEN GRX_25_ny  = 0.01
                OR SHX_27_ny  = 0.01
              THEN              0.01
              END
                                                               ) AS DECIMAL (38,2))
       ,           XSG_25n27_ny2
       = CAST ((
         CASE WHEN GRX_25_ny2 = 0.02
                OR SHX_27_ny2 = 0.02
              THEN              0.02
              END
                                                               ) AS DECIMAL (38,2))
       ,           XSG_25n27_ny3
       = CAST ((
         CASE WHEN GRX_25_ny3 = 0.03
                OR SHX_27_ny3 = 0.03
              THEN              0.03
              END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

       , *
FROM
/***************************************************************************************************************************************************************/
(
/*** table including numeric values + Step-1 calculated variables **********************************************************************************************/
SELECT
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
         GRI_20
         =        ROUND(
                  CAST ((((
                                [GRI_20_01]
                         +      [GRI_20_02]
                         + ( (  [GRI_20_03_a]
                              + [GRI_20_03_b]
                              + [GRI_20_03_c]
                                               ) / 3 )
                         +      [GRI_20_04]
                         +      [GRI_20_05]
                                                       ) / 5  )
                                                               ) AS DECIMAL (38,2)) ,2)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , GRI_20_top
         =        CAST ((
                  CASE
                  WHEN GRI_20_03_a = 1
                    OR GRI_20_03_b = 1
                    OR GRI_20_03_c = 1
                    OR GRI_20_02   > 0.5
                  THEN               1.00
                  WHEN GRI_20_01   > 0
                    OR GRI_20_02   > 0
                    OR GRI_20_03_a > 0
                    OR GRI_20_03_b > 0
                    OR GRI_20_03_c > 0
                    OR GRI_20_04   > 0
                    OR GRI_20_05   > 0
                  THEN               0.50
                  ELSE               0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , GRI_20_03_top
         =        CAST ((
                  CASE
                  WHEN GRI_20_03_a >= GRI_20_03_b
                   AND GRI_20_03_a >= GRI_20_03_c
                  THEN GRI_20_03_a
                  WHEN GRI_20_03_b >= GRI_20_03_a
                   AND GRI_20_03_b >= GRI_20_03_c
                  THEN GRI_20_03_b
                  WHEN GRI_20_03_c >= GRI_20_03_b
                   AND GRI_20_03_c >= GRI_20_03_c
                  THEN GRI_20_03_c
                  ELSE NULL
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , 
--       select
       SHI_01
         =        CAST ((
                  (
                  CAST ((
                    ( CASE
                      WHEN SHI_01_a > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_b > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_c > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_d > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_e > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_f > 0 THEN 1
                      ELSE                   0
                       END                     )
                                                       
                                                               ) AS DECIMAL (38,2))
                                                                                    / 6 )
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , SHI_01_summary_b
         =        CAST ((
                  (
                  CAST ((
                    ( CASE
                      WHEN SHI_01_a > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_b > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_c > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_d > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_e > 0 THEN 1
                      ELSE                   0
                       END                     )
                  + ( CASE
                      WHEN SHI_01_f > 0 THEN 1
                      ELSE                   0
                       END                     )
                                                       
                                                               ) AS DECIMAL (38,2))
                                                                                    / 6 )
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_01_[a,b,c,d,e,f]_dummy for tables of question answers by country */
       ,           SHI_01_a_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_a   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_b_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_b   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_c_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_c   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_d_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_d   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_e_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_e   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_01_f_dummy
       = CAST ((
         CASE 
              WHEN SHI_01_f   >  0.00
              THEN               1
              ELSE               0
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Christianity */
       , GRI_11_xG1
         =        CAST ((
                  CASE
                  WHEN   GRI_11_01a
                       + GRI_11_01b
                       + GRI_11_02
                       + GRI_11_03
                       + GRI_11_11
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Islam */
       , GRI_11_xG2 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_04
                       + GRI_11_05
                       + GRI_11_06
                       + GRI_11_12
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Buddhism */
       , GRI_11_xG3 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_07
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Hinduism */
       , GRI_11_xG4 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_08
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Judaism */
       , GRI_11_xG5 
         =        CAST ((
                  CASE
                  WHEN   GRI_11_09
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Other ('New' Religions, Ancient Religions, Sikhs, Zoroastrianism) */
       , GRI_11_xG6 
         =        CAST ((
                  CASE
                  WHEN   isnull(GRI_11_10, 0)
                       + isnull(GRI_11_14, 0)
                       + isnull(GRI_11_15, 0)
                       + isnull(GRI_11_16, 0)
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Gov harassment of Ethnic or Tribal Religions */
       , GRI_11_xG7
         =        CAST ((
                  CASE
                  WHEN   GRI_11_13
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Christianity */
       , SHI_01_xG1
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_01a
                       + SHI_01_x_01b
                       + SHI_01_x_02
                       + SHI_01_x_03
                       + SHI_01_x_11
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Islam */
       , SHI_01_xG2 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_04
                       + SHI_01_x_05
                       + SHI_01_x_06
                       + SHI_01_x_12
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Buddhism */
       , SHI_01_xG3 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_07
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Hinduism */
       , SHI_01_xG4 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_08
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Judaism */
       , SHI_01_xG5 
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_09
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Other ('New' Religions, Ancient Religions, Sikhs, Zoroastrianism) */
       , SHI_01_xG6 
         =        CAST ((
                  CASE
                  WHEN   isnull(SHI_01_x_10, 0)
                       + isnull(SHI_01_x_14, 0)
                       + isnull(SHI_01_x_15, 0)
                       + isnull(SHI_01_x_16, 0)
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* Social harassment of Ethnic or Tribal Religions */
       , SHI_01_xG7
         =        CAST ((
                  CASE
                  WHEN   SHI_01_x_13
                  > 0
                  THEN 1.00
                  ELSE 0.00
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* recode GRI_08 to be used as index-factor */
       , GRI_08_for_index
         =        CAST ((
                  CASE
                  WHEN GRI_08  = 0.5
                  THEN           1
                  ELSE GRI_08
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/* recode SHI_Q_11 to be used as index-factor */
       , SHI_11_for_index
         =        CAST ((
                  CASE
                  WHEN SHI_11  = 0.5
                  THEN           1
                  ELSE SHI_11
                  END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_16               for toplines */
       ,           GRI_16_ny
       = CAST ((
         CASE 
              WHEN GRI_16     =  0.00
              THEN               0.00
              WHEN GRI_16     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_16_ny1
       = CAST ((
         CASE 
              WHEN GRI_16     =  0.00
              THEN               NULL
              WHEN GRI_16     >  0.00
              THEN               GRI_16
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19               for toplines */
       ,           GRI_19_ny
       = CAST ((
         CASE 
              WHEN GRI_19     =  0.00
              THEN               0.00
              WHEN GRI_19     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_ny1
       = CAST ((
         CASE 
              WHEN GRI_19     =  0.00
              THEN               NULL
              WHEN GRI_19     >  0.00
              THEN               GRI_19
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19_summ_ny          for toplines */
       ,           GRI_19_summ_ny
       = CAST ((
         CASE 
              WHEN GRI_19     =  0.00
              THEN               0.00
              WHEN GRI_19     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nyb
       = CAST ((
         CASE 
              WHEN GRI_19_b   >  0.00
              THEN               1.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nyc
       = CAST ((
         CASE 
              WHEN GRI_19_c   >  0.00
              THEN               1.03
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nyd
       = CAST ((
         CASE 
              WHEN GRI_19_d   >  0.00
              THEN               1.04
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nye
       = CAST ((
         CASE 
              WHEN GRI_19_e   >  0.00
              THEN               1.05
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRI_19_summ_nyf
       = CAST ((
         CASE 
              WHEN GRI_19_f   >  0.00
              THEN               1.06
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRI_19_x              for toplines */
       ,           GRI_19_x
       =           ISNULL(GRI_19_b, 0)
                 + ISNULL(GRI_19_c, 0)
                 + ISNULL(GRI_19_d, 0)
                 + ISNULL(GRI_19_e, 0)
                 + ISNULL(GRI_19_f, 0)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_04_ny          for toplines */
       ,           SHI_04_ny
       = CAST ((
         CASE 
              WHEN SHI_04     =  0.00
              THEN               0.00
              WHEN SHI_04     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_04_ny1
       = CAST ((
         CASE 
              WHEN SHI_04     =  0.00
              THEN               NULL
              WHEN SHI_04     >  0.00
              THEN               SHI_04
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_05_ny          for toplines */
       ,           SHI_05_ny
       = CAST ((
         CASE 
              WHEN SHI_05     =  0.00
              THEN               0.00
              WHEN SHI_05     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_05_ny1
       = CAST ((
         CASE 
              WHEN SHI_05     =  0.00
              THEN               NULL
              WHEN SHI_05     >  0.00
              THEN               SHI_05
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_07_ny          for toplines */
       ,           SHI_07_ny
       = CAST ((
         CASE 
              WHEN SHI_07     =  0.00
              THEN               0.00
              WHEN SHI_07     >  0.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHI_07_ny1
       = CAST ((
         CASE 
              WHEN SHI_07     =  0.00
              THEN               NULL
              WHEN SHI_07     >  0.00
              THEN               SHI_07
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHI_01_x              for toplines??? - added on Dec2015  */
       ,           SHI_01_x
       =           ISNULL(SHI_01_b, 0)
                 + ISNULL(SHI_01_c, 0)
                 + ISNULL(SHI_01_d, 0)
                 + ISNULL(SHI_01_e, 0)
                 + ISNULL(SHI_01_f, 0)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22               for toplines */
--     ,           GRX_22_ny1    => this was the former name
       ,           GRX_22_aggreg
       = CAST ((
         CASE WHEN ISNULL(GRX_22   , 9)  = 9
               AND ISNULL(GRX_22_01, 9)  = 9
               AND ISNULL(GRX_22_02, 9)  = 9
               AND ISNULL(GRX_22_04, 9)  = 9
              THEN               NULL
              WHEN ISNULL(GRX_22   , 0)  < 0.66
               AND ISNULL(GRX_22_01, 0)  < 0.66
               AND ISNULL(GRX_22_02, 0)  < 0.66
               AND ISNULL(GRX_22_04, 0)  < 0.66
              THEN              0
              WHEN ISNULL(GRX_22   , 0)  < 1.00
               AND ISNULL(GRX_22_01, 0)  < 1.00
               AND ISNULL(GRX_22_02, 0)  < 1.00
               AND ISNULL(GRX_22_04, 0)  < 1.00
              THEN              0.67
              WHEN GRX_22     = 1.00
                OR GRX_22_01  = 1.00
                OR GRX_22_02  = 1.00
                OR GRX_22_04  = 1.00
              THEN              1.00
--              ELSE 1000                       /*this for checking any value non-recoded*/
              END
                                                               ) AS DECIMAL (38,2))
/* current does not display "NO" -- this would be just a dummy but it has NOT BEEN TESTED: */
---------------------------------------------------------------------------------------------
--       ,           GRX_22_ny
--       = CAST ((
--         CASE WHEN ISNULL(GRX_22   , 9)   = 9
--               AND ISNULL(GRX_22_01, 9)   = 9
--               AND ISNULL(GRX_22_02, 9)   = 9
--               AND ISNULL(GRX_22_04, 9)   = 9
--              THEN               NULL
--              WHEN ISNULL(GRX_22   , 0)   < 0.66
--               AND ISNULL(GRX_22_01, 0)   < 0.66
--               AND ISNULL(GRX_22_02, 0)   < 0.66
--               AND ISNULL(GRX_22_04, 0)   < 0.66
--              THEN              0
--              WHEN ISNULL(GRX_22   , 0)  >= 0.66
--               AND ISNULL(GRX_22_01, 0)  >= 0.66
--               AND ISNULL(GRX_22_02, 0)  >= 0.66
--               AND ISNULL(GRX_22_04, 0)  >= 0.66
--              THEN              0.01
--              END
--                                                               ) AS DECIMAL (38,2))
---------------------------------------------------------------------------------------------
/*                                                         END of CODE -> NOT BEEN TESTED: */
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_01               for toplines */
       ,           GRX_22_01_ny
       = CAST ((
         CASE WHEN GRX_22_01  < 0.66
              THEN              0
              WHEN GRX_22_01 >= 0.66
              THEN              0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_01_ny1
       = CAST ((
         CASE WHEN GRX_22_01  < 0.66
              THEN              NULL
              WHEN GRX_22_01 >= 0.66
              THEN              GRX_22_01
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_02               for toplines */
       ,           GRX_22_02_ny
       = CAST ((
         CASE WHEN GRX_22_02  < 0.66
              THEN              0
              WHEN GRX_22_02 >= 0.66
              THEN              0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_02_ny1
       = CAST ((
         CASE WHEN GRX_22_02  < 0.66
              THEN              NULL
              WHEN GRX_22_02 >= 0.66
              THEN              GRX_22_02
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_03               for toplines */
       ,           GRX_22_03_ny
       = CAST ((
         CASE WHEN GRX_22_03  <  0.66
              THEN               0
              WHEN GRX_22_03 >=  0.66
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_03_ny1
       = CAST ((
         CASE WHEN GRX_22_03  <  0.66
              THEN               NULL
              WHEN GRX_22_03 >=  0.66
              THEN               GRX_22_03
        END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_22_04               for toplines */
       ,           GRX_22_04_ny
       = CAST ((
         CASE WHEN GRX_22_04  <  0.66
              THEN               0
              WHEN GRX_22_04 >=  0.66
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_22_04_ny1
       = CAST ((
         CASE WHEN GRX_22_04  <  0.66
              THEN               NULL
              WHEN GRX_22_04 >=  0.66
              THEN               GRX_22_04
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_24               for toplines */
       ,           GRX_24_ny
       = CAST ((
         CASE WHEN GRX_24     =  0
              THEN               0
              WHEN GRX_24     >  0
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_24_ny1
       = CAST ((
         CASE WHEN GRX_24     =  0
              THEN               NULL
              WHEN GRX_24     >  0
              THEN               GRX_24
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 GRX_25               for toplines */
       ,           GRX_25_ny
       = CAST ((
         CASE 
              WHEN GRX_25_01  =  0.00
              THEN               0.00
              WHEN GRX_25_01  =  1.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_25_ny2
       = CAST ((
         CASE 
              WHEN GRX_25_02  =  1.00
              THEN               0.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           GRX_25_ny3
       = CAST ((
         CASE 
              WHEN GRX_25_03  =  1.00
              THEN               0.03
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHX_25               for toplines */
       ,           SHX_25_ny
       = CAST ((
         CASE WHEN SHX_25     =  0
              THEN               0
              WHEN SHX_25     >  0
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHX_25_ny1
       = CAST ((
         CASE WHEN SHX_25     =  0
              THEN               NULL
              WHEN SHX_25     >  0
              THEN               SHX_25
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHX_26               for toplines */
       ,           SHX_26_ny
       = CAST ((
         CASE WHEN SHX_26     =  0
              THEN               0
              WHEN SHX_26     >  0
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHX_26_ny1
       = CAST ((
         CASE WHEN SHX_26     =  0
              THEN               NULL
              WHEN SHX_26     >  0
              THEN               SHX_26
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                 SHX_27               for toplines */
       ,           SHX_27_ny
       = CAST ((
         CASE 
              WHEN SHX_27_01  =  0.00
              THEN               0.00
              WHEN SHX_27_01  =  1.00
              THEN               0.01
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHX_27_ny2
       = CAST ((
         CASE 
              WHEN SHX_27_02  =  1.00
              THEN               0.02
         END
                                                               ) AS DECIMAL (38,2))
       ,           SHX_27_ny3
       = CAST ((
         CASE 
              WHEN SHX_27_03  =  1.00
              THEN               0.03
         END
                                                               ) AS DECIMAL (38,2))
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
       , *
FROM
/*** View including numeric values aggregated by country/religion & year ***************************************************************************************/
               [dbo].[vr___02_cDB_Wide__by_Ctry&Year]
/*************************************************************************************** View including numeric values aggregated by country/religion & year ***/
/********************************************************************************************** table including numeric values + Step-1 calculated variables ***/
)                                                                                                                                                       AS NV_S1
/***************************************************************************************************************************************************************/
)                                                                                                                                                       AS NV_S2
/********************************************************************************************** table including numeric values + Step-2 calculated variables ***/
/********************************************************************************************** table including numeric values + Step-3 calculated variables ***/
/************************************************************************************************************************************* main select statement ***/
/***************************************************************************************************************************************************************/
) formerview                                                        /***        last row of code for the VIEW                                                ***/
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/








/***************************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___03_cDB_W&Xtra_byCtry&Year]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___03_cDB_W&Xtra_byCtry&Year]
SELECT * INTO    [forum_ResAnal].[dbo].[vr___03_cDB_W&Xtra_byCtry&Year]
            FROM                 [dbo].[vr___03_]
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/
--	SELECT* FROM [forum_ResAnal].[dbo].[vr___03_cDB_W&Xtra_byCtry&Year]
/***************************************************************************************************************************************************************/
