use Interview_Prep_Ankit_Bansal;
-- Table for Personal Profiles
CREATE TABLE PersonalProfiles (
    ProfileID INT PRIMARY KEY,
    ProfileName VARCHAR(100),
    FollowersCount INT
);

-- Insert sample data into PersonalProfiles
INSERT INTO PersonalProfiles (ProfileID, ProfileName, FollowersCount)
VALUES 
    (1, 'Nick Singh', 92000), 
    (2, 'Zach Wilson', 199000),
    (3, 'Daliana Liu', 171000),
    (4, 'Ravit Jain', 107000),
    (5, 'Vin Vashishta', 139000),
    (6, 'Susan Woicicki', 39000);

-- Table for Employee-Company Relationship
CREATE TABLE EmployeeCompany (
    Personal_ProfileID INT,
    CompanyID INT
);

-- Insert sample data into EmployeeCompany
INSERT INTO EmployeeCompany (Personal_ProfileID , CompanyID )
VALUES
    (1, 4),
    (1, 9),
    (2, 2),
    (3, 1),
    (4, 3),
    (5, 6),
    (6, 5);

-- Table for Company Pages
CREATE TABLE CompanyPages (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Followers INT
);

-- Insert sample data into CompanyPages
INSERT INTO CompanyPages (CompanyID, Name, Followers)
VALUES
    (1, 'The Data Science Podcast', 8000),
    (2, 'Airbnb', 700000),
    (3, 'The Ravit Show', 6000),
    (4, 'Data Lemur', 200),
    (5, 'You Tube', 16000000),
    (6, 'Data Science Vin', 4500),
    (9, 'Ace The Data Science Interview', 4479);
select * from PersonalProfiles;
Select * from EmployeeCompany;
select * from CompanyPages;

/* The linkedin creator team is looking for power creators who use their personal profile as a company or influence page
If someone's linkedin page has more followers than the company they work for, we can safely assume that the person is 
power creator.
Write a query to return the ID's of these linkedin power creators
Assumption : Person can work at multiple companies*/
 
With CompanyFollowers as (
	Select ec.Personal_ProfileID, max(cp.followers) as Max_Followers
	from EmployeeCompany Ec
	Join CompanyPages Cp
	on ec.companyid = cp.companyid
	group by ec.Personal_ProfileID
)
select 
	pp.ProfileID, pp.ProfileName 
from companyfollowers cf
join PersonalProfiles pp
on cf. Personal_ProfileID = pp.ProfileID
where FollowersCount > cf.Max_Followers;

