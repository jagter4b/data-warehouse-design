-- =====================================================
-- Northwind OLTP - SQL Server (T-SQL) Create Tables
-- Converted from BigQuery dialect
-- Relationships sourced from ERD schema
-- =====================================================

-- Create schema if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'oltp')
BEGIN
    EXEC('CREATE SCHEMA oltp')
END
GO


-- =====================================================
-- TABLE CREATION
-- (ordered to respect FK dependencies)
-- =====================================================

-- -----------------------------------------------------
-- Lookup / reference tables (no FK dependencies)
-- -----------------------------------------------------

IF OBJECT_ID('oltp.customers', 'U') IS NULL
CREATE TABLE oltp.customers
(
    id                INT             NOT NULL,
    company           VARCHAR(50),
    last_name         VARCHAR(50),
    first_name        VARCHAR(50),
    email_address     VARCHAR(50),
    job_title         VARCHAR(50),
    business_phone    VARCHAR(25),
    home_phone        VARCHAR(25),
    mobile_phone      VARCHAR(25),
    fax_number        VARCHAR(25),
    address           VARCHAR(MAX),
    city              VARCHAR(50),
    state_province    VARCHAR(50),
    zip_postal_code   VARCHAR(15),
    country_region    VARCHAR(50),
    web_page          VARCHAR(MAX),
    notes             VARCHAR(MAX),
    attachments       VARCHAR(MAX)
)
GO

IF OBJECT_ID('oltp.employees', 'U') IS NULL
CREATE TABLE oltp.employees
(
    id                INT             NOT NULL,
    company           VARCHAR(50),
    last_name         VARCHAR(50),
    first_name        VARCHAR(50),
    email_address     VARCHAR(50),
    job_title         VARCHAR(50),
    business_phone    VARCHAR(25),
    home_phone        VARCHAR(25),
    mobile_phone      VARCHAR(25),
    fax_number        VARCHAR(25),
    address           VARCHAR(MAX),
    city              VARCHAR(50),
    state_province    VARCHAR(50),
    zip_postal_code   VARCHAR(15),
    country_region    VARCHAR(50),
    web_page          VARCHAR(MAX),
    notes             VARCHAR(MAX),
    attachments       VARCHAR(MAX)
)
GO

IF OBJECT_ID('oltp.privileges', 'U') IS NULL
CREATE TABLE oltp.privileges
(
    id              INT         NOT NULL,
    privilege_name  VARCHAR(50)
)
GO

IF OBJECT_ID('oltp.shippers', 'U') IS NULL
CREATE TABLE oltp.shippers
(
    id                INT             NOT NULL,
    company           VARCHAR(50),
    last_name         VARCHAR(50),
    first_name        VARCHAR(50),
    email_address     VARCHAR(50),
    job_title         VARCHAR(50),
    business_phone    VARCHAR(25),
    home_phone        VARCHAR(25),
    mobile_phone      VARCHAR(25),
    fax_number        VARCHAR(25),
    address           VARCHAR(MAX),
    city              VARCHAR(50),
    state_province    VARCHAR(50),
    zip_postal_code   VARCHAR(15),
    country_region    VARCHAR(50),
    web_page          VARCHAR(MAX),
    notes             VARCHAR(MAX),
    attachments       VARCHAR(MAX)
)
GO

IF OBJECT_ID('oltp.suppliers', 'U') IS NULL
CREATE TABLE oltp.suppliers
(
    id                INT             NOT NULL,
    company           VARCHAR(50),
    last_name         VARCHAR(50),
    first_name        VARCHAR(50),
    email_address     VARCHAR(50),
    job_title         VARCHAR(50),
    business_phone    VARCHAR(25),
    home_phone        VARCHAR(25),
    mobile_phone      VARCHAR(25),
    fax_number        VARCHAR(25),
    address           VARCHAR(MAX),
    city              VARCHAR(50),
    state_province    VARCHAR(50),
    zip_postal_code   VARCHAR(15),
    country_region    VARCHAR(50),
    web_page          VARCHAR(MAX),
    notes             VARCHAR(MAX),
    attachments       VARCHAR(MAX)
)
GO

IF OBJECT_ID('oltp.orders_tax_status', 'U') IS NULL
CREATE TABLE oltp.orders_tax_status
(
    id              TINYINT     NOT NULL,
    tax_status_name VARCHAR(50)
)
GO

IF OBJECT_ID('oltp.orders_status', 'U') IS NULL
CREATE TABLE oltp.orders_status
(
    id          TINYINT     NOT NULL,
    status_name VARCHAR(50)
)
GO

IF OBJECT_ID('oltp.order_details_status', 'U') IS NULL
CREATE TABLE oltp.order_details_status
(
    id          INT         NOT NULL,
    -- ERD uses 'status_name'; original BQ script used 'status' — aligned to ERD
    status_name VARCHAR(50)
)
GO

IF OBJECT_ID('oltp.purchase_order_status', 'U') IS NULL
CREATE TABLE oltp.purchase_order_status
(
    id     INT         NOT NULL,
    status VARCHAR(50)
)
GO

IF OBJECT_ID('oltp.inventory_transaction_types', 'U') IS NULL
CREATE TABLE oltp.inventory_transaction_types
(
    id        TINYINT     NOT NULL,
    type_name VARCHAR(50)
)
GO

IF OBJECT_ID('oltp.products', 'U') IS NULL
CREATE TABLE oltp.products
(
    id                       INT             NOT NULL,
    -- supplier_ids kept for source compatibility; consider a junction table in future
    supplier_ids             VARCHAR(MAX),
    product_code             VARCHAR(25),
    product_name             VARCHAR(50),
    description              VARCHAR(MAX),
    standard_cost            DECIMAL(18,2),
    list_price               DECIMAL(18,2),
    reorder_level            INT,
    target_level             INT,
    quantity_per_unit        VARCHAR(50),
    discontinued             BIT             NOT NULL DEFAULT 0,   -- boolean flag → BIT
    minimum_reorder_quantity INT,
    category                 VARCHAR(50),
    attachments              VARCHAR(MAX)
)
GO


-- -----------------------------------------------------
-- employee_privileges  (depends on employees, privileges)
-- -----------------------------------------------------

IF OBJECT_ID('oltp.employee_privileges', 'U') IS NULL
CREATE TABLE oltp.employee_privileges
(
    employee_id  INT  NOT NULL,
    privilege_id INT  NOT NULL
)
GO


-- -----------------------------------------------------
-- orders  (depends on employees, customers, shippers,
--           orders_tax_status, orders_status)
-- -----------------------------------------------------

IF OBJECT_ID('oltp.orders', 'U') IS NULL
CREATE TABLE oltp.orders
(
    id                   INT         NOT NULL,
    employee_id          INT,                        -- FK → employees
    customer_id          INT,                        -- FK → customers
    order_date           DATETIME,
    shipped_date         DATETIME,
    shipper_id           INT,                        -- FK → shippers
    ship_name            VARCHAR(50),
    ship_address         VARCHAR(MAX),
    ship_city            VARCHAR(50),
    ship_state_province  VARCHAR(50),
    ship_zip_postal_code VARCHAR(15),
    ship_country_region  VARCHAR(50),
    shipping_fee         DECIMAL(18,2),
    taxes                DECIMAL(18,2),
    payment_type         VARCHAR(50),
    paid_date            DATETIME,
    notes                VARCHAR(MAX),
    tax_rate             FLOAT,
    tax_status_id        TINYINT,                    -- FK → orders_tax_status
    status_id            TINYINT                     -- FK → orders_status
)
GO


-- -----------------------------------------------------
-- purchase_orders  (depends on suppliers, employees,
--                   purchase_order_status)
-- -----------------------------------------------------

IF OBJECT_ID('oltp.purchase_orders', 'U') IS NULL
CREATE TABLE oltp.purchase_orders
(
    id             INT         NOT NULL,
    supplier_id    INT,                              -- FK → suppliers
    created_by     INT,                              -- FK → employees
    submitted_date DATETIME,
    creation_date  DATETIME,
    status_id      INT,                              -- FK → purchase_order_status
    expected_date  DATETIME,
    shipping_fee   DECIMAL(18,2),
    taxes          DECIMAL(18,2),
    payment_date   DATETIME,
    payment_amount DECIMAL(18,2),
    payment_method VARCHAR(50),
    notes          VARCHAR(MAX),
    approved_by    INT,                              -- FK → employees
    approved_date  DATETIME,
    submitted_by   INT                               -- FK → employees
)
GO




IF OBJECT_ID('oltp.inventory_transactions', 'U') IS NULL
CREATE TABLE oltp.inventory_transactions
(
    id                        INT         NOT NULL,
    transaction_type          TINYINT,               -- FK → inventory_transaction_types
    transaction_created_date  DATETIME,
    transaction_modified_date DATETIME,
    product_id                INT,                   -- FK → products
    quantity                  INT,
    purchase_order_id         INT,                   -- FK → purchase_orders
    customer_order_id         INT,                   -- FK → orders
    comments                  VARCHAR(255)
)
GO


-- -----------------------------------------------------
-- invoices  (depends on orders)
-- -----------------------------------------------------

IF OBJECT_ID('oltp.invoices', 'U') IS NULL
CREATE TABLE oltp.invoices
(
    id           INT         NOT NULL,
    order_id     INT,                                -- FK → orders
    invoice_date DATETIME,
    due_date     DATETIME,
    tax          DECIMAL(18,2),
    shipping     DECIMAL(18,2),
    amount_due   DECIMAL(18,2)
)
GO


-- -----------------------------------------------------
-- order_details  (depends on orders, products,
--                 order_details_status)
-- -----------------------------------------------------

IF OBJECT_ID('oltp.order_details', 'U') IS NULL
CREATE TABLE oltp.order_details
(
    id                INT         NOT NULL,
    order_id          INT,                           -- FK → orders
    product_id        INT,                           -- FK → products
    quantity          DECIMAL(18,2),
    unit_price        DECIMAL(18,2),
    discount          FLOAT,
    status_id         INT,                           -- FK → order_details_status
    date_allocated    DATETIME,
    purchase_order_id INT,                           -- informational, no FK enforced (ERD)
    inventory_id      INT                            -- FK → inventory_transactions
)
GO


-- -----------------------------------------------------
-- purchase_order_details  (depends on purchase_orders,
--                           products, inventory_transactions)
-- -----------------------------------------------------

IF OBJECT_ID('oltp.purchase_order_details', 'U') IS NULL
CREATE TABLE oltp.purchase_order_details
(
    id                  INT         NOT NULL,
    purchase_order_id   INT,                         -- FK → purchase_orders
    product_id          INT,                         -- FK → products
    quantity            DECIMAL(18,2),
    unit_cost           DECIMAL(18,2),
    date_received       DATETIME,
    posted_to_inventory BIT         NOT NULL DEFAULT 0,  -- boolean flag → BIT
    inventory_id        INT                          -- FK → inventory_transactions (NOCHECK, see below)
)
GO


-- -----------------------------------------------------
-- sales_reports  (no FKs per ERD)
-- -----------------------------------------------------

IF OBJECT_ID('oltp.sales_reports', 'U') IS NULL
CREATE TABLE oltp.sales_reports
(
    group_by          VARCHAR(255),
    display           VARCHAR(255),
    title             VARCHAR(255),
    filter_row_source VARCHAR(255),
    [default]         VARCHAR(255)
)
GO


-- -----------------------------------------------------
-- strings  (no FKs per ERD)
-- -----------------------------------------------------

IF OBJECT_ID('oltp.strings', 'U') IS NULL
CREATE TABLE oltp.strings
(
    string_id   INT         NOT NULL,
    string_data VARCHAR(MAX)
)
GO


-- =====================================================
-- PRIMARY KEY CONSTRAINTS
-- =====================================================

ALTER TABLE oltp.customers
    ADD CONSTRAINT PK_customers PRIMARY KEY (id)
GO

ALTER TABLE oltp.employees
    ADD CONSTRAINT PK_employees PRIMARY KEY (id)
GO

ALTER TABLE oltp.privileges
    ADD CONSTRAINT PK_privileges PRIMARY KEY (id)
GO

ALTER TABLE oltp.employee_privileges
    ADD CONSTRAINT PK_employee_privileges PRIMARY KEY (employee_id, privilege_id)
GO

ALTER TABLE oltp.shippers
    ADD CONSTRAINT PK_shippers PRIMARY KEY (id)
GO

ALTER TABLE oltp.suppliers
    ADD CONSTRAINT PK_suppliers PRIMARY KEY (id)
GO

ALTER TABLE oltp.orders_tax_status
    ADD CONSTRAINT PK_orders_tax_status PRIMARY KEY (id)
GO

ALTER TABLE oltp.orders_status
    ADD CONSTRAINT PK_orders_status PRIMARY KEY (id)
GO

ALTER TABLE oltp.order_details_status
    ADD CONSTRAINT PK_order_details_status PRIMARY KEY (id)
GO

ALTER TABLE oltp.purchase_order_status
    ADD CONSTRAINT PK_purchase_order_status PRIMARY KEY (id)
GO

ALTER TABLE oltp.inventory_transaction_types
    ADD CONSTRAINT PK_inventory_transaction_types PRIMARY KEY (id)
GO

ALTER TABLE oltp.products
    ADD CONSTRAINT PK_products PRIMARY KEY (id)
GO

ALTER TABLE oltp.orders
    ADD CONSTRAINT PK_orders PRIMARY KEY (id)
GO

ALTER TABLE oltp.purchase_orders
    ADD CONSTRAINT PK_purchase_orders PRIMARY KEY (id)
GO

ALTER TABLE oltp.inventory_transactions
    ADD CONSTRAINT PK_inventory_transactions PRIMARY KEY (id)
GO

ALTER TABLE oltp.invoices
    ADD CONSTRAINT PK_invoices PRIMARY KEY (id)
GO

ALTER TABLE oltp.order_details
    ADD CONSTRAINT PK_order_details PRIMARY KEY (id)
GO

ALTER TABLE oltp.purchase_order_details
    ADD CONSTRAINT PK_purchase_order_details PRIMARY KEY (id)
GO


ALTER TABLE oltp.strings
    ADD CONSTRAINT PK_strings PRIMARY KEY (string_id)
GO


-- =====================================================
-- FOREIGN KEY CONSTRAINTS
-- (grouped by child table, ordered by dependency depth)
-- =====================================================

-- --------------------------
-- employee_privileges
-- --------------------------

ALTER TABLE oltp.employee_privileges
    ADD CONSTRAINT FK_employee_privileges_employees
    FOREIGN KEY (employee_id) REFERENCES oltp.employees (id)
GO

ALTER TABLE oltp.employee_privileges
    ADD CONSTRAINT FK_employee_privileges_privileges
    FOREIGN KEY (privilege_id) REFERENCES oltp.privileges (id)
GO


-- --------------------------
-- orders
-- --------------------------

ALTER TABLE oltp.orders
    ADD CONSTRAINT FK_orders_employees
    FOREIGN KEY (employee_id) REFERENCES oltp.employees (id)
GO

ALTER TABLE oltp.orders
    ADD CONSTRAINT FK_orders_customers
    FOREIGN KEY (customer_id) REFERENCES oltp.customers (id)
GO

ALTER TABLE oltp.orders
    ADD CONSTRAINT FK_orders_shippers
    FOREIGN KEY (shipper_id) REFERENCES oltp.shippers (id)
GO

ALTER TABLE oltp.orders
    ADD CONSTRAINT FK_orders_orders_tax_status
    FOREIGN KEY (tax_status_id) REFERENCES oltp.orders_tax_status (id)
GO

ALTER TABLE oltp.orders
    ADD CONSTRAINT FK_orders_orders_status
    FOREIGN KEY (status_id) REFERENCES oltp.orders_status (id)
GO


-- --------------------------
-- purchase_orders
-- --------------------------

ALTER TABLE oltp.purchase_orders
    ADD CONSTRAINT FK_purchase_orders_suppliers
    FOREIGN KEY (supplier_id) REFERENCES oltp.suppliers (id)
GO

ALTER TABLE oltp.purchase_orders
    ADD CONSTRAINT FK_purchase_orders_employees_created_by
    FOREIGN KEY (created_by) REFERENCES oltp.employees (id)
GO

ALTER TABLE oltp.purchase_orders
    ADD CONSTRAINT FK_purchase_orders_employees_approved_by
    FOREIGN KEY (approved_by) REFERENCES oltp.employees (id)
GO

ALTER TABLE oltp.purchase_orders
    ADD CONSTRAINT FK_purchase_orders_employees_submitted_by
    FOREIGN KEY (submitted_by) REFERENCES oltp.employees (id)
GO

ALTER TABLE oltp.purchase_orders
    ADD CONSTRAINT FK_purchase_orders_purchase_order_status
    FOREIGN KEY (status_id) REFERENCES oltp.purchase_order_status (id)
GO


-- --------------------------
-- inventory_transactions
-- --------------------------

ALTER TABLE oltp.inventory_transactions
    ADD CONSTRAINT FK_inventory_transactions_inventory_transaction_types
    FOREIGN KEY (transaction_type) REFERENCES oltp.inventory_transaction_types (id)
GO

ALTER TABLE oltp.inventory_transactions
    ADD CONSTRAINT FK_inventory_transactions_products
    FOREIGN KEY (product_id) REFERENCES oltp.products (id)
GO

ALTER TABLE oltp.inventory_transactions
    ADD CONSTRAINT FK_inventory_transactions_purchase_orders
    FOREIGN KEY (purchase_order_id) REFERENCES oltp.purchase_orders (id)
GO

ALTER TABLE oltp.inventory_transactions
    ADD CONSTRAINT FK_inventory_transactions_orders
    FOREIGN KEY (customer_order_id) REFERENCES oltp.orders (id)
GO


-- --------------------------
-- invoices
-- --------------------------

ALTER TABLE oltp.invoices
    ADD CONSTRAINT FK_invoices_orders
    FOREIGN KEY (order_id) REFERENCES oltp.orders (id)
GO


-- --------------------------
-- order_details
-- --------------------------

ALTER TABLE oltp.order_details
    ADD CONSTRAINT FK_order_details_orders
    FOREIGN KEY (order_id) REFERENCES oltp.orders (id)
GO

ALTER TABLE oltp.order_details
    ADD CONSTRAINT FK_order_details_products
    FOREIGN KEY (product_id) REFERENCES oltp.products (id)
GO

ALTER TABLE oltp.order_details
    ADD CONSTRAINT FK_order_details_order_details_status
    FOREIGN KEY (status_id) REFERENCES oltp.order_details_status (id)
GO

ALTER TABLE oltp.order_details
    ADD CONSTRAINT FK_order_details_inventory_transactions
    FOREIGN KEY (inventory_id) REFERENCES oltp.inventory_transactions (id)
GO


-- --------------------------
-- purchase_order_details
-- --------------------------

ALTER TABLE oltp.purchase_order_details
    ADD CONSTRAINT FK_purchase_order_details_purchase_orders
    FOREIGN KEY (purchase_order_id) REFERENCES oltp.purchase_orders (id)
GO

ALTER TABLE oltp.purchase_order_details
    ADD CONSTRAINT FK_purchase_order_details_products
    FOREIGN KEY (product_id) REFERENCES oltp.products (id)
GO


ALTER TABLE oltp.purchase_order_details
    WITH NOCHECK
    ADD CONSTRAINT FK_purchase_order_details_inventory_transactions
    FOREIGN KEY (inventory_id) REFERENCES oltp.inventory_transactions (id)
GO

