
SELECT
DISTINCT
         --A.[Question_fk]
       --,
         A.[Answer_pk]
       --,
  --entity      = 'Ctry'
  --    ,    link_fk     = KN.[Nation_answer_pk]
  --    ,    Nation_fk   = N.[Nation_pk]
  --    ,    Locality_fk = NULL
  --    ,    Religion_fk = NULL
  --    , N.[Ctry_EditorialName]
  --    ,    Locality    = 'not detailed'
  --    ,    Religion    = 'not detailed'
      --,  Q.[Question_Year]
      --, Q.[Question_abbreviation_std]  AS  Std_VarName
      --, Q.[Question_wording]
      --, A.[Answer_value]
      --, A.[Answer_wording]
      --, Q.[Notes]
  FROM [forum].[dbo].[Pew_Question]          Q
  LEFT
  JOIN [forum].[dbo].[Pew_Answer]            A


select *
into [juancarlos].[dbo].[Restrictions_Data]
from
(



////////////////////////////////////////////////////////////


SELECT
DISTINCT
         q.[Question_Pk]
  FROM [forum].[dbo].[Pew_Question]          Q

LEFT
JOIN 

(

SELECT
DISTINCT
         Q.[Question_pk]
       --,
         --A.[Answer_pk]
       --,
  --entity      = 'Ctry'
  --    ,    link_fk     = KN.[Nation_answer_pk]
  --    ,    Nation_fk   = N.[Nation_pk]
  --    ,    Locality_fk = NULL
  --    ,    Religion_fk = NULL
  --    , N.[Ctry_EditorialName]
  --    ,    Locality    = 'not detailed'
  --    ,    Religion    = 'not detailed'
      --,  Q.[Question_Year]
      --, Q.[Question_abbreviation_std]  AS  Std_VarName
      --, Q.[Question_wording]
      --, A.[Answer_value]
      --, A.[Answer_wording]
      --, Q.[Notes]
  FROM [forum].[dbo].[Pew_Question]          Q
  LEFT
  JOIN [forum].[dbo].[Pew_Answer]            A

    ON     Q.[Question_pk]
        =  A.[Question_fk]
 ) AS xx
   ON      Q.[Question_pk]
       =  XX.[Question_pk]
  
 where 
         XX.[Question_pk] is null
 
  
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]

UNION

SELECT     entity      = 'Prov'
      ,    link_fk     = KL.[Locality_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = L.[Locality_pk]
      ,    Religion_fk = NULL
      , N.[Ctry_EditorialName]
      ,    Locality    = L.[Locality]
      ,    Religion    = 'not detailed'
      , Q.[Question_Year]
      , Q.[Question_abbreviation_std]  AS  Std_VarName
      , Q.[Question_wording]
      , A.[Answer_value]
      , A.[Answer_wording]
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

SELECT     entity      = 'RGrp'
      ,    link_fk     = KR.[Nation_religion_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = NULL
      ,    Religion_fk = G.[Religion_group_pk]
      , N.[Ctry_EditorialName]
      ,    Locality    = 'not detailed'
      ,    Religion    = G.[Pew_religion]
      , Q.[Question_Year]
      , Q.[Question_abbreviation_std]  AS  Std_VarName
      , Q.[Question_wording]
      , A.[Answer_value]
      , A.[Answer_wording]
      ,    Question_fk = Q.[Question_pk]
      ,    Answer_fk   = A.[Answer_pk]
      , Q.[Notes]
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






/***

ORDER BY Q.[Question_abbreviation]
        ,Q.[Question_Year]
        ,N.[Nation_pk]
ORDER BY Q.[Question_abbreviation]
        ,Q.[Question_Year]
        ,N.[Nation_pk]
        ,L.Locality_pk
ORDER BY Q.[Question_abbreviation]
        ,Q.[Question_Year]
        ,N.[Nation_pk]






UPDATE    [forum].[dbo].[Pew_Answer_rows_to_add]
   SET    answer_wording     = RTRIM(answer_wording)
        , answer_wording_std = RTRIM(answer_wording_std)
"),
dsn("ForumDB") user(jcesparzaochoa) password(tz1tz1cU);

***/