CREATE TABLE shop (
  id          varchar(10) NOT NULL, 
  city        varchar(50) NOT NULL, 
  street      varchar(50) NOT NULL, 
  building    int(3) NOT NULL, 
  date_open   date NOT NULL, 
  date_closed date, 
  PRIMARY KEY (id));
CREATE TABLE worker (
  id          varchar(10) NOT NULL, 
  first_name  varchar(15), 
  second_name varchar(15), 
  address     varchar(100), 
  birth_date  date NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE employment (
  worker_id     varchar(10) NOT NULL, 
  shop_id       varchar(10), 
  department_id varchar(10), 
  date_start    date NOT NULL, 
  date_finish   date, 
  PRIMARY KEY (worker_id));
CREATE TABLE department (
  id            varchar(10) NOT NULL, 
  name          varchar(100) NOT NULL, 
  description   varchar(255), 
  date_creation date NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE shop_product (
  shop_id         varchar(10) NOT NULL, 
  product_id      varchar(10) NOT NULL, 
  price           numeric(10, 2) NOT NULL, 
  discount_id     varchar(10), 
  expiration_date date, 
  amount          int(10) NOT NULL, 
  amount_storage  int(10) NOT NULL, 
  PRIMARY KEY (shop_id, 
  product_id));
CREATE TABLE provider (
  id           varchar(10) NOT NULL, 
  name         varchar(100) NOT NULL, 
  description  varchar(255), 
  address      varchar(255), 
  phone_number varchar(50), 
  PRIMARY KEY (id));
CREATE TABLE product_distribution (
  provider_id varchar(10) NOT NULL, 
  product_id  varchar(10) NOT NULL, 
  worker_id   varchar(10) NOT NULL, 
  shop_id     varchar(10) NOT NULL, 
  price       int(10) NOT NULL, 
  amount      int(10) NOT NULL, 
  PRIMARY KEY (provider_id, 
  product_id, 
  worker_id, 
  shop_id));
CREATE TABLE product (
  id              varchar(10) NOT NULL, 
  name            varchar(50) NOT NULL, 
  description     varchar(100), 
  expiration_time timestamp NULL, 
  composition     varchar(255), 
  weight          numeric(7, 3), 
  carbohydrates   numeric(5, 1), 
  fats            numeric(5, 1), 
  protein         numeric(5, 1), 
  PRIMARY KEY (id));
CREATE TABLE client (
  id           varchar(10) NOT NULL, 
  name_full    varchar(50) NOT NULL, 
  mail         varchar(50) NOT NULL, 
  phone_number varchar(15) NOT NULL, 
  money_spent  numeric(10, 2) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE discount (
  id          varchar(10) NOT NULL, 
  description varchar(100), 
  discount    int(3) NOT NULL, 
  sum_to_get  int(10), 
  PRIMARY KEY (id));
CREATE TABLE purchase_history (
  shopid        varchar(10) NOT NULL, 
  product_id    varchar(10) NOT NULL, 
  clientid      varchar(10) NOT NULL, 
  purchase_date date NOT NULL, 
  PRIMARY KEY (shopid, 
  product_id, 
  clientid));
CREATE TABLE price_history (
  id           varchar(10) NOT NULL, 
  product_id   varchar(10) NOT NULL, 
  shop_id      varchar(10) NOT NULL, 
  price        numeric(10, 2) NOT NULL, 
  date_changed date NOT NULL, 
  PRIMARY KEY (id, 
  product_id, 
  shop_id));
CREATE TABLE discount_list (
  discount_id varchar(10) NOT NULL, 
  client_id   varchar(10) NOT NULL, 
  PRIMARY KEY (discount_id, 
  client_id));
ALTER TABLE employment ADD CONSTRAINT FKemployment81671 FOREIGN KEY (shop_id) REFERENCES shop (id);
ALTER TABLE employment ADD CONSTRAINT FKemployment184163 FOREIGN KEY (worker_id) REFERENCES worker (id);
ALTER TABLE employment ADD CONSTRAINT FKemployment848122 FOREIGN KEY (department_id) REFERENCES department (id);
ALTER TABLE product_distribution ADD CONSTRAINT FKproduct_di496488 FOREIGN KEY (provider_id) REFERENCES provider (id);
ALTER TABLE product_distribution ADD CONSTRAINT `provider to shop` FOREIGN KEY (shop_id) REFERENCES shop (id);
ALTER TABLE product_distribution ADD CONSTRAINT `taking products` FOREIGN KEY (worker_id) REFERENCES worker (id);
ALTER TABLE shop_product ADD CONSTRAINT FKshop_produ939633 FOREIGN KEY (shop_id) REFERENCES shop (id);
ALTER TABLE shop_product ADD CONSTRAINT `product to shop` FOREIGN KEY (product_id) REFERENCES product (id);
ALTER TABLE product_distribution ADD CONSTRAINT FKproduct_di824470 FOREIGN KEY (product_id) REFERENCES product (id);
ALTER TABLE purchase_history ADD CONSTRAINT FKpurchase_h557706 FOREIGN KEY (shopid, product_id) REFERENCES shop_product (shop_id, product_id);
ALTER TABLE purchase_history ADD CONSTRAINT FKpurchase_h860873 FOREIGN KEY (clientid) REFERENCES client (id);
ALTER TABLE price_history ADD CONSTRAINT FKprice_hist593517 FOREIGN KEY (shop_id, product_id) REFERENCES shop_product (shop_id, product_id);
ALTER TABLE shop_product ADD CONSTRAINT FKshop_produ151383 FOREIGN KEY (discount_id) REFERENCES discount (id);
ALTER TABLE discount_list ADD CONSTRAINT FKdiscount_l71253 FOREIGN KEY (client_id) REFERENCES client (id);
ALTER TABLE discount_list ADD CONSTRAINT FKdiscount_l362107 FOREIGN KEY (discount_id) REFERENCES discount (id);
