-- Create the Sales table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    department_id INT,
    sale_date DATE,
    sales_amount DECIMAL(10, 2)
);

-- Insert example data into the Sales table
INSERT INTO Sales (sale_id, department_id, sale_date, sales_amount) VALUES
(1, 1, '2023-01-01', 1000.00),
(2, 1, '2023-02-01', 1500.00),
(3, 1, '2023-03-01', 1200.00),
(4, 1, '2023-04-01', 1800.00),
(5, 2, '2023-01-01', 1600.00),
(6, 2, '2023-02-01', 1700.00),
(7, 2, '2023-03-01', 1300.00),
(8, 2, '2023-04-01', 1900.00);

-- Use FIRST_VALUE() and LAST_VALUE() to get the first and last sales amount within each department
SELECT
    sale_id,
    department_id,
    sale_date,
    sales_amount,
    FIRST_VALUE(sales_amount) OVER (PARTITION BY department_id ORDER BY sale_date) AS first_sale_amount,
    LAST_VALUE(sales_amount) OVER (PARTITION BY department_id ORDER BY sale_date 
                                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale_amount
FROM
    Sales;


-- | sale_id | department_id | sale_date  | sales_amount | first_sale_amount | last_sale_amount |
-- |---------|---------------|------------|--------------|-------------------|------------------|
-- | 1       | 1             | 2023-01-01 | 1000.00      | 1000.00           | 1800.00          |
-- | 2       | 1             | 2023-02-01 | 1500.00      | 1000.00           | 1800.00          |
-- | 3       | 1             | 2023-03-01 | 1200.00      | 1000.00           | 1800.00          |
-- | 4       | 1             | 2023-04-01 | 1800.00      | 1000.00           | 1800.00          |
-- | 5       | 2             | 2023-01-01 | 1600.00      | 1600.00           | 1900.00          |
-- | 6       | 2             | 2023-02-01 | 1700.00      | 1600.00           | 1900.00          |
-- | 7       | 2             | 2023-03-01 | 1300.00      | 1600.00           | 1900.00          |
-- | 8       | 2             | 2023-04-01 | 1900.00      | 1600.00           | 1900.00          |
