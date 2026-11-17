CREATE DATABASE RetailSales;
USE RetailSales;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers VALUES
(1, 'Arun Kumar', 'Chennai', 'arun@gmail.com'),
(2, 'Priya Sharma', 'Coimbatore', 'priya@gmail.com'),
(3, 'Rahul Raj', 'Madurai', 'rahul@gmail.com'),
(4, 'Divya S', 'Chennai', 'divya@gmail.com'),
(5, 'Karthik M', 'Coimbatore', 'karthik@gmail.com'),
(6, 'Sneha R', 'Salem', 'sneha@gmail.com'),
(7, 'Vijay Kumar', 'Madurai', 'vijay@gmail.com'),
(8, 'Meena P', 'Chennai', 'meena@gmail.com');


INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Office Chair', 'Furniture', 8000),
(106, 'Desk', 'Furniture', 12000),
(107, 'Smart Watch', 'Electronics', 5000),
(108, 'Mouse', 'Accessories', 800);

INSERT INTO orders VALUES
(1001, 1, '2026-01-05', 'Paid'),
(1002, 2, '2026-01-10', 'Paid'),
(1003, 1, '2026-01-15', 'Paid'),
(1004, 3, '2026-02-02', 'Paid'),
(1005, 4, '2026-02-10', NULL),
(1006, 2, '2026-02-15', 'Paid'),
(1007, 1, '2026-03-01', 'Paid'),
(1008, 5, '2026-03-05', 'Paid'),
(1009, 3, '2026-03-12', 'Pending'),
(1010, 1, '2026-03-20', 'Paid'),
(1011, 6, '2026-04-02', 'Paid'),
(1012, 2, '2026-04-10', NULL),
(1013, 4, '2026-04-15', 'Paid'),
(1014, 5, '2026-04-20', 'Paid'),
(1015, 7, '2026-05-05', 'Paid');

INSERT INTO order_items VALUES
(1, 1001, 101, 1, 50000),
(2, 1001, 103, 2, 2000),

(3, 1002, 102, 1, 20000),
(4, 1002, 104, 2, 1500),

(5, 1003, 107, 2, 5000),
(6, 1003, 108, 3, 800),

(7, 1004, 105, 1, 8000),
(8, 1004, 103, 1, 2000),

(9, 1005, 106, 1, 12000),
(10, 1005, 108, 2, 800),

(11, 1006, 101, 1, 50000),
(12, 1006, 104, 1, 1500),

(13, 1007, 102, 2, 20000),
(14, 1007, 103, 2, 2000),

(15, 1008, 105, 2, 8000),
(16, 1008, 108, 1, 800),

(17, 1009, 107, 1, 5000),
(18, 1009, 104, 3, 1500),

(19, 1010, 101, 1, 50000),
(20, 1010, 102, 1, 20000),

(21, 1011, 103, 3, 2000),
(22, 1011, 108, 2, 800),

(23, 1012, 106, 2, 12000),
(24, 1012, 104, 2, 1500),

(25, 1013, 102, 1, 20000),
(26, 1013, 107, 2, 5000),

(27, 1014, 101, 1, 50000),
(28, 1014, 105, 1, 8000),

(29, 1015, 108, 5, 800),
(30, 1015, 103, 1, 2000);

