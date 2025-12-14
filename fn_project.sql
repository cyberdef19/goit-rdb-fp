use pandemic;
#--------------------------------- Кількість завантажених даних-------------------------------------------
#--select count(*)--
#--from infectious_cases;
#----------------------------------Кількість завантажених даних---------------------------------------------
/*
#-----------------------Завдання 2. Створення нормалізованих таблиць та їх заповнення даними--------------------------------
create table if not exists countries_tb(
country_id int primary key auto_increment not null,
name_col varchar(50) unique, 
code_col varchar(10)
);

create table if not exists infectious_cases_norm(
ic_id int primary key auto_increment not null,
country int,
country_name varchar(50),
year_col year,
polio_cases int,
cases_guinea_worm int,
number_rabies double,
number_malaria double,
number_hiv double,
number_tuberculosis double,
number_cholera_cases double,
constraint country_fk foreign key (country)
references countries_tb (country_id)
);

insert into countries_tb(name_col, code_col)
select ic.entity, ic.code
from infectious_cases as ic
group by ic.entity, ic.code;

insert into infectious_cases_norm( country_name, year_col, polio_cases, cases_guinea_worm, 
number_rabies, number_malaria, number_hiv, number_tuberculosis, number_cholera_cases)
select ic.entity, year(ic.year), ic.polio_cases, ic.cases_guinea_worm,
ic.number_rabies, ic.number_malaria, ic.number_hiv, ic.number_tuberculosis, ic.number_cholera_cases
from infectious_cases as ic;

update infectious_cases_norm as icn
join countries_tb as c on icn.country_name = c.name_col
set icn.country = c.country_id;

alter table infectious_cases_norm
drop column country_name;
#---------------------------Завдання 2. Створення нормалізованих таблиць та їх заповнення даними---------------------
*/
/*
#---------------------------Виконання завдання 3 Аналіз даних---------------------------------------------
select c.name_col as 'Назва країни', c.code_col as 'Абревіатура', avg(icn.number_rabies) as Average, 
min(icn.number_rabies) as Minimum, max(icn.number_rabies) as Maximum, sum(icn.number_rabies) as Sum
from infectious_cases_norm as icn inner join countries_tb as c on c.country_id = icn.country 
group by icn.country
order by Average desc
limit 10; 
#--------------------------- -Виконання завдання 3 Аналіз даних-----------------------------------------
*/
/*
#-----------------------------Завдання 4. Колонка різниці в роках--------------------------------------------

select icn.*, makedate(icn.year_col, 1) as 'Year Date', curdate() as 'Current Date', timestampdiff(YEAR, makedate(icn.year_col, 1), curdate()) as 'Різниця в роках'
from infectious_cases_norm as icn;
#-----------------------------Завдання 4. Колонка різниці в роках--------------------------------------------------
*/
/*
#-----------------------------Завдання 5. Власна функція ------------------------------------------------------------
drop function if exists diff_dates;
delimiter //

create function diff_dates(year_val year)
returns int
no sql
deterministic
begin
	declare result int;
    set result = timestampdiff(YEAR, makedate(year_val, 1), curdate());
    return result;
end//

delimiter ;

select icn.*, diff_dates(icn.year_col) as 'Різниця в роках'
from infectious_cases_norm as icn;
#-------------------------------------------Завдання 5. Власна функція---------------------------------------------
*/







