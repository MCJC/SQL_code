/**************************************************************************************************************************/
/*****                                              BackUp current Table                                              *****/
/**************************************************************************************************************************/
--USE [x_LoadRLS1cUS]                                                          /* use working database                    */
  USE [forum]                                                                  /* use final database                      */
GO
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)                                                 /* declare variable to store current date  */
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                          /* store date in format YYYYMMDD           */
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC                                                                           /* exec statement to run string s script   */
     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Answer_Std_' + @CrDt + 'b]
                  FROM     [forum].[dbo].[Pew_Answer_Std]'               )     /* select into backup from current table   */
/**************************************************************************************************************************/

--DELETE FROM               [forum].[dbo].[Pew_Answer_Std]
--WHERE                     [AnswerSet_number] IN (236, 237, 238)   --- added

/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/*****                        SECTION A: Store set of Qs-parameters as Common Table Expression                        *****/
/**************************************************************************************************************************/
WITH NSV AS                                                                    /* NewSet of Vals -common table expression */
(                                                                              /*> Set of Vals: ASetN + StdAVal + StdAWd  */
  --      SELECT N =  1 -- AnswerSetNumber      j  (i=StdAValue|j=ASetN)
  --           , V =  1 -- StdAnswerValue      ij  (i=StdAValue|j=ASetN)
  --           , W =  ' -- StdAnswerWording    ij  (i=StdAValue|j=ASetN)'
  --UNION SELECT N =  1 -- AnswerSetNumber      j  (i=StdAValue|j=ASetN)
  --           , V =  2 -- StdAnswerValue      ij  (i=StdAValue|j=ASetN)
  --           , W =  ' -- StdAnswerWording    ij  (i=StdAValue|j=ASetN)'

        SELECT N =  1
             , V =  01.00 
             , W =  'White NH'


  UNION SELECT N =  1 
             , V =  02.00 
             , W =  'Black NH'


  UNION SELECT N =  1 
             , V =  03.00 
             , W =  'Asian NH'


  UNION SELECT N =  1 
             , V =  04.00 
             , W =  'Other/Mi'


  UNION SELECT N =  1 
             , V =  05.00 
             , W =  'Latino'


  UNION SELECT N =  1 
             , V =  99.00 
             , W =  'DK/Ref. (vol.)'


  UNION SELECT N =  2 
             , V =  01.00 
             , W =  'R is not a US citizen'


  UNION SELECT N =  2 
             , V =  02.00 
             , W =  'R is a US citizen'


  UNION SELECT N =  3 
             , V =  01.00 
             , W =  'R is not absolutely certain registered to vote'


  UNION SELECT N =  3 
             , V =  02.00 
             , W =  'R is absolutely certain registered to vote'

                                                                             ) /* <   Set of Values ends!                 */
/*------------------------------------------------------------------------------------------------------------------------*/
--	INSERT INTO                                                                /* insert statement                        */
--	               [Pew_Answer_Std]                                            /* table in working database               */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
       [Answer_Std_pk]          =   (ROW_NUMBER ()                             /* number all rows                         */
                                           OVER (ORDER BY [N], [V] ))          /* sorted by answer set number & value     */
                                  + (SELECT MAX([Answer_Std_pk])               /* add currently max pk                    */
                                       FROM     [Pew_Answer_Std]               /* from Std Answers                        */
                                      WHERE     [Answer_Std_pk] < 999990)      /* excluding Un-Coded Numeric/Count vals   */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[AnswerSet_number]       =   [N]                                        /* conventional answer set number          */
                                  + (SELECT MAX([AnswerSet_number])            /* add currently max answer set number     */
                                       FROM     [Pew_Answer_Std]               /* from Std Answers                        */
                                      WHERE     [AnswerSet_number] < 999990)   /* excluding Un-Coded Numeric/Count vals   */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Answer_value_std]       =   [V]                                        /* conventional answer standard value      */
      ,[Answer_Wording_std]     =   [W]                                        /* conventional answer standard wording    */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[Full_set_of_Answers]    =   [A]                                        /* nested set of values & wordings by set  */
/*------------------------------------------------------------------------------------------------------------------------*/
      ,[NA_by_set_of_Answers]   =   [X]                                        /* count of values by answer set number    */
/*------------------------------------------------------------------------------------------------------------------------*/
FROM
/*------------------------------------------------------------------------------------------------------------------------*/
        [NSV]                                                     AS SetVs     /* main reference to CTE (New Set of Vals) */
/*------------------------------------------------------------------------------------------------------------------------*/
 JOIN
/*------------------------------------------------------------------------------------------------------------------------*/
      ( SELECT                                                                 /* sub-query for nested & aggegated values */
               [r] = [N]                                                       /* answer set number - join to main query  */
              ,[X] = COUNT(*)                                                  /* aggregate by counting rows              */
              ,[A] = STUFF(                                                    /* begin stuffing procedure...             */
                           ( SELECT '   ||'                                    /* begin selection into XML nested cell(s) */
                                  + STR(S2.[V], 7,2 )                          /* add value as string...                  */
                                  + ': '                                       /* concatenate using colon...              */
                                  +        [W]                                 /* to the corresponding wording            */
                              FROM         [NSV]          S2                   /* secondary reference to CTE in sub-query */
                             WHERE      S1.[N]                                 /* correspondence on main CTE reference... */
                                      = S2.[N]                                 /* to secondary reference in sub-query     */
                          ORDER BY      S1.[N]                                 /* sorting order by answer set number      */
                          FOR XML PATH('') )                                   /* nest in one XML string cell             */
                                            , 1, 8, '')                        /* end stuffing proced. by dropping chars  */
          FROM     [NSV]                                  S1                   /* main reference to CTE in sub-query      */
          GROUP BY [N]                                        )   AS nstdV     /* aggregate values & alias of sub-query   */
/*------------------------------------------------------------------------------------------------------------------------*/
ON         SetVs.[N]  =   nstdV.[r]                                            /* joint b/w main ref to CTE & sub-query   */
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 002                                                    *****/
/**************************************************************************************************************************/
SELECT * FROM [Pew_Answer_Std]                                                 /* check results in modified table         */
/**************************************************************************************************************************/
