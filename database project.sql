
-- EVENT MANAGEMENT SYSTEM


CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    created_at DATETIME DEFAULT GETDATE()
);

SELECT *FROM Users;

CREATE TABLE Venue (
    venue_id INT PRIMARY KEY IDENTITY(1,1),
    venue_name VARCHAR(50),
    city VARCHAR(50),
    capacity INT
);


SELECT *FROM Venue;

CREATE TABLE Event (
    event_id INT PRIMARY KEY IDENTITY(1,1),
    event_name VARCHAR(50),
    event_date DATE,
    ticket_price DECIMAL(8,2),
    venue_id INT,
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
);


SELECT *FROM Event;

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    event_id INT,
    tickets INT,
    booking_status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);
SELECT *FROM Booking;

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    booking_id INT,
    amount DECIMAL(8,2),
    payment_method VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);
GO

SELECT *FROM Payment;


INSERT INTO Users (name, email, phone) VALUES
('Ram Sharma','ram@gmail.com','9800000001'),
('Sita Rai','sita@gmail.com','9800000002'),
('Hari Thapa','hari@gmail.com','9800000003'),
('Mina Gurung','mina@gmail.com','9800000004'),
('Bikash Karki','bikash@gmail.com','9800000005'),
('Aayush Adhikari','aayush@gmail.com','9800000006'),
('Nisha Shrestha','nisha@gmail.com','9800000007'),
('Prakash Lama','prakash@gmail.com','9800000008');
SELECT *FROM Users;

INSERT INTO Venue (venue_name, city, capacity) VALUES
('City Hall','Kathmandu',500),
('Lakeside Ground','Pokhara',1000),
('Expo Center','Butwal',800),
('Community Hall','Chitwan',400),
('Stadium Arena','Dharan',1500);
SELECT *FROM Venue;

INSERT INTO Event (event_name, event_date, ticket_price, venue_id) VALUES
('Music Concert','2026-03-01',500,1),
('Tech Seminar','2026-03-05',300,2),
('Comedy Show','2026-03-10',400,3),
('Startup Meetup','2026-03-15',250,1),
('Dance Festival','2026-03-20',600,5),
('Art Exhibition','2026-03-25',200,4);
SELECT *FROM Event;

INSERT INTO Booking (user_id, event_id, tickets, booking_status) VALUES
(1,1,2,'Confirmed'),
(2,1,1,'Confirmed'),
(3,2,3,'Pending'),
(4,3,2,'Confirmed'),
(5,2,1,'Confirmed'),
(6,4,2,'Confirmed'),
(7,5,4,'Confirmed'),
(8,6,1,'Pending'),
(1,5,3,'Confirmed'),
(2,4,2,'Confirmed');

SELECT *FROM Booking;

INSERT INTO Payment (booking_id, amount, payment_method) VALUES
(1,1000,'Cash'),
(2,500,'Card'),
(3,900,'Cash'),
(4,800,'Card'),
(5,300,'Cash'),
(6,500,'Card'),
(7,2400,'Cash'),
(8,200,'Card'),
(9,1800,'Cash'),
(10,500,'Card');

SELECT *FROM Payment;

-- INNER JOIN
--which user booked which event:

SELECT Users.name, Event.event_name, Booking.tickets
FROM Booking
INNER JOIN Users ON Booking.user_id = Users.user_id
INNER JOIN Event ON Booking.event_id = Event.event_id;

--LEFT JOIN
--Show all events even if no booking exists:

SELECT Event.event_name, Booking.booking_id
FROM Event
LEFT JOIN Booking ON Event.event_id = Booking.event_id;

--COUNT + GROUP BY
--Count total bookings per event:

SELECT event_id, COUNT(booking_id) AS total_bookings
FROM Booking
GROUP BY event_id;

--SUM [Total tickets per event]

SELECT event_id, SUM(tickets) AS total_tickets
FROM Booking
GROUP BY event_id;

--AVG (Average ticket price)

SELECT AVG(ticket_price) AS average_price
FROM Event;

--SUBQUERY
--Users who booked more than 2 tickets:

SELECT name
FROM Users
WHERE user_id IN (
    SELECT user_id
    FROM Booking
    WHERE tickets > 2
);

--VIEW
--Create a view to show booking details:

CREATE VIEW BookingDetails AS
SELECT Users.name, Event.event_name, Booking.tickets
FROM Booking
JOIN Users ON Booking.user_id = Users.user_id
JOIN Event ON Booking.event_id = Event.event_id;

SELECT * FROM BookingDetails;

--TRANSACTION
--Example using ROLLBACK

BEGIN TRANSACTION;

INSERT INTO Booking (user_id, event_id, tickets, booking_status)
VALUES (1,2,2,'Confirmed');

ROLLBACK;

--Example using COMMIT

BEGIN TRANSACTION;

INSERT INTO Booking (user_id, event_id, tickets, booking_status)
VALUES (1,2,2,'Confirmed');

COMMIT;






