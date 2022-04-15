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

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Species-small.txt'
INTO TABLE Species
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/ListedSpecies-small.txt'
INTO TABLE ListedSpecies
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/DelistedSpecies-small.txt'
INTO TABLE DelistedSpecies
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/State-small.txt'
INTO TABLE States
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/CurrentRange-small.txt'
INTO TABLE CurrentRange
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Conservation-small.txt'
INTO TABLE Conservation
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Planned-small.txt'
INTO TABLE Planned
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Refuge-small.txt'
INTO TABLE Refuge
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Refuges-small.txt'
INTO TABLE Refuges
FIELDS TERMINATED BY '\t'
IGNORE 1 LINES;
