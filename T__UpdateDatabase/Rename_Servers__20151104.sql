SELECT @@servername

/*	

Since this appears quite high in the google search for 'rename sql instance'..and is just not right IMHO, I thought I better add a comment.

sp_dropserver "oldservername"
sp_addserver "newservername" , local



The sp_dropserver / sp_addserver method works only for the DEFAULT instance though.
On the default instance only, by using sp_dropserver / sp_addserver you can change the server name reported by @@SERVERNAME.








done.
I cant see how uninstalling and reinstalling is easier for you than 2 queries and a few minor clicks here and there....


The sp_dropserver / sp_addserver method works only for the DEFAULT instance though.
On the default instance only, by using sp_dropserver / sp_addserver you can change the server name reported by @@SERVERNAME.
You would also have to change your machnine name if you wanted remote clients to be able to connect to that instance using that name.

For a NAMED (non-default) instance it isn't so easy.
The supported method is to uninstall / re-install.
There are registry hacks to rename a default instance, but you may prefer the safer option of re-installing:

http://groups.google.com/group/microsoft.public.sqlserver.server/browse_thread/thread/544c4eaf43ddfaf3/e9065e05718e984e





– Get the current name of the SQL Server instance for later comparison.
*/

SELECT @@servername


/*----
– Remove server from the list of known remote and linked servers on the local instance of SQL Server.
*/----


EXEC master.dbo.sp_dropserver [FORUMDB]


/*----
– Define the name of the local instance of SQL Server.
*/----


EXEC master.dbo.sp_addserver [FORUMDBOLD], local





– Get the new name of the SQL Server instance for comparison.
SELECT @@servername






Post #806336	
Send Private Message...  		
seth delconte	
 Posted Friday, March 23, 2012 9:20 AM	Post a reply to this post...  Post a quoted reply to this post...  Edit This Post
 

SSCommitted

SSCommittedSSCommittedSSCommittedSSCommittedSSCommittedSSCommittedSSCommittedSSCommitted 

Group: General Forum Members 
Last Login: Thursday, September 3, 2015 2:44 PM 
Points: 1,619, Visits: 1,339
Rao.V (10/21/2009)
– Get the current name of the SQL Server instance for later comparison.
SELECT @@servername
– Remove server from the list of known remote and linked servers on the local instance of SQL Server.
EXEC master.dbo.sp_dropserver ‘[SERVER NAME]‘
– Define the name of the local instance of SQL Server.
EXEC master.dbo.sp_addserver ‘[NEW SERVER NAME]‘, ‘local’
– Get the new name of the SQL Server instance for comparison.
SELECT @@servername


I know this is an old post, but...
After renaming the instance using sp_dropserver and sp_addserver, selecting @@SERVERNAME will not return the new, changed instance name until a sql server service restart has occurred. 

____________________________