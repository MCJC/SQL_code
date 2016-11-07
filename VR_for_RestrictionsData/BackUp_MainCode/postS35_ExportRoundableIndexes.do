*******************************************************************************************************************
{
*******************************************************************************************************************
*******************************************************************************************************************
**                                                                                                               **
**       Stata script (do file):                                                                                 **
**                                  postS35_ExportRoundableIndexes.do                                            **
**                                                                                                               **
**                                                                                                               **
**  Script for deleting & re-creating table [for_x].[dbo].[Pew_Indexes]                                          **
**                                                                                                               **
**  NOTE:                                                                                                        **
**        This program works accesing the SQL Server ("dsn" is ForumDB) as ODBC source                           **
**                                                                                                               **
*******************************************************************************************************************
*******************************************************************************************************************
*
* Select work directory:
cd "C:\data\Restrictions_ver2013"
* save date & time:
local d = subinstr( (c(current_date)) ," ","",.)
local t = subinstr( (c(current_time)) ,":","",.)
* Create log of the session:
*capture log close
*log using "Restrictions_`d'_`t'.log", replace
* context:
*clear all
version 12
set more off
  pause off
* pause on
  set trace off
* set trace on
* Save & Display date & time to check how long the program takes to run:
scalar cxd=(c(current_date))
scalar cxt=(c(current_time))
di cxd "   " cxt
*******************************************************************************************************************
}
*******************************************************************************************************************
* Step 1 [from database: do not run in laptop]      
{
*******************************************************************************************************************
#delimit ;
odbc load, exec 
("
/**********************************************************************************************/
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
       *
  FROM
       [for_x].[dbo].[Vx_e_LongIndex]
/**********************************************************************************************/
")
connectionstring("DRIVER={SQL Server};SERVER=ForumDB;DATABASE=forum; ")
clear ;
#delimit cr
qui: compress
*
gen     Index_Name = ""
replace Index_Name = "Government Restrictions Index" if Index_Abbreviation == "GRI"
replace Index_Name = "Social Hostilities Index"      if Index_Abbreviation == "SHI"
replace Index_Name = "Government Favoritism Index"   if Index_Abbreviation == "GFI"
*
recast float                         Index_Value, force
gen    float I_Rounded_Value = round(Index_Value, 0.1)
*
sort Nation_fk Index_Abbreviation Question_Year
*
save Indexes, replace
*******************************************************************************************************************
}
*******************************************************************************************************************
* Create blank table Pew_Indexes
{
*******************************************************************************************************************
* SQL SERVER statements (blank table)
#delimit ;
clear;
odbc exec 
("
IF OBJECT_ID  (N'[for_x].[dbo].[Pew_Indexes]', N'U') IS NOT NULL
DROP   TABLE     [for_x].[dbo].[Pew_Indexes]
CREATE TABLE     [for_x].[dbo].[Pew_Indexes]
                                                    (   [Nation_fk]             [int]         NOT NULL
													  , [Ctry_EditorialName]    [varchar](50)     NULL
													  , [Region]                [varchar](50)     NULL
													  , [Index_Year]            [varchar](50)     NULL
													  , [Index_abbreviation]    [varchar](5)      NULL
													  , [Index_name]            [varchar](50)     NULL
													  , [Index_value]           [float]           NULL
													  , [I_Rounded_value]       [decimal](4,1)    NULL
													  , [Question_Year]         [int]             NULL
                                                                                                       ) ON [PRIMARY]
"),
connectionstring("DRIVER={SQL Server};SERVER=ForumDB;DATABASE=for_x; ")
;
#delimit cr
pause
*******************************************************************************************************************
}
*******************************************************************************************************************
*******************************************************************************************************************
* Load into the DB updated data
use Indexes, clear
odbc insert, table("Pew_Indexes")                                         ///
connectionstring("DRIVER={SQL Server};SERVER=ForumDB;DATABASE=for_x; ")    //
*******************************************************************************************************************
clear
* Back to main work directory:
cd "S:\Forum\Database\MANAGEMENT\Y2013\Load_using__for_x"
*******************************************************************************************************************
*******************************************************************************************************************
*******************************************************************************************************************
* Display final message:
di as error                                                                                                                             ///
"*************************************************************************************************************************" _newline    ///
"*************************************************************************************************************************" _newline    ///
"**                                                                                                                     **" _newline    ///
"**       Stata script (do file) re-created table:                                                                      **" _newline    ///
"**                                             [for_x].[dbo].[Pew_Indexes]                                             **" _newline    ///
"**                                                                                                                     **" _newline    ///
"**                                                                                                                     **" _newline    ///
"**   (                                      postS35_ExportRoundableIndexes.do                                      )   **" _newline    ///
"**                                                                             END of Stata script (do file)!          **" _newline    ///
"**                                                                                                                     **" _newline    ///
"**   Started: " _column(23)    cxd            _column(35) "at" _column(39)    cxt                        _column(120) "**" _newline    ///
"**   Ended:   " _column(23) (c(current_date)) _column(35) "at" _column(39) (c(current_time))             _column(120) "**" _newline    ///
"**"                                                                                                      _column(120) "**" _newline    ///
"*************************************************************************************************************************" _newline    ///
"*************************************************************************************************************************" _newline     //
*log close


*  *  *****  *****  *****          *          *****  *     *
*  *  *      *  *   *              *          *   *  **   **
****  *****  ***    *****          *          *****  * * * *
*  *  *      * *    *              *          *   *  *  *  *
*  *  *****  *  *   *****          *          *   *  *     *

