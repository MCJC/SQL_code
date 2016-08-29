/******************************************************************************************/
-- December 7
/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14077
WHERE Nation_answer_pk  = 79674

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14078
WHERE Nation_answer_pk  = 79659

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14078
WHERE Nation_answer_pk  = 79727


/******************************************************************************************/
-- December 10
/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Locality_Answer]

SET   Answer_fk         = -1
WHERE Locality_answer_pk  IN (
7704,  -- France
6187,
7392,
5839,  

7879,  -- Sri Lanka
6593,
7757,
7758,
7809,
5676,
6344,
6508
)


/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14072    -- SHI_04 for Netherlands, or bring back to 11870
WHERE Nation_answer_pk  = 67447

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14072    -- SHI_04 for Paraguay, or bring back to 11870
WHERE Nation_answer_pk  = 68572

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14072    -- SHI_04 for Western Sahara, or bring back to 11870
WHERE Nation_answer_pk  = 73766



/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14084    -- .5
WHERE Nation_answer_pk  = 79604    -- Kososvo

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14084    -- .5
WHERE Nation_answer_pk  = 79584    -- Burma (Myanmar)

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14086    -- 1
WHERE Nation_answer_pk  = 79536    -- Pakistan

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14085    -- .75
WHERE Nation_answer_pk  = 79600    -- Serbia

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 14084    -- .5
WHERE Nation_answer_pk  = 79581    -- Sri Lanka




-- December 12
/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 8047    -- Pakistan, GRI_10, or bring back to 8046
WHERE Nation_answer_pk  = 68052

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 10273    -- Egypt, GRI_20_05, or bring back to 10272
WHERE Nation_answer_pk  = 76986

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 11868    -- Denmark, SHI_04, or bring back to 11870
WHERE Nation_answer_pk  = 76539

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 11868    -- Guinea, SHI_04, or bring back to 14073
WHERE Nation_answer_pk  = 78484




-- December 14
/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 13354    -- Kosovo, SHI_07, or bring back to 13356
WHERE Nation_answer_pk  = 64411

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 13433    -- Kosovo, SHI_08, or bring back to 13434
WHERE Nation_answer_pk  = 64410

/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Nation_Answer]

SET   Answer_fk         = 13502    -- Kosovo, SHI_09, or bring back to 13503
WHERE Nation_answer_pk  = 64413


/******************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Locality_Answer]

SET   Answer_fk         = -1
WHERE Locality_answer_pk  IN (
3011,  -- Cyprus, GRI_19_b	
3013,  -- Cyprus, SHI_05_d
5533   -- Cyprus, SHI_05_db
)


-- January 14
/****************************************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Question]

SET   Question_abbreviation_std = 'GRI_20_05_x'
WHERE Question_pk               = 1070
  AND Question_abbreviation_std = 'GRX_20_05x'   -- * coding error: "GRI_20_05_x" was labeled as "GRX_20_05x"

UPDATE     [forum].[dbo].[Pew_Answer]

SET   Answer_wording      = 'Yes, in some Provinces'
	, Answer_wording_std  = 'Yes, in some Provinces'
WHERE Answer_pk           = 10329
  AND Answer_value        = 0.50
  AND Question_fk         = 1070
  AND Answer_wording      = 'Yes, in some parts of the country'
  AND Answer_wording_std  = 'Yes, in some parts of the country'  -- * coding error: wording changed for 2011


UPDATE     [forum].[dbo].[Pew_Answer]

SET   Answer_wording      = 'Yes, in the whole country'
	, Answer_wording_std  = 'Yes, in the whole country'
WHERE Answer_pk           = 10330
  AND Answer_value        = 1
  AND Question_fk         = 1070
  AND Answer_wording      = 'Yes, in all the country'
  AND Answer_wording_std  = 'Yes, in all the country'            -- * coding error: wording changed for 2011


-- January 23
/****************************************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Question]

SET   Question_short_wording_std = 'Have provisions of Shari''a law been adopted in the country?'
WHERE Question_pk                = 1070
  AND Question_abbreviation_std  = 'GRI_20_05_x'
                                                               -- * coding error: short wording null for 2011

/****************************************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Question]

SET   Question_wording_std        = 'Do you or your family ever use traditional religious healers when someone is sick?'
	, Question_short_wording_std  = 'Do you or your family ever use traditional religious healers?'
WHERE Question_pk                = 593
  AND Question_abbreviation_std  = 'SVYc_0020'
                                                        -- * coding error: updated wording affected dummy data

/****************************************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Question]

SET   Question_wording_std       =   'Do you identify with any Sufi orders -- such as (IN SOUTH ASIA: Chistiyya, Naqshban'
								   + 'diya, Qadiriyya, Suhrawardiyya or Shattariyya; IN SOUTHEAST ASIA: Naqshbandiyya Kha'
								   + 'lidiyya, Qadiriyya wa Naqshbandiyya, Shattariyya, Siddiqiyya, Junaidiyya, Sammaniyy'
								   + 'a, Wahidiyya, Sanusiyya or Tijaniyya; IN MIDDLE EAST-NORTH AFRICA: Jerrahiyya, Mevl'
								   + 'eviyya, Naqshbandiyya, Qadiriyya, Tijaniyya, Shadhiliyya or Alawiyya; IN SUB-SAHARA'
								   + 'N AFRICA: Tijaniyya, Qadiriyya, Chistiyya, Shadhiliyya, Alawiyya, or Muridiyya; IN '
								   + 'ALABANIA,BOSNIA-HERZEGOVINA, KOSOVO: as Bektashiyya, Naqshbandiyya, Halvatiyya, Qad'
								   + 'iriyya or Rifa’iyya; IN AZERBAIJAN, KAZAKHSTAN, KYRGYZSTAN, TAJIKISTAN, UZBEKISTAN:'
								   + ' Kubrawiyya, Yasawiyya, Khwajagan, Naqshbandiyya or Qalandariyya; IN RUSSIA: Qadiri'
								   + 'yya, Naqshbandiyya, Shazaliyya, Vis Haji, Yasawiyya or Dzhazuliyya; in TURKEY: Jerr'
								   + 'ahiyya, Mevleviyya, Naqshbandiyya, Qadiriyya, Tijaniyya or Shadhiliyya)'
WHERE Question_pk                = 841
  AND Question_abbreviation_std  = 'SVYc_0077'
                                                        -- * coding error: unstandardized wording


/****************************************************************************************************************/




-- Jan 29
/****************************************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]

SET   answer_wording_std  = 'Yes, in limited ways'      -- * Standard wording used other years
WHERE Answer_pk           = 10883
                                                        -- * coding error: unstandardized wording


/****************************************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]

SET   answer_wording_std  =  'Yes, with violence that resulted in so'
                           + 'me casualties (1-9 injuries or deaths)'    -- * Standard wording changed this year
WHERE Answer_pk       IN (
                             3420   -- 2007
                           , 3199   -- 2008
                           , 2978   -- 2009
                           , 4088   -- 2010
                         )
                                                                         -- * UPDATE standardized wording


/****************************************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]

SET   answer_wording_std  =  'Yes, with violence that resulted in multi'
                           + 'ple casualties (10-50 injuries or deaths)' -- * Standard wording used other years
WHERE Answer_pk           =   14073
                                                                         -- * coding error: unstandardized wording


/****************************************************************************************************************/
UPDATE     [forum].[dbo].[Pew_Answer]

SET   answer_wording_std  =  'Yes, with violence that resulted in many cas'
                           + 'ualties (more than 50 injuries or deaths)' -- * Standard wording used other years
WHERE Answer_pk           =   11872
                                                                         -- * coding error: unstandardized wording


/****************************************************************************************************************/



------check

SELECT     
        DISTINCT
      --  N.[Nation_pk]
      --, N.[Ctry_EditorialName]
      --, 
      --  Q.[Question_Year]
      --, 
      Q.[Question_abbreviation_std]
      --, Q.[Question_short_wording_std]
      , A.answer_value
      , A.[answer_wording_std]
      --,    Question_fk = Q.[Question_pk]
      --,    Answer_fk   = A.[Answer_pk]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]
  and Q.Question_abbreviation_std = 'SHI_04'
  --and A.answer_value              = 0.50

ORDER
   BY   
      --  Q.[Question_Year]
      --, 
        Q.[Question_abbreviation_std]
      ,    Answer_value
