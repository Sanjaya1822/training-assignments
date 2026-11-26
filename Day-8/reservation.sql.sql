
USE RetailDB;
-- TASK 1 --
START TRANSACTION;
 
-- Reduce stock
UPDATE Products
SET stock = stock - 2
WHERE product_id = 1
AND stock >= 2;

-- Insert order
INSERT INTO Orders VALUES
(103, 'Kumar', '2026-11-26', 100000);

-- Insert order items
INSERT INTO Order_Items VALUES
(5, 103, 1, 2, 50000);

COMMIT;

START TRANSACTION;

UPDATE Products
SET stock = stock - 100
WHERE product_id = 1
AND stock >= 100;

-- Check stock
SELECT stock
FROM Products
WHERE product_id = 1;
ROLLBACK;


-- TASK 2 List products whose stock is below the average stock of their category--
SELECT product_name, category, stock
FROM Products p
WHERE stock < (
    SELECT AVG(stock)
    FROM Products
    WHERE category = p.category
);

