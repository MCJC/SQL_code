alter table for_d.dbo.Pew_Religion_Group
add Pew_RelL02_5_display varchar(50) NULL
GO


update for_d.dbo.Pew_Religion_Group
set Pew_RelL02_5_display = Pew_religion_lev02_5
GO


update for_d.dbo.Pew_Religion_Group
set Pew_RelL02_5_display = Pew_religion_lev02
where Pew_religion_lev02 = 'Muslims'
GO




select distinct 
       RV.Religion_group_fk
      , R.Pew_religion_lev02    AS Religion
	  ,RD.Pew_RelL02_5_display  AS Sub_Religion
	FROM Pew_Nation_Religion_Age_Sex_Value AS RV
	   , Pew_Religion_Group AS R
       , (
            select distinct
			   Pew_religion_lev02
			  ,Pew_religion_lev02_5_display
			   from
			   for_d.dbo.Pew_Religion_Group
			                                  ) AS RD
WHERE
            RV.Religion_group_fk = R.Religion_group_pk
AND      
             R.Pew_religion_lev02 = RD.Pew_religion_lev02

