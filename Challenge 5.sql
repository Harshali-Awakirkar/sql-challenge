-- Creating Table Tickets
use Interview_Prep_Ankit_Bansal;
create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);

insert into tickets 
values	(1,'2022-08-01','2022-08-03'),
		(2,'2022-08-01','2022-08-12'),
		(3,'2022-08-01','2022-08-16');

select * from tickets;

-- Creating Table Holiday
create table holidays
(
holiday_date date
,reason varchar(100)
);

insert into holidays 
values  ('2022-08-11','Rakhi'),
		('2022-08-15','Independence day');
        
select * from holidays;


/* Write sql query to find business day between create date and resolved date by excluding
 weekends and public Holidays */
select *,
	datediff(resolved_date, create_date) as Actual_Day,
	extract(week from resolved_date) -extract(week from create_date) as Week_Diff,
    (datediff(resolved_date, create_date) - 
    2*(extract(week from resolved_date) -extract(week from create_date)) - No_Of_Holiday) as Business_Day 
from (
	select 
		ticket_id, create_date, resolved_date , 
        count(holiday_date)as No_Of_Holiday
	from tickets t
	left join holidays H
	on holiday_date between create_date and resolved_date
	group by ticket_id, create_date, resolved_date) A;



with cte as (
	select ticket_id, create_date, resolved_date, count(holiday_date) as Public_Holiday
	from tickets t
	left join holidays
	on holiday_date between create_date and resolved_date
	group by ticket_id, create_date, resolved_date)
select *,
datediff(resolved_date , create_date) as Actual_days,
extract(week from resolved_date) - extract(week from create_date) as Week_Diff,
(datediff(resolved_date, create_date) - 
2*(extract(week from resolved_date) -extract(week from create_date)) - Public_Holiday) as Business_Day 
from cte;






/* Write sql query to find business day between create date and resolved date by excluding
 weekends and public Holidays if the holidays fall on weekekends*/
 with cte as (
	select 
		ticket_id, create_date, resolved_date, 
		count(holiday_date) as Public_Holiday
	from tickets t
	left join holidays
	on holiday_date 
	between create_date and resolved_date
    and dayname(holiday_date)<>'Saturday' and dayname(holiday_date)<>'Sunday'
	group by ticket_id, create_date, resolved_date)
select *,
datediff(resolved_date , create_date) as actual_days,
extract(week from resolved_date) - extract(week from create_date) as week_Diff,
datediff(resolved_date, create_date) - 2*(extract(week from resolved_date) -extract(week from create_date)) - Public_Holiday as Business_Day 
from cte;