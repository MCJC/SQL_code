/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
/*****                                                    STEP 000                                                    *****/
/*****                                           BackUp  current Table(s)                                             *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Attributes' + '_' + @CrDt + ']
                  FROM      [forum].[dbo].[Pew_Question_Attributes]'                      )
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
	INSERT INTO                                                                /* insert statement                        */
	                                      [Pew_Question_Attributes]            /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
             [Question_Attributes_pk]  = ROW_NUMBER()                          /* - number all rows                       */
                                         OVER(ORDER BY  [k]  )                 /*   by QApk                               */
                                      + (SELECT MAX([Question_Attributes_pk])  /* - add currently max pk                  */
                                           FROM [Pew_Question_Attributes])     /*   from QAttributes                      */
/*------------------------------------------------------------------------------------------------------------------------*/
           , [Question_Std_fk]         = [k]                                   /* -                                       */
           , [attk]                    = 'XNote_RbyC'                          /* -                                       */
           , [attr]                    = [t]                                   /* -                                       */
/*------------------------------------------------------------------------------------------------------------------------*/
      FROM
           (
/*------------------------------------------------------------------------------------------------------------------------*/
/*	GRI.01	*/

select
 [k] = 	1	
,[t] = 
  'Article 18 states: "Everyone has the right to freedom of thought, conscience and religion; this right includes freedom to'
+ ' change his religion or belief, and freedom, either alone or in community with others and in public or private, to manife'
+ 'st his religion or belief in teaching, practice, worship and observance."'
/*	GRI_20	*/
union
select
 [k] = 	925	
,[t] = 
  'This is a summary variable that puts the restrictions identified in Questions 20.1, 20.2, 20.3a-c, 20.4, and 20.5 into a '
+ 'single measure indicating the level to which a government supports religious groups in the country.
Government support of a religion or religions is considered restrictive only when preferential treatment of one or more reli'
+ 'gious groups puts other religious groups at a disadvantage.'
/*	GRI_20_01	*/
union
select
 [k] = 	76	
,[t] = 
  'This question is a component of GRI.Q.20.
For GRI.Q.20.1, the differences between the coding periods may not be as substantial as they appear due to minor changes in '
+ 'coding procedures.'
/*	GRI_20_02	*/
union
select
 [k] = 	89	
,[t] = 
  'This question is a component of GRI.Q.20.'
/*	GRI_20_03_top	*/
union
select
 [k] = 	926	
,[t] = 
  'This question is a component of GRI.Q.20.
This is a summary variable that puts the restrictions identified in Questions 20.3a-c into a single measure indicating the l'
+ 'evel to which a government supports religious groups in the country.
Government support of a religion or religions is considered restrictive only when preferential treatment of one or more reli'
+ 'gious groups puts other religious groups at a disadvantage.'
/*	GRI_20_03_a	*/
union
select
 [k] = 	91	
,[t] = 
  'This question is a component of GRI.Q.20.3.'
/*	GRI_20_03_b	*/
union
select
 [k] = 	93	
,[t] = 
  'This question is a component of GRI.Q.20.3.'
/*	GRI_20_03_c	*/
union
select
 [k] = 	95	
,[t] = 
  'This question is a component of GRI.Q.20.3.'
/*	GRI_20_04	*/
union
select
 [k] = 	98	
,[t] = 
  'This question is a component of GRI.Q.20.'
/*	GRI_20_05	*/
union
select
 [k] = 101	
,[t] = 
  'This question is a component of GRI.Q.20.'
/*	SHI_01	*/
union
select
 [k] = 935	
,[t] = 
  'This is a summary variable that captures the hostilities identified in questions 1.a-f into a single measure indicating t'
+ 'he severity of religious hatred or bias in each country.
If one type of hostility occurred the country received 1/6 point for that year. Countries can have multiple types of hostili'
+ 'ties. The scores on this question are cumulative; a country with three types of malicious acts would score 0.50 for that '
+ 'period and a country with all six types in any of both years would score 1.00.'
/*	SHI_01_a_dummy	*/
union
select
 [k] = 936	
,[t] = 
  'This question is a component of SHI.Q.1.'
/*	SHI_01_b_dummy	*/
union
select
 [k] = 937	
,[t] = 
  'This question is a component of SHI.Q.1.'
/*	SHI_01_c_dummy	*/
union
select
 [k] = 938	
,[t] = 
  'This question is a component of SHI.Q.1.'
/*	SHI_01_d_dummy	*/
union
select
 [k] = 939	
,[t] = 
  'This question is a component of SHI.Q.1.'
/*	SHI_01_e_dummy	*/
union
select
 [k] = 940	
,[t] = 
  'This question is a component of SHI.Q.1.'
/*	SHI_01_f_dummy	*/
union
select
 [k] = 941	
,[t] = 
  'This question is a component of SHI.Q.1.'
/*	SHI_03	*/
union
select
 [k] = 190	
,[t] = 
  'Sectarian or communal violence involves two or more religious groups facing off in repeated clashes.'
/*	SHI_04	*/
union
select
 [k] = 192	
,[t] = 
  'Religion-related terrorism is defined as politically motivated violence agaisnt noncombatants by subnational groups or cl'
+ 'andestine agents with a religious justification or intent.'
--- 'Some of the increase in religion-related terrorism between the year ending in June 2007 and the year ending in December --- '2012 could reflect the use of new source material providing greater detail on terrorist activities than was provided by--- 'sources used in the baseline report./*	SHI_05	*/
union
select
 [k] = 207	
,[t] = 
  'Religion-related war is defined as armed conflict (involving sustained casualties over time or more than 1,000 battle dea'
+ 'ths) in which religious rhetoric is commonly employed to justify the use of force, or in which one or more of the combata'
+ 'nts primarily identifies itself or the opposing side by religion.'
--- 'Some of the increase shown above for 2012 reflects ongoing displacements that were not coded prior to 2011, including the--- ' religion-related conflicts in such places as Cyprus./*	SHI_06	*/
union
select
 [k] = 220	
,[t] = 
  'The data for each year also take into account information from the two previous years.'
/*	SHI_07	*/
union
select
 [k] = 222	
,[t] = 
  'The data for each year also take into account information from the two previous years.'
/*	SHI_08	*/
union
select
 [k] = 224	
,[t] = 
  'The data for each year also take into account information from the two previous years.'
/*	SHI_09	*/
union
select
 [k] = 226	
,[t] = 
  'The data for each year also take into account information from the two previous years.'
/*	SHI_10	*/
union
select
 [k] = 228	
,[t] = 
  'The data for each year also take into account information from the two previous years.'
/*	SHI_11_for_index	*/
union
select
 [k] = 913	
,[t] = 
  'The data for each year also take into account information from the two previous years.
Figures for the year ending in December 2013 have been updated to correct a minor error in the previous report.'
/*	SHI_12	*/
union
select
 [k] = 233	
,[t] = 
  'The data for each year also take into account information from the two previous years.'
/*	SHI_13	*/
union
select
 [k] = 235	
,[t] = 
  'The data for each year also take into account information from the two previous years.'
/*------------------------------------------------------------------------------------------------------------------------*/
           ) DDTT
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/



/**************************************************************************************************************************/
/*****                                                    STEP 002                                                    *****/
/**************************************************************************************************************************/
-- check results                                                                                                          --
	select * from                         [Pew_Question_Attributes]            /* test statement...                       */
WHERE                                                                          /* filters...                              */
             [attk]                    = 'XNote_RbyC'                          /*            filter condition             */
/**************************************************************************************************************************/










----SELECT 
----       [Question_abbreviation_std]
----      ,[Question_Std_pk]
----	  ,[attr]
----      ,[Question_Attributes_pk]
----	  --,[attk]
----  FROM [forum].[dbo].[Pew_Question_Attributes] A
----     , [forum].[dbo].[Pew_Question_Std]        Q
----where
----       [Question_Std_fk] = [Question_Std_pk]
----  and 
----       [attk] like 'XNote%'

----order by [Question_abbreviation_std]
----        ,[attk]
