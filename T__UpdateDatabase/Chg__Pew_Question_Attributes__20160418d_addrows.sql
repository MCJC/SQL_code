/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
/*****                                                    STEP 000                                                    *****/
/*****                                           BackUp  current Table(s)                                             *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Attributes' + '_' + @CrDt + 'c]
                  FROM      [forum].[dbo].[Pew_Question_Attributes]'                      )
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
	INSERT INTO                                                                /* insert statement                        */
	                                      [Pew_Question_Attributes]            /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT                                                                         /* select statement...                     */
/*------------------------------------------------------------------------------------------------------------------------*/
             [Question_Attributes_pk]  = ROW_NUMBER()
                                         OVER(ORDER BY  [Question_Std_pk])     /* number all rows                         */
                                      + (SELECT MAX([Question_Attributes_pk])  /* add currently max pk                    */
                                           FROM [Pew_Question_Attributes])     /* from QAttributes                        */
/*------------------------------------------------------------------------------------------------------------------------*/
           , [Question_Std_fk]         = [Question_Std_pk]
           , [attk]                    = 'PubDS_sort'
           , [attr]                    = [s]
/*------------------------------------------------------------------------------------------------------------------------*/
      FROM
           (
/*------------------------------------------------------------------------------------------------------------------------*/
          SELECT [v] = 'GRI_01'                     , [s] = '01'
    UNION SELECT [v] = 'GRI_02'                     , [s] = '02'
    UNION SELECT [v] = 'GRI_03'                     , [s] = '03'
    UNION SELECT [v] = 'GRI_04'                     , [s] = '04'
    UNION SELECT [v] = 'GRI_05'                     , [s] = '05'
    UNION SELECT [v] = 'GRI_06'                     , [s] = '06'
    UNION SELECT [v] = 'GRI_07'                     , [s] = '07'
    UNION SELECT [v] = 'GRI_08_for_index'           , [s] = '08'
    UNION SELECT [v] = 'GRI_09'                     , [s] = '09'
    UNION SELECT [v] = 'GRI_10'                     , [s] = '10'
    UNION SELECT [v] = 'GRI_11'                     , [s] = '11'
    UNION SELECT [v] = 'GRI_11_xG1'                 , [s] = '12'
    UNION SELECT [v] = 'GRI_11_xG2'                 , [s] = '13'
    UNION SELECT [v] = 'GRI_11_xG3'                 , [s] = '14'
    UNION SELECT [v] = 'GRI_11_xG4'                 , [s] = '15'
    UNION SELECT [v] = 'GRI_11_xG5'                 , [s] = '16'
    UNION SELECT [v] = 'GRI_11_xG7'                 , [s] = '17'
    UNION SELECT [v] = 'GRI_11_xG6'                 , [s] = '18'
    UNION SELECT [v] = 'GRI_12'                     , [s] = '19'
    UNION SELECT [v] = 'GRI_13'                     , [s] = '20'
    UNION SELECT [v] = 'GRI_14'                     , [s] = '21'
    UNION SELECT [v] = 'GRI_15'                     , [s] = '22'
    UNION SELECT [v] = 'GRI_16_ny'                  , [s] = '23'
    UNION SELECT [v] = 'GRI_16'                     , [s] = '24'
    UNION SELECT [v] = 'GRI_17'                     , [s] = '25'
    UNION SELECT [v] = 'GRI_18'                     , [s] = '26'
    UNION SELECT [v] = 'GRI_19_ny'                  , [s] = '27'
    UNION SELECT [v] = 'GRI_19'                     , [s] = '28'
    UNION SELECT [v] = 'GRI_19_e_scaled'            , [s] = '29'
    UNION SELECT [v] = 'GRI_19_f_scaled'            , [s] = '30'
    UNION SELECT [v] = 'GRI_19_d_scaled'            , [s] = '31'
    UNION SELECT [v] = 'GRI_19_c_scaled'            , [s] = '32'
    UNION SELECT [v] = 'GRI_19_b_scaled'            , [s] = '33'
    UNION SELECT [v] = 'GRI_20_01'                  , [s] = '34'
    UNION SELECT [v] = 'GRI_20_02'                  , [s] = '35'
    UNION SELECT [v] = 'GRI_20_03_top'              , [s] = '36'
    UNION SELECT [v] = 'GRI_20_03_a'                , [s] = '37'
    UNION SELECT [v] = 'GRI_20_03_b'                , [s] = '38'
    UNION SELECT [v] = 'GRI_20_03_c'                , [s] = '39'
    UNION SELECT [v] = 'GRI_20_04'                  , [s] = '40'
    UNION SELECT [v] = 'GRI_20_05'                  , [s] = '41'
    UNION SELECT [v] = 'SHI_01_a_dummy'             , [s] = '42'
    UNION SELECT [v] = 'SHI_01_b_dummy'             , [s] = '43'
    UNION SELECT [v] = 'SHI_01_c_dummy'             , [s] = '44'
    UNION SELECT [v] = 'SHI_01_d_dummy'             , [s] = '45'
    UNION SELECT [v] = 'SHI_01_e_dummy'             , [s] = '46'
    UNION SELECT [v] = 'SHI_01_f_dummy'             , [s] = '47'
    UNION SELECT [v] = 'SHI_01'                     , [s] = '48'
    UNION SELECT [v] = 'SHI_01_xG1'                 , [s] = '49'
    UNION SELECT [v] = 'SHI_01_xG2'                 , [s] = '50'
    UNION SELECT [v] = 'SHI_01_xG3'                 , [s] = '51'
    UNION SELECT [v] = 'SHI_01_xG4'                 , [s] = '52'
    UNION SELECT [v] = 'SHI_01_xG5'                 , [s] = '53'
    UNION SELECT [v] = 'SHI_01_xG7'                 , [s] = '54'
    UNION SELECT [v] = 'SHI_01_xG6'                 , [s] = '55'
    UNION SELECT [v] = 'SHI_02'                     , [s] = '56'
    UNION SELECT [v] = 'SHI_03'                     , [s] = '57'
    UNION SELECT [v] = 'SHI_04_ny'                  , [s] = '58'
    UNION SELECT [v] = 'SHI_04'                     , [s] = '59'
    UNION SELECT [v] = 'SHI_05_ny'                  , [s] = '60'
    UNION SELECT [v] = 'SHI_05'                     , [s] = '61'
    UNION SELECT [v] = 'SHI_06'                     , [s] = '62'
    UNION SELECT [v] = 'SHI_07'                     , [s] = '63'
    UNION SELECT [v] = 'SHI_08'                     , [s] = '64'
    UNION SELECT [v] = 'SHI_09'                     , [s] = '65'
    UNION SELECT [v] = 'SHI_10'                     , [s] = '66'
    UNION SELECT [v] = 'SHI_11_for_index'           , [s] = '67'
    UNION SELECT [v] = 'SHI_12'                     , [s] = '68'
    UNION SELECT [v] = 'SHI_13'                     , [s] = '69'
    UNION SELECT [v] = 'GRX_22_01_ny'               , [s] = '70'
    UNION SELECT [v] = 'GRX_22_02_ny'               , [s] = '71'
    UNION SELECT [v] = 'GRX_22_03_ny'               , [s] = '72'
    UNION SELECT [v] = 'GRX_22_04_ny'               , [s] = '73'
    UNION SELECT [v] = 'GRX_30'                     , [s] = '74'
/*------------------------------------------------------------------------------------------------------------------------*/
           ) DDTT
/*------------------------------------------------------------------------------------------------------------------------*/
			INNER
			JOIN
/*------------------------------------------------------------------------------------------------------------------------*/
			[Pew_Question_Std]
			ON [v] = [Question_abbreviation_std]
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 002                                                    *****/
/**************************************************************************************************************************/
-- check results                                                                                                          --
	select * from                         [Pew_Question_Attributes]            /* test statement...                       */
WHERE                                                                          /* filters...                              */
             [attk]                    = 'PubDS_sort'                          /*            filter condition             */
/**************************************************************************************************************************/
