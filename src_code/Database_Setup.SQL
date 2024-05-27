-- Start! 
CREATE TABLE Artist (
    ArtistID INT PRIMARY KEY,
    artistName VARCHAR(255) NOT NULL,
    country VARCHAR(255),
	ArtistRank INT,
    monthlyListenerID INT
);

CREATE TABLE User (
    UserID INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    firstName VARCHAR(255),
    middleName VARCHAR(255),
    lastName VARCHAR(255),
    birthDate DATE,
    age INT,
    ArtistID INT
);

CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY,
    ArtistID INT,
    Title VARCHAR(255),
    coverImage VARCHAR(255),
    releaseDate DATE,
    duration INT
);

CREATE TABLE Songs (
    SongID INT PRIMARY KEY,
    ArtistID INT,
    AlbumID INT,
    GenreID INT,
    releaseDate DATE,
    title VARCHAR(255),
    duration INT,
    totalPlays INT,
    Features VARCHAR(255)
);

CREATE TABLE Podcasts (
    PodcastID INT PRIMARY KEY,
    ArtistID INT,
    Title VARCHAR(255),
    coverImage VARCHAR(255),
    releaseDate DATE,
    duration INT
);

CREATE TABLE Genre (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(255)
);

CREATE TABLE AlbumSongs (
    AlbumID INT,
    SongID INT,
    PRIMARY KEY (AlbumID, SongID)
);

CREATE TABLE SongGenres (
    GenreID INT,
    SongID INT,
    ArtistID INT,
    genreName VARCHAR(255),
    PRIMARY KEY (GenreID, SongID, ArtistID)
);

CREATE TABLE UserFollowers (
    followerID INT,
    UserID INT,
    PRIMARY KEY (followerID, UserID)
);

CREATE TABLE UserFollowing (
    followingID INT,
    UserID INT,
    PRIMARY KEY (followingID, UserID)
);

CREATE TABLE UserLikedSongs (
    SongID INT,
    UserID INT,
    PRIMARY KEY (SongID, UserID)
);

CREATE TABLE Playlist (
    PlaylistID INT PRIMARY KEY,
    playlistName VARCHAR(255),
    playlistImage VARCHAR(255),
    isPublic BOOLEAN,
    playlistCreator INT
);

CREATE TABLE PlaylistSongs (
    PlaylistID INT,
    SongID INT,
    PRIMARY KEY (PlaylistID, SongID)
);

CREATE TABLE ListeningHistory (
    HistoryID INT PRIMARY KEY,
    UserID INT,
    ArtistID INT,
    SongID INT,
    listenDate DATE
);

CREATE TABLE ListeningHistoryArtist (
    monthlyListenerID INT,
    ArtistID INT,
    year INT,
    month INT,
    listenerCount INT,
    PRIMARY KEY (monthlyListenerID, ArtistID)
);

-- 2nd Step. 
-- Add foreign key constraints to the Artist table
ALTER TABLE Artist
ADD CONSTRAINT FK_Artist_monthlyListenerID FOREIGN KEY (monthlyListenerID) REFERENCES ListeningHistoryArtist(monthlyListenerID);

-- Add foreign key constraints to the User table
ALTER TABLE User
ADD CONSTRAINT FK_User_ArtistID FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID);

-- Add foreign key constraints to the Albums table
ALTER TABLE Albums
ADD CONSTRAINT FK_Albums_ArtistID FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID);

-- Add foreign key constraints to the Songs table
ALTER TABLE Songs
ADD CONSTRAINT FK_Songs_ArtistID FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID),
ADD CONSTRAINT FK_Songs_AlbumID FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID),
ADD CONSTRAINT FK_Songs_GenreID FOREIGN KEY (GenreID) REFERENCES Genre(GenreID);

-- Add foreign key constraints to the Podcasts table
ALTER TABLE Podcasts
ADD CONSTRAINT FK_Podcasts_ArtistID FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID);

-- Add foreign key constraints to the AlbumSongs table
ALTER TABLE AlbumSongs
ADD CONSTRAINT FK_AlbumSongs_AlbumID FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID),
ADD CONSTRAINT FK_AlbumSongs_SongID FOREIGN KEY (SongID) REFERENCES Songs(SongID);

-- Add foreign key constraints to the SongGenres table
ALTER TABLE SongGenres
ADD CONSTRAINT FK_SongGenres_GenreID FOREIGN KEY (GenreID) REFERENCES Genre(GenreID),
ADD CONSTRAINT FK_SongGenres_SongID FOREIGN KEY (SongID) REFERENCES Songs(SongID),
ADD CONSTRAINT FK_SongGenres_ArtistID FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID);

-- Add foreign key constraints to the UserFollowers table
ALTER TABLE UserFollowers
ADD CONSTRAINT FK_UserFollowers_followerID FOREIGN KEY (followerID) REFERENCES User(UserID),
ADD CONSTRAINT FK_UserFollowers_UserID FOREIGN KEY (UserID) REFERENCES User(UserID);

-- Add foreign key constraints to the UserFollowing table
ALTER TABLE UserFollowing
ADD CONSTRAINT FK_UserFollowing_followingID FOREIGN KEY (followingID) REFERENCES User(UserID),
ADD CONSTRAINT FK_UserFollowing_UserID FOREIGN KEY (UserID) REFERENCES User(UserID);

-- Add foreign key constraints to the UserLikedSongs table
ALTER TABLE UserLikedSongs
ADD CONSTRAINT FK_UserLikedSongs_SongID FOREIGN KEY (SongID) REFERENCES Songs(SongID),
ADD CONSTRAINT FK_UserLikedSongs_UserID FOREIGN KEY (UserID) REFERENCES User(UserID);

-- Add foreign key constraints to the Playlist table
ALTER TABLE Playlist
ADD CONSTRAINT FK_Playlist_playlistCreator FOREIGN KEY (playlistCreator) REFERENCES User(UserID);

-- Add foreign key constraints to the PlaylistSongs table
ALTER TABLE PlaylistSongs
ADD CONSTRAINT FK_PlaylistSongs_PlaylistID FOREIGN KEY (PlaylistID) REFERENCES Playlist(PlaylistID),
ADD CONSTRAINT FK_PlaylistSongs_SongID FOREIGN KEY (SongID) REFERENCES Songs(SongID);

-- Add foreign key constraints to the ListeningHistory table
ALTER TABLE ListeningHistory
ADD CONSTRAINT FK_ListeningHistory_UserID FOREIGN KEY (UserID) REFERENCES User(UserID),
ADD CONSTRAINT FK_ListeningHistory_ArtistID FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID),
ADD CONSTRAINT FK_ListeningHistory_SongID FOREIGN KEY (SongID) REFERENCES Songs(SongID);

-- Add foreign key constraints to the ListeningHistoryArtist table
ALTER TABLE ListeningHistoryArtist
ADD CONSTRAINT FK_ListeningHistoryArtist_ArtistID FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID);

-- 3rd Step. 
INSERT INTO Artist (ArtistID, artistName, country, ArtistRank, monthlyListenerID)
VALUES (1, 'Ed Sheeran', 'United Kingdom', 1, NULL),
       (2, 'Taylor Swift', 'United States', 2, NULL),
       (3, 'BTS', 'South Korea', 3, NULL);
       
-- Insert Dummy data for the ListeningHistoryArtist table
INSERT INTO ListeningHistoryArtist (monthlyListenerID, ArtistID, year, month, listenerCount) VALUES
(1001, 1, 2022, 1, 50000),
(1002, 2, 2022, 1, 60000),
(1003, 3, 2022, 1, 70000);

UPDATE Artist AS a
JOIN ListeningHistoryArtist AS l ON a.ArtistID = l.ArtistID
SET a.monthlyListenerID = l.monthlyListenerID;

-- Dummy data for the User table
INSERT INTO User (UserID, username, email, password, firstName, lastName, birthDate, age, ArtistID) VALUES
(1, 'john_doe', 'john@example.com', 'password123', 'John', 'Doe', '1990-05-15', 34, 1),
(2, 'jane_smith', 'jane@example.com', 'password456', 'Jane', 'Smith', '1995-08-20', 29, 2),
(3, 'mike_jones', 'mike@example.com', 'password789', 'Mike', 'Jones', '1985-02-10', 37, 3);

-- Dummy data for the Albums table
INSERT INTO Albums (AlbumID, ArtistID, Title, coverImage, releaseDate, duration) VALUES
(1, 1, 'Divide', 'divide_cover.jpg', '2017-03-03', 2400),
(2, 2, '1989', '1989_cover.jpg', '2014-10-27', 2100),
(3, 3, 'Love Yourself: Tear', 'love_yourself_tear_cover.jpg', '2018-05-18', 2700);


-- Dummy data for the Genre table
INSERT INTO Genre (GenreID, GenreName) VALUES
(1, 'Pop'),
(2, 'K-Pop');

-- Dummy data for the Songs table
INSERT INTO Songs (SongID, ArtistID, AlbumID, GenreID, releaseDate, title, duration, totalPlays, Features) VALUES
(1, 1, 1, 1, '2017-03-03', 'Shape of You', 235, 1000000, NULL),
(2, 2, 2, 1, '2014-10-27', 'Shake It Off', 219, 800000, NULL),
(3, 3, 3, 2, '2018-05-18', 'Fake Love', 238, 900000, NULL);

-- Dummy data for the Podcasts table
INSERT INTO Podcasts (PodcastID, ArtistID, Title, coverImage, releaseDate, duration) VALUES
(1, 1, 'Ed Sheeran Podcast', 'ed_sheeran_podcast_cover.jpg', '2022-01-01', 3600),
(2, 2, 'Taylor Swift Podcast', 'taylor_swift_podcast_cover.jpg', '2022-01-01', 2700);

-- Dummy data for the AlbumSongs table
INSERT INTO AlbumSongs (AlbumID, SongID) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Dummy data for the SongGenres table
INSERT INTO SongGenres (GenreID, SongID, ArtistID, genreName) VALUES
(1, 1, 1, 'Pop'),
(1, 2, 2, 'Pop'),
(2, 3, 3, 'K-Pop');

-- Dummy data for the UserFollowers table
INSERT INTO UserFollowers (followerID, UserID) VALUES
(2, 1),
(3, 1),
(1, 2);

-- Dummy data for the UserFollowing table
INSERT INTO UserFollowing (followingID, UserID) VALUES
(1, 3),
(2, 3),
(3, 2);

-- Dummy data for the UserLikedSongs table
INSERT INTO UserLikedSongs (SongID, UserID) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Dummy data for the Playlist table
INSERT INTO Playlist (PlaylistID, playlistName, playlistImage, isPublic, playlistCreator) VALUES
(1, 'My Favorites', 'favorites_cover.jpg', 1, 1),
(2, 'Workout Playlist', 'workout_cover.jpg', 1, 2),
(3, 'Chill Vibes', 'chill_vibes_cover.jpg', 1, 3);

-- Dummy data for the PlaylistSongs table
INSERT INTO PlaylistSongs (PlaylistID, SongID) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Dummy data for the ListeningHistory table
INSERT INTO ListeningHistory (HistoryID, UserID, ArtistID, SongID, listenDate) VALUES
(1, 1, 1, 1, '2022-01-01'),
(2, 2, 2, 2, '2022-01-02'),
(3, 3, 3, 3, '2022-01-03');

-- Adding Weather and Season Constraints

-- Add columns to the Songs table
ALTER TABLE Songs
ADD COLUMN weather VARCHAR(255),
ADD COLUMN season VARCHAR(255);

-- Update the weather and season for existing songs
UPDATE Songs
SET weather = 'Sunny', season = 'Summer'
WHERE SongID = 1;

UPDATE Songs
SET weather = 'Rainy', season = 'Autumn'
WHERE SongID = 2;

UPDATE Songs
SET weather = 'Cloudy', season = 'Spring'
WHERE SongID = 3;
