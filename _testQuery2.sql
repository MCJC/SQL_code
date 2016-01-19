use _Test

---Use Microsoft.ACE.OLEDB.12.0 OPENROWSET format
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0;
   Database= C:\SS\Data\TestJC.xlsx',
   [MJCC1$]);


   /*


EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0'
 
    , N'AllowInProcess', 1
 
GO


EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0'

    , N'DynamicParameters', 1

GO






icacls C:\SS /grant JUANCARLOSE45F7\juancarlos:(R,W)







c
C:\SS\temp
for
%USERPROFILE%\AppData\Local\Temp
%USERPROFILE%\AppData\Local\Temp


C:\Windows\TEMP



   */

