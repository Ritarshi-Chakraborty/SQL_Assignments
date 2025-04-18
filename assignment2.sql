create database Employees;
use Employees;

create table employee_code_table (
employee_code char(20) primary key,
employee_code_name char(20),
employee_domain char(15)
);

insert into employee_code_table values
("su_john", "ru_john", "JAVA"),
("su_daenerys", "du_daenerys", "PHP"),
("su_cersei", "ru_cersei", "JAVA"),
("su_tyrion", "tu_tyrion", "Angular JS");

select * from employee_code_table;

create table employee_details_table (
employee_id varchar(8) primary key,
employee_first_name char(15),
employee_last_name char(15),
Graduation_percentile varchar(5)
);

insert into employee_details_table values
("RU122", "John", "Snow", "60%"),
("RU123", "Daenerys", "Targaryen", "88%"),
("RU124", "Cersei", "Lannister", "72%"),
("RU125", "Tyrion", "Lannister", "64%");

select * from employee_details_table;

create table employee_salary_table (
employee_id varchar(8),
employee_salary varchar(5),
employee_code char(20),
foreign key (employee_id) references employee_details_table(employee_id),
foreign key (employee_code) references employee_code_table(employee_code)
);

insert into employee_salary_table values
("RU122", "60k", "su_john"),
("RU123", "25k", "su_daenerys"),
("RU124", "44k", "su_cersei"),
("RU125", "85k", "su_tyrion");

select * from employee_salary_table;

-- WAQ to list all employee first name with salary greater than 50k.
select details.employee_first_name 
from employee_details_table as details, employee_salary_table as salary
where details.employee_id = salary.employee_id and salary.employee_salary > "50k";

-- WAQ to list all employee last name with graduation percentile greater than 70%.
select details.employee_last_name
from  employee_details_table as details
where details.Graduation_percentile > "70%";

-- WAQ to list all employee code name with graduation percentile less than 70%
select codes.employee_code_name
from employee_code_table as codes, employee_details_table as details, employee_salary_table as salary
where codes.employee_code = salary.employee_code and salary.employee_id = details.employee_id and details.Graduation_percentile < "70%";

-- WAQ to list all employee’s full name that are not of domain Java.
select concat(details.employee_first_name, " ", details.employee_last_name) as full_name
from employee_code_table as codes, employee_details_table as details, employee_salary_table as salary
where codes.employee_code = salary.employee_code and salary.employee_id = details.employee_id and codes.employee_domain <> "JAVA";

-- WAQ to list all employee_domain with sum of it's salary
-- 1st approach using "Substring"
select codes.employee_domain, concat(sum(substring(salary.employee_salary, "1", "2")), "k") as Total_salary
from employee_code_table as codes, employee_salary_table as salary
where codes.employee_code = salary.employee_code
group by codes.employee_domain;
-- 2nd approach using "Cast"
select codes.employee_domain, concat(sum(cast(salary.employee_salary as unsigned)), "k") as Total_salary
from employee_code_table as codes, employee_salary_table as salary
where codes.employee_code = salary.employee_code
group by codes.employee_domain;

-- Write the above query again but dont include salaries which is less than 30k.
select codes.employee_domain, concat(sum(substring(salary.employee_salary, "1", "2")), "k") as Total_salary
from employee_code_table as codes, employee_salary_table as salary
where codes.employee_code = salary.employee_code and salary.employee_salary >= "30k"
group by codes.employee_domain;

-- WAQ to list all employee id which has not been assigned employee code.
select salary.employee_id
from employee_salary_table as salary
where salary.employee_code is null;
