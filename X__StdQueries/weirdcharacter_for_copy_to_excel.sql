DROP TABLE            #test                                 -- drop temporary table if existent
IF OBJECT_ID('tempdb..#test') IS NOT NULL


use forum
go

SELECT
           Nation_fk          = N.[Nation_pk]
      , N.[Ctry_EditorialName]
      , Q.[Question_Year]
      ,   QA_std              = Q.[Question_abbreviation_std]
      ,   QW_std              = Q.[Question_short_wording_std]
      ,    Answer_value       = A.[Answer_value]
      ,    expltext     = A.[Answer_wording]

      
into #test      



  FROM [Pew_Answer]            A
      ,[Pew_Question]          Q
      ,[Pew_Locality]          L
      ,[Pew_Nation]            N
      ,[Pew_Locality_Answer]   KL
WHERE 
      Q.[Question_Year] >= 2012
  AND Q.[Question_pk] = A.[Question_fk]
  AND A.[Answer_pk]   = KL.[Answer_fk]
  AND L.[Locality_pk] = KL.[Locality_fk]
  AND N.[Nation_pk]   =  L.[Nation_fk]
GO

/*----------------------------------------------------------------------------------------------------------------- ' -*/
--UPDATE
--            #test
--SET
--                          [expltext] = REPLACE( CAST([expltext] AS VARCHAR(MAX)) , char(147), '"')
--WHERE 
--                          [expltext] LIKE                                      '%'+char(147)+'%'
--GO
/*----------------------------------------------------------------------------------------------------------------- " -*/

select * from #test
