USE [RLS]
GO
/******     Object:  View [Displayable_New_Q_and_A_Wordings]     **********************************************************************/
/**************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************************************************************************************************/
ALTER VIEW             [dbo].[Displayable_New_Q_and_A_Wordings]
AS
/**************************************************************************************************************************************/
/**************************************************************************************************************************************/
SELECT
       [NQA_pk]                     = ROW_NUMBER()
                                            OVER(
                                        ORDER BY  
                                                [RLS_FieldName]
                                              , [A_Value]        )
/*------------------------------------------------------------------------------------------------------------------------------------*/
      ,[WideVer_FieldName]        = [RLS_FieldName]
      ,[Q_Wording_to_Display]     = [Q_Label_to_Display]
      ,[A_Wording_to_Display]
      ,[A_Value]
      ,[Editorially_Checked]
      ,[Ans_SortOrder]
FROM
/**************************************************************************************************************************************/
(
/**************************************************************************************************************************************/
SELECT 
       [RLS_FieldName]            = [N]
      ,[Q_Label_to_Display]       = [L]
      ,[A_Wording_to_Display]     = '- - -'
      ,[A_Value]                  = [V]
      ,[Editorially_Checked]      = '- - -'
      ,[Ans_SortOrder]            = '- - -'
/*------------------------------------------------------------------------------------------------------------------------------------*/
FROM (
/*------------------------------------------------------------------------------------------------------------------------------------*/
      SELECT N = 'RLS_DNWV_pk'                     
	        ,L = 'principal key -- to sort cases'
			,V = '- - -'
UNION SELECT N = 'RLSx0_001_main_ID'
            ,L = 'main_ID: '
			     + CAST((SELECT COUNT(*) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' interviewees'
			,V = '- - -'
UNION SELECT N = 'RLSx1_001_year'
            ,L = 'Year'
			,V = CAST((SELECT COUNT(DISTINCT(SUBSTRING([SVY_psraid],3,4))) FROM [Pew_Survey_Respondent]) AS nvarchar)
                 + ' years of data'
UNION SELECT N = 'RLSx2_001_WEIGHT'
            ,L = 'National Weight'
			,V =   CAST((SELECT COUNT(DISTINCT([weight])) FROM [Pew_Survey_Respondent]) AS nvarchar)
                 + ' different weights ranking from '
			     + LEFT(CAST((SELECT ROUND(MIN([weight]), 1,2) FROM [Pew_Survey_Respondent]) AS nvarchar), 4)
                 + '  to '
			     + LEFT(CAST((SELECT ROUND(MAX([weight]), 1,2) FROM [Pew_Survey_Respondent]) AS nvarchar), 4)
UNION SELECT N = 'RLSx2_002_akhiweight2007'
            ,L = 'Weight including AK and HI cases (from WT_LAT)'
			,V =   CAST((SELECT COUNT(DISTINCT([weight_akhi2007])) FROM [Pew_Survey_Respondent]) AS nvarchar)
                 + ' different weights ranking from '
			     + LEFT(CAST((SELECT ROUND(MIN([weight_akhi2007]), 1,2) FROM [Pew_Survey_Respondent]) AS nvarchar), 4)
                 + '  to '
			     + LEFT(CAST((SELECT ROUND(MAX([weight_akhi2007]), 1,2) FROM [Pew_Survey_Respondent]) AS nvarchar), 4)
UNION SELECT N = 'RLSx2_003_WGT_all_MSA'
            ,L = 'Metro region specific weights'
			,V =   CAST((SELECT COUNT(DISTINCT([weight_all_MSA])) FROM [Pew_Survey_Respondent]) AS nvarchar)
                 + ' different weights ranking from '
			     + LEFT(CAST((SELECT ROUND(MIN([weight_all_MSA]), 1,2) FROM [Pew_Survey_Respondent]) AS nvarchar), 4)
                 + '  to '
			     + LEFT(CAST((SELECT ROUND(MAX([weight_all_MSA]), 1,2) FROM [Pew_Survey_Respondent]) AS nvarchar), 4)
/*------------------------------------------------------------------------------------------------------------------------------------*/
                                                                                                                        )  ID_and_Wght
/*------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************/
UNION ALL
/**************************************************************************************************************************************/
SELECT 
       [RLS_FieldName]            = [N]
      ,[Q_Label_to_Display]       = [L]
      ,[A_Wording_to_Display]     = [W]
      ,[A_Value]                  = [V]
      ,[Editorially_Checked]      = '- - -'
      ,[Ans_SortOrder]            = '- - -'
/*------------------------------------------------------------------------------------------------------------------------------------*/
FROM (
/*------------------------------------------------------------------------------------------------------------------------------------*/
      SELECT N = 'RLSx3_000_other_and_christian'
            ,L = 'Identifies members of non-Christian faiths, Christians, & Unaffil/D.K./Ref.'
	        ,W =   CAST((SELECT COUNT(DISTINCT([RLSx3_000_other_and_christian])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different categories'
			,V = '- - -'
UNION SELECT N = 'RLSx3_001_otherfaithfordisplay'
            ,L = 'Identifies members of non-Christian faiths (i.e., the following traditions:'
                +' Jewish, Muslim, Buddhist, Hindu, Other world religions, other faiths'
	        ,W =   CAST((SELECT COUNT(DISTINCT([RLSx3_001_otherfaithfordisplay])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different categories'
			,V = '- - -'
UNION SELECT N = 'RLSx3_002_christianfordisplay'
            ,L = 'Identifies Christians'
	        ,W =   CAST((SELECT COUNT(DISTINCT([RLSx3_002_christianfordisplay])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different categories'
			,V = '- - -'
UNION SELECT N = 'RLSx3_003_protestantfordisplay'
            ,L = 'Identifies Protestants'
	        ,W =   CAST((SELECT COUNT(DISTINCT([RLSx3_003_protestantfordisplay])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different categories'
			,V = '- - -'
UNION SELECT N = 'RLSx4_001_reltradfordisplay_v'
            ,L = 'RELTRAD values recoded for display on web and in report'
	        ,W = '- - -'
			,V =   CAST((SELECT COUNT(DISTINCT([RLSx4_001_reltradfordisplay_v])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different values'
UNION SELECT N = 'RLSx4_001_reltradfordisplay_w'
            ,L = 'RELTRAD wordings relabeled for display on web and in report'
	        ,W =   CAST((SELECT COUNT(DISTINCT([RLSx4_001_reltradfordisplay_w])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different categories'
			,V = '- - -'
UNION SELECT N = 'RLSx4_002_protfamfordisplay_v'
            ,L = 'PROTFAM values recoded for display on web and in report'
	        ,W = '- - -'
			,V =   CAST((SELECT COUNT(DISTINCT([RLSx4_002_protfamfordisplay_v])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different values'
UNION SELECT N = 'RLSx4_002_protfamfordisplay_w'
            ,L = 'PROTFAM relabeld for display on web and in report'
	        ,W =   CAST((SELECT COUNT(DISTINCT([RLSx4_002_protfamfordisplay_w])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different caegories'
			,V = '- - -'
UNION SELECT N = 'RLSx4_003_familyfordisplay_v'
            ,L = 'FAMILY values collapsed for display on web and in report'
	        ,W = '- - -'
			,V =   CAST((SELECT COUNT(DISTINCT([RLSx4_003_familyfordisplay_v])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different values'
UNION SELECT N = 'RLSx4_003_familyfordisplay_w'
            ,L = 'FAMILY wordings collapsed for display on web and in report'
	        ,W =   CAST((SELECT COUNT(DISTINCT([RLSx4_003_familyfordisplay_w])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different caegories'
			,V = '- - -'
UNION SELECT N = 'RLSx4_004_denomfordisplay2_v'
            ,L = 'DENOM values collapsed for display on web and in report version 2'
            ,W = '- - -'
			,V =   CAST((SELECT COUNT(DISTINCT([RLSx4_004_denomfordisplay2_v])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different values'
UNION SELECT N = 'RLSx4_004_denomfordisplay2_w'    
            ,L = 'DENOM wordings collapsed for display on web and in report version 2'
            ,W = CAST((SELECT COUNT(DISTINCT([RLSx4_004_denomfordisplay2_v])) FROM [__Displayable_NewWideVersion]) AS nvarchar)
                 + ' different caegories'
			,V = '- - -'
/*------------------------------------------------------------------------------------------------------------------------------------*/
                                                                                                                           )  Rel_Vars
/*------------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************/
UNION ALL
/**************************************************************************************************************************************/
SELECT 
/*------------------------------------------------------------------------------------------------------------------------------------*/
       [RLS_FieldName]              = [Question_abbreviation_std]
      ,[Q_Label_to_Display]         = [Question_short_wording_std]
      ,[A_Wording_to_Display]       = [Answer_Wording_std]
      ,[A_Value]
      ,[Editorially_Checked]
/*------------------------------------------------------------------------------------------------------------------------------------*/
      ,[Ans_SortOrder]                = 
	                                    REPLACE([A_value], '.00', '')
	                                  + ' out of '
                                      + CAST([NA_by_set_of_Answers] as nvarchar)
	                                  + ' answers'
/*------------------------------------------------------------------------------------------------------------------------------------*/
  FROM
/*------------------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------------------*/
(
/*------------------------------------------------------------------------------------------------------------------------------------*/
SELECT
/*------------------------------------------------------------------------------------------------------------------------------------*/
       DISTINCT
/*------------------------------------------------------------------------------------------------------------------------------------*/
       [Question_Std_fk]
      ,[Answer_value_Std]
/*------------------------------------------------------------------------------------------------------------------------------------*/
      ,[Question_abbreviation_std]
      ,[Question_short_wording_std]
      ,[Answer_Wording_std]
/*------------------------------------------------------------------------------------------------------------------------------------*/
      ,[A_Value]                    = CAST([Answer_value_Std] as nvarchar)
                                      --CASE 
                                      --    WHEN [Answer_value_Std]   IS NULL
                                      --    THEN [Answer_value_NoStd]
                                      --    ELSE [Answer_value_Std]
                                      -- END
      ,[NA_by_set_of_Answers]
/*------------------------------------------------------------------------------------------------------------------------------------*/
      ,[Editorially_Checked]        =   'Q:' 
                                      +  Q.[Editorially_Checked]
	                                  + '/' 
	                                  + 'A:' 
									  +  A.[Editorially_Checked]
/*------------------------------------------------------------------------------------------------------------------------------------*/
  FROM
/*------------------------------------------------------------------------------------------------------------------------------------*/
       [Pew_Question]                                                                      Q
/*------------------------------------------------------------------------------------------------------------------------------------*/
  FULL
  OUTER
   JOIN
/*------------------------------------------------------------------------------------------------------------------------------------*/
(
/*------------------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------------------*/
SELECT
/*------------------------------------------------------------------------------------------------------------------------------------*/
       *
  FROM
       [Pew_Answer_NoStd]
  FULL
  OUTER
   JOIN
       [Pew_Answer_Std]
/*------------------------------------------------------------------------------------------------------------------------------------*/
     ON
            Answer_Std_fk
         =  Answer_Std_pk
/*------------------------------------------------------------------------------------------------------------------------------------*/
)                                                                                                        A
/*------------------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------------------*/
ON
       [Question_fk]
      =[Question_pk]
/*------------------------------------------------------------------------------------------------------------------------------------*/
  LEFT
   JOIN
/*------------------------------------------------------------------------------------------------------------------------------------*/
       [Pew_Data_Source]                                                                   D
/*------------------------------------------------------------------------------------------------------------------------------------*/
ON
       [Data_Source_fk]
      =[Data_Source_pk]
/*------------------------------------------------------------------------------------------------------------------------------------*/
                                                                                                                                  )  QA
/**************************************************************************************************************************************/
                                                                                                                           ) AS ALLVARS
/**************************************************************************************************************************************/

GO
