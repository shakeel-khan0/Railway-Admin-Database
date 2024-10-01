create table LoginAS(
loginID varchar(20) Primary key,
Username varchar(20),
Userpassword varchar(50) NOT NULL,
);

alter table LoginAS
alter column Username varchar(20) not null;

create table TrainAdmin(
adminID varchar(20) primary key,
admin_pass varchar(50) NOT NULL,
admin_name varchar(50)
);

alter table TrainAdmin
drop column admin_name;

alter table TrainAdmin
add last_name varchar(30) not null;

create table passenger(
passenger_seq int,
passengerID varchar(30) primary key,
passenger_name varchar(25),
passenger_mob int NOT NULL,
passenger_mail varchar (40) NOT NULL,
street varchar(20) NOT NULL,
city varchar(20) NOt NUll,
postal_code int
);

alter table passenger
add last_name varchar(30) not null;

alter table TrainAdmin
add loginID varchar(20);

alter table passenger
add loginID varchar(20);

alter table [passenger]
add constraint FK_pass_login
foreign key (loginID) references LoginAS(loginID);

alter table [TrainAdmin]
add constraint FK_admin_lodin
foreign key (loginID) references [LoginAS](loginID);

create table train(
train_no int primary key,
train_name varchar(30),
train_destination varchar(30),
departure_time time,
arrival_time time,
availble_seats int 
);

alter table train
drop column departure_time,arrival_time;

create table Schedule(
scheduleID int primary key,
dept_time time,
arrival_time timestamp
);

alter table Schedule
add train_no int;

alter table [Schedule]
add constraint FK_schedule_train
foreign key(train_no) references [train](train_no);

create table Stations(
stationID varchar(20) primary key,
station_name varchar(30),
station_destination varchar(50),
arrival_time timestamp,
departure_time time
);

alter table Stations 
add arrivals_time datetime;
update Stations 
set arrivals_time = cast(arrival_time as datetime);
alter table Stations
drop column arrival_time;

create table Class (
class_type varchar(50) primary key,
train_no int,
class_description varchar(100),
constraint FK_class_train
foreign key(train_no) references train(train_no)
);

create table BusinessClass(
class_type varchar(50),
bClass_specification varchar(100),
foreign key(class_type) references Class(class_type)
);

create table FirstClass(
class_type varchar(50),
fClass_specification varchar(100),
foreign key(class_type) references Class(class_type)
);

create table EconomyClass(
class_type varchar(50),
eClass_specification varchar(100),
foreign key(class_type) references Class(class_type)
);

create table Payment(
paymentID int primary key,
amount int not null,
payment_method varchar(20),
passengerID varchar(30),
foreign key(passengerID) references passenger(passengerID)
);

create table EasyPaisa(
paymentID int primary key,
mobile_number int not null,
recieverID int not null,
foreign key(paymentID) references Payment(paymentID)
);

create table CardPayment(
paymentID int primary key,
accholder_name varchar(30) not null,
card_number int not null,
card_type varchar not null,
expire_date date,
foreign key(paymentID) references Payment(paymentID)
);
alter table CardPayment
alter column card_type varchar(20);

create table Tickets(
ticketID varchar(50) primary key,
passengerID varchar(30),
train_no int,
ticket_price int not null,
date_Time timestamp,
number_seats int,
source varchar(50),
start_time time,
destiantion varchar(50),
foreign key(passengerID) references passenger(passengerID),
foreign key(train_no) references Train(train_no)
);
alter table Tickets
add time_date datetime;
update Tickets 
set time_date=cast(date_time AS datetime);
alter table Tickets
drop column date_time;

INSERT INTO LoginAS(loginID, Username, Userpassword)
VALUES (1, 'admin1', 'admin12'),
 (2, 'passenger1', 'pass12'),
 (3, 'passenger2', 'pass34'),
 (4, 'admin2', 'admin23'),
 (5, 'admin', 'admin34');

INSERT INTO LoginAS(loginID, Username, Userpassword)
VALUES (6, 'passenger3', 'pass45'),
 (7, 'passenger4', 'pass56'),
 (8, 'admin4', 'admin45'),
 (9, 'passenger5', 'pass67'),
 (10, 'admin5', 'admin56');

INSERT INTO passenger(passenger_seq,passengerID,first_name,last_name,passenger_mail,passenger_mob,street,city,postal_code,loginID)
VALUES(1,'P1','passenger','01', 'passenger12@mail.com',987651,'78 main st','Islamabad',44000, 2),
(2,'P2','passenger1','02', 'passenger01@mail.com',9876501,'02 st','Islamabad',44000, 3);

INSERT INTO passenger(passenger_seq,passengerID,first_name,last_name,passenger_mail,passenger_mob,street,city,postal_code,loginID)
VALUES(3,'P3','passenger2','03', 'passenger3@mail.com',987652,'70 main st','Islamabad',44000, 6),
(4,'P4','passenger3','04', 'passenger4@mail.com',9876502,'03 st','Rawalpindi',42000, 7),
(5,'P5','passenger4','05', 'passenger5@mail.com',9876503,'Murree Chowk','Abbottabad',22000, 9);

insert into TrainAdmin(adminID,admin_pass,first_name,last_name,loginID)
values('A1','admin12','admin1','01',1),('A2','admin23','admin2','02',4),
('A3','admin34','admin3','03',5);
insert into TrainAdmin(adminID,admin_pass,first_name,last_name,loginID)
values('A4','admin45','admin4','04',8),
('A5','admin56','admin5','05',10);

INSERT INTO train(train_no,train_name,train_destination,availble_seats)
VALUES
(103, 'Express Train ', 'Rwp to Lahore', 100),
(104, 'Local Train ', 'Lahore to RWP', 50);

INSERT INTO Class(class_type, train_no,class_description)
VALUES
('Business', 101, 'Luxurious Business Class'),
('Economy', 102, 'Standard Economy Class'),
('First', 103, 'Chiller First Class');
INSERT INTO BusinessClass (class_type, bClass_specification)
VALUES('Business', 'Exclusive amenities for Business-class passengers');
INSERT INTO FirstClass(class_type, fClass_specification)
VALUES('First', 'Luxurious seating and services');
INSERT INTO EconomyClass(class_type, eClass_specification)
VALUES('Economy', 'Standard amenities for economy-class passengers');

INSERT INTO Stations (stationID, station_name, station_destination, arrivals_time, departure_time)
VALUES
(1, 'City Station', 'Main City Station', '2024-01-07 12:30:00', '08:00:00'),
(2, 'Town Station', 'Central Town Station', '2024-01-06 14:30:00', '12:00:00');

INSERT INTO Payment(paymentID, amount, payment_method, passengerID)
VALUES
(1, 5000.00, 'Card', 'P1'),
(2, 3000.00, 'Easypaisa', 'P2');
INSERT INTO Payment(paymentID, amount, payment_method, passengerID)
VALUES
(3, 10000.00, 'Card', 'P4'),
(4, 6000.00, 'Easypaisa', 'P3');
INSERT INTO EasyPaisa(paymentID, mobile_number, recieverID)
VALUES(2, 03123098, 67890),(4, 0345890, 123456);
insert into CardPayment(paymentID,accholder_name,card_number,card_type,expire_date)
values(1,'Ali','3456 0129 5678 1234','Visa','2026-01-12'),(3,'Khan','0987 9321 5678 1234','MasterCard','2028-03-26');

INSERT INTO Tickets (ticketID,ticket_price, time_date, number_seats, source, start_time, destiantion, passengerID, train_no)
VALUES
(1, 5000.00, '2024-01-15 10:30:00', 2, 'City', '08:00:00', 'Town', 'P1', 101),
(2, 3000.00, '2024-01-16 14:45:00', 1, 'Town', '14:00:00', 'City','P2', 102);

select *from loginAS;
select *from TrainAdmin;
select *from passenger;
select *from train;
select * from Class;
select * from BusinessClass;
select * from FirstClass;
select * from EconomyClass;
select * from Stations;
select * from Payment;
select * from CardPayment;
select * from EasyPaisa;
select * from Tickets;
