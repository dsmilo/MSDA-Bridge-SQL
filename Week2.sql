-- Drop tables if already existing
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS reviewers;

-- Create tables
CREATE TABLE videos (
	VideoID int AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL, -- character limit for youtube videos (https://productforums.google.com/forum/#!topic/youtube/Hx9lQMg2WTk)
    Length FLOAT(2) NOT NULL,
    url CHAR(11) NOT NULL -- YouTube videos are of form https://www.youtube.com/watch?v=videoid where videoid is 11 characters
	);

CREATE TABLE reviewers (
	ReviewID int AUTO_INCREMENT PRIMARY KEY,
    UserName VARCHAR(255) NOT NULL,
    Rating int,
    Review VARCHAR(255) NOT NULL,
    VideoID int NOT NULL REFERENCES videos
    );

-- Populate tables
INSERT INTO videos(Title, Length, url)
VALUES
('Introduction to MySQL Workbench',ROUND(11+44/60,2),'RSHevYMwCVw'),
('MySQL Tutorial',ROUND(41+9/60,2),'yPu6qV5byu4'),
('Beginners MYSQL Database Tutorial 1 # Download , Install MYSQL and first SQL query', ROUND(12+31/60,2), 'iP1wOSsKjW8')
;

INSERT INTO reviewers(VideoID, UserName, Review, Rating)
VALUES
(1,'Salma','Your videos are awesome!',5),
(1,'Phil','Too fast',1),
(2,'Anthony','Concise',4),
(2,'Dan','No graphical interface?',2),
(3,'Tony','The installation gets stuck',NULL),
(3,'Verma','Go faster',3)
;

-- Execute join
SELECT v.VideoID, v.Title, v.Length, r.UserName, r.Rating, r.Review, CONCAT('https://www.youtube.com/watch?v=',v.url) AS url FROM videos as v
INNER JOIN reviewers as r
ON r.VideoID = v.VideoID
ORDER BY VideoID, Rating;