/*************************************************************************/
create table #DailyIncome(VendorId     nvarchar(10),
                          IncomeDay    nvarchar(10),
                          IncomeAmount int          )
insert into #DailyIncome values ('SPIKE', 'FRI', 100)
insert into #DailyIncome values ('SPIKE', 'MON', 300)
insert into #DailyIncome values ('FREDS', 'SUN', 400)
insert into #DailyIncome values ('SPIKE', 'WED', 500)
insert into #DailyIncome values ('SPIKE', 'TUE', 200)
insert into #DailyIncome values ('JOHNS', 'WED', 900)
insert into #DailyIncome values ('JOHNS', 'WED', 900)
insert into #DailyIncome values ('SPIKE', 'FRI', 100)
insert into #DailyIncome values ('JOHNS', 'MON', 300)
insert into #DailyIncome values ('SPIKE', 'SUN', 400)
insert into #DailyIncome values ('JOHNS', 'FRI', 300)
insert into #DailyIncome values ('FREDS', 'TUE', 500)
insert into #DailyIncome values ('FREDS', 'TUE', 200)
insert into #DailyIncome values ('SPIKE', 'MON', 900)
insert into #DailyIncome values ('FREDS', 'FRI', 900)
insert into #DailyIncome values ('FREDS', 'MON', 500)
insert into #DailyIncome values ('JOHNS', 'SUN', 600)
insert into #DailyIncome values ('SPIKE', 'FRI', 300)
insert into #DailyIncome values ('SPIKE', 'WED', 500)
insert into #DailyIncome values ('SPIKE', 'FRI', 300)
insert into #DailyIncome values ('JOHNS', 'THU', 800)
insert into #DailyIncome values ('JOHNS', 'SAT', 800)
insert into #DailyIncome values ('SPIKE', 'TUE', 100)
insert into #DailyIncome values ('SPIKE', 'THU', 300)
insert into #DailyIncome values ('FREDS', 'WED', 500)
insert into #DailyIncome values ('SPIKE', 'SAT', 100)
insert into #DailyIncome values ('FREDS', 'SAT', 500)
insert into #DailyIncome values ('FREDS', 'THU', 800)
insert into #DailyIncome values ('JOHNS', 'TUE', 600) 
/*************************************************************************/
select * from #DailyIncome
/*************************************************************************/
select *
into  #PersonIncome
 from #DailyIncome
pivot (avg (IncomeAmount) 
       for IncomeDay in (
       [MON],[TUE],[WED],[THU],[FRI],[SAT],[SUN]
       )) 
       as AvgIncomePerDay
/*************************************************************************/
select * from #PersonIncome
/*************************************************************************/
select                              /* statement                         */
       VendorId                     /* existing variable(s)              */
     , daysem                       /* newvar: stores setofvars_1 names  */    
     , valor                        /* newvar: stores setofvars_1 values */
  from                              /* statement                         */
#PersonIncome
                            AS P    /* alias of table of data to be used */
unpivot (                           /* statement                         */
       valor                        /* newvar: stores setofvars_1 values */
       for                          /* statement                         */
       daysem                       /* newvar: stores setofvars_1 names  */
       in (                         /* statement                         */
       [MON],                       /* 1st name of the setofvars_1       */
       [TUE],                       /* ith name of the setofvars_1       */
       [WED],                       /* ith name of the setofvars_1       */
       [THU],                       /* ith name of the setofvars_1       */
       [FRI],                       /* ith name of the setofvars_1       */
       [SAT],                       /* ith name of the setofvars_1       */
       [SUN]                        /* last name of the setofvars_1      */
          )                         /* statement                         */
        )                           /* statement                         */
       as                           /* statement                         */
       UP1                          /* statement                         */
/*************************************************************************/








/*************************************************************************/
select                              /* statement                         */
       VendorId                     /* existing variable(s)              */
     , daysem                       /* newvar: stores setofvars_1 names  */    
     , valor                        /* newvar: stores setofvars_1 values */
  from                              /* statement                         */
(                                   /*beg: query pulling data to be used */
select * from #DailyIncome
pivot (avg (IncomeAmount) 
       for IncomeDay in (
       [MON],
       [TUE],
       [WED],
       [THU],
       [FRI],
       [SAT],
       [SUN]
       )) 
       as AvgIncomePerDay
)                                   /*end: query pulling data to be used */
                            AS P    /* alias of table of data to be used */
unpivot (                           /* statement                         */
       valor                        /* newvar: stores setofvars_1 values */
       for                          /* statement                         */
       daysem                       /* newvar: stores setofvars_1 names  */
       in (                         /* statement                         */
       [MON],                       /* 1st name of the setofvars_1       */
       [TUE],                       /* ith name of the setofvars_1       */
       [WED],                       /* ith name of the setofvars_1       */
       [THU],                       /* ith name of the setofvars_1       */
       [FRI],                       /* ith name of the setofvars_1       */
       [SAT],                       /* ith name of the setofvars_1       */
       [SUN]                        /* last name of the setofvars_1      */
          )                         /* statement                         */
        )                           /* statement                         */
       as                           /* statement                         */
       UP1                          /* statement                         */
/*************************************************************************/

/*************************************************************************/
drop table #DailyIncome
/*************************************************************************/
