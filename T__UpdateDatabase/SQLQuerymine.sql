  USE [forum]
GO
/**********************************************************************************************************************************************************/
/**********************************************************************************************************************************************************/
/*****                                              BackUp current Tables                                                                             *****/
/**********************************************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT *
--                  INTO  [_bk_forum].[dbo].[Pew_Answer_NoStd_' + @CrDt + ']
--                  FROM      [forum].[dbo].[Pew_Answer_NoStd]'               )
/**********************************************************************************************************************************************************/
/**********************************************************************************************************************************************************/
--- 5 records to be added
WITH
     VTS AS  ---- REPLACE VALUE & TEXT, as well as link to StdAnswer
(
          SELECT C = 2011, D=  'GRI_02',      E = 0.67,     F = 0.33,  B =  'Uruguay'          , G =  'ARTICLE 10  Private actions of persons which do not in any way affect the public order or prejudice others shall be outside the jurisdiction of the magistrates. (CP 2016)'
UNION ALL SELECT C = 2012, D=  'GRI_02',      E = 0.67,     F = 0.33,  B =  'Uruguay'          , G =  'ARTICLE 10  Private actions of persons which do not in any way affect the public order or prejudice others shall be outside the jurisdiction of the magistrates. (CP 2016)'
UNION ALL SELECT C = 2013, D=  'GRI_02',      E = 0.67,     F = 0.33,  B =  'Uruguay'          , G =  'ARTICLE 10  Private actions of persons which do not in any way affect the public order or prejudice others shall be outside the jurisdiction of the magistrates. (CP 2016)'
UNION ALL SELECT C = 2014, D=  'GRI_02',      E = 0.67,     F = 0.33,  B =  'Uruguay'          , G =  'ARTICLE 10  Private actions of persons which do not in any way affect the public order or prejudice others shall be outside the jurisdiction of the magistrates. (CP 2016)'
UNION ALL SELECT C = 2014, D=  'GRI_11',      E = 0   ,     F = 1   ,  B =  'Equatorial Guinea', G =  'Some non-Catholic clergy, who also worked for the government as civil service employees, continued to report their supervisors strongly encouraged participation in religious activities related to their government positions, including attending Catholic masses. (IRF 2014)'
)
/**********************************************************************************************************************************************************/
/*  Update from CTE table:                          ------------------------------------------------------------------------------------------------------*/
--	INSERT INTO  [forum].[dbo].[Pew_Answer_NoStd]
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT           [Answer_pk]              = (   (SELECT MAX([Answer_pk]) FROM [forum]..[Pew_Answer_NoStd])
                                              + (ROW_NUMBER() OVER(ORDER BY [VTS].[C], [VTS].[D]))                     )
                ,[Answer_value_NoStd]     = [VTS].[F]
                ,[Answer_Wording]         = [VTS].[G]
                ,[Answer_Std_fk]          = [PAS].[Answer_Std_pk]
                ,[Question_fk]            = [ANS].[Question_fk]

--				, *
FROM
          [forum].[dbo].[Pew_Answer_NoStd]                               ANS
INNER
JOIN
          [forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]         EXT
   ON 
       EXT.[Answer_fk]
      =ANS.[Answer_pk]
INNER
JOIN
       [VTS]
   ON 
       VTS.[C]
      =EXT.[Question_Year]
  AND
       VTS.[D]
      =EXT.[QA_std]
  AND
       VTS.[B]
      =EXT.[Ctry_EditorialName]
INNER
JOIN
       [FORUM].[dbo].[Pew_Answer]                                        TPA
   ON 
       EXT.[Answer_fk]
      =TPA.[Answer_pk]

INNER
JOIN
       [FORUM].[dbo].[Pew_Answer_Std]                                    PAS
   ON 
       TPA.[AnswerSet_num]
      =PAS.[AnswerSet_number]
  AND
       VTS.[F]
      =PAS.[Answer_value_std]
/**********************************************************************************************************************************************************/
/**********************************************************************************************************************************************************/





/**********************************************************************************************************************************************************/
/**********************************************************************************************************************************************************/
/*****                                              BackUp current Tables                                                                             *****/
/**********************************************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT *
--                  INTO  [_bk_forum].[dbo].[Pew_Nation_Answer_' + @CrDt + ']
--                  FROM      [forum].[dbo].[Pew_Nation_Answer]'               )
/**********************************************************************************************************************************************************/
/**********************************************************************************************************************************************************/
--- 5 records to be updated
WITH
     VTS AS  ---- REPLACE VALUE & TEXT, as well as link to StdAnswer
(
          SELECT C = 2011, D=  'GRI_02',      E = 0.67,     F = 0.33,  B =  'Uruguay'          , G =  'ARTICLE 10  Private actions of persons which do not in any way affect the public order or prejudice others shall be outside the jurisdiction of the magistrates. (CP 2016)'
UNION ALL SELECT C = 2012, D=  'GRI_02',      E = 0.67,     F = 0.33,  B =  'Uruguay'          , G =  'ARTICLE 10  Private actions of persons which do not in any way affect the public order or prejudice others shall be outside the jurisdiction of the magistrates. (CP 2016)'
UNION ALL SELECT C = 2013, D=  'GRI_02',      E = 0.67,     F = 0.33,  B =  'Uruguay'          , G =  'ARTICLE 10  Private actions of persons which do not in any way affect the public order or prejudice others shall be outside the jurisdiction of the magistrates. (CP 2016)'
UNION ALL SELECT C = 2014, D=  'GRI_02',      E = 0.67,     F = 0.33,  B =  'Uruguay'          , G =  'ARTICLE 10  Private actions of persons which do not in any way affect the public order or prejudice others shall be outside the jurisdiction of the magistrates. (CP 2016)'
UNION ALL SELECT C = 2014, D=  'GRI_11',      E = 0   ,     F = 1   ,  B =  'Equatorial Guinea', G =  'Some non-Catholic clergy, who also worked for the government as civil service employees, continued to report their supervisors strongly encouraged participation in religious activities related to their government positions, including attending Catholic masses. (IRF 2014)'
)
/**********************************************************************************************************************************************************/
/*  Update from CTE table:                          ------------------------------------------------------------------------------------------------------*/
--		UPDATE    [forum].[dbo].[Pew_Nation_Answer]
--		SET       [forum].[dbo].[Pew_Nation_Answer].[Answer_fk]      =  [ANS].[Answer_pk]
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
--------select  PNA.[Answer_fk], ANS.[Answer_pk], *
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
FROM
          [forum].[dbo].[Pew_Nation_Answer]                              PNA
INNER
JOIN
        ( SELECT * FROM
          [forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]
		  WHERE [Locality] = 'not detailed'
		    AND [Religion] = 'not detailed'                      )       EXT
   ON 
       EXT.[link_fk]
      =PNA.[Nation_answer_pk]
INNER
JOIN
       [VTS]
   ON 
       VTS.[C]
      =EXT.[Question_Year]
  AND
       VTS.[D]
      =EXT.[QA_std]
  AND
       VTS.[B]
      =EXT.[Ctry_EditorialName]
INNER
JOIN
       [FORUM].[dbo].[Pew_Answer]                                        TPA
   ON 
       EXT.[Answer_fk]
      =TPA.[Answer_pk]
INNER
JOIN
       [FORUM].[dbo].[Pew_Answer_Std]                                    PAS
   ON 
       TPA.[AnswerSet_num]
      =PAS.[AnswerSet_number]
  AND
       VTS.[F]
      =PAS.[Answer_value_std]
INNER
JOIN
          [forum].[dbo].[Pew_Answer_NoStd]                               ANS
   ON 
       VTS.[F]
      =ANS.[Answer_value_NoStd]
  AND
       VTS.[G]
      =ANS.[Answer_Wording]
  AND
       EXT.[Question_fk]
      =ANS.[Question_fk]
  AND
       PAS.[Answer_Std_pk]
      =ANS.[Answer_Std_fk]
/**********************************************************************************************************************************************************/
/**********************************************************************************************************************************************************/




/**********************************************************************************************************************************************************/
/**********************************************************************************************************************************************************/
--- 4 records to be updated
WITH
     VTS AS  ---- REPLACE VALUE & TEXT, as well as link to StdAnswer
(
          SELECT C = 2007, D=  'GRI_02',      E = 0.33,     F = 0   ,  B =  'Mozambique'       , G =  'ARTICLE 54. FREEDOM OF CONSCIENCE, RELIGION AND WORSHIP 1. All citizens shall have the freedom to practice or not to practice a religion. 2. Nobody shall be discriminated against, persecuted, prejudiced, deprived of his or her rights, or benefit from or be exempt from duties, on the grounds of his faith or religious persuasion or practice. 3. Religious denominations shall have the right to pursue their religious aims freely and to own and acquire assets for realising their objectives. 4. The protection of places of worship shall be ensured. 5. The right to conscientious objection shall be guaranteed in terms of the law.'
UNION ALL SELECT C = 2008, D=  'GRI_02',      E = 0.33,     F = 0   ,  B =  'Mozambique'       , G =  'ARTICLE 54. FREEDOM OF CONSCIENCE, RELIGION AND WORSHIP 1. All citizens shall have the freedom to practice or not to practice a religion. 2. Nobody shall be discriminated against, persecuted, prejudiced, deprived of his or her rights, or benefit from or be exempt from duties, on the grounds of his faith or religious persuasion or practice. 3. Religious denominations shall have the right to pursue their religious aims freely and to own and acquire assets for realising their objectives. 4. The protection of places of worship shall be ensured. 5. The right to conscientious objection shall be guaranteed in terms of the law.'
UNION ALL SELECT C = 2009, D=  'GRI_02',      E = 0.33,     F = 0   ,  B =  'Mozambique'       , G =  'ARTICLE 54. FREEDOM OF CONSCIENCE, RELIGION AND WORSHIP 1. All citizens shall have the freedom to practice or not to practice a religion. 2. Nobody shall be discriminated against, persecuted, prejudiced, deprived of his or her rights, or benefit from or be exempt from duties, on the grounds of his faith or religious persuasion or practice. 3. Religious denominations shall have the right to pursue their religious aims freely and to own and acquire assets for realising their objectives. 4. The protection of places of worship shall be ensured. 5. The right to conscientious objection shall be guaranteed in terms of the law.'
UNION ALL SELECT C = 2010, D=  'GRI_02',      E = 0.33,     F = 0   ,  B =  'Mozambique'       , G =  'ARTICLE 54. FREEDOM OF CONSCIENCE, RELIGION AND WORSHIP 1. All citizens shall have the freedom to practice or not to practice a religion. 2. Nobody shall be discriminated against, persecuted, prejudiced, deprived of his or her rights, or benefit from or be exempt from duties, on the grounds of his faith or religious persuasion or practice. 3. Religious denominations shall have the right to pursue their religious aims freely and to own and acquire assets for realising their objectives. 4. The protection of places of worship shall be ensured. 5. The right to conscientious objection shall be guaranteed in terms of the law.'
)
/**********************************************************************************************************************************************************/
/*  Update from CTE table:                          ------------------------------------------------------------------------------------------------------*/
--		UPDATE    [forum].[dbo].[Pew_Nation_Answer]
--		SET       [forum].[dbo].[Pew_Nation_Answer].[Answer_fk]      =  [ANS].[Answer_pk]
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
--------select  PNA.[Answer_fk], ANS.[Answer_pk], *
--------select                                    *
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
FROM
          [forum].[dbo].[Pew_Nation_Answer]                              PNA
INNER
JOIN
        ( SELECT * FROM
          [forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]
		  WHERE [Locality] = 'not detailed'
		    AND [Religion] = 'not detailed'                      )       EXT
   ON 
       EXT.[link_fk]
      =PNA.[Nation_answer_pk]
INNER
JOIN
       [VTS]
   ON 
       VTS.[C]
      =EXT.[Question_Year]
  AND
       VTS.[D]
      =EXT.[QA_std]
  AND
       VTS.[B]
      =EXT.[Ctry_EditorialName]
INNER
JOIN
       [FORUM].[dbo].[Pew_Answer]                                        TPA
   ON 
       EXT.[Answer_fk]
      =TPA.[Answer_pk]
INNER
JOIN
       [FORUM].[dbo].[Pew_Answer_Std]                                    PAS
   ON 
       TPA.[AnswerSet_num]
      =PAS.[AnswerSet_number]
  AND
       VTS.[F]
      =PAS.[Answer_value_std]
INNER
JOIN
          [forum].[dbo].[Pew_Answer_NoStd]                               ANS
   ON 
       VTS.[F]
      =ANS.[Answer_value_NoStd]
  AND
       EXT.[Question_fk]
      =ANS.[Question_fk]
  AND
       PAS.[Answer_Std_pk]
      =ANS.[Answer_Std_fk]
/**********************************************************************************************************************************************************/
/**********************************************************************************************************************************************************/


