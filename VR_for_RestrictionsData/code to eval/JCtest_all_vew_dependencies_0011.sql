




------------CREATE FUNCTION GetDependents(
------------    @ObjectName AS SYSNAME
------------)
------------RETURNS @result TABLE (
------------	Seq INT IDENTITY, 
------------	ObjectName SYSNAME, 
------------	Hierarchy VARCHAR(128))
------------AS
------------BEGIN
------------    ;
	 WITH Obj AS (
        SELECT DISTINCT
               [ChildID]     =  s.id 
             , [ParentID]    =  s.DepID 
             , [ChildN]      =  o1.Name 
             , [ParentN]     =  o2.Name
             , [ChildFullN]  =  QUOTENAME(sch1.name)
			                  + '.'
							  + QUOTENAME(o1.Name)
							  + '('
							  + RTRIM(o1.type)
							  + ')'
                                COLLATE SQL_Latin1_General_CP1_CI_AS
             , [ParentFullN] =  QUOTENAME(sch2.name)
			                  + '.'
							  + QUOTENAME(o1.Name)
			 
			  + '.' + QUOTENAME(o2.Name) 
			+ '(' + RTRIM(o2.type) + ')' 
                COLLATE SQL_Latin1_General_CP1_CI_AS
   --- AS ParentFullName

   --         QUOTENAME(sch1.name) + '.' + QUOTENAME(o1.Name) 
			--+ '(' + RTRIM(o1.type) + ')' 
   --             COLLATE SQL_Latin1_General_CP1_CI_AS 
			--AS ParentObject, 
   --         QUOTENAME(sch2.name) + '.' + QUOTENAME(o2.Name) 
			--+ '(' + RTRIM(o2.type) + ')' 
   --             COLLATE SQL_Latin1_General_CP1_CI_AS AS ObjectName


   --  ,       QUOTENAME(sch1.name) + '.' + QUOTENAME(o1.Name) 
			--+ '(' + RTRIM(o1.type) + ')' 
   --             COLLATE SQL_Latin1_General_CP1_CI_AS 
			--AS ParentObject, 
   --    ,     QUOTENAME(sch2.name) + '.' + QUOTENAME(o2.Name) 
			--+ '(' + RTRIM(o2.type) + ')' 
   --             COLLATE SQL_Latin1_General_CP1_CI_AS AS ObjectName
        FROM sys.sysdepends s
        INNER JOIN sys.all_objects o1 ON s.id = o1.object_id
        INNER JOIN sys.schemas sch1 ON sch1.schema_id = o1.schema_id
        INNER JOIN sys.all_objects o2 on s.DepID = o2.object_id
        INNER JOIN sys.schemas sch2 ON sch2.schema_id = o2.schema_id


where 
            s.id  ----- AS ParentID,
			IN (
                 7671075,
				 2091154495,
                 1826105546
               )

    ), cte AS (
        SELECT 
                1 AS lvl
     --         , [ChildName]
			  --, [ParentID]
			  --, [ParentName]
			  --, [ChildFullName]
			  --, [ParentFullName] 
              , [ChildN]
			  , [ParentN]
			  , [ChildID]
            --ParentID,
            , [ParentID]
			,
            [ChildFullN]
			,
            [ParentFullN]
          --,  CAST(ObjectID AS VARBINARY(512)) AS Sort
        FROM obj 
		WHERE [ChildN] in  ('Pew_Answer')
------------        FROM obj WHERE ParentName = @ObjectName
        UNION ALL 
        SELECT
            p.lvl+ 1 
           , c.[ChildN]
           , c.[ParentN]
           , c.[ChildID]
           , c.[ParentID]
		   , c.[ChildFullN]
		   , c.[ParentFullN]
  --       ,  CAST(p.sort + CAST(c.ObjectID AS VARBINARY(16)) 
		--AS VARBINARY(512))
        FROM cte p 
        INNER JOIN obj c ON p.[ParentID] = c.[ChildID]
    )
------------    INSERT INTO @result (ObjectName, Hierarchy)

--    SELECT 
--        ParentName,
--        ObjectName,
--        Tree,
--		sort
--into #dc
--	FROM
--	(


----select * from [cte]



    SELECT 
         [ChildN] AS [through],
         [ChildID]
		    AS [through_ID],
        [ParentFullN]  AS [ancestors],
        Tree = '<-' + REPLICATE('-',(lvl * 4)) + ']  ' + LEFT('               ',(16-(lvl * 4))) + [ParentFullN] --, 
--        sort = '|x' + REPLICATE('x',(lvl * 4)) 
    FROM cte
order by
        '|x' + REPLICATE('x',(lvl * 4)) 


--    ) vf
--   ORDER
--	  BY
--        Tree 



--    SELECT 
--        Tree
--from  #dc
--   ORDER
--	  BY
--        sort 
    
------------    RETURN 
------------END
;







	 WITH Obj AS (
        SELECT DISTINCT
            s.id  AS ParentID,
            s.DepID AS ObjectID,
            o1.Name AS ParentName,
            o2.Name AS ChildName,
            QUOTENAME(sch1.name) + '.' + QUOTENAME(o1.Name) 
			+ '(' + RTRIM(o1.type) + ')' 
                COLLATE SQL_Latin1_General_CP1_CI_AS 
			AS ParentObject, 
            QUOTENAME(sch2.name) + '.' + QUOTENAME(o2.Name) 
			+ '(' + RTRIM(o2.type) + ')' 
                COLLATE SQL_Latin1_General_CP1_CI_AS AS ObjectName
        FROM sys.sysdepends s
        INNER JOIN sys.all_objects o1 ON s.id = o1.object_id
        INNER JOIN sys.schemas sch1 ON sch1.schema_id = o1.schema_id
        INNER JOIN sys.all_objects o2 on s.DepID = o2.object_id
        INNER JOIN sys.schemas sch2 ON sch2.schema_id = o2.schema_id
where 
            s.id  ----- AS ParentID,
			IN (
                 7671075,
				 2091154495,
                 1826105546
               )
    ), cte AS (
        SELECT 
                1 AS lvl
            ,ParentName,
            ParentID,
            ObjectId,
            ParentObject,
            ObjectName
          --,  CAST(ObjectID AS VARBINARY(512)) AS Sort
        FROM obj 
		WHERE ParentName in  ('Pew_Answer')
------------        FROM obj WHERE ParentName = @ObjectName
        UNION ALL 
        SELECT
            p.lvl+ 1, 
            c.ParentName,
            c.ParentID,
            c.ObjectId,
            c.ParentObject,
            c.ObjectName
  --       ,  CAST(p.sort + CAST(c.ObjectID AS VARBINARY(16)) 
		--AS VARBINARY(512))
        FROM cte p 
        INNER JOIN obj c ON p.ObjectID = c.ParentID
    )

    SELECT 
         ParentName AS [through],
         ParentID   AS [through_ID],
        ObjectName  AS [ancestors],
        Tree = '<-' + REPLICATE('-',(lvl * 4)) + ']  ' + LEFT('               ',(16-(lvl * 4))) + ObjectName --, 
--        sort = '|x' + REPLICATE('x',(lvl * 4)) 
    FROM cte
order by
        '|x' + REPLICATE('x',(lvl * 4)) 



        SELECT DISTINCT
            s.id                 AS ChildID,
            s.DepID              AS ParentID,
            o1.Name AS ChildName,
            o2.Name AS ParentName,
            QUOTENAME(sch1.name) + '.' + QUOTENAME(o1.Name) 
			+ '(' + RTRIM(o1.type) + ')' 
                COLLATE SQL_Latin1_General_CP1_CI_AS 
			AS ChildFullName, 
            QUOTENAME(sch2.name) + '.' + QUOTENAME(o2.Name) 
			+ '(' + RTRIM(o2.type) + ')' 
                COLLATE SQL_Latin1_General_CP1_CI_AS AS ParentFullName
        FROM sys.sysdepends s
        INNER JOIN sys.all_objects o1 ON s.id = o1.object_id
        INNER JOIN sys.schemas sch1 ON sch1.schema_id = o1.schema_id
        INNER JOIN sys.all_objects o2 on s.DepID = o2.object_id
        INNER JOIN sys.schemas sch2 ON sch2.schema_id = o2.schema_id


where 
            s.id  ----- AS ParentID,
			IN (
                 7671075,
				 2091154495,
1826105546
)
