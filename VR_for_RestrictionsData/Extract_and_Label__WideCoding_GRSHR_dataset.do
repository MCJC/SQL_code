*******************************************************************************************************************
{  // Program:   for extracting coding GRSHR data to be used in preliminar analysis (by Country and Year)        **
*******************************************************************************************************************
*******************************************************************************************************************
**                                                                                                               **
**       Stata script (do file):                                                                                 **
**                                  Extract_and_Label__coding_GRSHR_dataset.do                                   **
**                                                                                                               **
**                                                                                                               **
**  NOTE: This script works using [GRSHRcode] SQL Server database tables ("dsn" is ForumDB)                      **
**                                                                                                               **
**                                                                                                               **
*******************************************************************************************************************
*******************************************************************************************************************
* If needed, select working directory by replacing the proper name:
cd   "S:\Forum\Database\MANAGEMENT\SQL_code_in_SharedDrive\VR_for_RestrictionsData"
* save date & time:
local d = subinstr( (c(current_date)) ," ","",.)
local t = subinstr( (c(current_time)) ,":","",.)
* Create log of the session:
capture log close
log using "Extraction_of_CodingData.log", replace
* context:
clear all
version 13
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
  FROM [GRSHRcode].[dbo].[vr___04_wlabSemiWide_byCtry&Yr]
/**********************************************************************************************/
")
connectionstring("DRIVER={SQL Server};SERVER=ForumDB;DATABASE=GRSHRcode; ")
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
  FROM [GRSHRcode].[dbo].[vr___04_wDB_SemiWide_byCtry&Yr]
")
connectionstring("DRIVER={SQL Server};SERVER=ForumDB;DATABASE=GRSHRcode; ")
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
save  S:\Forum\Database\RestrictionsDataSets\CodingDataWideVersion_`d'_.dta, replace
save  S:\Forum\Database\RestrictionsDataSets\CodingDataWideVersion.dta     , replace
* clear 
clear
*******************************************************************************************************************
**copy                                                                                                            ///
**"S:\Forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData\Extract_and_Label__WideWorkng_GRSHR_dataset.do"  ///
**"C:\do\WW_GRSHR.do"                                                                                  , replace   //
*******************************************************************************************************************
* delete labeling do file
erase "S:\Forum\Database\MANAGEMENT\SQL_code_in_SharedDrive\VR_for_RestrictionsData\VarWorkingLabels.do"
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
"**       Stata script (do file) created the dataset CodingDataWideVersion.dta                                **" _newline    ///
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
