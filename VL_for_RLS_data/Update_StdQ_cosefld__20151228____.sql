USE [RLS]
GO
/****************************************************************************************************************************************************/
/*****                                                              Pew_Answer_Std                                                              *****/
/*****                                                           BackUp current Table                                                           *****/
/****************************************************************************************************************************************************/
--  DECLARE @CrDt    varchar( 8)                                                            /* declare variable to store current date                 */
--  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))                                     /* store date in format YYYYMMDD                          */
--/*--------------------------------------------------------------------------------------------------------------------------------------------------*/
--EXEC                                                                                      /* exec statement to run strings script                   */
--     ( ' SELECT * INTO [_bk_forum].[dbo].[Pew_Question_Std_' + @CrDt + 'RLS]'             /* select into backup                                     */
--         + '      FROM                   [Pew_Question_Std]'               )              /* select into backup from current table                  */
/****************************************************************************************************************************************************/


/****************************************************************************************************************************************************/
/*****                                                              -> U P D A T E                                                              *****/
/*****                                             notice:  this UPDATES questions previously added                                             *****/
/****************************************************************************************************************************************************/
/*** code field for edtorialy checked or not-checked ************************************************************************************************/
/*--------------------------------------------------------------------------------------------------------------------------------------------------*/
--UPDATE                                                                                    /*                                                        */
--                               [RLS].[dbo].[Pew_Question_Std]                             /*                                                        */
--SET                                                                                       /*                                                        */
--                                           [Editorially_Checked] = 'Yes'                  /*                                                        */
--                                     WHERE [Question_Std_pk]                              /*                                                        */
--                                                                 IN (                     /*                                                        */
--                                                                              1        /* modify row in selecteded table                         */
--                                                                             ,2        /* modify row in selecteded table                         */
--                                                                             ,19       /* modify row in selecteded table                         */
--                                                                             ,64       /* modify row in selecteded table                         */
--                                                                             ,66       /* modify row in selecteded table                         */
--                                                                             ,77       /* modify row in selecteded table                         */
--                                                                             ,81       /* modify row in selecteded table                         */
--                                                                             ,82       /* modify row in selecteded table                         */
--                                                                             ,86       /* modify row in selecteded table                         */
--                                                                             ,87       /* modify row in selecteded table                         */
--                                                                             ,88       /* modify row in selecteded table                         */
--                                                                             ,89       /* modify row in selecteded table                         */
--                                                                             ,90       /* modify row in selecteded table                         */
--                                                                             ,91       /* modify row in selecteded table                         */
--                                                                             ,92       /* modify row in selecteded table                         */
--                                                                             ,93       /* modify row in selecteded table                         */
--                                                                             ,94       /* modify row in selecteded table                         */
--                                                                             ,95       /* modify row in selecteded table                         */
--                                                                             ,96       /* modify row in selecteded table                         */
--                                                                             ,97       /* modify row in selecteded table                         */
--                                                                             ,98       /* modify row in selecteded table                         */
--                                                                             ,99       /* modify row in selecteded table                         */
--                                                                             ,100       /* modify row in selecteded table                         */
--                                                                             ,101       /* modify row in selecteded table                         */
--                                                                             ,102       /* modify row in selecteded table                         */
--                                                                             ,103       /* modify row in selecteded table                         */
--                                                                             ,104       /* modify row in selecteded table                         */
--                                                                             ,105       /* modify row in selecteded table                         */
--                                                                             ,106       /* modify row in selecteded table                         */
--                                                                             ,107       /* modify row in selecteded table                         */
--                                                                             ,108       /* modify row in selecteded table                         */
--                                                                             ,109       /* modify row in selecteded table                         */
--                                                                             ,110       /* modify row in selecteded table                         */
--                                                                             ,111       /* modify row in selecteded table                         */
--                                                                             ,112       /* modify row in selecteded table                         */
--                                                                             ,113       /* modify row in selecteded table                         */
--                                                                    )                     /*                                                        */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/****************************************************************************************************************************************************************************/
--SELECT 
--                                           [Editorially_Checked]                          /*                                                        */
--                                         , [Question_Std_pk]                              /*                                                        */
--         FROM                  [RLS].[dbo].[Pew_Question_Std]                             /*                                                        */
--                                     WHERE [Question_Std_pk]                              /*                                                        */
--                                                                 IN (                     /*                                                        */
--                                                                              1        /* modify row in selecteded table                         */
--                                                                             ,2        /* modify row in selecteded table                         */
--                                                                             ,19       /* modify row in selecteded table                         */
--                                                                             ,64       /* modify row in selecteded table                         */
--                                                                             ,66       /* modify row in selecteded table                         */
--                                                                             ,77       /* modify row in selecteded table                         */
--                                                                             ,81       /* modify row in selecteded table                         */
--                                                                             ,82       /* modify row in selecteded table                         */
--                                                                             ,86       /* modify row in selecteded table                         */
--                                                                             ,87       /* modify row in selecteded table                         */
--                                                                             ,88       /* modify row in selecteded table                         */
--                                                                             ,89       /* modify row in selecteded table                         */
--                                                                             ,90       /* modify row in selecteded table                         */
--                                                                             ,91       /* modify row in selecteded table                         */
--                                                                             ,92       /* modify row in selecteded table                         */
--                                                                             ,93       /* modify row in selecteded table                         */
--                                                                             ,94       /* modify row in selecteded table                         */
--                                                                             ,95       /* modify row in selecteded table                         */
--                                                                             ,96       /* modify row in selecteded table                         */
--                                                                             ,97       /* modify row in selecteded table                         */
--                                                                             ,98       /* modify row in selecteded table                         */
--                                                                             ,99       /* modify row in selecteded table                         */
--                                                                             ,100       /* modify row in selecteded table                         */
--                                                                             ,101       /* modify row in selecteded table                         */
--                                                                             ,102       /* modify row in selecteded table                         */
--                                                                             ,103       /* modify row in selecteded table                         */
--                                                                             ,104       /* modify row in selecteded table                         */
--                                                                             ,105       /* modify row in selecteded table                         */
--                                                                             ,106       /* modify row in selecteded table                         */
--                                                                             ,107       /* modify row in selecteded table                         */
--                                                                             ,108       /* modify row in selecteded table                         */
--                                                                             ,109       /* modify row in selecteded table                         */
--                                                                             ,110       /* modify row in selecteded table                         */
--                                                                             ,111       /* modify row in selecteded table                         */
--                                                                             ,112       /* modify row in selecteded table                         */
--                                                                             ,113       /* modify row in selecteded table                         */
--                                                                    )                     /*                                                        */
--ORDER BY                                   [Editorially_Checked]                          /*                                                        */
/****************************************************************************************************************************************************************************/
/****************************************************************************************************************************************************************************/


