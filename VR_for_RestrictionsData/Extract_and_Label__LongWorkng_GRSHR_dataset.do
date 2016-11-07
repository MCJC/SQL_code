*******************************************************************************************************************
{  // Program:   for extracting GRSHR to be used in the analysis (by Country and Year)                           **
*******************************************************************************************************************
*******************************************************************************************************************
**                                                                                                               **
**       Stata script (do file):                                                                                 **
**                                  Extract_and_Label__workng_GRSHR_dataset.do                                   **
**                                                                                                               **
**  NOTE: This script works using [forum_ResAnal] SQL Server database tables:                                    **
**                                                                                                               **
**        -  [vr___04_cDB_SemiWide_byCtry&Yr]                                                                    **
**        -  [vr___04_lab_SemiWide_byCtry&Yr]                                                                    **
**                                                                                                               **
**        This program works using SQL Server ("dsn" is ForumDB) as the main data source                         **
**                                                                                                               **
*******************************************************************************************************************
*******************************************************************************************************************
* If needed, select working directory by replacing the proper name:
cd   "S:\Forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData"
* save date & time:
local d = subinstr( (c(current_date)) ," ","",.)
local t = subinstr( (c(current_time)) ,":","",.)
* Create log of the session:
capture log close
log using "Extraction_of_LongWorkingData.log", replace
* context:
clear all
version 14
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
{  //   Step 1:  Create labeling script                                                                          **
*******************************************************************************************************************
#delimit ;
odbc load, exec 
("
/**********************************************************************************************/
SELECT *
  FROM [forum_ResAnal].[dbo].[vr___06_cDB_LongData_ALL_byCYQ]
/**********************************************************************************************/
")
connectionstring("DRIVER={SQL Server};SERVER=ForumDB;DATABASE=forum_ResAnal; ")
clear ;
#delimit cr
* wait 15 seonds for data retreiving
sleep 15000
* Compress data:
qui: compress
* count and store number of rows for iteration 
qui count
local n = r(N)
* Create .do file for labeling variables
*
******************************************************************************************************************
capture ///
file close                handle
file open                 handle using VarWorkingLabels.do, write text replace
* - -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - - *
               file write handle "***   Script created from the database (forum_ResAnal)                   ***" _n
               file write handle "***   on `= c(current_date)' at `= c(current_time)' "       _column(87) "***" _n
               file write handle                                                                                _n
               file write handle                                                                                _n
* - -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - - *
  forvalues ///
    x = 1/`n' {
               file write handle " label var " (VarName[`x']) " " (VarLabel[`x'])  _n
              }
******************************************************************************************************************
file close                handle
******************************************************************************************************************
}
*******************************************************************************************************************
{  //   Step 2:  Retreive, label and save dataset as a .DTA file                                                 **
*******************************************************************************************************************
clear
#delimit ;
odbc load, exec 
("
SELECT *
  FROM [forum_ResAnal].[dbo].[vr___04_cDB_SemiWide_byCtry&Yr]
")
connectionstring("DRIVER={SQL Server};SERVER=ForumDB;DATABASE=forum_ResAnal; ")
clear ;
#delimit cr
* wait 15 seonds for data retreiving
 sleep 15000
* Compress data:
qui: compress
* label variables using the script
do VarWorkingLabels.do
*******************************************************************************************************************
* save dataset
local d = subinstr( (c(current_date)) ," ","",.)
save  S:\Forum\Database\RestrictionsDataSets\DataWideVersion_`d'_.dta, replace
save  S:\Forum\Database\RestrictionsDataSets\DataWideVersion.dta     , replace
* clear 
clear
*******************************************************************************************************************
copy                                                                                                            ///
"S:\Forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData\Extract_and_Label__LongWorkng_GRSHR_dataset.do"  ///
"C:\do\LW_GRSHR.do"                                                                                  , replace   //
*******************************************************************************************************************
* delete labeling do file
erase "S:\Forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData\VarWorkingLabels.do"
*******************************************************************************************************************
}
*******************************************************************************************************************
{  //   Step 3:  Display final message                                                                           **
*******************************************************************************************************************
*close log file
log close
*******************************************************************************************************************
* message:
di as error                                                                                                                             ///
"***************************************************************************************************************" _newline    ///
"***************************************************************************************************************" _newline    ///
"**                                                                                                           **" _newline    ///
"**                                                                                                           **" _newline    ///
"**       Stata script (do file) created a set of data for public distribution:                               **" _newline    ///
"**                                                                                                           **" _newline    ///
"**                     -   WorkingDataSet.dta                                                                **" _newline    ///
"**                                                                                                           **" _newline    ///
"**                                                                           END of Stata script (do file)!  **" _newline    ///
"**                                                                                                           **" _newline    ///
"**   Started: " _column(23)    cxd            _column(35) "at" _column(39)    cxt              _column(110) "**" _newline    ///
"**   Ended:   " _column(23) (c(current_date)) _column(35) "at" _column(39) (c(current_time))   _column(110) "**" _newline    ///
"**                                                                                                           **" _newline    ///
"**                                                                                                           **" _newline    ///
"***************************************************************************************************************" _newline    ///
"***************************************************************************************************************" _newline     //
}
*
