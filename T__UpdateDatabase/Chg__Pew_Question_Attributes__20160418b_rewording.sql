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
EXEC ( ' SELECT * INTO  [_bk_forum].[dbo].[Pew_Question_Attributes' + '_' + @CrDt + 'a]
                  FROM      [forum].[dbo].[Pew_Question_Attributes]'                      )
/**************************************************************************************************************************/
/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
UPDATE                                                                         /* update statement                        */
	                                      [Pew_Question_Attributes]            /* target table in current database        */
/*------------------------------------------------------------------------------------------------------------------------*/
SET                                                                            /* set statement                           */
            [attr] = '100'                                                     /* updated/new values                      */
/*------------------------------------------------------------------------------------------------------------------------*/
--	select * from                         [Pew_Question_Attributes]            /* test statement...                       */
WHERE                                                                          /* filters...                              */
             [attk]                    = 'PubDS_scale'                         /*            filter condition             */
      AND    [attr]                 LIKE '100  --   fromerly rescaled %'       /*            filter condition             */
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 002                                                    *****/
/**************************************************************************************************************************/
-- check results                                                                                                          --
	select * from                         [Pew_Question_Attributes]            /* test statement...                       */
WHERE                                                                          /* filters...                              */
             [attk]                    = 'PubDS_scale'                         /*            filter condition             */
/**************************************************************************************************************************/