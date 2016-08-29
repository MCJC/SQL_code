/*****************************************************************************************************************************************/
USE [forum]
GO
/*****************************************************************************************************************************************/
/*****                                                     BackUp  current Table                                                     *****/
/*****************************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT *
--                INTO  [_bk_forum].[dbo].[Pew_Answer_NoStd_' + @CrDt + ']
--                FROM      [forum].[dbo].[Pew_Answer_NoStd]'               )
/*****************************************************************************************************************************************/
/* update data */
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--Afghanistan changes for 2014:
--   -> GRI_04:  change to 1 (is currently 0.67)

--	UPDATE     [forum].[dbo].[Pew_Answer_NoStd]
--	SET        [forum].[dbo].[Pew_Answer_NoStd].[Answer_value_NoStd]  = 1.00
--	       ,   [forum].[dbo].[Pew_Answer_NoStd].[Answer_Std_fk]       = 10015
--	select * from   [forum]..[Pew_Answer_NoStd]
WHERE
               [forum].[dbo].[Pew_Answer_NoStd].[Answer_pk]           = 32616
		AND                                     [Answer_Wording]   LIKE 'Reports regularly arise%'
        AND                                     [Question_fk]         = 1780
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--Afghanistan changes for 2014:
--   -> GRI_16: add in this text to coder note, no change to score-

--	UPDATE     [forum].[dbo].[Pew_Answer_NoStd]
--	SET        [forum].[dbo].[Pew_Answer_NoStd].[Answer_Wording]      = [Answer_Wording]
--	                                                                   +' The General Directorate of Fatwas and Accounts under the Su'
--																	   +'preme Court ruled in May 2007 that the Bahai Faith was disti'
--																	   +'nct from Islam and a form of blasphemy. The ruling held that'
--																	   +' all Muslims who converted to the Bahai Faith were apostates'
--																	   +' and all Bahais were infidels. The ruling creates uncertaint'
--																	   +'ies for the country’s small Bahai population, particularly on'
--																	   +' the question of marriages between Bahai women and Muslim men'
--																	   +'. Citizens who convert from Islam to the Bahai Faith risk per'
--																	   +'secution, similar to Christian converts, in theory up to and '
--																	   +'including the death penalty. (IRF 2013)'
--	select * from   [forum]..[Pew_Answer_NoStd]
WHERE
               [forum].[dbo].[Pew_Answer_NoStd].[Answer_pk]           = 33452
		AND                                     [Answer_value_NoStd]  = 0.33
		AND                                     [Answer_Wording]   LIKE '"The government banned the pan-Islamic movement Hizb%'
		AND                                     [Answer_Std_fk]       = 10053
        AND                                     [Question_fk]         = 1813
/*---------------------------------------------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------*/
/* add data */
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--Afghanistan changes for 2014:
--GRI_17: Change to 1 (currently at 0). Add in below text-

--	INSERT INTO             [forum].[dbo].[Pew_Answer_NoStd]
SELECT [Answer_pk]                  =  1
                                      + (SELECT DISTINCT MAX([Answer_pk])
                                         FROM [forum]..[Pew_Answer_NoStd])
      ,[Answer_value_NoStd]
      ,[Answer_Wording]             =  'The General Directorate of Fatwas and Accounts under the Su'
									 +'preme Court ruled in May 2007 that the Bahai Faith was disti'
									 +'nct from Islam and a form of blasphemy. The ruling held that'
									 +' all Muslims who converted to the Bahai Faith were apostates'
									 +' and all Bahais were infidels. The ruling creates uncertaint'
									 +'ies for the country’s small Bahai population, particularly o'
									 +'n the question of marriages between Bahai women and Muslim m'
									 +'en. Citizens who convert from Islam to the Bahai Faith risk '
									 +'persecution, similar to Christian converts, in theory up to '
									 +'and including the death penalty. (IRF 2013)'
      ,[Answer_Std_fk]
      ,[Question_fk]
  FROM [forum]..[Pew_Answer_NoStd]
 WHERE [Answer_pk]                  =   33520
/*****************************************************************************************************************************************/
/*****************************************************************************************************************************************/

/*****************************************************************************************************************************************/
/*****                                                     BackUp current  Table                                                     *****/
/*****************************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT *
--                INTO  [_bk_forum].[dbo].[Pew_Nation_Answer_' + @CrDt + ']
--                FROM      [forum].[dbo].[Pew_Nation_Answer]'               )
/*****************************************************************************************************************************************/
/* update data */
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--	UPDATE     [forum].[dbo].[Pew_Nation_Answer]
--	SET        [forum].[dbo].[Pew_Nation_Answer].[Answer_fk]         = 36720
/*---------------------------------------------------------------------------------------------------------------------------------------*/
--	select * from   [forum]..[Pew_Nation_Answer]
 WHERE
             [forum].[dbo].[Pew_Nation_Answer].[Nation_answer_pk]  = 170015
       AND   [forum].[dbo].[Pew_Nation_Answer].[Nation_fk]         = 1
       AND   [forum].[dbo].[Pew_Nation_Answer].[Answer_fk]         = 33514
       AND   [forum].[dbo].[Pew_Nation_Answer].[display]           = 0
/*****************************************************************************************************************************************/
/*****************************************************************************************************************************************/


SELECT 
       [link_fk]
      ,[Question_fk]
      ,[Answer_fk]
      ,[Nation_fk]
      ,[QA_std]
      ,[Answer_value]
      ,[answer_wording_std]
      ,[answer_wording]
  FROM [forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]
where  [Question_Year]      = 2014
  and  [Ctry_EditorialName] = 'Afghanistan'
  and  [QA_std]
IN ( 'GRI_04', 'GRI_16', 'GRI_17' )

SELECT * FROM
[forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
where  [Question_Year]      = 2014
  and  [Ctry_EditorialName] = 'Afghanistan'
  and  [QA_std]
IN ( 'GRI_04', 'GRI_16', 'GRI_17' )





/*
169997	1780	32616	1	GRI_04	0.67	Yes, in many cases                          	Reports regularly arise of Afgha...
170013	1813	33452	1	GRI_16	0.33	Yes, security reasons stated as rationale   	"The government banned the pan-I...
170015	1815	33514	1	GRI_17	0.00	No                                          	No description coded
*/
