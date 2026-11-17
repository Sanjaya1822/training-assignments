USE RetailSales;

select * from orders where payment_status = 'paid';


select customer_id, count(order_id) as total_orders
from orders
group by customer_id
having count(order_id) > 3;