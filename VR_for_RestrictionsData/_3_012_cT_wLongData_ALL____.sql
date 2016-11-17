USE [GRSHRcode]
GO

IF OBJECT_ID  (N'[GRSHRcode].[dbo].[tr___06_wDB_LongData_ALL_byCYQ]', N'U') IS NOT NULL
DROP TABLE       [GRSHRcode].[dbo].[tr___06_wDB_LongData_ALL_byCYQ]
SELECT * INTO    [GRSHRcode].[dbo].[tr___06_wDB_LongData_ALL_byCYQ]
            FROM [GRSHRcode].[dbo].[vr___06_wDB_LongData_ALL_byCYQ]
