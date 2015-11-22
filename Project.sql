-- 1. Create BuildingEnergy schema and select it
DROP SCHEMA IF EXISTS BuildingEnergy;
CREATE SCHEMA BuildingEnergy;
USE BuildingEnergy;


-- 2. Create EnergyCategories and EnergyTypes tables
DROP TABLE IF EXISTS EnergyCategories;
DROP TABLE IF EXISTS EnergyTypes;

CREATE TABLE EnergyCategories (
	cat_id INT PRIMARY KEY,
    energycategory VARCHAR(20) NOT NULL
    );

CREATE TABLE EnergyTypes (
	type_id INT PRIMARY KEY,
    energytype VARCHAR(20) NOT NULL,
    cat_id INT NOT NULL,
    FOREIGN KEY (cat_id) REFERENCES EnergyCategories(cat_id)
    );


-- 2. Populate tables with given data
INSERT INTO EnergyCategories (cat_id, energycategory)
	VALUES
		(1, 'Fossil'),
        (2, 'Renewable');

INSERT INTO EnergyTypes (type_id, energytype, cat_id)
	VALUES
		(1, 'Electricity', 1),
        (2, 'Gas', 1),
        (3, 'Steam', 1),
        (4, 'Fuel Oil', 1),
        (5, 'Solar', 2),
        (6, 'Wind', 2);


-- 3. Write a JOIN statement that shows the energy categories and associated energy types
SELECT c.energycategory, t.energytype
FROM EnergyCategories AS c
INNER JOIN EnergyTypes AS t
ON c.cat_id = t.cat_id
ORDER BY energytype;


--  4. Add a table called Buildings
DROP TABLE IF EXISTS Buildings;

CREATE TABLE Buildings (
	bldg_id INT PRIMARY KEY,
    bldg VARCHAR(100) NOT NULL
    );


-- 4. Populate buildings table
INSERT INTO Buildings (bldg_id, bldg)
	VALUES
		(1, 'Empire State Building'),
        (2, 'Chrysler Building'),
        (3, 'Borough of Manhattan Community College');


-- 4. In order to create many-to-many relationship, create and populate bridge table BuildingEnergy
DROP TABLE IF EXISTS BuildingEnergy;

CREATE TABLE BuildingEnergy (
	bldg_id INT NOT NULL,
    type_id INT NOT NULL,
    FOREIGN KEY(bldg_id) REFERENCES Buildings(bldg_id),
	FOREIGN KEY(type_id) REFERENCES EnergyTypes(type_id)
    );

INSERT INTO BuildingEnergy (bldg_id, type_id)
	VALUES
		(1,1), (1,2), (1,3),
        (2,1), (2,3),
        (3,1), (3,3), (3,5);


-- 5. Write a JOIN statement that shows the buildings and associated energy types for each building
SELECT b.bldg AS Building, t.energytype as Type
FROM Buildings as b
LEFT JOIN BuildingEnergy as e
ON b.bldg_id = e.bldg_id
LEFT JOIN EnergyTypes as t
ON e.type_id = t.type_id
ORDER BY Building, t.type_id;


-- 6. Add additional information
INSERT INTO EnergyTypes (type_id, energytype, cat_id)
	VALUES
		(7, 'Geothermal', 2);

INSERT INTO Buildings (bldg_id, bldg)
	VALUES
		(4, 'Bronx Lion House'),
        (5, 'Brooklyn Childrens Museum');

INSERT INTO BuildingEnergy (bldg_id, type_id)
	VALUES
		(4,7),
        (5,1), (5,7);


-- 7. Write a query that displays all of the buildings that use Renewable energies
SELECT b.bldg AS Building FROM Buildings AS b
INNER JOIN BuildingEnergy AS e
ON b.bldg_id = e.bldg_id
INNER JOIN EnergyTypes AS t
ON e.type_id = t.type_id
INNER JOIN EnergyCategories AS c
ON t.cat_id = c.cat_id
WHERE c.energycategory = 'Renewable'
ORDER BY Building;


-- 8.  Write a  query that shows the frequency with which energy types are used in various buildings
SELECT t.energytype AS Type, COUNT(*) AS Count FROM EnergyTypes as t
LEFT JOIN BuildingEnergy AS e
ON t.type_id = e.type_id
LEFT JOIN Buildings AS b
ON e.bldg_id = b.bldg_id
GROUP BY Type
ORDER BY Count DESC, Type ASC;


-- 9.  (a) Create the appropriate foreign key constraints
	-- See definition of EnergyTypes and BuildingEnergy tables on lines 20, 71, and 72.