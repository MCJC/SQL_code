*******************************************************************************************************************
{
*******************************************************************************************************************
*******************************************************************************************************************
**                                                                                                               **
**       Stata script (do file):                                                                                 **
**                                  postS33_ExportWideData.do                                                    **
**                                                                                                               **
**                                                                                                               **
**  Script for creating wide dataset for analysis of Restrictions data:                                          **
**                      -   ForAnalysis_6Yrs.dta                                                                 **
**                      -   ForAnalysis_6Yrs.sav                                                                 **
**                      -   ForAnalysis_6Yrs.xlsx                                                                **
**                                                                                                               **
**  NOTE: This script works using the following inputs:                                                          **
**        -   Blank Excel documents pre-formated to store data                                                   **
**        -   [forum] SQL Server database tables                                                                 **
**                                                                                                               **
*******************************************************************************************************************
*******************************************************************************************************************
* Select temporary work directory:
cd "C:\data\Restrictions"
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
       [for_x].[dbo].[Vx_c_GR&SH_WideData]
/**********************************************************************************************/
")
connectionstring("DRIVER={SQL Server};SERVER=ForumDB;DATABASE=for_x; ")
clear ;
#delimit cr
qui: compress
*
recast float GRI_2007, force
recast float GRI_2008, force
recast float GRI_2009, force
recast float GRI_2010, force
recast float GRI_2011, force
recast float GRI_2012, force
recast float SHI_2007, force
recast float SHI_2008, force
recast float SHI_2009, force
recast float SHI_2010, force
recast float SHI_2011, force
recast float SHI_2012, force
recast float GFI_2007, force
recast float GFI_2008, force
recast float GFI_2009, force
recast float GFI_2010, force
recast float GFI_2011, force
recast float GFI_2012, force

/*
modify code, download long, label vars using similar to:
gen a = "label var "
gen b = char(34) + nom_mun + char(34)
gen c = nom_mun
keep abc
keep a b c
order a c b
outfile using "C:\data\test.do", noquote replace wide
do test.do

we could also label values

*/



*******************************************************************************************************************
*save                                       widedata              ,replace
save                                        ForAnalysis_6Yrs_`d'  ,replace
*******************************************************************************************************************
saveold                                      ForAnalysis_6Yrs     , replace    // to export to SPSS
*******************************************************************************************************************
export excel using     "C:\data\Restrictions\ForAnalysis_6Yrs.xlsx", sheet("dataset") firstrow(variables) replace
copy                   "C:\data\Restrictions\ForAnalysis_6Yrs.xlsx"                                             ///
         "S:\Forum\Database\RestrictionsData\ForAnalysis_6Yrs.xlsx",                                      replace
*******************************************************************************************************************
* Convert to SPSS format using StatTransfer:
winexec "C:\Program Files (x86)\StatTransfer10\ST"                            ///
                        C:\data\Restrictions\ForAnalysis_6Yrs.dta             ///
                        C:\data\Restrictions\ForAnalysis_6Yrs.sav -y

sleep 10000
copy                   "C:\data\Restrictions\ForAnalysis_6Yrs.sav"            ///
         "S:\Forum\Database\RestrictionsData\ForAnalysis_6Yrs.sav",    replace
sleep 10000
**********************************************************************************************************************
clear
pause
*******************************************************************************************************************
* Back to main work directory:
cd "S:\Forum\Database\MANAGEMENT\common\GRSHoR_analysis"
*******************************************************************************************************************
}
*******************************************************************************************************************
*******************************************************************************************************************
*******************************************************************************************************************
* Display final message:
di as error                                                                                                                             ///
"*************************************************************************************************************************" _newline    ///
"*************************************************************************************************************************" _newline    ///
"**                                                                                                                     **" _newline    ///
"**       Stata script (do file) created wide dataset for analysis of Restrictions data:                                **" _newline    ///
"**                     -   ForAnalysis_6Yrs.dta                                                                        **" _newline    ///
"**                     -   ForAnalysis_6Yrs.sav                                                                        **" _newline    ///
"**                     -   ForAnalysis_6Yrs.xlsx                                                                       **" _newline    ///
"**                                                                                                                     **" _newline    ///
"**   (                              postS33_ExportWideData.do                                                      )   **" _newline    ///
"**                                                                             END of Stata script (do file)!          **" _newline    ///
"**                                                                                                                     **" _newline    ///
"**   Started: " _column(23)    cxd            _column(35) "at" _column(39)    cxt                        _column(120) "**" _newline    ///
"**   Ended:   " _column(23) (c(current_date)) _column(35) "at" _column(39) (c(current_time))             _column(120) "**" _newline    ///
"**"                                                                                                      _column(120) "**" _newline    ///
"*************************************************************************************************************************" _newline    ///
"*************************************************************************************************************************" _newline     //
*log close
