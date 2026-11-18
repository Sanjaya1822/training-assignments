-- day-5 assignment set 2: bank branch accounts

create database if not exists bank_db;
use bank_db;

-- task 1 and 2: create simple normalized tables

create table managers(
    manager_id int auto_increment primary key,
    manager_name varchar(50) not null
);

create table branches(
    branch_id int auto_increment primary key,
    branch_name varchar(50) not null,
    branch_city varchar(50) not null
);

create table customers(
    customer_id int auto_increment primary key,
    customer_name varchar(50) not null,
    customer_address varchar(100),
    manager_id int,
    foreign key (manager_id)references managers(manager_id)
);

create table accounts(
    account_id int auto_increment primary key,
    account_number varchar(20) not null unique,
    customer_id int not null,
    branch_id int not null,
    account_type varchar(20) not null,
    balance decimal(10,2) not null,
    opened_date date not null,
    foreign key (customer_id) references customers(customer_id),
    foreign key (branch_id) references branches(branch_id),
    check (balance >= 0),
    check (account_type in ('savings', 'current', 'fixed'))
);

-- task 3: delete and rollback demonstration

create table test_account(
    id int auto_increment primary key,
    name varchar(30)
);

insert into test_account (name) values('arun'),('priya');

start transaction;
delete from test_account where id = 1;
rollback;
select * from test_account;

-- truncate removes all rows and resets auto_increment.
-- truncate table test_account;

-- drop removes the complete table.
-- drop table test_account;

-- task 4: sample filtering queries

-- accounts opened in the last quarter with balance above 10000

select *
from accounts
where opened_date between '2026-07-01' and'2026-09-30'
and balance > 10000;

-- and: both conditions must be true

select * from accounts
where account_type = 'savings' and balance >10000;

-- or: either condition can be true

select * from accounts
where account_type = 'savings' or account_type = 'current';

-- in: matches any value in the list

select * from accounts
where account_type in ('savings','current');

-- between: checks a range

select * from accounts
where balance between 10000 and 50000;

-- like: searches using a pattern

select * from customers
where customer_name like 'a%';

-- update example

update accounts
set balance = 20000
where account_number 'a1001';

-- delete example

delete from accounts
where account_number = 'a1005';

-- task 5: alter table

alter table customers add kyc_status varchar(20);

-- rename table example
-- rename table managers to relationship_managers;