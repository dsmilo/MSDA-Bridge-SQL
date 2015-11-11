-- create tables

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS rooms;

CREATE TABLE users (
	user VARCHAR(20) PRIMARY KEY,
	user_group VARCHAR(20)
	);

CREATE TABLE groups (
	group_name VARCHAR(20),
	room_access VARCHAR(20)
	);

CREATE TABLE rooms (
	room VARCHAR(20)
	);


-- populate tables

INSERT INTO users(user, user_group)
	VALUES
		('Modesto','I.T.'),
		('Ayine','I.T.'),
		('Christopher','Sales'),
		('Chong woo','Sales'),
		('Soulat','Administration'),
		('Heidy',NULL);

INSERT INTO groups(group_name,room_access)
	VALUES
		('I.T.', '101'),
		('I.T.', '102'),
		('Sales','102'),
		('Sales','Auditorium A'),
        ('Administration',NULL),
        ('Operations',NULL);

INSERT INTO rooms(room)
	VALUES
		('101'),
		('102'),
		('Auditorium A'),
		('Auditorium B');


-- issue SELECT statements

SELECT group_name, users.user from groups
LEFT JOIN users
ON groups.group_name = users.user_group
ORDER BY groups.group_name, user_group;

SELECT room, groups.group_name from rooms
LEFT JOIN groups
ON rooms.room = groups.room_access
ORDER BY rooms.room, groups.group_name;

SELECT user, groups.group_name, groups.room_access from users
LEFT JOIN groups
ON users.user_group = groups.group_name
ORDER BY user, groups.group_name, groups.room_access;