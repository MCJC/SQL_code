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
           , [attk]                    = 'RbyC_scale'                          /* -                                       */
           , [attr]                    = [t]                                   /* -                                       */
/*------------------------------------------------------------------------------------------------------------------------*/
      FROM
           (
/*------------------------------------------------------------------------------------------------------------------------*/
/*	GRI.01	*/

select
 [k] = 	1	
,[t] = 
'
-    0 points  0.00 Yes
-  1/2 point   0.50 The constitution or basic law does not specifically provide for freedom of religion but does protect some religious practices
- Full point   1.00 No	
'
/*	GRI.02	*/
union
select
 [k] = 	7	
,[t] = 
'
-    0 points  0.00 No
-  1/3 point   0.33 Yes, there is a qualification
-  2/3 point   0.67 Yes, there is a substantial contradiction and only some religious practices are protected
- Full point   1.00 Religious freedom is not provided in the first place	
'
/*	GRI.03	*/
union
select
 [k] = 	9	
,[t] = 
'
-    0 points  0.00 National laws and policies provide for religious freedom, and the national government respects religious freedom in practice
-  1/3 point   0.33 National laws and policies provide for religious freedom, and the national government generally respects religious freedom in practice; but there are some instances 
                    (e.g., in certain localities) where religious freedom is not respected in practice
-  2/3 point   0.67 There are limited national legal protections for religious freedom, but the national government does not generally respect religious freedom in practice
- Full point   1.00 National laws and policies do not provide for religious freedom and the national government does not respect religious freedom in practice	
'
/*	GRI.04	*/
union
select
 [k] = 	11	
,[t] = 
'
-    0 points  0.00 No
-  1/3 point   0.33 Yes, in a few cases
-  2/3 point   0.67 Yes, in many cases
- Full point   1.00 Government prohibits worship or religious practices of one or more religious groups as a general policy	
'
/*	GRI.05	*/
union
select
 [k] = 	13	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, for some religious groups
- Full point   1.00 Yes, for all religious groups	
'
/*	GRI.06	*/
union
select
 [k] = 	15	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, for some religious groups
- Full point   1.00 Yes, for all religious groups	
'
/*	GRI.07	*/
union
select
 [k] = 	17	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	GRI.08	*/
union
select
 [k] = 	911	
,[t] = 
'
	-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	GRI.09	*/
union
select
 [k] = 	21	
,[t] = 
'
-    0 points  0.00 Yes
-  1/2 point   0.50 Yes, but with restrictions
- Full point   1.00 No	
'
/*	GRI.10	*/
union
select
 [k] = 	23	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	GRI.11	*/
union
select
 [k] = 	28	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, there was limited intimidation
- Full point   1.00 Yes, there was widespread intimidation	
'
/*	GRI.12	*/
union
select
 [k] = 	48	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	GRI.13	*/
union
select
 [k] = 	50	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	GRI.14	*/
union
select
 [k] = 	52	
,[t] = 
'
-    0 points  0.00 No
-  1/3 point   0.33 No, but the government consults a nongovernmental religious advisory board
-  2/3 point   0.67 Yes, but the organization is noncoercive toward religious groups
- Full point   1.00 Yes, and the organization is coercive toward religious groups	
'
/*	GRI.15	*/
union
select
 [k] = 	54	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	GRI.16	*/
union
select
 [k] = 	56	
,[t] = 
'
-    0 points  0.00 No
-  1/3 point   0.33 Yes: Security reasons stated as rationale
-  2/3 point   0.67 Yes: Nonsecurity reasons stated as rationale
- Full point   1.00 Yes: Both security and nonsecurity reasons stated as rationale	
'
/*	GRI.17	*/
union
select
 [k] = 	59	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	GRI.18	*/
union
select
 [k] = 	61	
,[t] = 
'
-    0 points  0.00 No
-  1/3 point   0.33 Yes, but in a nondiscriminatory way
-  2/3 point   0.67 Yes, and the process adversely affects the ability of some religious groups to operate
- Full point   1.00 Yes, and the process clearly discriminates against some religious groups	
'
/*	GRI.19	*/
union
select
 [k] = 	63	
,[t] = 
'
-    0 points  0.00 No
-  1/5 point   0.20 Yes, 1-9 cases of government force
-  2/5 point   0.40 Yes, 10-200 cases of government force
-  3/5 point   0.60 Yes, 201-1,000 cases of government force
-  4/5 point   0.80 Yes, 1,001-9,999 cases of government force
- Full point   1.00 Yes, 10,000+ cases of government force	
'
/*	GRI.20	*/
union
select
 [k] = 	925	
,[t] = 
'
-        0 points  0.00 No
     + 1/5 point   0.20 Yes, the country''s constitution or basic law recognizes a favored religion or religions (see GRI.Q.20.1)
     + 1/5 point   0.20 Yes, one or more religious groups have privileges or government access unavailable to other religious groups (see GRI.Q.20.2)
     + 1/5 point   0.20 Yes, the government provides funds or other resources to one or more religious groups (see GRI.Q.20.3)
     + 1/5 point   0.20 Yes, religious education is required in public schools by local governments or the national government (see GRI.Q.20.4)
     + 1/5 point   0.20 Yes, the national government defers in some way to religious authorities, texts or doctrines on legal issues (see GRI.Q.20.5)	
'
/*	GRI.20.01	*/
union
select
 [k] = 	76	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	GRI.20.02	*/
union
select
 [k] = 	89	
,[t] = 
'
-    0 points  0.00 All religious groups are generally treated the same
-  1/4 point   0.25 Some religious groups have minimal privileges unavailable to other religious groups, limited to things such as inheriting buildings or properties
-  2/4 point   0.50 Some religious groups have general privileges or government access unavailable to other religious groups
-  3/4 point   0.75 One religious group has privileges or government access unavailable to other religious groups, but it is not recognized as the country''s official religion
- Full point   1.00 One religious group has privileges or government access unavailable to other religious groups, and it is recognized by the national government as the official religion	
'
/*	GRI.20.03	*/
union
select
 [k] = 	926	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, but with no obvious favoritism to a particular group or groups
- Full point   1.00 Yes, and with obvious favoritism to a particular group or groups	
'
/*	GRI.20.03.a	*/
union
select
 [k] = 	91	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, but with no obvious favoritism to a particular group or groups
- Full point   1.00 Yes, and with obvious favoritism to a particular group or groups	
'
/*	GRI.20.03.b	*/
union
select
 [k] = 	93	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, but with no obvious favoritism to a particular group or groups
- Full point   1.00 Yes, and with obvious favoritism to a particular group or groups	
'
/*	GRI.20.03.c	*/
union
select
 [k] = 	95	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, but with no obvious favoritism to a particular group or groups
- Full point   1.00 Yes, and with obvious favoritism to a particular group or groups	
'
/*	GRI.20.04	*/
union
select
 [k] = 	98	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, by at least some local governments
- Full point   1.00 Yes, by the national government	
'
/*	GRI.20.05	*/
union
select
 [k] = 	101	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.01	*/
union
select
 [k] = 	935	
,[t] = 
'
-        0 points  0.00 No
     + 1/6 point   0.17 Yes, harassment/intimidation (see SHI.Q.1.a)
     + 1/6 point   0.17 Yes, property damage (see SHI.Q.1.b)
     + 1/6 point   0.17 Yes, detentions/abductions (see SHI.Q.1.c)
     + 1/6 point   0.17 Yes, displacement from homes (see SHI.Q.1.d)
     + 1/6 point   0.17 Yes, physical assaults (see SHI.Q.1.e)
     + 1/6 point   0.17 Yes, deaths (see SHI.Q.1.f)	
'
/*	SHI.01.a	*/
union
select
 [k] = 	936	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.01.b	*/
union
select
 [k] = 	937	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.01.c	*/
union
select
 [k] = 	938	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.01.d	*/
union
select
 [k] = 	939	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.01.e	*/
union
select
 [k] = 	940	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.01.f	*/
union
select
 [k] = 	941	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.02	*/
union
select
 [k] = 	187	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, but there were no deaths reported
- Full point   1.00 Yes, and there were deaths reported	
'
/*	SHI.03	*/
union
select
 [k] = 	190	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.04	*/
union
select
 [k] = 	192	
,[t] = 
'
-    0 points  0.00 No
-  1/4 point   0.25 Yes, but their activity was limited to recruitment or fundraising
-  2/4 point   0.50 Yes, with violence that resulted in some casualties (1-9 injuries or deaths)
-  3/4 point   0.75 Yes, with violence that resulted in multiple casualties (10-50 injuries or deaths)
- Full point   1.00 Yes, with violence that resulted in many casualties (more than 50 injuries or deaths)	
'
/*	SHI.05	*/
union
select
 [k] = 	207	
,[t] = 
'
-    0 points  0.00 No
-  1/4 point   0.25 Yes, with fewer than 10,000 casualties or people displaced
-  2/4 point   0.50 Yes, with tens of thousands of casualties or people displaced
-  3/4 point   0.75 Yes, with hundreds of thousands of casualties or people displaced
- Full point   1.00 Yes, with millions of casualties or people displaced	
'
/*	SHI.06	*/
union
select
 [k] = 	220	
,[t] = 
'
-    0 points  0.00 No
-  1/3 point   0.33 There were public tensions between religious groups, but they fell short of hostilities involving physical violence
-  2/3 point   0.67 Yes, with physical violence in a few cases
- Full point   1.00 Yes, with physical violence in numerous cases	
'
/*	SHI.07	*/
union
select
 [k] = 	222	
,[t] = 
'
-    0 points  0.00 No
-  1/3 point   0.33 Yes, at the local level
-  2/3 point   0.67 Yes, at the regional level
- Full point   1.00 Yes, at the national level	
'
/*	SHI.08	*/
union
select
 [k] = 	224	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.09	*/
union
select
 [k] = 	226	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.10	*/
union
select
 [k] = 	228	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.11	*/
union
select
 [k] = 	913	
,[t] = 
'
-    0 points  0.00 No
- Full point   1.00 Yes	
'
/*	SHI.12	*/
union
select
 [k] = 	233	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, but they fell short of physical violence
- Full point   1.00 Yes, and they included physical violence	
'
/*	SHI.13	*/
union
select
 [k] = 	235	
,[t] = 
'
-    0 points  0.00 No
-  1/2 point   0.50 Yes, but they fell short of physical violence
- Full point   1.00 Yes, and they included physical violence	
'
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
             [attk]                    = 'RbyC_scale'                          /*            filter condition             */
/**************************************************************************************************************************/
