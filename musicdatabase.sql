CREATE DATABASE MusicDataBase;
USE MusicDataBase;

DROP TABLE IF EXISTS Listener;
CREATE TABLE Listener (
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
userID INT(10) NOT NULL,
userName VARCHAR(50) NOT NULL,
userPassword VARCHAR(50) NOT NULL,
mostPlayedArtist VARCHAR(100),
PRIMARY KEY (userID)
);
CREATE UNIQUE INDEX Listener_name
ON Listener (userName);

drop view if exists listenerView;
CREATE VIEW listenerView AS
SELECT userName, mostPlayedArtist, FirstName, LastName
FROM Listener
WHERE NOT NULL;

SELECT * FROM listenerView;

DROP TABLE IF EXISTS Song;
CREATE TABLE Song (
songTitle VARCHAR(50) NOT NULL,
musicType VARCHAR(50),
length VARCHAR(20) NOT NULL,
language VARCHAR(30),
artist VARCHAR(50) NOT NULL,
songID INT(10) NOT NULL UNIQUE,
PRIMARY KEY (SongID),
ReleaseDate DATE NOT NULL
);
CREATE UNIQUE INDEX Song_name
ON Song (songTitle, Artist, ReleaseDate);
SELECT * FROM Song;

DROP TABLE IF EXISTS contentCreator;
CREATE TABLE contentCreator (
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	userID INT(10) NOT NULL UNIQUE,
	numberOfFollowers INT(10),
	stageName VARCHAR(50) NOT NULL
);
CREATE UNIQUE INDEX contentCreator_name
ON contentCreator (stageName);
SELECT * FROM contentCreator;

drop view if exists contentCreatorView;
CREATE VIEW contentCreatorView AS
SELECT firstName, lastName, userID, numberFollowers
FROM contentCreator
WHERE NOT NULL;

select * from contentCreatorView;

DROP TABLE IF EXISTS Reviewer;
CREATE TABLE Reviewer (
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
userID INT(10) NOT NULL UNIQUE,
userName VARCHAR(50) NOT NULL,
userPassword VARCHAR(50) NOT NULL,
PRIMARY KEY (userID)
);
CREATE UNIQUE INDEX Reviewer
ON Reviewer (userID);
SELECT * FROM Reviewer;

DROP TABLE IF EXISTS Review;
CREATE TABLE Review (
reviewID INT (5) NOT NULL,
reviewContent VARCHAR(1000) NOT NULL,
reviewScore INT(3),
songID int (10),
userID int(10),
FOREIGN KEY (songID) REFERENCES Song(songID),
FOREIGN KEY (userID) REFERENCES Reviewer(userID)
);
CREATE UNIQUE INDEX Review
ON Review (userID);
SELECT * FROM Review;

drop view if exists reviewAndReviewer;
CREATE VIEW reviewAndReviewer AS
SELECT userName, reviewScore, songID
FROM Review natural join Reviewer natural join Song
WHERE NOT NULL;

select * from reviewAndReviewer;

drop procedure if exists findArtist;

delimiter $$
CREATE PROCEDURE findArtist (
	IN artistName varChar (15)
)
begin
	select
    	stageName
	from
    	contentCreator
	where
    	artistName = stageName;
end$$
delimiter ;

call findArtist('Taylor Swift');

INSERT INTO Listener(FirstName, LastName, userID,userName, userPassword)
VALUES('Jon', 'Doe', 0000000001, 'jdoe123' , 'password123' ),
('Jane', 'Doe', 0000000002,'janedoe456', 'password1234' ),
('John','Smith',0000000003, 'jsmith123', 'password12345');

INSERT INTO Song(songTitle, songID, musicType, Artist, ReleaseDate)
VALUES ('What makes you beautiful', '57864', 'pop', 'One Direction', '08-12-2011'),
   	('Lovely', '25759', 'pop', 'Billie Eilish', '06-10-2018'),
   	('Way back home', '24753', 'Electronic', 'Shaun', '04-08-2018');

INSERT INTO contentCreator(firstName, lastName, userID, numberFollowers)
VALUES('John', 'Rabbit', 000000001, 1980),
  	('Jane', 'Doesong', 000000002, 104500),
  	('alice', 'Wonderland', 0000046, 10530);
 	 
INSERT INTO Reviewer(FirstName, LastName, userID, userName)
VALUES ('niuikn', 'tgftyvi', 9750, 'ytcdetghb'),
   	('niuikn', 'tgftyvi', 2546, 'ytcdetghb'),
   	('niuikn', 'tgftyvi', 1865, 'ytcdetghb');

INSERT INTO Review(songID, reviewID, reviewContent, reviewScore)
VALUES(57864, 00001, 'worst  song ever, lol', 0),
   	(25759,  00002, 'made me cry tears of tears', 100),
   	(24753, 00003, 'wowie', 90);


