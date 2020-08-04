

CREATE TABLE menu_item(
item_id int auto_increment primary key unique,
name varchar(30) not null,
price decimal(10,2) not null,
Active enum('Yes','No'),
DateOfLaunch date not null,
Category enum('Main Course','Starter','Desserts','Drinks'),
FreeDelivery enum('Yes','No')
);

CREATE TABLE user
( user_id int primary key auto_increment unique ,
user_name varchar(30) not null,
category enum('Admin','Customer')
);

CREATE TABLE cart(
cart_id int primary key auto_increment,
item_id int ,
user_id int,
foreign key(user_id) references user(user_id),
foreign key(item_id) references menu_item(item_id)
);


-- 1a)View Menu List Admin

insert into menu_item
values
(1,'Sandwich',99.00,'Yes','2017:03:15','Main Course','Yes'),
(2,'Burger',129.00,'Yes','2017:12:23','Main Course','No'),
(3,'Pizza',149.00,'Yes','2017:08:21','Main Course','No'),
(4,'French Fries',57.00,'No','2017:07:02','Starter','Yes'),
(5,'Chocolate Brownie',32.00,'Yes','2022:11:02','Desserts','Yes');

-- 1b)
SELECT 
name as Name,
CONCAT('Rs. ',price) AS Price,
Active,
date_format(DateOfLaunch,'%d/%m/%Y') AS "Date of Launch",
Category,
FreeDelivery AS "Free Delivery"
FROM menu_item;

-- 2a)View Menu List Customer

SELECT 
item_id AS "ID",
name as Name,
CONCAT('Rs. ',price) AS Price,
Active,
date_format(DateOfLaunch,'%d/%m/%Y') AS "Date of Launch",
Category,
FreeDelivery AS "Free Delivery"
FROM menu_item
WHERE DATE(DateOfLaunch)>current_timestamp() AND Active='Yes';

-- 3a)Edit Manu Item

SELECT 
item_id AS "ID",
name as Name,
CONCAT('Rs. ',price) AS Price,
Active,
date_format(DateOfLaunch,'%d/%m/%Y') AS "Date of Launch",
Category,
FreeDelivery AS "Free Delivery"
FROM menu_item
WHERE item_id=1;

-- 3b)

UPDATE menu_item
SET price=101.00,
	DateOfLaunch='2022-03-15'
WHERE item_id=1;

-- 4a)Add to Cart

insert into user
values
(1,'nag','Admin'),
(2,'baskar','Customer'),
(3,'Harish','Customer');

insert into cart(item_id,user_id)
values
(1,2),
(2,2),
(3,2),
(4,3);

-- 5a)View Cart

SELECT 
name as Name,
CONCAT('Rs. ',price) AS Price,
Active,
date_format(DateOfLaunch,'%d/%m/%Y') AS "Date of Launch",
Category,
FreeDelivery AS "Free Delivery"
FROM menu_item
JOIN cart ON menu_item.item_id = cart.item_id
WHERE cart.user_id=2;

-- 5b)

SELECT CONCAT('Rs. ',CAST(SUM(price) AS char(30))) AS "Total"
FROM menu_item
JOIN cart ON menu_item.item_id = cart.item_id
WHERE cart.user_id=2;

-- 6a)Remove Item Cart

DELETE FROM cart
WHERE user_id=2 AND item_id=1;

-- 

SELECT * FROM menu_item;

SELECT * FROM cart;

SELECT * FROM user;

DROP TABLE menu_item;

DROP TABLE user;

DROP TABLE cart;

--



