
-- SET 1: RETAIL PRICE CHANGE AUDIT

CREATE DATABASE  Retail;
USE Retail;

-- 1. Product table

CREATE TABLE product_price (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2)
) ENGINE = InnoDB;

-- 2. Audit table

CREATE TABLE price_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    changed_by VARCHAR(100),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

-- 3. Sample data

INSERT INTO product_price VALUES
(1, 'Laptop', 40000, 45000),
(2, 'Mobile', 10000, 12000),
(3, 'Headphones', 1500, 2000),
(4, 'Keyboard', 500, 800);

-- 4. BEFORE UPDATE trigger

DELIMITER //

CREATE TRIGGER check_price_before_update
BEFORE UPDATE ON product_price
FOR EACH ROW
BEGIN
    IF NEW.selling_price < NEW.cost_price THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Price rejected: Selling price cannot be below cost price!';
    END IF;
END //

-- 5. AFTER UPDATE trigger

CREATE TRIGGER price_update_audit
AFTER UPDATE ON product_price
FOR EACH ROW
BEGIN
    IF OLD.selling_price <> NEW.selling_price THEN
        INSERT INTO price_audit
        (product_id, old_price, new_price,
         changed_by, changed_at)
        VALUES
        (OLD.product_id,
         OLD.selling_price,
         NEW.selling_price,
         USER(),
         NOW());
    END IF;
END //

DELIMITER ;
