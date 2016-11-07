*******************************************************************************************************************
{
*******************************************************************************************************************
*******************************************************************************************************************
**                                                                                                               **
**       Stata script (do file):                                                                                 **
**                                  postS34_Tables_by_Country.do                                                 **
**                                                                                                               **
**                                                                                                               **
**  Script for creating tables of Results by Country (One table per each question)                               **
**                                                                                                               **
**  NOTE: This script works using the following inputs:                                                          **
**                                                                                                               **
**        -   Blank Excel documents pre-formated to store data                                                   **
**        -   [forum] SQL Server database tables                                                                 **
**                                                                                                               **
*******************************************************************************************************************
*******************************************************************************************************************
* Select work directory:
cd   C:\data\Restrictions
* save date & time:
local d = subinstr( (c(current_date)) ," ","",.)
local t = subinstr( (c(current_time)) ,":","",.)
* Create log of the session:
*capture log close
*log using "T6_`d'_`t'.log", replace
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
* Step 1:  Download data from the corresponding view in the database & copy blank Excel sheet                    **
{
*******************************************************************************************************************
clear
#delimit ;
odbc load, exec 
("
/**********************************************************************************************/
SELECT
       [Ctry_EditorialName]
      ,[Variable]
      ,[Y2007]
      ,[Y2011]
      ,[Y2012]
  FROM [for_x].[dbo].[Vx_d_Vars_by_Ctry]
/**********************************************************************************************/
")
connectionstring("DRIVER={SQL Server};SERVER=ForumDB;DATABASE=for_x; ")
clear ;
#delimit cr
* wait 30 seonds for data retreiving
* sleep 30000
* Compress data:
qui: compress
*
tostring Y2007 , replace force format(%6.2f)
tostring Y2011 , replace force format(%6.2f)
tostring Y2012 , replace force format(%6.2f)

* the mark for South Sudan for the baseline year (2007) should be “-“ rather than 
replace Y2007 = "-" if Y2007 == "."  // 47 changes expected
replace Y2011 = "-" if Y2007 == "."  //  0 changes expected
replace Y2012 = "-" if Y2007 == "."  //  0 changes expected

*
replace Variable = "GRI_08" if Variable == "GRI_08_for_index"
replace Variable = "SHI_11" if Variable == "SHI_11_for_index"

* sorting order
sort Ctry_EditorialName	Variable

* save working set
save TB1, replace
* Copy Excel Format
copy T6_TopLines_by_Ctry_blank.xlsx   TL.xlsx, replace
*******************************************************************************************************************
}
*******************************************************************************************************************
* Step 2:  Toplines for all index variables for baseline year, previous year, and latest year.                   **
*          Get 47 tables of Results by Country (One table per each question)                                     **
{
*******************************************************************************************************************
* Loop to export each variables to be displayed
* in the Excel tables:
{
foreach var in   ///
GRI_01           ///
GRI_02           ///
GRI_03           ///
GRI_04           ///
GRI_05           ///
GRI_06           ///
GRI_07           ///
GRI_08           ///
GRI_09           ///
GRI_10           ///
GRI_11           ///
GRI_12           ///
GRI_13           ///
GRI_14           ///
GRI_15           ///
GRI_16           ///
GRI_17           ///
GRI_18           ///
GRI_19           ///
GRI_20           ///
GRI_20_01        ///
GRI_20_02        ///
GRI_20_03        ///
GRI_20_03_a      ///
GRI_20_03_b      ///
GRI_20_03_c      ///
GRI_20_04        ///
GRI_20_05        ///
SHI_01           ///
SHI_01_a         ///
SHI_01_b         ///
SHI_01_c         ///
SHI_01_d         ///
SHI_01_e         ///
SHI_01_f         ///
SHI_02           ///
SHI_03           ///
SHI_04           ///
SHI_05           ///
SHI_06           ///
SHI_07           ///
SHI_08           ///
SHI_09           ///
SHI_10           ///
SHI_11           ///
SHI_12           ///
SHI_13           ///
{
local sheet =  subinstr("`var'","_",".",.)
di "`sheet'"
*****************
use  TB1, clear
keep if Variable ==    "`var'"
drop    Variable
save TB2, replace
*****************
di "saving -->>   `var'  "
keep if _n <  67
export excel  ///
using TL.xlsx, sheet("`sheet'") ///
sheetmodify cell(B7)
*****************
*****************
use TB2, clear
*****************
drop if _n <  67
keep if _n <  67
export excel  ///
using TL.xlsx, sheet("`sheet'") ///
sheetmodify cell(H7)
*****************
*****************
use TB2, clear
*****************
drop if _n <  67
drop if _n <  67
export excel  ///
using TL.xlsx, sheet("`sheet'") ///
sheetmodify cell(N7)
}
*****
}
*******************************************************************************************************************
*clear
erase TB1.dta
erase TB2.dta
*******************************************************************************************************************
}
*******************************************************************************************************************
*******************************************************************************************************************
*******************************************************************************************************************
* Copy Final Excel Documents                                                                                     **
{
*******************************************************************************************************************
clear
local d = subinstr( (c(current_date)) ," ","",.)
local t = subinstr( (c(current_time)) ,":","",.)
copy TL.xlsx                                      T6_TopLines_by_Ctry_`d'_`t'.xlsx
copy TL.xlsx                                      T6_TopLines_by_Ctry.xlsx          , replace
copy TL.xlsx   S:\Forum\Database\RestrictionsData\T6_TopLines_by_Ctry.xlsx          , replace
*******************************************************************************************************************
* Back to main work directory:
cd "S:\Forum\Database\MANAGEMENT\common\GRSHoR_analysis"
*******************************************************************************************************************
}
*******************************************************************************************************************
*******************************************************************************************************************
* Display final message:
di as error                                                                                                                             ///
"*************************************************************************************************************************" _newline    ///
"*************************************************************************************************************************" _newline    ///
"**                                                                                                                     **" _newline    ///
"**       Stata script (do file) created a set of tables of Results by Country:                                         **" _newline    ///
"**                     -   T6_TopLines_by_Ctry.xlsx                                                                    **" _newline    ///
"**                          (One table per each question)                                                              **" _newline    ///
"**                                                                                                                     **" _newline    ///
"**   (                             postS34_Tables_by_Country.do                                                    )   **" _newline    ///
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
