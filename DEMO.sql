create database if not exists DEMO;

use DEMO;

create table if not exists USERS (
id int(2) auto_increment primary key,
login varchar(10) not null,
password varchar(10) not null
);

insert into USERS (login, password) values
('A_user', 'qwerty1'),
('B_user', 'qwerty2'),
('C_user', 'qwerty3'),
('D_user', 'qwerty4'),
('E_user', 'qwerty5'),
('F_user', 'qwerty6'),
('G_user', 'qwerty7'),
('H_user', 'qwerty8'),
('I_user', 'qwerty9'),
('J_user', 'qwerty10'),
('K_user', 'qwerty11'),
('L_user', 'qwerty12'),
('M_user', 'qwerty13'),
('N_user', 'qwerty14'),
('O_user', 'qwerty15');

select* from USERS;

create table if not exists PROFILES (
id int(2) auto_increment primary key,
first_name varchar(10) not null,
last_name varchar(10) not null,
email varchar(20) not null,
age int(2) not null
);

insert into PROFILES (first_name, last_name, email, age)  values
('Nick', 'White', 'qwerty1@.com', 20),
('Ann', 'Brown', 'qwerty2@.com', 26),
('Jane', 'Red', 'qwerty3@.com', 33),
('Alice', 'Green', 'qwerty4@.com', 19),
('John', 'Grey', 'qwerty5@.com', 35),
('Bob', 'Yellow', 'qwerty6@.com', 22),
('Bill', 'Black', 'qwerty7@.com', 45),
('Mary', 'Blue', 'qwerty8@.com', 18),
('Kit', 'Pink', 'qwerty9@.com', 33),
('Mike', 'Orange', 'qwerty10@.com', 23);

select* from PROFILES;

create table if not exists GAMES (
id int(2) auto_increment primary key,
first_player_id int(2),
second_player_id int(2)
);

insert into GAMES (first_player_id, second_player_id)  values
(1, 10),
(2, 9),
(3, 8),
(4, 7),
(5, 6),
(6, 1),
(7, 9),
(8, 5),
(9, 4),
(10, 6);

select* from GAMES;

create table if not exists GAME_RESULTS (
id int(2) auto_increment primary key,
result varchar(10)
);

insert into GAME_RESULTS  values
(1, 'WIN'),
(2, 'LOSE'),
(3, 'LOSE');

select* from GAME_RESULTS;

update PROFILES
set first_name = 'Bob'
where id = 5;

select* from PROFILES;

update GAME_RESULTS
set result = 'DRAW'
where id = 3;

select* from GAME_RESULTS;

delete
from USERS
where id = 14;

delete
from USERS
where id = 15;

select* from USERS;

create table if not exists ACHIEVEMENTS (
id int(2) auto_increment primary key,
achiev_name varchar(20)
);

insert into ACHIEVEMENTS (achiev_name)  values
('newbie'),
('master'),
('grandmaster'),
('supergrandmaster'),
('kingofchess');

select* from ACHIEVEMENTS;

create table if not exists PLAYER_ACHIEVS (
id int(2) auto_increment primary key,
player_id int(2),
achiev_id int(2)
);

insert into PLAYER_ACHIEVS (player_id,achiev_id) values
(1,1),
(1,2),
(1,3),
(2,4),
(2,5),
(3,1),
(3,2),
(3,3),
(4,4),
(4,5),
(5,1),
(5,2),
(6,3),
(7,4),
(8,5),
(9,1),
(10,2),
(10,3),
(10,4);

select* from PLAYER_ACHIEVS;

create table if not exists PLAYER_RESULT (
id int(2) auto_increment primary key,
player_id int(2),
result_id int(2)
);

insert into PLAYER_RESULT (player_id, result_id) values
(1,1),
(1,2),
(1,3),
(2,1),
(2,2),
(2,3),
(3,1),
(3,2),
(3,3),
(4,1),
(4,2),
(4,3),
(5,1),
(5,2),
(5,3),
(6,1),
(6,2),
(6,3),
(7,1),
(7,2),
(7,3),
(8,1),
(8,2),
(8,3),
(9,1),
(9,2),
(9,3),
(10,1),
(10,2),
(10,3);

select* from PLAYER_RESULT;

alter table GAMES
add column winner_id int(2);

update GAMES 
set winner_id=case
when id=1 then 1
when id=2 then 2
when id=3 then 3
when id=4 then 4
when id=5 then 6
when id=6 then 1
when id=7 then 9
when id=8 then 8
when id=9 then 4
else winner_id
end;

alter table PROFILES
add constraint FK_PROFILES_USERS
foreign key(id) 
references 
USERS(id);

alter table GAMES
add constraint FK_GAMES_first_player_PROFILES
foreign key (first_player_id) references 
PROFILES(id);

alter table GAMES
add constraint FK_GAMES_second_player_PROFILES
foreign key (second_player_id) references 
PROFILES(id);

alter table GAMES
add constraint FK_GAMES_PROFILES
foreign key (winner_id) references 
PROFILES(id);

alter table PLAYER_ACHIEVS
add constraint FK_PLAYER_ACHIEVS_PROFILES
foreign key (player_id) references 
PROFILES(id);

alter table PLAYER_ACHIEVS
add constraint FK_PLAYER_ACHIEVS_ACHIEVEMENTS
foreign key (achiev_id) references 
ACHIEVEMENTS(id);

alter table PLAYER_RESULT
add constraint FK_PLAYER_RESULT_PROFILES
foreign key (player_id) references 
PROFILES(id);

alter table PLAYER_RESULT
add constraint FK_PLAYER_RESULT_GAME_RESULTS
foreign key (result_id) references 
GAME_RESULTS(id);


select login, first_name, last_name
from PROFILES
join USERS on profiles.id=users.id;

select profiles.id, first_name, email, achiev_name
from PROFILES
join PLAYER_ACHIEVS on player_id=profiles.id
join ACHIEVEMENTS on achiev_id=ACHIEVEMENTS.id
where profiles.id<=5;

-- Таблица отредактирована для присвоения в задании первому игроку статуса win,lose,draw

alter table GAMES
add column first_player_result_value varchar(10);

update GAMES set first_player_result_value=case
when first_player_id=winner_id then 'WIN'
when winner_id is null then 'DRAW'
else 'LOSE'
end;

select first_name, last_name, first_player_result_value as result_value, games.id as game_id
from PROFILES
join GAMES on profiles.id=first_player_id
join PLAYER_RESULT on profiles.id=PLAYER_RESULT.player_id
join GAME_RESULTS on GAME_RESULTS.id=PLAYER_RESULT.result_id
group by game_id;


select profiles.id, first_name, last_name, email, age, winner_id 
from PROFILES, GAMES
where winner_id = profiles.id;

select first_name,  count(second_player_id) as count_of_games
from GAMES
join PROFILES on second_player_id=profiles.id
group by second_player_id
order by count_of_games DESC;

select first_name,email from PROFILES
where id in (select first_player_id
from GAMES);








































































































