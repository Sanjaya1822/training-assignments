-- Sample data for Bank Branch Accounts
USE bank_db;

INSERT INTO managers (manager_name) VALUES
('Ravi'), ('Priya');

INSERT INTO branches (branch_name, branch_city) VALUES
('Main Branch', 'Coimbatore'),
('City Branch', 'Chennai');

INSERT INTO customers (customer_name, customer_address, manager_id) VALUES
('Arun', 'Gandhi Road, Coimbatore', 1),
('Anitha', 'Anna Nagar, Chennai', 2),
('Kumar', 'RS Puram, Coimbatore', 1);

INSERT INTO accounts
(account_number, customer_id, branch_id, account_type, balance, opened_date) VALUES
('A1001', 1, 1, 'Savings', 25000.00, '2026-07-10'),
('A1002', 1, 1, 'Fixed', 50000.00, '2026-08-15'),
('A1003', 2, 2, 'Current', 15000.00, '2026-09-05'),
('A1004', 3, 1, 'Savings', 8000.00, '2026-10-12'),
('A1005', 2, 2, 'Savings', 5000.00, '2026-06-20');