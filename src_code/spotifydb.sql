-- phpMyAdmin SQL Dump
-- version 4.2.4
-- http://www.phpmyadmin.net
--
-- Host: ovid.u.washington.edu:20345
-- Generation Time: May 23, 2019 at 04:58 PM
-- Server version: 5.5.18
-- PHP Version: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `point_of_sale`
--
CREATE DATABASE IF NOT EXISTS `spotifydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `spotifydb`;

-- --------------------------------------------------------

CREATE TABLE Artist (
    ArtistID INT PRIMARY KEY,
    artistName VARCHAR(255) NOT NULL,
    country VARCHAR(255),
	ArtistRank INT,
    monthlyListenerID INT
);

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
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
ADD CONSTRAINT FK_UserFollowers_followerID FOREIGN KEY (followerID) REFERENCES Artist(ArtistID),
ADD CONSTRAINT FK_UserFollowers_UserID FOREIGN KEY (UserID) REFERENCES User(UserID);

-- Add foreign key constraints to the UserFollowing table
ALTER TABLE UserFollowing
ADD CONSTRAINT FK_UserFollowing_followingID FOREIGN KEY (followingID) REFERENCES User(UserID),
ADD CONSTRAINT FK_UserFollowers_followerID FOREIGN KEY (followingID) REFERENCES Artist(ArtistID),
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
VALUES 
(1, 'Ed Sheeran', 'United Kingdom', 1, NULL),
(2, 'Taylor Swift', 'United States', 2, NULL),
(3, 'BTS', 'South Korea', 3, NULL),
(4, 'Drake', 'Canada', 4, NULL),
(5, 'Ariana Grande', 'United States', 5, NULL),
(6, 'Billie Eilish', 'United States', 6, NULL),
(7, 'Post Malone', 'United States', 7, NULL),
(8, 'The Weeknd', 'Canada', 8, NULL),
(9, 'Justin Bieber', 'Canada', 9, NULL),
(10, 'Dua Lipa', 'United Kingdom', 10, NULL),
(11, 'Khalid', 'United States', 11, NULL),
(12, 'Maroon 5', 'United States', 12, NULL),
(13, 'Harry Styles', 'United Kingdom', 13, NULL),
(14, 'Shawn Mendes', 'Canada', 14, NULL),
(15, 'Doja Cat', 'United States', 15, NULL);
       
-- Insert Dummy data for the ListeningHistoryArtist table
INSERT INTO ListeningHistoryArtist (monthlyListenerID, ArtistID, year, month, listenerCount) VALUES
(1001, 1, 2022, 1, 35000000), -- Ed Sheeran
(1002, 2, 2022, 1, 32000000), -- Taylor Swift
(1003, 3, 2022, 1, 38000000), -- BTS
(1004, 4, 2022, 1, 33000000), -- Drake
(1005, 5, 2022, 1, 36000000), -- Ariana Grande
(1006, 6, 2022, 1, 31000000), -- Billie Eilish
(1007, 7, 2022, 1, 29000000), -- Post Malone
(1008, 8, 2022, 1, 34000000), -- The Weeknd
(1009, 9, 2022, 1, 30000000), -- Justin Bieber
(1010, 10, 2022, 1, 28000000), -- Dua Lipa
(1011, 11, 2022, 1, 25000000), -- Khalid
(1012, 12, 2022, 1, 27000000), -- Maroon 5
(1013, 13, 2022, 1, 30000000), -- Harry Styles
(1014, 14, 2022, 1, 28000000), -- Shawn Mendes
(1015, 15, 2022, 1, 35000000); -- Doja Cat


UPDATE Artist AS a
JOIN ListeningHistoryArtist AS l ON a.ArtistID = l.ArtistID
SET a.monthlyListenerID = l.monthlyListenerID;

-- Dummy data for the User table
INSERT INTO User (UserID, username, email, password, firstName, lastName, birthDate, age, ArtistID) VALUES
(1, 'john_doe', 'john@example.com', 'password123', 'John', 'Doe', '1990-05-15', 34, NULL),
(2, 'jane_smith', 'jane@example.com', 'password456', 'Jane', 'Smith', '1995-08-20', 29, NULL),
(3, 'mike_jones', 'mike@example.com', 'password789', 'Mike', 'Jones', '1985-02-10', 37, NULL),
(4, 'sarah_connor', 'sarah@example.com', 'password111', 'Sarah', 'Connor', '1987-12-13', 36, NULL),
(5, 'david_clark', 'david@example.com', 'password222', 'David', 'Clark', '1992-07-22', 31, NULL),
(6, 'emily_johnson', 'emily@example.com', 'password333', 'Emily', 'Johnson', '1998-03-30', 26, NULL),
(7, 'michael_brown', 'michael@example.com', 'password444', 'Michael', 'Brown', '1980-09-14', 43, NULL),
(8, 'laura_white', 'laura@example.com', 'password555', 'Laura', 'White', '1991-05-06', 33, NULL),
(9, 'chris_black', 'chris@example.com', 'password666', 'Chris', 'Black', '1984-11-19', 39, NULL),
(10, 'natalie_green', 'natalie@example.com', 'password777', 'Natalie', 'Green', '1989-01-22', 35, NULL),
(11, 'josh_lee', 'josh@example.com', 'password888', 'Josh', 'Lee', '1993-04-15', 31, NULL),
(12, 'lisa_wong', 'lisa@example.com', 'password999', 'Lisa', 'Wong', '1996-08-25', 27, NULL),
(13, 'kevin_hall', 'kevin@example.com', 'password000', 'Kevin', 'Hall', '1994-02-28', 30, NULL),
(14, 'karen_baker', 'karen@example.com', 'passwordabc', 'Karen', 'Baker', '1982-06-17', 42, NULL),
(15, 'paul_walker', 'paul@example.com', 'passworddef', 'Paul', 'Walker', '1997-12-02', 26, NULL);

-- Dummy data for the Albums table
INSERT INTO Albums (AlbumID, ArtistID, Title, coverImage, releaseDate, duration) VALUES
-- Ed Sheeran
(1, 1, 'Divide', 'https://upload.wikimedia.org/wikipedia/en/4/45/Divide_cover.png', '2017-03-03', 2400),
(2, 1, 'Multiply', 'https://upload.wikimedia.org/wikipedia/en/a/ad/X_cover.png', '2014-06-20', 2550),
(3, 1, 'Plus', 'https://upload.wikimedia.org/wikipedia/en/thumb/3/3f/Ed_Sheeran_%2B_cover.png/220px-Ed_Sheeran_%2B_cover.png', '2011-09-09', 2340),

-- Taylor Swift
(4, 2, '1989', 'https://upload.wikimedia.org/wikipedia/en/d/d5/Taylor_Swift_-_1989_%28Taylor%27s_Version%29.png', '2014-10-27', 2100),
(5, 2, 'Fearless', 'https://upload.wikimedia.org/wikipedia/en/8/86/Taylor_Swift_-_Fearless.png', '2008-11-11', 2300),
(6, 2, 'Red', 'https://upload.wikimedia.org/wikipedia/en/thumb/4/47/Taylor_Swift_-_Red_%28Taylor%27s_Version%29.png/220px-Taylor_Swift_-_Red_%28Taylor%27s_Version%29.png', '2012-10-22', 2300),

-- BTS
(7, 3, 'Love Yourself: Tear', 'love_yourself_tear_cover.jpg', '2018-05-18', 2700),
(8, 3, 'Map of the Soul: 7', 'map_of_the_soul_7_cover.jpg', '2020-02-21', 2750),
(9, 3, 'BE', 'be_cover.jpg', '2020-11-20', 2200),

-- Drake
(10, 4, 'Scorpion', 'scorpion_cover.jpg', '2018-06-29', 3900),
(11, 4, 'Views', 'views_cover.jpg', '2016-04-29', 3100),
(12, 4, 'Take Care', 'take_care_cover.jpg', '2011-11-15', 3450),

-- Ariana Grande
(13, 5, 'Thank U, Next', 'thank_u_next_cover.jpg', '2019-02-08', 2500),
(14, 5, 'Sweetener', 'sweetener_cover.jpg', '2018-08-17', 2500),
(15, 5, 'Dangerous Woman', 'dangerous_woman_cover.jpg', '2016-05-20', 2600),

-- Billie Eilish
(16, 6, 'When We All Fall Asleep, Where Do We Go?', 'when_we_all_fall_asleep_cover.jpg', '2019-03-29', 2600),
(17, 6, 'Happier Than Ever', 'happier_than_ever_cover.jpg', '2021-07-30', 2800),
(18, 6, 'Dont Smile at Me', 'dont_smile_at_me_cover.jpg', '2017-08-11', 1800),

-- Post Malone
(19, 7, 'Hollywoods Bleeding', 'hollywoods_bleeding_cover.jpg', '2019-09-06', 3100),
(20, 7, 'Beerbongs & Bentleys', 'beerbongs_bentleys_cover.jpg', '2018-04-27', 2800),
(21, 7, 'Stoney', 'stoney_cover.jpg', '2016-12-09', 3200),

-- The Weeknd
(22, 8, 'After Hours', 'after_hours_cover.jpg', '2020-03-20', 2600),
(23, 8, 'Starboy', 'starboy_cover.jpg', '2016-11-25', 3800),
(24, 8, 'Beauty Behind the Madness', 'beauty_behind_the_madness_cover.jpg', '2015-08-28', 4200),

-- Justin Bieber
(25, 9, 'Justice', 'justice_cover.jpg', '2021-03-19', 2600),
(26, 9, 'Purpose', 'purpose_cover.jpg', '2015-11-13', 3200),
(27, 9, 'Believe', 'believe_cover.jpg', '2012-06-15', 2700),

-- Dua Lipa
(28, 10, 'Future Nostalgia', 'future_nostalgia_cover.jpg', '2020-03-27', 2300),
(29, 10, 'Dua Lipa', 'dua_lipa_cover.jpg', '2017-06-02', 2900),
(30, 10, 'Club Future Nostalgia', 'club_future_nostalgia_cover.jpg', '2020-08-28', 3100),

-- Khalid
(31, 11, 'Free Spirit', 'free_spirit_cover.jpg', '2019-04-05', 2600),
(32, 11, 'American Teen', 'american_teen_cover.jpg', '2017-03-03', 2600),
(33, 11, 'Suncity', 'suncity_cover.jpg', '2018-10-19', 2100),

-- Maroon 5
(34, 12, 'Songs About Jane', 'songs_about_jane_cover.jpg', '2002-06-25', 3000),
(35, 12, 'V', 'v_cover.jpg', '2014-08-29', 2300),
(36, 12, 'Red Pill Blues', 'red_pill_blues_cover.jpg', '2017-11-03', 2800),

-- Harry Styles
(37, 13, 'Fine Line', 'fine_line_cover.jpg', '2019-12-13', 2700),
(38, 13, 'Harry Styles', 'harry_styles_cover.jpg', '2017-05-12', 2500),
(39, 13, 'Harrys House', 'harrys_house_cover.jpg', '2022-05-20', 2400),

-- Shawn Mendes
(40, 14, 'Shawn Mendes', 'shawn_mendes_cover.jpg', '2018-05-25', 2500),
(41, 14, 'Illuminate', 'illuminate_cover.jpg', '2016-09-23', 2600),
(42, 14, 'Handwritten', 'handwritten_cover.jpg', '2015-04-14', 2700),

-- Doja Cat
(43, 15, 'Hot Pink', 'hot_pink_cover.jpg', '2019-11-07', 2400),
(44, 15, 'Planet Her', 'planet_her_cover.jpg', '2021-06-25', 2700),
(45, 15, 'Amala', 'amala_cover.jpg', '2018-03-30', 2200);


-- Dummy data for the Genre table
INSERT INTO Genre (GenreID, GenreName) VALUES
(1, 'Pop'),
(2, 'K-Pop'),
(3, 'Hip-Hop'),
(4, 'R&B'),
(5, 'Alternative'),
(6, 'Rock');

-- Dummy data for the Songs table
INSERT INTO Songs (SongID, ArtistID, AlbumID, GenreID, releaseDate, title, duration, totalPlays, Features) VALUES
-- Ed Sheeran
(1, 1, 1, 1, '2017-03-03', 'Shape of You', 235, 1000000, NULL),
(2, 1, 1, 1, '2017-03-03', 'Castle on the Hill', 261, 900000, NULL),
(3, 1, 2, 1, '2014-06-20', 'Sing', 236, 800000, NULL),
(4, 1, 2, 1, '2014-06-20', 'Thinking Out Loud', 281, 950000, NULL),
(5, 1, 3, 1, '2011-09-09', 'The A Team', 258, 1100000, NULL),

-- Taylor Swift
(6, 2, 4, 1, '2014-10-27', 'Shake It Off', 219, 800000, NULL),
(7, 2, 4, 1, '2014-10-27', 'Blank Space', 231, 850000, NULL),
(8, 2, 5, 1, '2008-11-11', 'Love Story', 230, 900000, NULL),
(9, 2, 5, 1, '2008-11-11', 'You Belong With Me', 231, 920000, NULL),
(10, 2, 6, 1, '2012-10-22', 'We Are Never Ever Getting Back Together', 193, 950000, NULL),

-- BTS
(11, 3, 7, 2, '2018-05-18', 'Fake Love', 238, 900000, NULL),
(12, 3, 7, 2, '2018-05-18', 'The Truth Untold', 260, 850000, NULL),
(13, 3, 8, 2, '2020-02-21', 'ON', 249, 1000000, NULL),
(14, 3, 8, 2, '2020-02-21', 'Black Swan', 233, 920000, NULL),
(15, 3, 9, 2, '2020-11-20', 'Life Goes On', 230, 890000, NULL),

-- Drake
(16, 4, 10, 3, '2018-06-29', 'Gods Plan', 198, 950000, NULL),
(17, 4, 10, 3, '2018-06-29', 'In My Feelings', 210, 920000, NULL),
(18, 4, 11, 3, '2016-04-29', 'One Dance', 173, 1000000, NULL),
(19, 4, 11, 3, '2016-04-29', 'Hotline Bling', 267, 980000, NULL),
(20, 4, 12, 3, '2011-11-15', 'Take Care', 280, 870000, 'Rihanna'),

-- Ariana Grande
(21, 5, 13, 1, '2019-02-08', '7 Rings', 179, 1000000, NULL),
(22, 5, 13, 1, '2019-02-08', 'Thank U, Next', 207, 970000, NULL),
(23, 5, 14, 1, '2018-08-17', 'No Tears Left to Cry', 210, 890000, NULL),
(24, 5, 14, 1, '2018-08-17', 'God is a Woman', 197, 880000, NULL),
(25, 5, 15, 1, '2016-05-20', 'Dangerous Woman', 236, 950000, NULL),

-- Billie Eilish
(26, 6, 16, 1, '2019-03-29', 'Bad Guy', 194, 1000000, NULL),
(27, 6, 16, 1, '2019-03-29', 'Bury a Friend', 194, 930000, NULL),
(28, 6, 17, 1, '2021-07-30', 'Happier Than Ever', 298, 910000, NULL),
(29, 6, 17, 1, '2021-07-30', 'Therefore I Am', 175, 900000, NULL),
(30, 6, 18, 1, '2017-08-11', 'Ocean Eyes', 200, 850000, NULL),

-- Post Malone
(31, 7, 19, 1, '2019-09-06', 'Circles', 215, 1000000, NULL),
(32, 7, 19, 1, '2019-09-06', 'Goodbyes', 183, 950000, 'Young Thug'),
(33, 7, 20, 3, '2018-04-27', 'Rockstar', 218, 970000, '21 Savage'),
(34, 7, 20, 3, '2018-04-27', 'Better Now', 231, 940000, NULL),
(35, 7, 21, 3, '2016-12-09', 'Congratulations', 222, 890000, 'Quavo'),

-- The Weeknd
(36, 8, 22, 4, '2020-03-20', 'Blinding Lights', 200, 1000000, NULL),
(37, 8, 22, 4, '2020-03-20', 'Save Your Tears', 215, 970000, NULL),
(38, 8, 23, 4, '2016-11-25', 'Starboy', 230, 980000, 'Daft Punk'),
(39, 8, 23, 4, '2016-11-25', 'I Feel It Coming', 269, 950000, 'Daft Punk'),
(40, 8, 24, 4, '2015-08-28', 'Cant Feel My Face', 213, 920000, NULL),

-- Justin Bieber
(41, 9, 25, 1, '2021-03-19', 'Peaches', 198, 1000000, 'Daniel Caesar, Giveon'),
(42, 9, 25, 1, '2021-03-19', 'Hold On', 170, 950000, NULL),
(43, 9, 26, 1, '2015-11-13', 'Sorry', 200, 1000000, NULL),
(44, 9, 26, 1, '2015-11-13', 'Love Yourself', 233, 980000, NULL),
(45, 9, 27, 1, '2012-06-15', 'Boyfriend', 174, 900000, NULL),

-- Dua Lipa
(46, 10, 28, 1, '2020-03-27', 'Dont Start Now', 183, 1000000, NULL),
(47, 10, 28, 1, '2020-03-27', 'Physical', 194, 930000, NULL),
(48, 10, 29, 1, '2017-06-02', 'New Rules', 212, 970000, NULL),
(49, 10, 29, 1, '2017-06-02', 'IDGAF', 222, 950000, NULL),
(50, 10, 30, 1, '2020-08-28', 'Levitating', 203, 980000, 'DaBaby'),

-- Khalid
(51, 11, 31, 1, '2019-04-05', 'Talk', 198, 950000, NULL),
(52, 11, 31, 1, '2019-04-05', 'Better', 209, 910000, NULL),
(53, 11, 32, 1, '2017-03-03', 'Young Dumb & Broke', 222, 1000000, NULL),
(54, 11, 32, 1, '2017-03-03', 'Location', 213, 980000, NULL),
(55, 11, 33, 1, '2018-10-19', 'Suncity', 176, 890000, NULL),

-- Maroon 5
(56, 12, 34, 1, '2002-06-25', 'This Love', 206, 950000, NULL),
(57, 12, 34, 1, '2002-06-25', 'She Will Be Loved', 257, 1000000, NULL),
(58, 12, 35, 1, '2014-08-29', 'Animals', 231, 980000, NULL),
(59, 12, 35, 1, '2014-08-29', 'Sugar', 235, 930000, NULL),
(60, 12, 36, 1, '2017-11-03', 'Girls Like You', 235, 1000000, 'Cardi B'),

-- Harry Styles
(61, 13, 37, 1, '2019-12-13', 'Watermelon Sugar', 174, 1000000, NULL),
(62, 13, 37, 1, '2019-12-13', 'Adore You', 207, 950000, NULL),
(63, 13, 38, 1, '2017-05-12', 'Sign of the Times', 339, 900000, NULL),
(64, 13, 38, 1, '2017-05-12', 'Kiwi', 173, 870000, NULL),
(65, 13, 39, 1, '2022-05-20', 'As It Was', 167, 1000000, NULL),

-- Shawn Mendes
(66, 14, 40, 1, '2018-05-25', 'In My Blood', 217, 950000, NULL),
(67, 14, 40, 1, '2018-05-25', 'Lost in Japan', 202, 910000, NULL),
(68, 14, 41, 1, '2016-09-23', 'Treat You Better', 207, 1000000, NULL),
(69, 14, 41, 1, '2016-09-23', 'Mercy', 208, 970000, NULL),
(70, 14, 42, 1, '2015-04-14', 'Stitches', 207, 980000, NULL),

-- Doja Cat
(71, 15, 43, 1, '2019-11-07', 'Say So', 237, 1000000, NULL),
(72, 15, 43, 1, '2019-11-07', 'Juicy', 194, 930000, 'Tyga'),
(73, 15, 44, 1, '2021-06-25', 'Kiss Me More', 208, 1000000, 'SZA'),
(74, 15, 44, 1, '2021-06-25', 'Need to Know', 211, 970000, NULL),
(75, 15, 45, 1, '2018-03-30', 'Mooo!', 244, 890000, NULL);

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
-- User 1 likes 5 songs
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),

-- User 2 likes 5 songs
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),

-- User 3 likes 5 songs
(11, 3),
(12, 3),
(13, 3),
(14, 3),
(15, 3),

-- User 4 likes 5 songs
(16, 4),
(17, 4),
(18, 4),
(19, 4),
(20, 4),

-- User 5 likes 5 songs
(21, 5),
(22, 5),
(23, 5),
(24, 5),
(25, 5),

-- User 6 likes 5 songs
(26, 6),
(27, 6),
(28, 6),
(29, 6),
(30, 6),

-- User 7 likes 5 songs
(31, 7),
(32, 7),
(33, 7),
(34, 7),
(35, 7),

-- User 8 likes 5 songs
(36, 8),
(37, 8),
(38, 8),
(39, 8),
(40, 8),

-- User 9 likes 5 songs
(41, 9),
(42, 9),
(43, 9),
(44, 9),
(45, 9),

-- User 10 likes 5 songs
(46, 10),
(47, 10),
(48, 10),
(49, 10),
(50, 10),

-- User 11 likes 5 songs
(51, 11),
(52, 11),
(53, 11),
(54, 11),
(55, 11),

-- User 12 likes 5 songs
(56, 12),
(57, 12),
(58, 12),
(59, 12),
(60, 12),

-- User 13 likes 5 songs
(61, 13),
(62, 13),
(63, 13),
(64, 13),
(65, 13),

-- User 14 likes 5 songs
(66, 14),
(67, 14),
(68, 14),
(69, 14),
(70, 14),

-- User 15 likes 5 songs
(71, 15),
(72, 15),
(73, 15),
(74, 15),
(75, 15);

-- Dummy data for the Playlist table
INSERT INTO Playlist (PlaylistID, playlistName, playlistImage, isPublic, playlistCreator) VALUES
-- Playlists for User 1
(1, 'Chill Vibes', 'https://i.pinimg.com/474x/a1/1b/17/a11b1719624fdffb407649ed9390ccd4.jpg', 1, 1),
(2, 'Morning Boost', 'https://external-preview.redd.it/morning-vibes-a-morning-playlist-to-boost-your-mornings-v0-J9lTySWP2hav8FfmAtdMYc4R4WS106NeHqhXB_lrDmo.jpg?auto=webp&s=eddb66a740f50d4bc9e2a712bdb8569d0253c365', 1, 1),

-- Playlists for User 2
(3, 'Workout Hits', 'https://marketplace.canva.com/EAFyzlkEEcI/1/0/1600w/canva-black-illustrative-workout-playlist-cover-D8BP8RPEIe4.jpg', 1, 2),
(4, 'Evening Relaxation', 'https://i.scdn.co/image/ab67706c0000da84b4288d98239b8aa63bd80571', 1, 2),

-- Playlists for User 3
(5, 'Party Anthems', 'party_anthems_cover.jpg', 1, 3),
(6, 'Road Trip', 'road_trip_cover.jpg', 1, 3),
(7, 'Study Tunes', 'study_tunes_cover.jpg', 1, 3),

-- Playlists for User 4
(8, 'Sleepy Time', 'sleepy_time_cover.jpg', 1, 4),
(9, 'Morning Jog', 'morning_jog_cover.jpg', 1, 4),

-- Playlists for User 5
(10, 'Work From Home', 'work_from_home_cover.jpg', 1, 5),
(11, 'Weekend Chill', 'weekend_chill_cover.jpg', 1, 5),

-- Playlists for User 6
(12, 'Driving Beats', 'driving_beats_cover.jpg', 1, 6),
(13, 'Chillax', 'chillax_cover.jpg', 1, 6),
(14, 'Late Night Vibes', 'late_night_vibes_cover.jpg', 1, 6),

-- Playlists for User 7
(15, 'Oldies But Goodies', 'oldies_but_goodies_cover.jpg', 1, 7),
(16, 'Workout Power', 'workout_power_cover.jpg', 1, 7),

-- Playlists for User 8
(17, 'Love Songs', 'love_songs_cover.jpg', 1, 8),
(18, 'Morning Coffee', 'morning_coffee_cover.jpg', 1, 8),

-- Playlists for User 9
(19, 'Motivation Mix', 'motivation_mix_cover.jpg', 1, 9),
(20, 'Evening Chill', 'evening_chill_cover.jpg', 1, 9),
(21, 'Focus Music', 'focus_music_cover.jpg', 1, 9),

-- Playlists for User 10
(22, 'Party Time', 'party_time_cover.jpg', 1, 10),
(23, 'Sunday Relax', 'sunday_relax_cover.jpg', 1, 10),

-- Playlists for User 11
(24, 'Pump Up', 'pump_up_cover.jpg', 1, 11),
(25, 'Acoustic Mornings', 'acoustic_mornings_cover.jpg', 1, 11),

-- Playlists for User 12
(26, 'Jazz Evenings', 'jazz_evenings_cover.jpg', 1, 12),
(27, 'Electronic Nights', 'electronic_nights_cover.jpg', 1, 12),
(28, 'Relaxing Acoustic', 'relaxing_acoustic_cover.jpg', 1, 12),

-- Playlists for User 13
(29, 'Hip-Hop Vibes', 'hiphop_vibes_cover.jpg', 1, 13),
(30, 'Workout Mix', 'workout_mix_cover.jpg', 1, 13),

-- Playlists for User 14
(31, 'Morning Workout', 'morning_workout_cover.jpg', 1, 14),
(32, 'Evening Calm', 'evening_calm_cover.jpg', 1, 14),

-- Playlists for User 15
(33, 'Top Hits', 'top_hits_cover.jpg', 1, 15),
(34, 'Soft Rock', 'soft_rock_cover.jpg', 1, 15),
(35, 'Classical Focus', 'classical_focus_cover.jpg', 1, 15);

-- Dummy data for the PlaylistSongs table
INSERT INTO PlaylistSongs (PlaylistID, SongID) VALUES
-- Songs for User 1's Playlists
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5),

-- Songs for User 2's Playlists
(3, 6), (3, 7), (3, 8), (3, 9), (3, 10),
(4, 6), (4, 7), (4, 8), (4, 9), (4, 10),

-- Songs for User 3's Playlists
(5, 11), (5, 12), (5, 13), (5, 14), (5, 15),
(6, 11), (6, 12), (6, 13), (6, 14), (6, 15),
(7, 11), (7, 12), (7, 13), (7, 14), (7, 15),

-- Songs for User 4's Playlists
(8, 16), (8, 17), (8, 18), (8, 19), (8, 20),
(9, 16), (9, 17), (9, 18), (9, 19), (9, 20),

-- Songs for User 5's Playlists
(10, 21), (10, 22), (10, 23), (10, 24), (10, 25),
(11, 21), (11, 22), (11, 23), (11, 24), (11, 25),

-- Songs for User 6's Playlists
(12, 26), (12, 27), (12, 28), (12, 29), (12, 30),
(13, 26), (13, 27), (13, 28), (13, 29), (13, 30),
(14, 26), (14, 27), (14, 28), (14, 29), (14, 30),

-- Songs for User 7's Playlists
(15, 31), (15, 32), (15, 33), (15, 34), (15, 35),
(16, 31), (16, 32), (16, 33), (16, 34), (16, 35),

-- Songs for User 8's Playlists
(17, 36), (17, 37), (17, 38), (17, 39), (17, 40),
(18, 36), (18, 37), (18, 38), (18, 39), (18, 40),

-- Songs for User 9's Playlists
(19, 41), (19, 42), (19, 43), (19, 44), (19, 45),
(20, 41), (20, 42), (20, 43), (20, 44), (20, 45),
(21, 41), (21, 42), (21, 43), (21, 44), (21, 45),

-- Songs for User 10's Playlists
(22, 46), (22, 47), (22, 48), (22, 49), (22, 50),
(23, 46), (23, 47), (23, 48), (23, 49), (23, 50),

-- Songs for User 11's Playlists
(24, 51), (24, 52), (24, 53), (24, 54), (24, 55),
(25, 51), (25, 52), (25, 53), (25, 54), (25, 55),

-- Songs for User 12's Playlists
(26, 56), (26, 57), (26, 58), (26, 59), (26, 60),
(27, 56), (27, 57), (27, 58), (27, 59), (27, 60),
(28, 56), (28, 57), (28, 58), (28, 59), (28, 60),

-- Songs for User 13's Playlists
(29, 61), (29, 62), (29, 63), (29, 64), (29, 65),
(30, 61), (30, 62), (30, 63), (30, 64), (30, 65),

-- Songs for User 14's Playlists
(31, 66), (31, 67), (31, 68), (31, 69), (31, 70),
(32, 66), (32, 67), (32, 68), (32, 69), (32, 70),

-- Songs for User 15's Playlists
(33, 71), (33, 72), (33, 73), (33, 74), (33, 75),
(34, 71), (34, 72), (34, 73), (34, 74), (34, 75),
(35, 71), (35, 72), (35, 73), (35, 74), (35, 75);

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
-- Ed Sheeran
UPDATE Songs SET weather = 'Sunny', season = 'Summer' WHERE SongID = 1;
UPDATE Songs SET weather = 'Rainy', season = 'Autumn' WHERE SongID = 2;
UPDATE Songs SET weather = 'Cloudy', season = 'Spring' WHERE SongID = 3;
UPDATE Songs SET weather = 'Snowy', season = 'Winter' WHERE SongID = 4;
UPDATE Songs SET weather = 'Windy', season = 'Autumn' WHERE SongID = 5;

-- Taylor Swift
UPDATE Songs SET weather = 'Sunny', season = 'Spring' WHERE SongID = 6;
UPDATE Songs SET weather = 'Rainy', season = 'Winter' WHERE SongID = 7;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 8;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 9;
UPDATE Songs SET weather = 'Windy', season = 'Spring' WHERE SongID = 10;

-- BTS
UPDATE Songs SET weather = 'Sunny', season = 'Winter' WHERE SongID = 11;
UPDATE Songs SET weather = 'Rainy', season = 'Spring' WHERE SongID = 12;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 13;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 14;
UPDATE Songs SET weather = 'Windy', season = 'Winter' WHERE SongID = 15;

-- Drake
UPDATE Songs SET weather = 'Sunny', season = 'Summer' WHERE SongID = 16;
UPDATE Songs SET weather = 'Rainy', season = 'Autumn' WHERE SongID = 17;
UPDATE Songs SET weather = 'Cloudy', season = 'Spring' WHERE SongID = 18;
UPDATE Songs SET weather = 'Snowy', season = 'Winter' WHERE SongID = 19;
UPDATE Songs SET weather = 'Windy', season = 'Autumn' WHERE SongID = 20;

-- Ariana Grande
UPDATE Songs SET weather = 'Sunny', season = 'Spring' WHERE SongID = 21;
UPDATE Songs SET weather = 'Rainy', season = 'Winter' WHERE SongID = 22;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 23;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 24;
UPDATE Songs SET weather = 'Windy', season = 'Spring' WHERE SongID = 25;

-- Billie Eilish
UPDATE Songs SET weather = 'Sunny', season = 'Winter' WHERE SongID = 26;
UPDATE Songs SET weather = 'Rainy', season = 'Spring' WHERE SongID = 27;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 28;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 29;
UPDATE Songs SET weather = 'Windy', season = 'Winter' WHERE SongID = 30;

-- Post Malone
UPDATE Songs SET weather = 'Sunny', season = 'Summer' WHERE SongID = 31;
UPDATE Songs SET weather = 'Rainy', season = 'Autumn' WHERE SongID = 32;
UPDATE Songs SET weather = 'Cloudy', season = 'Spring' WHERE SongID = 33;
UPDATE Songs SET weather = 'Snowy', season = 'Winter' WHERE SongID = 34;
UPDATE Songs SET weather = 'Windy', season = 'Autumn' WHERE SongID = 35;

-- The Weeknd
UPDATE Songs SET weather = 'Sunny', season = 'Spring' WHERE SongID = 36;
UPDATE Songs SET weather = 'Rainy', season = 'Winter' WHERE SongID = 37;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 38;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 39;
UPDATE Songs SET weather = 'Windy', season = 'Spring' WHERE SongID = 40;

-- Justin Bieber
UPDATE Songs SET weather = 'Sunny', season = 'Winter' WHERE SongID = 41;
UPDATE Songs SET weather = 'Rainy', season = 'Spring' WHERE SongID = 42;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 43;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 44;
UPDATE Songs SET weather = 'Windy', season = 'Winter' WHERE SongID = 45;

-- Dua Lipa
UPDATE Songs SET weather = 'Sunny', season = 'Summer' WHERE SongID = 46;
UPDATE Songs SET weather = 'Rainy', season = 'Autumn' WHERE SongID = 47;
UPDATE Songs SET weather = 'Cloudy', season = 'Spring' WHERE SongID = 48;
UPDATE Songs SET weather = 'Snowy', season = 'Winter' WHERE SongID = 49;
UPDATE Songs SET weather = 'Windy', season = 'Autumn' WHERE SongID = 50;

-- Khalid
UPDATE Songs SET weather = 'Sunny', season = 'Spring' WHERE SongID = 51;
UPDATE Songs SET weather = 'Rainy', season = 'Winter' WHERE SongID = 52;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 53;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 54;
UPDATE Songs SET weather = 'Windy', season = 'Spring' WHERE SongID = 55;

-- Maroon 5
UPDATE Songs SET weather = 'Sunny', season = 'Winter' WHERE SongID = 56;
UPDATE Songs SET weather = 'Rainy', season = 'Spring' WHERE SongID = 57;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 58;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 59;
UPDATE Songs SET weather = 'Windy', season = 'Winter' WHERE SongID = 60;

-- Harry Styles
UPDATE Songs SET weather = 'Sunny', season = 'Summer' WHERE SongID = 61;
UPDATE Songs SET weather = 'Rainy', season = 'Autumn' WHERE SongID = 62;
UPDATE Songs SET weather = 'Cloudy', season = 'Spring' WHERE SongID = 63;
UPDATE Songs SET weather = 'Snowy', season = 'Winter' WHERE SongID = 64;
UPDATE Songs SET weather = 'Windy', season = 'Autumn' WHERE SongID = 65;

-- Shawn Mendes
UPDATE Songs SET weather = 'Sunny', season = 'Spring' WHERE SongID = 66;
UPDATE Songs SET weather = 'Rainy', season = 'Winter' WHERE SongID = 67;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 68;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 69;
UPDATE Songs SET weather = 'Windy', season = 'Spring' WHERE SongID = 70;

-- Doja Cat
UPDATE Songs SET weather = 'Sunny', season = 'Winter' WHERE SongID = 71;
UPDATE Songs SET weather = 'Rainy', season = 'Spring' WHERE SongID = 72;
UPDATE Songs SET weather = 'Cloudy', season = 'Summer' WHERE SongID = 73;
UPDATE Songs SET weather = 'Snowy', season = 'Autumn' WHERE SongID = 74;
UPDATE Songs SET weather = 'Windy', season = 'Winter' WHERE SongID = 75;
