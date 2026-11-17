USE RetailSales;

select count(*) as total_rows from orders;




select count(payment_status) as non_null_payments from orders;



select sum(payment_status = 'paid') as paid_orders from orders;



select avg(payment_status = 'paid') as paid_percentage from orders;

