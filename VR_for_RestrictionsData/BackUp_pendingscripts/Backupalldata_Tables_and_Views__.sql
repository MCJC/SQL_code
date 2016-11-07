---select [scriptingjc] = (  exec sp_helptext '[dbo].[Pew_Q&A_Std]'  )


                             exec sp_helptext '[dbo].[Pew_Q&A_Std]'  


SELECT *
              FROM sys.objects
              WHERE object_id
                    =
                    OBJECT_ID('Pew_Q&A_Std')



DECLARE           @t TABLE(line varchar(max))
INSERT INTO       @t
EXEC sp_helptext 'Pew_Q&A_Std';
DECLARE           @ddl varchar(MAX);
SELECT            @ddl = '';
/* Change CREATE to ALTER because this object all ready exists */
SELECT            @ddl
                = @ddl + REPLACE(line, 'CREATE VIEW', 'ALTER VIEW')
  FROM            @t;
select code     = @ddl;
