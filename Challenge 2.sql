-- Olympic Gold Medals Problem | SQL Online Interview Question | Data Analytics | 2 Solutions
-- Write a Query to find gold medal per swimmer for swimmer who won only gold medals



CREATE TABLE events (
	ID int,
	event varchar(255),
	YEAR INt,
	GOLD varchar(255),
	SILVER varchar(255),
	BRONZE varchar(255)
);

INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

select * from events;


select Gold as Player, count(*) as No_Of_Medals
from events
where gold not in (
		select silver from events 
		Union all
		select bronze from events)
group by Gold;

-- Alternate Way
with Cte as (
select Gold as Player, 'Gold' as Medal_Type from events
union all
select silver as Player, 'Silver' as Medal_Type from events
Union all
select Bronze as Player, 'Bronze' as Medal_Type from events)
select Player, Count(*) as No_Gold_Medal
from cte
group by player
having count(distinct Medal_Type) = 1 and max(Medal_Type) = "Gold";
