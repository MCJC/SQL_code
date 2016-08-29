create view ChristianSubGroups
as

select * from
(

select * from
(
/**********************************************************************************************/
/* Proportion and Population by religion-group / year / scenario
   Religions & 2.5 level SubReligions included (sub-groups consistent to published data)
   => The percentage stored in pew_nation_religion_age_sex_structure is the percentage
      of the total population of the corresponding 'age-group/sex-group' in that country      */
/**********************************************************************************************/
/*   ONLY: Preferred Scenario                                                                 */
/**********************************************************************************************/
/*   NOTICE: Although precentages of subreligions add exactly to the percentages by religion, */
/*           added counts have some error because of rounding                                 */
/**********************************************************************************************/
SELECT * FROM
(
/**********************************************************************************************/
(
/**********************************************************************************************/
/* Section 1 of 2:                                                                            */
/* Select population by * major Religions                                                     */
SELECT Year              = FR.Field_year
      ,                    N.Nation_pk
      ,                    R.Religion_group_pk
      ,Country           = N.Ctry_EditorialName
      ,Religion          = R.Pew_religion_lev02
      ,SubReligion       = R.Pew_religion_lev03
      ,Source            = FR.Field_note
      ,PercentByReligion = ROUND(   RV.Percentage                  , 4)
      ,PopulByReligion   = ROUND( ((RV.Percentage * NV.Cnt / 100)) , 0)
      ,PopByRelUnrounded = ROUND( ((RV.Percentage * NV.Cnt / 100)) , 4)
      ,TotPop_Constant   =  CAST(   NV.Cnt AS bigint                  )
      ,Scenario          = RV.Scenario_id
      ,Preferred         = CASE     RV.Scenario_id WHEN P.Preferred_scenario_id THEN 'yes'
                                                                                ELSE 'no'
                                                    END
      ,URL               = D.Data_source_url
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]       AS   RV
      ,[forum].[dbo].[Pew_Nation_Age_Sex_Value]                AS   NV
      ,[forum].[dbo].[Pew_Field]                               AS   FR
      ,[forum].[dbo].[Pew_Field]                               AS   FN
      ,[forum].[dbo].[Pew_Data_Source]                         AS   D
      ,[forum].[dbo].[Pew_Preferred_Scenario]                  AS   P
      ,[forum].[dbo].[Pew_Religion_Group]                      AS   R
      ,[forum].[dbo].[Pew_Nation]                              AS   N
WHERE  RV.Nation_fk                  = NV.Nation_fk                       /* match RV-NV */
   AND RV.Sex_fk                     = NV.Sex_fk                          /* match RV-NV */
   AND RV.Age_fk                     = NV.Age_fk                          /* match RV-NV */
  /***************************************************************************************/
   AND RV.Sex_fk                     = 0                                   /* sex: "all" */
   AND RV.Age_fk                     = 0                                   /* age: "all" */
  /***************************************************************************************/
   AND RV.Field_fk                   = FR.Field_pk                  /* link to field...  */
   AND FR.Field_year                 = 2010                        /* to select year    */
  /***************************************************************************************/
   AND NV.Field_fk                   = FN.Field_pk                  /* link to field...  */
   AND FN.Field_year                 = 2010                         /* to select year    */
  /***************************************************************************************/
   AND FR.Data_source_fk             = D.Data_source_pk   /* link R field to datasource  */
  /***************************************************************************************/
   AND RV.Nation_fk                  = P.Nation_fk                /* link to PrefScn...  */
   AND RV.Field_fk                   = P.Field_fk                 /* link to PrefScn...  */
   AND RV.Scenario_id                = P.Preferred_scenario_id    /* to select scenario  */
  /***************************************************************************************/
   AND RV.Display                    = 1                        /* only displayable data */
  /***************************************************************************************/
   AND RV.Nation_fk                  = N.Nation_pk              /* link to N for labels  */
   AND RV.Religion_group_fk          = R.Religion_group_pk      /* link to R for labels  */
   AND R.Religion_group_pk IN (                                 /* we'll have these data */
                                 23,                      /* removed if subRs aggregated */
                                 26,
                                 27,
                                 28,
                                 51,                      /* removed if subRs aggregated */
                                 53,
                                 55,
                                 57
                              )
  /***************************************************************************************/
 --AND N.Ctry_EditorialName          = 'United States'                /* select Country  */
  /***************************************************************************************/
)

/**************************************** -   LINK   - ****************************************/
                                              UNION 
/**************************************** -   LINK   - ****************************************/

(
/**********************************************************************************************/
/* Section 2 of 2:                                                                            */
/* Aggregate population by Sub-Religions                                                      */
SELECT Year
      ,Nation_pk
      ,Religion_group_pk
      ,Country
      ,Religion
      ,SubReligion
      ,Source
      ,PercentByReligion = ROUND(SUM(PercentByReligion)  /   100, 4)
      ,PopulByReligion   = ROUND(SUM(PopulByReligion  )  / 10000, 0)
      ,PopByRelUnrounded = ROUND(SUM(PopulByReligion  )  / 10000, 4)
      ,TotPop_Constant
      ,Scenario
      ,Preferred
      ,URL
  FROM
(
/* Select population by Sub-Religions                                                         */
SELECT Year              = FR.Field_year
      ,                    N.Nation_pk
      ,Religion_group_pk = NULL
      ,Country           = N.Ctry_EditorialName
      ,Religion          = R.Pew_religion_lev02
      ,SubReligion       = R.Pew_religion_lev02_5
      ,SubRelDetailed    = R.Pew_religion_lev03
      ,Source            = FR.Field_note
      ,PercentByReligion = SR.Proportion * RV.Percentage         
      ,PopulByReligion   = SR.Proportion * RV.Percentage * NV.Cnt
      ,TotPop_Constant   =  CAST(   NV.Cnt AS bigint                  )
      ,Scenario          =          RV.Scenario_id
      ,Preferred         = CASE     RV.Scenario_id WHEN P.Preferred_scenario_id THEN 'yes'
                                                                                ELSE 'no'
                                                    END
      ,URL               =           D.Data_source_url
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]       AS   RV
      ,[forum].[dbo].[Pew_Nation_Subreligion_Distribution]     AS   SR
      ,[forum].[dbo].[Pew_Nation_Age_Sex_Value]                AS   NV
      ,[forum].[dbo].[Pew_Field]                               AS   FR
      ,[forum].[dbo].[Pew_Field]                               AS   FN
      ,[forum].[dbo].[Pew_Data_Source]                         AS   D
      ,[forum].[dbo].[Pew_Preferred_Scenario]                  AS   P
      ,[forum].[dbo].[Pew_Religion_Group]                      AS   R
      ,[forum].[dbo].[Pew_Nation]                              AS   N

WHERE  RV.Religion_group_fk          = SR.Aggregated_Religion_fk          /* match RV-SR */
   AND RV.Nation_fk                  = SR.Nation_fk                       /* match RV-SR */
   AND RV.Nation_fk                  = NV.Nation_fk                       /* match RV-NV */
   AND RV.Sex_fk                     = NV.Sex_fk                          /* match RV-NV */
   AND RV.Age_fk                     = NV.Age_fk                          /* match RV-NV */
  /***************************************************************************************/
   AND RV.Sex_fk                     = 0                                   /* sex: "all" */
   AND RV.Age_fk                     = 0                                   /* age: "all" */
  /***************************************************************************************/
   AND SR.Majority_SubReligion_Range = 'mid'                             /* middle range */
  /***************************************************************************************/
   AND RV.Field_fk                   = FR.Field_pk                  /* link to field...  */
   AND FR.Field_year                 = 2010                        /* to select year    */
  /***************************************************************************************/
   AND NV.Field_fk                   = FN.Field_pk                  /* link to field...  */
   AND FN.Field_year                 = 2010                         /* to select year    */
  /***************************************************************************************/
   AND FR.Data_source_fk             = D.Data_source_pk   /* link R field to datasource  */
  /***************************************************************************************/
   AND RV.Nation_fk                  = P.Nation_fk                /* link to PrefScn...  */
   AND RV.Field_fk                   = P.Field_fk                 /* link to PrefScn...  */
   AND RV.Scenario_id                = P.Preferred_scenario_id    /* to select scenario  */
  /***************************************************************************************/
   AND RV.Display                    = 1                        /* only displayable data */
  /***************************************************************************************/
   AND RV.Nation_fk                  = N.Nation_pk              /* link to N for labels  */
   AND SR.Sub_Religion_fk            = R.Religion_group_pk      /* link to R for labels  */
   AND R.Religion_group_pk IN (                                 /* we'll have these data */
                                 5,                                   /* SubR of 23 (M)  */
                                 6,                                   /* SubR of 23 (M)  */
                                16,                                   /* SubR of 51 (C)  */
                                17,                                   /* SubR of 51 (C)  */
                                18,                                   /* SubR of 51 (C)  */
                                19,                                   /* SubR of 51 (C)  */
                                20,                                   /* SubR of 51 (C)  */
                                21                                    /* SubR of 51 (C)  */
                              )
  /***************************************************************************************/
 --AND N.Ctry_EditorialName          = 'United States'                /* select Country  */
  /***************************************************************************************/
/**********************************************************************************************/
) AS  By_SubRel
GROUP BY SubReligion
        ,Year
        ,Nation_pk
        ,Religion_group_pk
        ,Country
        ,Religion
        ,Source
        ,TotPop_Constant
        ,Scenario
        ,Preferred
        ,URL 
/**********************************************************************************************/
)
/**********************************************************************************************/
) AS BaseSet
/**********************************************************************************************/
  /***************************************************************************************/
) as ALLT
--order by Nation_pk, Religion, SubReligion
  /***************************************************************************************/
/**********************************************************************************************/
) as d