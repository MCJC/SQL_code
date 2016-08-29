
/**********************************************************************************************/
/* Select population by Sub-Religions                                                         */
SELECT  RV.Nation_fk
      , RV.Source
      , RV.Source_year
      , RGpPercentage                = ROUND( (D.Proportion * RV.Percentage          / 100  ) , 4)
      , RV.Field_fk
      , RV.Religion_group_fk  AS MajorReligion_fk
      ,  D.Sub_Religion_fk    AS SubReligion_fk
      ,  R.Pew_religion_lev02 AS MajorReligion
      ,  R.Pew_religion_lev03 AS SubReligion
      ,  R.Wrd_religion_code
      ,  X.Sex_pk
      ,  X.Sex
      ,  A.Age_pk
      ,  A.Age
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]       AS   RV
      ,[forum].[dbo].[Pew_Nation_Subreligion_Distribution]     AS   D
      ,[forum].[dbo].[Pew_Religion_Group]                      AS   R
      ,[forum].[dbo].[Pew_Sex]                                 AS   X
      ,[forum].[dbo].[Pew_Age]                                 AS   A
WHERE  D.Aggregated_Religion_fk      = RV.Religion_group_fk
   AND D.Nation_fk                   = RV.Nation_fk
   AND D.Distribution_wave_id        = RV.Distribution_wave_id
   AND D.Majority_SubReligion_Range  = 'mid'
   AND D.Sub_Religion_fk             = R.Religion_group_pk
-----------------------------------------------------------------------
   AND RV.Sex_fk                     = X.Sex_pk
   AND RV.Age_fk                     = A.Age_pk
   AND RV.Sex_fk                     = 0
   AND RV.Age_fk                     = 0
-----------------------------------------------------------------------
   AND RV.Field_fk                    IN ( 25, 28 )
   --AND  R.Wrd_religion_code           = N'RC'                               

   AND  R.Pew_religion_lev02          = N'Muslims'
   AND RV.Nation_fk                   = 2
/*
The one important piece of information we seem to have lost in the process however is the primary source 
of the final pew estimate. e.g. the “nation_value_source” field for Muslims in Albania used to show as
 “DHS 2008/2009” but the “Source” field in Pew_Nation_Religion_Age_Sex_Value refers only to this being a
  Pew Estimate, and the “Notes” field mentions DHS, but not the year. Where should I be looking to find 
  that reference to DHS 2008 or whatever as the original source? The ones that are sourced back to 
  WRD 2010 are especially important for us to track to avoid circular referencing
   (e.g. Todd investigates why a Pew Estimate differs from his WRD estimate only to find 
   the Pew value actually came from a previous version of WRD).

By the way, when I try to look at (alter or create) the actual sql of the view Pew_Nation_Religion_Value at Forumdb I get an error:
“Property TextHeader is not available for View '[dbo].[Pew_Nation_Religion_Value]'. This property may 
not exist for this object, or may not be retrievable due to insufficient access rights. The text is 
encrypted. (Microsoft.SqlServer.Smo)”
so I can’t see exactly how the view is constructed (but that’s OK if the above SQL will work for Religion_Comparison anyway.

Cheerio,

*/


/**********************************************************************************************/
