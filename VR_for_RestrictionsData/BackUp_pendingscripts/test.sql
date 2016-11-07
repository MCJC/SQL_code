USE [forum_ResAnal]
GO
/**************************************************************************************************************************************************/
IF OBJECT_ID (N'[forum_ResAnal].[dbo].[vx_00_dependencies]', N'U') IS NOT NULL
DROP TABLE      [forum_ResAnal].[dbo].[vx_00_dependencies]
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
/***************************************************************************************************************************************************************/
CREATE TABLE
[dbo].[vx_00_dependencies] (
                              [ROWID]    INT IDENTITY
                            , [sort]        INT
                            , [child]       VarChar(MAX)
                            , [lvl]         INT
                            , [through]     VarChar(MAX)
                            , [ancestors]   VarChar(MAX)
                            , [tree]        VarChar(MAX)
                            , [ChildID]     VarChar(MAX)
                            , [ParentID]    VarChar(MAX)
                            , [ChildFullN]  VarChar(MAX)
                            , [ParentFullN] VarChar(MAX)
                                                         ) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
DECLARE @CrDt varchar( 8)                                 /***        declare variable for storing current date (as text)                       ***/
SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))       /***        set value to current date in the format YYYYMMDD                          ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  cursor                                                                    ***/
DECLARE @CODEmain1 nvarchar(max)                          /***        declare variable for storing code during each data retreival              ***/
DECLARE @tablename nvarchar(max)                          /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor   CURSOR FOR                             /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
SELECT [ct]                                               /*** >>>    select concatenated text                                                  ***/
          = [D] + '.[dbo].['+[N]+']'                      /***               table/view names                                                   ***/
--	 , [T]
  FROM                                                    /***                                                                                  ***/
      (                                                   /***                                                                                  ***/
       SELECT                                             /***                                                                                  ***/
       [N]= [TABLE_NAME]                                  /***               table/view names                                                   ***/
      ,[T]= [TABLE_TYPE]                                  /***                                                                                  ***/
      ,[D]='[forum]'                                      /***               database                                                           ***/
       FROM [forum]        .[INFORMATION_SCHEMA].[TABLES] /***   <    from the system view listing tables & views in the database               ***/
     UNION                                                /***                                                                                  ***/
     ALL                                                  /***                                                                                  ***/



declare @Loginname varchar(100),
        @MemberOf  varchar(100)

declare crsMyTblParams cursor for
        select Loginname, MemberOf from #serverLoginDetails

open crsMyTblParams

fetch next from crsMyTblParams into @Loginname, @MemberOf





SELECT 
       [rn] = ROW_NUMBER() OVER(ORDER BY VN)
,* FROM
(
       SELECT                                             /***                                                                                  ***/
       [TN]= [TABLE_NAME]                                  /***               table/view names                                                   ***/
       FROM [forum_ResAnal].[INFORMATION_SCHEMA].[TABLES] /***   <    from the system view listing tables & views in the database               ***/
	   where [TABLE_TYPE] = 'BASE TABLE'
	   and [TABLE_NAME] like 'vr%'
) TNs
inner join
(
       SELECT                                             /***                                                                                  ***/
       [VN]= [TABLE_NAME]                                  /***               table/view names                                                   ***/
       FROM [forum_ResAnal].[INFORMATION_SCHEMA].[TABLES] /***   <    from the system view listing tables & views in the database               ***/
	   where [TABLE_TYPE] = 'VIEW'
	   and [TABLE_NAME] like 'vr%'
) VNs
ON
VN = SUBSTRING(TN, 1, 8)

      )                                    tabs_and_views /***                                                                                  ***/
----------------------------------------------------------------------------------------------------------------------------------------------------
  WHERE     [T] LIKE 'VIEW'                               /***                                                                                  ***/
--	AND     [N] IN ( 'Pew_Answer', 'vi_AgeSexValue' )     /***                                                                                  ***/
----------------------------------------------------------------------------------------------------------------------------------------------------
ORDER BY [T] DESC, [ct]                                             /*** <<<                                                                              ***/
/**************************************************************************************************************************************************/
OPEN             MyCursor                                 /*** >>>    open cursor by its name                                                   ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @tablename                               /***        store it into the corresponding variable(s)                               ***/
          WHILE  @@FETCH_STATUS = 0                       /***        while the status of the last retreival has been successful                ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
BEGIN                                                     /*** >>     BEGIN the procedures using values of each row of the cursor               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
INSERT INTO         [vx_00_dependencies]                  /***        execute code                                                              ***/
SELECT * FROM [dbo].[GetAncestors](@tablename)            /***        execute code                                                              ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <<     ENDING of the procedures using values of each row of the cursor           ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @tablename                               /***        store it into the corresponding variable(s)                               ***/
           END                                            /***        and end when last row has been retreived                                  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
   CLOSE         MyCursor                                 /*** <<<    close cursor by its name                                                  ***/
DEALLOCATE       MyCursor                                 /*** <<<<   remove reference and relase from memory by cursor name                    ***/
/*********************************************************     <<<<<  cursor                                                                    ***/
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/


/* 

    SELECT * FROM 
                  [vx_00_dependencies] 

            WHERE
                  [ancestors]
                              IN ( 
                                      '[forum].[dbo].[Pew_Indexes]'
                                    , '[forum].[dbo].[Pew_Nation_Religion_Value]'
                                    , '[forum].[dbo].[Pew_Question_Displayable]'
                                    , '[forum].[dbo].[Restrictions_byCtry]'
                                    , '[forum].[dbo].[v__AllCodedData]'
                                    , '[forum].[dbo].[v_Current_Survey_Questions]'
                                    , '[forum].[dbo].[v_Data_for_WRD_Religion_Comparison]'
                                    , '[forum].[dbo].[v_GRI_20_01_all]'
                                    , '[forum].[dbo].[V_Pew_LongIndex]'





                                 )

------[dbo].[v_Religion_Group_for_Surveys]
------[dbo].[vi_CutPoints]
------[dbo].[vi_ForMoreInformationLinks_by_Region_or_Ctry]
------[dbo].[vi_ForMoreInformationLinks_by_Religion]
------[dbo].[vi_Locations_by_Question]
------[dbo].[vi_QuestionMetadata_Svy&Restr]
------[dbo].[vi_Reportable_DataSource_Joins]
------[dbo].[vi_ReportLinks_by_Region_or_Ctry]
------[dbo].[vi_ReportLinks_by_Religion]
------[dbo].[vi_Restrictions_byCtryYr]
------[dbo].[vi_Restrictions_Ctry&Q&Yr_Displayable]
------[dbo].[vi_Restrictions_Index_by_CtryRegion&Yr]
------[dbo].[vi_Restrictions_Q&Yr_Displayable]
------[dbo].[vi_Restrictions_Tables_by_region&world]
------[dbo].[vi_Sources_by_Tabs&Charts]
------[dbo].[vi_Thresholds]
------[dbo].[vi_Topic&Question_Displayable]
------[dbo].[vi_Topic&Question_link_RelatedPewResearchReports]





----TABLE  [vr___0______NationLocalityTOOL]
----TABLE  [vr___0______QuestiReligionTOOL]
----TABLE  [vr___01_cDB_Long__NoAggregated]
----TABLE  [vr___02_cDB_Wide__by_Ctry&Year]
----TABLE  [vr___03_cDB_W&Xtra_byCtry&Year]
----TABLE  [vr___asked20160113]
----TABLE  [vr_00_GRSHR_Q&A]
----TABLE  [vr_00_GRSHR_QLabels]
----TABLE  [vr_04w_R&H_Index_by_CtryRegion&Yr]
----TABLE  [vr_05w_SemiWide_by_Ctry&Year]
----TABLE  [vr_06w_LongData_ALL]
----TABLE  [vr_06w_LongData_ALL_bkup]
----TABLE  [vr_07w_weights]
----TABLE  [vr_08__QAttributes]
----TABLE  [vrd_w_01_proGRSHRadm_01]
----TABLE  [vrp__01_cDB_SelDataBYCtry&Year]
----TABLE  [vrp__02_cDB_Label_of_Variables]
----TABLE  [vrx_w_01_Basic_TopLinesAll_00]
----TABLE  [vrx_w_02_proTopLines_00]
----TABLE  [vrx_w_03_Basic_TopLines_by_Region_00]
----TABLE  [vrx_w_04_Vars_by_Ctry_source_00]
----TABLE  [vrx_w_05_proRRIdxSbyR_00]
----TABLE  [vrx_w_06_proRRIdxMedians_00]
----VIEW  [vr_01_DB_Long_NoAggregated]
----VIEW  [vr_02_W_by_Ctry&Year]
----VIEW  [vr_03_W&Extras_by_Ctry&Year]
----VIEW  [vr_LongCodedData_in_DB]

----VIEW  [V1_DB_Long]
----VIEW  [V2_W_by_Ctry&Year]
----VIEW  [V3_W&Extras_by_Ctry&Year]
----VIEW  [V4_L_by_CYV]
----VIEW  [V5_LRestr_by_CYV]
----VIEW  [V6_Basic&Index]
----VIEW  [V7_LRestr_by_CV]
----VIEW  [V7_LRestr_by_VarVal]
----VIEW  [V8_AggIdx_by_VarVal]
----VIEW  [V9_AggIdx_by_Yr]




------ WHERE      [TABLE_NAME] LIKE 'vr%'                       /***                                                                                  ***/
------    OR      [TABLE_NAME] LIKE 'V[1-9]_%'                  /***                                                                                  ***/


















----    SELECT 
----         [ChildN] AS [through],
----         [ChildID]
----		    AS [through_ID],
----        [ParentFullN]  AS [ancestors],
----        Tree = '<-' + REPLICATE('-',(lvl * 4)) + ']  ' + LEFT('               ',(16-(lvl * 4))) + [ParentFullN] --, 
------        sort = '|x' + REPLICATE('x',(lvl * 4)) 
----    FROM cte
----order by
----        '|x' + REPLICATE('x',(lvl * 4)) 


------    ) vf
------   ORDER
------	  BY
------        Tree 


------select * from SO