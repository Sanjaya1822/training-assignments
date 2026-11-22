use insurance_db;

drop function if exists fn_premium_with_no_claim_discount;
drop procedure if exists sp_renew_policy;

delimiter //

-- TASK 3: FUNCTION
-- Gives a 10% discount when the policy has no claims.
create function fn_premium_with_no_claim_discount(
    p_premium decimal(10,2),
    p_claim_count int
)
returns decimal(10,2)
deterministic
begin
    if p_claim_count = 0 then
        return p_premium * 0.90;
    else
        return p_premium;
    end if;
end //

delimiter ;


select p.policy_id, p.premium,
       (select count(*) from claims c
        where c.policy_id = p.policy_id) as claim_count,
       fn_premium_with_no_claim_discount(
           p.premium,
           (select count(*) from claims c
            where c.policy_id = p.policy_id)
       ) as premium_after_discount
from policies p;


delimiter //

-- TASK 2: STORED PROCEDURE
-- Validates policy, checks pending claims, recalculates premium,
-- updates policy and inserts audit record in one transaction.
create procedure sp_renew_policy(
    in p_policy_id int,
    out p_new_premium decimal(10,2)
)
begin
    declare v_old_premium decimal(10,2);
    declare v_claim_count int;
    declare v_policy_status varchar(20);
    declare v_new_premium decimal(10,2);

    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;

    start transaction;

    set p_new_premium = null;

    select count(*) into v_claim_count
    from policies
    where policy_id = p_policy_id;

    if v_claim_count = 0 then
        signal sqlstate '45000'
        set message_text = 'Policy does not exist';
    end if;

    select premium, status
    into v_old_premium, v_policy_status
    from policies
    where policy_id = p_policy_id
    for update;

    if v_policy_status <> 'ACTIVE' then
        signal sqlstate '45000'
        set message_text = 'Policy is not active';
    end if;

    select count(*) into v_claim_count
    from claims
    where policy_id = p_policy_id
      and claim_status = 'PENDING';

    if v_claim_count > 0 then
        signal sqlstate '45000'
        set message_text = 'Policy has a pending claim';
    end if;

    -- Increase base premium by 5%, then apply no-claim discount.
    select count(*) into v_claim_count
    from claims
    where policy_id = p_policy_id;

    set v_new_premium = fn_premium_with_no_claim_discount(
        v_old_premium * 1.05, v_claim_count
    );

    update policies
    set payment_due_date = date_add(end_date, interval 1 year),
        start_date = end_date,
        end_date = date_add(end_date, interval 1 year),
        premium = v_new_premium,
        payment_status = 'PAID'
    where policy_id = p_policy_id;

    insert into renewal_audit
        (policy_id, old_premium, new_premium, renewal_date, remarks)
    values
        (p_policy_id, v_old_premium, v_new_premium,
         current_date, 'Policy renewed successfully');

    set p_new_premium = v_new_premium;

    commit;
end //

delimiter ;


call sp_renew_policy(101, @new_premium);
select @new_premium as renewed_premium;


-- View renewal audit records
select * from renewal_audit;
