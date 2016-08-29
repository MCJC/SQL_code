SELECT DB_NAME(dbid) AS DBName,
COUNT(dbid) AS NumberOfConnections,
loginame
FROM    sys.sysprocesses
GROUP BY dbid, loginame
ORDER BY DB_NAME(dbid)



SELECT login_name ,COUNT(session_id) AS session_count 
FROM sys.dm_exec_sessions 
GROUP BY login_name;



SELECT *
FROM sys.dm_exec_sessions 


SELECT *
FROM sys.dm_os_waiting_tasks 


Remarks
When the common criteria compliance enabled server configuration option is enabled, logon statistics are displayed in the following columns.
last_successful_logon
last_unsuccessful_logon
unsuccessful_logons
If this option is not enabled, these columns will return null values. For more information about how to set this server configuration option, see common criteria compliance enabled Server Configuration Option.
Relationship Cardinalities
From
To
On/Apply
Relationship
sys.dm_exec_sessions
sys.dm_exec_requests
session_id
One-to-zero or one-to-many
sys.dm_exec_sessions
sys.dm_exec_connections
session_id
One-to-zero or one-to-many
sys.dm_exec_sessions
sys.dm_tran_session_transactions
session_id
One-to-zero or one-to-many
sys.dm_exec_sessions
sys.dm_exec_cursors(session_id | 0)
session_id CROSS APPLY
OUTER APPLY
One-to-zero or one-to-many
sys.dm_exec_sessions
sys.dm_db_session_space_usage
session_id
One-to-one
Examples
A. Finding users that are connected to the server
The following example finds the users that are connected to the server and returns the number of sessions for each user.
SELECT login_name ,COUNT(session_id) AS session_count 
FROM sys.dm_exec_sessions 
GROUP BY login_name;
B. Finding long-running cursors
The following example finds the cursors that have been open for more than a specific period of time, who created the cursors, and what session the cursors are on.
USE master;
GO
SELECT creation_time ,cursor_id 
    ,name ,c.session_id ,login_name 
FROM sys.dm_exec_cursors(0) AS c 
JOIN sys.dm_exec_sessions AS s 
   ON c.session_id = s.session_id 
WHERE DATEDIFF(mi, c.creation_time, GETDATE()) > 5;
C. Finding idle sessions that have open transactions
The following example finds sessions that have open transactions and are idle. An idle session is one that has no request currently running.
SELECT s.* 
FROM sys.dm_exec_sessions AS s
WHERE EXISTS 
    (
    SELECT * 
    FROM sys.dm_tran_session_transactions AS t
    WHERE t.session_id = s.session_id
    )
    AND NOT EXISTS 
    (
    SELECT * 
    FROM sys.dm_exec_requests AS r
    WHERE r.session_id = s.session_id
    );

D. Finding information about a queries own connection
Typical query to gather information about a queries own connection.
SELECT 
    c.session_id, c.net_transport, c.encrypt_option, 
    c.auth_scheme, s.host_name, s.program_name, 
    s.client_interface_name, s.login_name, s.nt_domain, 
    s.nt_user_name, s.original_login_name, c.connect_time, 
    s.login_time 
FROM sys.dm_exec_connections AS c
JOIN sys.dm_exec_sessions AS s
    ON c.session_id = s.session_id
WHERE c.session_id = @@SPID;
See Also
Dynamic Management Views and Functions (Transact-SQL)
Execution Related Dynamic Management Views and Functions (Transact-SQL)
Community Additions





-----------


    SELECT login_name, --count(session_id) as session_count 
	 *
    FROM  sys.dm_exec_sessions 
    --GROUP BY login_name


	status
sleeping