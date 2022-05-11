DROP TABLE IF EXISTS CurrentRange;
DROP TABLE IF EXISTS Planned;
DROP TABLE IF EXISTS Refuges;
DROP TABLE IF EXISTS DelistedSpecies;
DROP TABLE IF EXISTS ListedSpecies;
DROP TABLE IF EXISTS States;
DROP TABLE IF EXISTS Conservation;
DROP TABLE IF EXISTS Refuge;
DROP TABLE IF EXISTS Species;

CREATE TABLE Species (
  Species_ID		VARCHAR(5),
  Common_Name           VARCHAR(100),
  Scientific_Name       VARCHAR(150),
  Esa_Listing_Status    VARCHAR(100),
  Is_Foreign            VARCHAR(10),
  Tax_Family            VARCHAR(100),
  Tax_Group             VARCHAR(100),
  Tax_Kingdom           VARCHAR(100),
  PRIMARY KEY(Species_ID)
);

CREATE TABLE ListedSpecies (
  Species_ID		VARCHAR(5),
  Listing_Date          VARCHAR(20),
  PRIMARY KEY(Species_ID),
  FOREIGN KEY(Species_ID) REFERENCES Species(Species_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
  
  CREATE TABLE DelistedSpecies (
  Species_ID		VARCHAR(5),
  Listing_Date          VARCHAR(20),
  Delisting_Date        VARCHAR(20),
  Delisting_Reason      VARCHAR(1000),
  PRIMARY KEY(Species_ID),
  FOREIGN KEY(Species_ID) REFERENCES Species(Species_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE States (
  State_Name            VARCHAR(50),
  State_Code            VARCHAR(2),
  Region                VARCHAR(40),
  Division              VARCHAR(80),
  PRIMARY KEY(State_Code)
);

CREATE TABLE CurrentRange (
  Species_ID		VARCHAR(5),
  State_Code            VARCHAR(2), 
  PRIMARY KEY(Species_ID, State_Code),
  FOREIGN KEY(Species_ID) REFERENCES Species(Species_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(State_Code) REFERENCES States(State_Code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Conservation (
  Plan_ID               VARCHAR(10),
  Plan_Title            VARCHAR(250),
  Plan_Type             VARCHAR(5),
  PRIMARY KEY(Plan_ID)
);

CREATE TABLE Planned (
  Species_ID		VARCHAR(10),
  Plan_ID               VARCHAR(10),
  PRIMARY KEY(Species_ID, Plan_ID),
  FOREIGN KEY(Species_ID) REFERENCES Species(Species_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(Plan_ID) REFERENCES Conservation(Plan_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Refuge (
  Refuge_Name             VARCHAR(100),
  Refuge_ID 	          VARCHAR(10),
  PRIMARY KEY(Refuge_ID)
);

CREATE TABLE Refuges (
  Species_ID		VARCHAR(5),
  Refuge_ID             VARCHAR(10),
  PRIMARY KEY(Species_ID, Refuge_ID),
  FOREIGN KEY(Species_ID) REFERENCES Species(Species_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(Refuge_ID) REFERENCES Refuge(Refuge_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

--Change local infile to txt file location.
LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/tables/Species.txt'
INTO TABLE Species
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/tables/ListedSpecies.txt'
INTO TABLE ListedSpecies
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/tables/DelistedSpecies.txt'
INTO TABLE DelistedSpecies
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/tables/State.txt'
INTO TABLE States
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/tables/CurrentRange.txt'
INTO TABLE CurrentRange
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/tables/Conservation.txt'
INTO TABLE Conservation
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/tables/Planned.txt'
INTO TABLE Planned
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/tables/Refuge.txt'
INTO TABLE Refuge
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/tables/Refuges.txt'
INTO TABLE Refuges
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;


-------------------------------------------

update DelistedSpecies set Delisting_date = DATE_FORMAT(STR_TO_DATE(delisting_date, '%m/%d/%Y'),'%Y-%m-%d');
ALTER TABLE DelistedSpecies Modify Delisting_Date DATE NULL;

update DelistedSpecies set Listing_date = DATE_FORMAT(STR_TO_DATE(listing_date, '%m/%d/%Y'),'%Y-%m-%d');
ALTER TABLE DelistedSpecies Modify Listing_Date DATE NULL;

update ListedSpecies set Listing_date = DATE_FORMAT(STR_TO_DATE(listing_date, '%m/%d/%Y'),'%Y-%m-%d');
ALTER TABLE ListedSpecies Modify Listing_Date DATE NULL;

DELIMITER //

-----Given portion of scientific or common name, find all species
DROP PROCEDURE IF EXISTS FindSpeciesName //
CREATE PROCEDURE FindSpeciesName(IN var VARCHAR(100))
BEGIN

SELECT *
FROM Species AS S
WHERE S.Scientific_Name LIKE CONCAT('%', var, '%') OR S.Common_Name LIKE CONCAT('%', var, '%');

END; 

------Given a portion of delisting reason, find all delisted species with matching reason.
DROP PROCEDURE IF EXISTS  ShowSpeciesDelistedReason //
CREATE PROCEDURE ShowSpeciesDelistedReason(IN var VARCHAR(100))
BEGIN

SELECT S.species_id, S.Scientific_Name, D.delisting_date, D.Delisting_Reason
FROM Species AS S JOIN DelistedSpecies AS D
ON S.species_id = D.species_id 
WHERE D.Delisting_Reason LIKE CONCAT('%', var, '%');

END;

------Given species id, find number of species are in each division.
DROP PROCEDURE IF EXISTS ShowRegionRangeSpecies //
CREATE PROCEDURE ShowRegionRangeSpecies(IN var VARCHAR(100))
BEGIN

SELECT S.Division, COUNT(C.Species_id) 
FROM CurrentRange AS C JOIN States AS S 
ON C.State_Code = S.State_Code
WHERE C.species_id = var 
GROUP BY S.Division;

END; 

------Given species id, find all refuges with species
DROP PROCEDURE IF EXISTS ShowRefugesSpecies //
CREATE PROCEDURE ShowRefugesSpecies(IN var VARCHAR(5))
BEGIN

SELECT R.Refuge_Name
FROM Refuge AS R JOIN Refuges AS E 
ON R.Refuge_ID = E.Refuge_ID
WHERE E.species_id = var;

END;

------Given species range, list all species group count
DROP PROCEDURE IF EXISTS  ShowSpeciesGroupsRange //
CREATE PROCEDURE ShowSpeciesGroupsRange(IN var VARCHAR(100))
BEGIN

SELECT S.Tax_Group, COUNT(S.Species_id)
FROM Species AS S JOIN CurrentRange AS C JOIN States AS T 
ON S.Species_ID = C.Species_ID AND C.State_Code = T.State_Code
WHERE T.State_Code = var OR T.State_Name = var OR T.Region = var OR T.Division = var
GROUP BY S.Tax_Group
ORDER BY COUNT(S.Species_id) DESC;

END;

------Given a date range, list all of the species that were delisted after the given year.
DROP PROCEDURE IF EXISTS  ShowSpeciesDelistedAfterDate //
CREATE PROCEDURE ShowSpeciesDelistedAfterDate(IN var DATE)
BEGIN

SELECT S.Species_ID, S.Scientific_Name, S.Esa_Listing_Status, D.*
FROM Species AS S JOIN DelistedSpecies AS D
ON S.species_id = D.species_id AND D.delisting_date > var;

END;

------Given a date range, list all species that were listed then. 
DROP PROCEDURE IF EXISTS  ShowListedSpeciesDateRange //
CREATE PROCEDURE ShowListedSpeciesDateRange(IN var1 DATE, IN var2 DATE)
BEGIN

SELECT S.Species_ID, S.Scientific_Name, S.Esa_Listing_Status, D.Listing_date AS LDate
FROM Species AS S JOIN DelistedSpecies AS D
ON S.species_id = D.species_id 
WHERE D.Listing_date > var1 AND D.Listing_Date < var2 AND D.Delisting_Date > var2AND D.Delisting_Date > var2;
UNION
SELECT S.Species_ID, S.Scientific_Name, S.Esa_Listing_Status, L.Listing_date AS LDate
FROM Species AS S JOIN ListedSpecies AS L
ON S.species_id = L.species_id 
WHERE L.Listing_date > var1 AND L.Listing_date < var2;


END;

------Given a date, list count of all currently species since.
DROP PROCEDURE IF EXISTS  ShowListedSpeciesCountDateRange //
CREATE PROCEDURE ShowListedSpeciesCountDateRange(IN var DATE)
BEGIN

WITH listedSpeciesDates (species_id) AS (
SELECT D.species_id
FROM DelistedSpecies AS D
WHERE D.listing_date <= var AND D.Delisting_Date > var
UNION
SELECT L.species_id
FROM ListedSpecies AS L
WHERE L.Listing_date <= var)

SELECT COUNT(species_id)
FROM listedSpeciesDates;

END;
//


DELIMITER;