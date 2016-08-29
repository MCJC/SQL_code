create database forum
on  (filename = 'C:\SQL_data\forum.mdf')
  , (filename = 'C:\SQL_data\forum_log.ldf')
for attach;
go


/*
sql injection

parameterize

owasp.org

This is Windows related issue where SQL Server does not have appropriate 
permission to the folder that contains .bak file and hence the error.
 The easiest work around is to copy your .bak file to default SQL backup
  location which has all the necessary permissions. You do not need to fiddle 
  with anything else. In SQL SERVER 2012, this location is

D:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Backup


To fix, I did the following:

Added the Administrators Group to the file security permissions
with full control for the Data file (S:) and the Log File (T:).

Attached the database and it works fine.

