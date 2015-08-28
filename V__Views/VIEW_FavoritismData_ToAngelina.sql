USE [forum]
GO
/**************************** Object:  View [dbo].[v_GRI_20_01_all]    Script Date: 02/26/2013 ****************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************************************************************************************/
ALTER View [dbo].[v_GRI_20_01_all] as 
/**************************************************************************************************************************/
SELECT 
        Ctry_EditorialName
      , GRI_20_01_2007
      , GRI_20_01_2008
      , GRI_20_01_2009
      , GRI_20_01_2010
      , GRI_20_01_2011
      , GRI_20_01_D_2011
      , GRI_20_01_X_Buddhism_2009
      , GRI_20_01_X_Buddhism_2010
      , GRI_20_01_X_Buddhism_2011
      , GRI_20_01_X_CatholicChristianity_2009
      , GRI_20_01_X_CatholicChristianity_2010
      , GRI_20_01_X_CatholicChristianity_2011
      , GRI_20_01_X_Christianityunspecified_2009
      , GRI_20_01_X_Christianityunspecified_2010
      , GRI_20_01_X_Christianityunspecified_2011
      , GRI_20_01_X_Hinduism_2009
      , GRI_20_01_X_Hinduism_2010
      , GRI_20_01_X_Hinduism_2011
      , GRI_20_01_X_Islamunspecified_2009
      , GRI_20_01_X_Islamunspecified_2010
      , GRI_20_01_X_Islamunspecified_2011
      , GRI_20_01_X_Judaism_2009
      , GRI_20_01_X_Judaism_2010
      , GRI_20_01_X_Judaism_2011
      , GRI_20_01_X_OrthodoxChristianity_2009
      , GRI_20_01_X_OrthodoxChristianity_2010
      , GRI_20_01_X_OrthodoxChristianity_2011
      , GRI_20_01_X_Other_2009
      , GRI_20_01_X_Other_2010
      , GRI_20_01_X_Other_2011
      , GRI_20_01_X_ProtestantAnglicanChristianity_2009
      , GRI_20_01_X_ProtestantAnglicanChristianity_2010
      , GRI_20_01_X_ProtestantAnglicanChristianity_2011
      , GRI_20_01_X_ShiaIslam_2009
      , GRI_20_01_X_ShiaIslam_2010
      , GRI_20_01_X_ShiaIslam_2011
      , GRI_20_01_X_SunniIslam_2009
      , GRI_20_01_X_SunniIslam_2010
      , GRI_20_01_X_SunniIslam_2011

FROM
(
/* Restrictions' Data in long format ****************************************************************/
SELECT
        Nation_fk
      , Ctry_EditorialName
      --, Question_wording
      , Heading = CASE
                       WHEN Std_VarName = 'GRI_20_01'
                       THEN   
                              'GRI_20_01_'
                            + STR(Question_Year , 4,2 )
                       WHEN Std_VarName = 'GRI_20_01_DSCPTN'
                       THEN   
                              'GRI_20_01_D_'
                            + STR(Question_Year , 4,2 )
                       ELSE
                              'GRI_20_01_X_'
                            + Religion
                            + '_'
                            + STR(Question_Year , 4,2 )
                       
                       END
      , Answer  = CASE
                       WHEN Std_VarName = 'GRI_20_01_DSCPTN'
                       THEN   
                             Answer_wording
                       WHEN Std_VarName = 'GRI_20_01'
                       THEN   
                              STR((CAST(Answer_value as decimal (4,2))) , 4,2 )
                           + '   - '
                           + Answer_wording_std
                       ELSE
                              STR((CAST(Answer_value as decimal (4,2))) , 4,2 )
                       END
FROM
(
SELECT  level              = 'Ctry'
      , Nation_fk          = N.[Nation_pk]
      , Ctry_EditorialName = N.[Ctry_EditorialName]
      , Religion           = 'not detailed'
      , Question_Year      = Q.[Question_Year]
      , Std_VarName        = Q.[Question_abbreviation_std]
      , Question_wording   = Q.[Question_wording_std]
      , Answer_value       = A.[Answer_value]
      , Answer_wording_std = A.[answer_wording_std]
      , Answer_wording     = A.[answer_wording]
  FROM [forum].[dbo].[Pew_Answer]            A
      ,[forum].[dbo].[Pew_Question]          Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Question_pk] =  A.[Question_fk]
  AND A.[Answer_pk]   = KN.[Answer_fk]
  AND N.[Nation_pk]   = KN.[Nation_fk]

UNION

SELECT  level              = 'RGrp'
      , Nation_fk          = N.[Nation_pk]
      , Ctry_EditorialName = N.[Ctry_EditorialName]
      , Religion           =   
                              Replace(
                                (Replace(
                                   (Replace(G.[Pew_religion], ',', ''))
                                                            , ' ', ''))
                                                            , '/', '')
      , Question_Year      = Q.[Question_Year]
      , Std_VarName        = Q.[Question_abbreviation_std]
      , Question_wording   = Q.[Question_wording]
      , Answer_value       = A.[Answer_value]
      , Answer_wording_std = A.[answer_wording_std]
      , Answer_wording     = A.[answer_wording]
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
where Std_VarName like 'GRI_20_01%'
/**************************************************************** Restrictions' Data in long format */
) AS rdlf
pivot (max (Answer) 
       for Heading
           in (
        GRI_20_01_2007
      , GRI_20_01_2008
      , GRI_20_01_2009
      , GRI_20_01_2010
      , GRI_20_01_2011
      , GRI_20_01_D_2011
      , GRI_20_01_X_Buddhism_2009
      , GRI_20_01_X_Buddhism_2010
      , GRI_20_01_X_Buddhism_2011
      , GRI_20_01_X_CatholicChristianity_2009
      , GRI_20_01_X_CatholicChristianity_2010
      , GRI_20_01_X_CatholicChristianity_2011
      , GRI_20_01_X_Christianityunspecified_2009
      , GRI_20_01_X_Christianityunspecified_2010
      , GRI_20_01_X_Christianityunspecified_2011
      , GRI_20_01_X_Hinduism_2009
      , GRI_20_01_X_Hinduism_2010
      , GRI_20_01_X_Hinduism_2011
      , GRI_20_01_X_Islamunspecified_2009
      , GRI_20_01_X_Islamunspecified_2010
      , GRI_20_01_X_Islamunspecified_2011
      , GRI_20_01_X_Judaism_2009
      , GRI_20_01_X_Judaism_2010
      , GRI_20_01_X_Judaism_2011
      , GRI_20_01_X_OrthodoxChristianity_2009
      , GRI_20_01_X_OrthodoxChristianity_2010
      , GRI_20_01_X_OrthodoxChristianity_2011
      , GRI_20_01_X_Other_2009
      , GRI_20_01_X_Other_2010
      , GRI_20_01_X_Other_2011
      , GRI_20_01_X_ProtestantAnglicanChristianity_2009
      , GRI_20_01_X_ProtestantAnglicanChristianity_2010
      , GRI_20_01_X_ProtestantAnglicanChristianity_2011
      , GRI_20_01_X_ShiaIslam_2009
      , GRI_20_01_X_ShiaIslam_2010
      , GRI_20_01_X_ShiaIslam_2011
      , GRI_20_01_X_SunniIslam_2009
      , GRI_20_01_X_SunniIslam_2010
      , GRI_20_01_X_SunniIslam_2011
              )
        ) 
       as PivotedData
/******************************************************************  Unpivoted Values: Nation Level   ***/
/**************************************************************************************************************************/
