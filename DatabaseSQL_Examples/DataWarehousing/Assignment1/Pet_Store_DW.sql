--Daniel Bishop
--03/06/2019
--Pet_Store_DW.sql

Create Table dates
(   
    date_id NUMBER (38,0),
    full_date date,
    day VARCHAR2(255 CHAR),
    month NUMBER (2,0),
    month_name VARCHAR2(255 CHAR),
    year VARCHAR2(255 CHAR),
    
    constraint date_pk Primary Key (date_id)
);

Create Table city
(   
    city_id NUMBER (38,0),
    city VARCHAR2(255 CHAR),
    state_name VARCHAR2(255 CHAR),
    area_code VARCHAR2(255 CHAR),
    zip_code VARCHAR2(255 CHAR),
    country VARCHAR2(255 CHAR),
    
    constraint city_pk Primary Key (city_id)
);

Create Table customers
(   
    customer_id NUMBER (38,0),
    phone VARCHAR2(255 CHAR),
    customer_name VARCHAR2(255 CHAR),
    address VARCHAR2(255 CHAR),
    zip_code VARCHAR2(255 CHAR),
    city_id NUMBER (38,0),
    
    constraint customers_pk Primary Key (customer_id),
    
    constraint fk_city
        foreign key (city_id)
        references city(city_id)
);


Create Table suppliers
(
    supplier_id NUMBER (38,0),
    name VARCHAR2(255 CHAR),
    
    constraint suppliers_pk Primary Key (supplier_id)
);

Create Table animals
(   
    animal_id NUMBER (38,0),
    name VARCHAR2(255 CHAR),
    category VARCHAR2(255 CHAR),
    breed VARCHAR2(255 CHAR),
    date_born date,
    gender VARCHAR2(255 CHAR),
    registered VARCHAR2(255 CHAR),
    color VARCHAR2(255 CHAR),
    list_price NUMBER (38,4),

    constraint animals_pk Primary Key (animal_id)        
);

Create Table merchandise
(   
    item_id NUMBER (38,0),
    description VARCHAR2(255 CHAR),
    quantitiy_on_hand NUMBER (38,0),
    list_price NUMBER (38,4),
    category VARCHAR2(255 CHAR),

    constraint merchandise_pk Primary Key (item_id)        
);

Create Table orders
(   
    order_fact_id NUMBER (38,0),
    order_date date,
    recieve_date date,
    quantity NUMBER (38,0),
    cost NUMBER (38,4),
    shipping_cost NUMBER (38,0),
    order_id NUMBER (38,0),
    po_number NUMBER (38,0),
    date_id NUMBER (38,0),
    supplier_id NUMBER (38,0),
    animal_id NUMBER (38,0),
    item_id NUMBER (38,0),

    constraint orders_pk Primary Key (order_fact_id),
    
    constraint fk_order_dates
        foreign key (date_id)
        references dates(date_id),
    constraint fk_suppliers
        foreign key (supplier_id)
        references suppliers(supplier_id),
    constraint fk_animals
        foreign key (animal_id)
        references animals(animal_id),
    constraint fk_merchandise
        foreign key (item_id)
        references merchandise(item_id)
);

Create Table sales
(   
    sale_id NUMBER (38,0),
    sales_tax NUMBER (38,4),
    quantity NUMBER (38,0),
    sale_price NUMBER (38,4),
    date_id NUMBER (38,0),
    customer_id NUMBER (38,0),
    animal_id NUMBER (38,0),
    item_id NUMBER (38,0),

    constraint sales_pk Primary Key (sale_id),
    
    constraint fk_sale_dates
        foreign key (date_id)
        references dates(date_id),
    constraint fk_sale_customers
        foreign key (customer_id)
        references customers(customer_id),
    constraint fk_sale_animals
        foreign key (animal_id)
        references animals(animal_id),
    constraint fk_sale_merchandise
        foreign key (item_id)
        references merchandise(item_id)
);

--Drops for convienience
--drop table animals;
--drop table city;
--drop table customers;
--drop table dates;
--drop table merchandise;
--drop table orders;
--drop table sales;
--drop table suppliers;