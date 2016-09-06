/**************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'AllLongData'                      ) = 1
DROP              TABLE         [AllLongData]
/***  All Long Data *******************************************************************************************************************************/
----SELECT * INTO    [AllLongData] FROM [TwoYD]
/**************************************************************************************************************************************************/

/**************************************************************************************************************************************************/
IF OBJECT_ID  ('tempdb..#TCV')                        IS NOT NULL
DROP TABLE              #TCV
IF OBJECT_ID  ('tempdb..#TNV')                        IS NOT NULL
DROP TABLE              #TNV
IF OBJECT_ID  ('tempdb..#TAW')                        IS NOT NULL
DROP TABLE              #TAW
/**************************************************************************************************************************************************/
/***  coded values ********************************************************************************************************************************/
SELECT 
        [CEN]                                              -- name only for this set
     ,  [N_k]                                              -- key only for this set
     ,  [QYr]                                              -- year only for this set
     ,  [YNc]           = ([QYr] * 10000) + [N_k]
     ,  [QAS]
     ,  [AX]            =  STR((CAST([AVa] as decimal ( 4,2))), 4,2 )
                         + '   - ' + [AWS]
                                                                         INTO [#TCV]
                                                                         FROM [TwoYD]
                                                                        WHERE [QCl]      IN ( 'CODED', 'preyr' )
/***  coded values ********************************************************************************************************************************/
/**************************************************************************************************************************************************/
/***  count (numeric) values **********************************************************************************************************************/
SELECT 
        [YNn]           = ([QYr] * 10000) + [N_k]
     ,  [QAS]
     ,  [AX]            =  STR((CAST([AVa] as decimal (10,0))),10,0 )
                         + '   - ' + [AWS]
                                                                         INTO [#TNV]
                                                                         FROM [TwoYD]
                                                                        WHERE [QCl]      IN ( 'COUNT' )
/***  count (numeric) values **********************************************************************************************************************/
/**************************************************************************************************************************************************/
/***  wordings ************************************************************************************************************************************/
SELECT 
        [YNw]           = ([QYr] * 10000) + [N_k]
     ,  [QAS]           =  [Qde]
     ,  [AX]            =  [AWu]
                                                                         INTO [#TAW]
                                                                         FROM [TwoYD]
                                                                        WHERE [QDe]      IS NOT NULL
/**************************************************************************************************************************************************/
GO





----/**************************************************************************************************************************************************/



----IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME]='TAWpv') =1 DROP TABLE [TAWpv]
----IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME]='TCVpv') =1 DROP TABLE [TCVpv]
----IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME]='TNVpv') =1 DROP TABLE [TNVpv]
----GO
----/**************************************************************************************************************************************************/
----declare @CODEAW nvarchar(max)
----declare @CODENV nvarchar(max)
----declare @CODECV nvarchar(max)
----/**************************************************************************************************************************************************/
----set @CODEAW = 
----  N'SELECT * INTO [TAWpv] FROM [#TAW] pivot(max([AX]) for [QAS] in ('
----+                                      STUFF((SELECT ', '+[QAS] FROM [AT_Qs] WHERE [QClass]='DESCR' for xml path('')),1,1,'')
----                                                                                                        +N' ) ) AS pivt '
----/*------------------------------------------------------------------------------------------------------------------------------------------------*/
----set @CODENV = 
----  N'SELECT * INTO [TNVpv] FROM [#TNV] pivot(max([AX]) for [QAS] in ('
----+                                      STUFF((SELECT ', '+[QAS] FROM [AT_Qs] WHERE [QClass]='COUNT' for xml path('')),1,1,'')
----                                                                                                        +N' ) ) AS pivt '
----/*------------------------------------------------------------------------------------------------------------------------------------------------*/
----set @CODECV =
----  N'SELECT * INTO [TCVpv] FROM [#TCV] pivot(max([AX]) for [QAS] in ('
----+                                      STUFF((SELECT ', '+[QAS] FROM [AT_Qs] WHERE [QClass]='CODED' for xml path('')),1,1,'')
----                                                                                                        +N' ) ) AS pivt '
----/**************************************************************************************************************************************************/
------	EXEC dbo.LongPrint @CODEAW                                     /***        display the currently stored code (to be executed)               ***/
------	EXEC dbo.LongPrint @CODENV                                     /***        display the currently stored code (to be executed)               ***/
------	EXEC dbo.LongPrint @CODECV                                     /***        display the currently stored code (to be executed)               ***/
----	EXEC              (@CODEAW)                                    /***        execute the code that has been stored as text                    ***/
----	EXEC              (@CODENV)                                    /***        execute the code that has been stored as text                    ***/
----	EXEC              (@CODECV)                                    /***        execute the code that has been stored as text                    ***/
----/**************************************************************************************************************************************************/
----IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] ='GRSH_C') = 1 DROP TABLE [GRSH_C]
----GO
----declare @CODET  nvarchar(max)
----/**************************************************************************************************************************************************/
----set @CODET = 
---- N'
----   SELECT
----         [RowID]               = ROW_NUMBER() OVER(ORDER BY [QYr] DESC, [N_k] )
----       , [Question_Year]       = [QYr]
----       , [Nation_fk]           = [N_k]
----       , [Ctry_EditorialName]  = [CEN]
----  ' 
----+                                          ( SELECT ', '+[QAS] FROM [AT_Qs] WHERE [QClass]!='PERSI' for xml path(''))
----+N'
----        INTO [GRSH_C] FROM [TAWpv] '
----+N'             INNER JOIN [TNVpv] ON [YNw] = [YNn] '
----+N'             INNER JOIN [TCVpv] ON [YNc] = [YNw] '
----                                                                   /*** >>>    store ordered variables in wide shape                            ***/
----/**************************************************************************************************************************************************/
----	EXEC              (@CODET)                                     /***        execute the code that has been stored as text                    ***/
----/**************************************************************************************************************************************************/
----GO
----/**************************************************************************************************************************************************/
--------SELECT * FROM [TAWpv]
--------SELECT * FROM [TNVpv]
--------SELECT * FROM [TCVpv]
--IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
--     WHERE       [TABLE_NAME] = 'TCVpv'                          ) = 1
--DROP              TABLE         [TCVpv]
--IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
--     WHERE       [TABLE_NAME] = 'TNVpv'                          ) = 1
--DROP              TABLE         [TNVpv]
--IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
--     WHERE       [TABLE_NAME] = 'TAWpv'                          ) = 1
--DROP              TABLE         [TAWpv]
--GO
--/**************************************************************************************************************************************************/













IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] ='GRSH_C') = 1 DROP TABLE [GRSH_C]
GO
/**************************************************************************************************************************************************/
declare @CODEAW nvarchar(max)
declare @CODENV nvarchar(max)
declare @CODECV nvarchar(max)
declare @CODET  nvarchar(max)
/**************************************************************************************************************************************************/
set @CODEAW = 
  N'SELECT * FROM [#TAW] pivot(max([AX]) for [QAS] in ('
+                         STUFF((SELECT ', '+[QAS] FROM [AT_Qs] WHERE [QClass]='DESCR' for xml path('')),1,1,'') + N' ) ) AS pivt '
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
set @CODENV = 
  N'SELECT * FROM [#TNV] pivot(max([AX]) for [QAS] in ('
+                         STUFF((SELECT ', '+[QAS] FROM [AT_Qs] WHERE [QClass]='COUNT' for xml path('')),1,1,'') + N' ) ) AS pivt '
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
set @CODECV =
  N'SELECT * FROM [#TCV] pivot(max([AX]) for [QAS] in ('
+                         STUFF((SELECT ', '+[QAS] FROM [AT_Qs] WHERE [QClass]='CODED' for xml path('')),1,1,'') + N' ) ) AS pivt '
/**************************************************************************************************************************************************/
set @CODET = 
 N'
   SELECT
         [RowID]               = ROW_NUMBER() OVER(ORDER BY [QYr] DESC, [N_k] )
       , [Question_Year]       = [QYr]
       , [Nation_fk]           = [N_k]
       , [Ctry_EditorialName]  = [CEN]
  ' 
+                                          ( SELECT ', '+[QAS] FROM [AT_Qs] WHERE [QClass]!='PERSI' for xml path(''))
+N'
        INTO [GRSH_C] FROM ( ' + @CODEAW + ' ) AW '
+N'             INNER JOIN ( ' + @CODENV + ' ) NV  ON [YNw] = [YNn] '
+N'             INNER JOIN ( ' + @CODECV + ' ) CV  ON [YNc] = [YNw] '
                                                                   /*** >>>    store ordered variables in wide shape                            ***/
/**************************************************************************************************************************************************/
	EXEC              (@CODET)                                     /***        execute the code that has been stored as text                    ***/
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEAW                                     /***        display the currently stored code (to be executed)               ***/
--	EXEC dbo.LongPrint @CODENV                                     /***        display the currently stored code (to be executed)               ***/
--	EXEC dbo.LongPrint @CODECV                                     /***        display the currently stored code (to be executed)               ***/
--	EXEC dbo.LongPrint @CODET                                      /***        display the currently stored code (to be executed)               ***/
/***  manual setting *****************************************************************************************************************************/
/***         By default the SQL Server Agent does not set QUOTED_IDENTIFIER: in the Transact-SQL command SET OPTIONS must be added             ***/
SET QUOTED_IDENTIFIER ON
GO
/**************************************************************************************************************************************************/
/***  Final steps: ********************************************************************************************************************************/
/**************************************************************************************************************************************************/
/***  Change ID field configuration as integer and non-nullable  **********************************************************************************/
ALTER TABLE [GRSH_C]
ALTER COLUMN RowID INT NOT NULL
GO
/**********************************************************************************  Change ID field configuration as integer and non-nullable  ***/
/**************************************************************************************************************************************************/
/***  Change ID field configuration as real pk  ***************************************************************************************************/
ALTER TABLE      [GRSH_C]
ADD   CONSTRAINT GRSHC_pk PRIMARY KEY(RowID)
GO
/***************************************************************************************************  Change ID field configuration as real pk  ***/
/**************************************************************************************************************************************************/
/***  Add Computed Columns PERSISTED  *************************************************************************************************************/
ALTER TABLE [GRSH_C]
ADD GRI_19_x         AS
                          GRI_19_b
                        + GRI_19_c
                        + GRI_19_d
                        + GRI_19_e
                        + GRI_19_f   PERSISTED
GO

ALTER TABLE [GRSH_C]
ADD SHI_04_x         AS
                          SHI_04_b
                        + SHI_04_c
                        + SHI_04_d
                        + SHI_04_e
                        + SHI_04_f   PERSISTED
GO

ALTER TABLE [GRSH_C]
ADD SHI_05_x         AS
                          SHI_05_c  -- notice SHI_05_b_x has been dropped / never used for the index
                        + SHI_05_d
                        + SHI_05_e
                        + SHI_05_f   PERSISTED
GO

ALTER TABLE [GRSH_C]
ADD SHI_01_x         AS 
                          SHI_01_b
                        + SHI_01_c
                        + SHI_01_d
                        + SHI_01_e
                        + SHI_01_f   PERSISTED
GO

ALTER TABLE [GRSH_C]
ADD SHI_01_summary_b AS 
                          CASE WHEN SHI_01_a = '0.50   - Yes, in limited ways'              THEN 1 ELSE 0 END
                        + CASE WHEN SHI_01_a = '1.00   - Yes, widespread social harassment' THEN 1 ELSE 0 END
                        + CASE WHEN CAST(SUBSTRING(SHI_01_b, 1, 10) as decimal (10,0)) > 0  THEN 1 ELSE 0 END
                        + CASE WHEN CAST(SUBSTRING(SHI_01_c, 1, 10) as decimal (10,0)) > 0  THEN 1 ELSE 0 END
                        + CASE WHEN CAST(SUBSTRING(SHI_01_d, 1, 10) as decimal (10,0)) > 0  THEN 1 ELSE 0 END
                        + CASE WHEN CAST(SUBSTRING(SHI_01_e, 1, 10) as decimal (10,0)) > 0  THEN 1 ELSE 0 END
                        + CASE WHEN CAST(SUBSTRING(SHI_01_f, 1, 10) as decimal (10,0)) > 0  THEN 1 ELSE 0 END   PERSISTED
GO
/*************************************************************************************************************  Add Computed Columns PERSISTED  ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
---select * from [GRSH_C]
