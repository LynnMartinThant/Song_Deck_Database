
-- Artist Table
CREATE TABLE Artist (
   artist_id VARCHAR(20) PRIMARY KEY NOT NULL,
   CHECK (artist_id LIKE 'Artist-0020%') ,
   artist_name VARCHAR(100) NOT NULL,
  Artist_Genere VARCHAR (100),
   country VARCHAR(50),
   biography TEXT,
   debut_date DATE,
   total_followers INT DEFAULT 1000,
   profile_image VARCHAR(255),
 
);
SELECT * FROM Artist;

-- Registered User Account Table
CREATE TABLE Registered_User_Account (
   user_id VARCHAR(20) PRIMARY KEY,
   username VARCHAR(50) NOT NULL UNIQUE,
   email VARCHAR(100) NOT NULL UNIQUE,
   CHECK (user_id LIKE 'Usr-0021%'),
   password VARCHAR(255) NOT NULL,
   full_name VARCHAR(100),
   join_date DATETIME,
   profile_picture VARCHAR(255),
   last_login_date DATETIME
);
SELECT * FROM Registered_User_Account;

-- Album Table
CREATE TABLE Album (
   album_id VARCHAR(20) PRIMARY KEY,
   CHECK (album_id LIKE 'Alb-0082%'),
   album_name VARCHAR(100) NOT NULL,
   artist_id VARCHAR(20),
   release_date DATE,
   genre VARCHAR(50),
   total_tracks INT,
   album_cover VARCHAR(255),
   FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
);
SELECT * FROM Album;

-- Song Table
CREATE TABLE Song (
   song_id VARCHAR(20) PRIMARY KEY,
   CHECK (song_id LIKE 'song-0092%'),
   title VARCHAR(100) NOT NULL,
   artist_id VARCHAR(20),
   album_id VARCHAR(20),
   duration TIME NOT NULL,
   release_date DATE,
   genre VARCHAR(50),
   Total_play_count INT,
   language VARCHAR(50) DEFAULT 'English', -- New column
   FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE,
   FOREIGN KEY (album_id) REFERENCES Album(album_id)
);
SELECT * FROM Song;


-- Curator Table
CREATE TABLE Curator (
   curator_id VARCHAR(20) PRIMARY KEY,
   curator_name VARCHAR(100),
   curator_email VARCHAR(100),
   curator_phone VARCHAR(15),
   curator_joined_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM Curator;


-- Plan Table
CREATE TABLE Plan_ (
   plan_id VARCHAR(20) PRIMARY KEY,
   CHECK (plan_id LIKE 'Plan_0021%'),
   plan_name VARCHAR(50) NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   duration_months INT NOT NULL,
   features TEXT,
   max_devices INT,
   audio_quality VARCHAR(50),
   stream_quality VARCHAR (50)
);


SELECT * FROM Plan_;




-- User-Artist Follow Table
CREATE TABLE User_Artist_Follow (
   follow_id VARCHAR(20) PRIMARY KEY,
   CHECK (follow_id LIKE 'follow_0094%'),
   user_id VARCHAR(20),
   artist_id VARCHAR(20),
   follow_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   last_interaction_date DATETIME,
   FOREIGN KEY (user_id) REFERENCES Registered_User_Account(user_id),
   FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
);
SELECT * FROM User_Artist_Follow;



-- User Listen Song Table
CREATE TABLE User_Listen_Song (
   listen_id VARCHAR(20) PRIMARY KEY,
   CHECK (listen_id LIKE 'listen_0090%'),
   user_id VARCHAR(20),
   listen_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   listen_duration TIME,
   device_type VARCHAR(50),
   location VARCHAR(100),
   FOREIGN KEY (user_id) REFERENCES Registered_User_Account(user_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE,
);
SELECT * FROM User_Listen_Song;





-- Playlist Table
CREATE TABLE Playlist (
   playlist_id VARCHAR(20) PRIMARY KEY,
   CHECK (playlist_id LIKE 'Playlist_0087%'),
   playlist_name VARCHAR(100) NOT NULL,
   user_id VARCHAR(20),
   creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   description TEXT,
   cover_image VARCHAR(255),
   total_duration TIME,
   playlist_type Varchar (50),
   FOREIGN KEY (user_id) REFERENCES Registered_User_Account(user_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
);
SELECT * FROM Playlist;


-- Create Playlist Table
CREATE TABLE Create_Playlist (
   create_id VARCHAR(20) PRIMARY KEY,
   CHECK (create_id LIKE 'Create_0017%'),
   playlist_id VARCHAR(20),
   user_id VARCHAR(20),
   created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   last_modified_date DATETIME,
   FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE,
   FOREIGN KEY (user_id) REFERENCES Registered_User_Account(user_id)
);


SELECT * FROM Create_Playlist;






-- Subscribe Plan Table
CREATE TABLE Subscribe_Plan (
   subscription_id VARCHAR(20) PRIMARY KEY,
   CHECK (subscription_id LIKE 'Sub_0023%'),
   user_id VARCHAR(20),
   plan_id VARCHAR(20),
   start_date DATE NOT NULL,
   end_date DATE,
   last_payment_date DATE,
   FOREIGN KEY (user_id) REFERENCES Registered_User_Account(user_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE,
   FOREIGN KEY (plan_id) REFERENCES Plan_(plan_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
);




SELECT * FROM Subscribe_Plan;


-- Playlist Song Table
CREATE TABLE Playlist_Song (
   playlist_song_id VARCHAR(20) PRIMARY KEY,
   CHECK (playlist_song_id LIKE 'Play_0054%'),
   playlist_id VARCHAR(20),
   song_id VARCHAR(20),
   added_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   added_by VARCHAR(20),
   order_number INT,
   FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE,
   FOREIGN KEY (song_id) REFERENCES Song(song_id)
      ON DELETE NO ACTION
      ON UPDATE CASCADE,
   FOREIGN KEY (added_by) REFERENCES Registered_User_Account(user_id)
);

SELECT * FROM Playlist_Song;


-- Platform Table
CREATE TABLE Platform (
   platform_id VARCHAR(20) PRIMARY KEY,
   CHECK (platform_id LIKE 'Plat_0075%'),
   platform_name VARCHAR(50) NOT NULL,
   platform_url VARCHAR(255),
   api_key VARCHAR(255),
   integration_date DATE,
   last_sync_date DATETIME,
   icon_url VARCHAR(255)
);
SELECT * FROM Platform;


-- Share Playlist Platform Table
CREATE TABLE Share_Playlist_Platform (
   share_id VARCHAR(20) PRIMARY KEY CHECK (share_id LIKE 'share_0066%'),
   playlist_id VARCHAR(20),
   platform_id VARCHAR(20),
   user_id VARCHAR(20),
   share_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   share_url VARCHAR(255),
   FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
   FOREIGN KEY (platform_id) REFERENCES Platform(platform_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
   FOREIGN KEY (user_id) REFERENCES Registered_User_Account(user_id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

SELECT * FROM Share_Playlist_Platform





CREATE TABLE Create_Playlist_Detail (
    user_id VARCHAR(20),
    Playlist_ID VARCHAR(20) PRIMARY KEY,
    Number_of_Popular_Hit VARCHAR(225),
    create_id VARCHAR(20),
FOREIGN KEY (user_id) REFERENCES Registered_User_Account (user_id)
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
FOREIGN KEY (Create_ID) REFERENCES Create_Playlist(create_id)
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);
 
-- Table: Playlist_Song
 
 
-- Table: User_Listen_Song_Detail
CREATE TABLE User_Listen_Song_Detail (
    song_id VARCHAR(20),
    Listen_ID VARCHAR(20),
    Recent_Played DATETIME,
    user_id VARCHAR(20),
   FOREIGN KEY ( User_ID ) REFERENCES Registered_User_Account(user_id)
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
FOREIGN KEY ( song_id ) REFERENCES Song( song_id )
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);
 
-- Table: User_Artist_Follow_Detail
CREATE TABLE User_Artist_Follow_Detail (
    User_ID VARCHAR(20),
    follow_id VARCHAR(20) PRIMARY KEY,
    artist_id VARCHAR(20),
    Latest_Followed_Date DATE,
  FOREIGN KEY ( User_ID ) REFERENCES Registered_User_Account(user_id)
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
FOREIGN KEY (Artist_ID) REFERENCES Artist( artist_id )
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);













INSERT INTO Artist (artist_id, artist_name, Artist_Genere, country, biography, debut_date, total_followers, profile_image)
VALUES
('Artist-002001', 'John Doe', 'Pop', 'USA', 'A talented pop singer.', '2015-06-01', 1500, 'john_doe_profile.jpg'),
('Artist-002002', 'Jane Smith', 'Rock', 'UK', 'A rising rock star.', '2017-09-10', 2000, 'jane_smith_profile.jpg'),
('Artist-002003', 'Michael Ray', 'Jazz', 'Canada', 'Master of smooth jazz music.', '2014-11-22', 1800, 'michael_ray_profile.jpg'),
('Artist-002004', 'Lilly White', 'R&B', 'USA', 'Known for soulful R&B hits.', '2019-04-12', 2200, 'lilly_white_profile.jpg'),
('Artist-002005', 'Carlos Santana', 'Latin', 'Mexico', 'Legendary Latin musician.', '1965-03-10', 2500, 'carlos_santana_profile.jpg'),
('Artist-002006', 'Anna Belle', 'Pop', 'Canada', 'Fresh pop talent.', '2020-01-15', 1300, 'anna_belle_profile.jpg'),
('Artist-002007', 'Mark Phillips', 'Blues', 'USA', 'A soulful blues guitarist.', '2016-07-07', 1700, 'mark_phillips_profile.jpg'),
('Artist-002008', 'Sofia Lopez', 'Reggaeton', 'Puerto Rico', 'Dynamic reggaeton performer.', '2018-08-20', 2300, 'sofia_lopez_profile.jpg'),
('Artist-002009', 'The Weekend Band', 'Rock', 'USA', 'A classic rock group.', '2011-05-09', 5000, 'weekend_band_profile.jpg'),
('Artist-002010', 'Charlie Brown', 'Hip Hop', 'UK', 'UK-based rapper with deep lyrics.', '2017-12-13', 1400, 'charlie_brown_profile.jpg');


Select * From Artist





 
-- Registered User Account Table Inserts (Fixed quotes)
INSERT INTO Registered_User_Account (user_id, username, email, password, full_name, join_date, profile_picture, last_login_date)
VALUES
('Usr-00210001', 'john', 'john.doe@example.com', 'password123', 'John Doe', '2025-01-01 10:00:00', 'john_doe.jpg', '2025-01-10 09:00:00'),
('Usr-00210002', 'smith', 'jane.smith@example.com', 'securePassword456', 'Jane Smith', '2024-12-15 14:30:00', 'jane_smith.jpg', '2025-01-10 08:45:00'),
('Usr-00210003', 'ray', 'michael.ray@example.com', '123Password!789', 'Michael Ray', '2025-01-03 12:00:00', 'michael_ray.jpg', '2025-01-09 16:00:00'),
('Usr-00210004', 'Justin', 'lilly.white@example.com', 'lillyPass@321', 'Lilly White', '2024-11-22 08:00:00', 'lilly_white.jpg', '2025-01-09 10:30:00'),
('Usr-00210005', 'Anaggha', 'carlos.santana@example.com', 'S@ntanaPassword2024', 'Carlos Santana', '2024-10-11 15:20:00', 'carlos_santana.jpg', '2025-01-08 17:00:00'),
('Usr-00210006', 'Barbuu', 'anna.belle@example.com', 'annaBelle123', 'Anna Belle', '2025-01-05 18:00:00', 'anna_belle.jpg', '2025-01-10 14:30:00'),
('Usr-00210007', 'martin', 'mark.phillips@example.com', 'bluesRocks_007', 'Mark Phillips', '2024-08-20 11:30:00', 'mark_phillips.jpg', '2025-01-09 18:45:00'),
('Usr-00210008', 'Mango', 'sofia.lopez@example.com', 'SofiaReggaeton@99', 'Sofia Lopez', '2024-09-25 09:00:00', 'sofia_lopez.jpg', '2025-01-10 13:15:00'),
('Usr-00210009', 'Zane', 'weekend.band@example.com', 'WeekendBand@2025', 'The Weekend Band', '2024-06-05 07:45:00', 'weekend_band.jpg', '2025-01-10 11:30:00'),
('Usr-00210010', 'charlie_brown', 'charlie.brown@example.com', 'CharlieRap2025', 'Charlie Brown', '2024-12-01 10:30:00', 'charlie_brown.jpg', '2025-01-10 09:15:00');



Select * From  Registered_User_Account
 





-- Album Table Inserts
INSERT INTO Album (album_id, album_name, artist_id, release_date, genre, total_tracks, album_cover)
VALUES
('Alb-00820001', 'Future Nostalgia', 'Artist-002001', '2020-03-27', 'Pop', 11, 'futurenostalgia_cover.jpg'),
('Alb-00820002', '21', 'Artist-002002', '2011-01-24', 'Pop/Soul', 11, '21_album_cover.jpg'),
('Alb-00820003', 'The Dark Side of the Moon', 'Artist-002003', '1973-03-01', 'Progressive Rock', 10, 'dark_side_cover.jpg'),
('Alb-00820004', 'Back to Black', 'Artist-002004', '2006-10-27', 'Soul/R&B', 10, 'back_to_black_cover.jpg'),
('Alb-00820005', 'Supernatural', 'Artist-002005', '1999-06-15', 'Latin Rock', 13, 'supernatural_cover.jpg'),
('Alb-00820006', 'The Fame', 'Artist-002006', '2008-08-19', 'Pop', 15, 'the_fame_cover.jpg'),
('Alb-00820007', 'Blues Breakers with Eric Clapton', 'Artist-002007', '1966-07-01', 'Blues', 12, 'blues_breakers_cover.jpg'),
('Alb-00820008', 'El Mal Querer', 'Artist-002008', '2018-11-02', 'Reggaeton', 10, 'el_mal_querer_cover.jpg'),
('Alb-00820009', 'Abbey Road', 'Artist-002009', '1969-09-26', 'Rock', 17, 'abbey_road_cover.jpg'),
('Alb-00820010', 'The Chronic', 'Artist-002010', '1992-12-15', 'Hip Hop', 16, 'the_chronic_cover.jpg');


Select * From  Album
 







-- Song Table Inserts

INSERT INTO Song (song_id, title, artist_id, album_id, duration, release_date, genre, Total_play_count, language)
VALUES
('song-00920001', 'Levitating', 'Artist-002001', 'Alb-00820001', '00:03:23', '2020-03-27', 'Pop', 1000000, 'English'),
('song-00920002', 'Someone Like You', 'Artist-002002', 'Alb-00820002', '00:04:45', '2011-01-24', 'Pop/Soul', 5000000, 'English'),
('song-00920003', 'Money', 'Artist-002003', 'Alb-00820003', '00:03:15', '2022-08-26', 'Jazz', 150000, 'English'),
('song-00920004', 'Back to Black', 'Artist-002004', 'Alb-00820004', '00:04:00', '2006-10-27', 'Soul/R&B', 2500000, 'English'),
('song-00920005', 'Smooth', 'Artist-002005', 'Alb-00820005', '00:04:58', '1999-06-15', 'Latin Rock', 4500000, 'English'),
('song-00920006', 'Just Dance', 'Artist-002006', 'Alb-00820006', '00:04:02', '2008-08-19', 'Pop', 3500000, 'English'),
('song-00920007', 'Tears in Heaven', 'Artist-002007', 'Alb-00820007', '00:04:33', '1992-01-08', 'Blues', 2000000, 'English'),
('song-00920008', 'Malamente', 'Artist-002008', 'Alb-00820008', '00:03:29', '2018-11-02', 'Reggaeton', 3000000, 'Spanish'),
('song-00920009', 'Come Together', 'Artist-002009', 'Alb-00820009', '00:04:20', '1969-09-26', 'Rock', 7000000, 'English'),
('song-00920010', 'Nuthin But a G Thang', 'Artist-002010', 'Alb-00820010', '00:03:58', '1992-03-19', 'Hip Hop', 4500000, 'English');

Select * From  Song

 
-- Curator Table Inserts

 
-- Plan_1 Table Inserts
INSERT INTO Plan_ (plan_id, plan_name, price, duration_months, features, max_devices, audio_quality, stream_quality)
VALUES
('Plan_00210001', 'Basic', 9.99, 1, 'Access to 200 songs, standard audio quality, ads', 1, 'Standard', 'HD'),
('Plan_00210002', 'Standard', 14.99, 1, 'Access to 500 songs, offline listening, no ads', 2, 'High', 'Full HD'),
('Plan_00210003', 'Premium', 19.99, 1, 'Access to 1000+ songs, offline listening, no ads, priority support', 5, 'High', '4K'),
('Plan_00210004', 'Family', 29.99, 1, 'Up to 6 accounts, access to 1000+ songs, no ads', 6, 'High', '4K'),
('Plan_00210005', 'Student', 4.99, 1, 'Access to 500 songs, no ads, discounted price for students', 1, 'High', 'HD'),
('Plan_00210006', 'Solo Premium', 12.99, 1, 'Access to 300 songs, offline listening, ad-free, priority support', 1, 'High', 'HD'),
('Plan_00210007', 'Family Premium', 39.99, 1, 'Up to 8 accounts, 1000+ songs, offline listening, ad-free', 8, 'High', '4K'),
('Plan_00210008', 'Lite', 7.99, 1, 'Access to 100 songs, standard audio quality, ads', 1, 'Standard', 'HD'),
('Plan_00210009', 'Corporate', 99.99, 12, 'Unlimited accounts, premium features, offline access, priority support', 100, 'High', '4K'),
('Plan_00210010', 'Trial', 0.00, 1, 'Limited access to 50 songs, standard audio, 7-day trial', 1, 'Standard', 'SD');




Select * From Plan_
 



-- User_Artist_Follow Table Inserts

INSERT INTO User_Artist_Follow (follow_id, user_id, artist_id, follow_date, last_interaction_date)
VALUES
('follow_00940001', 'Usr-00210001', 'Artist-002001', '2024-07-25 08:12:35', '2024-08-01 14:45:10'),
('follow_00940002', 'Usr-00210002', 'Artist-002002', '2024-08-15 10:30:22', '2024-08-16 09:21:00'),
('follow_00940003', 'Usr-00210003', 'Artist-002003', '2024-09-05 15:55:48', '2024-09-06 11:20:11'),
('follow_00940004', 'Usr-00210004', 'Artist-002004', '2024-09-15 11:05:02', '2024-09-17 13:50:25'),
('follow_00940005', 'Usr-00210005', 'Artist-002005', '2024-10-01 14:00:00', '2024-10-03 18:30:12'),
('follow_00940006', 'Usr-00210006', 'Artist-002006', '2024-10-10 16:05:30', '2024-10-12 17:15:50'),
('follow_00940007', 'Usr-00210007', 'Artist-002007', '2024-10-20 09:25:15', '2024-10-22 11:40:00'),
('follow_00940008', 'Usr-00210008', 'Artist-002008', '2024-11-05 19:33:42', '2024-11-07 14:10:23'),
('follow_00940009', 'Usr-00210009', 'Artist-002009', '2024-11-10 13:00:00', '2024-11-12 16:10:55'),
('follow_00940010', 'Usr-00210010', 'Artist-002005', '2024-12-01 07:25:03', '2024-12-02 08:40:19');



Select * From  User_Artist_Follow


INSERT INTO Playlist (playlist_id, playlist_name, user_id, creation_date, description, cover_image, total_duration, playlist_type)
VALUES
('Playlist_008701', 'Chill Vibes', 'Usr-00210001', '2024-05-15 14:20:00', 'A relaxing mix of mellow tunes perfect for unwinding.', 'cover_image_1.jpg', '01:30:45', 'Personal'),
('Playlist_008702', 'Workout Pump', 'Usr-00210002', '2024-06-10 09:05:00', 'High-energy tracks to get you moving and motivated.', 'cover_image_2.jpg', '00:50:30', 'Personal'),
('Playlist_008703', 'Summer Hits', 'Usr-00210003', '2024-07-01 16:45:00', 'The best hits of the summer, perfect for sunny days.', 'cover_image_3.jpg', '02:00:00', 'Public'),
('Playlist_008704', 'Study Playlist', 'Usr-00210004', '2024-08-21 10:10:00', 'Instrumental and calm music to help focus while studying.', 'cover_image_4.jpg', '01:45:20', 'Personal'),
('Playlist_008705', 'Party Jams', 'Usr-00210005', '2024-09-05 20:00:00', 'Non-stop tracks for an unforgettable party experience.', 'cover_image_5.jpg', '01:20:10', 'Public'),
('Playlist_008706', 'Indie Rock Favorites', 'Usr-00210006', '2024-10-10 18:30:00', 'A curated selection of the best indie rock songs.', 'cover_image_6.jpg', '01:15:30', 'Personal'),
('Playlist_008707', 'Classical Relaxation', 'Usr-00210007', '2024-11-12 12:00:00', 'A peaceful mix of classical music for deep relaxation.', 'cover_image_7.jpg', '02:10:15', 'Public'),
('Playlist_008708', 'Top 40 Hits', 'Usr-00210008', '2024-12-01 08:00:00', 'The latest and greatest chart-topping songs.', 'cover_image_8.jpg', '01:30:00', 'Collaborative'),
('Playlist_008709', 'Road Trip Tunes', 'Usr-00210009', '2024-12-15 17:25:00', 'Perfect playlist for a long drive through scenic routes.', 'cover_image_9.jpg', '03:00:30', 'Public'),
('Playlist_008710', 'Mood Boosters', 'Usr-00210010', '2024-12-20 14:50:00', 'Feel-good tracks to improve your mood instantly.', 'cover_image_10.jpg', '01:10:45', 'Collaborative');
SELECT * FROM Playlist

 
-- User_Listen_Song Table Inserts

INSERT INTO User_Listen_Song (listen_id, user_id, song_id, listen_date, listen_duration, device_type, location)
VALUES
('listen_009001', 'Usr-00210001', 'song-00920001', '2023-01-01 10:00:00', '00:04:30', 'Mobile', 'New York'),
('listen_009002', 'Usr-00210002', 'song-00920002', '2023-01-02 11:30:00', '00:03:45', 'Desktop', 'London'),
('listen_009003', 'Usr-00210003', 'song-00920003', '2023-01-03 09:15:00', '00:04:15', 'Tablet', 'London'),
('listen_009004', 'Usr-00210004', 'song-00920004', '2023-01-04 13:45:00', '00:05:30', 'Mobile', 'London'),
('listen_009005', 'Usr-00210005', 'song-00920005', '2023-01-05 15:20:00', '00:06:00', 'Desktop', 'Berlin'),
('listen_009006', 'Usr-00210006', 'song-00920006', '2023-01-06 16:10:00', '00:03:30', 'Mobile', 'Madrid'),
('listen_009007', 'Usr-00210007', 'song-00920007', '2023-01-07 14:25:00', '00:04:45', 'Tablet', 'London'),
('listen_009008', 'Usr-00210008', 'song-00920008', '2023-01-08 12:40:00', '00:04:00', 'Desktop', 'Beijing'),
('listen_009009', 'Usr-00210009', 'song-00920009', '2023-01-09 10:55:00', '00:05:15', 'Mobile', 'London'),
('listen_009010', 'Usr-00210010', 'song-00920010', '2023-01-10 08:30:00', '00:03:15', 'Tablet', 'Sydney');




Select * From User_Listen_Song



 
-- Playlist Table Inserts



 
-- Create_Playlist Table Inserts
INSERT INTO Create_Playlist (create_id, playlist_id, user_id, created_date, last_modified_date)
VALUES
('Create_00171', 'Playlist_008701', 'Usr-00210001', '2023-01-01 10:00:00', '2023-01-10 15:30:00'),
('Create_00172', 'Playlist_008702', 'Usr-00210002', '2023-01-02 11:30:00', '2023-01-11 16:45:00'),
('Create_00173', 'Playlist_008703', 'Usr-00210003', '2023-01-03 09:15:00', '2023-01-12 14:20:00'),
('Create_00174', 'Playlist_008704', 'Usr-00210004', '2023-01-04 13:45:00', '2023-01-13 12:10:00'),
('Create_00175', 'Playlist_008705', 'Usr-00210005', '2023-01-05 15:20:00', '2023-01-14 11:30:00'),
('Create_00176', 'Playlist_008706', 'Usr-00210006', '2023-01-06 16:10:00', '2023-01-15 10:45:00'),
('Create_00177', 'Playlist_008707', 'Usr-00210007', '2023-01-07 14:25:00', '2023-01-16 09:15:00'),
('Create_00178', 'Playlist_008708', 'Usr-00210008', '2023-01-08 12:40:00', '2023-01-17 13:30:00'),
('Create_00179', 'Playlist_008709', 'Usr-00210009', '2023-01-09 10:55:00', '2023-01-18 15:20:00'),
('Create_00170', 'Playlist_008710', 'Usr-00210010', '2023-01-10 08:30:00', '2023-01-19 17:45:00');




Select * From  Create_Playlist
 








-- Subscribe_Plan3 Table Inserts

INSERT INTO Subscribe_Plan (subscription_id, user_id, plan_id, start_date, end_date, last_payment_date)
VALUES
('Sub_0023101', 'Usr-00210001', 'Plan_00210001', '2023-01-01', '2024-01-01', '2023-01-01'),
('Sub_0023102', 'Usr-00210002', 'Plan_00210002', '2023-01-02', '2024-01-02', '2023-01-02'),
('Sub_0023103', 'Usr-00210003', 'Plan_00210003', '2023-01-03', '2024-01-03', '2023-01-03'),
('Sub_0023104', 'Usr-00210004', 'Plan_00210004', '2023-01-04', '2024-01-04', '2023-01-04'),
('Sub_0023105', 'Usr-00210005', 'Plan_00210005', '2023-01-05', '2024-01-05', '2023-01-05'),
('Sub_0023106', 'Usr-00210006', 'Plan_00210006', '2023-01-06', '2024-01-06', '2023-01-06'),
('Sub_0023107', 'Usr-00210007', 'Plan_00210007', '2023-01-07', '2024-01-07', '2023-01-07'),
('Sub_0023108', 'Usr-00210008', 'Plan_00210008', '2023-01-08', '2024-01-08', '2023-01-08'),
('Sub_0023109', 'Usr-00210009', 'Plan_00210009', '2023-01-09', '2024-01-09', '2023-01-09'),
('Sub_0023110', 'Usr-00210010', 'Plan_00210010', '2023-01-10', '2024-01-10', '2023-01-10');



Select * From  Subscribe_Plan
 
-- Playlist_Song Table Inserts

INSERT INTO Playlist_Song (playlist_song_id, playlist_id, song_id, added_date, added_by, order_number)
VALUES
('Play_00540001', 'Playlist_008701', 'song-00920001', '2023-03-15 10:12:45', 'Usr-00210001', 1),
('Play_00540002', 'Playlist_008701', 'song-00920002', '2023-06-07 11:53:02', 'Usr-00210002', 2),
('Play_00540003', 'Playlist_008702', 'song-00920003', '2023-04-21 09:35:18', 'Usr-00210003', 1),
('Play_00540004', 'Playlist_008702', 'song-00920004', '2023-05-04 14:05:29', 'Usr-00210004', 2),
('Play_00540005', 'Playlist_008703', 'song-00920005', '2023-02-17 15:28:10', 'Usr-00210005', 1),
('Play_00540006', 'Playlist_008703', 'song-00920006', '2023-07-09 16:47:33', 'Usr-00210006', 2),
('Play_00540007', 'Playlist_008704', 'song-00920007', '2023-08-25 14:12:02', 'Usr-00210007', 1),
('Play_00540008', 'Playlist_008704', 'song-00920008', '2023-09-19 13:21:58', 'Usr-00210008', 2),
('Play_00540009', 'Playlist_008705', 'song-00920009', '2023-10-03 11:09:47', 'Usr-00210009', 2),
('Play_00540010', 'Playlist_008705', 'song-00920010', '2023-11-30 08:45:58', 'Usr-00210010', 2);



Select * From  Playlist_Song








 
-- Platform Table Inserts
INSERT INTO Platform (platform_id, platform_name, platform_url, api_key, integration_date, last_sync_date, icon_url)
VALUES
('Plat_00750001', 'Spotify', 'https://www.spotify.com', 'API_KEY_123', '2023-01-15', CURRENT_TIMESTAMP, 'https://www.spotify.com/icon.png'),
('Plat_00750002', 'Apple Music', 'https://www.apple.com/music', 'API_KEY_124', '2023-02-01', CURRENT_TIMESTAMP, 'https://www.apple.com/music/icon.png'),
('Plat_00750003', 'YouTube Music', 'https://www.youtube.com/music', 'API_KEY_125', '2023-03-10', CURRENT_TIMESTAMP, 'https://www.youtube.com/music/icon.png'),
('Plat_00750004', 'Tidal', 'https://www.tidal.com', 'API_KEY_126', '2023-04-05', CURRENT_TIMESTAMP, 'https://www.tidal.com/icon.png'),
('Plat_00750005', 'Deezer', 'https://www.deezer.com', 'API_KEY_127', '2023-05-12', CURRENT_TIMESTAMP, 'https://www.deezer.com/icon.png'),
('Plat_00750006', 'Pandora', 'https://www.pandora.com', 'API_KEY_128', '2023-06-08', CURRENT_TIMESTAMP, 'https://www.pandora.com/icon.png'),
('Plat_00750007', 'Amazon Music', 'https://www.amazon.com/music', 'API_KEY_129', '2023-07-19', CURRENT_TIMESTAMP, 'https://www.amazon.com/music/icon.png'),
('Plat_00750008', 'SoundCloud', 'https://www.soundcloud.com', 'API_KEY_130', '2023-08-22', CURRENT_TIMESTAMP, 'https://www.soundcloud.com/icon.png'),
('Plat_00750009', 'Bandcamp', 'https://www.bandcamp.com', 'API_KEY_131', '2023-09-30', CURRENT_TIMESTAMP, 'https://www.bandcamp.com/icon.png'),
('Plat_00750010', 'Napster', 'https://www.napster.com', 'API_KEY_132', '2023-10-11', CURRENT_TIMESTAMP, 'https://www.napster.com/icon.png');

Select * From  Platform
 
 
-- Share_Playlist_Platform2 Table Inserts
INSERT INTO Share_Playlist_Platform (share_id, playlist_id, platform_id, user_id, share_date, share_url)
VALUES
('share_00660001', 'Playlist_008701', 'Plat_00750001', 'Usr-00210001', '2023-03-01 12:15:22', 'https://spotify.com/playlist/Playlist_008701'),
('share_00660002', 'Playlist_008702', 'Plat_00750002', 'Usr-00210002', '2023-04-05 14:20:11', 'https://music.apple.com/playlist/Playlist_008702'),
('share_00660003', 'Playlist_008703', 'Plat_00750003', 'Usr-00210003', '2023-05-07 10:35:02', 'https://music.youtube.com/playlist/Playlist_008703'),
('share_00660004', 'Playlist_008704', 'Plat_00750004', 'Usr-00210004', '2023-06-12 11:50:45', 'https://www.tidal.com/playlist/Playlist_008704'),
('share_00660005', 'Playlist_008705', 'Plat_00750005', 'Usr-00210005', '2023-07-16 16:25:33', 'https://www.deezer.com/playlist/Playlist_008705'),
('share_00660006', 'Playlist_008701', 'Plat_00750006', 'Usr-00210006', '2023-08-21 17:15:59', 'https://www.pandora.com/playlist/Playlist_008701'),
('share_00660007', 'Playlist_008702', 'Plat_00750007', 'Usr-00210007', '2023-09-18 14:02:28', 'https://www.amazon.com/music/playlist/Playlist_008702'),
('share_00660008', 'Playlist_008703', 'Plat_00750008', 'Usr-00210008', '2023-10-23 13:14:47', 'https://www.soundcloud.com/playlist/Playlist_008703'),
('share_00660009', 'Playlist_008704', 'Plat_00750009', 'Usr-00210009', '2023-11-19 15:45:12', 'https://www.bandcamp.com/playlist/Playlist_008704'),
('share_00660010', 'Playlist_008705', 'Plat_00750010', 'Usr-00210010', '2023-12-12 09:25:05', 'https://www.napster.com/playlist/Playlist_008705');

Select * From Share_Playlist_Platform




-- Query 1: Artist Performance Analytics
-- Analyzes artist performance based on song plays and followers

SELECT 
    a.artist_id,
    a.artist_name,
    COUNT(s.song_id) AS total_songs,  -- Count of distinct songs directly
    a.total_followers              -- Total followers (from the Artist table)

FROM 
    Artist a
LEFT JOIN 
    Song s ON a.artist_id = s.artist_id  -- Left join to include artists even without songs
GROUP BY 
    a.artist_id, a.artist_name, a.total_followers  -- Grouping by artist details
HAVING 
    a.total_followers > 2000  -- Only include artists with more than 0 followers





-- Query 2: User Listening Patterns Analysis
-- Analyzes user listening habits across different devices and locations
SELECT 
    RUA.username, 
    S.title, 
    MAX(ULS.listen_date) AS last_listened, 
    COUNT(ULS.listen_date) AS times_listened
FROM 
    Registered_User_Account RUA
    
JOIN 
    User_Listen_Song ULS ON RUA.user_id = ULS.user_id
JOIN 
    Song S ON ULS.song_id = S.song_id

GROUP BY 
    RUA.username, S.title  -- Group by username and song title for more meaningful aggregation
ORDER BY 
    last_listened DESC;    -- Order by the last listened date in descending order




-- Query 3: Premium Subscription Revenue Analysis
-- Calculates revenue metrics for different subscription plans
SELECT 
    p.plan_name,
    COUNT(s.subscription_id) as total_subscriptions,
    SUM(p.price) as total_revenue,
    AVG(p.price) as avg_revenue_per_subscription,
    COUNT(DISTINCT s.user_id) as unique_subscribers
FROM Plan_ p
LEFT JOIN Subscribe_Plan s ON p.plan_id = s.plan_id
GROUP BY p.plan_name
ORDER BY total_revenue DESC;


    
    

-- Query 5: Artist Genre Distribution Analysis
-- Analyzes the distribution of genres across artists and their songs
SELECT 
    a.genre,
    COUNT(DISTINCT s.artist_id) as unique_artists,
    COUNT(s.song_id) as total_playlist

   
FROM Album a
JOIN Song s ON a.album_id = s.album_id
GROUP BY a.genre
ORDER BY total_playlist DESC;

-- Query 6: User Platform Sharing Analysis
-- Analyzes how users share playlists across different platforms








-- Query 9: Cross-Platform User Activity Analysis
-- Analyzes user activity across different platforms and content types
SELECT 
    rua.user_id,
    COUNT(DISTINCT uls.listen_id) as total_listens,
    COUNT(DISTINCT uaf.follow_id) as artist_follows,
    COUNT(DISTINCT spp.share_id) as social_shares,
    COUNT(DISTINCT p.playlist_id) as playlists_created
FROM Registered_User_Account rua
LEFT JOIN User_Listen_Song uls ON rua.user_id = uls.user_id
LEFT JOIN User_Artist_Follow uaf ON rua.user_id = uaf.user_id
LEFT JOIN Share_Playlist_Platform spp ON rua.user_id = spp.user_id
LEFT JOIN Playlist p ON rua.user_id = p.user_id
GROUP BY rua.user_id
ORDER BY total_listens DESC;





-- Query 10: err Content Growth and Trend Analysis
-- Analyzes the growth of content and user engagement over time
-- Basic Subscription Analysis Query
SELECT 
    sp.plan_id,
    p.plan_name,
    p.price,
    sp.start_date,
    COUNT(sp.user_id) AS subscriber_count,
    SUM(p.price) AS total_revenue
FROM 
    Subscribe_Plan sp
JOIN 
    Plan_ p ON sp.plan_id = p.plan_id
GROUP BY 
    sp.plan_id,
    p.plan_name,
    p.price,
    sp.start_date
ORDER BY 
    sp.start_date DESC;

-- Count Subscriptions by Plan
SELECT 
    p.plan_name,
    COUNT(sp.subscription_id) AS total_subscriptions
FROM 
    Plan_ p
LEFT JOIN 
    Subscribe_Plan sp ON p.plan_id = sp.plan_id
GROUP BY 
    p.plan_name;
    
    

-- Revenue by Plan
SELECT 
    p.plan_name,
    p.price,
    COUNT(sp.subscription_id) AS subscribers,
    p.price * COUNT(sp.subscription_id) AS total_revenue
FROM 
    Plan_ p
LEFT JOIN 
    Subscribe_Plan sp ON p.plan_id = sp.plan_id
GROUP BY 
    p.plan_name,
    p.price;




-- Active Subscriptions by Plan
SELECT 
    p.plan_name,
    p.price,
    COUNT(sp.subscription_id) AS active_subscriptions
FROM 
    Plan_ p
LEFT JOIN 
    Subscribe_Plan sp ON p.plan_id = sp.plan_id
-- Include subscriptions with no end date
GROUP BY 
    p.plan_name,
    p.price
ORDER BY 
    active_subscriptions DESC;
    
    
    

-- Detailed User Subscription History
SELECT 
    RUA.username, 
    RUA.full_name, 
    UAF.last_interaction_date,
    COALESCE(P.plan_name, 'No Plan') AS current_plan -- Replace NULL with 'No Plan'
FROM 
    Registered_User_Account RUA
JOIN 
    User_Artist_Follow UAF ON RUA.user_id = UAF.user_id
LEFT JOIN 
    Subscribe_Plan SP ON RUA.user_id = SP.user_id 
LEFT JOIN 
    Plan_ P ON SP.plan_id = P.plan_id
ORDER BY 
    UAF.last_interaction_date DESC;




--Query11--


