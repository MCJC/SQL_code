USE master
IF OBJECT_ID ('tempdb..#SizeTempTable') IS NOT NULL
DROP   TABLE           #SizeTempTable
CREATE TABLE           #SizeTempTable
                        (  database_name    varchar(MAX)
                         , database_size    varchar(MAX)
                         , unalloc_space    varchar(MAX)  )
/*****************************************************************************************************************************************************/
/*** >> Create complete list of database size in ForumDb *********************************************************************************************/
/*****************************************************************************************************************************************************/
-- Declare the variables needed for cursor to store data

  DECLARE                          --  declare variable
          db_names                 --  cursor name
                    CURSOR FOR     -- as a cursor to take values from
/*-----------------------------------------------------------------------------------------------------------*/
-- SELECT the data that will be represented by cursor
--    (i.e. "select query" to produce the table)
         SELECT   
                 name
         FROM
                 sysdatabases
-- Where Clause, Enable if you want to filter out some databases.
--        where name like 'forum'
/*-----------------------------------------------------------------------------------------------------------*/
  DECLARE                          --  declare variable
          @db_name                 --  variable name
                    varchar(100)   --  data type of the variable
DECLARE @QueryString NVARCHAR(max)
                    
/*************************************************************************************************************/
-- OPEN the cursor 
    OPEN                           -- open
           db_names                -- cursor name
/*-----------------------------------------------------------------------------------------------------------*/
-- RETRIEVE the FIRST row from cursor & STORE it into the variable(s): 
           FETCH NEXT              -- retrieve the next row
                 FROM              -- from cursor
                      db_names     -- cursor name
                 INTO              -- store it into the variable(s)
                      @db_name     --  variable name
-- @@FETCH_STATUS returns the status of the last cursor FETCH statement issued against  
-- any cursor currently opened by the connection. 
	--     @@FETCH_STATUS =  0 means The FETCH statement was successful. 
	--     @@FETCH_STATUS = -1 means The FETCH statement failed or the row was beyond the result set. 
	--     @@FETCH_STATUS = -2 means The row fetched is missing. 
			 WHILE  @@FETCH_STATUS = 0
/*************************************************************************************************************/
/*************************************************************************************************************/
-- BEGIN the procedures to be done using the values of each row of the cursor
					BEGIN
-- Procedures to be done
/*****************************************************************************************************************************************************/
/*** >> Calculate database size for each database (from tables and fields) ***************************************************************************/
/*****************************************************************************************************************************************************/
--PRINT @db_name
/*****************************************************************************************************************************/
SET @QueryString =
N' 
USE
'
+ 
       @db_name
+
N'
INSERT INTO 
            #SizeTempTable
SELECT 
     database_name = db_name()
    ,database_size = ltrim(str((convert(DECIMAL(15, 2), dbsize) + convert(DECIMAL(15, 2), logsize      )) * 8192 / 1048576, 15, 2) + '' MB'')
    ,unalloc_space = ltrim(str((
                         CASE 
                         WHEN 
                  dbsize
              >= reservedpages
                         THEN  (convert(DECIMAL(15, 2), dbsize) - convert(DECIMAL(15, 2), reservedpages)) * 8192 / 1048576
                         ELSE 0
                         END
                                                                                                                         ), 15, 2) + '' MB'')
FROM (
    SELECT dbsize = sum(convert(BIGINT, CASE 
                    WHEN STATUS & 64 = 0
                        THEN size
                    ELSE 0
                    END))
        ,logsize = sum(convert(BIGINT, CASE 
                    WHEN STATUS & 64 <> 0
                        THEN size
                    ELSE 0
                    END))
    FROM dbo.sysfiles
) AS files
,(
    SELECT reservedpages = sum(a.total_pages)
        ,usedpages = sum(a.used_pages)
        ,pages = sum(CASE 
                WHEN it.internal_type IN (
                        202
                        ,204
                        ,211
                        ,212
                        ,213
                        ,214
                        ,215
                        ,216
                        )
                    THEN 0
                WHEN a.type <> 1
                    THEN a.used_pages
                WHEN p.index_id < 2
                    THEN a.data_pages
                ELSE 0
                END)
    FROM sys.partitions p
    INNER JOIN sys.allocation_units a
        ON p.partition_id = a.container_id
    LEFT JOIN sys.internal_tables it
        ON p.object_id = it.object_id
) AS partitions
'


--print @QueryString
EXEC sp_executesql @QueryString
/*****************************************************************************************************************************************************/
/*** << Calculate database size for each database (from tables and fields) ***************************************************************************/
/*****************************************************************************************************************************************************/
-- RETRIEVE the NEXT row from cursor & STORE it into the variable(s): 
           FETCH NEXT              -- retrieve the next row
                 FROM              -- from cursor
                      db_names     -- cursor name
                 INTO              -- store it into the variable(s)
                      @db_name     --  variable name
-- END the procedures to be done using the values of each row of the cursor
                 END
/***********************************************************************************************************/
-- CLOSE the cursor 
   CLOSE                            -- close
              db_names              -- cursor name
/*************************************************************************************************************/
-- REMOVE the cursor reference and relase cursor from memory
-- (very Important )
DEALLOCATE                          -- remove reference and relase from memory
              db_names              -- cursor name
/*************************************************************************************************************/
/*************************************************************************************************************/
SELECT *
FROM   #SizeTempTable


