use Interview_Prep_Ankit_Bansal;

create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

Select * from hospital;

-- Write a SQL Query to find the total number of people present inside the hospital

-- Group By
select emp_id,
	max(case when action = 'in' then time end )as In_Time,
    max(case when action = 'out' then time end )as Out_Time
from hospital
group by emp_id
having max(case when action = 'in' then time end ) > max(case when action = 'out' then time end ) 
or out_time is null; 


-- Join
with Intime as (
	select emp_id, max(time) as latest_intime
	from hospital 
	where action = 'in'
	group by emp_id),
Out_time as (
	select emp_id, max(time) as latest_outtime
	from hospital 
	where action = 'out'
	group by emp_id)
select it.emp_id, it.Latest_Intime, ot.Latest_Outtime 
from intime It
left join out_time ot
on it.emp_id = ot.emp_id
where latest_intime > latest_outtime or latest_outtime is null;