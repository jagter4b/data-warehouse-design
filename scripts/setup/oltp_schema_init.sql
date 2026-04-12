CREATE TABLE oltp.orders_status (
    id          BIGINT          NOT NULL,
    status_name NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_orders_status PRIMARY KEY (id)
);

CREATE TABLE oltp.orders_tax_status (
    id              BIGINT          NOT NULL,
    tax_status_name NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_orders_tax_status PRIMARY KEY (id)
);

CREATE TABLE oltp.purchase_order_status (
    id      BIGINT          NOT NULL,
    status  NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_purchase_order_status PRIMARY KEY (id)
);

CREATE TABLE oltp.order_details_status (
    id      BIGINT          NOT NULL,
    status  NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_order_details_status PRIMARY KEY (id)
);

CREATE TABLE oltp.inventory_transaction_types (
    id        BIGINT          NOT NULL,
    type_name NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_inventory_transaction_types PRIMARY KEY (id)
);

CREATE TABLE oltp.privileges (
    id             BIGINT          NOT NULL,
    privilege_name NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_privileges PRIMARY KEY (id)
);

CREATE TABLE oltp.customer (
    id                BIGINT          NOT NULL,
    company           NVARCHAR(MAX)   NULL,
    last_name         NVARCHAR(MAX)   NULL,
    first_name        NVARCHAR(MAX)   NULL,
    email_address     NVARCHAR(MAX)   NULL,
    job_title         NVARCHAR(MAX)   NULL,
    business_phone    NVARCHAR(MAX)   NULL,
    home_phone        NVARCHAR(MAX)   NULL,
    mobile_phone      NVARCHAR(MAX)   NULL,
    fax_number        NVARCHAR(MAX)   NULL,
    address           NVARCHAR(MAX)   NULL,
    city              NVARCHAR(MAX)   NULL,
    state_province    NVARCHAR(MAX)   NULL,
    zip_postal_code   NVARCHAR(MAX)   NULL,
    country_region    NVARCHAR(MAX)   NULL,
    web_page          NVARCHAR(MAX)   NULL,
    notes             NVARCHAR(MAX)   NULL,
    attachments       NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_customer PRIMARY KEY (id)
);

CREATE TABLE oltp.employees (
    id                BIGINT          NOT NULL,
    company           NVARCHAR(MAX)   NULL,
    last_name         NVARCHAR(MAX)   NULL,
    first_name        NVARCHAR(MAX)   NULL,
    email_address     NVARCHAR(MAX)   NULL,
    job_title         NVARCHAR(MAX)   NULL,
    business_phone    NVARCHAR(MAX)   NULL,
    home_phone        NVARCHAR(MAX)   NULL,
    mobile_phone      NVARCHAR(MAX)   NULL,
    fax_number        NVARCHAR(MAX)   NULL,
    address           NVARCHAR(MAX)   NULL,
    city              NVARCHAR(MAX)   NULL,
    state_province    NVARCHAR(MAX)   NULL,
    zip_postal_code   NVARCHAR(MAX)   NULL,
    country_region    NVARCHAR(MAX)   NULL,
    web_page          NVARCHAR(MAX)   NULL,
    notes             NVARCHAR(MAX)   NULL,
    attachments       NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_employees PRIMARY KEY (id)
);

CREATE TABLE oltp.shippers (
    id                BIGINT          NOT NULL,
    company           NVARCHAR(MAX)   NULL,
    last_name         NVARCHAR(MAX)   NULL,
    first_name        NVARCHAR(MAX)   NULL,
    email_address     NVARCHAR(MAX)   NULL,
    job_title         NVARCHAR(MAX)   NULL,
    business_phone    NVARCHAR(MAX)   NULL,
    home_phone        NVARCHAR(MAX)   NULL,
    mobile_phone      NVARCHAR(MAX)   NULL,
    fax_number        NVARCHAR(MAX)   NULL,
    address           NVARCHAR(MAX)   NULL,
    city              NVARCHAR(MAX)   NULL,
    state_province    NVARCHAR(MAX)   NULL,
    zip_postal_code   NVARCHAR(MAX)   NULL,
    country_region    NVARCHAR(MAX)   NULL,
    web_page          NVARCHAR(MAX)   NULL,
    notes             NVARCHAR(MAX)   NULL,
    attachments       NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_shippers PRIMARY KEY (id)
);

CREATE TABLE oltp.suppliers (
    id                BIGINT          NOT NULL,
    company           NVARCHAR(MAX)   NULL,
    last_name         NVARCHAR(MAX)   NULL,
    first_name        NVARCHAR(MAX)   NULL,
    email_address     NVARCHAR(MAX)   NULL,
    job_title         NVARCHAR(MAX)   NULL,
    business_phone    NVARCHAR(MAX)   NULL,
    home_phone        NVARCHAR(MAX)   NULL,
    mobile_phone      NVARCHAR(MAX)   NULL,
    fax_number        NVARCHAR(MAX)   NULL,
    address           NVARCHAR(MAX)   NULL,
    city              NVARCHAR(MAX)   NULL,
    state_province    NVARCHAR(MAX)   NULL,
    zip_postal_code   NVARCHAR(MAX)   NULL,
    country_region    NVARCHAR(MAX)   NULL,
    web_page          NVARCHAR(MAX)   NULL,
    notes             NVARCHAR(MAX)   NULL,
    attachments       NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_suppliers PRIMARY KEY (id)
);

CREATE TABLE oltp.products (
    supplier_ids              NVARCHAR(MAX)   NULL,
    id                        BIGINT          NOT NULL,
    product_code              NVARCHAR(MAX)   NULL,
    product_name              NVARCHAR(MAX)   NULL,
    description               NVARCHAR(MAX)   NULL,
    standard_cost             FLOAT           NULL,
    list_price                FLOAT           NULL,
    reorder_level             BIGINT          NULL,
    target_level              BIGINT          NULL,
    quantity_per_unit         NVARCHAR(MAX)   NULL,
    discontinued              BIGINT          NULL,
    minimum_reorder_quantity  BIGINT          NULL,
    category                  NVARCHAR(MAX)   NULL,
    attachments               NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_products PRIMARY KEY (id)
);

CREATE TABLE oltp.orders (
    id                    BIGINT          NOT NULL,
    employee_id           BIGINT          NULL,
    customer_id           BIGINT          NULL,
    order_date            DATETIME2(7)    NULL,
    shipped_date          DATETIME2(7)    NULL,
    shipper_id            BIGINT          NULL,
    ship_name             NVARCHAR(MAX)   NULL,
    ship_address          NVARCHAR(MAX)   NULL,
    ship_city             NVARCHAR(MAX)   NULL,
    ship_state_province   NVARCHAR(MAX)   NULL,
    ship_zip_postal_code  NVARCHAR(MAX)   NULL,
    ship_country_region   NVARCHAR(MAX)   NULL,
    shipping_fee          FLOAT           NULL,
    taxes                 FLOAT           NULL,
    payment_type          NVARCHAR(MAX)   NULL,
    paid_date             DATETIME2(7)    NULL,
    notes                 NVARCHAR(MAX)   NULL,
    tax_rate              FLOAT           NULL,
    tax_status_id         BIGINT          NULL,
    status_id             BIGINT          NULL,
    CONSTRAINT PK_orders            PRIMARY KEY (id),
    CONSTRAINT FK_orders_customer   FOREIGN KEY (customer_id)   REFERENCES oltp.customer (id),
    CONSTRAINT FK_orders_employee   FOREIGN KEY (employee_id)   REFERENCES oltp.employees (id),
    CONSTRAINT FK_orders_shipper    FOREIGN KEY (shipper_id)    REFERENCES oltp.shippers (id),
    CONSTRAINT FK_orders_tax_status FOREIGN KEY (tax_status_id) REFERENCES oltp.orders_tax_status (id),
    CONSTRAINT FK_orders_status     FOREIGN KEY (status_id)     REFERENCES oltp.orders_status (id)
);

CREATE TABLE oltp.purchase_orders (
    id              BIGINT          NOT NULL,
    supplier_id     BIGINT          NULL,
    created_by      BIGINT          NULL,
    submitted_date  DATETIME2(7)    NULL,
    creation_date   DATETIME2(7)    NULL,
    status_id       BIGINT          NULL,
    expected_date   DATETIME2(7)    NULL,
    shipping_fee    FLOAT           NULL,
    taxes           FLOAT           NULL,
    payment_date    DATETIME2(7)    NULL,
    payment_amount  FLOAT           NULL,
    payment_method  NVARCHAR(MAX)   NULL,
    notes           NVARCHAR(MAX)   NULL,
    approved_by     BIGINT          NULL,
    approved_date   DATETIME2(7)    NULL,
    submitted_by    BIGINT          NULL,
    CONSTRAINT PK_purchase_orders            PRIMARY KEY (id),
    CONSTRAINT FK_purchase_orders_supplier   FOREIGN KEY (supplier_id) REFERENCES oltp.suppliers (id),
    CONSTRAINT FK_purchase_orders_created_by FOREIGN KEY (created_by)  REFERENCES oltp.employees (id),
    CONSTRAINT FK_purchase_orders_status     FOREIGN KEY (status_id)   REFERENCES oltp.purchase_order_status (id)
);

CREATE TABLE oltp.employee_privileges (
    employee_id   BIGINT  NOT NULL,
    privilege_id  BIGINT  NOT NULL,
    CONSTRAINT PK_employee_privileges           PRIMARY KEY (employee_id, privilege_id),
    CONSTRAINT FK_employee_privileges_employee  FOREIGN KEY (employee_id)  REFERENCES oltp.employees (id),
    CONSTRAINT FK_employee_privileges_privilege FOREIGN KEY (privilege_id) REFERENCES oltp.privileges (id)
);

CREATE TABLE oltp.inventory_transactions (
    id                          BIGINT          NOT NULL,
    transaction_type            BIGINT          NULL,
    transaction_created_date    DATETIME2(7)    NULL,
    transaction_modified_date   DATETIME2(7)    NULL,
    product_id                  BIGINT          NULL,
    quantity                    BIGINT          NULL,
    purchase_order_id           BIGINT          NULL,
    customer_order_id           BIGINT          NULL,
    comments                    NVARCHAR(MAX)   NULL,
    CONSTRAINT PK_inventory_transactions           PRIMARY KEY (id),
    CONSTRAINT FK_inv_trans_type                   FOREIGN KEY (transaction_type)  REFERENCES oltp.inventory_transaction_types (id),
    CONSTRAINT FK_inv_trans_product                FOREIGN KEY (product_id)        REFERENCES oltp.products (id),
    CONSTRAINT FK_inv_trans_purchase_order         FOREIGN KEY (purchase_order_id) REFERENCES oltp.purchase_orders (id),
    CONSTRAINT FK_inv_trans_customer_order         FOREIGN KEY (customer_order_id) REFERENCES oltp.orders (id)
);

CREATE TABLE oltp.order_details (
    id                BIGINT          NOT NULL,
    order_id          BIGINT          NULL,
    product_id        BIGINT          NULL,
    quantity          FLOAT           NULL,
    unit_price        FLOAT           NULL,
    discount          FLOAT           NULL,
    status_id         BIGINT          NULL,
    date_allocated    DATETIME2(7)    NULL,
    purchase_order_id BIGINT          NULL,
    inventory_id      BIGINT          NULL,
    CONSTRAINT PK_order_details         PRIMARY KEY (id),
    CONSTRAINT FK_order_details_order   FOREIGN KEY (order_id)   REFERENCES oltp.orders (id),
    CONSTRAINT FK_order_details_product FOREIGN KEY (product_id) REFERENCES oltp.products (id),
    CONSTRAINT FK_order_details_status  FOREIGN KEY (status_id)  REFERENCES oltp.order_details_status (id)
);

CREATE TABLE oltp.purchase_order_details (
    id                    BIGINT          NOT NULL,
    purchase_order_id     BIGINT          NULL,
    product_id            BIGINT          NULL,
    quantity              FLOAT           NULL,
    unit_cost             FLOAT           NULL,
    date_received         DATETIME2(7)    NULL,
    posted_to_inventory   BIGINT          NULL,
    inventory_id          BIGINT          NULL,
    CONSTRAINT PK_purchase_order_details  PRIMARY KEY (id),
    CONSTRAINT FK_pod_purchase_order      FOREIGN KEY (purchase_order_id) REFERENCES oltp.purchase_orders (id),
    CONSTRAINT FK_pod_product             FOREIGN KEY (product_id)        REFERENCES oltp.products (id),
    CONSTRAINT FK_pod_inventory           FOREIGN KEY (inventory_id)      REFERENCES oltp.inventory_transactions (id)
);

CREATE TABLE oltp.invoices (
    id            BIGINT          NOT NULL,
    order_id      BIGINT          NULL,
    invoice_date  DATETIME2(7)    NULL,
    due_date      DATETIME2(7)    NULL,
    tax           FLOAT           NULL,
    shipping      FLOAT           NULL,
    amount_due    FLOAT           NULL,
    CONSTRAINT PK_invoices       PRIMARY KEY (id),
    CONSTRAINT FK_invoices_order FOREIGN KEY (order_id) REFERENCES oltp.orders (id)
);

CREATE TABLE oltp.sales_reports (
    group_by            NVARCHAR(MAX)   NULL,
    display             NVARCHAR(MAX)   NULL,
    title               NVARCHAR(MAX)   NULL,
    filter_row_source   NVARCHAR(MAX)   NULL,
    [default]           NVARCHAR(MAX)   NULL
);

CREATE TABLE oltp.strings (
    string_id   BIGINT          NULL,
    string_data NVARCHAR(MAX)   NULL
);
