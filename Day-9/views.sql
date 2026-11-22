use insurance_db;

-- TASK 1: VIEW - POLICIES DUE IN THE NEXT 30 DAYS
-- Sensitive details such as phone, email and address are not displayed.

create or replace view vw_policy_due as
select p.policy_id, c.customer_name, p.policy_type,
       p.end_date, p.premium, p.status
from policies p
join customers c on p.customer_id = c.customer_id
where p.end_date between current_date and date_add(current_date, interval 30 day)
  and p.status = 'ACTIVE';

-- Display the view
select * from vw_policy_due;
