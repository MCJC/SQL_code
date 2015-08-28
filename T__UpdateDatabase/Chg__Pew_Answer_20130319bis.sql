/****************************************************************************************************/
select *
from
(
SELECT
        level                      = 'Ctry'
      , link_fk                    = KN.[Nation_answer_pk]
      , Nation_fk                  = N.[Nation_pk]
      , Locality_fk                = NULL
      , Religion_fk                = NULL
      , Ctry_EditorialName         = N.[Ctry_EditorialName]
      , Locality                   = 'not detailed'
      , Religion                   = 'not detailed'
      , Question_Year              = Q.[Question_Year]
      , Question_abbreviation_std  = Q.[Question_abbreviation_std]
      , Question_wording           = Q.[Question_wording]
      , Answer_value               = A.[Answer_value]
      , Answer_wording             = A.[Answer_wording]
      , Question_fk                = Q.[Question_pk]
      , Answer_fk                  = A.[Answer_pk]
      , Notes                      = Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]

UNION

SELECT
        level                      = 'Prov'
      , link_fk                    = KL.[Locality_answer_pk]
      , Nation_fk                  = N.[Nation_pk]
      , Locality_fk                = L.[Locality_pk]
      , Religion_fk                = NULL
      , Ctry_EditorialName         = N.[Ctry_EditorialName]
      , Locality                   = L.[Locality]
      , Religion                   = 'not detailed'
      , Question_Year              = Q.[Question_Year]
      , Question_abbreviation_std  = Q.[Question_abbreviation_std]
      , Question_wording           = Q.[Question_wording]
      , Answer_value               = A.[Answer_value]
      , Answer_wording             = A.[Answer_wording]
      , Question_fk                = Q.[Question_pk]
      , Answer_fk                  = A.[Answer_pk]
      , Notes                       = Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Locality]          L
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Locality_Answer]   KL
WHERE Q.[Question_pk] = A.[Question_fk]
  AND A.[Answer_pk]   = KL.[Answer_fk]
  AND L.[Locality_pk] = KL.[Locality_fk]
  AND N.[Nation_pk]   =
                           /* In order to keep consistent to previuos years 
                              Data by Province currently belonging to South Sudan
                              should considered data for South Sudan before 2010: */
                     CASE 
                            WHEN L.[Nation_fk]     = 237 
                             AND Q.[Question_Year] < 2010 
                            THEN                           197
                           /* In order to avoid changing the final set,
                              Data previously used for Northern Cyprus
                              should be excluded:                       */
                            ELSE                           L.[Nation_fk]
                     END 
                           /* Although we have REAL data by province for North Korea,
                              we will not use them in this analysis                   */
  AND N.Ctry_EditorialName  <>  'North Korea'

UNION

SELECT
        level                      = 'RGrp'
      , Answer_fk                  = A.[Answer_pk]
      , link_fk                    = KR.[Nation_religion_answer_pk]
      , Nation_fk                  = N.[Nation_pk]
      , Locality_fk                = NULL
      , Religion_fk                = G.[Religion_group_pk]
      , Ctry_EditorialName         = N.[Ctry_EditorialName]
      , Locality                   = 'not detailed'
      , Religion                   = G.[Pew_religion]
      , Question_Year              = Q.[Question_Year]
      , Question_abbreviation_std  = Q.[Question_abbreviation_std]
      , Question_wording           = Q.[Question_wording]
      , Answer_wording             = A.[Answer_wording_std]
      , Question_fk                = Q.[Question_pk]
      , Notes                      = Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]                   A
      ,[forum].[dbo].[Pew_Question]                 Q
      ,[forum].[dbo].[Pew_Nation]                   N
      ,[forum].[dbo].[Pew_Religion_Group]           G
      ,[forum].[dbo].[Pew_Nation_Religion_Answer]   KR
WHERE  Q.[Question_pk]       =  A.[Question_fk]
  AND  A.[Answer_pk]         = KR.[Answer_fk]
  AND KR.[Religion_group_fk] =  G.[Religion_group_pk]
  AND  N.[Nation_pk]         = KR.[Nation_fk]
                           /* Pull only data on Restrictions */
  AND (   Q.[Question_abbreviation_std] like 'SHI_%'
       OR Q.[Question_abbreviation_std] like 'GRI_%'  )
)
AS JOINED
/****************************************************************************************************/





/*********************************************************************************************************/
SELECT *
  INTO  [_bk_forum].[dbo].[Pew_Answer_2013_03_19_province]
  FROM      [forum].[dbo].[Pew_Answer]
/*********************************************************************************************************/
SELECT *
  INTO [juancarlos].[dbo].[Pew_Answer]
  FROM      [forum].[dbo].[Pew_Answer]
/*********************************************************************************************************/

-- Step 01
-- drop text answers when their value has been previouly dropped
DELETE FROM 
            [juancarlos].[dbo].[Pew_answer]                                                   -- DB name
WHERE
            [juancarlos].[dbo].[Pew_answer].[Answer_pk] IN                                    -- DB name
                                                           (9522, 9150, 9537, 9459, 9359)
-- Step 02
-- attach text answers to corresponding values (province level)
UPDATE
           [juancarlos].[dbo].[Pew_Answer]                                                    -- DB name
SET
           [juancarlos].[dbo].[Pew_Answer].[Answer_Wording]                                   -- DB name
       =                             toolT.[Answer_Wording]
FROM
           [juancarlos].[dbo].[Pew_Answer]   AS mydbt                                         -- DB name
 JOIN
       (
SELECT 
         VV.Answer_fk
       , VV.Answer_value
--       , DD.Answer_fk
       , DD.Answer_wording
FROM
(
SELECT
        level                      = 'Prov'
      , Answer_fk                  = A.[Answer_pk]
      , Answer_value               = A.[Answer_value]
      , Answer_wording             = A.[Answer_wording]
      , answer_wording_std         = A.[answer_wording_std]
      , Question_fk                = Q.[Question_pk]
      , Locality_fk                = KL.[Locality_fk]
      , Question_abbreviation_std  = Q.[Question_abbreviation_std]
  FROM
  [juancarlos].[dbo].[Pew_Answer]            A                                                -- DB name
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Locality_Answer]   KL
WHERE Q.[Question_pk]               =         A.[Question_fk]
  AND A.[Answer_pk]                 =        KL.[Answer_fk]
  AND Q.[Question_Year]             =        2011
  --AND Q.[Question_abbreviation_std]     LIKE '%text'
  AND Q.[Question_abbreviation_std] NOT LIKE '%text'
  --AND A.[Answer_value]              IS NULL
  AND A.[Answer_wording]            IS NULL
) VV
JOIN
(
SELECT
        level                      = 'Prov'
      , Answer_fk                  = A.[Answer_pk]
      , Answer_value               = A.[Answer_value]
      , Answer_wording             = A.[Answer_wording]
      , answer_wording_std         = A.[answer_wording_std]
      , Question_fk                = Q.[Question_pk]
      , Locality_fk                = KL.[Locality_fk]
      , Question_abbreviation_std  = Q.[Question_abbreviation_std]
  FROM
  [juancarlos].[dbo].[Pew_Answer]            A                                                -- DB name
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Locality_Answer]   KL
WHERE Q.[Question_pk]               =         A.[Question_fk]
  AND A.[Answer_pk]                 =        KL.[Answer_fk]
  AND Q.[Question_Year]             =        2011
  AND Q.[Question_abbreviation_std]     LIKE '%text'
  --AND Q.[Question_abbreviation_std] NOT LIKE '%text'
  AND A.[Answer_value]              IS NULL
  --AND A.[Answer_wording]            IS NULL
) DD
ON
        VV.Locality_fk                = DD.Locality_fk
AND
        VV.Question_abbreviation_std  = SUBSTRING(DD.Question_abbreviation_std,1, 8)
       ) AS toolT
ON
           mydbt.Answer_pk
       =   toolT.Answer_fk

-- Step 03
-- drop text answers whose text has already been attached to the value
DELETE FROM 
            [juancarlos].[dbo].[Pew_answer]                                                   -- DB name
WHERE
            [juancarlos].[dbo].[Pew_answer].[Answer_pk] IN                                    -- DB name
                                                           (
                                                               8854
                                                             , 8855
                                                             , 8856
                                                             , 8857
                                                             , 8858
                                                             , 8859
                                                             , 8860
                                                             , 8861
                                                             , 8862
                                                             , 8863
                                                             , 8864
                                                             , 8865
                                                             , 8866
                                                             , 8867
                                                             , 8868
                                                             , 8869
                                                             , 8870
                                                             , 8871
                                                             , 8872
                                                             , 8873
                                                             , 8874
                                                             , 8875
                                                             , 8876
                                                             , 8877
                                                             , 8878
                                                             , 8879
                                                             , 8880
                                                             , 8881
                                                             , 8882
                                                             , 8883
                                                             , 8884
                                                             , 8885
                                                             , 8886
                                                             , 8887
                                                             , 8888
                                                             , 8889
                                                             , 8890
                                                             , 8891
                                                             , 8892
                                                             , 8893
                                                             , 8894
                                                             , 8895
                                                             , 8896
                                                             , 8897
                                                             , 8898
                                                             , 8899
                                                             , 8900
                                                             , 8901
                                                             , 8902
                                                             , 8903
                                                             , 8904
                                                             , 8905
                                                             , 8906
                                                             , 8907
                                                             , 8908
                                                             , 8909
                                                             , 8910
                                                             , 8911
                                                             , 8912
                                                             , 8913
                                                             , 8914
                                                             , 8915
                                                             , 8916
                                                             , 8917
                                                             , 8918
                                                             , 8919
                                                             , 8920
                                                             , 8921
                                                             , 8922
                                                             , 8923
                                                             , 8924
                                                             , 8925
                                                             , 8926
                                                             , 8927
                                                             , 8928
                                                             , 8929
                                                             , 8930
                                                             , 8931
                                                             , 8932
                                                             , 8933
                                                             , 9115
                                                             , 9116
                                                             , 9117
                                                             , 9118
                                                             , 9119
                                                             , 9120
                                                             , 9121
                                                             , 9122
                                                             , 9123
                                                             , 9124
                                                             , 9125
                                                             , 9126
                                                             , 9127
                                                             , 9128
                                                             , 9129
                                                             , 9130
                                                             , 9131
                                                             , 9132
                                                             , 9133
                                                             , 9134
                                                             , 9135
                                                             , 9136
                                                             , 9137
                                                             , 9138
                                                             , 9139
                                                             , 9140
                                                             , 9141
                                                             , 9142
                                                             , 9143
                                                             , 9144
                                                             , 9145
                                                             , 9146
                                                             , 9147
                                                             , 9148
                                                             , 9149
                                                             , 9151
                                                             , 9152
                                                             , 9153
                                                             , 9154
                                                             , 9155
                                                             , 9156
                                                             , 9157
                                                             , 9158
                                                             , 9159
                                                             , 9160
                                                             , 9161
                                                             , 9162
                                                             , 9163
                                                             , 9164
                                                             , 9165
                                                             , 9166
                                                             , 9167
                                                             , 9168
                                                             , 9169
                                                             , 9170
                                                             , 9171
                                                             , 9172
                                                             , 9173
                                                             , 9174
                                                             , 9175
                                                             , 9176
                                                             , 9177
                                                             , 9178
                                                             , 9179
                                                             , 9180
                                                             , 9181
                                                             , 9182
                                                             , 9183
                                                             , 9184
                                                             , 9185
                                                             , 9186
                                                             , 9187
                                                             , 9188
                                                             , 9189
                                                             , 9190
                                                             , 9191
                                                             , 9192
                                                             , 9193
                                                             , 9194
                                                             , 9195
                                                             , 9196
                                                             , 9197
                                                             , 9198
                                                             , 9199
                                                             , 9200
                                                             , 9201
                                                             , 9202
                                                             , 9203
                                                             , 9204
                                                             , 9205
                                                             , 9206
                                                             , 9207
                                                             , 9208
                                                             , 9209
                                                             , 9210
                                                             , 9211
                                                             , 9212
                                                             , 9213
                                                             , 9214
                                                             , 9215
                                                             , 9216
                                                             , 9217
                                                             , 9218
                                                             , 9219
                                                             , 9220
                                                             , 9221
                                                             , 9222
                                                             , 9223
                                                             , 9224
                                                             , 9225
                                                             , 9226
                                                             , 9227
                                                             , 9228
                                                             , 9229
                                                             , 9230
                                                             , 9231
                                                             , 9232
                                                             , 9233
                                                             , 9234
                                                             , 9235
                                                             , 9236
                                                             , 9237
                                                             , 9238
                                                             , 9239
                                                             , 9240
                                                             , 9241
                                                             , 9242
                                                             , 9243
                                                             , 9244
                                                             , 9245
                                                             , 9246
                                                             , 9247
                                                             , 9248
                                                             , 9249
                                                             , 9250
                                                             , 9251
                                                             , 9252
                                                             , 9253
                                                             , 9254
                                                             , 9255
                                                             , 9256
                                                             , 9257
                                                             , 9258
                                                             , 9259
                                                             , 9260
                                                             , 9261
                                                             , 9262
                                                             , 9263
                                                             , 9264
                                                             , 9265
                                                             , 9266
                                                             , 9267
                                                             , 9268
                                                             , 9269
                                                             , 9270
                                                             , 9271
                                                             , 9272
                                                             , 9273
                                                             , 9274
                                                             , 9275
                                                             , 9276
                                                             , 9277
                                                             , 9278
                                                             , 9279
                                                             , 9280
                                                             , 9281
                                                             , 9282
                                                             , 9283
                                                             , 9284
                                                             , 9285
                                                             , 9286
                                                             , 9287
                                                             , 9288
                                                             , 9289
                                                             , 9290
                                                             , 9291
                                                             , 9292
                                                             , 9293
                                                             , 9294
                                                             , 9295
                                                             , 9328
                                                             , 9329
                                                             , 9330
                                                             , 9331
                                                             , 9332
                                                             , 9333
                                                             , 9334
                                                             , 9335
                                                             , 9336
                                                             , 9337
                                                             , 9338
                                                             , 9339
                                                             , 9340
                                                             , 9341
                                                             , 9342
                                                             , 9343
                                                             , 9344
                                                             , 9345
                                                             , 9346
                                                             , 9347
                                                             , 9348
                                                             , 9349
                                                             , 9350
                                                             , 9351
                                                             , 9352
                                                             , 9353
                                                             , 9354
                                                             , 9355
                                                             , 9356
                                                             , 9357
                                                             , 9358
                                                             , 9415
                                                             , 9416
                                                             , 9417
                                                             , 9418
                                                             , 9419
                                                             , 9420
                                                             , 9421
                                                             , 9422
                                                             , 9423
                                                             , 9424
                                                             , 9425
                                                             , 9426
                                                             , 9427
                                                             , 9428
                                                             , 9429
                                                             , 9430
                                                             , 9431
                                                             , 9432
                                                             , 9433
                                                             , 9434
                                                             , 9435
                                                             , 9436
                                                             , 9437
                                                             , 9438
                                                             , 9439
                                                             , 9440
                                                             , 9441
                                                             , 9442
                                                             , 9443
                                                             , 9444
                                                             , 9445
                                                             , 9446
                                                             , 9447
                                                             , 9448
                                                             , 9449
                                                             , 9450
                                                             , 9451
                                                             , 9452
                                                             , 9453
                                                             , 9454
                                                             , 9455
                                                             , 9456
                                                             , 9457
                                                             , 9458
                                                             , 9460
                                                             , 9461
                                                             , 9462
                                                             , 9463
                                                             , 9464
                                                             , 9465
                                                             , 9466
                                                             , 9467
                                                             , 9468
                                                             , 9469
                                                             , 9515
                                                             , 9516
                                                             , 9517
                                                             , 9518
                                                             , 9519
                                                             , 9520
                                                             , 9521
                                                             , 9523
                                                             , 9524
                                                             , 9525
                                                             , 9526
                                                             , 9527
                                                             , 9528
                                                             , 9529
                                                             , 9530
                                                             , 9531
                                                             , 9532
                                                             , 9533
                                                             , 9534
                                                             , 9535
                                                             , 9536
                                                             , 9538
                                                             , 9539
                                                             , 9540
                                                             , 9541
                                                             , 9542
                                                             , 9543
                                                             , 9544
                                                             , 9545
                                                             , 9546
                                                             , 9547
                                                             , 9548
                                                             , 9549
                                                             , 9550
                                                             , 9551
                                                             , 9552
                                                             , 9553
                                                             , 9554
                                                             , 9555
                                                             , 9556
                                                             , 9557
                                                             , 9558
                                                             , 9559
                                                             , 11175
                                                             , 11176
                                                             , 11177
                                                             , 11178
                                                             , 11179
                                                             , 11180
                                                             , 11181
                                                             , 11182
                                                             , 11183
                                                             , 11184
                                                             , 11185
                                                             , 11186
                                                             , 11187
                                                             , 11188
                                                             , 11189
                                                             , 11190
                                                             , 11191
                                                             , 11192
                                                             , 11193
                                                             , 11194
                                                             , 11195
                                                             , 11196
                                                             , 11197
                                                             , 11198
                                                             , 11199
                                                             , 11200
                                                             , 11201
                                                             , 11202
                                                             , 11203
                                                             , 11204
                                                             , 11205
                                                             , 11206
                                                             , 11207
                                                             , 11208
                                                             , 11209
                                                             , 11210
                                                             , 11211
                                                             , 11212
                                                             , 11213
                                                             , 11214
                                                             , 11215
                                                             , 11216
                                                             , 11217
                                                             , 11218
                                                             , 11219
                                                             , 11220
                                                             , 11221
                                                             , 11222
                                                             , 11223
                                                             , 11224
                                                             , 11225
                                                             , 11226
                                                             , 11227
                                                             , 11228
                                                             , 11229
                                                             , 11230
                                                             , 11231
                                                             , 11232
                                                             , 11233
                                                             , 11234
                                                             , 11235
                                                             , 11236
                                                             , 11237
                                                             , 11238
                                                             , 11239
                                                             , 11240
                                                             , 11241
                                                             , 11242
                                                             , 11243
                                                             , 11244
                                                             , 11245
                                                             , 11246
                                                             , 11247
                                                             , 11248
                                                             , 11249
                                                             , 11250
                                                             , 11251
                                                             , 11252
                                                             , 11253
                                                             , 11254
                                                             , 11255
                                                             , 11256
                                                             , 11257
                                                             , 11258
                                                             , 11259
                                                             , 11260
                                                             , 11261
                                                             , 11262
                                                             , 11263
                                                             , 11264
                                                             , 11265
                                                             , 11266
                                                             , 11267
                                                             , 11268
                                                             , 11269
                                                             , 11270
                                                             , 11271
                                                             , 11272
                                                             , 11273
                                                             , 11274
                                                             , 11275
                                                             , 11276
                                                             , 11277
                                                             , 11278
                                                             , 11279
                                                             , 11280
                                                             , 11281
                                                             , 11282
                                                             , 11283
                                                             , 11284
                                                             , 11285
                                                             , 11286
                                                             , 11287
                                                             , 11288
                                                             , 11289
                                                             , 11290
                                                             , 11291
                                                             , 11292
                                                             , 11293
                                                             , 11294
                                                             , 11295
                                                             , 11296
                                                             , 11297
                                                             , 11298
                                                             , 11299
                                                             , 11300
                                                             , 11301
                                                             , 11302
                                                             , 11303
                                                             , 11304
                                                             , 11305
                                                             , 11306
                                                             , 11307
                                                             , 11308
                                                             , 11309
                                                             , 11310
                                                             , 11311
                                                             , 11312
                                                             , 11313
                                                             , 11314
                                                             , 11330
                                                             , 11331
                                                             , 11332
                                                             , 11333
                                                             , 11334
                                                             , 11335
                                                             , 11336
                                                             , 11337
                                                             , 11338
                                                             , 11339
                                                             , 11340
                                                             , 11341
                                                             , 11342
                                                             , 11343
                                                             , 11344
                                                             , 11361
                                                             , 11362
                                                             , 11363
                                                             , 11364
                                                             , 11365
                                                             , 11366
                                                             , 11367
                                                             , 11368
                                                             , 11369
                                                             , 11370
                                                             , 11371
                                                             , 11372
                                                             , 11373
                                                             , 11374
                                                             , 11375
                                                             , 11376
                                                             , 11495
                                                             , 11496
                                                             , 11497
                                                             , 11498
                                                             , 11499
                                                             , 11500
                                                             , 11501
                                                             , 11502
                                                             , 11503
                                                             , 11504
                                                             , 11505
                                                             , 11506
                                                             , 11507
                                                             , 11508
                                                             , 11509
                                                             , 11510
                                                             , 11511
                                                             , 11512
                                                             , 11513
                                                             , 11514
                                                             , 11515
                                                             , 11516
                                                             , 11517
                                                             , 11518
                                                             , 11519
                                                             , 11520
                                                             , 11521
                                                             , 11522
                                                             , 11523
                                                             , 11524
                                                             , 11525
                                                             , 11526
                                                             , 11527
                                                             , 11528
                                                             , 11529
                                                             , 11530
                                                             , 11531
                                                             , 11532
                                                             , 11533
                                                             , 11534
                                                             , 11535
                                                             , 11536
                                                             , 11537
                                                             , 11538
                                                             , 11539
                                                             , 11540
                                                             , 11541
                                                             , 11542
                                                             , 11543
                                                             , 11544
                                                             , 11545
                                                             , 11546
                                                             , 11547
                                                             , 11548
                                                             , 11549
                                                             , 11550
                                                             , 11551
                                                             , 11552
                                                             , 11553
                                                             , 11554
                                                             , 11555
                                                             , 11556
                                                             , 11557
                                                             , 11558
                                                             , 11559
                                                             , 11560
                                                             , 11561
                                                             , 11562
                                                             , 11563
                                                             , 11564
                                                             , 11565
                                                             , 11566
                                                             , 11567
                                                             , 11568
                                                             , 11569
                                                             , 11570
                                                             , 11571
                                                             , 11572
                                                             , 11573
                                                             , 11574
                                                             , 11575
                                                             , 11576
                                                             , 11577
                                                             , 11578
                                                             , 11579
                                                             , 11580
                                                             , 11581
                                                             , 11582
                                                             , 11583
                                                             , 11584
                                                             , 11585
                                                             , 11586
                                                             , 11587
                                                             , 11588
                                                             , 11589
                                                             , 11590
                                                             , 11591
                                                             , 11592
                                                             , 11593
                                                             , 11594
                                                             , 11595
                                                             , 11596
                                                             , 11597
                                                             , 11598
                                                             , 11599
                                                             , 11600
                                                             , 11601
                                                             , 11602
                                                             , 11603
                                                             , 11604
                                                             , 11605
                                                             , 11606
                                                             , 11607
                                                             , 11608
                                                             , 11609
                                                             , 11610
                                                             , 11611
                                                             , 11612
                                                             , 11683
                                                             , 11684
                                                             , 11685
                                                             , 11686
                                                             , 11687
                                                             , 11688
                                                             , 11689
                                                             , 11690
                                                             , 11691
                                                             , 11692
                                                             , 11693
                                                             , 11694
                                                             , 11695
                                                             , 11696
                                                             , 11697
                                                             , 11698
                                                             , 11699
                                                             , 11700
                                                             , 11701
                                                             , 11702
                                                             , 11703
                                                             , 11704
                                                             , 11705
                                                             , 11706
                                                             , 11707
                                                             , 11708
                                                             , 11709
                                                             , 11710
                                                             , 11711
                                                             , 11712
                                                             , 11713
                                                             , 11714
                                                             , 11715
                                                             , 11716
                                                             , 11717
                                                             , 11718
                                                             , 11719
                                                             , 11720
                                                             , 11721
                                                             , 11722
                                                             , 11723
                                                             , 11724
                                                             , 11725
                                                             , 11726
                                                             , 11727
                                                             , 11728
                                                             , 11729
                                                             , 11730
                                                             , 11731
                                                             , 11732
                                                             , 11733
                                                             , 11734
                                                             , 11735
                                                             , 11736
                                                             , 11737
                                                             , 11738
                                                             , 11739
                                                             , 11740
                                                             , 11741
                                                             , 11742
                                                             , 11743
                                                             , 11744
                                                             , 11745
                                                             , 11746
                                                             , 11747
                                                             , 11748
                                                             , 11749
                                                             , 11750
                                                             , 11751
                                                             , 11752
                                                             , 12002
                                                             , 12003
                                                             , 12004
                                                             , 12005
                                                             , 12006
                                                             , 12007
                                                             , 12008
                                                             , 12009
                                                             , 12010
                                                             , 12011
                                                             , 12012
                                                             , 12013
                                                             , 12014
                                                             , 12015
                                                             , 12017
                                                             , 12018
                                                             , 12019
                                                             , 12020
                                                             , 12021
                                                             , 12022
                                                             , 12023
                                                             , 12024
                                                             , 12025
                                                             , 12026
                                                             , 12027
                                                             , 12028
                                                             , 12029
                                                             , 12030
                                                             , 12031
                                                             , 12032
                                                             , 12033
                                                             , 12034
                                                             , 12035
                                                             , 12036
                                                             , 12037
                                                             , 12038
                                                             , 12039
                                                             , 12040
                                                             , 12041
                                                             , 12042
                                                             , 12043
                                                             , 12044
                                                             , 12045
                                                             , 12046
                                                             , 12047
                                                             , 12048
                                                             , 12049
                                                             , 12050
                                                             , 12051
                                                             , 12052
                                                             , 12053
                                                             , 12054
                                                             , 12055
                                                             , 12056
                                                             , 12057
                                                             , 12058
                                                             , 12059
                                                             , 12060
                                                             , 12061
                                                             , 12062
                                                             , 12063
                                                             , 12064
                                                             , 12065
                                                             , 12066
                                                             , 12067
                                                             , 12068
                                                             , 12069
                                                             , 12070
                                                             , 12071
                                                             , 12072
                                                             , 12073
                                                             , 12074
                                                             , 12075
                                                             , 12076
                                                             , 12077
                                                             , 12078
                                                             , 12079
                                                             , 12080
                                                             , 12081
                                                             , 12082
                                                             , 12083
                                                             , 12084
                                                             , 12085
                                                             , 12086
                                                             , 12087
                                                             , 12088
                                                             , 12089
                                                             , 12090
                                                             , 12091
                                                             , 12092
                                                             , 12093
                                                             , 12094
                                                             , 12095
                                                             , 12096
                                                             , 12097
                                                             , 12098
                                                             , 12099
                                                             , 12100
                                                             , 12101
                                                             , 12102
                                                             , 12103
                                                             , 12104
                                                             , 12105
                                                             , 12107
                                                             , 12108
                                                             , 12109
                                                             , 12110
                                                             , 12111
                                                             , 12112
                                                             , 12113
                                                             , 12114
                                                             , 12115
                                                             , 12116
                                                             , 12117
                                                             , 12118
                                                             , 12119
                                                             , 12120
                                                             , 12121
                                                             , 12122
                                                             , 12123
                                                             , 12124
                                                             , 12125
                                                             , 12126
                                                             , 12127
                                                             , 12128
                                                             , 12129
                                                             , 12130
                                                             , 12223
                                                             , 12224
                                                             , 12225
                                                             , 12226
                                                             , 12227
                                                             , 12228
                                                             , 12229
                                                             , 12230
                                                             , 12231
                                                             , 12232
                                                             , 12233
                                                             , 12234
                                                             , 12235
                                                             , 12236
                                                             , 12237
                                                             , 12238
                                                             , 12239
                                                             , 12240
                                                             , 12241
                                                             , 12242
                                                             , 12243
                                                             , 12244
                                                             , 12245
                                                             , 12246
                                                             , 12247
                                                             , 12248
                                                             , 12249
                                                             , 12250
                                                             , 12251
                                                             , 12252
                                                             , 12253
                                                             , 12254
                                                             , 12255
                                                             , 12256
                                                             , 12257
                                                             , 12258
                                                             , 12259
                                                             , 12260
                                                             , 12261
                                                             , 12262
                                                             , 12263
                                                             , 12264
                                                             , 12265
                                                             , 12266
                                                             , 12267
                                                             , 12268
                                                             , 12269
                                                             , 12270
                                                             , 12271
                                                             , 12272
                                                             , 12273
                                                             , 12274
                                                             , 12275
                                                             , 12276
                                                             , 12277
                                                             , 12278
                                                             , 12279
                                                             , 12280
                                                             , 12281
                                                             , 12282
                                                             , 12283
                                                             , 12284
                                                             , 12285
                                                             , 12286
                                                             , 12287
                                                             , 12288
                                                             , 12289
                                                             , 12290
                                                             , 12291
                                                             , 12292
                                                             , 12293
                                                             , 12294
                                                             , 12295
                                                             , 12296
                                                             , 12297
                                                             , 12298
                                                             , 12299
                                                             , 12300
                                                             , 12301
                                                             , 12302
                                                             , 12303
                                                             , 12304
                                                             , 12305
                                                             , 12306
                                                             , 12307
                                                             , 12308
                                                             , 12309
                                                             , 12310
                                                             , 12311
                                                             , 12312
                                                             , 12313
                                                             , 12314
                                                             , 12319
                                                             , 12320
                                                             , 12321
                                                             , 12322
                                                             , 12547
                                                             , 12549
                                                             , 12550
                                                             , 12551
                                                             , 12552
                                                             , 12553
                                                             , 12554
                                                             , 12555
                                                             , 12556
                                                             , 12557
                                                             , 12558
                                                             , 12559
                                                             , 12560
                                                             , 12561
                                                             , 12562
                                                             , 12563
                                                             , 12564
                                                             , 12566
                                                             , 12567
                                                             , 12568
                                                             , 12569
                                                             , 12570
                                                             , 12571
                                                             , 12572
                                                             , 12573
                                                             , 12574
                                                             , 12575
                                                             , 12576
                                                             , 12577
                                                             , 12578
                                                             , 12579
                                                             , 12580
                                                             , 12581
                                                             , 12582
                                                             , 12583
                                                             , 12584
                                                             , 12585
                                                             , 12586
                                                             , 12587
                                                             , 12588
                                                             , 12589
                                                             , 12590
                                                             , 12591
                                                             , 12592
                                                             , 12593
                                                             , 12594
                                                             , 12595
                                                             , 12596
                                                             , 12597
                                                             , 12598
                                                             , 12599
                                                             , 12600
                                                             , 12601
                                                             , 12602
                                                             , 12603
                                                             , 12604
                                                             , 12605
                                                             , 12606
                                                             , 12607
                                                             , 12608
                                                             , 12609
                                                             , 12610
                                                             , 12611
                                                             , 12612
                                                             , 12614
                                                             , 12615
                                                             , 12616
                                                             , 12617
                                                             , 12618
                                                             , 12619
                                                             , 12620
                                                             , 12621
                                                             , 12622
                                                             , 12623
                                                             , 12624
                                                             , 12625
                                                             , 12626
                                                             , 12627
                                                             , 12628
                                                             , 12629
                                                             , 12630
                                                             , 12631
                                                             , 12632
                                                             , 12633
                                                             , 12634
                                                             , 12635
                                                             , 12636
                                                             , 12637
                                                             , 12638
                                                             , 12639
                                                             , 12640
                                                             , 12641
                                                             , 12642
                                                             , 12643
                                                             , 12644
                                                             , 12645
                                                             , 12646
                                                             , 12647
                                                             , 12648
                                                             , 12649
                                                             , 12650
                                                             , 12651
                                                             , 12652
                                                             , 12653
                                                             , 12654
                                                             , 12655
                                                             , 12656
                                                             , 12657
                                                             , 12659
                                                             , 12660
                                                             , 12661
                                                             , 12662
                                                             , 12663
                                                             , 12664
                                                             , 12665
                                                             , 12666
                                                             , 12667
                                                             , 12668
                                                             , 12669
                                                             , 12670
                                                             , 12671
                                                             , 12672
                                                             , 12673
                                                             , 12674
                                                             , 12675
                                                             , 12676
                                                             , 12677
                                                             , 12678
                                                             , 12679
                                                             , 12680
                                                             , 12681
                                                             , 12682
                                                             , 12683
                                                             , 12684
                                                             , 12685
                                                             , 12686
                                                             , 12687
                                                             , 12688
                                                             , 12689
                                                             , 12690
                                                             , 12691
                                                             , 12692
                                                             , 12693
                                                             , 12694
                                                             , 12695
                                                             , 12696
                                                             , 12697
                                                             , 12698
                                                             , 12699
                                                             , 12700
                                                             , 12701
                                                             , 12702
                                                             , 12862
                                                             , 12863
                                                             , 12864
                                                             , 12865
                                                             , 12866
                                                             , 12867
                                                             , 12868
                                                             , 12869
                                                             , 12870
                                                             , 12871
                                                             , 12872
                                                             , 12873
                                                             , 12874
                                                             , 12875
                                                             , 12876
                                                             , 12877
                                                             , 12878
                                                             , 12879
                                                             , 12880
                                                             , 12881
                                                             , 12882
                                                             , 12883
                                                             , 12884
                                                             , 12885
                                                             , 12886
                                                             , 12887
                                                             , 12888
                                                             , 12889
                                                             , 12890
                                                             , 12891
                                                             , 12892
                                                             , 12893
                                                             , 12894
                                                             , 12895
                                                             , 12896
                                                             , 12897
                                                             , 12898
                                                             , 12899
                                                             , 12900
                                                             , 12901
                                                             , 12902
                                                             , 12903
                                                             , 12904
                                                             , 12905
                                                             , 12906
                                                             , 12907
                                                             , 12908
                                                             , 12909
                                                             , 12910
                                                             , 12911
                                                             , 12912
                                                             , 12913
                                                             , 12914
                                                             , 12915
                                                             , 12916
                                                             , 12917
                                                             , 12918
                                                             , 12919
                                                             , 12920
                                                             , 12921
                                                             , 12922
                                                             , 12923
                                                             , 12924
                                                             , 12925
                                                             , 12926
                                                             , 12927
                                                             , 12928
                                                             , 12929
                                                             , 12930
                                                             , 12931
                                                             , 12932
                                                             , 12933
                                                             , 12934
                                                             , 12935
                                                             , 12936
                                                             , 12937
                                                             , 12938
                                                             , 12939
                                                             , 12940
                                                             , 12941
                                                             , 12942
                                                             , 12943
                                                             , 12944
                                                             , 12945
                                                             , 12946
                                                             , 12947
                                                             , 12948
                                                             , 12949
                                                             , 12950
                                                             , 12951
                                                             , 12952
                                                             , 12953
                                                             , 12954
                                                             , 12955
                                                             , 12956
                                                             , 12957
                                                             , 12958
                                                             , 12959
                                                             , 12960
                                                             , 12961
                                                             , 12962
                                                             , 12963
                                                             , 12964
                                                             , 12965
                                                             , 12966
                                                             , 12967
                                                             , 12968
                                                             , 12969
                                                             , 12970
                                                             , 12971
                                                             , 12972
                                                             , 12973
                                                             , 12974
                                                             , 12975
                                                             , 12976
                                                             , 12977
                                                             , 12978
                                                             , 12979
                                                             , 12980
                                                             , 12981
                                                             , 12982
                                                             , 12983
                                                             , 12984
                                                             , 12985
                                                             , 12986
                                                             , 12987
                                                             , 12988
                                                             , 12989
                                                             , 12990
                                                             , 12991
                                                             , 12992
                                                             , 12993
                                                             , 12994
                                                             , 12995
                                                             , 12996
                                                             , 12997
                                                             , 12998
                                                             , 12999
                                                             , 13000
                                                             , 13001
                                                             , 13002
                                                             , 13003
                                                             , 13004
                                                             , 13005
                                                             , 13006
                                                             , 13007
                                                             , 13008
                                                             , 13009
                                                             , 13010
                                                             , 13011
                                                             , 13012
                                                             , 13013
                                                             , 13014
                                                             , 13015
                                                             , 13016
                                                             , 13017
                                                             , 13018
                                                             , 13019
                                                             , 13020
                                                             , 13092
                                                             , 13093
                                                             , 13094
                                                             , 13101
                                                             , 13102
                                                             , 13103
                                                             , 13104
                                                             , 13105
                                                             , 13106
                                                             , 13128
                                                             , 13129
                                                             , 13130
                                                             , 13131
                                                             , 13132
                                                             , 13133
                                                             , 13134
                                                             , 13135
                                                             , 13136
                                                             , 13137
                                                             , 13138
                                                             , 13139
                                                             , 13140
                                                             , 13141
                                                             , 13142
                                                             , 13143
                                                             , 13144
                                                             , 13145
                                                             , 13146
                                                             , 13147
                                                             , 13148
                                                             , 13156
                                                             , 13157
                                                             , 13158
                                                             , 13159
                                                             , 13160
                                                             , 13161
                                                             , 13162
                                                             , 13184
                                                             , 13185
                                                             , 13186
                                                             , 13187
                                                             , 13188
                                                             , 13189
                                                             , 13190
                                                             , 13191
                                                             , 13192
                                                             , 13193
                                                             , 13194
                                                             , 13195
                                                             , 13196
                                                             , 13197
                                                             , 13198
                                                             , 13199
                                                             , 13200
                                                             , 13201
                                                             , 13202
                                                             , 13203
                                                             , 13204
                                                                       )

























                                                           
                                                           
                                                           
                                                           
                                                           
                                                           

-- drop meaningless answers


            [juancarlos].[dbo].[Pew_answer].[Question_wording_std] = 'GRX_25_01_text'
       OR
            





-- Update from other table:
SELECT *
FROM
(
SELECT [Answer_pk]
      ,[Answer_value]
      ,[Question_fk]
      ,[Answer_wording]
      ,[answer_wording_std]
      ,[Question_pk]
      ,[Question_abbreviation]
      ,[Question_wording]
      ,[Data_source_fk]
      ,[Question_Year]
      ,[Short_wording]
      ,[Notes]
      ,[Default_response]
      ,[Question_abbreviation_std]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
  FROM [juancarlos].[dbo].[Pew_answer]
           ,[forum].[dbo].[Pew_Question]
where  Question_fk = Question_pk
and    Question_abbreviation_std 
       IN (
            , 



 NOT LIKE 'SVY%'
) AS C1
,
(
SELECT [Answer_pk]
      ,[Answer_value]
      ,[Question_fk]
      ,[Answer_wording]
      ,[answer_wording_std]
      ,[Question_pk]
      ,[Question_abbreviation]
      ,[Question_wording]
      ,[Data_source_fk]
      ,[Question_Year]
      ,[Short_wording]
      ,[Notes]
      ,[Default_response]
      ,[Question_abbreviation_std]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
  FROM [juancarlos].[dbo].[Pew_answer]
           ,[forum].[dbo].[Pew_Question]
where  Question_fk = Question_pk
and    Question_abbreviation_std NOT LIKE 'SVY%'
) AS W2


WHERE SUBSTRING ( expression ,start , length )





UPDATE
           [juancarlos].[dbo].[Pew_Answer]
SET
           [juancarlos].[dbo].[Pew_Answer].[Answer_Wording]
       =                             clone.[Source_Display_Name]
     --,
     --      [forum].[dbo].[Pew_Footnote].[About_the_Data_link]
     --  =                          clone.[About_the_Data_link]
FROM
          [forum].[dbo].[Pew_Data_Source]   AS mydbt
 JOIN
        [Stacy's].[dbo].[Pew_Data_Source]   AS clone

ON
           mydbt.[Data_source_pk]
       =   clone.[Data_source_pk]

/*********************************************************************************************************/
-- check results
SELECT * FROM    [forum].[dbo].[Pew_Data_Source]
SELECT * FROM  [Stacy's].[dbo].[Pew_Data_Source]
/*********************************************************************************************************/




USE juancarlos ;
GO

IF OBJECT_ID ('Pew_AQ', 'V') IS NOT NULL
  DROP VIEW    Pew_AQ;
GO
   
CREATE VIEW    Pew_AQ
AS


SELECT [Answer_pk]
      ,[Answer_value]
      ,[Question_fk]
      ,[Answer_wording]
      ,[answer_wording_std]
      ,[Question_pk]
      ,[Question_abbreviation]
      ,[Question_wording]
      ,[Data_source_fk]
      ,[Question_Year]
      ,[Short_wording]
      ,[Notes]
      ,[Default_response]
      ,[Question_abbreviation_std]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
  FROM [forum].[dbo].[Pew_answer]
      ,[forum].[dbo].[Pew_Question]
where  Question_fk = Question_pk
and    Question_abbreviation_std NOT LIKE 'SVY%'




DELETE FROM [forum].[dbo].[Pew_Topic]
WHERE
            [forum].[dbo].[Pew_Topic].[Topic_pk] = 60

DELETE FROM [forum].[dbo].[Pew_Question_Topic]
WHERE
            [forum].[dbo].[Pew_Question_Topic].[Topic_fk] = 60


select *  FROM [forum].[dbo].[Pew_Question_Topic]
WHERE
            [forum].[dbo].[Pew_Question_Topic].[Topic_fk] = 60


Topic_pk	Topic_sorting	SubTopic_Sorting	Topic	SubTopic	Display
60	4	2	Interfaith Relations	Interfaith Tolerance	1



