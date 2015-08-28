/**************************************************************************************************************************/
/***                  *****************************************************************************************************/
/***   UPDATE FLAGS   *****************************************************************************************************/
/***                  *****************************************************************************************************/
/**************************************************************************************************************************/
/**************************************************************************************************************************/
USE
       [forumBlob]
GO
/**************************************************************************************************************************/
/*****                                           BackUp  current Table(s)                                             *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT *
                INTO  [_bk_forum].[dbo].[Pew_Flag_' + @CrDt + ']
                FROM  [forumBlob].[dbo].[Pew_Flag'          + ']' )
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT *
                INTO  [_bk_forum].[dbo].[flag_' + @CrDt + ']
                FROM  [forumBlob].[dbo].[flag'          + ']' )
/**************************************************************************************************************************/
-- add flags: 
INSERT
INTO
       [Pew_Flag]
                (  Flag_pk
                 , Nation_fk
                 , Flag_name )
          SELECT '233', '238', 'cura-flag.gif'
UNION ALL SELECT '234', '239', 'sint-flag.gif'
UNION ALL SELECT '235', '240', 'cari-flag.gif'
/*------------------------------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------------------------*/
UPDATE
       [Pew_Flag]
SET    [Flag_image] = (SELECT *
                FROM   OPENROWSET(BULK N'C:\data\Flag_of_Curaçao.gif',
                       SINGLE_BLOB) AS x)
WHERE  [Nation_fk]  = 238
/*------------------------------------------------------------------------------------------------------------------------*/
UPDATE
       [Pew_Flag]
SET    [Flag_image] = (SELECT *
                FROM   OPENROWSET(BULK N'C:\data\Flag_of_Sint_Maarten.gif',
                       SINGLE_BLOB) AS x)
WHERE  [Nation_fk]  = 239
/*------------------------------------------------------------------------------------------------------------------------*/
UPDATE
       [Pew_Flag]
SET    [Flag_image] = (SELECT *
                FROM   OPENROWSET(BULK N'C:\data\Flag_of_Car_Netherlands.gif',
                       SINGLE_BLOB) AS x)
WHERE  [Nation_fk]  = 240
/********************************************************************************************************************************************************************/
-- check results by exporting image
-- Keep the command on ONE LINE - SINGLE LINE!!!

DECLARE  @sql NVARCHAR(4000)
 
set @sql = 'BCP "SELECT Flag_image FROM forumBlob.dbo.Pew_Flag WHERE Nation_fk = 238" QUERYOUT F:\JC\test\exp_238.jpg -T -f F:\JC\test\testblob.fmt -S ' + @@SERVERNAME
EXEC master.dbo.xp_CmdShell @sql 

set @sql = 'BCP "SELECT Flag_image FROM forumBlob.dbo.Pew_Flag WHERE Nation_fk = 239" QUERYOUT F:\JC\test\exp_239.jpg -T -f F:\JC\test\testblob.fmt -S ' + @@SERVERNAME
EXEC master.dbo.xp_CmdShell @sql 

set @sql = 'BCP "SELECT Flag_image FROM forumBlob.dbo.Pew_Flag WHERE Nation_fk = 240" QUERYOUT F:\JC\test\exp_240.jpg -T -f F:\JC\test\testblob.fmt -S ' + @@SERVERNAME
EXEC master.dbo.xp_CmdShell @sql 

set @sql = 'BCP "SELECT Flag_image FROM forumBlob.dbo.Pew_Flag WHERE Nation_fk =   9" QUERYOUT F:\JC\test\exp_009.jpg -T -f F:\JC\test\testblob.fmt -S ' + @@SERVERNAME
EXEC master.dbo.xp_CmdShell @sql 
/********************************************************************************************************************************************************************/
-- drop Netherlnds Antilles & Drop other working table
DELETE
FROM
       [Pew_Flag]
WHERE  [Nation_fk]  = 147
GO
/*------------------------------------------------------------------------------------------------------------------------*/
DROP TABLE [forumBlob].[dbo].[flag]
GO
/*------------------------------------------------------------------------------------------------------------------------*/
