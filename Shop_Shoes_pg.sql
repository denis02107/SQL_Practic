Create table Type_Shoes
(
	ID_Code_Type_Shoes Serial not null constraint PK_Type_Shoes primary key,
	Title_Type_Shoes varchar not null CONSTRAINT UQ_Title UNIQUE
);

Create table Buyer
(
	ID_Code_Buyer Serial not null constraint PK_Buyer primary key,
	Name_Buyer varchar  not null,
	Surname_Buyer varchar not null,
	Adress varchar not null,
	End_Date DATE null DEFAULT(CURRENT_DATE),
	CVV int not null CONSTRAINT CH_CVV CHECK (CVV>0),
	Contact_Phone_Number varchar(19) not null CONSTRAINT UQ_Contact_Phone_Number UNIQUE
	CONSTRAINT CH_Contact_Phone_Number CHECK (Contact_Phone_Number similar to '\+7\([0-9]{3}\)[0-9]{3} [0-9]{2} [0-9]{2}'),
	Email_Addres varchar not null CONSTRAINT UQ_Email_Addres UNIQUE
);

Create table Type_Season
(
	ID_Code_Type_Season Serial not null constraint PK_Type_Season primary key,
	Title_Season varchar not null CONSTRAINT UQ_Title_Season UNIQUE
);
 
Create table Type_Product
(
	ID_Code_Type_Product Serial not null constraint PK_Type_Product primary key,
	Quantity_Type_Product int not null
);
 
Create table Manufacturer
(
	ID_Code_Manufacturer Serial not null constraint PK_Manufacturer primary key,
	Title_Manufacturer varchar not null
);
Create table Courier
(
	ID_Code_Courier Serial not null constraint PK_Courier primary key,
	Where_From_Couriel varchar not null,
	Where_Courier varchar not null,
	Formation_Act int not null 
);
Create table Employer
(
	ID_Code_Employer Serial not null constraint PK_Employer primary key,
	Name_Employer varchar not null,
	Surname_Employer varchar not null
);

/*  Все что выше это база */
Create table Model
(
	ID_Code_Model Serial not null constraint PK_Model primary key,
	Sizes INT not null,
	Image varchar not null,
	Quantity_Model INT not null,
	Warranty_Period INT not null,
	Code_Manufacturer_ID INT not null REFERENCES Manufacturer (ID_Code_Manufacturer),
	Code_Employer_ID INT not null REFERENCES Employer (ID_Code_Employer)
);

Create table Product
(
	ID_Code_Product Serial not null constraint PK_Product primary key,
	Amount_Product INT not null,
	Title_Product varchar not null,
	Quantity_Product INT not null,
	Code_Type_Shoes_ID INT not null REFERENCES Type_Shoes (ID_Code_Type_Shoes),
	Code_Type_Season_ID INT not null REFERENCES Type_Season (ID_Code_Type_Season),
	Code_Model_ID INT not null REFERENCES Model (ID_Code_Model),
	Code_Type_Product_ID INT not null REFERENCES Type_Product (ID_Code_Type_Product)
);

Create table Bank_card_details
(
	ID_Code_bank_card_details Serial not null constraint PK_Bank_card_details primary key,
	Number INT not null,
	Code_Buyer_ID INT not null REFERENCES Buyer (ID_Code_Buyer)
);

Create table Orders
(
	ID_Code_Orders Serial not null constraint PK_Orders primary key,
	Number_Orders INT not null,
	Total_Price DECIMAL(38,2) null DEFAULT (0.0) CONSTRAINT CH_Total_Price
	CHECK (Total_Price >= 0.0),
	Code_bank_card_details_ID INT not null REFERENCES Bank_card_details (ID_Code_bank_card_details),
	Code_Courier_ID INT not null REFERENCES Courier (ID_Code_Courier)
);

Create table Marriage_Fixation
(
	ID_Code_Marriage_Fixation Serial not null constraint PK_Marriage_Fixation primary key,
	Date_Time_Marriage_Fixation DATE null DEFAULT(CURRENT_DATE),
	Code_Orders_ID INT not null REFERENCES Orders (ID_Code_Orders)
);

Create table Structured
(
	ID_Code_Structured Serial not null constraint PK_Structured primary key,
	Title_Structured varchar not null,
	Code_Product_ID INT not null REFERENCES Product (ID_Code_Product),
	Code_Orders_ID INT not null REFERENCES Orders (ID_Code_Orders)
);

Create table Estimate
(
	ID_Code_Estimate Serial not null constraint PK_Estiamte primary key,
	Estimate_Number INT not null,
	Contract_Number_Estimate INT not null,
	Code_Employer_ID INT not null REFERENCES Employer (ID_Code_Employer)
);

Create table Act
(
	ID_Code_Act Serial not null constraint PK_Act primary key,
	Number_Act INT not null,
	Date_Time_Act DATE null DEFAULT(CURRENT_DATE),
	Code_Estimate_ID INT not null REFERENCES Estimate (ID_Code_Estimate),
	Code_Product_ID INT not null REFERENCES Product (ID_Code_Product)
);

Create table Reception
(
	ID_Code_Reception Serial not null constraint PK_Reception primary key,
	Contract_Number_Reception INT not null,
	Email_Address varchar not null,
	Telephone varchar(19) not null CONSTRAINT UQ_Telephone UNIQUE
	CONSTRAINT CH_Telephone CHECK (Telephone similar to '\+7\([0-9]{3}\)[0-9]{3} [0-9]{2} [0-9]{2}'),
	Code_Estimate_ID INT not null REFERENCES Estimate (ID_Code_Estimate),
	Code_Product_ID INT not null REFERENCES Product (ID_Code_Product)
);

Create table Sale
(
	ID_Code_Sale Serial not null constraint PK_Sale primary key,
	Receipt_Number INT not null,
	Date_Time_Sale DATE null DEFAULT(CURRENT_DATE),
	Code_bank_card_details_ID INT not null REFERENCES Bank_card_details (ID_Code_bank_card_details),
	Code_Product_ID INT not null REFERENCES Product (ID_Code_Product),
	Code_Estimate_ID INT not null REFERENCES Estimate (ID_Code_Estimate)
);


Insert into type_Shoes(Title_Type_Shoes) VALUES ('Зимняя'), ('Летняя'), ('Осенняя'), ('Весенняя');
SELECT Title_Type_Shoes as "Название типа обуви" from type_shoes order by Title_Type_Shoes ASC;

Insert into Buyer(Name_Buyer,Surname_Buyer,Adress,End_Date,CVV,Contact_Phone_Number, Email_Addres) VALUES ('Денис', 'Юсупов', 'Дверная 6/6',  '02.10.2005', '132', '+7(912)333 44 22', 'denisusupov228@gmail.com'), ('Азамат', 'Юсупов', 'Гайкина 6/6',  '02.09.2003', '155', '+7(126)393 44 22', 'enisusupov300@gmail.com'), ('Даня', 'Ботов', 'Забивная',  '03.10.2012', '666', '+7(912)395 43 22', 'nescam228@gmail.com'), ('Артем', 'Дербий', 'Вереновы 11',  '11.11.2014', '777', '+7(666)633 44 22', 'gosuslugi12@gmail.com');
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

Insert into Bank_card_details(Number,Code_Buyer_ID) VALUES ('45345658','1'), ('45341158','2'), ('11345658','2'), ('11345658','2');
Select Number as "Номер банковской карты" from Bank_card_details inner join Buyer on Code_Buyer_ID = ID_Code_Buyer order by Number ASC;

Insert into Orders(Number_Orders,Total_Price,Code_bank_card_details_ID,Code_Courier_ID) VALUES('1324','123.2','1','1'),('1124','1233.54','2','2'),('1024','2223.5','3','3'),('924','999.11','4','4');
Select Number_Orders as "Номер Заказа", Total_Price as "Итоговая цена" from Orders inner join bank_card_details on Code_bank_card_details_ID = ID_Code_bank_card_details inner join Courier on Code_Courier_ID = ID_Code_Courier order by Number_Orders ASC;

Insert into Marriage_Fixation(Date_Time_Marriage_Fixation,Code_Orders_ID)VALUES('12.10.2000','1'),('13.10.2000','2'),('14.10.2000','3'),('15.10.2000','4');
Select Date_Time_Marriage_Fixation as "Время" from Marriage_Fixation inner join Orders on Code_Orders_ID = ID_Code_Orders order by Date_Time_Marriage_Fixation ASC;

Insert into Structured(Title_Structured, Code_Product_ID, Code_Orders_ID) VALUES('ООО вишня','1','1'),('ООО грозамоды','2','2'),('ООО винтаж','3','3'),('ООО вишня','4','4');
Select Title_Structured as "Название структуры" from Structured inner join Product on Code_Product_ID = ID_Code_Product inner join Orders on Code_Orders_ID = ID_Code_Orders order by Title_Structured ASC;

Insert into Estimate(Estimate_Number,Contract_Number_Estimate,Code_Employer_ID) VALUES('1999','1230','1'),('12444','1231','2'),('9263','1232','3'),('144','1233','4');
Select Estimate_Number as "Номер сметы",Contract_Number_Estimate as "Номер контракта" from Estimate inner join Employer on Code_Employer_ID = ID_Code_Employer order by Estimate_Number ASC;

Insert into Act(Number_Act, Date_Time_Act, Code_Estimate_ID, Code_Product_ID) VALUES('13636','10.10.1999','1','1'),('13635','11.10.1999','2','2'),('13634','12.10.1999','3','3'),('13637','20.10.1999','4','4');
Select Number_Act as "Номер акта", Date_Time_Act as "Дата акта" from Act inner join Estimate on Code_Estimate_ID = ID_Code_Estimate inner join Product on Code_Product_ID = ID_Code_Product order by Date_Time_Act ASC;

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

create or replace view Shoes_Remove_List ("Название компании", "Название продукции", "Количество продукции", "Цена продукции")
as
	select Title_Structured as "Название компании", Title_Product as "Название продукции", Quantity_Product as "Количество продукции", Amount_Product as "Цента продукции" from Structured
	inner join Product on Code_Product_ID = ID_Code_Product
	inner join Orders on Code_Orders_ID = ID_Code_Orders;
select * from Shoes_Remove_List;

create or replace view New_Buyer_Sale_List ("Номер сметы", "Номер контракта", "Имя работника", "Фамилия работника")
as
	select Estimate_Number as "Номер сметы",Contract_Number_Estimate as "Номер контракта", Name_Employer as "Имя работника", Surname_Employer as "Фамилия работника" from Estimate 
	inner join Employer on Code_Employer_ID = ID_Code_Employer;
select * from New_Buyer_Sale_List;

create or replace view Finished_Sale_Check_List ("Номер чека", "Номер сметы", "Номер контракта", "Дата продажи", "Номер банковской карты", "Название продукции", "Цена продукции", "Количество продукции")
as
	Select Receipt_Number as "Номер чека", Estimate_Number as "Номер сметы", Contract_Number_Estimate as "Номер контракта", Date_Time_Sale as "Дата продажи", Number as "Номер банковской карты", Title_Product as "Название продукции", Amount_Product as "Цена продукции", Quantity_Product as "Количество продукции" from Sale
	inner join Bank_Card_details on Code_bank_card_details_ID = ID_Code_Bank_Card_details
	inner join Product on Code_Product_ID = ID_Code_Product
	inner join Estimate on Code_Estimate_ID = ID_Code_Estimate;
select * from Finished_Sale_Check_List;
SELECT count(*) FROM information_schema.tables 
where table_schema = 'public' and table_type = 'VIEW';

Select Title_Manufacturer as "Название производителя" count(Quantity_Model) as "Количество обуви", Sizes as "Размер", Image as "Картинка обучи", Warranty_Period as "Гарантийный срок" from Model
inner join Manufacturer on Code_Manufacturer_ID = ID_Code_Manufacturer
inner join Employer on Code_Employer_ID = ID_Code_Employer
group by Name_Manufacturer;

create or replace procedure Type_Shoes_insert (p_Title_Type_Shoes varchar(50))
language plpgsql
as $$
		begin
				insert into Type_Shoes (Titile_Type_Shoes)
				values (p_Title_Type_Shoes);
				exception when others
				then
						raise notice'Данный тип обуви уже есть в таблице!';
				end;
	$$;
	
create or replace procedure Type_Shoes_update (p_ID_Code_Type_Shoes int, p_Title_Type_Shoes varchar)
language plpgsql
as $$
		begin
				update Type_Shoes set
					Title_Type_Shoes = p_Title_Type_Shoes
						where
								ID_Code_Type_Shoes = p_ID_Code_Type_Shoes;
				exception when others
				then
						raise notice'Данный тип обуви уже есть в таблице!';
				end;
	$$;

create or replace procedure Type_Shoes_delete (p_ID_Code_Type_Shoes int)
language plpgsql
as $$
		declare p_any_child_record int := count(*) from Product
		where Code_Type_Shoes_ID = p_ID_Code_Type_Shoes;
		begin
				if(p_any_child_record > 0) then
					raise notice'Тип обуви не может быть удален, так как в таблице "Продукт", есть связанные данные!';
				else
					delete from Type_Shoes
						where
						ID_Code_Type_Shoes = p_ID_Code_Type_Shoes;
				end if;
		end;
	$$;
	
create or replace procedure Buyer_insert (p_Name_Buyer varchar,p_Surname_Buyer varchar, p_Adress varchar,p_CVV int, p_Contact_Phone_Number varchar, p_Email_Addres varchar)
language plpgsql
as $$
		begin
		insert into Buyer (Name_Buyer, Surname_Buyer, Adress, CVV, Contact_Phone_Number, Email_Addres)
		VALUES (p_Name_Buyer, p_Surname_Buyer, p_Addres, p_CVV, p_Contact_Phone_Number, p_Email_Addres);
		exception when others
		then
			raise notice'Данный покупатель уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Buyer_update (p_ID_Code_Buyer int, p_Name_Buyer varchar, p_Surname_Buyer varchar, p_Adress varchar, p_CVV int, p_Contact_Phone_Number varchar, p_Email_Addres varchar)
language plpgsql
as $$
		begin
		Update Buyer set Name_Buyer = p_Name_Buyer, Surname_Buyer = p_Surname_Buyer, Adress = p_Adress, CVV = p_CVV, Contact_Phone_Number = p_Contact_Phone_Number, Email_Addres = p_Email_Addres
		where ID_Code_Buyer = p_ID_Code_Buyer;
				exception when others
		then
			raise notice'Данный покупатель уже есть в таблице!';
		end;
	$$;

create or replace procedure Buyer_delete (p_ID_Code_Buyer int)
language plpgsql
as $$
		declare p_any_child_record int := count(*) from Bank_card_details
		Where ID_Code_Buyer = p_ID_Code_Buyer;
		begin
			if(p_any_child_record > 0) then
						raise notice'Покупатель не может быть удален, так как в таблице "Банк_карт_деталь", есть связанные данные!';
			else
				delete from Buyer
					where
					ID_Code_Buyer = p_ID_Code_Buyer;
			end if;
		end;
	$$;

create or replace procedure Type_Season_insert (p_Title_Season varchar)
language plpgsql
as $$
		begin
			Insert into Type_Season (Title_Season)
			VALUES (p_Title_Season);
			exception when others
				then
					raise notice'Данный Сезон уже есть в таблице!';
		end;
	$$;
		
create or replace procedure Type_Season_update (p_ID_Code_Type_Season int, p_Title_Season varchar)
language plpgsql
as $$
		begin
			UPDATE Type_Season set Titile_Season = p_Title_Season WHERE ID_Code_Type_Season = p_ID_Code_Type_Season;
						exception when others
				then
					raise notice'Данный Сезон уже есть в таблице!';
		end;
	$$;

create or replace procedure Type_Season_delete (p_ID_Code_Type_Season int)
language plpgsql
as $$
		declare p_any_child_record int := count(*) from Product
		Where ID_Code_Type_Season = p_ID_Code_Type_Season; 
		begin
				if(p_any_child_record > 0) then
					raise notice'Сезон не может быть удален, так как в таблице "Продукт", есть связанные данные!';
			else
			delete from Type_Season
			where ID_Code_Type_Season = p_Code_Type_Season;
			end if;
		end;
	$$;

create or replace procedure Type_Product_insert (p_Quantity_Type_Product int)
language plpgsql
as $$
		begin
			Insert into Type_Product (Quantity_Type_Product)
			VALUES (p_Quantity_Type_Product);
		exception when others
				then
					raise notice'Данный тип продукта уже есть в таблице!';
		end;
	$$;

create or replace procedure Type_Product_update (p_ID_Code_Type_Product int, p_Quantity_Type_Product int)
language plpgsql
as $$
	begin
		UPDATE Type_Product set Quantity_Type_Product = p_Quantity_Type_Product WHERE ID_Code_Type_Product = p_ID_Code_Type_Product;
		exception when others
				then
					raise notice'Данный тип продукта уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Type_Product_delete (p_ID_Code_Type_Product int)
language plpgsql
as $$
	declare p_any_child_record int := count(*) from Product
		Where ID_Code_Type_Product = p_ID_Code_Type_Product;
		begin
				if(p_any_child_record > 0) then
					raise notice'Тип продукта не может быть удален, так как в таблице "Продукт", есть связанные данные!';
			else
			delete from Type_Product
			where ID_Code_Type_Product = p_Code_Type_Product;
			end if;
		end;
	$$;


create or replace procedure Manufacturer_insert (p_Title_Manufacturer varchar)
language plpgsql
as $$
		begin
			Insert into Manufacturer (Title_Manufacturer)
			VALUES (p_Title_Manufacturer);
		exception when others
				then
					raise notice'Данный Производитель уже есть в таблице!';
		end;
	$$;

create or replace procedure Manufacturer_update (p_ID_Code_Manufacturer int, p_Title_Manufacturer varchar)
language plpgsql
as $$
	begin
		UPDATE Manufacturer set Title_Manufacturer = p_Title_Manufacturer WHERE ID_Code_Manufacturer = p_ID_Code_Manufacturer;
		exception when others
				then
					raise notice'Данный Производитель уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Manufacturer_delete (p_ID_Code_Manufacturer int)
language plpgsql
as $$
	declare p_any_child_record int := count(*) from Model
		Where ID_Code_Manufacturer = p_ID_Code_Manufacturer;
		begin
				if(p_any_child_record > 0) then
					raise notice'Производитель не может быть удален, так как в таблице "Модель", есть связанные данные!';
			else
			delete from Manufacturer
			where ID_Code_Manufacturer = p_ID_Code_Manufacturer;
			end if;
		end;
	$$;

create or replace procedure Courier_insert (p_Where_From_Couriel varchar, p_Where_Courier varchar, p_Formation_Act int)
language plpgsql
as $$
	begin
		Insert into Courier (Where_From_Courier, Where_Courier,Formation_Act)
		VALUES (p_Where_From_Courier, p_Where_Courier,p_Formation_Act);
		exception when others
				then
					raise notice'Данные курьера уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Courier_update (p_ID_Code_Courier int ,p_Where_From_Couriel varchar, p_Where_Courier varchar, p_Formation_Act int)
language plpgsql
as $$
	begin
		UPDATE Courier SET Where_From_Courier = p_Where_From_Courier, Where_Courier = p_Where_Courier,Formation_Act = p_Formation_Act
		WHERE ID_Code_Courier = p_ID_Code_Courier;
				exception when others
				then
					raise notice'Данные курьера уже есть в таблице!';
		end;
	$$;

create or replace procedure Courier_delete (p_ID_Code_Courier int)
language plpgsql
as $$
	declare p_any_child_record int := count(*) from Orders
		Where ID_Code_Courier = p_ID_Code_Courier;
		begin
				if(p_any_child_record > 0) then
					raise notice'Данные курьера не могут быть удалены, так как в таблице "Orders", есть связанные данные!';
			else
			delete from Courier
			where ID_Code_Courier = p_ID_Code_Courier;
			end if;
		end;
	$$;
	
create or replace procedure Employer_insert (p_Name_Employer varchar, p_Surname_Employer varchar)
language plpgsql
as $$
	begin
		INSERT INTO Employer (Name_Employer, Surname_Employer)
		VALUES (p_Name_Employer, p_Surname_Employer);
		exception when others
				then
					raise notice'Данные сотрудника уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Employer_update (p_ID_Code_Employer int,p_Name_Employer varchar, p_Surname_Employer varchar)
language plpgsql
as $$
	begin
		UPDATE Employer SET Name_Employer = p_Name_Employer, Surname_Employer = p_Surname_Employer
		WHERE ID_Code_Employer = p_ID_Code_Employer;
		exception when others
				then
					raise notice'Данные сотрудника уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Employer_delete (p_ID_Code_Employer int)
language plpgsql
as $$
		declare p_any_child_record int := count(*) from Model
		Where ID_Code_Employer = p_ID_Code_Employer;
		begin
				if(p_any_child_record > 0) then
					raise notice'Данные сотрудника не могут быть удалены, так как в таблице "Модель", есть связанные данные!';
			else
			delete from Employer
			where ID_Code_Employer = p_ID_Code_Employer;
			end if;
		end;
	$$;
	
create or replace procedure Model_insert (p_sizes INT,p_image VARCHAR,p_quantity_model INT,p_warranty_period INT,p_code_manufacturer_id INT,p_code_employer_id INT)
language plpgsql
as $$
		begin
			INSERT INTO Model (Sizes, Image, Quantity_Model, Warranty_Period, Code_Manufacturer_ID, Code_Employer_ID)
    		VALUES (p_sizes, p_image, p_quantity_model, p_warranty_period, p_code_manufacturer_id, p_code_employer_id);
					exception when others
				then
					raise notice'Данные модели уже есть в таблице!';
		end;
	$$;

create or replace procedure Model_update (p_id_code_model int,p_sizes INT,p_image VARCHAR,p_quantity_model INT,p_warranty_period INT,p_code_manufacturer_id INT,p_code_employer_id INT)
language plpgsql
as $$
		BEGIN
    	UPDATE Model
    	SET Sizes = p_sizes,
        	Image = p_image,
        	Quantity_Model = p_quantity_model,
        	Warranty_Period = p_warranty_period,
        	Code_Manufacturer_ID = p_code_manufacturer_id,
        	Code_Employer_ID = p_code_employer_id
    	WHERE ID_Code_Model = p_id_code_model;
		exception when others
		then
		raise notice'Данные модели уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Model_delete (p_id_code_model int)
language plpgsql
as $$
		declare p_any_child_record int := count(*) from Product
		Where ID_Code_Model = p_id_code_model;
		begin
				if(p_any_child_record > 0) then
					raise notice'Данные модели не могут быть удалены, так как в таблице "Продукт", есть связанные данные!';
			else
			delete from Model
			where ID_Code_Model = p_id_code_model;
			end if;
		end;
	$$;
	
create or replace procedure Product_insert (p_amount_product INT,p_title_product VARCHAR,p_quantity_product INT,p_code_type_shoes_id INT,p_code_type_season_id INT,p_code_model_id INT,p_code_type_product_id INT)
language plpgsql
as $$
	BEGIN
    INSERT INTO Product (Amount_Product, Title_Product, Quantity_Product, Code_Type_Shoes_ID, Code_Type_Season_ID, Code_Model_ID, Code_Type_Product_ID)
    VALUES (p_amount_product, p_title_product, p_quantity_product, p_code_type_shoes_id, p_code_type_season_id, p_code_model_id, p_code_type_product_id);
	exception when others
		then
		raise notice'Данные продукта уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Product_update (p_id_code_product INT,p_amount_product INT,p_title_product VARCHAR,p_quantity_product INT,p_code_type_shoes_id INT,p_code_type_season_id INT,p_code_model_id INT,p_code_type_product_id INT)
language plpgsql
as $$
	BEGIN
    UPDATE Product
    SET Amount_Product = p_amount_product,
        Title_Product = p_title_product,
        Quantity_Product = p_quantity_product,
        Code_Type_Shoes_ID = p_code_type_shoes_id,
        Code_Type_Season_ID = p_code_type_season_id,
        Code_Model_ID = p_code_model_id,
        Code_Type_Product_ID = p_code_type_product_id
    WHERE ID_Code_Product = p_id_code_product;
	exception when others
		then
		raise notice'Данные продукта уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Product_delete(p_id_code_product INT)
language plpgsql
as $$
		declare p_any_child_record int := count(*) from Structured
		Where ID_Code_Product = p_id_code_product;
		begin
				if(p_any_child_record > 0) then
					raise notice'Данные продукта не могут быть удалены, так как в таблице "Структура", есть связанные данные!';
			else
			delete from Model
			where ID_Code_Product = p_id_code_product;
			end if;
		end;
	$$;
	
create or replace procedure Bank_card_details_insert(p_number INT,p_code_buyer_id INT)
language plpgsql
as $$
	BEGIN
    INSERT INTO Bank_card_details (Number, Code_Buyer_ID)
    VALUES (p_number, p_code_buyer_id);
	exception when others
		then
		raise notice'Данные банковской карты уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Bank_card_details_update(p_id_code_bank_card_details INT,p_number INT,p_code_buyer_id INT)
language plpgsql
as $$
	BEGIN
    UPDATE Bank_card_details
    SET Number = p_number,
        Code_Buyer_ID = p_code_buyer_id
    WHERE ID_Code_bank_card_details = p_id_code_bank_card_details;
		exception when others
		then
		raise notice'Данные банковской карты уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Bank_card_details_delete(p_id_code_bank_card_details INT)
language plpgsql
as $$
		declare p_any_child_record int := count(*) from Orders
		Where ID_Code_Bank_card_details = p_id_code_bank_card_details;
		begin
				if(p_any_child_record > 0) then
					raise notice'Данные банковской карты не могут быть удалены, так как в таблице "Orders", есть связанные данные!';
			else
			delete from Bank_card_details
			where ID_Code_Bank_card_details = p_id_code_bank_card_details;
			end if;
		end;
	$$;
	
create or replace procedure Orders_insert (p_number_orders INT,p_code_bank_card_details_id INT,p_code_courier_id INT)
language plpgsql
as $$
	BEGIN
    INSERT INTO Orders (Number_Orders, Code_bank_card_details_ID, Code_Courier_ID)
    VALUES (p_number_orders, p_code_bank_card_details_id, p_code_courier_id);
	exception when others
		then
		raise notice'Данный заказ уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Orders_update (p_id_code_orders INT,p_number_orders INT,p_code_bank_card_details_id INT,p_code_courier_id INT)
language plpgsql
as $$
	BEGIN
    UPDATE Orders
    SET Number_Orders = p_number_orders,
        Code_bank_card_details_ID = p_code_bank_card_details_id,
        Code_Courier_ID = p_code_courier_id
    WHERE ID_Code_Orders = p_id_code_orders;
	exception when others
		then
		raise notice'Данный заказ уже есть в таблице!';
		end;
	$$;

create or replace procedure Orders_delete (p_id_code_orders INT)
language plpgsql
as $$
		declare p_any_child_record int := count(*) from Marriage_Fixation
		Where ID_Code_Orders = p_id_code_orders;
		begin
				if(p_any_child_record > 0) then
					raise notice'Данный заказ не может быть удален, так как в таблице "Marriage_Fixation", есть связанные данные!';
			else
			delete from Orders
			where ID_Code_Orders = p_id_code_orders;
			end if;
		end;
	$$;

create or replace procedure Marriage_Fixation_insert (p_date_time_marriage_fixation DATE,p_code_orders_id INT)
language plpgsql
as $$
	BEGIN
    INSERT INTO Marriage_Fixation (Date_Time_Marriage_Fixation, Code_Orders_ID)
    VALUES (p_date_time_marriage_fixation, p_code_orders_id);
		exception when others
		then
		raise notice'Данная фиксация брака уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Marriage_Fixation_update (p_id_code_marriage_fixation INT,p_date_time_marriage_fixation DATE,p_code_orders_id INT)
language plpgsql
as $$
	BEGIN
    UPDATE Marriage_Fixation
    SET Date_Time_Marriage_Fixation = p_date_time_marriage_fixation,
        Code_Orders_ID = p_code_orders_id
    WHERE ID_Code_Marriage_Fixation = p_id_code_marriage_fixation;
			exception when others
		then
		raise notice'Данная фиксация брака уже есть в таблице!';
		end;
	$$;
create or replace procedure Marriage_Fixation_delete (p_id_code_marriage_fixation INT)
language plpgsql
as $$
	BEGIN
    DELETE FROM Marriage_Fixation
    WHERE ID_Code_Marriage_Fixation = p_id_code_marriage_fixation;
	end;
	$$;
	
create or replace procedure Structured_insert(p_title_structured VARCHAR,p_code_product_id INT,p_code_orders_id INT)
language plpgsql
as $$
    BEGIN
    INSERT INTO Structured (Title_Structured, Code_Product_ID, Code_Orders_ID)
    VALUES (p_title_structured, p_code_product_id, p_code_orders_id);
		exception when others
		then
		raise notice'Данная структура уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Structured_update(p_id_code_structured INT,p_title_structured VARCHAR,p_code_product_id INT,p_code_orders_id INT)
language plpgsql
as $$
	BEGIN
    UPDATE Structured
    SET Title_Structured = p_title_structured,
        Code_Product_ID = p_code_product_id,
        Code_Orders_ID = p_code_orders_id
    WHERE ID_Code_Structured = p_id_code_structured;
		exception when others
		then
		raise notice'Данная структура уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Structured_delete(p_id_code_structured INT)
language plpgsql
as $$
	BEGIN
    	DELETE FROM Structured
    	WHERE ID_Code_Structured = p_id_code_structured;
		end;
	$$;
	
create or replace procedure Estimate_insert (p_estimate_number INT,p_contract_number_estimate INT,p_code_employer_id INT)
language plpgsql
as $$
	BEGIN
    INSERT INTO Estimate (Estimate_Number, Contract_Number_Estimate, Code_Employer_ID)
    VALUES (p_estimate_number, p_contract_number_estimate, p_code_employer_id);
		exception when others
		then
		raise notice'Данная смета уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Estimate_update (p_id_code_estimate INT,p_estimate_number INT,p_contract_number_estimate INT,p_code_employer_id INT)
language plpgsql
as $$
	BEGIN
    UPDATE Estimate
    SET Estimate_Number = p_estimate_number,
        Contract_Number_Estimate = p_contract_number_estimate,
        Code_Employer_ID = p_code_employer_id
    WHERE ID_Code_Estimate = p_id_code_estimate;
	exception when others
		then
		raise notice'Данная смета уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Estimate_delete (p_id_code_estimate INT)
language plpgsql
as $$
		declare p_any_child_record int := count(*) from Act
		Where ID_Code_Estimate = p_id_code_estimate;
		begin
				if(p_any_child_record > 0) then
					raise notice'Данная смета не может быть удалена, так как в таблице "Акт", есть связанные данные!';
			else
			delete from Estimate
			where ID_Code_Estimate = p_id_code_estimate;
			end if;
		end;
	$$;
	
create or replace procedure Act_insert (p_number_act INT,p_date_time_act DATE,p_code_estimate_id INT,p_code_product_id INT)
language plpgsql
as $$
	BEGIN
    INSERT INTO Act (Number_Act, Date_Time_Act, Code_Estimate_ID, Code_Product_ID)
    VALUES (p_number_act, p_date_time_act, p_code_estimate_id, p_code_product_id);
		exception when others
		then
		raise notice'Данный акт уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Act_update (p_id_code_act INT,p_number_act INT,p_date_time_act DATE,p_code_estimate_id INT,p_code_product_id INT)
language plpgsql
as $$
	BEGIN
    UPDATE Act
    SET Number_Act = p_number_act,
        Date_Time_Act = p_date_time_act,
        Code_Estimate_ID = p_code_estimate_id,
        Code_Product_ID = p_code_product_id
    WHERE ID_Code_Act = p_id_code_act;
		exception when others
		then
		raise notice'Данный акт уже есть в таблице!';
		end;
	$$;

create or replace procedure Act_delete (p_id_code_act INT)
language plpgsql
as $$
	BEGIN
    DELETE FROM Act
    WHERE ID_Code_Act = p_id_code_act;
	end;
	$$;
	
create or replace procedure Reception_insert (p_contract_number_reception INT,p_email_address VARCHAR,p_telephone VARCHAR,p_code_estimate_id INT,p_code_product_id INT)
language plpgsql
as $$
	BEGIN
    INSERT INTO Reception (Contract_Number_Reception, Email_Address, Telephone, Code_Estimate_ID, Code_Product_ID)
    VALUES (p_contract_number_reception, p_email_address, p_telephone, p_code_estimate_id, p_code_product_id);
	exception when others
		then
		raise notice'Данный прием уже есть в таблице!';
		end;
	$$;

create or replace procedure Reception_update (p_id_code_reception INT,p_contract_number_reception INT,p_email_address VARCHAR,p_telephone VARCHAR,p_code_estimate_id INT,p_code_product_id INT)
language plpgsql
as $$
	BEGIN
    UPDATE Reception
    SET Contract_Number_Reception = p_contract_number_reception,
        Email_Address = p_email_address,
        Telephone = p_telephone,
        Code_Estimate_ID = p_code_estimate_id,
        Code_Product_ID = p_code_product_id
    WHERE ID_Code_Reception = p_id_code_reception;
		exception when others
		then
		raise notice'Данный прием уже есть в таблице!';
		end;
	$$;

create or replace procedure Reception_delete (p_id_code_reception INT)
language plpgsql
as $$
	BEGIN
    DELETE FROM Reception
    WHERE ID_Code_Reception = p_id_code_reception;
	end;
	$$;
	
create or replace procedure Sale_insert (p_receipt_number INT,p_date_time_sale DATE,p_code_bank_card_details_id INT,p_code_product_id INT,p_code_estimate_id INT)
language plpgsql
as $$
	BEGIN
    INSERT INTO Sale (Receipt_Number, Date_Time_Sale, Code_bank_card_details_ID, Code_Product_ID, Code_Estimate_ID)
    VALUES (p_receipt_number, p_date_time_sale, p_code_bank_card_details_id, p_code_product_id, p_code_estimate_id);
		exception when others
		then
		raise notice'Данныая продажа уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Sale_update (p_id_code_sale INT,p_receipt_number INT,p_date_time_sale DATE,p_code_bank_card_details_id INT,p_code_product_id INT,p_code_estimate_id INT)
language plpgsql
as $$
	BEGIN
    UPDATE Sale
    SET Receipt_Number = p_receipt_number,
        Date_Time_Sale = p_date_time_sale,
        Code_bank_card_details_ID = p_code_bank_card_details_id,
        Code_Product_ID = p_code_product_id,
        Code_Estimate_ID = p_code_estimate_id
    WHERE ID_Code_Sale = p_id_code_sale;
		exception when others
		then
		raise notice'Данныая продажа уже есть в таблице!';
		end;
	$$;
	
create or replace procedure Sale_delete (p_id_code_sale INT)
language plpgsql
as $$
	BEGIN
    DELETE FROM Sale
    WHERE ID_Code_Sale = p_id_code_sale;
	end;
	$$;
	
SELECT count(*) FROM information_schema.routines 
WHERE routine_type = 'PROCEDURE';

call Type_Shoes_insert ('Зимняя');
select * from Type_shoes;


call Type_Shoes_delete (5);
select * from Type_Shoes;

call Type_Season_insert ('Шествой');
select * from Type_Season;

call Type_Season_delete (4);
select * from Type_Season;

call Sale_delete(4);
select * from sale;

call Employer_insert(' ');
select * from Employer;



Select Title_Manufacturer as "Название производителя", length(Title_Manufacturer) as "Количество символов", count(Code_Manufacturer_ID) as "Количество постовляемой продукции" from Model
inner join Manufacturer on Code_Manufacturer_ID = ID_Code_Manufacturer
inner join Employer on Code_Employer_ID = ID_Code_Employer
group by Title_Manufacturer;

Select Title_Product as "Самый дорогой товар", sum(Amount_Product) as "Цена товара" from Product
group by Title_Product
having sum(Amount_Product) > 1 limit 3;

Select Title_Product as "Название товара", case
	when Amount_Product <3000 then 'Дешевый товар'
	when Amount_Product between 3000 and 5000 then 'Доступный товар'
	when Amount_Product > 5000 then 'Дорогой товар'
	end as "Степень дороговизны" from Product;
	
Select Max(Amount_Product) as "Самый дорогой товар", Min(Amount_Product) as "Самый дешевый товар" from Product;

Select distinct(Date_time_Marriage_Fixation) from Marriage_Fixation;

Select to_char(Date_time_Marriage_Fixation,'dd.MM.yyyy')  as "Дата заключения договора" , 
to_char(Date_time_Marriage_Fixation + interval '1 year','dd.MM.yyyy')  as "Дата окончания договора" , 
date_part('QUARTER',Date_time_Marriage_Fixation + interval '1 year')  as "Квартал окончания договора" from Marriage_Fixation;


create or replace function Check_Title (p_Title_Product VARCHAR)
returns INT
language plpgsql
as $$
	declare p_Amount_Product INT;
	begin
		p_Amount_Product :=sum(Amount_Product * Quantity_Product) from Product
		inner join Type_Shoes on Code_Type_Shoes_ID = ID_Code_Type_Shoes
		inner join Type_Season on Code_Type_Season_ID = ID_Code_Type_Season
		inner join Model on Code_Model_ID = ID_Code_Model
		inner join Type_Product on Code_Type_Product_ID = ID_Code_Type_Product
		where Title_Product = p_Title_Product;
		return p_Amount_Product;
	end;
$$;
select * from Check_Title('Гуччишуси');

create or replace function Check_Product (p_Title_Product VARCHAR)
returns table (Amount_Product INT, Quantity_Product INT)
language plpgsql
as $$
	begin
		return query select Amount_Product as "Цена продукта", Quantity_Product as "Количество продукта" from Product
		inner join Type_Shoes on Code_Type_Shoes_ID = ID_Code_Type_Shoes 
		inner join Type_Season on Code_Type_Season_ID = ID_Code_Type_Season 
		inner join Model on Code_Model_ID = ID_Code_Model 
		inner join Type_Product on Code_Type_Product_ID = ID_Code_Type_Product
		where Title_Product = p_Title_Product
		group by Amount_Product,Quantity_Product;
	end;
$$;
select * from Check_Product('Гуччишуси');

select Amount_Product as "Цена продукта", Quantity_Product as "Количество продукта" from Product
		inner join Type_Shoes on Code_Type_Shoes_ID = ID_Code_Type_Shoes 
		inner join Type_Season on Code_Type_Season_ID = ID_Code_Type_Season 
		inner join Model on Code_Model_ID = ID_Code_Model 
		inner join Type_Product on Code_Type_Product_ID = ID_Code_Type_Product
		where Title_Product = 'Гуччишуси';
		
drop function check_card;

SELECT count(*) FROM information_schema.routines 
WHERE routine_type = 'FUNCTION' AND routine_schema = 'public';
