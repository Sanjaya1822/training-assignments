create database if not exists logistics_db;
use logistics_db;

create table hubs (
    hub_id int primary key,
    hub_name varchar(60) not null,
    city varchar(50) not null,
    region varchar(30) not null
);

create table carriers (
    carrier_id int primary key,
    carrier_name varchar(60) not null,
    service_type varchar(40)
);

create table customers (
    customer_id int primary key,
    customer_name varchar(60) not null,
    city varchar(50)
);

create table employees (
    employee_id int primary key,
    employee_name varchar(60) not null,
    job_title varchar(40),
    supervisor_id int null,
    foreign key (supervisor_id) references employees(employee_id)
);

create table shipments (
    shipment_id int primary key,
    customer_id int not null,
    carrier_id int not null,
    origin_hub_id int not null,
    destination_hub_id int not null,
    shipment_date date not null,
    expected_delivery_date date not null,
    delivered_date date null,
    shipping_cost decimal(10,2) not null,
    status varchar(25) not null,
    foreign key (customer_id) references customers(customer_id),
    foreign key (carrier_id) references carriers(carrier_id),
    foreign key (origin_hub_id) references hubs(hub_id),
    foreign key (destination_hub_id) references hubs(hub_id)
);

create table delivery_events (
    event_id int primary key,
    shipment_id int not null,
    event_date datetime not null,
    event_location varchar(60),
    event_description varchar(100),
    foreign key (shipment_id) references shipments(shipment_id)
);


insert into hubs values
(1, 'Chennai Central Hub', 'Chennai', 'South'),
(2, 'Coimbatore Hub', 'Coimbatore', 'South'),
(3, 'Bengaluru Hub', 'Bengaluru', 'South'),
(4, 'Mumbai Hub', 'Mumbai', 'West'),
(5, 'Delhi Hub', 'Delhi', 'North'),
(6, 'Kochi Hub', 'Kochi', 'South'),
(7, 'Hyderabad Hub', 'Hyderabad', 'South');

insert into carriers values
(1, 'FastTrack Logistics', 'Express'),
(2, 'BlueDart Transport', 'Standard'),
(3, 'SafeMove Couriers', 'Economy'),
(4, 'QuickShip Services', 'Express'),
(5, 'NoShipment Carrier', 'Standard');

insert into customers values
(1, 'Arun Kumar', 'Chennai'),
(2, 'Priya Sharma', 'Coimbatore'),
(3, 'Rahul Das', 'Bengaluru'),
(4, 'Meena Raj', 'Mumbai'),
(5, 'Karthik S', 'Delhi'),
(6, 'Divya Nair', 'Kochi');

insert into employees values
(101, 'Ravi Kumar', 'Regional Manager', null),
(102, 'Anitha', 'Hub Manager', 101),
(103, 'Suresh', 'Delivery Supervisor', 102),
(104, 'Kavya', 'Delivery Executive', 103),
(105, 'Manoj', 'Delivery Executive', 103),
(106, 'Farah', 'Operations Analyst', 102);

insert into shipments values
(1001, 1, 1, 1, 2, '2026-10-01', '2026-10-03', '2026-10-07', 850.00, 'Delivered'),
(1002, 2, 2, 2, 3, '2026-10-02', '2026-10-05', '2026-10-05', 500.00, 'Delivered'),
(1003, 3, 1, 3, 4, '2026-10-03', '2026-10-06', '2026-10-10', 1200.00, 'Delivered'),
(1004, 1, 3, 1, 5, '2026-10-04', '2026-10-08', '2026-10-08', 950.00, 'Delivered'),
(1005, 4, 2, 4, 1, '2026-10-05', '2026-10-08', '2026-10-12', 700.00, 'Delivered'),
(1006, 5, 4, 5, 2, '2026-10-06', '2026-10-09', '2026-10-09', 1100.00, 'Delivered'),
(1007, 6, 1, 6, 1, '2026-10-07', '2026-10-10', '2026-10-10', 650.00, 'Delivered'),
(1008, 2, 3, 2, 5, '2026-10-08', '2026-10-11', '2026-10-16', 1300.00, 'Delivered'),
(1009, 3, 2, 3, 1, '2026-10-09', '2026-10-12', '2026-10-12', 450.00, 'Delivered'),
(1010, 4, 4, 4, 3, '2026-10-10', '2026-10-13', '2026-10-14', 900.00, 'Delivered'),
(1011, 5, 1, 5, 4, '2026-10-11', '2026-10-14', null, 1500.00, 'In Transit'),
(1012, 6, 3, 6, 2, '2026-10-12', '2026-10-15', '2026-10-20', 750.00, 'Delivered'),
(1013, 1, 2, 1, 3, '2026-10-13', '2026-10-16', '2026-10-16', 550.00, 'Delivered'),
(1014, 2, 1, 2, 4, '2026-10-14', '2026-10-17', '2026-10-17', 800.00, 'Delivered'),
(1015, 3, 4, 3, 5, '2026-10-15', '2026-10-18', '2026-10-18', 1000.00, 'Delivered');

insert into delivery_events values
(1, 1001, '2026-10-01 09:00:00', 'Chennai', 'Shipment picked up'),
(2, 1001, '2026-10-04 11:00:00', 'Coimbatore', 'Shipment delayed at sorting'),
(3, 1002, '2026-10-02 10:00:00', 'Coimbatore', 'Shipment picked up'),
(4, 1003, '2026-10-07 12:00:00', 'Bengaluru', 'Shipment delayed'),
(5, 1004, '2026-10-08 08:00:00', 'Chennai', 'Shipment delivered'),
(6, 1005, '2026-10-12 15:00:00', 'Mumbai', 'Shipment delivered'),
(7, 1008, '2026-10-14 10:00:00', 'Coimbatore', 'Shipment delayed'),
(8, 1012, '2026-10-20 16:00:00', 'Kochi', 'Shipment delivered');


-- TASK 1: TEN SIMPLE JOIN QUERIES

-- 1. Show shipment details with customer and carrier names.
select s.shipment_id, c.customer_name, cr.carrier_name, s.shipping_cost
from shipments s
inner join customers c on s.customer_id = c.customer_id
inner join carriers cr on s.carrier_id = cr.carrier_id;

-- 2. Find shipments delayed by more than two days.
select s.shipment_id, cr.carrier_name,
       datediff(s.delivered_date, s.expected_delivery_date) as delay_days
from shipments s
inner join carriers cr on s.carrier_id = cr.carrier_id
where s.delivered_date is not null
and datediff(s.delivered_date, s.expected_delivery_date) > 2;

-- 3. Find hubs that have no outbound shipments.
select h.hub_name
from hubs h
left join shipments s on h.hub_id = s.origin_hub_id
where s.shipment_id is null;

-- 4. Show all carriers, even if they have no shipments.
select cr.carrier_name, s.shipment_id
from shipments s
right join carriers cr on s.carrier_id = cr.carrier_id;

-- 5. Show each customer and their number of shipments.
select c.customer_name, count(s.shipment_id) as total_shipments
from customers c
left join shipments s on c.customer_id = s.customer_id
group by c.customer_id, c.customer_name;

-- 6. Show shipment tracking events.
select s.shipment_id, d.event_location, d.event_description
from shipments s
inner join delivery_events d on s.shipment_id = d.shipment_id;

-- 7. Show employees and their supervisors (SELF JOIN).
select e.employee_name as employee,
       m.employee_name as supervisor
from employees e
left join employees m on e.supervisor_id = m.employee_id;

-- 8. Count outbound shipments from each hub.
select h.hub_name, count(s.shipment_id) as total_shipments
from hubs h
left join shipments s on h.hub_id = s.origin_hub_id
group by h.hub_id, h.hub_name;

-- 9. Find total shipping cost for each carrier.
select cr.carrier_name, sum(s.shipping_cost) as total_cost
from carriers cr
left join shipments s on cr.carrier_id = s.carrier_id
group by cr.carrier_id, cr.carrier_name;

-- 10. Show customers and their destination hubs.
select c.customer_name, h.hub_name as destination
from customers c
inner join shipments s on c.customer_id = s.customer_id
inner join hubs h on s.destination_hub_id = h.hub_id;


-- TASK 2: SIMPLE SUBQUERIES (IN, EXISTS, ANY, ALL)

-- 11. IN: Find customers who shipped to a South region hub.
select customer_name
from customers
where customer_id in (
    select customer_id
    from shipments
    where destination_hub_id in (
        select hub_id from hubs where region = 'South'
    )
);

-- 12. EXISTS: Find customers who have at least one shipment.
select c.customer_name
from customers c
where exists (
    select shipment_id
    from shipments s
    where s.customer_id = c.customer_id
);

-- 13. Find customers who shipped to EVERY hub.
select c.customer_name
from customers c
where not exists (
    select hub_id
    from hubs h
    where not exists (
        select shipment_id
        from shipments s
        where s.customer_id = c.customer_id
        and s.destination_hub_id = h.hub_id
    )
);

-- 14. ANY: Find carriers whose average delay is greater than
-- at least one other carrier's average delay.
select cr.carrier_name,
       avg(datediff(s.delivered_date, s.expected_delivery_date)) as avg_delay
from carriers cr
join shipments s on cr.carrier_id = s.carrier_id
where s.delivered_date is not null
group by cr.carrier_id, cr.carrier_name
having avg(datediff(s.delivered_date, s.expected_delivery_date)) > ANY (
    select avg(datediff(delivered_date, expected_delivery_date))
    from shipments
    where delivered_date is not null
    group by carrier_id
);

-- 15. ALL: Find carriers whose average delay is greater than
-- the overall average delay.
select cr.carrier_name,
       avg(datediff(s.delivered_date, s.expected_delivery_date)) as avg_delay
from carriers cr
join shipments s on cr.carrier_id = s.carrier_id
where s.delivered_date is not null
group by cr.carrier_id, cr.carrier_name
having avg(datediff(s.delivered_date, s.expected_delivery_date)) > ALL (
    select avg_delay
    from (
        select avg(datediff(delivered_date, expected_delivery_date)) as avg_delay
        from shipments
        where delivered_date is not null
    ) as overall_delay
);

-- ============================================================
-- TASK 3: REWRITE TWO SUBQUERIES AS JOINS
-- ============================================================

-- 16. Subquery: Find customers who have shipments.
select customer_name
from customers
where customer_id in (select customer_id from shipments);

-- 17. Same result using JOIN.
select distinct c.customer_name
from customers c
inner join shipments s on c.customer_id = s.customer_id;

-- 18. Subquery: Find hubs with no outbound shipments.
select hub_name
from hubs
where hub_id not in (select origin_hub_id from shipments);

-- 19. Same result using LEFT JOIN.
select h.hub_name
from hubs h
left join shipments s on h.hub_id = s.origin_hub_id
where s.shipment_id is null;


-- TASK 4: NESTED SUBQUERY
-- Find the second-highest shipping cost for each origin hub.

select h.hub_name,
       (select max(shipping_cost)
        from shipments s1
        where s1.origin_hub_id = h.hub_id
        and shipping_cost < (
            select max(shipping_cost)
            from shipments s2
            where s2.origin_hub_id = h.hub_id
        )) as second_highest_cost
from hubs h;


select * from hubs;
select * from carriers;
select * from customers;
select * from employees;
select * from shipments;
select * from delivery_events;
