create database Sale_Shoes_Database;
use Sale_Shoes_Database;
CREATE TABLE Type_Shoes (
	ID_Code_Type_Shoes SERIAL NOT NULL PRIMARY KEY,
	Title_Type_Shoes VARCHAR(30) NOT NULL UNIQUE 
 );
 CREATE TABLE Buyer (
 ID_Code_Buyer SERIAL NOT NULL PRIMARY KEY,
 Name_Buyer VARCHAR(30) NOT NULL,
 Surname_Buyer VARCHAR(30) NOT NULL,
 Adress VARCHAR(30) NOT NULL,
 End_Date DATE NULL,
 CVV INT NOT NULL CHECK (CVV > 0),
 Contact_Phone_Number VARCHAR(19) NOT NULL UNIQUE,
 Email_Addres VARCHAR(30) NOT NULL UNIQUE 
 );
 CREATE TABLE Type_Season (
 ID_Code_Type_Season SERIAL NOT NULL PRIMARY KEY,
 Title_Season VARCHAR(30) NOT NULL UNIQUE
 );
 CREATE TABLE Type_Product (
 ID_Code_Type_Product SERIAL NOT NULL PRIMARY KEY,
 Quantity_Type_Product INT NOT NULL
 );
 CREATE TABLE Manufacturer (
 ID_Code_Manufacturer SERIAL NOT NULL PRIMARY KEY,
 Title_Manufacturer VARCHAR(30) NOT NULL 
 );
 CREATE TABLE Courier ( 
 ID_Code_Courier SERIAL NOT NULL PRIMARY KEY,
 Where_From_Couriel VARCHAR(30) NOT NULL,
 Where_Courier VARCHAR(30) NOT NULL,
 Formation_Act INT NOT NULL 
 );
 CREATE TABLE Employer (
 ID_Code_Employer SERIAL NOT NULL PRIMARY KEY,
 Name_Employer VARCHAR(30) NOT NULL,
 Surname_Employer VARCHAR(30) NOT NULL
 );
 CREATE TABLE Model ( 
 ID_Code_Model SERIAL NOT NULL PRIMARY KEY,
 Sizes INT NOT NULL,
 Image VARCHAR(30) NOT NULL,
 Quantity_Model INT NOT NULL,
 Warranty_Period INT NOT NULL,
 Code_Manufacturer_ID INT NOT NULL REFERENCES Manufacturer (ID_Code_Manufacturer),
 Code_Employer_ID INT NOT NULL REFERENCES Employer (ID_Code_Employer)
 );
 CREATE TABLE Product (
 ID_Code_Product SERIAL NOT NULL PRIMARY KEY,
 Amount_Product INT NOT NULL,
 Title_Product VARCHAR(30) NOT NULL,
 Quantity_Product INT NOT NULL,
 Code_Type_Shoes_ID INT NOT NULL REFERENCES Type_Shoes (ID_Code_Type_Shoes),
 Code_Type_Season_ID INT NOT NULL REFERENCES Type_Season (ID_Code_Type_Season),
 Code_Model_ID INT NOT NULL REFERENCES Model (ID_Code_Model),
 Code_Type_Product_ID INT NOT NULL REFERENCES Type_Product (ID_Code_Type_Product)
 );
 CREATE TABLE Bank_card_details (
 ID_Code_bank_card_details SERIAL NOT NULL PRIMARY KEY,
 Numbers INT NOT NULL,
 Code_Buyer_ID INT NOT NULL REFERENCES Buyer (ID_Code_Buyer)
 );
 CREATE TABLE Orders (
 ID_Code_Orders SERIAL NOT NULL PRIMARY KEY,
 Number_Orders INT NOT NULL,
 Total_Price DECIMAL(38,2) NULL DEFAULT 0.0 CHECK (Total_Price >= 0.0),
 Code_bank_card_details_ID INT NOT NULL REFERENCES Bank_card_details (ID_Code_bank_card_details),
 Code_Courier_ID INT NOT NULL REFERENCES Courier (ID_Code_Courier)
 );
 CREATE TABLE Marriage_Fixation (
 ID_Code_Marriage_Fixation SERIAL NOT NULL PRIMARY KEY,
 Date_Time_Marriage_Fixation DATE NULL,
 Code_Orders_ID INT NOT NULL REFERENCES Orders (ID_Code_Orders)
 );
 CREATE TABLE Structured (
 ID_Code_Structured SERIAL NOT NULL PRIMARY KEY,
 Title_Structured VARCHAR(30) NOT NULL,
 Code_Product_ID INT NOT NULL REFERENCES Product (ID_Code_Product),
 Code_Orders_ID INT NOT NULL REFERENCES Orders (ID_Code_Orders)
 );
 CREATE TABLE Estimate (
 ID_Code_Estimate SERIAL NOT NULL PRIMARY KEY,
 Estimate_Number INT NOT NULL,
 Contract_Number_Estimate INT NOT NULL,
 Code_Employer_ID INT NOT NULL REFERENCES Employer (ID_Code_Employer)
 );

CREATE TABLE Act (
 ID_Code_Act SERIAL NOT NULL PRIMARY KEY,
 Numbers INT NOT NULL,
 Date_Time_Act DATE,
 Code_Estimate_ID INT NOT NULL REFERENCES Estimate(ID_Code_Estimate),
 Code_Product_ID INT NOT NULL REFERENCES Product (ID_Code_Product)
 );
 CREATE TABLE Reception ( 
 ID_Code_Reception SERIAL NOT NULL PRIMARY KEY,
 Contract_Number_Reception INT NOT NULL,
 Email_Address VARCHAR(255) NOT NULL,
 Telephone VARCHAR(19) NOT NULL,
 UNIQUE KEY UQ_Telephone (Telephone), CHECK (Telephone REGEXP '^\\+7\\([0-9]{3}\\)[0-9]{3} [0-9]{2} [0-9]{2}$'),
 Code_Estimate_ID INT NOT NULL REFERENCES Estimate(ID_Code_Estimate),
 Code_Product_ID INT NOT NULL REFERENCES Product (ID_Code_Product)
 );
 CREATE TABLE Sale (
 ID_Code_Sale INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
 Receipt_Number INT NOT NULL,
 Date_Time_Sale DATE,
 Code_bank_card_details_ID INT NOT NULL REFERENCES Bank_card_details (ID_Code_bank_card_details),
 Code_Estimate_ID INT NOT NULL REFERENCES Estimate(ID_Code_Estimate),
 Code_Product_ID INT NOT NULL REFERENCES Product (ID_Code_Product)
 );

SELECT count(*) FROM information_schema.tables
where table_schema= 'Sale_Shoes_Database' and table_type='BASE TABLE';

SELECT table_name, count(column_Name) FROM information_schema.columns
where table_schema= 'Sale_Shoes_Database'
group by table_name;

Insert into type_Shoes(Title_Type_Shoes) VALUES ('Зимняя'), ('Летняя'), ('Осенняя'), ('Весенняя');
SELECT Title_Type_Shoes as "Название типа обуви" from type_shoes order by Title_Type_Shoes ASC;

Insert into Buyer(Name_Buyer,Surname_Buyer,Adress,CVV,Contact_Phone_Number, Email_Addres) VALUES ('Денис', 'Юсупов', 'Дверная 6/6',  '02.10.2005', '132', '+7(912)333 44 22', 'denisusupov228@gmail.com'), ('Азамат', 'Юсупов', 'Гайкина 6/6',  '02.09.2003', '155', '+7(126)393 44 22', 'enisusupov300@gmail.com'), ('Даня', 'Ботов', 'Забивная',  '03.10.2012', '666', '+7(912)395 43 22', 'nescam228@gmail.com'), ('Артем', 'Дербий', 'Вереновы 11',  '11.11.2014', '777', '+7(666)633 44 22', 'gosuslugi12@gmail.com');
Select Name_Buyer as "Имя покупателя", Surname_Buyer as "Фамилия покупателя", End_Date as "Конечный адресс", CVV as "ЦВВ", Contact_Phone_Number as "Контактный телефон", Email_Addres as "Емаил адресс" from Buyer order by Name_Buyer ASC;

Insert into Type_Season(Title_Season) VALUES('Первый'), ('Второй'), ('Третий'), ('Четвертый');
Select Title_Season as "Название сезона" from Type_Season order by Title_Season ASC;

Insert into Type_Product (Quantity_Type_Product) VALUES (13),(15),(16),(17);
Select Quantity_Type_Product as "Количество" from Type_Product order by Quantity_Type_Product ASC;

Insert into Manufacturer(Title_Manufacturer) VALUES('ООО Дирижабль'), ('ООО Светение'), ('ООО Лупа'), ('ООО Ткани');
Select Title_Manufacturer as "Название Производителя" from Manufacturer order by Title_Manufacturer ASC;

Insert into Courier(Where_From_Couriel, Where_Courier, Formation_Act) VALUES ('Ленина 51', 'Мельникова 1/2','334521351'),('Римская 91', 'Шакалова 33','555334123'),('Каралева 8/10', 'Замосковье 2','132435465'),('Винная 3', 'Межмкадная 3','127893111');
Select Formation_Act as "Номер акта", Where_From_Couriel as "Откуда", Where_Courier as "Куда" from Courier order by Formation_Act ASC;

Insert into Employer(Name_Employer, Surname_Employer) VALUES ('Вася', 'Ребельцов'),('Петя', 'Петров'),('Рузвель', 'Паганини'),('Даня', 'Данилов');
Select Name_Employer as "Имя работника", Surname_Employer as "Фамилия работника" from Employer order by Name_Employer ASC;

Insert into Model(Sizes,Image,Quantity_Model,Warranty_Period,Code_Manufacturer_ID,Code_Employer_ID) VALUES ('35','fqwerrq12','11','14','1','1'),('36','gqwefdsa','103','28','2','2'),('37','fqblwebglq','23','7','3','3'),('38','fgggggg12','14','14','4','4');
Select Quantity_Model as "Количество обуви", Sizes as "Размер", Image as "Картинка обуви", Warranty_Period as "Гарантийный срок" from Model inner join Manufacturer on Code_Manufacturer_ID = ID_Code_Manufacturer inner join Employer on Code_Employer_ID = ID_Code_Employer order by Quantity_Model ASC;

Insert into Product(Amount_Product,Title_Product,Quantity_Product,Code_Type_Shoes_ID,Code_Type_Season_ID,Code_Model_ID,Code_Type_Product_ID) VALUES('1000','Лабутены','12','1','1','1','1'),('2000','Дольчегабана','13','2','2','2','2'),('3100','Баленсиага','16','3','3','3','3'),('10000','Гуччишуси','100','4','4','4','4');
Select  Title_Product as "Название продукта", Amount_Product as "Цена продукта", Quantity_Product as "Количество продукта" from Product inner join Type_Shoes on Code_Type_Shoes_ID = ID_Code_Type_Shoes inner join Type_Season on Code_Type_Season_ID = ID_Code_Type_Season inner join Model on Code_Model_ID = ID_Code_Model inner join Type_Product on Code_Type_Product_ID = ID_Code_Type_Product order by Title_Product ASC;

Insert into Bank_card_details(Numbers,Code_Buyer_ID) VALUES ('45345658','1'), ('45341158','2'), ('11345658','2'), ('11345658','2');
Select Numbers as "Номер банковской карты" from Bank_card_details inner join Buyer on Code_Buyer_ID = ID_Code_Buyer order by Numbers ASC;

Insert into Orders(Number_Orders,Total_Price,Code_bank_card_details_ID,Code_Courier_ID) VALUES('1324','123.2','1','1'),('1124','1233.54','2','2'),('1024','2223.5','3','3'),('924','999.11','4','4');
Select Number_Orders as "Номер Заказа", Total_Price as "Итоговая цена" from Orders inner join bank_card_details on Code_bank_card_details_ID = ID_Code_bank_card_details inner join Courier on Code_Courier_ID = ID_Code_Courier order by Number_Orders ASC;

Insert into Marriage_Fixation(Date_Time_Marriage_Fixation,Code_Orders_ID)VALUES('12.10.2000','1'),('13.10.2000','2'),('14.10.2000','3'),('15.10.2000','4');
Select Date_Time_Marriage_Fixation as "Время" from Marriage_Fixation inner join Orders on Code_Orders_ID = ID_Code_Orders order by Date_Time_Marriage_Fixation ASC;

Insert into Structured(Title_Structured, Code_Product_ID, Code_Orders_ID) VALUES('ООО вишня','1','1'),('ООО грозамоды','2','2'),('ООО винтаж','3','3'),('ООО вишня','4','4');
Select Title_Structured as "Название структуры" from Structured inner join Product on Code_Product_ID = ID_Code_Product inner join Orders on Code_Orders_ID = ID_Code_Orders order by Title_Structured ASC;

Insert into Estimate(Estimate_Number,Contract_Number_Estimate,Code_Employer_ID) VALUES('1999','1230','1'),('12444','1231','2'),('9263','1232','3'),('144','1233','4');
Select Estimate_Number as "Номер сметы",Contract_Number_Estimate as "Номер контракта" from Estimate inner join Employer on Code_Employer_ID = ID_Code_Employer order by Estimate_Number ASC;

Insert into Act(Numbers, Date_Time_Act, Code_Estimate_ID, Code_Product_ID) VALUES('13636','2016.10.19','1','1'),('13635','2016.11.20','2','2'),('13634','2016.10.21','3','3'),('13637','2016.11.25','4','4');
Select Numbers as "Номер акта", Date_Time_Act as "Дата акта" from Act inner join Estimate on Code_Estimate_ID = ID_Code_Estimate inner join Product on Code_Product_ID = ID_Code_Product order by Date_Time_Act ASC;

Insert into Reception(Contract_Number_Reception, Email_Address, Telephone, Code_Estimate_ID, Code_Product_ID) VALUES ('1000011','denisusupov333@gmail.com','+7(918)911 12 22','1','1'),('1000012','denisusupov123@gmail.com','+7(910)111 12 22','2','2'),('1000010','denisusupov999@gmail.com','+7(912)555 35 35','3','3'),('1000013','deniv113@gmail.com','+7(925)512 82 32','4','4');
Select Contract_Number_Reception as "Номер контракта", Email_Address as "Электронная почта", Telephone as "Номер телефона" from Reception inner join Estimate on Code_Estimate_ID = ID_Code_Estimate inner join Product on Code_Product_ID = ID_Code_Product order by Contract_Number_Reception ASC;

Insert into Sale(Receipt_Number, Date_Time_Sale, Code_bank_card_details_ID, Code_Product_ID,Code_Estimate_ID) VALUES ('100','11.05.2023','1','1','1'),('101','12.05.2023','2','2','2'),('106','14.05.2023','3','3','3'),('999','13.05.2023','4','4','4');
Select Receipt_Number as "Номер чека", Date_Time_Sale as "Дата продажи" from Sale inner join Bank_Card_details on Code_bank_card_details_ID = ID_Code_Bank_Card_details inner join Product on Code_Product_ID = ID_Code_Product inner join Estimate on Code_Estimate_ID = ID_Code_Estimate order by Receipt_Number ASC;

update Type_Shoes set Title_Type_Shoes = 'Бархатный' where ID_Code_Type_Shoes = 2;
delete from Type_Shoes where ID_Code_Type_Shoes = 3;

update Type_Season set Title_Season = 'Пятый' where ID_Code_Type_Season = 1;
delete from Type_Season where ID_Code_Type_Season = 1;

update Employer set Name_Employer = 'Виталий' where ID_Code_Employer = 3;
delete from Employer where ID_Code_Employer = 2;

update Courier set Formation_Act = '335676' where ID_Code_Courier = 1;
delete from Courier where ID_Code_Courier = 1;

update Sale set Receipt_Number = '12' where ID_Code_Sale = 2;
delete from Sale where ID_Code_Sale = 1;

SELECT Title_Type_Shoes as "Название типа обуви" from type_shoes where Title_Type_Shoes like '%яя';

Select Name_Employer as "Имя работника", Surname_Employer as "Фамилия работника" from Employer where Name_Employer like '%я';

Select Title_Season as "Название сезона" from Type_Season where Title_Season like '%ый';

create or replace view Shoes_Market_Place_List
as
	select Title_Product as "Название продукта", Title_Season as "Название сезона", Warranty_Period as "Название модели", Title_Type_Shoes as "Название типа обуви", Quantity_Product as "Количество", Amount_Product as "Стоимость" from Product
		inner join Type_Shoes on Code_Type_Shoes_ID = ID_Code_Type_Shoes 
		inner join Type_Season on Code_Type_Season_ID = ID_Code_Type_Season
		inner join Model on Code_Model_ID = ID_Code_Model
		inner join Type_Product on Code_Type_Product_ID = ID_Code_Type_Product;
select * from Shoes_Market_Place_List;

create or replace view Shoes_Buy_List
as
	select Number_Orders as "Номер заказа", Total_Price as "Итоговая цена", Where_From_Couriel as "Откуда доставка", Where_Courier as "Куда доставка", Formation_Act as "Номер акта", Numbers as "Номер карты покупателя" from Orders
		inner join bank_card_details on Code_bank_card_details_ID = ID_Code_bank_card_details
		inner join Courier on Code_Courier_ID = ID_Code_Courier;
select * from Shoes_Buy_List;

create or replace view Shoes_Person_Info
as
	select Name_Buyer as "Имя покупателя", Surname_Buyer as "Фамилия покупателя", End_Date as "Дата доставки",Contact_Phone_Number as "Контактный телефон", Email_Addres as "Адрес элк.почты", CVV as "ЦВВ код", Numbers as "Номер банковской карты" from Bank_card_details
		inner join Buyer on Code_Buyer_ID = ID_Code_Buyer;
select * from Shoes_Person_Info;

create or replace view Shoes_Remove_List
as
	select Title_Structured as "Название компании", Title_Product as "Название продукции", Quantity_Product as "Количество продукции", Amount_Product as "Цента продукции" from Structured
	inner join Product on Code_Product_ID = ID_Code_Product
	inner join Orders on Code_Orders_ID = ID_Code_Orders;
select * from Shoes_Remove_List;

create or replace view New_Buyer_Sale_List
as
	select Estimate_Number as "Номер сметы",Contract_Number_Estimate as "Номер контракта", Name_Employer as "Имя работника", Surname_Employer as "Фамилия работника" from Estimate 
	inner join Employer on Code_Employer_ID = ID_Code_Employer;
select * from New_Buyer_Sale_List;	

create or replace view Finished_Sale_Check_List
as
	Select Receipt_Number as "Номер чека", Estimate_Number as "Номер сметы", Contract_Number_Estimate as "Номер контракта", Date_Time_Sale as "Дата продажи", Numbers as "Номер банковской карты", Title_Product as "Название продукции", Amount_Product as "Цена продукции", Quantity_Product as "Количество продукции" from Sale
	inner join Bank_Card_details on Code_bank_card_details_ID = ID_Code_Bank_Card_details
	inner join Product on Code_Product_ID = ID_Code_Product
	inner join Estimate on Code_Estimate_ID = ID_Code_Estimate;
select * from Finished_Sale_Check_List;

SELECT  count(*) FROM information_schema.tables 
where table_schema = 'sale_shoes_database' and table_type = 'VIEW';



DELIMITER //
CREATE PROCEDURE Type_Shoes_insert (IN p_Title_Type_Shoes VARCHAR(30))
BEGIN
	INSERT INTO Type_Shoes (Title_Type_Shoes)
	VALUES (p_Title_Type_Shoes);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Type_Shoes_update (IN p_ID_Code_Type_Shoes INT, IN p_Title_Type_Shoes VARCHAR(30))
BEGIN
	UPDATE Type_Shoes
	SET Title_Type_Shoes = p_Title_Type_Shoes
	WHERE ID_Code_Type_Shoes = p_ID_Code_Type_Shoes;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Type_Shoes_delete (IN p_ID_Code_Type_Shoes INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Product
	WHERE Code_Type_Shoes_ID = p_ID_Code_Type_Shoes;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Тип обуви не может быть удален, так как в таблице "Product" есть связанные данные!';
	ELSE
		DELETE FROM Type_Shoes
		WHERE ID_Code_Type_Shoes = p_ID_Code_Type_Shoes;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Buyer_insert (IN p_Name_Buyer VARCHAR(30),IN p_Surname_Buyer VARCHAR(30),IN p_Adress VARCHAR(30),IN p_End_Date DATE,IN p_CVV INT,IN p_Contact_Phone_Number VARCHAR(19),IN p_Email_Addres VARCHAR(30))
BEGIN
	INSERT INTO Buyer (Name_Buyer, Surname_Buyer, Adress, End_Date, CVV, Contact_Phone_Number, Email_Addres)
	VALUES (p_Name_Buyer, p_Surname_Buyer, p_Adress, p_End_Date, p_CVV, p_Contact_Phone_Number, p_Email_Addres);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Buyer_update (IN p_ID_Code_Buyer INT,IN p_Name_Buyer VARCHAR(30),IN p_Surname_Buyer VARCHAR(30),IN p_Adress VARCHAR(30),IN p_End_Date DATE,IN p_CVV INT,IN p_Contact_Phone_Number VARCHAR(19),IN p_Email_Addres VARCHAR(30))
BEGIN
	UPDATE Buyer
	SET
		Name_Buyer = p_Name_Buyer,
		Surname_Buyer = p_Surname_Buyer,
		Adress = p_Adress,
		End_Date = p_End_Date,
		CVV = p_CVV,
		Contact_Phone_Number = p_Contact_Phone_Number,
		Email_Addres = p_Email_Addres
	WHERE ID_Code_Buyer = p_ID_Code_Buyer;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Buyer_delete (IN p_ID_Code_Buyer INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Bank_card_details
	WHERE Code_Buyer_ID = p_ID_Code_Buyer;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Тип обуви не может быть удален, так как в таблице "Bank_card_details" есть связанные данные!';
	ELSE
		DELETE FROM Buyer
		WHERE ID_Code_Buyer = p_ID_Code_Buyer;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Type_Season_insert (IN p_Title_Season VARCHAR(30))
BEGIN
	INSERT INTO Type_Season (Title_Season)
	VALUES (p_Title_Season);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Type_Season_update (IN p_ID_Code_Type_Season INT, IN p_Title_Season VARCHAR(30))
BEGIN
	UPDATE Type_Season
	SET Title_Season = p_Title_Season
	WHERE ID_Code_Type_Season = p_ID_Code_Type_Season;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Type_Season_delete (IN p_ID_Code_Type_Season INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Product
	WHERE Type_Season_ID = p_ID_Code_Type_Season;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Тип сезона не может быть удален, так как в таблице "Product" есть связанные данные!';
	ELSE
		DELETE FROM Type_Season
		WHERE ID_Code_Type_Season = p_ID_Code_Type_Season;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Type_Product_insert (IN p_Quantity_Type_Product INT)
BEGIN
	INSERT INTO Type_Product (Quantity_Type_Product)
	VALUES (p_Quantity_Type_Product);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Type_Product_update (IN p_ID_Code_Type_Product INT, IN p_Quantity_Type_Product INT)
BEGIN
	UPDATE Type_Product
	SET Quantity_Type_Product = p_Quantity_Type_Product
	WHERE ID_Code_Type_Product = p_ID_Code_Type_Product;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Type_Product_delete (IN p_ID_Code_Type_Product INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Product
	WHERE Type_Product_ID = p_ID_Code_Type_Product;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Тип продукта не может быть удален, так как в таблице "Product" есть связанные данные!';
	ELSE
		DELETE FROM Type_Product
		WHERE ID_Code_Type_Product = p_ID_Code_Type_Product;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Manufacturer_insert (IN p_Title_Manufacturer VARCHAR(30))
BEGIN
	INSERT INTO Manufacturer (Title_Manufacturer)
	VALUES (p_Title_Manufacturer);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Manufacturer_update (IN p_ID_Code_Manufacturer INT, IN p_Title_Manufacturer VARCHAR(30))
BEGIN
	UPDATE Manufacturer
	SET Title_Manufacturer = p_Title_Manufacturer
	WHERE ID_Code_Manufacturer = p_ID_Code_Manufacturer;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Manufacturer_delete (IN p_ID_Code_Manufacturer INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Model
	WHERE Manufacturer_ID = p_ID_Code_Manufacturer;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Производитель не может быть удален, так как в таблице "Model" есть связанные данные!';
	ELSE
		DELETE FROM Manufacturer
		WHERE ID_Code_Manufacturer = p_ID_Code_Manufacturer;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Courier_insert (
	IN p_Where_From_Courier VARCHAR(30),
	IN p_Where_Courier VARCHAR(30),
	IN p_Formation_Act INT
)
BEGIN
	INSERT INTO Courier (Where_From_Courier, Where_Courier, Formation_Act)
	VALUES (p_Where_From_Courier, p_Where_Courier, p_Formation_Act);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Courier_update (
	IN p_ID_Code_Courier INT,
	IN p_Where_From_Courier VARCHAR(30),
	IN p_Where_Courier VARCHAR(30),
	IN p_Formation_Act INT
)
BEGIN
	UPDATE Courier
	SET
		Where_From_Courier = p_Where_From_Courier,
		Where_Courier = p_Where_Courier,
		Formation_Act = p_Formation_Act
	WHERE ID_Code_Courier = p_ID_Code_Courier;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Courier_delete (IN p_ID_Code_Courier INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Orders
	WHERE Courier_ID = p_ID_Code_Courier;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Курьер не может быть удален, так как в таблице "Orders" есть связанные данные!';
	ELSE
		DELETE FROM Courier
		WHERE ID_Code_Courier = p_ID_Code_Courier;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Employer_insert (
	IN p_Name_Employer VARCHAR(30),
	IN p_Surname_Employer VARCHAR(30)
)
BEGIN
	INSERT INTO Employer (Name_Employer, Surname_Employer)
	VALUES (p_Name_Employer, p_Surname_Employer);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Employer_update (
	IN p_ID_Code_Employer INT,
	IN p_Name_Employer VARCHAR(30),
	IN p_Surname_Employer VARCHAR(30)
)
BEGIN
	UPDATE Employer
	SET
		Name_Employer = p_Name_Employer,
		Surname_Employer = p_Surname_Employer
	WHERE ID_Code_Employer = p_ID_Code_Employer;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Employer_delete (IN p_ID_Code_Employer INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Model
	WHERE Employer_ID = p_ID_Code_Employer;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Работник не может быть удален, так как в таблице "Model" есть связанные данные!';
	ELSE
		DELETE FROM Employer
		WHERE ID_Code_Employer = p_ID_Code_Employer;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Model_insert (
	IN p_Sizes INT,
	IN p_Image VARCHAR(30),
	IN p_Quantity_Model INT,
	IN p_Warranty_Period INT,
	IN p_Code_Manufacturer_ID INT,
	IN p_Code_Employer_ID INT
)
BEGIN
	INSERT INTO Model (Sizes, Image, Quantity_Model, Warranty_Period, Code_Manufacturer_ID, Code_Employer_ID)
	VALUES (p_Sizes, p_Image, p_Quantity_Model, p_Warranty_Period, p_Code_Manufacturer_ID, p_Code_Employer_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Model_update (
	IN p_ID_Code_Model INT,
	IN p_Sizes INT,
	IN p_Image VARCHAR(30),
	IN p_Quantity_Model INT,
	IN p_Warranty_Period INT,
	IN p_Code_Manufacturer_ID INT,
	IN p_Code_Employer_ID INT
)
BEGIN
	UPDATE Model
	SET
		Sizes = p_Sizes,
		Image = p_Image,
		Quantity_Model = p_Quantity_Model,
		Warranty_Period = p_Warranty_Period,
		Code_Manufacturer_ID = p_Code_Manufacturer_ID,
		Code_Employer_ID = p_Code_Employer_ID
	WHERE ID_Code_Model = p_ID_Code_Model;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Model_delete (IN p_ID_Code_Model INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Product
	WHERE Model_ID = p_ID_Code_Model;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Модель не может быть удалена, так как в таблице "Product" есть связанные данные!';
	ELSE
		DELETE FROM Model
		WHERE ID_Code_Model = p_ID_Code_Model;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Product_insert (
	IN p_Amount_Product INT,
	IN p_Title_Product VARCHAR(30),
	IN p_Quantity_Product INT,
	IN p_Code_Type_Shoes_ID INT,
	IN p_Code_Type_Season_ID INT,
	IN p_Code_Model_ID INT,
	IN p_Code_Type_Product_ID INT
)
BEGIN
	INSERT INTO Product (Amount_Product, Title_Product, Quantity_Product, Code_Type_Shoes_ID, Code_Type_Season_ID, Code_Model_ID, Code_Type_Product_ID)
	VALUES (p_Amount_Product, p_Title_Product, p_Quantity_Product, p_Code_Type_Shoes_ID, p_Code_Type_Season_ID, p_Code_Model_ID, p_Code_Type_Product_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Product_update (
	IN p_ID_Code_Product INT,
	IN p_Amount_Product INT,
	IN p_Title_Product VARCHAR(30),
	IN p_Quantity_Product INT,
	IN p_Code_Type_Shoes_ID INT,
	IN p_Code_Type_Season_ID INT,
	IN p_Code_Model_ID INT,
	IN p_Code_Type_Product_ID INT
)
BEGIN
	UPDATE Product
	SET
		Amount_Product = p_Amount_Product,
		Title_Product = p_Title_Product,
		Quantity_Product = p_Quantity_Product,
		Code_Type_Shoes_ID = p_Code_Type_Shoes_ID,
		Code_Type_Season_ID = p_Code_Type_Season_ID,
		Code_Model_ID = p_Code_Model_ID,
		Code_Type_Product_ID = p_Code_Type_Product_ID
	WHERE ID_Code_Product = p_ID_Code_Product;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Product_delete (IN p_ID_Code_Product INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Structured
	WHERE Product_ID = p_ID_Code_Product;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Продукт не может быть удален, так как в таблице "Structured" есть связанные данные!';
	ELSE
		DELETE FROM Product
		WHERE ID_Code_Product = p_ID_Code_Product;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Bank_card_details_insert (
	IN p_Numbers INT,
	IN p_Code_Buyer_ID INT
)
BEGIN
	INSERT INTO Bank_card_details (Numbers, Code_Buyer_ID)
	VALUES (p_Numbers, p_Code_Buyer_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Bank_card_details_update (
	IN p_ID_Code_bank_card_details INT,
	IN p_Numbers INT,
	IN p_Code_Buyer_ID INT
)
BEGIN
	UPDATE Bank_card_details
	SET
		Numbers = p_Numbers,
		Code_Buyer_ID = p_Code_Buyer_ID
	WHERE ID_Code_bank_card_details = p_ID_Code_bank_card_details;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Bank_card_details_delete (IN p_ID_Code_bank_card_details INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Orders
	WHERE Bank_card_details_ID = p_ID_Code_bank_card_details;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Детали банковской карты не могут быть удалены, так как в таблице "Orders" есть связанные данные!';
	ELSE
		DELETE FROM Bank_card_details
		WHERE ID_Code_bank_card_details = p_ID_Code_bank_card_details;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Orders_insert (
	IN p_Number_Orders INT,
	IN p_Total_Price DECIMAL(38,2),
	IN p_Code_bank_card_details_ID INT,
	IN p_Code_Courier_ID INT
)
BEGIN
	INSERT INTO Orders (Number_Orders, Total_Price, Code_bank_card_details_ID, Code_Courier_ID)
	VALUES (p_Number_Orders, p_Total_Price, p_Code_bank_card_details_ID, p_Code_Courier_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Orders_update (
	IN p_ID_Code_Orders INT,
	IN p_Number_Orders INT,
	IN p_Total_Price DECIMAL(38,2),
	IN p_Code_bank_card_details_ID INT,
	IN p_Code_Courier_ID INT
)
BEGIN
	UPDATE Orders
	SET
		Number_Orders = p_Number_Orders,
		Total_Price = p_Total_Price,
		Code_bank_card_details_ID = p_Code_bank_card_details_ID,
		Code_Courier_ID = p_Code_Courier_ID
	WHERE ID_Code_Orders = p_ID_Code_Orders;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Orders_delete (IN p_ID_Code_Orders INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Marriage_Fixation
	WHERE Orders_ID = p_ID_Code_Orders;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Заказ не может быть удален, так как в таблице "Marriage_Fixation" есть связанные данные!';
	ELSE
		DELETE FROM Orders
		WHERE ID_Code_Orders = p_ID_Code_Orders;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Marriage_Fixation_insert (
	IN p_Date_Time_Marriage_Fixation DATE,
	IN p_Code_Orders_ID INT
)
BEGIN
	INSERT INTO Marriage_Fixation (Date_Time_Marriage_Fixation, Code_Orders_ID)
	VALUES (p_Date_Time_Marriage_Fixation, p_Code_Orders_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Marriage_Fixation_update (
	IN p_ID_Code_Marriage_Fixation INT,
	IN p_Date_Time_Marriage_Fixation DATE,
	IN p_Code_Orders_ID INT
)
BEGIN
	UPDATE Marriage_Fixation
	SET
		Date_Time_Marriage_Fixation = p_Date_Time_Marriage_Fixation,
		Code_Orders_ID = p_Code_Orders_ID
	WHERE ID_Code_Marriage_Fixation = p_ID_Code_Marriage_Fixation;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Marriage_Fixation_delete (IN p_ID_Code_Marriage_Fixation INT)
BEGIN
	DELETE FROM Marriage_Fixation
	WHERE ID_Code_Marriage_Fixation = p_ID_Code_Marriage_Fixation;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Structured_insert (
	IN p_Title_Structured VARCHAR(30),
	IN p_Code_Product_ID INT,
	IN p_Code_Orders_ID INT
)
BEGIN
	INSERT INTO Structured (Title_Structured, Code_Product_ID, Code_Orders_ID)
	VALUES (p_Title_Structured, p_Code_Product_ID, p_Code_Orders_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Structured_update (
	IN p_ID_Code_Structured INT,
	IN p_Title_Structured VARCHAR(30),
	IN p_Code_Product_ID INT,
	IN p_Code_Orders_ID INT
)
BEGIN
	UPDATE Structured
	SET
		Title_Structured = p_Title_Structured,
		Code_Product_ID = p_Code_Product_ID,
		Code_Orders_ID = p_Code_Orders_ID
	WHERE ID_Code_Structured = p_ID_Code_Structured;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Structured_delete (IN p_ID_Code_Structured INT)
BEGIN
	DELETE FROM Structured
	WHERE ID_Code_Structured = p_ID_Code_Structured;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Estimate_insert (
	IN p_Estimate_Number INT,
	IN p_Contract_Number_Estimate INT,
	IN p_Code_Employer_ID INT
)
BEGIN
	INSERT INTO Estimate (Estimate_Number, Contract_Number_Estimate, Code_Employer_ID)
	VALUES (p_Estimate_Number, p_Contract_Number_Estimate, p_Code_Employer_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Estimate_update (
	IN p_ID_Code_Estimate INT,
	IN p_Estimate_Number INT,
	IN p_Contract_Number_Estimate INT,
	IN p_Code_Employer_ID INT
)
BEGIN
	UPDATE Estimate
	SET
		Estimate_Number = p_Estimate_Number,
		Contract_Number_Estimate = p_Contract_Number_Estimate,
		Code_Employer_ID = p_Code_Employer_ID
	WHERE ID_Code_Estimate = p_ID_Code_Estimate;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Estimate_delete (IN p_ID_Code_Estimate INT)
BEGIN
	DECLARE p_any_child_record INT;
	SELECT COUNT(*) INTO p_any_child_record FROM Act
	WHERE Estimate_ID = p_ID_Code_Estimate;
	
	IF (p_any_child_record > 0) THEN
		SELECT 'Смета не может быть удалена, так как в таблице "Act" есть связанные данные!';
	ELSE
		DELETE FROM Estimate
		WHERE ID_Code_Estimate = p_ID_Code_Estimate;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Act_insert (
	IN p_Numbers INT,
	IN p_Date_Time_Act DATE,
	IN p_Code_Estimate_ID INT,
	IN p_Code_Product_ID INT
)
BEGIN
	INSERT INTO Act (Numbers, Date_Time_Act, Code_Estimate_ID, Code_Product_ID)
	VALUES (p_Numbers, p_Date_Time_Act, p_Code_Estimate_ID, p_Code_Product_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Act_update (
	IN p_ID_Code_Act INT,
	IN p_Numbers INT,
	IN p_Date_Time_Act DATE,
	IN p_Code_Estimate_ID INT,
	IN p_Code_Product_ID INT
)
BEGIN
	UPDATE Act
	SET
		Numbers = p_Numbers,
		Date_Time_Act = p_Date_Time_Act,
		Code_Estimate_ID = p_Code_Estimate_ID,
		Code_Product_ID = p_Code_Product_ID
	WHERE ID_Code_Act = p_ID_Code_Act;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Act_delete (IN p_ID_Code_Act INT)
BEGIN
	DELETE FROM Act
	WHERE ID_Code_Act = p_ID_Code_Act;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Reception_insert (
	IN p_Contract_Number_Reception INT,
	IN p_Email_Address VARCHAR(255),
	IN p_Telephone VARCHAR(19),
	IN p_Code_Estimate_ID INT,
	IN p_Code_Product_ID INT
)
BEGIN
	INSERT INTO Reception (Contract_Number_Reception, Email_Address, Telephone, Code_Estimate_ID, Code_Product_ID)
	VALUES (p_Contract_Number_Reception, p_Email_Address, p_Telephone, p_Code_Estimate_ID, p_Code_Product_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Reception_update (
	IN p_ID_Code_Reception INT,
	IN p_Contract_Number_Reception INT,
	IN p_Email_Address VARCHAR(255),
	IN p_Telephone VARCHAR(19),
	IN p_Code_Estimate_ID INT,
	IN p_Code_Product_ID INT
)
BEGIN
	UPDATE Reception
	SET
		Contract_Number_Reception = p_Contract_Number_Reception,
		Email_Address = p_Email_Address,
		Telephone = p_Telephone,
		Code_Estimate_ID = p_Code_Estimate_ID,
		Code_Product_ID = p_Code_Product_ID
	WHERE ID_Code_Reception = p_ID_Code_Reception;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Reception_delete (IN p_ID_Code_Reception INT)
BEGIN
	DELETE FROM Reception
	WHERE ID_Code_Reception = p_ID_Code_Reception;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Sale_insert (
	IN p_Receipt_Number INT,
	IN p_Date_Time_Sale DATE,
	IN p_Code_bank_card_details_ID INT,
	IN p_Code_Estimate_ID INT,
	IN p_Code_Product_ID INT
)
BEGIN
	INSERT INTO Sale (Receipt_Number, Date_Time_Sale, Code_bank_card_details_ID, Code_Estimate_ID, Code_Product_ID)
	VALUES (p_Receipt_Number, p_Date_Time_Sale, p_Code_bank_card_details_ID, p_Code_Estimate_ID, p_Code_Product_ID);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Sale_update (
	IN p_ID_Code_Sale INT,
	IN p_Receipt_Number INT,
	IN p_Date_Time_Sale DATE,
	IN p_Code_bank_card_details_ID INT,
	IN p_Code_Estimate_ID INT,
	IN p_Code_Product_ID INT
)
BEGIN
	UPDATE Sale
	SET
		Receipt_Number = p_Receipt_Number,
		Date_Time_Sale = p_Date_Time_Sale,
		Code_bank_card_details_ID = p_Code_bank_card_details_ID,
		Code_Estimate_ID = p_Code_Estimate_ID,
		Code_Product_ID = p_Code_Product_ID
	WHERE ID_Code_Sale = p_ID_Code_Sale;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Sale_delete (IN p_ID_Code_Sale INT)
BEGIN
	DELETE FROM Sale
	WHERE ID_Code_Sale = p_ID_Code_Sale;
END //
DELIMITER ;

SELECT  count(*) FROM information_schema.routines 
where routine_schema = 'sale_shoes_database' and routine_type = 'PROCEDURE';

call Type_Season_insert ('Шестой');
select * from Type_Season;

call Type_Shoes_delete (1);
select * from Type_shoes;
call Type_Season_delete (5);
select * from Type_Season;
call Sale_delete (4);
select * from Sale;

call Employer_insert(' ');
select * from Employer;