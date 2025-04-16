create database IPL_Fixtures;

use IPL_Fixtures;

create table team (	
team_id int primary key,
team_name char(25),
home_ground char(50),
captain char(25)
);

insert into team values
(101, "KKR", "Eden Gardens", "Ajinkya Rahane"),
(102, "SRH", "Rajiv Gandhi International Stadium", "Pat Cummins"),
(103, "MI", "Wankhede", "Hardik Pandya"),
(104, "RCB", "Chinnaswamy", "Rajat Patidar"),
(105, "CSK", "Chepauk", "Ruturaj Gaikwad"),
(106, "GT", "Narendra Modi International Stadium", "Shubhman Gill"),
(107, "PBKS", "Maharaja Yadavindra Singh International Stadium", "Shreyas Iyer"),
(108, "RR", "Sawai Mansingh Stadium", "Riyan Parag"),
(109, "LSG", "Ekana", "Rishabh Pant"),
(110, "DC", "Arun Jaitley Stadium", "Axar Patel");

select * from team;

alter table team modify team_name char(5);

create table fixture (
match_id int primary key,
date_of_match date,
home_team int,
away_team int
);

insert into fixture values
(1, '2025-03-29', 101, 102), (2, '2025-03-30', 103, 104), (3, '2025-03-31', 105, 106), (4, '2025-04-01', 107, 108), (5, '2025-04-02', 109, 110),
(6, '2025-04-03', 101, 103), (7, '2025-04-04', 102, 104), (8, '2025-04-05', 105, 107), (9, '2025-04-06', 106, 108), (10, '2025-04-07', 109, 101),
(11, '2025-04-08', 110, 102), (12, '2025-04-09', 103, 105), (13, '2025-04-10', 104, 106), (14, '2025-04-11', 107, 109), (15, '2025-04-12', 108, 110),
(16, '2025-04-13', 101, 104), (17, '2025-04-14', 102, 105), (18, '2025-04-15', 103, 106), (19, '2025-04-16', 104, 107), (20, '2025-04-17', 105, 108),
(21, '2025-04-18', 106, 109), (22, '2025-04-19', 107, 110), (23, '2025-04-20', 108, 101), (24, '2025-04-21', 109, 102), (25, '2025-04-22', 110, 103),
(26, '2025-04-23', 101, 106), (27, '2025-04-24', 102, 107), (28, '2025-04-25', 103, 108), (29, '2025-04-26', 104, 109), (30, '2025-04-27', 105, 110),
(31, '2025-04-28', 106, 101), (32, '2025-04-29', 107, 102), (33, '2025-04-30', 108, 103), (34, '2025-05-01', 109, 104), (35, '2025-05-02', 110, 105),
(36, '2025-05-03', 106, 107), (37, '2025-05-04', 108, 109), (38, '2025-05-05', 110, 101), (39, '2025-05-06', 102, 103), (40, '2025-05-07', 104, 105),
(41, '2025-05-08', 106, 110), (42, '2025-05-09', 107, 101), (43, '2025-05-10', 108, 102), (44, '2025-05-11', 109, 103), (45, '2025-05-12', 110, 104);

select * from fixture;

create table result (
match_id int primary key,
toss_won_by int,
match_won_by int,
foreign key (match_id) references fixture(match_id)
);

insert into result values
(01, 101, 102), (02, 104, 104), (03, 105, 106), (04, 108, 107), (05, 110, 109),
(06, 103, 101), (07, 102, 104), (08, 107, 107), (09, 106, 106), (10, 101, 109),
(11, 110, 102), (12, 103, 105), (13, 104, 106), (14, 107, 109), (15, 110, 110),
(16, 104, 104), (17, 102, 105), (18, 103, 106), (19, 107, 107), (20, 108, 105),
(21, 106, 109), (22, 110, 110), (23, 101, 101), (24, 109, 102), (25, 110, 103),
(26, 101, 106), (27, 107, 107), (28, 108, 108), (29, 109, 104), (30, 105, 110),
(31, 101, 101), (32, 102, 107), (33, 103, 108), (34, 109, 109), (35, 110, 105),
(36, 106, 106), (37, 108, 108), (38, 110, 101), (39, 102, 102), (40, 105, 105),
(41, 110, 106), (42, 107, 101), (43, 102, 108), (44, 109, 109), (45, 104, 104);

select * from result;

select t1.home_ground as Venue, fixture.date_of_match as Date, t1.team_name as Home_Team, t2.team_name as Away_Team,
t1.captain as Team1_Captain, t2.captain as Team2_Captain, t3.team_name as Toss_winner, t4.team_name as Match_winner
from fixture
join team as t1 on fixture.home_team = t1.team_id 
join team as t2 on fixture.away_team = t2.team_id
join result on result.match_id = fixture.match_id
join team as t3 on result.toss_won_by = t3.team_id
join team as t4 on result.match_won_by = t4.team_id;
