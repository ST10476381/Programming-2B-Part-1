
--ST10476381_NOKUTHULA_MNISI--

--create the Raceday Database if it doesnt exixt
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'RaceDay')
BEGIN
 CREATE DATABASE RaceDay;
 END
 GO
 --Switch intp the RaceDay Database for everything that follows
 USE RaceDay;
 GO


-- Drop tables if they already exist (run in reverse dependency order)
IF OBJECT_ID('dbo.RESULT', 'U') IS NOT NULL DROP TABLE dbo.RESULT;
IF OBJECT_ID('dbo.ENROLMENT', 'U') IS NOT NULL DROP TABLE dbo.ENROLMENT;
IF OBJECT_ID('dbo.CATEGORY', 'U') IS NOT NULL DROP TABLE dbo.CATEGORY;
IF OBJECT_ID('dbo.EVENT', 'U') IS NOT NULL DROP TABLE dbo.EVENT;
IF OBJECT_ID('dbo.PARTICIPANT', 'U') IS NOT NULL DROP TABLE dbo.PARTICIPANT;
IF OBJECT_ID('dbo.ORGANISER', 'U') IS NOT NULL DROP TABLE dbo.ORGANISER;
GO

/* Table: ORGANISER */

CREATE TABLE dbo.ORGANISER (
    OrganiserID     INT IDENTITY(1,1) PRIMARY KEY,
    Name            VARCHAR(100)    NOT NULL,
    Email           VARCHAR(150)    NOT NULL UNIQUE,
    Password        VARCHAR(255)    NOT NULL,
    Phone           VARCHAR(20)     NULL
);
GO

/*  Table: PARTICIPANT */
CREATE TABLE dbo.PARTICIPANT (
    ParticipantID   INT IDENTITY(1,1) PRIMARY KEY,
    Name            VARCHAR(100)    NOT NULL,
    Email           VARCHAR(150)    NOT NULL UNIQUE,
    Password        VARCHAR(255)    NOT NULL,
    DateOfBirth     DATE            NULL,
    Gender          VARCHAR(20)     NULL
);
GO

/* Table: EVENT
   FK: OrganiserID -> ORGANISER (1 Organiser : M Events)
   */
CREATE TABLE dbo.EVENT (
    EventID         INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID     INT             NOT NULL,
    EventName       VARCHAR(150)    NOT NULL,
    EventDate       DATE            NOT NULL,
    Location        VARCHAR(150)    NOT NULL,
    Description     VARCHAR(MAX)    NULL,
    CONSTRAINT FK_Event_Organiser FOREIGN KEY (OrganiserID)
        REFERENCES dbo.ORGANISER(OrganiserID)
);
GO

/* Table: CATEGORY
   FK: EventID -> EVENT (1 Event : M Categories)
 */
CREATE TABLE dbo.CATEGORY (
    CategoryID      INT IDENTITY(1,1) PRIMARY KEY,
    EventID         INT             NOT NULL,
    CategoryName    VARCHAR(100)    NOT NULL,
    Distance        DECIMAL(5,2)    NOT NULL,
    MaxParticipants INT             NOT NULL DEFAULT 100,
    EntryFee        DECIMAL(8,2)    NOT NULL DEFAULT 0.00,
    CONSTRAINT FK_Category_Event FOREIGN KEY (EventID)
        REFERENCES dbo.EVENT(EventID)
);
GO

/*  Table: ENROLMENT
   FK: ParticipantID -> PARTICIPANT (1 Participant : M Enrolments)
   FK: CategoryID -> CATEGORY (1 Category : M Enrolments)
   */
CREATE TABLE dbo.ENROLMENT (
    EnrolmentID     INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID   INT             NOT NULL,
    CategoryID      INT             NOT NULL,
    EnrolmentDate   DATE            NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    Status          VARCHAR(20)     NOT NULL DEFAULT 'Confirmed',
    CONSTRAINT FK_Enrolment_Participant FOREIGN KEY (ParticipantID)
        REFERENCES dbo.PARTICIPANT(ParticipantID),
    CONSTRAINT FK_Enrolment_Category FOREIGN KEY (CategoryID)
        REFERENCES dbo.CATEGORY(CategoryID),
    CONSTRAINT UQ_Enrolment_Participant_Category
        UNIQUE (ParticipantID, CategoryID)
);
GO

/*  Table: RESULT
   FK: EnrolmentID -> ENROLMENT (1 Enrolment : 0..1 Result)
   UNIQUE on EnrolmentID enforces the 1-to-0/1 relationship
 */
CREATE TABLE dbo.RESULT (
    ResultID        INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID     INT             NOT NULL UNIQUE,
    FinishTime      TIME            NULL,
    Position        INT             NULL,
    Status          VARCHAR(20)     NOT NULL DEFAULT 'Pending',
    CONSTRAINT FK_Result_Enrolment FOREIGN KEY (EnrolmentID)
        REFERENCES dbo.ENROLMENT(EnrolmentID)
);
GO

/* seed DATA */

-- Organisers (2)
INSERT INTO dbo.ORGANISER (Name, Email, Password, Phone) VALUES
('Durban Athletics Club', 'events@durbanathletics.co.za', 'HashedPass123', '0311234567'),
('Cape Peninsula Sports Trust', 'info@cpst.org.za', 'HashedPass456', '0219876543');

-- Participants (2)
INSERT INTO dbo.PARTICIPANT (Name, Email, Password, DateOfBirth, Gender) VALUES
('Ntokozo Zulu', 'ntokozo.zulu@email.com', 'HashedPassA1', '1996-04-12', 'Female'),
('Sipho Mooi', 'sipho.mooi@email.com', 'HashedPassB2', '1990-11-03', 'Male');

-- Events (3)
INSERT INTO dbo.EVENT (OrganiserID, EventName, EventDate, Location, Description) VALUES
(1, 'Durban Beachfront Fun Run', '2026-11-15', 'Durban Beachfront', 'A family-friendly road running event along the Durban promenade.'),
(1, 'Midlands Trail Challenge', '2026-12-06', 'Pietermaritzburg', 'A scenic trail running event through the KZN Midlands.'),
(2, 'Cape Town Cycle Classic', '2027-01-24', 'Cape Town CBD', 'An annual community cycling event around the Cape Peninsula.');

-- Categories (at least one per event)
INSERT INTO dbo.CATEGORY (EventID, CategoryName, Distance, MaxParticipants, EntryFee) VALUES
(1, '5km Fun Run', 5.00, 500, 100.00),
(1, '10km Road Race', 10.00, 300, 150.00),
(2, '15km Trail Run', 15.00, 200, 180.00),
(3, '50km Cycle Race', 50.00, 400, 250.00),
(3, '100km Cycle Race', 100.00, 250, 350.00);

-- Enrolments (example)
INSERT INTO dbo.ENROLMENT (ParticipantID, CategoryID, EnrolmentDate, Status) VALUES
(1, 1, '2026-10-01', 'Confirmed'),
(1, 4, '2026-11-20', 'Confirmed'),
(2, 2, '2026-10-05', 'Confirmed'),
(2, 3, '2026-11-01', 'Pending');

-- Results (example - only for completed enrolments)
INSERT INTO dbo.RESULT (EnrolmentID, FinishTime, Position, Status) VALUES
(1, '00:28:40', 12, 'Finished'),
(3, '00:49:10', 34, 'Finished');
GO
