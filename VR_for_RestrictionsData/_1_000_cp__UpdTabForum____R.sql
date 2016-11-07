/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 1.000    ---------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     Each year we start by updating tables in the main database [forum] in order to include changes for such a coding period                             ***/
/***                                                                                                                                                         ***/
/***     We should know in advance about new questions to be added: such questions involve changes in:                                                       ***/
/***        --      [forum].[dbo].[Pew_Answer_Std]                                                                                                           ***/
/***        --      [forum].[dbo].[Pew_Question_Std]                                                                                                         ***/
/***     We should also know about questions to be removed from the former year; the new list should be addd to:                                             ***/
/***        --      [forum].[dbo].[Pew_Question_NoStd]                                                                                                       ***/
/***                                                                                                                                                         ***/
/***     Once the former tables have been updated, we should also update--if necesssary--the corrsponding references in:                                     ***/
/***        --      [forum].[dbo].[Pew_Question_Attributes]                                                                                                  ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/

--                                                          NOTE:
/* add to year variables te following toool variables:
GRI_01_filter
GRI_01_yBe
GRI_02_filter
GRI_02_yBe
GRI_19_filter
GRI_19_x
SHI_01_x
SHI_01_summary_b
SHI_04_filter
SHI_04_x
SHI_05_filter
SHI_05_x
XSG_S_99_filter*/
/* 2015-data coding period: */
--SHI_04_d_x_1_n
--SHI_04_d_x_2_n
--SHI_05_d_x_1_n
--SHI_05_d_x_2_n




-----hhhhhhhhhhhhhhhhhhhhhhhhhhhhh
--- NOT REPLICABLE
--
