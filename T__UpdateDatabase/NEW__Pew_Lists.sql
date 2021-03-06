/**************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum].[dbo].[Pew_Lists]', N'U') IS NOT NULL
DROP   TABLE     [forum].[dbo].[Pew_Lists]
/**************************************************************************************************************************************************/

-- create
CREATE TABLE
                 [forum].[dbo].[Pew_Lists]
           (
              List_pk	INT          NOT NULL PRIMARY KEY
             ,
              List      NVARCHAR(50)
            )
            
/**************************************************************************************************************************************************/

-- Load the data into the table, adding to the current values
-- NOTICE:
-- FIRST TEST using a copy of the table to verify there are no errors
-- PKs should be included and correctly defined to do this procedure
-- Valid data, in the followinf statement, starts in row 2 (row 1 are headings)
-- Data are saved as CSV from Excel and should be copyed to FORUMDB C:\ drive 

BULK
INSERT
                 [forum].[dbo].[Pew_Lists]
FROM 
       'C:\data\lists.csv'
WITH
     (
       FIELDTERMINATOR = ','  ,
       ROWTERMINATOR   = '\n' ,
       FIRSTROW        = 2
     )

/**************************************************************************************************************************************************/
