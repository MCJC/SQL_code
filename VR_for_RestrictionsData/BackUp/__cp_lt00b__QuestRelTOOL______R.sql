USE [forum_ResAnal]
GO
/********************************************************************************************************************/
/***                                                                                                              ***/
/***      The long set of data includes numeric values and descriptive wordings for GR&SH R                       ***/
/***                                                                                                              ***/
/***                                > > >     lookup tables  work faster     < < <                                ***/
/***                                                                                                              ***/
/********************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr_0______QuestionReligionTOOL]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr_0______QuestionReligionTOOL]
----------------------------------------------------------------------------------------------------------------------
SELECT * 	INTO [forum_ResAnal].[dbo].[vr_0______QuestionReligionTOOL]
FROM
----------------------------------------------------------------------------------------------------------------------
(
/*** Set of data at country/religious group level *******************************************************************/
SELECT
           DISTINCT
           Religion_fk = G.[Religion_group_pk]
      ,    Religion    = G.[Pew_religion]
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
  FROM [forum].[dbo].[Pew_Q&A]                      Q
      ,[forum].[dbo].[Pew_Nation]                   N
      ,[forum].[dbo].[Pew_Religion_Group]           G
      ,[forum].[dbo].[Pew_Nation_Religion_Answer]   KR
WHERE Q.[Answer_fk]           = KR.[Answer_fk]
  AND KR.[Religion_group_fk]  =  G.[Religion_group_pk]
  AND  N.[Nation_pk]          = KR.[Nation_fk]
                                /* Pull only data on Restrictions */
  AND Q.[Pew_Data_Collection] = 'Global Restriction on Religion Study'

  AND Q.[Question_Year] = 2012
                                /* redundant filters                                        */
  AND
    (    Q.[Question_abbreviation_std]   LIKE 'GRI_11_%'
      OR Q.[Question_abbreviation_std]   LIKE 'GRI_20_01x%'
      OR Q.[Question_abbreviation_std]   LIKE 'SHI_01_x%'              )
/******************************************************************* Set of data at country/religious group level ***/
) AS CRL
/********************************************************************************************************************/
GO
/********************************************************************************************************************/
