SELECT  
          --distinct 
          A.Answer_pk
        , Q.[Question_abbreviation_std]
        , Q.[Question_short_wording_std]
        , Answer_wording             = A.[Answer_wording]
        , answer_wording_std         = A.[answer_wording_std]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND Q.[Question_abbreviation_std]     LIKE '%text'
  and Answer_wording     =  ''
  AND answer_wording_std IS NULL
  
  AND Q.[Question_abbreviation_std]     LIKE '%text'
  and Question_abbreviation_std = 'SHX_28_02_text'






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
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND Q.[Question_abbreviation_std]     LIKE '%text'

  and Question_abbreviation_std = 'GRX_25_01_text'