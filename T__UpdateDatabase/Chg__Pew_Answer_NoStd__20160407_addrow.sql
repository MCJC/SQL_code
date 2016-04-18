/**************************************************************************************************************************/
			--SELECT *
			--  FROM [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
			--WHERE  [QA_std] like  'SHI_11%'
			--	and    [Nation_fk]      in ( 55, 156)
			--	and    [Question_Year]  = 2013
			----	and    [Answer_value]   = 0.50
			--order by
			-- [QA_std]
			--,[Nation_fk]
			--SELECT *
			--  FROM [forum].[dbo].[Pew_Nation_Answer]
			--where
			--	   [Nation_answer_pk] in 
			--(
			--147139,
			--159687
			----147140,
			----159688
			--)
/**************************************************************************************************************************/


/**************************************************************************************************************************/
/*****                                              BackUp current Table                                              *****/
/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT *
--                INTO  [_bk_forum].[dbo].[Pew_Answer_NoStd_' + @CrDt + 'b]
--                FROM      [forum].[dbo].[Pew_Answer_NoStd]'               )
/**************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' SELECT *
--                INTO  [_bk_forum].[dbo].[Pew_Nation_Answer_' + @CrDt + 'b]
--                FROM      [forum].[dbo].[Pew_Nation_Answer]'               )
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/* add data */
--	INSERT INTO             [forum].[dbo].[Pew_Answer_NoStd]
SELECT [Answer_pk]                  =  1
                                      + (SELECT DISTINCT MAX([Answer_pk])
                                         FROM [forum]..[Pew_Answer_NoStd])
      ,[Answer_value_NoStd]
      ,[Answer_Wording]             = 'In May Dansk supermarket amended its policy regarding religious head coverings'
                                     +' to allow employees to wear head coverings if they follow a recognized religio'
                                     +'n. (IRF 2013) [Coder Note: Before May, religious head coverings were prohibite'
                                     +'d][DataManager Note: wording copied from answer to SHI_11_x to correct error]'
      ,[Answer_Std_fk]
      ,[Question_fk]
  FROM [forum]..[Pew_Answer_NoStd]
 WHERE [Answer_pk]                  =   31759
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/* update data */
/*------------------------------------------------------------------------------------------------------------------------*/
--	UPDATE     [forum].[dbo].[Pew_Nation_Answer]
--	SET        [forum].[dbo].[Pew_Nation_Answer].[Answer_fk]         = 31807
/*------------------------------------------------------------------------------------------------------------------------*/
	select * from   [forum]..[Pew_Nation_Answer]
WHERE
           [forum].[dbo].[Pew_Nation_Answer].[Nation_answer_pk]  = 147140
     AND   [forum].[dbo].[Pew_Nation_Answer].[Nation_fk]         = 55
     AND   [forum].[dbo].[Pew_Nation_Answer].[Answer_fk]         = 31806
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
--	UPDATE   [forum].[dbo].[Pew_Nation_Answer]
--	SET      [forum].[dbo].[Pew_Nation_Answer].[Answer_fk]         = ( SELECT [Answer_pk]
--	                                                                     FROM [forum]..[Pew_Answer_NoStd]
--	                                                                    WHERE [Answer_value_NoStd] =    1
--	                                                                      AND [Answer_Wording]     LIKE 'In May Dansk%'
--	                                                                      AND [Answer_Std_fk]      =    10021
--	                                                                      AND [Question_fk]        =    1736           )
/*------------------------------------------------------------------------------------------------------------------------*/
	select * from [forum]..[Pew_Nation_Answer]
 WHERE
             [forum].[dbo].[Pew_Nation_Answer].[Nation_answer_pk]  = 147139
       AND   [forum].[dbo].[Pew_Nation_Answer].[Nation_fk]         = 55
       AND   [forum].[dbo].[Pew_Nation_Answer].[Answer_fk]         = 31753
/*------------------------------------------------------------------------------------------------------------------------*/
