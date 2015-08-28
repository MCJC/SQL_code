/***  Basic Data: Long NPR ******************************************************************************************/
----------------------------------------------------------------------------------------------------------------------
/*** Set of data at country level ***********************************************************************************/
SELECT
           entity      = 'Ctry'
      ,    link_fk     = KN.[Nation_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = NULL
      ,    Religion_fk = NULL
      , N.[Ctry_EditorialName]
      ,    Locality    = 'not detailed'
      ,    Religion    = ''
      , Q.[Question_Year]
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
      , A.[Answer_value]
      , A.[answer_wording]
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]
/*********************************************************************************** Set of data at country level ***/
UNION
/*** Set of data at country/province level **************************************************************************/
SELECT
           entity             = 'Prov'
      ,    link_fk     = KL.[Locality_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = L.[Locality_pk]
      ,    Religion_fk = NULL
      , N.[Ctry_EditorialName]
      ,    Locality    = L.Locality
      ,    Religion    = ''
      , Q.[Question_Year]
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
      , A.[Answer_value]
      , A.[answer_wording]
      , A.[answer_wording_std]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
      , Q.[Notes]
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
                              should considered data for Sudan before 2010: */
                     CASE 
                            WHEN L.[Nation_fk]     = 237 
                             AND Q.[Question_Year] < 2010 
                            THEN                           197
                            ELSE                           L.[Nation_fk]
                     END 
                           /* In order to avoid changing the final set,
                              Data previously used for Northern Cyprus
                              should be excluded: ????                                 */
                           /* Although we have REAL data by province for North Korea,
                              we will not use them in this analysis: ????              */
/************************************************************************** Set of data at country/province level ***/
----------------------------------------------------------------------------------------------------------------------
/******************************************************************************************  Basic Data: Long NPR ***/
