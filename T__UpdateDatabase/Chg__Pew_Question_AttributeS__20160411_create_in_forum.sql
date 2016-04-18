USE            [forum]
GO
/**************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]              /***                                     ***/
     WHERE       [TABLE_NAME] = 'Pew_Question_Attributes'             ) = 1    /***                                     ***/
DROP              TABLE         [Pew_Question_Attributes]                      /***                                     ***/
/**************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
/**************************************************************************************************************************/
CREATE TABLE
             [Pew_Question_Attributes]
       (
             [Question_Attributes_pk]  [int]            NOT NULL
           , [Question_Std_fk]         [int]            NOT NULL
           , [attk]                    [varchar](20)    NOT NULL
           , [attr]                    [nvarchar](max)      NULL
           , CONSTRAINT
             [PK_Question_Attributes]
             PRIMARY KEY CLUSTERED 
             ( [Question_Attributes_pk] ASC )
                                        WITH ( PAD_INDEX              = OFF,
                                               STATISTICS_NORECOMPUTE = OFF,
                                               IGNORE_DUP_KEY         = OFF,
                                               ALLOW_ROW_LOCKS        = ON ,
                                               ALLOW_PAGE_LOCKS       = ON  )   ON [PRIMARY]
                                                                              ) ON [PRIMARY]
GO
/**************************************************************************************************************************/
SET ANSI_PADDING OFF
GO
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
INSERT INTO 
/*------------------------------------------------------------------------------------------------------------------------*/
             [Pew_Question_Attributes]
/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
    SELECT 
             [Question_Attributes_pk]  = ROW_NUMBER()
                                         OVER(ORDER BY  [Question_Std_fk]
                                                      , [attk]             )
           , [Question_Std_fk]
           , [attk]
           , [attr]
      FROM
           (
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
				SELECT [Question_Std_fk]
					  ,[Variable]
					  ,[attk]
					  ,[attr]
				  FROM (
						SELECT [VxQAttr]
							  ,[Question_Std_fk] = CASE 
							                       WHEN [Question_Std_fk] IS NULL 
												   THEN [Question_Std_Pk]
												   ELSE [Question_Std_fk]
												    END
							  ,[Variable]
							  ,[attk]
							  ,[attr]
						  FROM [Rbkup].[dbo].[Pew_Question_Attribute]
						  LEFT
						  JOIN
						       [forum].[dbo].[Pew_Question_Std]
                            ON
                               [Variable]
							 = [Question_abbreviation_std]
                       ) OldTable
                 WHERE [Question_Std_fk] IS NOT NULL
/*------------------------------------------------------------------------------------------------------------------------*/
   UNION ALL
/*------------------------------------------------------------------------------------------------------------------------*/
				SELECT [Question_Std_fk]  = [Question_Std_pk]
						,[Variable]         = [Question_abbreviation_std]
						,[attk]             = '80CharsLabel'
						,[attr]             =  [Question_Label_80Chars]
			      FROM   [forum].[dbo].[Pew_Question_Std]
				 WHERE   [Question_Label_80Chars] IS NOT NULL
/*------------------------------------------------------------------------------------------------------------------------*/
   UNION ALL
/*------------------------------------------------------------------------------------------------------------------------*/
				SELECT [Question_Std_fk]  = [Question_Std_pk]
						,[Variable]         = [Question_abbreviation_std]
						,[attk]             = 'In_PubDataSet'
						,[attr]             =  [In_PubDataSet]
				  FROM   [forum].[dbo].[Pew_Question_Std]
				 WHERE   [In_PubDataSet]             != '-'
					 AND [Question_abbreviation_std] != 'SHI_11_b'
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
           ) AddedAll
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/
GO
/**************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------
----  1,201 rows  ----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
/**************************************************************************************************************************/
