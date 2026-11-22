use insurance_db;

drop procedure if exists sp_lapse_cursor;
drop procedure if exists sp_lapse_set_based;

delimiter //

-- TASK 4: CURSOR WITH NOT FOUND HANDLER
-- Finds unpaid policies whose payment due date has passed.
create procedure sp_lapse_cursor(inout p_processed_count int)
begin
    declare v_done int default 0;
    declare v_policy_id int;

    declare policy_cursor cursor for
        select policy_id
        from policies
        where payment_status = 'UNPAID'
          and payment_due_date < current_date
          and status = 'ACTIVE';

    declare continue handler for not found set v_done = 1;

    open policy_cursor;

    read_loop: loop
        fetch policy_cursor into v_policy_id;

        if v_done = 1 then
            leave read_loop;
        end if;

        update policies
        set status = 'LAPSED'
        where policy_id = v_policy_id;

        insert into lapse_log(policy_id, log_date, remarks)
        values(v_policy_id, current_date, 'Policy marked as lapsed');

        set p_processed_count = p_processed_count + 1;
    end loop;

    close policy_cursor;
end //

delimiter ;

-- Example cursor call
set @processed_count = 0;
call sp_lapse_cursor(@processed_count);
select @processed_count as total_processed;
select * from lapse_log;
select policy_id, status from policies;

-- TASK 4: SET-BASED VERSION
-- Use this instead of the cursor when processing all matching policies.
-- Run this alternative on a fresh copy of the sample data, or reset the
-- affected policy statuses and clear lapse_log before comparing.
delimiter //

create procedure sp_lapse_set_based(inout p_processed_count int)
begin
    declare v_count int default 0;

    insert into lapse_log(policy_id, log_date, remarks)
    select policy_id, current_date, 'Policy marked as lapsed'
    from policies
    where payment_status = 'UNPAID'
      and payment_due_date < current_date
      and status = 'ACTIVE';

    set v_count = row_count();

    update policies
    set status = 'LAPSED'
    where payment_status = 'UNPAID'
      and payment_due_date < current_date
      and status = 'ACTIVE';

    set p_processed_count = p_processed_count + v_count;
end //

delimiter ;
