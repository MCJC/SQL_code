SELECT 
    DISTINCT	'SELECT ' + 
    			RIGHT (ColumnList, LEN (ColumnList)-1) + 
    			' FROM ' + 
    			Table_Name
                +
                ' JOIN '
FROM 
    INFORMATION_SCHEMA.COLUMNS COL1
    CROSS AppLy 
    (
    	SELECT ', COUNT (DISTINCT ' + COLUMN_NAME + ') AS ' + COL1.TABLE_NAME + '_' + COLUMN_NAME
    	FROM INFORMATION_SCHEMA.COLUMNS COL2
    	WHERE COL1.TABLE_NAME = COL2.TABLE_NAME
    	FOR XML PATH ('')
    ) TableColumns (ColumnList)
WHERE 1=1


select * from

(SELECT  COUNT (DISTINCT Answer_pk) AS Pew_Answer_1_Answer_pk, COUNT (DISTINCT Answer_value) AS Pew_Answer_1_Answer_value, COUNT (DISTINCT Question_fk) AS Pew_Answer_1_Question_fk, COUNT (DISTINCT Answer_wording) AS Pew_Answer_1_Answer_wording, COUNT (DISTINCT answer_wording_std) AS Pew_Answer_1_answer_wording_std FROM Pew_Answer_1) as a
cross JOIN 
(SELECT  COUNT (DISTINCT Answer_pk) AS Pew_Answer_Answer_pk, COUNT (DISTINCT Answer_value) AS Pew_Answer_Answer_value, COUNT (DISTINCT Question_fk) AS Pew_Answer_Question_fk, COUNT (DISTINCT Answer_wording) AS Pew_Answer_Answer_wording, COUNT (DISTINCT answer_wording_std) AS Pew_Answer_answer_wording_std FROM Pew_Answer) as B
cross JOIN 
 
(SELECT  COUNT (DISTINCT Answer_pk) AS Pew_AQ_Answer_pk, COUNT (DISTINCT Answer_value) AS Pew_AQ_Answer_value, COUNT (DISTINCT Question_fk) AS Pew_AQ_Question_fk, COUNT (DISTINCT Answer_wording) AS Pew_AQ_Answer_wording, COUNT (DISTINCT answer_wording_std) AS Pew_AQ_answer_wording_std, COUNT (DISTINCT Question_pk) AS Pew_AQ_Question_pk, COUNT (DISTINCT Question_abbreviation) AS Pew_AQ_Question_abbreviation, COUNT (DISTINCT Question_wording) AS Pew_AQ_Question_wording, COUNT (DISTINCT Data_source_fk) AS Pew_AQ_Data_source_fk, COUNT (DISTINCT Question_Year) AS Pew_AQ_Question_Year, COUNT (DISTINCT Short_wording) AS Pew_AQ_Short_wording, COUNT (DISTINCT Notes) AS Pew_AQ_Notes, COUNT (DISTINCT Default_response) AS Pew_AQ_Default_response, COUNT (DISTINCT Question_abbreviation_std) AS Pew_AQ_Question_abbreviation_std, COUNT (DISTINCT Question_wording_std) AS Pew_AQ_Question_wording_std, COUNT (DISTINCT Question_short_wording_std) AS Pew_AQ_Question_short_wording_std FROM Pew_AQ) as c


 JOIN 




DECLARE @TableName VarChar (Max) = 'gri'

SELECT 
    DISTINCT	'SELECT ' + 
    			RIGHT (ColumnList, LEN (ColumnList)-1) + 
    			' FROM ' + 
    			Table_Name
FROM 
    INFORMATION_SCHEMA.COLUMNS COL1
    CROSS AppLy 
    (
    	SELECT ', COUNT (DISTINCT ' + COLUMN_NAME + ')'
    	FROM INFORMATION_SCHEMA.COLUMNS COL2
    	WHERE COL1.TABLE_NAME = COL2.TABLE_NAME
    	FOR XML PATH ('')
    ) TableColumns (ColumnList)
WHERE 1=1
    AND COL1.TABLE_NAME = @TableName
    
    SELECT  COUNT (DISTINCT nation_fk), COUNT (DISTINCT gri) FROM gri