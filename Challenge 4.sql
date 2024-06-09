use Interview_Prep_Ankit_Bansal;
-- There is phonelog table that has information about caller's call histrory
-- write sql query to find out callers whose first and last call was to the same person on a given day
Create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime);

Insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');
       
select * from phonelog;


with calls as (
	select 
		callerid, cast(datecalled as date) as called_date, 
		min(datecalled) as First_Call, max(datecalled) as Last_Call
	from phonelog
	group by callerid, cast(datecalled as date)),
cte_2 as (select c.*, p1.Recipientid
from calls c
join phonelog p1
on c.callerid = p1.callerid and c.first_call = p1.datecalled
join phonelog p2
on c.callerid = p2.callerid and c.last_call = p2.datecalled
where p1.Recipientid = p2.Recipientid)
select callerid, Recipientid
from cte_2;
