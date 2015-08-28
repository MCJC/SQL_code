USE [forum_ResAnal]
GO
/********************************************************************************************************************/
/***                                                                                                              ***/
/***      The long set of data includes numeric values and descriptive wordings for GR&SH R                       ***/
/***                                                                                                              ***/
/***                                > > >     lookup tables  work faster     < < <                                ***/
/***                                                                                                              ***/
/********************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr_0______NationLocalityTOOL]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr_0______NationLocalityTOOL]
----------------------------------------------------------------------------------------------------------------------
SELECT * 	INTO [forum_ResAnal].[dbo].[vr_0______NationLocalityTOOL]
FROM
----------------------------------------------------------------------------------------------------------------------
(
/*** Set of data at country/province level **************************************************************************/
SELECT
           distinct
          [Nation_fk]     = N.[Nation_pk]
      ,   [Locality_fk]   = L.[Locality_pk]
      , L.[Locality]
  FROM [forum].[dbo].[Pew_Q&A]               Q
      ,[forum].[dbo].[Pew_Locality]          L
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Locality_Answer]   KL
WHERE Q.[Answer_fk]   = KL.[Answer_fk]
  AND L.[Locality_pk] = KL.[Locality_fk]
                                /* No need of change in order to keep consistency of 2012: 
                                   Data by Province currently belonging to South Sudan
                                   should considered data for Sudan before 2010             */
  AND N.[Nation_pk]   =  L.[Nation_fk]
                                /* In order to avoid changing the final set,
                                   Data previously used for Northern Cyprus
                                   should be excluded                                       */
                                /* Although we have REAL data by province for North Korea,
                                   we will not use them in this analysis                    */
                                /* Pull only data on Restrictions                           */
  AND Q.[Pew_Data_Collection] = 'Global Restriction on Religion Study'
  AND Q.[Question_Year] = 2012
                                /* redundant filters                                        */
  AND
    (    Q.[Question_abbreviation_std]   LIKE 'GRI_19_[b-f]'
      OR Q.[Question_abbreviation_std]   LIKE 'SHI_0[1, 4, 5]_[b-f]'   )
/************************************************************************** Set of data at country/province level ***/
) AS CPL
/********************************************************************************************************************/
GO
