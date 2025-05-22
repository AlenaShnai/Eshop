-- -----------------------------------------------------
-- Создание таблиц
-- -----------------------------------------------------
CREATE TYPE ROLE AS ENUM ('ГОСТЬ', 'КУРЬЕР', 'МОДЕРАТОР', 'АДМИНИСТРАТОР', 'ПОЛЬЗОВАТЕЛЬ');

create table if not exists ROLES (
Role_ID INT primary key,
RoleName ROLE ,
Permissions JSON);



create table if not exists USERS (
User_ID INT primary key,
Role_ID INT not null default 0,
constraint FK_USERS_Role_ID
FOREIGN key (Role_ID)
references ROLES (Role_ID),
FirstName VARCHAR (100) not null,
LastName VARCHAR (100) not null ,
MediumName VARCHAR (100), 
Email VARCHAR (100) not null,
Phone VARCHAR (20) not null,
RegistrationDate DATE,
LastLoginDate DATE,
IsVIP BOOLEAN,
VIPSince DATE,
TotalPurchasesAmount DECIMAL (8,2));

ALTER TABLE USERS
ALTER COLUMN VIPSince TYPE TIMESTAMP,
ALTER COLUMN VIPSince SET NOT NULL,
ALTER COLUMN VIPSince SET DEFAULT CURRENT_TIMESTAMP;




CREATE TYPE AddressType_VIED AS ENUM ('ДОМАШНИЙ', 'РАБОЧИЙ', 'ПРОЧЕЕ');


create table if not exists USERADDRESSES (
AddressID INT primary key,
User_ID INT not null default 0,
constraint FK_USERS_User_ID
FOREIGN key (User_ID)
references USERS (User_ID)
on delete cascade
on update cascade, 
AddressType AddressType_VIED,
Country VARCHAR (100) not null,
CITY VARCHAR (100) not null ,
STREET VARCHAR (100) not null, 
Building VARCHAR (100) not null,
Apartment VARCHAR (20),
ZIPCode VARCHAR (10),
LastLoginDate DATE,
DeliveryNotes TEXT );


ALTER TABLE USERADDRESSES
ALTER COLUMN LastLoginDate TYPE TIMESTAMP,
ALTER COLUMN LastLoginDate SET NOT NULL,
ALTER COLUMN LastLoginDate SET DEFAULT CURRENT_TIMESTAMP;




 create table if not exists CATEGORIES (
CATEGORY_ID INT primary key,
CATEGORY_Description TEXT,
ImageURL VARCHAR (100) ,
IsActive BOOLEAN, 
CREATEDAT DATE,
UpdatedAt DATE);


ALTER TABLE CATEGORIES
ALTER COLUMN CREATEDAT TYPE TIMESTAMP,
ALTER COLUMN CREATEDAT SET NOT NULL,
ALTER COLUMN CREATEDAT SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE CATEGORIES
ALTER COLUMN UpdatedAt TYPE TIMESTAMP,
ALTER COLUMN UpdatedAt SET NOT NULL,
ALTER COLUMN UpdatedAt SET DEFAULT CURRENT_TIMESTAMP;




create table if not exists PRODUCTS (
PRODUCT_id INT primary key,
CATEGORY_ID INT not null default 0,
constraint FK_CATEGORYS_CATEGORY_ID
FOREIGN key (CATEGORY_ID)
references CATEGORIES (CATEGORY_ID)
on delete cascade
on update cascade,
SKU CHAR (10) not null,
PRODUCT_NAME VARCHAR (100) not null ,
Description TEXT,
PRICE DECIMAL (8,2) not null,
UnitOfMeasure INT,
StockQuantity INT,
Weight DECIMAL (8,2) not null,
Dimensions VARCHAR (100),
IsActive BOOLEAN,
CREATEDAT DATE,
UpdatedAt DATE,
Rating DECIMAL (8,2),
ReviewCount INT,
IsFeatured BOOLEAN);

ALTER TABLE PRODUCTS
ALTER COLUMN CREATEDAT TYPE TIMESTAMP,
ALTER COLUMN CREATEDAT SET NOT NULL,
ALTER COLUMN CREATEDAT SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE PRODUCTS
ALTER COLUMN UpdatedAt TYPE TIMESTAMP,
ALTER COLUMN UpdatedAt SET NOT NULL,
ALTER COLUMN UpdatedAt SET DEFAULT CURRENT_TIMESTAMP;



create table if not exists PromotionS (
Promotion_ID INT primary key,
PRODUCT_id INT not null default 0,
constraint FK_PRODUCTS_PRODUCT_id
FOREIGN key (PRODUCT_id)
references PRODUCTS (PRODUCT_id),
Promotion_Name VARCHAR (100) not null ,
Description TEXT,
DiscountValue DECIMAL (5,2),
StartDate DATE,
ENDDATE DATE,
IsActive BOOLEAN,
MinOrderAmount DECIMAL (8,2),
ApplicableCategories JSON,
PromoCoden VARCHAR (100));

create table if not exists DISCOUNTCARDS (
cARD_ID INT primary key,
User_ID INT not null default 0,
constraint FK_USERS_User_ID
FOREIGN key (User_ID)
references USERS (User_ID)
on delete cascade
on update cascade, 
CardNumber CHAR (13) not null default 0 ,
DiscountRate DECIMAL (10,2),
IsActive BOOLEAN,
ISSUEDATE DATE,
ExpiryDate DATE);

ALTER TABLE DISCOUNTCARDS
ALTER COLUMN ISSUEDATE TYPE TIMESTAMP,
ALTER COLUMN ISSUEDATE SET NOT NULL,
ALTER COLUMN ISSUEDATE SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE DISCOUNTCARDS
ALTER COLUMN ExpiryDate TYPE TIMESTAMP,
ALTER COLUMN ExpiryDate SET NOT NULL,
ALTER COLUMN ExpiryDate SET DEFAULT CURRENT_TIMESTAMP;




CREATE TYPE ORDER_STATUS AS ENUM ('ОПЛАЧЕН', 'СОБРАН', 'В ПУТИ', 'ДОСТАВЛЕН', 'ОТКАЗ');

CREATE TYPE ORDER_PaymentMethod AS ENUM ('КАРТА', 'НАЛИЧНЫЕ', 'РАССРОЧКА');



create table if not exists ORDERS (
ORDER_ID INT primary key,
User_ID INT not null default 0,
constraint FK_USERS_User_ID
FOREIGN key (User_ID)
references USERS (User_ID)
on delete cascade
on update cascade,
OrderDate DATE,
ORDENS_Status ORDER_STATUS,
TotalAmount DECIMAL (10,2),
DiscountAmount DECIMAL (10,2),
FinalAmount DECIMAL (10,2),
PaymentMethod ORDER_PaymentMethod,
DeliveryAddressID VARCHAR (255) not null default 0,
DeliveryCost DECIMAL (10,2),
Notes TEXT,
VIPDiscountApplied BOOLEAN,
USER_Promotion VARCHAR (255));

ALTER TABLE ORDERS
ALTER COLUMN OrderDate TYPE TIMESTAMP,
ALTER COLUMN OrderDate SET NOT NULL,
ALTER COLUMN OrderDate SET DEFAULT CURRENT_TIMESTAMP;



alter table ORDERS add column AddressID INT not null;
ALTER TABLE ORDERS
ADD CONSTRAINT FK_USERADDRESSES_AddressID
FOREIGN KEY (AddressID) 
REFERENCES USERADDRESSES(AddressID);
alter table ORDERS drop column  DeliveryAddressID;
alter table ORDERS drop column USER_Promotion;

alter table ORDERS add column Promotion_ID INT not null;
ALTER TABLE ORDERS
ADD CONSTRAINT FK_PromotionS_Promotion_ID
FOREIGN KEY (Promotion_ID) 
REFERENCES PromotionS(Promotion_ID);




create table if not exists PAYMENTS (
PAYMENT_ID INT primary key,
ORDER_ID INT not null default 0,
constraint FK_ORDERS_ORDER_ID
FOREIGN key (ORDER_ID)
references ORDERS (ORDER_ID),
Amount DECIMAL (10,2),
PaymentMethod ORDER_PaymentMethod,
PaymentDate DATE,
TransactionID VARCHAR (255),
GatewayResponse JSON);

ALTER TABLE PAYMENTS
ALTER COLUMN PaymentDate TYPE TIMESTAMP,
ALTER COLUMN PaymentDate SET NOT NULL,
ALTER COLUMN PaymentDate SET DEFAULT CURRENT_TIMESTAMP;




create table if not exists CARTS (
CART_ID INT primary key,
User_ID INT not null default 0,
constraint FK_USERS_User_ID
FOREIGN key (User_ID)
references USERS (User_ID)
on delete cascade
on update cascade,
SESSION VARCHAR (255),
CreatedAt DATE,
UpdatedAt DATE,
ExpiresAt DATE);

alter table CartS add column SESSION_ID VARCHAR (255); 
alter table CartS drop column session;

ALTER TABLE CARTS
ALTER COLUMN CreatedAt TYPE TIMESTAMP,
ALTER COLUMN CreatedAt SET NOT NULL,
ALTER COLUMN CreatedAt SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE CARTS
ALTER COLUMN UpdatedAt TYPE TIMESTAMP,
ALTER COLUMN UpdatedAt SET NOT NULL,
ALTER COLUMN UpdatedAt SET DEFAULT CURRENT_TIMESTAMP;


ALTER TABLE CARTS
ALTER COLUMN ExpiresAt TYPE TIMESTAMP,
ALTER COLUMN ExpiresAt SET NOT NULL,
ALTER COLUMN ExpiresAt SET DEFAULT CURRENT_TIMESTAMP;



create table if not exists CartItemS (
CARTITEM_ID INT primary key,
CART_ID INT not null default 0,
constraint FK_CARTS_CART_ID
FOREIGN key (CART_ID)
references CARTS (CART_ID)
on delete cascade
on update cascade,
PRODUCT_ID INT,
Quantity INT,
PriceAtAddition DATE,
AddedAt DATE);

ALTER TABLE CartItemS
ALTER COLUMN PriceAtAddition TYPE TIMESTAMP,
ALTER COLUMN PriceAtAddition SET NOT NULL,
ALTER COLUMN PriceAtAddition SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE CartItemS
ALTER COLUMN AddedAt TYPE TIMESTAMP,
ALTER COLUMN AddedAt SET NOT NULL,
ALTER COLUMN AddedAt SET DEFAULT CURRENT_TIMESTAMP;




alter table CartItemS add column SESSION_ID VARCHAR (255); 
alter table CartItemS DROP column SESSION_ID ; 
alter table CartItemS DROP column PRODUCT_ID; 


alter table CartItemS add column PRODUCT_ID INT not null;
ALTER TABLE CartItemS
ADD CONSTRAINT FK_PRODUCTS_PRODUCT_id
FOREIGN KEY (PRODUCT_id) 
REFERENCES PRODUCTS (PRODUCT_id);



create table if not exists PRODUCTIMAGES (
ImageID INT primary key,
PRODUCT_id INT not null default 0,
constraint FK_PRODUCTS_PRODUCT_id
FOREIGN key (PRODUCT_id)
references PRODUCTS (PRODUCT_id)
on delete cascade
on update cascade,
ImageURL VARCHAR (255),
ThumbnailURL VARCHAR (255),
OrderIndex INT,
IsMain BOOLEAN);

CREATE TYPE STATUS_REVIEWS AS ENUM ('НА МОДЕРАЦИИ', 'ОПУБЛИКОВАНО', 'ОТКЛОНЕНО');

CREATE TABLE IF NOT EXISTS reviews (
    REVIEW_ID INT PRIMARY KEY,
    PRODUCT_id INT NOT NULL DEFAULT 0,
    CONSTRAINT FK_PRODUCTS_PRODUCT_id
        FOREIGN KEY (PRODUCT_id)
        REFERENCES PRODUCTS (PRODUCT_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    User_ID INT NOT NULL,
    CONSTRAINT FK_USERS_User_ID
        FOREIGN KEY (User_ID)
        REFERENCES USERS (User_ID),
    ORDER_ID INT NOT NULL,
    CONSTRAINT FK_ORDERS_ORDER_ID
        FOREIGN KEY (ORDER_ID)
        REFERENCES ORDERS (ORDER_ID),
    Rating NUMERIC(3,1) 
        CHECK (Rating BETWEEN 1.0 AND 5.0),
    TITLE VARCHAR(100),
    REVIEW_TEXT TEXT,
    CreatedAt TIMESTAMP,
    UpdatedAt TIMESTAMP,
    StatusREVIEWS STATUS_REVIEWS, 
    ModerationDate TIMESTAMP);

ALTER TABLE reviews
ALTER COLUMN CreatedAt SET NOT NULL;

ALTER TABLE reviews
ALTER COLUMN UpdatedAt SET NOT NULL;

ALTER TABLE reviews
ALTER COLUMN ModerationDate SET NOT null;

CREATE TABLE IF NOT EXISTS REVIEWIMAGES (
    ReviewImage_ID INT PRIMARY KEY,
    REVIEW_ID INT NOT NULL DEFAULT 0,
    CONSTRAINT FK_reviews_REVIEW_ID
        FOREIGN KEY (REVIEW_ID)
        REFERENCES reviews (REVIEW_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        User_ID INT NOT NULL,
    CONSTRAINT FK_USERS_User_ID
        FOREIGN KEY (User_ID)
        REFERENCES USERS (User_ID),
        ImageURL VARCHAR (255),
        ThumbnailURL VARCHAR (255),
        ModerationDate TIMESTAMP,
        StatusREVIEWS STATUS_REVIEWS); 

ALTER TABLE REVIEWIMAGES
ALTER COLUMN ModerationDate SET NOT null;

alter table REVIEWIMAGES DROP column User_ID ; 



create table if not exists ORDERITEMS (
ORDERITEM_ID INT primary key,
ORDER_ID INT not null default 0,
constraint FK_ORDERS_ORDER_ID
FOREIGN key (ORDER_ID)
references ORDERS (ORDER_ID)
on delete cascade
on update cascade,
PRODUCT_id INT NOT NULL,
    CONSTRAINT FK_PRODUCTS_PRODUCT_id
        FOREIGN KEY (PRODUCT_id)
        REFERENCES PRODUCTS (PRODUCT_id),
        Quantity INT,
        UnitPrice DECIMAL (10,2),
        TotalPrice DECIMAL (10,2),
DiscountApplied DECIMAL (10,2));

---------------------------------------------------
--Заполнение таблиц начальными данными.
--------------------------------------------------

INSERT INTO ROLES (Role_ID, RoleName, Permissions) VALUES
(1, 'ПОЛЬЗОВАТЕЛЬ', '{"view": true, "order": true}'),
(2, 'АДМИНИСТРАТОР', '{"all": true}'),
(3, 'КУРЬЕР', '{"view_orders": true, "update_status": true}');

--  Добавляем пользователей
INSERT INTO USERS (User_ID, Role_ID, FirstName, LastName, Email, Phone, RegistrationDate, IsVIP, TotalPurchasesAmount) VALUES
(1, 1, 'Иван', 'Иванов', 'ivan@example.com', '+79161234567', '2023-01-15', FALSE, 0),
(2, 1, 'Петр', 'Петров', 'petr@example.com', '+79162345678', '2023-02-20', TRUE, 1500),
(3, 1, 'Сергей', 'Сергеев', 'sergey@example.com', '+79163456789', '2023-03-10', FALSE, 300);

-- Добавляем адреса пользователей
INSERT INTO USERADDRESSES (AddressID, User_ID, AddressType, Country, CITY, STREET, Building, Apartment, ZIPCode) VALUES
(1, 1, 'ДОМАШНИЙ', 'Россия', 'Москва', 'Ленина', '10', '25', '123456'),
(2, 1, 'РАБОЧИЙ', 'Россия', 'Москва', 'Гагарина', '5', '13', '123457'),
(3, 2, 'ДОМАШНИЙ', 'Россия', 'Санкт-Петербург', 'Невский', '20', '7', '190000'),
(4, 3, 'ДОМАШНИЙ', 'Россия', 'Казань', 'Пушкина', '15', '42', '420000');

-- Добавляем категории продуктов
INSERT INTO CATEGORIES (CATEGORY_ID, CATEGORY_Description, IsActive) VALUES
(1, 'Молочные продукты', TRUE),
(2, 'Бакалея', TRUE),
(3, 'Мясные продукты', TRUE);

-- Обновляем сумму покупок пользователя
UPDATE USERS SET TotalPurchasesAmount = TotalPurchasesAmount + 1140.00 WHERE User_ID = 2;

--  Добавляем продукты
INSERT INTO PRODUCTS (PRODUCT_ID, CATEGORY_ID, SKU, PRODUCT_NAME, Description, PRICE, StockQuantity, Weight, IsActive) 
SELECT 1, 1, 'MILK001', 'Молоко Домик в деревне', 'Молоко 3.2% жирности, 1л', 85.50, 100, 1.0, TRUE
WHERE NOT EXISTS (SELECT 1 FROM PRODUCTS WHERE PRODUCT_ID = 1);

-- Добавляем дисконтную карту
INSERT INTO DISCOUNTCARDS (CARD_ID, User_ID, CardNumber, DiscountRate, IsActive, ExpiryDate) 
SELECT 1, 2, '1234567890123', 5.00, TRUE, '2025-12-31'
WHERE NOT EXISTS (SELECT 1 FROM DISCOUNTCARDS WHERE CARD_ID = 1);


-- Обновляем сумму покупок пользователя (если заказ был создан)
UPDATE USERS 
SET TotalPurchasesAmount = TotalPurchasesAmount + 1140.00 
WHERE User_ID = 2 
AND EXISTS (SELECT 1 FROM ORDERS WHERE ORDER_ID = 1 AND User_ID = 2);
