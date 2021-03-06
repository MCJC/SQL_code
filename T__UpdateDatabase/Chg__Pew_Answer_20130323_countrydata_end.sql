/*********************************************************************************************************/
SELECT *
  INTO  [_bk_forum].[dbo].[Pew_Answer_2013_03_25a_country]
  FROM      [forum].[dbo].[Pew_Answer]
SELECT *
  INTO  [_bk_forum].[dbo].[Pew_Nation_Answer_2013_03_25a_country]
  FROM      [forum].[dbo].[Pew_Nation_Answer]
/*********************************************************************************************************/
SELECT *
  INTO [juancarlos].[dbo].[Pew_Answer]
  FROM      [forum].[dbo].[Pew_Answer]
SELECT *
  INTO [juancarlos].[dbo].[Pew_Nation_Answer]
  FROM      [forum].[dbo].[Pew_Nation_Answer]
/*********************************************************************************************************/

-- Should add & check
-- drop 1K rows from nation-asnwer linking table where
-- answers have been deleted & links are not needed any more
-- (we don't know them from the Excel table)


--- check also texts not attached to numbers...


-- Step 01
-- Correct wrong values
UPDATE
                [forum].[dbo].[Pew_Answer]                                                    -- DB name
SET
                [forum].[dbo].[Pew_Answer].[Answer_value]    = 1                              -- DB name
         ,      [forum].[dbo].[Pew_Answer].[Question_fk]     = 1080                           -- DB name
         ,      [forum].[dbo].[Pew_Answer].[Answer_wording]  = 'On Sept. 6, Seoul immigratio' -- DB name
          + 'n authorities, accompanied by local police, forced their way into the home of t'
          + 'wo Falun Gong practitioners of Chinese nationality, 26-year-old Mr. Jin and his'
          + ' wife Ms. Ma. They arrested the couple for lacking legal status after their app'
          + 'lications for asylum had been denied. [¦] It is a signatory of the UN Convent'
          + 'ion Against Torture, whose Article 3 says in part,    No State Party shall expe'
          + 'l, return (rrefouler) or extradite a person to another State where there ar'
          + 'e substantial grounds for believing that he would be in danger of being subject'
          + 'ed to torture. [¦] The Korean Falun Dafa Association (KFDA) has in the past s'
          + 'tated that the deportations from South Korea to China are due to their governme'
          + 'nt bending to pressure from the Chinese regime. A KDFA statement, released on J'
          + 'an. 24 and issued following the sudden deportation of three Falun Gong practiti'
          + 'oners to China, links the South Korean policy of deportation to visits by two C'
          + 'hinese officials. (HRWF 2011) [Immigrants are in the country, Chinese governmen'
          + 't is outside.] (Coder note)'
         ,      [forum].[dbo].[Pew_Answer].[answer_wording_std]  = 'Yes'                      -- DB name
WHERE
                [forum].[dbo].[Pew_Answer].[Answer_pk]    = 10438                             -- DB name
-- Delete corresponding numeric value from the Nation_Answer table
DELETE FROM 
                 [forum].[dbo].[Pew_Nation_Answer]                                            -- DB name
--SELECT*FROM      [forum].[dbo].[Pew_Nation_Answer]
WHERE
                 [forum].[dbo].[Pew_Nation_Answer].[Answer_fk] = 10405                        -- DB name
AND
                 [forum].[dbo].[Pew_Nation_Answer].[Nation_fk] =   194                        -- DB name

/*********************************************************************************************************/

-- Step 02
-- drop answers (text-answers) of 
--                      GRX_25_01_text
--                      SHX_27_01_text
--                                     because they are meaningless

DELETE FROM 
                 [forum].[dbo].[Pew_answer]                                                   -- DB name
WHERE
                 [forum].[dbo].[Pew_answer].[Question_fk] IN                                  -- DB name
                                                           (417, 497)

/*********************************************************************************************************/

-- Step 03
-- drop answer rows when they:
--                              1. have empty [answer_wording] and NULL [answer_wording_std]
--                              2. correspond to text variables questions abbreviation ending int "text"
--                              3. they correspond to answers in value 0 or are missing for answers in value 1
-- should add : have no link to number question but linked to country through link table

DELETE
                 [forum].[dbo].[Pew_Answer]                                                   -- DB name
FROM
--SELECT * FROM
                 [forum].[dbo].[Pew_Answer]                                                   -- DB name
LEFT OUTER JOIN
                 (
                      SELECT  
                               distinct
                               A.[Answer_pk]
                             , Q.[Question_abbreviation_std]
                        FROM [forum].[dbo].[Pew_Answer]            A
                            ,[forum].[dbo].[Pew_Question]          Q
                            ,[forum].[dbo].[Pew_Nation_Answer]     KN
                      WHERE Q.[Question_pk]                   =  A.[Question_fk]
                        AND A.[Answer_pk]                     = KN.[Answer_fk]
                        AND Q.[Question_abbreviation_std]     LIKE '%text'
                        AND Answer_wording                    =    ''
                        AND answer_wording_std                IS   NULL
                        AND A.Answer_pk                       IN   (
                                                                      3476
                                                                    , 3518
                                                                    , 3878
                                                                    , 3923
                                                                  )
                 )                                                                    A
ON
                 [forum].[dbo].[Pew_Answer].[Answer_pk]                                       -- DB name
          =                               A.[Answer_pk]
WHERE                                     A.[Answer_pk]   IS NOT NULL

/*********************************************************************************************************/

-- Step 04
-- drop 1K rows from nation-asnwer linking table where
-- answers have been deleted & links are not needed any more
-- (we don't know them from the Excel table)

DELETE
                 [forum].[dbo].[Pew_Nation_Answer]                                            -- DB name
FROM
--SELECT distinct answer_fk FROM  -- 19 DISTINCT, 1000 ROWS
--SELECT *                  FROM  -- 19 DISTINCT, 1000 ROWS
                 [forum].[dbo].[Pew_Nation_Answer]                                            -- DB name
LEFT OUTER JOIN
                 [forum].[dbo].[Pew_Answer]                 A                                 -- DB name
ON
                 [forum].[dbo].[Pew_Nation_Answer].[Answer_fk]
          =                                      A.[Answer_pk]
WHERE                                            A.[Answer_pk]   IS NULL

--> nation answer link should be consistent

/*********************************************************************************************************/

-- Step 05
-- attach answer values, standard wording, and question keys to corresponding answers (country level)
UPDATE
                [forum].[dbo].[Pew_Answer]                                                    -- DB name
SET
                [forum].[dbo].[Pew_Answer].[Answer_value]                                     -- DB name
       =                             toolT.[Answer_value]
     ,
                [forum].[dbo].[Pew_Answer].[Answer_wording_std]                               -- DB name
       =                             toolT.[Answer_wording_std]
     ,
                [forum].[dbo].[Pew_Answer].[Question_fk]                                      -- DB name
       =                             toolT.[Question_fk]
FROM
--select * from
                [forum].[dbo].[Pew_Answer]   AS mydbt                                         -- DB name
 JOIN
       (
          SELECT 
                  Answer_pk                    = TT.[Answer_fk]
                , Answer_value                 = VV.[Answer_value]
                , Question_fk                  = VV.[Question_fk]
                , Answer_wording               = TT.[Answer_wording]
                , Answer_wording_std           = VV.[answer_wording_std]
          FROM
          /****************************************************************************************************/
          (
          SELECT 
                  level                      = 'Ctry'
                , Answer_fk                  = A.[Answer_pk]
                , Answer_value               = A.[Answer_value]
                , Answer_wording             = A.[Answer_wording]
                , answer_wording_std         = A.[answer_wording_std]
                , Question_fk                = Q.[Question_pk]
                , Question_abbreviation_std  = Q.[Question_abbreviation_std]
                , Question_abbreviation      = Q.[Question_abbreviation]
                , Question_wording           = Q.[Question_wording]
                , Data_source_fk             = Q.[Data_source_fk]
                , Question_Year              = Q.[Question_Year]
                , Short_wording              = Q.[Short_wording]
                , Notes                      = Q.[Notes]
                , Default_response           = Q.[Default_response]
                , Question_wording_std       = Q.[Question_wording_std]
                , Question_short_wording_std = Q.[Question_short_wording_std]
                , Nation_fk                  = KN.[Nation_fk]
                , link_fk                    = KN.[Nation_answer_pk]
            FROM      [forum].[dbo].[Pew_Answer]            A                                 -- DB name
                ,     [forum].[dbo].[Pew_Question]          Q                                 -- DB name
                ,     [forum].[dbo].[Pew_Nation_Answer]     KN                                -- DB name
          WHERE Q.[Question_pk] =  A.[Question_fk]
            AND A.[Answer_pk]   = KN.[Answer_fk]
            AND Q.[Question_abbreviation_std]     LIKE '%text'
          ) TT
          /****************************************************************************************************/
          join
          /****************************************************************************************************/
          (
          SELECT 
                  level                      = 'Ctry'
                , Answer_fk                  = A.[Answer_pk]
                , Answer_value               = A.[Answer_value]
                , Answer_wording             = A.[Answer_wording]
                , answer_wording_std         = A.[answer_wording_std]
                , Question_fk                = Q.[Question_pk]
                , Question_abbreviation_std  = Q.[Question_abbreviation_std]
                , Question_abbreviation      = Q.[Question_abbreviation]
                , Question_wording           = Q.[Question_wording]
                , Data_source_fk             = Q.[Data_source_fk]
                , Question_Year              = Q.[Question_Year]
                , Short_wording              = Q.[Short_wording]
                , Notes                      = Q.[Notes]
                , Default_response           = Q.[Default_response]
                , Question_wording_std       = Q.[Question_wording_std]
                , Question_short_wording_std = Q.[Question_short_wording_std]
                , Nation_fk                  = KN.[Nation_fk]
                , link_fk                    = KN.[Nation_answer_pk]
            FROM      [forum].[dbo].[Pew_Answer]            A                                 -- DB name
                ,     [forum].[dbo].[Pew_Question]          Q                                 -- DB name
                ,     [forum].[dbo].[Pew_Nation_Answer]     KN                                -- DB name
          WHERE Q.[Question_pk] =  A.[Question_fk]
            AND A.[Answer_pk]   = KN.[Answer_fk]
            AND Q.[Question_abbreviation_std] NOT LIKE '%text'
          ) VV
          /****************************************************************************************************/
          ON 
                  VV.Nation_fk
                = TT.Nation_fk
          AND
                  VV.Question_Year
                = TT.Question_Year
          AND
                            VV.Question_abbreviation_std
                = SUBSTRING(TT.Question_abbreviation_std,1, 9)
       ) AS toolT
ON
           mydbt.Answer_pk
       =   toolT.Answer_pk

/*********************************************************************************************************/

-- Step 06
-- drop link to answers whose numeric value has already been attached to the text
-- (known from excel list)

DELETE FROM 
                 [forum].[dbo].[Pew_Nation_Answer]                                            -- DB name
WHERE
                 [forum].[dbo].[Pew_Nation_Answer].[Nation_answer_pk] IN                      -- DB name
                                                           (
                                                             42095
                                                           , 42535
                                                           , 42887
                                                           , 42975
                                                           , 43239
                                                           , 44031
                                                           , 44383
                                                           , 45175
                                                           , 45527
                                                           , 45791
                                                           , 46055
                                                           , 46143
                                                           , 46847
                                                           , 47023
                                                           , 47111
                                                           , 47815
                                                           , 47991
                                                           , 48079
                                                           , 48871
                                                           , 49487
                                                           , 50191
                                                           , 50807
                                                           , 51775
                                                           , 52127
                                                           , 52391
                                                           , 52831
                                                           , 53095
                                                           , 53447
                                                           , 53623
                                                           , 54063
                                                           , 54503
                                                           , 55119
                                                           , 55823
                                                           , 56615
                                                           , 57671
                                                           , 58727
                                                           , 58991
                                                           , 59079
                                                           , 59167
                                                           , 41921
                                                           , 42097
                                                           , 42449
                                                           , 42537
                                                           , 42625
                                                           , 42977
                                                           , 43417
                                                           , 43505
                                                           , 44121
                                                           , 44297
                                                           , 44385
                                                           , 45353
                                                           , 45529
                                                           , 45617
                                                           , 45793
                                                           , 46057
                                                           , 46145
                                                           , 46321
                                                           , 46585
                                                           , 46761
                                                           , 46849
                                                           , 46937
                                                           , 47025
                                                           , 47113
                                                           , 47905
                                                           , 48873
                                                           , 49313
                                                           , 49489
                                                           , 49753
                                                           , 50105
                                                           , 50193
                                                           , 50721
                                                           , 50809
                                                           , 50897
                                                           , 52041
                                                           , 52129
                                                           , 52481
                                                           , 52657
                                                           , 52833
                                                           , 52921
                                                           , 53009
                                                           , 53097
                                                           , 53449
                                                           , 54505
                                                           , 55121
                                                           , 55737
                                                           , 56529
                                                           , 56617
                                                           , 57057
                                                           , 57321
                                                           , 57849
                                                           , 58377
                                                           , 58729
                                                           , 41964
                                                           , 42052
                                                           , 42140
                                                           , 43284
                                                           , 43812
                                                           , 44076
                                                           , 44780
                                                           , 45572
                                                           , 46188
                                                           , 46628
                                                           , 46716
                                                           , 46804
                                                           , 47068
                                                           , 47156
                                                           , 47684
                                                           , 47948
                                                           , 49884
                                                           , 50588
                                                           , 50676
                                                           , 51116
                                                           , 51820
                                                           , 52172
                                                           , 52436
                                                           , 52524
                                                           , 52876
                                                           , 52964
                                                           , 53140
                                                           , 53492
                                                           , 54548
                                                           , 54724
                                                           , 55164
                                                           , 55340
                                                           , 56660
                                                           , 57364
                                                           , 57628
                                                           , 57716
                                                           , 57892
                                                           , 59036
                                                           , 59124
                                                           , 59212
                                                           , 59300
                                                           , 41966
                                                           , 42142
                                                           , 42230
                                                           , 42494
                                                           , 42670
                                                           , 42846
                                                           , 43022
                                                           , 43110
                                                           , 43286
                                                           , 43638
                                                           , 44518
                                                           , 44782
                                                           , 44870
                                                           , 45398
                                                           , 45574
                                                           , 45662
                                                           , 45838
                                                           , 46190
                                                           , 46278
                                                           , 46630
                                                           , 46806
                                                           , 46894
                                                           , 46982
                                                           , 47070
                                                           , 47158
                                                           , 47598
                                                           , 47686
                                                           , 48918
                                                           , 49798
                                                           , 50062
                                                           , 50238
                                                           , 50766
                                                           , 50854
                                                           , 51030
                                                           , 51734
                                                           , 51822
                                                           , 52174
                                                           , 52262
                                                           , 52438
                                                           , 52526
                                                           , 53142
                                                           , 53494
                                                           , 53582
                                                           , 54462
                                                           , 54902
                                                           , 55518
                                                           , 55782
                                                           , 56574
                                                           , 56662
                                                           , 57102
                                                           , 57366
                                                           , 57718
                                                           , 57894
                                                           , 59038
                                                           , 59302
                                                           , 64116
                                                           , 64144
                                                           , 64460
                                                           , 64544
                                                           , 64639
                                                           , 65015
                                                           , 66559
                                                           , 66640
                                                           , 66695
                                                           , 67343
                                                           , 67402
                                                           , 67858
                                                           , 68074
                                                           , 68248
                                                           , 68274
                                                           , 69206
                                                           , 70435
                                                           , 70746
                                                           , 70936
                                                           , 70979
                                                           , 71636
                                                           , 71718
                                                           , 71883
                                                           , 71991
                                                           , 72059
                                                           , 72527
                                                           , 72599
                                                           , 72644
                                                           , 72867
                                                           , 72955
                                                           , 72994
                                                           , 73323
                                                           , 73473
                                                           , 73617
                                                           , 73639
                                                           , 73752
                                                           , 73833
                                                           , 74181
                                                           , 74721
                                                           , 74964
                                                           , 75693
                                                           , 76206
                                                           , 76525
                                                           , 77002
                                                           , 77156
                                                           , 77383
                                                           , 78938
                                                           , 79192
                                                           , 79291
                                                           , 79382
                                                           , 63507
                                                           , 63695
                                                           , 63740
                                                           , 64030
                                                           , 64117
                                                           , 64210
                                                           , 64461
                                                           , 64640
                                                           , 64775
                                                           , 64792
                                                           , 65016
                                                           , 65486
                                                           , 65693
                                                           , 66696
                                                           , 66840
                                                           , 67103
                                                           , 67344
                                                           , 67434
                                                           , 67587
                                                           , 68075
                                                           , 68154
                                                           , 68249
                                                           , 68275
                                                           , 69122
                                                           , 69207
                                                           , 70296
                                                           , 70747
                                                           , 70980
                                                           , 71172
                                                           , 71637
                                                           , 71719
                                                           , 72060
                                                           , 72528
                                                           , 72600
                                                           , 72868
                                                           , 72995
                                                           , 73324
                                                           , 73437
                                                           , 73618
                                                           , 73640
                                                           , 73753
                                                           , 73834
                                                           , 74079
                                                           , 74182
                                                           , 74641
                                                           , 74722
                                                           , 74965
                                                           , 75289
                                                           , 75375
                                                           , 75550
                                                           , 76056
                                                           , 76354
                                                           , 76526
                                                           , 76759
                                                           , 77542
                                                           , 78168
                                                           , 78939
                                                           , 79193
                                                           , 79292
                                                           , 79391
                                                           , 63696
                                                           , 63779
                                                           , 64211
                                                           , 68276
                                                           , 71173
                                                           , 71720
                                                           , 72061
                                                           , 79194
                                                           , 79392
                                                           , 63509
                                                           , 63697
                                                           , 64212
                                                           , 64547
                                                           , 65695
                                                           , 68077
                                                           , 70914
                                                           , 71994
                                                           , 72530
                                                           , 72870
                                                           , 73262
                                                           , 73439
                                                           , 73836
                                                           , 75291
                                                           , 75556
                                                           , 79195
                                                           , 79393
                                                           , 64464
                                                           , 64643
                                                           , 64795
                                                           , 65019
                                                           , 66563
                                                           , 66644
                                                           , 66699
                                                           , 66843
                                                           , 67347
                                                           , 67437
                                                           , 68078
                                                           , 68252
                                                           , 68278
                                                           , 69125
                                                           , 69210
                                                           , 70439
                                                           , 70915
                                                           , 70940
                                                           , 71175
                                                           , 72063
                                                           , 72648
                                                           , 72998
                                                           , 73440
                                                           , 73477
                                                           , 73621
                                                           , 73643
                                                           , 73756
                                                           , 73837
                                                           , 74082
                                                           , 74185
                                                           , 74968
                                                           , 75557
                                                           , 76210
                                                           , 77006
                                                           , 77430
                                                           , 78942
                                                           , 79295
                                                           , 79394
                                                           , 63744
                                                           , 64034
                                                           , 64121
                                                           , 64465
                                                           , 64796
                                                           , 64951
                                                           , 65697
                                                           , 66700
                                                           , 66844
                                                           , 67107
                                                           , 67438
                                                           , 67591
                                                           , 68158
                                                           , 69211
                                                           , 70300
                                                           , 70916
                                                           , 70941
                                                           , 71641
                                                           , 72064
                                                           , 72999
                                                           , 74186
                                                           , 74645
                                                           , 74969
                                                           , 76060
                                                           , 76358
                                                           , 76530
                                                           , 77471
                                                           , 78172
                                                           , 63512
                                                           , 63700
                                                           , 64035
                                                           , 64122
                                                           , 64215
                                                           , 64550
                                                           , 64797
                                                           , 67888
                                                           , 68080
                                                           , 71724
                                                           , 71889
                                                           , 71997
                                                           , 72065
                                                           , 72533
                                                           , 72605
                                                           , 72873
                                                           , 73265
                                                           , 73442
                                                           , 73758
                                                           , 73839
                                                           , 74727
                                                           , 75294
                                                           , 75380
                                                           , 75559
                                                           , 75699
                                                           , 77432
                                                           , 79198
                                                           , 79396
                                                           , 64467
                                                           , 65492
                                                           , 71643
                                                           , 71725
                                                           , 71868
                                                           , 73624
                                                           , 76360
                                                           , 76532
                                                           , 78945
                                                           , 63702
                                                           , 64468
                                                           , 71726
                                                           , 73002
                                                           , 73625
                                                           , 73647
                                                           , 77164
                                                           , 68257
                                                           , 70755
                                                           , 73648
                                                           , 73761
                                                           , 75562
                                                           , 79201
                                                           , 63727
                                                           , 64597
                                                           , 64907
                                                           , 67788
                                                           , 67949
                                                           , 70046
                                                           , 70958
                                                           , 71610
                                                           , 71837
                                                           , 71931
                                                           , 72843
                                                           , 73271
                                                           , 73654
                                                           , 74036
                                                           , 74280
                                                           , 74581
                                                           , 76489
                                                           , 79139
                                                           , 63465
                                                           , 63640
                                                           , 63670
                                                           , 63728
                                                           , 63794
                                                           , 63897
                                                           , 63978
                                                           , 64060
                                                           , 64157
                                                           , 64330
                                                           , 64337
                                                           , 64500
                                                           , 64503
                                                           , 64598
                                                           , 64741
                                                           , 64986
                                                           , 65134
                                                           , 65215
                                                           , 65288
                                                           , 65439
                                                           , 65542
                                                           , 65682
                                                           , 65951
                                                           , 66105
                                                           , 66189
                                                           , 66277
                                                           , 66342
                                                           , 66475
                                                           , 66617
                                                           , 66852
                                                           , 66914
                                                           , 67015
                                                           , 67059
                                                           , 67140
                                                           , 67317
                                                           , 67419
                                                           , 67464
                                                           , 67721
                                                           , 67789
                                                           , 67895
                                                           , 67950
                                                           , 68035
                                                           , 68193
                                                           , 68304
                                                           , 68359
                                                           , 68436
                                                           , 68517
                                                           , 68598
                                                           , 68680
                                                           , 68760
                                                           , 68855
                                                           , 68894
                                                           , 69023
                                                           , 69091
                                                           , 69165
                                                           , 69246
                                                           , 69570
                                                           , 69894
                                                           , 69994
                                                           , 70159
                                                           , 70218
                                                           , 70316
                                                           , 70352
                                                           , 70386
                                                           , 70542
                                                           , 70706
                                                           , 70758
                                                           , 70866
                                                           , 70959
                                                           , 71054
                                                           , 71140
                                                           , 71211
                                                           , 71352
                                                           , 71433
                                                           , 71533
                                                           , 71611
                                                           , 71687
                                                           , 71797
                                                           , 71932
                                                           , 72018
                                                           , 72162
                                                           , 72243
                                                           , 72486
                                                           , 72574
                                                           , 72745
                                                           , 72914
                                                           , 73015
                                                           , 73080
                                                           , 73159
                                                           , 73305
                                                           , 73384
                                                           , 73655
                                                           , 73737
                                                           , 73792
                                                           , 73883
                                                           , 74037
                                                           , 74118
                                                           , 74197
                                                           , 74281
                                                           , 74343
                                                           , 74437
                                                           , 74490
                                                           , 74582
                                                           , 74698
                                                           , 74761
                                                           , 74923
                                                           , 75006
                                                           , 75085
                                                           , 75185
                                                           , 75328
                                                           , 75436
                                                           , 75490
                                                           , 75609
                                                           , 75733
                                                           , 75826
                                                           , 75902
                                                           , 76069
                                                           , 76166
                                                           , 76263
                                                           , 76320
                                                           , 76398
                                                           , 76490
                                                           , 76565
                                                           , 76978
                                                           , 77018
                                                           , 77284
                                                           , 77365
                                                           , 77620
                                                           , 77682
                                                           , 77763
                                                           , 77844
                                                           , 77967
                                                           , 78021
                                                           , 78099
                                                           , 78236
                                                           , 78330
                                                           , 78411
                                                           , 78573
                                                           , 78742
                                                           , 78816
                                                           , 78978
                                                           , 79031
                                                           , 79140
                                                           , 79268
                                                           , 79427
                                                           , 64600
                                                           , 64910
                                                           , 67319
                                                           , 70868
                                                           , 70961
                                                           , 71435
                                                           , 71613
                                                           , 73017
                                                           , 73274
                                                           , 73657
                                                           , 76322
                                                           , 79142
                                                           , 63549
                                                           , 63643
                                                           , 63731
                                                           , 63981
                                                           , 64333
                                                           , 64340
                                                           , 64506
                                                           , 64601
                                                           , 64744
                                                           , 64989
                                                           , 65137
                                                           , 65442
                                                           , 65523
                                                           , 65685
                                                           , 65873
                                                           , 66108
                                                           , 66511
                                                           , 66738
                                                           , 66855
                                                           , 66917
                                                           , 67062
                                                           , 67224
                                                           , 67422
                                                           , 67467
                                                           , 67898
                                                           , 68038
                                                           , 68196
                                                           , 68439
                                                           , 68763
                                                           , 69094
                                                           , 69168
                                                           , 69654
                                                           , 69897
                                                           , 70355
                                                           , 70545
                                                           , 70962
                                                           , 71057
                                                           , 71274
                                                           , 71355
                                                           , 71614
                                                           , 71690
                                                           , 72489
                                                           , 72577
                                                           , 72661
                                                           , 72917
                                                           , 73162
                                                           , 73387
                                                           , 73557
                                                           , 73658
                                                           , 73740
                                                           , 74040
                                                           , 74284
                                                           , 74440
                                                           , 74493
                                                           , 74701
                                                           , 76169
                                                           , 76266
                                                           , 76323
                                                           , 76493
                                                           , 76981
                                                           , 77534
                                                           , 77623
                                                           , 77847
                                                           , 77970
                                                           , 78102
                                                           , 78745
                                                           , 78901
                                                           , 78981
                                                           , 79271
                                                           , 63633
                                                           , 63808
                                                           , 64048
                                                           , 64228
                                                           , 64487
                                                           , 64658
                                                           , 65337
                                                           , 65504
                                                           , 65809
                                                           , 65930
                                                           , 66163
                                                           , 66256
                                                           , 66993
                                                           , 67452
                                                           , 67768
                                                           , 67865
                                                           , 68010
                                                           , 68093
                                                           , 68226
                                                           , 68343
                                                           , 69966
                                                           , 70459
                                                           , 70769
                                                           , 71034
                                                           , 71574
                                                           , 72682
                                                           , 73334
                                                           , 73589
                                                           , 73852
                                                           , 74365
                                                           , 74578
                                                           , 75874
                                                           , 76372
                                                           , 77344
                                                           , 79231
                                                           , 79486
                                                           , 63526
                                                           , 63634
                                                           , 63809
                                                           , 63958
                                                           , 64229
                                                           , 64488
                                                           , 64659
                                                           , 65043
                                                           , 65753
                                                           , 65810
                                                           , 65931
                                                           , 66164
                                                           , 66257
                                                           , 66878
                                                           , 66994
                                                           , 67453
                                                           , 67769
                                                           , 67866
                                                           , 67930
                                                           , 68094
                                                           , 68227
                                                           , 68344
                                                           , 68835
                                                           , 69064
                                                           , 69967
                                                           , 70068
                                                           , 70366
                                                           , 70460
                                                           , 70770
                                                           , 71035
                                                           , 71191
                                                           , 71656
                                                           , 73335
                                                           , 73512
                                                           , 73590
                                                           , 73772
                                                           , 73853
                                                           , 74098
                                                           , 74366
                                                           , 74579
                                                           , 75308
                                                           , 75426
                                                           , 75573
                                                           , 75875
                                                           , 76124
                                                           , 76373
                                                           , 76545
                                                           , 76944
                                                           , 77081
                                                           , 77345
                                                           , 77585
                                                           , 77662
                                                           , 78001
                                                           , 78138
                                                           , 79232
                                                           , 79410
                                                           , 63635
                                                           , 64249
                                                           , 64812
                                                           , 66895
                                                           , 68345
                                                           , 70771
                                                           , 71192
                                                           , 74099
                                                           , 76374
                                                           , 79233
                                                           , 79411
                                                           , 63528
                                                           , 63636
                                                           , 63811
                                                           , 64250
                                                           , 64813
                                                           , 65755
                                                           , 65933
                                                           , 66166
                                                           , 66259
                                                           , 66966
                                                           , 67771
                                                           , 67868
                                                           , 68096
                                                           , 68346
                                                           , 70368
                                                           , 70772
                                                           , 71037
                                                           , 71193
                                                           , 71577
                                                           , 71740
                                                           , 73337
                                                           , 73514
                                                           , 73592
                                                           , 73774
                                                           , 73855
                                                           , 74100
                                                           , 74368
                                                           , 74609
                                                           , 75310
                                                           , 75575
                                                           , 75877
                                                           , 77083
                                                           , 79234
                                                           , 79412
                                                           , 63812
                                                           , 63961
                                                           , 64491
                                                           , 64662
                                                           , 64814
                                                           , 65508
                                                           , 65813
                                                           , 67869
                                                           , 68347
                                                           , 71038
                                                           , 71194
                                                           , 73593
                                                           , 73856
                                                           , 74101
                                                           , 74369
                                                           , 76376
                                                           , 79235
                                                           , 79490
                                                           , 63813
                                                           , 64492
                                                           , 64815
                                                           , 65047
                                                           , 67457
                                                           , 67934
                                                           , 68284
                                                           , 68839
                                                           , 69068
                                                           , 69971
                                                           , 70072
                                                           , 70464
                                                           , 71039
                                                           , 71660
                                                           , 75879
                                                           , 76128
                                                           , 76377
                                                           , 76549
                                                           , 76948
                                                           , 77589
                                                           , 77666
                                                           , 78005
                                                           , 78142
                                                           , 63531
                                                           , 63617
                                                           , 63814
                                                           , 64253
                                                           , 64816
                                                           , 65343
                                                           , 65510
                                                           , 65936
                                                           , 66169
                                                           , 66969
                                                           , 67774
                                                           , 67871
                                                           , 68099
                                                           , 68285
                                                           , 68840
                                                           , 70371
                                                           , 70775
                                                           , 71743
                                                           , 73340
                                                           , 73595
                                                           , 73777
                                                           , 73858
                                                           , 74103
                                                           , 74371
                                                           , 74612
                                                           , 75578
                                                           , 75880
                                                           , 77086
                                                           , 77350
                                                           , 79237
                                                           , 79383
                                                           , 65511
                                                           , 66900
                                                           , 63816
                                                           , 64015
                                                           , 65345
                                                           , 67460
                                                           , 68018
                                                           , 68101
                                                           , 68234
                                                           , 69071
                                                           , 69974
                                                           , 70467
                                                           , 71042
                                                           , 71582
                                                           , 71745
                                                           , 72654
                                                           , 73597
                                                           , 73860
                                                           , 79494
                                                           , 64256
                                                           , 65818
                                                           , 66972
                                                           , 68019
                                                           , 75478
                                                           , 76132
                                                           )

/*********************************************************************************************************/

-- Step 07
-- List all answers (numeric answers) that should not be linked any more to any Nation
-- (numeric answers passed value to the text answers when they existed:
--  but some numeric answers have missing text)
----> Notice this will keep all in the answers table (LINKED AND NOT)
   -- identified through the general xlsx table 

                      SELECT  
                               --distinct
                              KN.[Nation_answer_pk]
                            , KN.[Answer_fk]
                            , KN.[Nation_fk]
                            , KN.[display]
                            ,  A.[Answer_pk]
                            ,  A.[Answer_value]
                            ,  A.[Answer_wording]
                            ,  A.[answer_wording_std]
                            ,  A.[Question_fk]
                            ,  Q.[Question_abbreviation_std]
                            ,  Q.[Question_Year]
                        FROM
                             [forum].[dbo].[Pew_Answer]            A
                      LEFT OUTER JOIN
                             [forum].[dbo].[Pew_Nation_Answer]     KN
                        ON     A.[Answer_pk]
                            = KN.[Answer_fk]
                      LEFT OUTER JOIN
                             [forum].[dbo].[Pew_Question]          Q
                        ON     A.[Question_fk]
                            =  Q.[Question_pk]
                      WHERE
                        --AND Q.[Question_abbreviation_std]     LIKE '%text'
                        --AND Answer_wording                    =    ''
                        --AND answer_wording_std                IS   NULL
                               A.Answer_pk   IN (
                                                    3475
                                                  , 3517
                                                  , 3877
                                                  , 3922
                                                  , 10354
                                                  , 10406
                                                  , 10469
                                                  , 10480
                                                  , 10499
                                                  , 10539
                                                  , 10569
                                                  , 10599
                                                  , 10610
                                                  , 10619
                                                  , 10629
                                                  , 10649
                                                  , 10798
                                                  , 10812
                                                  , 13816
                                                  , 13854
                                                  , 13912
                                                  , 13925
                                                  , 13961
                                                  , 13981
                                                  , 14006
                                                  , 14039
                                                  , 14043
                                                  , 14062
                                                          )

/*********************************************************************************************************/

-- Step 08
-- drop answers (numeric answers) that should not be linked any more to any Nation
-- and are actually not linked any more to any value
-- (these exclude answers whith missing text)
----> Notice these will be only some of those identified through the general xlsx table 

DELETE
                 [forum].[dbo].[Pew_Answer]                                                   -- DB name
FROM
--SELECT * FROM
                 [forum].[dbo].[Pew_Answer]                                                   -- DB name
LEFT OUTER JOIN
                 (
                      SELECT  
                              KN.[Nation_answer_pk]
                            , KN.[Answer_fk]
                            , KN.[Nation_fk]
                            , KN.[display]
                            ,  A.[Answer_pk]
                            ,  A.[Answer_value]
                            ,  A.[Answer_wording]
                            ,  A.[answer_wording_std]
                            ,  A.[Question_fk]
                            ,  Q.[Question_abbreviation_std]
                            ,  Q.[Question_Year]
                        FROM
                             [forum].[dbo].[Pew_Answer]            A
                      LEFT OUTER JOIN
                             [forum].[dbo].[Pew_Nation_Answer]     KN
                        ON     A.[Answer_pk]
                            = KN.[Answer_fk]
                      LEFT OUTER JOIN
                             [forum].[dbo].[Pew_Question]          Q
                        ON     A.[Question_fk]
                            =  Q.[Question_pk]
                      WHERE
                      KN.[Nation_answer_pk]  IS NULL
                      AND
                               A.Answer_pk   IN (
                                                    10406
                                                  , 10469
                                                  , 10480
                                                  , 10539
                                                  , 10569
                                                  , 10599
                                                  , 10619
                                                  , 10629
                                                  , 13912
                                                  , 13925
                                                  , 13961
                                                  , 13981
                                                  , 14006
                                                  , 14039
                                                  , 14043
                                                          )
                                                                  )                   A
ON
                 [forum].[dbo].[Pew_Answer].[Answer_pk]                                       -- DB name
          =                               A.[Answer_pk]
WHERE                                     A.[Answer_pk]   IS NOT NULL

/*********************************************************************************************************/

-- Step 09
-- These are 33 answers by country whith missing text:
----> Notice these will be only some of those identified through the general xlsx table 
----> Text should be added later and both answer & nation-answer keys be reassigned.

                      SELECT  
                               --distinct
                              KN.[Nation_answer_pk]
                            , KN.[Answer_fk]
                            , KN.[Nation_fk]
                            , KN.[display]
                            ,  A.[Answer_pk]
                            ,  A.[Answer_value]
                            ,  A.[Answer_wording]
                            ,  A.[answer_wording_std]
                            ,  A.[Question_fk]
                            ,  Q.[Question_abbreviation_std]
                            ,  Q.[Question_Year]
                        FROM
                             [forum].[dbo].[Pew_Answer]            A
                      LEFT OUTER JOIN
                             [forum].[dbo].[Pew_Nation_Answer]     KN
                        ON     A.[Answer_pk]
                            = KN.[Answer_fk]
                      LEFT OUTER JOIN
                             [forum].[dbo].[Pew_Question]          Q
                        ON     A.[Question_fk]
                            =  Q.[Question_pk]
                      WHERE
                        --AND Q.[Question_abbreviation_std]     LIKE '%text'
                        --AND Answer_wording                    =    ''
                        --AND answer_wording_std                IS   NULL
                               A.Answer_pk   IN (
                                                    3475
                                                  , 3517
                                                  , 3877
                                                  , 3922
                                                  , 10354
                                                  , 10499
                                                  , 10610
                                                  , 10649
                                                  , 10798
                                                  , 10812
                                                  , 13816
                                                  , 13854
                                                  , 14062
                                                          )

/*********************************************************************************************************/

