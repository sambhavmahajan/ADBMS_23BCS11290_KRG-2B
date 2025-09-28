-- ==================================================================
-- Variant A: Minimal table (follows user's "id, value" schema)
-- ==================================================================

-- Drop table if exists
DROP TABLE IF EXISTS transaction_data;

-- Create table
CREATE TABLE transaction_data (
    id    integer NOT NULL,
    value numeric(12,2) NOT NULL    -- sale amount for that row
);

-- Insert 1,000,000 rows for id=1
INSERT INTO transaction_data (id, value)
SELECT 1, round((random() * 100)::numeric, 2)
FROM generate_series(1,1000000);

-- Insert 1,000,000 rows for id=2
INSERT INTO transaction_data (id, value)
SELECT 2, round((random() * 100)::numeric, 2)
FROM generate_series(1,1000000);

-- Update planner statistics
VACUUM ANALYZE transaction_data;

-- ------------------------------------------------------------------
-- Normal View (recomputes on each query)
-- ------------------------------------------------------------------
DROP VIEW IF EXISTS sales_summary;

CREATE VIEW sales_summary AS
SELECT
    id,
    COUNT(*) AS total_quantity_sold,   -- assuming 1 item per row
    SUM(value) AS total_sales,
    COUNT(*) AS total_orders           -- one order per row in this minimal schema
FROM transaction_data
GROUP BY id;

-- ------------------------------------------------------------------
-- Materialized View (stores computed result)
-- ------------------------------------------------------------------
DROP MATERIALIZED VIEW IF EXISTS sales_summary_mat;

CREATE MATERIALIZED VIEW sales_summary_mat AS
SELECT
    id,
    COUNT(*) AS total_quantity_sold,
    SUM(value) AS total_sales,
    COUNT(*) AS total_orders
FROM transaction_data
GROUP BY id
WITH NO DATA;  -- create empty first, then refresh

-- Populate the materialized view
REFRESH MATERIALIZED VIEW sales_summary_mat;

-- Optional: index for faster lookups
CREATE UNIQUE INDEX IF NOT EXISTS sales_summary_mat_id_idx
    ON sales_summary_mat (id);



-- ==================================================================
-- Variant B: More realistic schema with quantity & price
-- ==================================================================

-- Drop table if exists
DROP TABLE IF EXISTS transaction_data_real;

-- Create table
CREATE TABLE transaction_data_real (
    id         integer NOT NULL,
    quantity   integer NOT NULL,
    price      numeric(12,2) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

-- Insert 1,000,000 rows for id=1
INSERT INTO transaction_data_real (id, quantity, price)
SELECT 1,
       (floor(random()*5)+1)::int AS quantity,
       round((1 + random()*199)::numeric, 2) AS price
FROM generate_series(1,1000000);

-- Insert 1,000,000 rows for id=2
INSERT INTO transaction_data_real (id, quantity, price)
SELECT 2,
       (floor(random()*5)+1)::int AS quantity,
       round((1 + random()*199)::numeric, 2) AS price
FROM generate_series(1,1000000);

-- Update planner statistics
VACUUM ANALYZE transaction_data_real;

-- ------------------------------------------------------------------
-- Normal View (recomputes on each query)
-- ------------------------------------------------------------------
DROP VIEW IF EXISTS sales_summary_real;

CREATE VIEW sales_summary_real AS
SELECT
    id,
    SUM(quantity) AS total_quantity_sold,
    SUM(price * quantity) AS total_sales,
    COUNT(*) AS total_orders
FROM transaction_data_real
GROUP BY id;

-- ------------------------------------------------------------------
-- Materialized View (stores computed result)
-- ------------------------------------------------------------------
DROP MATERIALIZED VIEW IF EXISTS sales_summary_real_mat;

CREATE MATERIALIZED VIEW sales_summary_real_mat AS
SELECT
    id,
    SUM(quantity) AS total_quantity_sold,
    SUM(price * quantity) AS total_sales,
    COUNT(*) AS total_orders
FROM transaction_data_real
GROUP BY id
WITH NO DATA;

-- Populate the materialized view
REFRESH MATERIALIZED VIEW sales_summary_real_mat;

-- Optional: index for faster lookups
CREATE UNIQUE INDEX IF NOT EXISTS sales_summary_real_mat_id_idx
    ON sales_summary_real_mat (id);
