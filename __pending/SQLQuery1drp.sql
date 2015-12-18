

sp_dropserver RELIGIONDB2014;
GO
sp_addserver forumtest, local;
GO


SELECT @@SERVERNAME AS 'Server Name';


Rename a Computer that Hosts a Stand-Alone Instance of SQL Server


 SQL Server 2014  




 Other Versions  

 









 21 out of 31 rated this helpful - Rate this topic  



 

When you change the name of the computer that is running SQL Server, the new name is recognized during SQL Server startup. You do not have to run Setup again to reset the computer name. Instead, use the following steps to update system metadata that is stored in sys.servers and reported by the system function @@SERVERNAME. Update system metadata to reflect computer name changes for remote connections and applications that use @@SERVERNAME, or that query the server name from sys.servers.

The following steps cannot be used to rename an instance of SQL Server. They can be used only to rename the part of the instance name that corresponds to the computer name. For example, you can change a computer named MB1 that hosts an instance of SQL Server named Instance1 to another name, such as MB2. However, the instance part of the name, Instance1, will remain unchanged. In this example, the \\ComputerName\InstanceName would be changed from \\MB1\Instance1 to \\MB2\Instance1.

Before you begin

Before you begin the renaming process, review the following information:

�When an instance of SQL Server is part of a SQL Server failover cluster, the computer renaming process differs from a computer that hosts a stand-alone instance.


�SQL Server does not support renaming computers that are involved in replication, except when you use log shipping with replication. The secondary computer in log shipping can be renamed if the primary computer is permanently lost. For more information, see Log Shipping and Replication (SQL Server).


�When you rename a computer that is configured to use Reporting Services, Reporting Services might not be available after the computer name change. For more information, see Rename a Report Server Computer.


�When you rename a computer that is configured to use database mirroring, you must turn off database mirroring before the renaming operation. Then, re-establish database mirroring with the new computer name. Metadata for database mirroring will not be updated automatically to reflect the new computer name. Use the following steps to update system metadata.


�Users who connect to SQL Server through a Windows group that uses a hard-coded reference to the computer name might not be able to connect to SQL Server. This can occur after the rename if the Windows group specifies the old computer name. To ensure that such Windows groups have SQL Server connectivity following the renaming operation, update the Windows group to specify the new computer name.


You can connect to SQL Server by using the new computer name after you have restarted SQL Server. To ensure that @@SERVERNAME returns the updated name of the local server instance, you should manually run the following procedure that applies to your scenario. The procedure you use depends on whether you are updating a computer that hosts a default or named instance of SQL Server.


To rename a computer that hosts a stand-alone instance of SQL Server


�For a renamed computer that hosts a default instance of SQL Server, run the following procedures:







Copy


sp_dropserver <old_name>;
GO
sp_addserver <new_name>, local;
GO


Restart the instance of SQL Server.



�For a renamed computer that hosts a named instance of SQL Server, run the following procedures:







Copy


sp_dropserver <old_name\instancename>;
GO
sp_addserver <new_name\instancename>, local;
GO


Restart the instance of SQL Server.





After the Renaming Operation



--------------------------------------------------------------------------------




After a computer has been renamed, any connections that used the old computer name must connect by using the new name.


To verify that the renaming operation has completed successfully


�Select information from either @@SERVERNAME or sys.servers. The @@SERVERNAME function will return the new name, and the sys.servers table will show the new name. The following example shows the use of @@SERVERNAME.







Copy


SELECT @@SERVERNAME AS 'Server Name';






Additional Considerations



--------------------------------------------------------------------------------




Remote Logins - If the computer has any remote logins, running sp_dropserver might generate an error similar to the following:

Server: Msg 15190, Level 16, State 1, Procedure sp_dropserver, Line 44 There are still remote logins for the server 'SERVER1'.

To resolve the error, you must drop remote logins for this server.


To drop remote logins


�For a default instance, run the following procedure:







Copy


sp_dropremotelogin old_name;
GO




�For a named instance, run the following procedure:







Copy


sp_dropremotelogin old_name\instancename;
GO



Linked Server Configurations - Linked server configurations will be affected by the computer renaming operation. Use sp_addlinkedserver or sp_setnetname to update computer name references. For more information, see the sp_addlinkedserver (Transact-SQL) or sp_setnetname (Transact-SQL).

Client Alias Names - Client aliases that use named pipes will be affected by the computer renaming operation. For example, if an alias "PROD_SRVR" was created to point to SRVR1 and uses the named pipes protocol, the pipe name will look like \\SRVR1\pipe\sql\query. After the computer is renamed, the path of the named pipe will no longer be valid and. For more information about named pipes, see the Creating a Valid Connection String Using Named Pipes.




See Also



--------------------------------------------------------------------------------



Install SQL Server 2014
