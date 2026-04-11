

-- Create Schema
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'oltp')
BEGIN
    EXEC('CREATE SCHEMA oltp')
END
GO

-- -----------------------------------------------------
-- Table: oltp.customer
-- -----------------------------------------------------
IF OBJECT_ID('oltp.customer', 'U') IS NULL
CREATE TABLE oltp.customer
(
    id                  INT,
    company             NVARCHAR(255),
    last_name           NVARCHAR(100),
    first_name          NVARCHAR(100),
    email_address       NVARCHAR(255),
    job_title           NVARCHAR(255),
    business_phone      NVARCHAR(50),
    home_phone          NVARCHAR(50),
    mobile_phone        NVARCHAR(50),
    fax_number          NVARCHAR(50),
    address             NVARCHAR(500),
    city                NVARCHAR(100),
    state_province      NVARCHAR(100),
    zip_postal_code     NVARCHAR(20),
    country_region      NVARCHAR(100),
    web_page            NVARCHAR(500),
    notes               NVARCHAR(MAX),
    attachments         NVARCHAR(MAX)
);
GO

-- -----------------------------------------------------
-- Table: oltp.employees
-- -----------------------------------------------------
IF OBJECT_ID('oltp.employees', 'U') IS NULL
CREATE TABLE oltp.employees
(
    id                  INT,
    company             NVARCHAR(255),
    last_name           NVARCHAR(100),
    first_name          NVARCHAR(100),
    email_address       NVARCHAR(255),
    job_title           NVARCHAR(255),
    business_phone      NVARCHAR(50),
    home_phone          NVARCHAR(50),
    mobile_phone        NVARCHAR(50),
    fax_number          NVARCHAR(50),
    address             NVARCHAR(500),
    city                NVARCHAR(100),
    state_province      NVARCHAR(100),
    zip_postal_code     NVARCHAR(20),
    country_region      NVARCHAR(100),
    web_page            NVARCHAR(500),
    notes               NVARCHAR(MAX),
    attachments         NVARCHAR(MAX)
);
GO

-- -----------------------------------------------------
-- Table: oltp.privileges
-- -----------------------------------------------------
IF OBJECT_ID('oltp.privileges', 'U') IS NULL
CREATE TABLE oltp.privileges
(
    id                  INT,
    privilege_name      NVARCHAR(255)
);
GO

-- -----------------------------------------------------
-- Table: oltp.employee_privileges
-- -----------------------------------------------------
IF OBJECT_ID('oltp.employee_privileges', 'U') IS NULL
CREATE TABLE oltp.employee_privileges
(
    employee_id         INT,
    privilege_id        INT
);
GO

-- -----------------------------------------------------
-- Table: oltp.inventory_transaction_types
-- -----------------------------------------------------
IF OBJECT_ID('oltp.inventory_transaction_types', 'U') IS NULL
CREATE TABLE oltp.inventory_transaction_types
(
    id                  INT,
    type_name           NVARCHAR(255)
);
GO

-- -----------------------------------------------------
-- Table: oltp.shippers
-- -----------------------------------------------------
IF OBJECT_ID('oltp.shippers', 'U') IS NULL
CREATE TABLE oltp.shippers
(
    id                  INT,
    company             NVARCHAR(255),
    last_name           NVARCHAR(100),
    first_name          NVARCHAR(100),
    email_address       NVARCHAR(255),
    job_title           NVARCHAR(255),
    business_phone      NVARCHAR(50),
    home_phone          NVARCHAR(50),
    mobile_phone        NVARCHAR(50),
    fax_number          NVARCHAR(50),
    address             NVARCHAR(500),
    city                NVARCHAR(100),
    state_province      NVARCHAR(100),
    zip_postal_code     NVARCHAR(20),
    country_region      NVARCHAR(100),
    web_page            NVARCHAR(500),
    notes               NVARCHAR(MAX),
    attachments         NVARCHAR(MAX)
);
GO

-- -----------------------------------------------------
-- Table: oltp.orders_tax_status
-- -----------------------------------------------------
IF OBJECT_ID('oltp.orders_tax_status', 'U') IS NULL
CREATE TABLE oltp.orders_tax_status
(
    id                  INT,
    tax_status_name     NVARCHAR(255)
);
GO

-- -----------------------------------------------------
-- Table: oltp.orders_status
-- -----------------------------------------------------
IF OBJECT_ID('oltp.orders_status', 'U') IS NULL
CREATE TABLE oltp.orders_status
(
    id                  INT,
    status_name         NVARCHAR(255)
);
GO

-- -----------------------------------------------------
-- Table: oltp.orders
-- -----------------------------------------------------
IF OBJECT_ID('oltp.orders', 'U') IS NULL
CREATE TABLE oltp.orders
(
    id                      INT,
    employee_id             INT,
    customer_id             INT,
    order_date              DATETIME2,
    shipped_date            DATETIME2,
    shipper_id              INT,
    ship_name               NVARCHAR(255),
    ship_address            NVARCHAR(500),
    ship_city               NVARCHAR(100),
    ship_state_province     NVARCHAR(100),
    ship_zip_postal_code    NVARCHAR(20),
    ship_country_region     NVARCHAR(100),
    shipping_fee            FLOAT,
    taxes                   FLOAT,
    payment_type            NVARCHAR(100),
    paid_date               DATETIME2,
    notes                   NVARCHAR(MAX),
    tax_rate                FLOAT,
    tax_status_id           INT,
    status_id               INT
);
GO

-- -----------------------------------------------------
-- Table: oltp.products
-- -----------------------------------------------------
IF OBJECT_ID('oltp.products', 'U') IS NULL
CREATE TABLE oltp.products
(
    supplier_ids                NVARCHAR(255),
    id                          INT,
    product_code                NVARCHAR(50),
    product_name                NVARCHAR(255),
    description                 NVARCHAR(MAX),
    standard_cost               FLOAT,
    list_price                  FLOAT,
    reorder_level               INT,
    target_level                INT,
    quantity_per_unit           NVARCHAR(100),
    discontinued                INT,
    minimum_reorder_quantity    INT,
    category                    NVARCHAR(100),
    attachments                 NVARCHAR(MAX)
);
GO

-- -----------------------------------------------------
-- Table: oltp.purchase_order_status
-- -----------------------------------------------------
IF OBJECT_ID('oltp.purchase_order_status', 'U') IS NULL
CREATE TABLE oltp.purchase_order_status
(
    id                  INT,
    status              NVARCHAR(255)
);
GO

-- -----------------------------------------------------
-- Table: oltp.suppliers
-- -----------------------------------------------------
IF OBJECT_ID('oltp.suppliers', 'U') IS NULL
CREATE TABLE oltp.suppliers
(
    id                  INT,
    company             NVARCHAR(255),
    last_name           NVARCHAR(100),
    first_name          NVARCHAR(100),
    email_address       NVARCHAR(255),
    job_title           NVARCHAR(255),
    business_phone      NVARCHAR(50),
    home_phone          NVARCHAR(50),
    mobile_phone        NVARCHAR(50),
    fax_number          NVARCHAR(50),
    address             NVARCHAR(500),
    city                NVARCHAR(100),
    state_province      NVARCHAR(100),
    zip_postal_code     NVARCHAR(20),
    country_region      NVARCHAR(100),
    web_page            NVARCHAR(500),
    notes               NVARCHAR(MAX),
    attachments         NVARCHAR(MAX)
);
GO

-- -----------------------------------------------------
-- Table: oltp.purchase_orders
-- -----------------------------------------------------
IF OBJECT_ID('oltp.purchase_orders', 'U') IS NULL
CREATE TABLE oltp.purchase_orders
(
    id                  INT,
    supplier_id         INT,
    created_by          INT,
    submitted_date      DATETIME2,
    creation_date       DATETIME2,
    status_id           INT,
    expected_date       DATETIME2,
    shipping_fee        FLOAT,
    taxes               FLOAT,
    payment_date        DATETIME2,
    payment_amount      FLOAT,
    payment_method      NVARCHAR(100),
    notes               NVARCHAR(MAX),
    approved_by         INT,
    approved_date       DATETIME2,
    submitted_by        INT
);
GO

-- -----------------------------------------------------
-- Table: oltp.inventory_transactions
-- -----------------------------------------------------
IF OBJECT_ID('oltp.inventory_transactions', 'U') IS NULL
CREATE TABLE oltp.inventory_transactions
(
    id                          INT,
    transaction_type            INT,
    transaction_created_date    DATETIME2,
    transaction_modified_date   DATETIME2,
    product_id                  INT,
    quantity                    INT,
    purchase_order_id           INT,
    customer_order_id           INT,
    comments                    NVARCHAR(MAX)
);
GO

-- -----------------------------------------------------
-- Table: oltp.invoices
-- -----------------------------------------------------
IF OBJECT_ID('oltp.invoices', 'U') IS NULL
CREATE TABLE oltp.invoices
(
    id                  INT,
    order_id            INT,
    invoice_date        DATETIME2,
    due_date            DATETIME2,
    tax                 FLOAT,
    shipping            FLOAT,
    amount_due          FLOAT
);
GO

-- -----------------------------------------------------
-- Table: oltp.order_details_status
-- -----------------------------------------------------
IF OBJECT_ID('oltp.order_details_status', 'U') IS NULL
CREATE TABLE oltp.order_details_status
(
    id                  INT,
    status              NVARCHAR(255)
);
GO

-- -----------------------------------------------------
-- Table: oltp.order_details
-- -----------------------------------------------------
IF OBJECT_ID('oltp.order_details', 'U') IS NULL
CREATE TABLE oltp.order_details
(
    id                  INT,
    order_id            INT,
    product_id          INT,
    quantity            FLOAT,
    unit_price          FLOAT,
    discount            FLOAT,
    status_id           INT,
    date_allocated      DATETIME2,
    purchase_order_id   INT,
    inventory_id        INT
);
GO

-- -----------------------------------------------------
-- Table: oltp.purchase_order_details
-- -----------------------------------------------------
IF OBJECT_ID('oltp.purchase_order_details', 'U') IS NULL
CREATE TABLE oltp.purchase_order_details
(
    id                      INT,
    purchase_order_id       INT,
    product_id              INT,
    quantity                FLOAT,
    unit_cost               FLOAT,
    date_received           DATETIME2,
    posted_to_inventory     INT,
    inventory_id            INT
);
GO

-- -----------------------------------------------------
-- Table: oltp.sales_reports
-- -----------------------------------------------------
IF OBJECT_ID('oltp.sales_reports', 'U') IS NULL
CREATE TABLE oltp.sales_reports
(
    group_by            NVARCHAR(255),
    display             NVARCHAR(255),
    title               NVARCHAR(255),
    filter_row_source   NVARCHAR(MAX),
    [default]           NVARCHAR(255)
);
GO

-- -----------------------------------------------------
-- Table: oltp.strings
-- -----------------------------------------------------
IF OBJECT_ID('oltp.strings', 'U') IS NULL
CREATE TABLE oltp.strings
(
    string_id           INT,
    string_data         NVARCHAR(MAX)
);
GO

