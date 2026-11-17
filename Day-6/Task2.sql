USE RetailSales;

SELECT
    customer_id,
    UPPER(customer_name) AS customer_name
FROM customers;

SELECT
    CONCAT(customer_name, ' - ', city) AS customer_details
FROM customers;


SELECT
    order_id,
    order_date,
    DATEDIFF('2026-11-17', order_date) AS days_since_order
FROM orders;

SELECT
    order_id,
    DATE_FORMAT(order_date, '%d-%M-%Y') AS formatted_date
FROM orders;


SELECT
    product_name,
    ROUND(price, 0) AS rounded_price
FROM products;



