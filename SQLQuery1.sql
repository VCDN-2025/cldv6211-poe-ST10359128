CREATE TABLE Venues (
    VenueID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    Capacity INT NOT NULL,
    Availability BIT DEFAULT 1,
    ImageURL NVARCHAR(255) DEFAULT 'https://via.placeholder.com/150'
    ALTER TABLE Venues
ADD IsAvailable BIT DEFAULT 1;

);

CREATE TABLE Events (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Description NVARCHAR(500)
    ALTER TABLE Events
ADD EventTypeID INT;

ALTER TABLE Events
ADD CONSTRAINT FK_Events_EventTypes FOREIGN KEY (EventTypeID) REFERENCES EventTypes(EventTypeID);

);

CREATE TABLE Bookings (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    VenueID INT NOT NULL,
    EventID INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Status NVARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (VenueID) REFERENCES Venues(VenueID),
    FOREIGN KEY (EventID) REFERENCES Events(EventID),
    CONSTRAINT UniqueBooking UNIQUE (VenueID, StartDate, EndDate)
);
CREATE VIEW vw_BookingDisplay AS
SELECT 
    b.BookingID,
    e.Name AS EventName,
    v.Name AS VenueName,
    v.Location,
    b.StartDate,
    b.EndDate,
    b.Status
FROM Bookings b
JOIN Events e ON b.EventID = e.EventID
JOIN Venues v ON b.VenueID = v.VenueID;
;
CREATE TABLE EventTypes (
    EventTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName NVARCHAR(100) NOT NULL
);
-- Add EventType table
CREATE TABLE EventTypes (
    EventTypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName NVARCHAR(100) NOT NULL
);

-- Add FK in Events
ALTER TABLE Events ADD EventTypeID INT;
ALTER TABLE Events
ADD CONSTRAINT FK_Events_EventTypes FOREIGN KEY (EventTypeID) REFERENCES EventTypes(EventTypeID);

-- Add IsAvailable column to Venues
ALTER TABLE Venues ADD IsAvailable BIT DEFAULT 1;

