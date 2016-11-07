------------------USE [Rbkup]
------------------GO

------------------/****** Object:  Table [dbo].[Pew_Question_Attribute]    Script Date: 4/12/2016 2:00:39 PM ******/
------------------SET ANSI_NULLS ON
------------------GO

------------------SET QUOTED_IDENTIFIER ON
------------------GO

------------------SET ANSI_PADDING ON
------------------GO

------------------CREATE TABLE [dbo].[Pew_Question_Attribute](
------------------	[VxQAttr] [bigint] NULL,
------------------	[Question_Std_fk] [int] NULL,
------------------	[Variable] [nvarchar](128) NULL,
------------------	[attk] [varchar](13) NOT NULL,
------------------	[attr] [nvarchar](max) NULL
------------------) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

------------------GO

------------------SET ANSI_PADDING OFF
------------------GO




SELECT [VxQAttr]  = ROW_NUMBER() over (order by    [Question_Std_fk]
                                                  ,[attk] )

      ,[Question_Std_fk]
      ,[Variable]
      ,[attk]
      ,[attr]
from
(
SELECT [VxQAttr]
      ,[Question_Std_fk] = CASE WHEN [Question_Std_fk] IS NULL THEN [Question_Std_Pk]
                                                               ELSE [Question_Std_fk] END
      ,[Variable]
      ,[attk]
      ,[attr]
  FROM [Rbkup].[dbo].[Pew_Question_Attribute]
  full join
     ( select * from
       [forum].[dbo].[Pew_Question_Std]
	   where          [Question_abbreviation_std]  not like 'CSR%'  
             AND      [Question_abbreviation_std]  not like 'ERI%'  
             AND      [Question_abbreviation_std]  not like 'IEI%'  
             AND      [Question_abbreviation_std]  not like 'PPR%'  
             AND      [Question_abbreviation_std]  not like 'RIR%'  
             AND      [Question_abbreviation_std]  not like 'SVY%'  )  VVg


on        [Variable] = [Question_abbreviation_std]

)  HHAJ


where 

[Variable] IS NOT NULL
AND 
[Variable] not like 'GRI_01_x2_%'
and
[Variable] not like 'GRX_22_filter'
and
[Variable] not like 'GRX_22_ny%'


UNION ALL

SELECT [VxQAttr] =1 
      ,[Question_Std_fk]  = [Question_Std_pk]
      ,[Variable]         = [Question_abbreviation_std]
      ,[attk]             = '80CharsLabel'
      ,[attr]             =  [Question_Label_80Chars]
  FROM [forum].[dbo].[Pew_Question_Std]
WHERE    [Question_Label_80Chars] IS NOT NULL
 

UNION ALL

SELECT [VxQAttr] =1 
      ,[Question_Std_fk]  = [Question_Std_pk]
      ,[Variable]         = [Question_abbreviation_std]
      ,[attk]             = 'In_PubDataSet'
      ,[attr]             =  [In_PubDataSet]
  FROM [forum].[dbo].[Pew_Question_Std]
WHERE    [In_PubDataSet] != '-'



/*
SELECT
       [Question_wording_std]
      ,[Question_short_wording_std]
      ,[Display]
      ,[AnswerSet_num]
      ,[Editorially_Checked]
      ,[Question_Label_80Chars]
      ,[In_PubDataSet]
  FROM [forum].[dbo].[Pew_Question_Std]
***/





