
USE Retail;

-- TEST 1: Display original product details
SELECT * FROM product_price;

-- TEST 2: Single-row valid update
UPDATE product_price
SET selling_price = 48000
WHERE product_id = 1;

-- Verify updated price
SELECT * FROM product_price
WHERE product_id = 1;

-- TEST 3: Check audit history
SELECT * FROM price_audit;

-- TEST 4: Multi-row valid update
UPDATE product_price
SET selling_price = selling_price + 500
WHERE product_id IN (2, 3, 4);

-- Verify multiple audit entries
SELECT * FROM price_audit;

-- TEST 5: Invalid single-row update
-- Expected: Error 1644 (SQLSTATE 45000)
UPDATE product_price
SET selling_price = 30000
WHERE product_id = 1;

-- TEST 6: Multi-row update with one invalid value
-- Product 2 and 3 have valid new prices.
-- Product 1 has an invalid new price.
-- Expected: Entire statement rolled back.
UPDATE product_price
SET selling_price =
    CASE
        WHEN product_id = 1 THEN 1000
        WHEN product_id = 2 THEN 14000
        WHEN product_id = 3 THEN 3000
    END
WHERE product_id IN (1, 2, 3);

-- TEST 7: Verify final product prices
SELECT * FROM product_price;

-- TEST 8: Verify audit records
SELECT * FROM price_audit
ORDER BY audit_id;

-- TEST 9: List all triggers
SELECT
    TRIGGER_NAME,
    EVENT_MANIPULATION,
    EVENT_OBJECT_TABLE,
    ACTION_TIMING
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'RetailDB';
