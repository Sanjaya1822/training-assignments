USE RetailSales;

select product_id, sum(quantity*unit_price) as revenue from  order_items 
group by product_id 
ORDER BY revenue DESC LIMIT 5;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;



select c.customer_name from customers c join orders o on c.customer_id=o.customer_id group by c.customer_id having count(order_id)>3;


SELECT c.city, ROUND(SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id), 2) AS avg_basket_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.city;



select order_id from orders where payment_status is null;



select customer_name from customers where customer_id not in(select customer_id from orders);

SELECT p.category,
    ROUND(SUM(oi.quantity * oi.unit_price) * 100 /
        (SELECT SUM(quantity * unit_price) FROM order_items),2) AS revenue_share
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category;


select o.order_date ,  sum(oi.quantity * oi.unit_price) as total_sales
from orders o join order_items oi on o.order_id=oi.order_id
group by o.order_date 
order by total_sales desc limit 1;
