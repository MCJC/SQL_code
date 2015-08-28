/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the table [forum_ResAnal]..[vm__Migration_Flow_all]                                             <<<<<     ***/
/***             NOTE:  This is a lookup table hosted at the default place for auxiliary fixed tables: [forum_ResAnal]                                       ***/
/***                    The table includes migration flow non-zero values but also adds all zero values to avoid errors                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
/**** database name specification for data sources (once) ******************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vm__Migration_Flow_all]', N'U') IS NOT NULL
DROP   TABLE     [forum_ResAnal].[dbo].[vm__Migration_Flow_all]
GO
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
          [V_Migration_Flow_pk]         = ROW_NUMBER()
                                          OVER(ORDER BY  F.[Field_fk]
                                                       , S.[Scenario_id]
                                                       , R.[Religion_group_fk]
                                                       , N.[Origin_Nation_fk]
                                                       , N.[Destination_Nation_fk]
                                                       , X.[Sex_fk]
                                                       , A.[Age_fk]                 )
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [MF_shortset_pk]              =                D.[Migration_Flow_pk]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      , F.[Field_fk]
      , S.[Scenario_id]
      , N.[Origin_Nation_fk]
      , N.[Destination_Nation_fk]
      , R.[Religion_group_fk]
      , X.[Sex_fk]
      , A.[Age_fk]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [Migrant_Count]               = CASE WHEN      D.[Migrant_Count]               IS     NULL
                                                   THEN     0
                                               WHEN      D.[Migrant_Count]               IS NOT NULL
                                                   THEN  D.[Migrant_Count]      
                                           END
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,   [Display_by_Religion]         = CASE WHEN      D.[Display_by_Religion]         IS     NULL
                                                   THEN     0
                                               WHEN      D.[Display_by_Religion]         IS NOT NULL
                                                   THEN  D.[Display_by_Religion]
                                           END
      ,   [Display_as_Destination_Ctry] = CASE WHEN      D.[Display_as_Destination_Ctry] IS     NULL
                                                   THEN     0
                                               WHEN      D.[Display_as_Destination_Ctry] IS NOT NULL
                                                   THEN  D.[Display_as_Destination_Ctry]
                                           END
      ,   [Display_as_Origin_Ctry]      = CASE WHEN      D.[Display_as_Origin_Ctry]      IS     NULL
                                                   THEN     0
                                               WHEN      D.[Display_as_Origin_Ctry]      IS NOT NULL
                                                   THEN  D.[Display_as_Origin_Ctry]
                                           END
/***************************************************************************************************************************************************************/
INTO      [vm__Migration_Flow_all]
/***************************************************************************************************************************************************************/
FROM
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--select n=count(*) from
 (  SELECT DISTINCT [Field_fk]                          FROM [forum].[dbo].[Pew_Migration_Flow]     ) F  /**  10 year-periods            =           10 rows  **/
CROSS                                                                                                    /**                                                  **/
JOIN                                                                                                     /**                                                  **/
 (  SELECT DISTINCT [Scenario_id]                       FROM [forum].[dbo].[Pew_Migration_Flow]     ) S  /**   1 scenario                =           10 rows **/
CROSS                                                                                                    /**                                                  **/
JOIN                                                                                                     /**                                                  **/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
 (  SELECT DISTINCT [Origin_Nation_fk]                                                                   /**                                                  **/
                  , [Destination_Nation_fk]             FROM                                             /**                                                  **/
    --select n=count(*) from                                                                             /**                                                  **/
  ( SELECT DISTINCT [Origin_Nation_fk]       = [N_fk]   FROM                                             /**                                                  **/
   (SELECT DISTINCT [Origin_Nation_fk]      AS [N_fk]   FROM [forum].[dbo].[Pew_Migration_Flow]          /**                                                  **/
    UNION ALL                                                                                            /**                                                  **/
    SELECT DISTINCT [Destination_Nation_fk] AS [N_fk]   FROM [forum].[dbo].[Pew_Migration_Flow] ) c      /**                                                  **/
                                                                                                 ) O     /** 155 countries of origin                          **/
  CROSS                                                                                                  /**                                                  **/
  JOIN                                                                                                   /**                                                  **/
  ( SELECT DISTINCT [Destination_Nation_fk]  = [N_fk]   FROM                                             /**                                                  **/
   (SELECT DISTINCT [Origin_Nation_fk]      AS [N_fk]   FROM [forum].[dbo].[Pew_Migration_Flow]          /**                                                  **/
    UNION ALL                                                                                            /**                                                  **/
    SELECT DISTINCT [Destination_Nation_fk] AS [N_fk]   FROM [forum].[dbo].[Pew_Migration_Flow] ) c      /**                                                  **/
                                                                                                 ) D     /** 155 countries of destination                     **/
  WHERE                                                                                                  /** NOTE: filter out when origin = destination       **/
                    [Origin_Nation_fk]                                                                   /**     155 x 155 =>   24,025                        **/
                 != [Destination_Nation_fk]                                                              /**                  -    155                        **/
                                                                                                    ) N  /**                    23,870    =      238,700 rows **/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
CROSS                                                                                                    /**                                                  **/
JOIN                                                                                                     /**                                                  **/
 (  SELECT DISTINCT [Religion_group_fk]                 FROM [forum].[dbo].[Pew_Migration_Flow]     ) R  /**   8 religious groups         =    1,909,600 rows **/
CROSS                                                                                                    /**                                                  **/
JOIN                                                                                                     /**                                                  **/
 (  SELECT DISTINCT [Sex_fk]                            FROM [forum].[dbo].[Pew_Migration_Flow]     ) X  /**   2 sex groups               =    3,819,200 rows **/
CROSS                                                                                                    /**                                                  **/
JOIN                                                                                                     /**                                                  **/
 (  SELECT DISTINCT [Age_fk]                            FROM [forum].[dbo].[Pew_Migration_Flow]     ) A  /**  14 age cohorts (0 - 69 yrs) =   53,468,800 rows **/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
FULL                                                                                                     /**                                                  **/
JOIN                                                                                                     /**                                                  **/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
  --select n=count(*)                                   from [forum].[dbo].[Pew_Migration_Flow]          /**                                                  **/
 (  SELECT           *                                  FROM [forum].[dbo].[Pew_Migration_Flow]     ) D  /**  although 16,431,538 matched ->  53,468,800 rows **/
 ON               D.[Field_fk]                                                                           /**                                                  **/
                = F.[Field_fk]                                                                           /**                                                  **/
 AND              D.[Scenario_id]                                                                        /**                                                  **/
                = S.[Scenario_id]                                                                        /**                                                  **/
 AND              D.[Origin_Nation_fk]                                                                   /**                                                  **/
                = N.[Origin_Nation_fk]                                                                   /**                                                  **/
 AND              D.[Destination_Nation_fk]                                                              /**                                                  **/
                = N.[Destination_Nation_fk]                                                              /**                                                  **/
 AND              D.[Religion_group_fk]                                                                  /**                                                  **/
                = R.[Religion_group_fk]                                                                  /**                                                  **/
 AND              D.[Sex_fk]                                                                             /**                                                  **/
                = X.[Sex_fk]                                                                             /**                                                  **/
 AND              D.[Age_fk]                                                                             /**                                                  **/
                = A.[Age_fk]                                                                             /**                                                  **/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/

