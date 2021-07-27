--Creation Script for the Schema and a drop for it
--David Beverley, Adam Collier, Zach Hall, and Daniel Bishop

DROP TABLE "CONTRACTS" CASCADE CONSTRAINTS;
DROP TABLE "CUSTOMERS" CASCADE CONSTRAINTS;
DROP TABLE "EMPLOYEES" CASCADE CONSTRAINTS;
DROP TABLE "EMP_AVAILABILITY" CASCADE CONSTRAINTS;
DROP TABLE "EMP_ROLES" CASCADE CONSTRAINTS;
DROP TABLE "EMP_SERVICES" CASCADE CONSTRAINTS;
DROP TABLE "LOCATIONS" CASCADE CONSTRAINTS;
DROP TABLE "ORDERS" CASCADE CONSTRAINTS;
DROP TABLE "ORDER_PACKAGES" CASCADE CONSTRAINTS;
DROP TABLE "PACKAGES" CASCADE CONSTRAINTS;
DROP TABLE "PICTURES" CASCADE CONSTRAINTS;
DROP TABLE "PROOFS" CASCADE CONSTRAINTS;
DROP TABLE "REVIEWS" CASCADE CONSTRAINTS;
DROP TABLE "ROLES" CASCADE CONSTRAINTS;
DROP TABLE "SERVICES" CASCADE CONSTRAINTS;
DROP TABLE "SERVICE_TYPES" CASCADE CONSTRAINTS;

CREATE TABLE roles
(
    role_id NUMBER (10,0) PRIMARY KEY,
    role_name VARCHAR2(255)NOT NULL,
    role_desc VARCHAR2(255),
    active number(1,0) NOT NULL
    
    CONSTRAINT roles_active_bool check (active in (0, 1))
);

CREATE TABLE locations
(
    location_id NUMBER(10,0) PRIMARY KEY,
    country VARCHAR2(255) NOT NULL,
    state VARCHAR2(255),
    city VARCHAR2(255) NOT NULL,
    street VARCHAR2(255) NOT NULL,
    unit_number VARCHAR2(255),
    zip VARCHAR2(255) NOT NULL
);

CREATE TABLE packages
(
  PACKAGE_ID NUMBER(10) PRIMARY KEY
, PACKAGE_NAME VARCHAR2(255) NOT NULL
, DESCRIPTION VARCHAR2(255)
, PRICE NUMBER(8,2) NOT NULL

);

CREATE TABLE customers
(
    customer_id NUMBER(10,0) PRIMARY KEY,
    first_name VARCHAR2(255),
    last_name VARCHAR2(255),
    company_name VARCHAR2(255),
    street VARCHAR2(255) NOT NULL,
    zip VARCHAR2(255) NOT NULL,
    state VARCHAR2(255) NOT NULL,
    country VARCHAR2(255) NOT NULL,
    city VARCHAR2(255) NOT NULL,
    unit_number VARCHAR2(255)
    
);

Create Table service_types
(   
    service_type_id NUMBER (10,0) PRIMARY KEY,
    service_type VARCHAR2(255 CHAR) NOT NULL,
    description VARCHAR2(255 CHAR) NOT NULL
);

Create Table services
(   
    service_id NUMBER (10,0) PRIMARY KEY,
    service_name VARCHAR2(255 CHAR) NOT NULL,
    location_id NUMBER (10,0) NOT NULL,
    service_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    customer_id NUMBER(10,0) NOT NULL,
    service_type_id NUMBER(10,0) NOT NULL,
    
    constraint fk_service_customers
        foreign key (customer_id)
        references customers(customer_id),
        
    constraint fk_service_types
        foreign key (service_type_id)
        references service_types(service_type_id)
);

CREATE TABLE contracts
(
    contract_id NUMBER(10,0) PRIMARY KEY,
    customer_id NUMBER(10,0) NOT NULL,
    service_id NUMBER(10,0) NOT NULL,
    signed NUMBER(1,0) NOT NULL,
    deposit_amt NUMBER(10,0) NOT NULL,
    
    CONSTRAINT sign_bool check (signed in (0, 1)),
    
    constraint fk_contract_customers
        foreign key (customer_id)
        references customers(customer_id),
        
    constraint fk_contract_service
        foreign key (service_id)
        references services(service_id)
);

CREATE TABLE pictures
(
    pic_id NUMBER(10,0) PRIMARY KEY,
    file_path VARCHAR2(255) NOT NULL,
    service_id NUMBER(10,0) NOT NULL,
    
    constraint fk_service_picture 
        foreign key (service_id) 
        references Services(service_id)
);

Create Table employees
(   
    emp_id NUMBER (10,0) PRIMARY KEY,
    first_name VARCHAR2(255 CHAR) NOT NULL,
    last_name VARCHAR2(255 CHAR) NOT NULL,
    hire_date DATE NOT NULL,
    active NUMBER(1,0) NOT NULL,
    
    CONSTRAINT emp_active_bool check (active in (0, 1))        
);

CREATE TABLE emp_availability
(
    available_id number(10,0) PRIMARY KEY,
    start_time TIMESTAMP NOT NULL,
    end_time   TIMESTAMP NOT NULL,
    emp_id number(10,0) NOT NULL,
    
    constraint fk_emp_availability 
        foreign key (emp_id) 
        references employees(emp_id)
);

Create Table emp_services
(
    service_id NUMBER (10,0),
    emp_id NUMBER(10,0) NOT NULL,
    assist_emp_id NUMBER(10,0) NOT NULL,
    
    constraint emp_services_pk Primary Key (service_id, emp_id),

    constraint fk_service_id
        foreign key (service_id)
        references services(service_id),
    
    constraint fk_emp
    foreign key (emp_id)
        references employees(emp_id),
    
    constraint fk_emp_assist
    foreign key (assist_emp_id)
        references employees(emp_id)
    
);

CREATE TABLE emp_roles
(
    emp_role_id NUMBER(10,0) PRIMARY KEY,
    emp_id number(10,0) NOT NULL,
    role_id number(10,0) NOT NULL,
    
    constraint fk_employees 
        foreign key (emp_id) 
        references Employees(emp_id),
        
    constraint fk_roles 
        foreign key (role_id) 
        references Roles(role_id)    
);

CREATE TABLE reviews
(
    review_id NUMBER(10) PRIMARY KEY,
    review VARCHAR2(255) NOT NULL,
    review_rating NUMBER(1,0) NOT NULL, 
    service_id NUMBER(10,0) NOT NULL,
    
    constraint fk_service 
        foreign key (service_id) 
        references Services(service_id)   
);

CREATE TABLE orders 
(
  order_id NUMBER(10) NOT NULL PRIMARY KEY,
  description VARCHAR2(255),
  special_instructions VARCHAR2(255),
  balance NUMBER(8,2) NOT NULL,
  balance_paid NUMBER(10,2),
  paid_in_full NUMBER(1,0) NOT NULL,
  customer_id number(10) NOT NULL,
  
  CONSTRAINT paid_in_full_bool check (paid_in_full in (0, 1)),
  
  CONSTRAINT fk_order_customers
    FOREIGN KEY (customer_id)
        references customers(customer_id),
        
    CONSTRAINT paid_bool check (paid_in_full in (0, 1))
);

CREATE TABLE order_packages 
(
  order_package_id NUMBER(10) NOT NULL
, package_id number(10) Not Null
, order_id NUMBER(10)NOT NULL 
, quantity NUMBER(8,2)
, CONSTRAINT order_package_PK PRIMARY KEY 
  (
    order_package_ID 
  )
, CONSTRAINT fk_op_orders
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
, CONSTRAINT fk_op_packages
    FOREIGN KEY (package_id)
        references packages(package_id)
);

CREATE TABLE proofs 
(
  proof_id NUMBER(10) NOT NULL 
, order_id NUMBER(10)NOT NULL 
, CONSTRAINT proofs_PK PRIMARY KEY 
  (
    proof_ID 
  )
, CONSTRAINT fk_proof_orders
    FOREIGN KEY (order_id)
        references orders(order_id)
);