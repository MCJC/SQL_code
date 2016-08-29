/**************************************************************************************************************************************************/
/***                                                     ******************************************************************************************/
/***             S T E P     B Y     S T E P             ******************************************************************************************/
/***                                                     ******************************************************************************************/
/***                    S T E P     1                    ******************************************************************************************/
/***                                                     ******************************************************************************************/
/**************************************************************************************************************************************************/
USE [GRSHR_admin]
GO
/***  Include wordings by values per each question  ***********************************************************************************************/
UPDATE
       [GRSHR_admin].[dbo].[Basic]
SET
          [v_000]
       = A.[0.00]  
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_020]
       = A.[0.20]  
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_025]
       = A.[0.25]  
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_033]
       = A.[0.33]
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_040]
       = A.[0.40]
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_050]
       = A.[0.50]
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_060]
       = A.[0.60]
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_067]
       = A.[0.67]
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_075]
       = A.[0.75]
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_080]
       = A.[0.80]
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_100]
       = A.[1.00]
----------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [v_plu]
       = A.[9.00]
----------------------------------------------------------------------------------------------------------------------------------------------------
FROM
       [GRSHR_admin].[dbo].[Basic]  B
JOIN
       [GRSHR_admin].[dbo].[AW_std] A
ON
         B.[QA_std]
       = A.[QA_std_a]
----------------------------------------------------------------------------------------------------------------------------------------------------
GO
/***********************************************************************************************  Include wordings by values per each question  ***/


/**************************************************************************************************************************************************/
/***                                                     ******************************************************************************************/
/***                    S T E P     2                    ******************************************************************************************/
/***                                                     ******************************************************************************************/
/**************************************************************************************************************************************************/
/***  Add Computed Columns PERSISTED  *************************************************************************************************************/
SET ANSI_PADDING ON
GO
----------------------------------------------------------------------------------------------------------------------------------------------------
ALTER
TABLE
       [GRSHR_admin].[dbo].[Basic]
ADD
----------------------------------------------------------------------------------------------------------------------------------------------------
       [Answer_Wording_std]
                             AS
                               CASE 
                                   WHEN [Answer_value]  = [Av_STD_CURRENT] THEN [AW_std_CURRENT]
                                   -------------------------------------------------------------------------------------------
                                   WHEN [note]   LIKE    '%NOT be edited%'
                                    AND [Answer_value] != [Av_STD_CURRENT] THEN 'VALUE SHOULD NOT BE EDITED !!!'
                                   -------------------------------------------------------------------------------------------
                                   WHEN [note]   LIKE    '%can be edited%'
                                    AND [Answer_value] != [Av_STD_CURRENT]
                                    AND [Answer_value]  < 1.00
                                    AND [Answer_value]    NOT IN (
                                                                    0.00
                                                                  , 0.20
                                                                  , 0.25
                                                                  , 0.33
                                                                  , 0.40
                                                                  , 0.50
                                                                  , 0.60
                                                                  , 0.67
                                                                  , 0.75
                                                                  , 0.80
                                                                         ) THEN 'THE VALUE IS NOT A VALID ANSWER'
                                   -------------------------------------------------------------------------------------------
                                   WHEN [Answer_value]  = 0.00             THEN [v_000]
                                   WHEN [Answer_value]  = 0.20             THEN [v_020]
                                   WHEN [Answer_value]  = 0.25             THEN [v_025]
                                   WHEN [Answer_value]  = 0.33             THEN [v_033]
                                   WHEN [Answer_value]  = 0.40             THEN [v_040]
                                   WHEN [Answer_value]  = 0.50             THEN [v_050]
                                   WHEN [Answer_value]  = 0.60             THEN [v_060]
                                   WHEN [Answer_value]  = 0.67             THEN [v_067]
                                   WHEN [Answer_value]  = 0.75             THEN [v_075]
                                   WHEN [Answer_value]  = 0.80             THEN [v_080]
                                   WHEN [Answer_value]  = 1.00             THEN [v_100]
                                   WHEN [Answer_value]  > 0.00             THEN [v_plu]
                                   -------------------------------------------------------------------------------------------
                                   ELSE                                         'program error: tell JC!'
                                                                                                               END   PERSISTED
----------------------------------------------------------------------------------------------------------------------------------------------------
    , [changeV]
                             AS
                               CASE 
                                   WHEN [AV_std_CURRENT] !=  [Answer_value] THEN 'value has been updated'
                                   WHEN [AV_std_CURRENT]  =  [Answer_value] THEN ''
                                   ELSE                                          'error!'
                                                                                                               END   PERSISTED
----------------------------------------------------------------------------------------------------------------------------------------------------
    , [changeW]
                             AS
                               CASE 
                                   WHEN [AW_CURRENT]     IS     NULL
                                    AND [Answer_Wording] IS     NULL      THEN ''
                                   WHEN [AW_CURRENT]     IS     NULL
                                    AND [Answer_Wording] IS NOT NULL      THEN 'descriptive wording has been updated'
                                   WHEN [AW_CURRENT]     IS NOT NULL
                                    AND [Answer_Wording] IS     NULL      THEN 'descriptive wording has been removed'
                                   WHEN [AW_CURRENT]  =  [Answer_Wording] THEN ''
                                   WHEN [AW_CURRENT] !=  [Answer_Wording] THEN 'descriptive wording has been updated'
                                   ELSE                                        'error!'
                                                                                                               END   PERSISTED
----------------------------------------------------------------------------------------------------------------------------------------------------
GO
/**************************************************************************************************************************************************/
SET ANSI_PADDING OFF
GO
/*************************************************************************************************************  Add Computed Columns PERSISTED  ***/
/**************************************************************************************************************************************************/


