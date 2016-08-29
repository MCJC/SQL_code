USE [RLS]
GO
/****************************************************************************************************************************************/
/*****                                                     BackUp current Table                                                     *****/
/****************************************************************************************************************************************/
/****************************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)                                                 /* declare variable to store current date                */
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                          /* store date in format YYYYMMDD                         */
/*--------------------------------------------------------------------------------------------------------------------------------------*/
EXEC                                                                           /* exec statement to run string s script                 */
     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Answer_Std_' + @CrDt + 'RLS]'    /* select into backup                                    */
         + '      FROM                   [Pew_Answer_Std]'               )     /* select into backup from current table                 */
/****************************************************************************************************************************************/
/*****                                                  number and sets of answers                                                  *****/
/****************************************************************************************************************************************/
/****************************************************************************************************************************************/
/*--------------------------------------------------------------------------------------------------------------------------------------*/
/*--- PEND: DESCRIBE  tab-of-ans (ToA) needs to be sorted by STD vals => PewAnsStd-Sorted ----------------------------------------------*/
--WITH PASS                                        ctre didnt work             /* Define the CTE common-table-expression name           */
--AS (                                                                         /* Define the CTE query                                  */
        SELECT  [r] = ROW_NUMBER ( )                                           /*                                                       */
                            OVER (                                             /*                                                       */
                        ORDER BY  [AnswerSet_number]                           /*                                                       */
                                , [Answer_value_std] )                         /*                                                       */
              , [Answer_value_std]                                             /*                                                       */
              , [Answer_Wording_std]                                           /*                                                       */
              , [AnswerSet_number]                                             /*                                                       */
         INTO   [#PASS]                                                        /* TEMP table sorting PewStdAns                          */
         FROM                                                                  /*                                                       */
                [Pew_Answer_Std]                                               /*                                                       */
--                                                                          )  /* End CTE - then, outer query referencing CTE name.     */
/*--------------------------------------------------------------------------------------------------------------------------------------*/
UPDATE
           [RLS].[dbo].[Pew_Answer_Std]
SET
           [RLS].[dbo].[Pew_Answer_Std].[NA_by_set_of_Answers]
       =                            aNW.[X]
     ,     [RLS].[dbo].[Pew_Answer_Std].[Full_set_of_Answers]
       =                            aNW.[A]
/*--------------------------------------------------------------------------------------------------------------------------------------*/
--select *                                                                     /* test statement                                        */
FROM                                                                           /* to incl;ude two joined elements                       */
           [Pew_Answer_Std]                                             AS myt /* current tabble to be modified                         */
/*--------------------------------------------------------------------------------------------------------------------------------------*/
 JOIN
/*--------------------------------------------------------------------------------------------------------------------------------------*/
      ( SELECT                                                                 /* sub-query for nested/aggreg N-of-answers+concat-wrdgs */
               [AnswerSet_number]                                              /* answer set number to join subquery to main query      */
              ,[X] = COUNT(*)                                                  /* aggregate number of answers by counting rows          */
              ,[A] = STUFF(                                                    /* begin stuffing procedure...                           */
                           ( SELECT '   ||'                                    /* begin selection into XML nested cell(s)               */
                                  + STR(S2.[Answer_value_std], 7,2 )           /* add value as string...                                */
                                  + ': '                                       /* concatenate using colon...                            */
                                  +        [Answer_Wording_std]                /* to the corresponding wording                          */
                              FROM         [#PASS]                   S2        /* secondary reference to TEMP Sorted ToA in sub-query   */
                             WHERE                                             /* condition of correspondence...                        */
                                        S1.[AnswerSet_number]                  /* matching set number from main ToA reference...        */
                                      = S2.[AnswerSet_number]                  /* to secondary reference of ToA in sub-query            */
                          ORDER BY      S1.[AnswerSet_number]                  /* q results sorting order by answer set number          */
                          FOR XML PATH('') )                                   /* nest in one XML string cell                           */
                                            , 1, 7, '')                        /* end stuffing proced. by dropping some initial chars   */
          FROM [#PASS]                                               S1         /* main reference to TEMP Sorted ToA in sub-qu          */
       GROUP BY [AnswerSet_number]                                             /* aggregate values by id of set odf answers             */
                                                                      ) AS aNW /* alias of sub-query of aggr N-of-answers+concat-wrdgs  */
/*--------------------------------------------------------------------------------------------------------------------------------------*/
ON                                                                             /* joint by answer set number, matching...               */
             myt.[AnswerSet_number]                                            /* AN in current tabble                                  */
       =     aNW.[AnswerSet_number]                                            /* to AN as resulted from sub-query                      */
/*--------------------------------------------------------------------------------------------------------------------------------------*/
--	WHERE \   myt.[AnswerSet_number] NOT IN (                                  /* EXCLUDING SOME values from the aggregation...         */
--	                                               1,                          /* ---- such as religion                                 */
--	                                             169,                          /* ---- such as age in years                             */
--	                                             170,                          /* ---- such as N of children                            */
--	                                          999999                           /* ---- such as continous count vars                     */
--	                                                           )               /*                        end of conditions of EXCLUSION */
/*--------------------------------------------------------------------------------------------------------------------------------------*/
GO
/*--------------------------------------------------------------------------------------------------------------------------------------*/
/****************************************************************************************************************************************/
/****************************************************************************************************************************************/
