-- Butrus wol Duang
-- 2309000416
create database Travel_ltinerary_management_system;
use Travel_ltinerary_management_system;

-- Create user and grant privileges
create user 'Butrus_2309000416'@'127.0.0.1' identified by '2309000416';
grant all privileges on cardealership.* to 'Butrus_2309000416'@'127.0.0.1';

show databases;
-- Create the Trips table
create table Trips (
    trip_id int auto_increment primary key,
    trip_name varchar(100),
    start_date DATE,
    end_date DATE
);
-- Create the Timing table
create table Timing (
    timing_id int auto_increment primary key,
    trip_id int,
    departure_time datetime,
    arrival_time datetime,
    foreign key (trip_id) references Trips(trip_id)
);
-- Create the Passengers table
create table Passengers (
    passenger_id int auto_increment primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    phone_number varchar(15)
);
-- Create the Destination table
create table Destination (
    destination_id int auto_increment primary key,
    trip_id int,
    destination_name varchar(100),
    address varchar(200),
    foreign key (trip_id) references Trips(trip_id)
);
-- Create the Trip_Passengers table to represent the many-to-many relationship between Trips and Passengers
create table Trip_Passengers (
    trip_id int,
    passenger_id int,
    primary key(trip_id, passenger_id),
    foreign key (trip_id) references Trips(trip_id),
    foreign key (passenger_id) references Passengers(passenger_id)
);

-- Butrus wol Duang
-- 2309000416
-- Insert data into Trips table
insert into Trips (trip_name, start_date, end_date)
values 
('Trip to Paris', '2023-05-01', '2023-05-07'),
('Business Trip to London', '2023-06-10', '2023-06-15');

-- Insert data into Timing table
insert into Timing (trip_id, departure_time, arrival_time)
values
(1, '2023-05-01 08:00:00', '2023-05-01 10:30:00'),
(2, '2023-06-10 09:00:00', '2023-06-10 11:00:00');

-- Insert data into Passengers table
INSERT INTO Passengers (first_name, last_name, email, phone_number)
VALUES 
('John', 'Doe', 'john@example.com', '123-456-7890'),
('Jane', 'Smith', 'jane@example.com', '098-765-4321');

-- Insert data into Destination table
insert into Destination (trip_id, destination_name, address)
values
(1, 'Eiffel Tower', 'Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France'),
(2, 'Big Ben', 'Westminster, London SW1A 0AA, UK');

-- Insert data into Trip_Passengers table
insert into Trip_Passengers (trip_id, passenger_id)
values 
(1, 1),
(1, 2),
(2, 1);

-- Butrus wol Duang
-- 2309000416
-- Create
insert into Trips (trip_name, start_date, end_date) 
values
 ('Trip to Paris', '2023-05-01', '2023-05-07');
-- Read
select * from Trips;
-- Update
update Trips set trip_name = 'Trip to Rome' where trip_id = 1;
-- Delete
delete from Trips where trip_id = 1;
-- Count
select COUNT(*) from Trips;
-- Average
select avg(DATEDIFF(end_date, start_date)) as avg_trip_duration from Trips;
-- Sum
select SUM(DATEDIFF(end_date, start_date)) as total_trip_duration from Trips;

-- Create
insert into Timing (trip_id, departure_time, arrival_time) 
values 
(1, '2023-05-01 08:00:00', '2023-05-01 10:30:00');
-- Read
select * from Timing;
-- Update
update Timing set departure_time = '2023-05-01 09:00:00' where timing_id = 1;
-- Delete
delete from Timing where timing_id = 1;
-- Count
select COUNT(*) from Timing;
-- Average
select avg(timestampdiff(hour, departure_time, arrival_time)) as avg_travel_time from Timing;
-- Sum
SELECT SUM(timestampdiff(hour, departure_time, arrival_time)) as total_travel_time from Timing;

-- Create
insert into Passengers (first_name, last_name, email, phone_number)
 values 
 ('John', 'Doe', 'john@example.com', '123-456-7890');
-- Read
select * from Passengers;
-- Update
update Passengers set email = 'john.doe@example.com' where passenger_id = 1;
-- Delete
delete from Passengers where passenger_id = 1;
-- Count
select COUNT(*) from Passengers;
-- Average
select avg(LENGTH(phone_number)) as avg_phone_length from Passengers;
-- Sum
SELECT SUM(LENGTH(phone_number)) as total_phone_length from Passengers;

-- Create
insert into Destination (trip_id, destination_name, address)
 values
 (1, 'Eiffel Tower', 'Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France');
-- Read
select * from Destination;
-- Update
update Destination set destination_name = 'Louvre Museum' where destination_id = 1;
-- Delete
delete from Destination where destination_id = 1;
-- Count
select COUNT(*) from Destination;
-- Average
select avg(LENGTH(destination_name)) as avg_destination_name_length from Destination;
-- Sum
select SUM(LENGTH(destination_name)) as total_destination_name_length from Destination;

-- Butrus wol Duang
-- 2309000416
-- Create
insert into Trip_Passengers (trip_id, passenger_id) values (1, 1);
-- Read
select * from Trip_Passengers;
-- Update
update Trip_Passengers set passenger_id = 2 where trip_id = 1 and passenger_id = 1;
-- Delete
delete from Trip_Passengers where trip_id = 1 and passenger_id = 1;
-- Count
select COUNT(*) from Trip_Passengers;
-- Average
select avg(trip_id) as avg_trip_id from Trip_Passengers;
-- Sum
select SUM(trip_id) as total_trip_id from Trip_Passengers;

-- create view 
create view TripDetails as
select t.trip_name, t.start_date, t.end_date, d.destination_name, d.address
from Trips t
join Destination d on t.trip_id = d.trip_id;

create view PassengerTrips as
select p.first_name, p.last_name, t.trip_name
from Passengers p
join Trip_Passengers tp on p.passenger_id = tp.passenger_id
join Trips t on tp.trip_id = t.trip_id;
-- Add four more views as needed

DELIMITER //
CREATE PROCEDURE AddTrip(IN trip_name VARCHAR(100), 
IN start_date DATE, IN end_date DATE)
BEGIN 
  INSERT INTO Trips (trip_name, start_date, end_date)
  VALUES (trip_name, start_date, end_date)
END;
DELIMITER //

DELIMITER //
CREATE PROCEDURE UpdateTrip(IN trip_id INT, IN trip_name VARCHAR(100))
BEGIN
  UPDATE Trips SET trip_name = trip_name WHERE trip_id = trip_id;
END;
DELIMITER //
-- Add four more stored procedures as needed

DELIMITER //
CREATE TRIGGER AfterInsertTrip
AFTER INSERT ON Trips
FOR EACH ROW
BEGIN
  INSERT INTO Timing (trip_id, departure_time, arrival_time)
  VALUES 
  (NEW.trip_id, NOW(), NOW() + INTERVAL 2 HOUR);
END;
DELIMITER //

DELIMITER //
CREATE TRIGGER AfterUpdateTrip
AFTER UPDATE ON Trips
FOR EACH ROW
BEGIN
  UPDATE Timing SET departure_time = NOW() WHERE trip_id = NEW.trip_id;
END;
DELIMITER //

-- Butrus wol Duang
-- 2309000416













