USE [GRSHRcode]
GO

DROP    TABLE  [tr___01_]
SELECT * INTO  [tr___01_]
         FROM  [vr___01_]
GO

DROP    TABLE  [tr___06_wDB_LongData_ALL_byCYQ]
SELECT * INTO  [tr___06_wDB_LongData_ALL_byCYQ]
         FROM  [vr___06_wDB_LongData_ALL_byCYQ]
GO

DROP    TABLE  [tr___07_wDB_WideData_ALL_byCY]
SELECT * INTO  [tr___07_wDB_WideData_ALL_byCY]
         FROM  [vr___07_wDB_WideData_ALL_byCY]
GO
/***************************************************************************************************************************************************************/
