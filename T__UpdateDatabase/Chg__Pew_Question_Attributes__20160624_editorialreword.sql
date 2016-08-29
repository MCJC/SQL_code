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
-- Update
UPDATE
                            [forum].[dbo].[Pew_Question_Attributes]
SET
                            [forum].[dbo].[Pew_Question_Attributes].[attr] = 
'
For some of the components below, coders may assign partial values
-        0 points  0.00 No
     + 1/5 point   0.20 Yes, the country''s constitution or basic law recognizes a favored religion or religions (see GRI.Q.20.1)
     + 1/5 point   0.20 Yes, one or more religious groups have privileges or government access unavailable to other religious groups (see GRI.Q.20.2)
     + 1/5 point   0.20 Yes, the government provides funds or other resources to one or more religious groups (see GRI.Q.20.3)
     + 1/5 point   0.20 Yes, religious education is required in public schools by local governments or the national government (see GRI.Q.20.4)
     + 1/5 point   0.20 Yes, the national government defers in some way to religious authorities, texts or doctrines on legal issues (see GRI.Q.20.5)	
'
/*------------------------------------------------------------------------------------------------------------------------*/
--   select * FROM [forum].[dbo].[Pew_Question_Attributes]                                                            AS mydbt
/*------------------------------------------------------------------------------------------------------------------------*/
WHERE
       [Question_Attributes_pk]     =  1330
  AND  [Question_Std_fk]            =   925
  AND  [attk]                       =  'RbyC_scale'
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
-- check results                                                                                                          --
	select * from                         [Pew_Question_Attributes]            /* test statement...                       */
WHERE                                                                          /* filters...                              */
       [Question_Attributes_pk]     =  1330                                    /*            filter condition             */
/**************************************************************************************************************************/



/**************************************************************************************************************************/
-- Update
UPDATE
                            [forum].[dbo].[Pew_Question_Attributes]
SET
                            [forum].[dbo].[Pew_Question_Attributes].[attr] = 
'This question is a component of GRI.Q.20.
For GRI.Q.20.1, the differences between the coding periods may not be as substantial as they appear due to minor changes in coding procedures.'
/*------------------------------------------------------------------------------------------------------------------------*/
--   select * FROM [forum].[dbo].[Pew_Question_Attributes]                                                            AS mydbt
/*------------------------------------------------------------------------------------------------------------------------*/
WHERE
       [Question_Attributes_pk]     =   230
  AND  [Question_Std_fk]            =    76
  AND  [attk]                       =  'XNote01'
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
-- check results                                                                                                          --
	select * from                         [Pew_Question_Attributes]            /* test statement...                       */
WHERE                                                                          /* filters...                              */
       [Question_Attributes_pk]     =   230                                    /*            filter condition             */
/**************************************************************************************************************************/



/**************************************************************************************************************************/
-- Update
UPDATE
                            [forum].[dbo].[Pew_Question_Attributes]
SET
                            [forum].[dbo].[Pew_Question_Attributes].[attr] = 
'Religion-related war is defined as armed conflict (involving sustained casualties over time or more than 1,000 battle deaths) in which religious rhetoric is commonly employed to justify the use of force, or in which one or more of the combatants primarily identifies itself or the opposing side by religion.'
/*------------------------------------------------------------------------------------------------------------------------*/
--   select * FROM [forum].[dbo].[Pew_Question_Attributes]                                                            AS mydbt
/*------------------------------------------------------------------------------------------------------------------------*/
WHERE
       [Question_Attributes_pk]     =  1103
  AND  [Question_Std_fk]            =   951
  AND  [attk]                       =  'XNote01'
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
-- check results                                                                                                          --
	select * from                         [Pew_Question_Attributes]            /* test statement...                       */
WHERE                                                                          /* filters...                              */
       [Question_Attributes_pk]     =  1103                                    /*            filter condition             */
/**************************************************************************************************************************/



