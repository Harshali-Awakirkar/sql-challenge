-- Airbnb SQL Interview Question | Convert Comma Separated Values into Rows | Data Analytics
create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);

insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room');
-- Find the room types that are searched for most no of times. Output the room type alongside the number of searched for it
-- if the filter for room type has more than one room type consider each unique room type as separate row
-- sort the result based on the number of seacrhes in descending order
select * from airbnb_searches;

with cte as(select 
	sum(case when filter_room_types like '%entire%' then 1 else 0 end )as entire,
	sum(case when filter_room_types like '%private%' then 1 else 0 end )as private,
	sum(case when filter_room_types like '%shared%' then 1 else 0 end )as shared
from airbnb_searches)
select 'entire room' as room, entire cnt from cte
union all
select 'Private room' as room, private cnt from cte
union all
select 'shared room' as room, shared cnt from cte
order by cnt desc;

Analyze which room kinds are most frequently searched for. Provide the type of room and the number of times it has been searched for.
In the instance that the room type filter contains multiple kinds of room, treat each distinct room type as a separate row as well as sort the results in descending order by the number of searches.