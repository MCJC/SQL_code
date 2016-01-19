use _Test

---Use Microsoft.ACE.OLEDB.12.0 OPENROWSET format
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0;
   Database= C:\SS\Data\TestJC.xlsx',
   [MJCC1$]);





/*


\\Mac\Home\Documents\SQL Server Management Studio

Microsoft Access Database Engine 2010 Redistributable 
This download will install a set of components that can be used to facilitate transfer of data between 2010 Microsoft Office System files and non-Microsoft Office applications. 
http://www.microsoft.com/en-us/download/details.aspx?id=13255




Microsoft Excel, Database, Web and Real Time Solutions







Save Excel Data into Databases

Connect to databases, edit data, and save changes back.
 Edit data using formulas and Search&Replace.
 Share data in your department using database tables instead of sharing or emailing workbooks.
 Share data among multiple worksheets and workbooks using embedded SQL Server Compact databases.

http://www.excel-sql-server.com/excel-import-to-sql-server-using-distributed-queries.htm


The basic format for the Microsoft.ACE.OLEDB.12.0 provider is:
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0;Database=C:\excel-sql-server.xlsx', [Sheet1$])
SELECT * FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
  'Data Source=C:\excel-sql-server.xlsx;Extended Properties=Excel 12.0')...[Sheet1$]

The Microsoft.Jet.OLEDB.4.0 provider is used with 32-bit SQL Server for Excel 2003 files.

The Microsoft.ACE.OLEDB.12.0 provider is used with 64-bit SQL Server for any Excel files or 32-bit SQL Server for Excel 2007 files.

Pay attention that "Excel 12.0" string is used, not "Excel 14.0" as some MSDN resources say.

To top

Configuration Steps for Excel Data Import to SQL Server

/*

http://www.excel-sql-server.com/excel-import-to-sql-server-using-distributed-queries.htm



*/


sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO


OLE DB provider "Microsoft.ACE.OLEDB.12.0" for linked server "(null)" returned message "Failure creating file.".
Msg 7303, Level 16, State 1, Line 62
Cannot initialize the data source object of OLE DB provider "Microsoft.ACE.OLEDB.12.0" for linked server "(null)".


EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO


icacls C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp /grant MSSQL$JC:(R,W)



Microsoft Windows [Versión 10.0.10240]
(c) 2015 Microsoft Corporation. Todos los derechos reservados.

C:\Users\juancarlos>icacls

ICACLS nombre /save archivoACL [/T] [/C] [/L] [/Q]
    almacena las DACL para los archivos y carpetas cuyos nombres coinciden
    en archivoACL para su uso posterior con /restore. Tenga en cuenta que no
    se guardan las SACL, el propietario ni las etiquetas de identidad.

ICACLS directorio [/substitute SidOld SidNew [...]] /restore archivoACL
                  [/C] [/L] [/Q]
    aplica las DACL almacenadas a los archivos del directorio.

ICACLS nombre /setowner usuario [/T] [/C] [/L] [/Q]
    cambia el propietario de todos los nombres coincidentes. Esta opción
    no fuerza un cambio de propiedad; use la utilidad takeown.exe
    con esta finalidad.

ICACLS nombre /findsid Sid [/T] [/C] [/L] [/Q]
    busca todos los nombres coincidentes que contienen una ACL
    que menciona el SID de forma explícita.

ICACLS nombre /verify [/T] [/C] [/L] [/Q]
    busca todos los archivos cuya ACL no está en formato canónico o cuyas
    longitudes no son coherentes con los recuentos de la ACE.

ICACLS nombre /reset [/T] [/C] [/L] [/Q]
    reemplaza las ACL con ACL heredadas predeterminadas para todos
    los archivos coincidentes.

ICACLS nombre [/grant[:r] Sid:perm[...]]
       [/deny Sid:perm [...]]
       [/remove[:g|:d]] Sid[...]] [/T] [/C] [/L] [/Q]
       [/setintegritylevel Level:policy[...]]

    /grant[:r] Sid:perm concede los derechos de acceso al usuario
        especificado. Con :r, los permisos reemplazan cualquier permiso
        explícito concedido anteriormente. Sin :r, los permisos se agregan a
        cualquier permiso explícito concedido anteriormente.

    /deny Sid:perm deniega de forma explícita los derechos de acceso al
        usuario especificado. Se agrega una ACE de denegación explícita
        para los permisos indicados y se quitan los mismos permisos de
        cualquier concesión explícita.

    /remove[:[g|d]] Sid quita todas las repeticiones del SID en la ACL. Con
        :g, quita todas las repeticiones de derechos concedidos a ese SID. Con
        :d, quita todas las repeticiones de derechos denegados a ese SID.

    /setintegritylevel [(CI)(OI)]nivel agrega de forma explícita una ACE de
        integridad a todos los archivos coincidentes. El nivel se debe
        especificar como:
            L[ow] - para bajo
            M[edium] - para medio
            H[igh] - para alto
        Las opciones de herencia para la ACE de integridad pueden preceder al
        nivel y se aplican solo a los directorios.

    /inheritance:e|d|r
        e - habilita la herencia
        d - deshabilita la herencia y copia las ACE
        r - quita todas las ACE heredadas

Nota:
    Los SID pueden tener un formato numérico o de nombre descriptivo. Si se da
    un formato numérico, agregue un asterisco (*) al principio del SID.

    /T indica que esta operación se realiza en todos los archivos o
        directorios coincidentes bajo los directorios especificados en el
        nombre.

    /C indica que esta operación continuará en todos los errores de archivo.
        Se seguirán mostrando los mensajes de error.

    /L indica que esta operación se realiza en el vínculo simbólico en sí
        en lugar de en su destino.

    /Q indica que icacls debe suprimir los mensajes de que las operaciones
       se realizaron correctamente.

    ICACLS conserva el orden canónico de las entradas ACE:
            Denegaciones explícitas
            Concesiones explícitas
            Denegaciones heredadas
            Concesiones heredadas

    perm es una máscara de permiso que puede especificarse de dos formas:
        una secuencia de derechos simples:
                N - sin acceso
                F - acceso total
                M - acceso de modificación
                RX - acceso de lectura y ejecución
                R - acceso de solo lectura
                W - acceso de solo escritura
                D - acceso de eliminación
        una lista separada por comas entre paréntesis de derechos específicos:
                DE - eliminar
                RC - control de lectura
                WDAC - escribir DAC
                WO - escribir propietario
                S - sincronizar
                AS - acceso al sistema de seguridad
                MA - máximo permitido
                GR - lectura genérica
                GW - escritura genérica
                GE - ejecución genérica
                GA - todo genérico
                RD - leer datos/lista de directorio
                WD - escribir datos/agregar archivo
                AD - anexar datos/agregar subdirectorio
                REA - leer atributos extendidos
                WEA - escribir atributos extendidos
                X - ejecutar/atravesar
                DC - eliminar secundario
                RA - leer atributos
                WA - escribir atributos
        los derechos de herencia pueden preceder a cualquier forma y se
        aplican solo a directorios:
                (OI) - herencia de objeto
                (CI) - herencia de contenedor
                (IO) - solo herencia
                (NP) - no propagar herencia
                (I) - permiso heredado del contenedor principal

Ejemplos:

        icacls c:\windows\* /save archivoACL /T
        - Guardará todas las ACL para todos los archivos en c:\windows
          y sus subdirectorios en archivoACL.

        icacls c:\windows\ /restore archivoACL
        - Restaurará todas las ACL para cada archivo dentro de
          archivoACL que exista en c:\windows y sus subdirectorios.

        icacls file /grant Administrador:(D,WDAC)
        - Concederá al usuario permisos de administrador para eliminar y
          escribir DAC en el archivo.

        icacls file /grant *S-1-1-0:(D,WDAC)
        - Concederá al usuario definido por el SID S-1-1-0 permisos para
          eliminar y escribir DAC en el archivo.

C:\Users\juancarlos>icacls C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp /grant vs:(R,W)
vs: No se efectuó ninguna asignación entre los nombres de cuenta y los identificadores de seguridad.
Se procesaron correctamente 0 archivos; error al procesar 1 archivos

C:\Users\juancarlos>cd..

C:\Users>cd..

C:\>icacls C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp /grant vs:(R,W)
vs: No se efectuó ninguna asignación entre los nombres de cuenta y los identificadores de seguridad.
Se procesaron correctamente 0 archivos; error al procesar 1 archivos

C:\>icacls C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp /grant JC:(R,W)
JC: No se efectuó ninguna asignación entre los nombres de cuenta y los identificadores de seguridad.
Se procesaron correctamente 0 archivos; error al procesar 1 archivos

C:\>icacls C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp /grant MSSQL$JC:(R,W)
archivo procesado: C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp
Se procesaron correctamente 1 archivos; error al procesar 0 archivos

C:\>icacls C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp /grant MSSQL$JC:(R,W)
archivo procesado: C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp
Se procesaron correctamente 1 archivos; error al procesar 0 archivos

C:\>icacls C:\SS\MSSQL12.JC\MSSQL\Data /grant MSSQL$JC:(R,W)
archivo procesado: C:\SS\MSSQL12.JC\MSSQL\Data
Se procesaron correctamente 1 archivos; error al procesar 0 archivos

C:\>icacls \\Mac\Home\Documents\SQL Server Management Studio /grant MSSQL$JC:(R,W)
Parámetro no válido "Server"

C:\>icacls "\\Mac\Home\Documents\SQL Server Management Studio" /grant MSSQL$JC:(R,W)
archivo procesado: \\Mac\Home\Documents\SQL Server Management Studio
Se procesaron correctamente 1 archivos; error al procesar 0 archivos

C:\>icacls C:\SS\MSSQL12.JC\MSSQL\Data /grant MSSQL$JC:(R,W)
archivo procesado: C:\SS\MSSQL12.JC\MSSQL\Data
Se procesaron correctamente 1 archivos; error al procesar 0 archivos

C:\>6.Add "-g512;"
"6.Add" no se reconoce como un comando interno o externo,
programa o archivo por lotes ejecutable.

C:\>
C:\>6.Add "-g512;"
"6.Add" no se reconoce como un comando interno o externo,
programa o archivo por lotes ejecutable.

C:\>
C:\>6.Add "-g512;"
"6.Add" no se reconoce como un comando interno o externo,
programa o archivo por lotes ejecutable.

C:\>
C:\>6.Add "-g512;"
"6.Add" no se reconoce como un comando interno o externo,
programa o archivo por lotes ejecutable.

C:\>
C:\>6.Add "-g512;"
"6.Add" no se reconoce como un comando interno o externo,
programa o archivo por lotes ejecutable.

C:\>
C:\>6.Add "-g512;"
"6.Add" no se reconoce como un comando interno o externo,
programa o archivo por lotes ejecutable.

C:\>
C:\>6.Add "-g512;"
"6.Add" no se reconoce como un comando interno o externo,
programa o archivo por lotes ejecutable.

C:\>



The Real Fix

As the SQL Server Central article states though, allocating more memory to the MemToLeave pool isn’t as easy as just setting the SQL startup switch. Whatever additional memory you allocate to the MemToLeave pool is taken from the Buffer Pool (BPool), which is SQL’s main operating memory. For this reason, reducing the amount of memory in this pool can have some very undesirable side effects. So, set this responsibly, do testing out of production first and get ready to set it back if things don’t work out the way you hoped, but here is how you allocate more memory to the MemToLeave pool.
1.Open SQL Server Configuration Manager.
2.Select the SQL Server Services folder in the left pane.
3.Right-click the SQL Server (MSSQLSERVER) service in the right pane.
4.Click Properties.
5.Click the Advanced tab in the properties dialog that pops up.
6.Add “-g512;” to the front of the value for parameter “Startup Parameters”.
7.Click OK.

Summary


http://www.aspsnippets.com/Articles/The-OLE-DB-provider-Microsoft.Ace.OLEDB.12.0-for-linked-server-null.aspx


*/


--How-To: Import Excel 2003/2007 to SQL Server x64

---Step 1. Install 64-bit Microsoft.ACE.OLEDB.12.0 driver

---Microsoft Access Database Engine 2010 Redistributable

---Step 2. Configure Ad Hoc Distributed Queries
sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

--Step 3. Configure OLE DB properties
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO

---Use Microsoft.ACE.OLEDB.12.0 OPENROWSET format
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0;
   Database= C:\SS\Data\TestJC.xlsx',
   [MJCC1$]);




/*
---Use Microsoft.ACE.OLEDB.12.0 OPENROWSET format
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0;

   HDR=Yes;
   IMEX=1;

   Database= C:\SS\Data\TestJC.xlsx',

   'SELECT * FROM
   
   [MJCC1$]');



Use Microsoft.ACE.OLEDB.12.0 OPENDATASOURCE format
SELECT * FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
  'Data Source=C:\excel-sql-server.xlsx;Extended Properties=Excel 12.0')...[Sheet1$]




SELECT *
FROM
OPENROWSET
 ('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0 Xml;
   Database= C:\SS\Data\TestJC.xlsx',
   [MJCC1$]);


SELECT *
FROM
OPENDATASOURCE
 ('Microsoft.ACE.OLEDB.12.0',
  'Data Source=C:\SS\Data\TestJC.xlsx;Extended Properties=Excel 12.0')...[MJCC1$]







#

Step

SQL Server x86
 for Excel 2003
 files *.xls

SQL Server x86
 for Excel 2007
 files *.xlsx, etc.

SQL Server x64
 for any Excel
 version files 

1 Install Microsoft.ACE.OLEDB.12.0 driver not needed x86 x64 
2 Configure Ad Hoc Distributed Queries yes yes yes 
3 Grant rigths to TEMP directory yes yes not needed 
4 Configure ACE OLE DB properties not needed yes yes 

Install Microsoft.ACE.OLEDB.12.0 driver

To import Excel 2007/2010/2013 files to SQL Server Microsoft.ACE.OLEDB.12.0 driver should be installed.

To download the driver use the following link:

Microsoft Access Database Engine 2010 Redistributable

Don't worry about "Access" in the name.

Warning! x64 driver can not be installed if Microsoft Office 2007/2010/2013 x86 is already installed!

So there is no way to import Excel data to SQL Server x64 using OPENROWSET/OPENDATASOURCE functions on a machine with Microsoft Office x86!

The SQL Server Error Message if Microsoft.ACE.OLEDB.12.0 is not installed
Msg 7403, Level 16, State 1, Line 1
The OLE DB provider "Microsoft.ACE.OLEDB.12.0" has not been registered.


Configure Ad Hoc Distributed Queries

To configure Ad Hoc Distributed Queries use the following code:
sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

The SQL Server Error Message if Ad Hoc Distributed Queries component is turned off
Msg 15281, Level 16, State 1, Line 1
SQL Server blocked access to STATEMENT 'OpenRowset/OpenDatasource' of component
'Ad Hoc Distributed Queries' because this component is turned off as part of
the security configuration for this server.
A system administrator can enable the use of 'Ad Hoc Distributed Queries'
by using sp_configure.
For more information about enabling 'Ad Hoc Distributed Queries',
see "Surface Area Configuration" in SQL Server Books Online.


Grant rigths to TEMP directory

This step is required only for 32-bit SQL Server with any OLE DB provider.

The main problem is that an OLE DB provider creates a temporary file during the query in the SQL Server temp directory using credentials of a user who run the query.

The default directory for SQL Server is a default directory for SQL Server service account.

If SQL Server is run under Network Service account the temp directory is like:

C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp

If SQL Server is run under Local Service account the temp directory is like:

C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp

Microsoft recommends two ways for the solution:
1.A change of SQL Server TEMP directory and a grant of full rights for all users to this directory.
2.Grant of read/write rights to the current SQL Server TEMP directory.

See details: PRB: "Unspecified error" Error 7399 Using OPENROWSET Against Jet Database

Usually only few accounts are used for import operations. So we can just add rights for these accounts.

For example, icacls utility can be used for the rights setup:
icacls C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp /grant vs:(R,W)

if SQL Server is started under Network Service and login "vs" is used to run the queries.

The SQL Server Error Message if a user have no rights for SQL Server TEMP directory
OLE DB provider "Microsoft.Jet.OLEDB.4.0" for linked server "(null)" returned message "Unspecified error".
Msg 7303, Level 16, State 1, Line 1
Cannot initialize the data source object of OLE DB provider "Microsoft.Jet.OLEDB.4.0" for linked server "(null)".


Configure ACE OLE DB properties

This step is required only if the Microsoft.ACE.OLEDB.12.0 provider is used.

Use the following T-SQL code:
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO

The SQL Server Error Messages if OLE DB properties are not configured
Msg 7399, Level 16, State 1, Line 1
The OLE DB provider "Microsoft.ACE.OLEDB.12.0" for linked server "(null)" reported an error. The provider did not give any information about the error.
Msg 7330, Level 16, State 2, Line 1
Cannot fetch a row from OLE DB provider "Microsoft.ACE.OLEDB.12.0" for linked server "(null)".


To top

How-To: Import Excel 2003 to SQL Server x86

Step 1. Configure Ad Hoc Distributed Queries
sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

Step 2. Grant rigths to TEMP directory
icacls C:\Windows\ServiceProfiles\<SQL Server Account>\AppData\Local\Temp /grant <User>:(R,W)

The most commonly used pathes:

C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp
 C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp

Use Microsoft.Jet.OLEDB.4.0 OPENROWSET format
SELECT * FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0',
  'Excel 8.0;Database=C:\excel-sql-server.xls', [Sheet1$])

Use Microsoft.Jet.OLEDB.4.0 OPENDATASOURCE format
SELECT * FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0',
  'Data Source=C:\excel-sql-server.xls;Extended Properties=Excel 8.0')...[Sheet1$]

To top

How-To: Import Excel 2007 to SQL Server x86

Step 1. Install 32-bit Microsoft.ACE.OLEDB.12.0 driver

Microsoft Access Database Engine 2010 Redistributable

Step 2. Configure Ad Hoc Distributed Queries
sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

Step 3. Grant rigths to TEMP directory
icacls C:\Windows\ServiceProfiles\<SQL Server Account>\AppData\Local\Temp /grant <User>:(R,W)

The most commonly used pathes:

C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp
 C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp

Step 4. Configure OLE DB properties
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO

Use Microsoft.ACE.OLEDB.12.0 OPENROWSET format
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0;Database=C:\excel-sql-server.xlsx', [Sheet1$])

Use Microsoft.ACE.OLEDB.12.0 OPENDATASOURCE format
SELECT * FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
  'Data Source=C:\excel-sql-server.xlsx;Extended Properties=Excel 12.0')...[Sheet1$]

To top

How-To: Import Excel 2003/2007 to SQL Server x64

Step 1. Install 64-bit Microsoft.ACE.OLEDB.12.0 driver

Microsoft Access Database Engine 2010 Redistributable

Step 2. Configure Ad Hoc Distributed Queries
sp_configure 'Show Advanced Options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO

Step 3. Configure OLE DB properties
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO

Use Microsoft.ACE.OLEDB.12.0 OPENROWSET format
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
  'Excel 12.0;Database=C:\excel-sql-server.xlsx', [Sheet1$])

Use Microsoft.ACE.OLEDB.12.0 OPENDATASOURCE format
SELECT * FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
  'Data Source=C:\excel-sql-server.xlsx;Extended Properties=Excel 12.0')...[Sheet1$]

To top

Conclusion

Using the described techniques you can import data from Microsof Excel 2003/2007/2010/2013 to SQL Server 2005/2008/R2/2012/2014 on 32-bit or 64-bit platform.

To top


See Also

Reference

OPENDATASOURCE (Transact-SQL)

OPENROWSET (Transact-SQL)

Connection strings for Excel

How To

How to use Excel with SQL Server linked servers and distributed queries

Accessing Excel files on a x64 machine

Downloads

Microsoft Access Database Engine 2010 Redistributable

2007 Office System Driver: Data Connectivity Components



Comments  




# Mirza Naher Abbas 2014-11-12 09:08 
Hi guys...

One more thing I wud like to tell..
Many of you still have the problem after applying aal the thing above "Cannot initialize the data source object of OLE DB provider "Microsoft.Jet.OLEDB.4.0" for linked server "(null)"."

This is because u r not giving the exact source.
never give the location of "Desktop".
try to ignore the source drive having program files or Desktop.
Reply | Reply with quote | Quote  



# Nailesh 2014-10-27 11:58 
Hi guys,
i have read .xlsb file using sql query so know any solution so tell me.

thanks
nailesh
Reply | Reply with quote | Quote  



# Faiz 2014-10-20 12:00 
Thank you for the article.

Just wanted to add that the temp folder permissions are still required, just tested and verified that now.
Reply | Reply with quote | Quote  



# Karvul Khan 2014-07-08 09:37 
Thank you for this excellent article. Still, Temp folder permissions are definitely still required with x64 SQL on x64 OS using x64 ACE driver. 

Another observation: One can receive the symptoms described for missing temp rights, but without the unspecified error (The portion Msg 7303 ... "(null)") when using invalid Range specs *and* the Excel file has Office 97 format.
Reply | Reply with quote | Quote  




# Majer 2014-10-02 15:10 
I've gone throught the temp permissions and it does not seem to resolve my error.

Msg 7302, Level 16, State 1, Line 1
Cannot create an instance of OLE DB provider "Microsoft.ACE.OLEDB.12.0" for linked server "(null)".

I am running SQL Server 2008 R2 on windows server 2003 r2 using a domain service account for SQL Service. I applied the permissions to the folder "C:\Documents and Settings\svcaccount\SQLExec\Lo cal Settings\Temp" with no benifit. Anyone have a solution?
Reply | Reply with quote | Quote  




# Sergey Vaselenko 2014-10-02 18:05 
Try
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO
Reply | Reply with quote | Quote  



# sharif 2013-10-13 11:48 
agree with the comment above, excellent document and examples.
managed to get it to work at home, vista/office 2007/ sql2012 
can’t at work, XP sp2/office 2007/ sql 2008

main problem seem to be with the permission

“The main problem is that an OLE DB provider creates a temporary file during the query in the SQL Server temp directory using credentials of a user who run the query.”

I am running both server and a user running the query under the same windows account (its windows admin and sql sys admin) everything on the one box.

also there isn’t such path C:\Windows\ServiceProfiles\, so when under network account can’t add permissions to 
C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp\

any ideas will be appreciated

if email is used, then "_deletet_me_" has to be removed for it to work.
Reply | Reply with quote | Quote  



# AJ 2013-10-11 23:17 
Need some help here. I have no problem using the JET provider with an openrowset command to extract the contents of an XLS file. However, while using the ACE provider for an XLSX file, I get "OLE DB provider "Microsoft.ACE.OLEDB.12.0" for linked server "(null)" returned message "Unspecified error".
Msg 7303, Level 16, State 1, Line 1
Cannot initialize the data source object of OLE DB provider "Microsoft.ACE.OLEDB.12.0" for linked server "(null)"."

I have performed all suggestions as above. ACE is definitely installed as I can see it as a provider in SSMS. I'm confused since JET works fine. Any ideas?
Reply | Reply with quote | Quote  



# Monted 2013-09-28 06:29 
Permissions to NetworkService temp folder not limited to 32-bit server. I needed to do this on my 2008 R2 64-bit server to make both the openrowsets and linked servers to XLSX function properly. Excellent resource. thx
Reply | Reply with quote | Quote  



# Chris Lemmonds 2013-09-22 17:59 
This is well-written article with great information. I just wanted to make everyone aware that on several occasions I've run into a horrible issue with opendata source using ACE for .xlsx files: the sql server and agent services terminally crash. Agent cannot restart the sql server service because it has been taken out too. Others who have encountered this issue note that it seems to only occur during heavy usage. My last stack dump showed 88% memory load when sql server crashed, so it may be a memory leak of some kind. Naturally, I now convert all xlsx to either xls or csv before importing. An example of the last statement that crashed the production server is as follows:
	select * into ##ticket5119
	from opendatasource
	('Microsoft.ACE.OLEDB.12.0','D ata Source="\\192.168.4.92\Public\Codes.xlsx";
	User ID=Admin;Password=;
	Extended Properties="Excel 8.0;HDR=Yes;IMEX=1"'
	)...[Sheet1$] x
Reply | Reply with quote | Quote  



# Selvakumar 2013-02-18 14:35 
Thanks a lot... Very helpfull. I was trying to read an Excel 2010 file from SQL Server 2012 for the past 4 days. Now after reading the solution here, the problem is resolve and i got relieved.
Reply | Reply with quote | Quote  



# Vishal 2012-10-15 11:33 
Thanks a lot,

"The SQL Server Error Message if a user have no rights for SQL Server TEMP directory." solved my problem for "OLE DB provider "microsoft.jet.oledb.4.0" for linked server "(null)" returned message "Unspecified error"."
Reply | Reply with quote | Quote  



# Lubos Bednar 2012-06-27 19:18 
Hi guys,

I have already solved this issue 2 times. In last time, running SQL Management Studio (or VS studio) "run as administrator" helped.

Regards,
Lubos











-- To allow advanced options to be changed.

EXEC sp_configure 'show advanced options', 1
GO

-- To update the currently configured value for advanced options.

RECONFIGURE
GO

-- To enable the feature.

EXEC sp_configure 'xp_cmdshell', 1
GO

-- To update the currently configured value for this feature.

RECONFIGURE
GO





sqlcmd -L[c]


SELECT @@SERVERNAME
GO


!! dir S:\forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData\xlsx

: SQLCMD -LC

osql -L

sqlcmd -L

sql -L[c]


exec xp_cmdShell 'net use S:'


N:\JCEO_data


S:\Forum\Database\MANAGEMENT


EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO
EXEC sp_configure 'ad hoc distributed queries', 1
RECONFIGURE
GO



EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
 
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO
 

SELECT *
FROM OPENROWSET('Microsoft.ACE.OLEDB.16.0',
  'Excel 16.0 Xml;
   Database=\S:\forum\Database\MANAGEMENT\SQL_code\VR_for_RestrictionsData\xlsx\CodeSheet.xlsx',
   [DB_TabAtt_source$]);



* FROM OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0',
'Data Source=C:\DataFolder\Documents\TestExcel.xls;Extended Properties=EXCEL 5.0')...[Sheet1$] ;


SELECT *
FROM OPENROWSET('Microsoft.ACE.OLEDB.16.0',
  'Excel 16.0 Xml;
   Database= C:\SS\Data\TestJC.xlsx',
   [MJCC1$]);





SELECT @@VERSION


