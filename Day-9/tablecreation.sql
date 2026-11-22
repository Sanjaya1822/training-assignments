-- DAY 9 SET 2: INSURANCE PREMIUM PROCESSING
-- Database and sample data

create database if not exists insurance_db;
use insurance_db;

drop table if exists lapse_log;
drop table if exists renewal_audit;
drop table if exists claims;
drop table if exists policies;
drop table if exists customers;

create table customers (
    customer_id int primary key,
    customer_name varchar(60) not null,
    phone varchar(15),
    email varchar(80),
    address varchar(100)
);

create table policies (
    policy_id int primary key,
    customer_id int not null,
    policy_type varchar(40),
    start_date date not null,
    end_date date not null,
    premium decimal(10,2) not null,
    payment_due_date date not null,
    payment_status varchar(20) not null,
    status varchar(20) not null,
    foreign key (customer_id) references customers(customer_id)
);

create table claims (
    claim_id int primary key,
    policy_id int not null,
    claim_date date not null,
    claim_status varchar(20) not null,
    claim_amount decimal(10,2),
    foreign key (policy_id) references policies(policy_id)
);

create table renewal_audit (
    audit_id int auto_increment primary key,
    policy_id int not null,
    old_premium decimal(10,2),
    new_premium decimal(10,2),
    renewal_date date,
    remarks varchar(100),
    foreign key (policy_id) references policies(policy_id)
);

create table lapse_log (
    log_id int auto_increment primary key,
    policy_id int not null,
    log_date date not null,
    remarks varchar(100),
    foreign key (policy_id) references policies(policy_id)
);

-- Sample customers
insert into customers values
(1, 'Arun Kumar', '9876543210', 'arun@gmail.com', 'Chennai'),
(2, 'Priya Sharma', '9876543211', 'priya@gmail.com', 'Coimbatore'),
(3, 'Rahul Das', '9876543212', 'rahul@gmail.com', 'Bengaluru'),
(4, 'Meena Raj', '9876543213', 'meena@gmail.com', 'Chennai'),
(5, 'Karthik S', '9876543214', 'karthik@gmail.com', 'Madurai');

-- Sample policies
-- Dates use CURRENT_DATE so the due and lapsed examples work whenever executed.
insert into policies values
(101, 1, 'Health', date_sub(current_date, interval 335 day),
 date_add(current_date, interval 25 day), 12000.00,
 date_add(current_date, interval 25 day), 'PAID', 'ACTIVE'),

(102, 2, 'Life', date_sub(current_date, interval 340 day),
 date_add(current_date, interval 20 day), 18000.00,
 date_add(current_date, interval 20 day), 'PAID', 'ACTIVE'),

(103, 3, 'Vehicle', date_sub(current_date, interval 400 day),
 date_sub(current_date, interval 35 day), 9000.00,
 date_sub(current_date, interval 10 day), 'UNPAID', 'ACTIVE'),

(104, 4, 'Health', date_sub(current_date, interval 390 day),
 date_sub(current_date, interval 25 day), 15000.00,
 date_sub(current_date, interval 15 day), 'UNPAID', 'ACTIVE'),

(105, 5, 'Life', date_sub(current_date, interval 300 day),
 date_add(current_date, interval 60 day), 20000.00,
 date_add(current_date, interval 60 day), 'PAID', 'ACTIVE');

-- Sample claims
insert into claims values
(1, 101, date_sub(current_date, interval 100 day), 'APPROVED', 3000.00),
(2, 102, date_sub(current_date, interval 50 day), 'REJECTED', 0.00),
(3, 103, date_sub(current_date, interval 5 day), 'PENDING', 2000.00),
(4, 105, date_sub(current_date, interval 200 day), 'APPROVED', 5000.00);