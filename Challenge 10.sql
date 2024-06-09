-- Google Interview Question 

-- Find companies who have atleast 2 users who speaks in english and german both the language
create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');

select * from company_users;


with cte as (
	select 
		Company_id, user_id
	from company_users
	where language in ('English', 'German')
	group by company_id, user_id
	having count( user_id)>= 2)
select company_id
from cte
group by company_id
having count(user_id) >= 2;

With UserDetails as (
Select Eng.Company_id,Eng.[USER_ID],Eng.[language1],Ger.[language2] from 
(Select Company_id,[USER_ID],[language] [language1] from company_users where [language]='English' ) as Eng
inner join
(Select Company_id, [USER_ID],[language] [language2] from company_users where [language]='German' ) as Ger on Eng.[USER_ID]=Ger.[USER_ID]
)

Select Company_id, Count(User_ID) as Usercount,[language1],[language2] from UserDetails 
group by Company_id,[language1],[language2] Having Count(User_ID) > = 2;

With UserDetails as (
Select Eng.Company_id,Eng.USER_ID,Eng.language1,Ger.language2 from 
(Select Company_id,USER_ID,language language1 from company_users where language='English' ) as Eng
inner join
(Select Company_id, USER_ID,language language2 from company_users where language='German' ) as Ger 
on Eng.USER_ID=Ger.USER_ID
)

Select Company_id, Count(User_ID) as Usercount,language1,language2 from UserDetails 
group by Company_id,language1,language2 Having Count(User_ID) >= 2;