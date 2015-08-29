SELECT 
        [Name]    = [11777X12X33742]
       ,[coder]   = [11777X12X33743]
       ,[YEAR]    = [11777X12X33744]
       ,[Ctry]    = [11777X12X33745]
       ,[keyname]
       ,[expltext]
FROM
(
select *
  FROM [limesurvey].[dbo].[lime_survey_11777]
WHERE [submitdate] IS NOT NULL
--order by [11777X12X33745]
) NONULLS
UNPIVOT
  (
     expltext
FOR
     keyname
in (
  [11777X1X34365]
, [11777X1X34366]
, [11777X1X34367]
, [11777X1X34404]
, [11777X1X34405]
, [11777X3X34368]
, [11777X3X34369]
, [11777X3X34370]
, [11777X3X34371]
, [11777X3X34372]
, [11777X3X34373]
, [11777X3X34374]
, [11777X4X34375]
, [11777X4X34376]
, [11777X4X34377]
, [11777X4X34378]
, [11777X4X34379]
, [11777X4X34380]
, [11777X4X34381]
, [11777X4X34382]
, [11777X4X34383]
, [11777X4X34384]
, [11777X5X34385]
, [11777X5X34386]
, [11777X5X34387]
, [11777X5X34388]
, [11777X5X34389]
, [11777X6X34390]
, [11777X6X34391]
, [11777X6X34392]
, [11777X7X34393]
, [11777X8X34394]
, [11777X8X34395]
, [11777X8X34396]
, [11777X8X34397]
, [11777X8X34398]
, [11777X8X34399]
, [11777X8X34400]
, [11777X8X34401]
                   ) ) as UNPIVTD1