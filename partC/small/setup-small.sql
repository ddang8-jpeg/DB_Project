DROP TABLE IF EXISTS CurrentRange;
DROP TABLE IF EXISTS Planned;
DROP TABLE IF EXISTS Refuges;
DROP TABLE IF EXISTS UnlistedSpecies;
DROP TABLE IF EXISTS DelistedSpecies;
DROP TABLE IF EXISTS ListedSpecies;
DROP TABLE IF EXISTS States;
DROP TABLE IF EXISTS Conservation;
DROP TABLE IF EXISTS Refuge;

CREATE TABLE ListedSpecies (
  Common_Name           VARCHAR(40),
  Scientific_Name       VARCHAR(40),
  Esa_Listing_Status    VARCHAR(40),
  Is_Foreign            VARCHAR(10),
  Tax_Family            VARCHAR(20),
  Tax_Group             VARCHAR(20),
  Tax_Kingdom           VARCHAR(20),
  PRIMARY KEY(Scientific_Name)
);

CREATE TABLE ListedSpecies (
  Common_Name           VARCHAR(40),
  Scientific_Name       VARCHAR(40),
  Esa_Listing_Status    VARCHAR(40),
  Listing_Date          DATETIME,
  Is_Foreign            VARCHAR(10),
  Tax_Family            VARCHAR(20),
  Tax_Group             VARCHAR(20),
  Tax_Kingdom           VARCHAR(20),
  PRIMARY KEY(Scientific_Name)
);
  
  CREATE TABLE DelistedSpecies (
  Common_Name           VARCHAR(40),
  Scientific_Name       VARCHAR(40),
  Esa_Listing_Status    VARCHAR(40),
  Listing_Date          DATETIME,
  Delisting_Date        DATETIME,
  Delisting_Reason      VARCHAR(100),
  Is_Foreign            VARCHAR(10),
  Tax_Family            VARCHAR(20),
  Tax_Group             VARCHAR(20),
  Tax_Kingdom           VARCHAR(20),
  PRIMARY KEY(Scientific_Name)
);

CREATE TABLE States (
  State_Name            VARCHAR(30),
  State_Code            VARCHAR(2),
  Region                VARCHAR(10),
  Division              VARCHAR(40),
  PRIMARY KEY(State_Name)
);

CREATE TABLE CurrentRange (
  Scientific_Name       VARCHAR(40),
  State_Code            VARCHAR(2),
  
  PRIMARY KEY(Scientific_Name, State_Code),
  FOREIGN KEY(Scientific_Name) REFERENCES Species(Scientific_Name) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(State_Code) REFERENCES States(State_Name)
);

CREATE TABLE Conservation (
  Plan_ID               VARCHAR(10),
  Plan_Title            VARCHAR(40),
  Plan_Type             VARCHAR(3),
  PRIMARY KEY(Plan_ID)
);

CREATE TABLE Planned (
  Scientific_Name       VARCHAR(40),
  Plan_ID               VARCHAR(10),
  PRIMARY KEY(Scientific_Name, Plan_ID),
  FOREIGN KEY(Scientific_Name) REFERENCES Species(Scientific_Name) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(Plan_ID) REFERENCES Conservation(Plan_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Refuge (
  Refuge_ID             VARCHAR(10),
  Refuge_Name           VARCHAR(40),
  PRIMARY KEY(Refuge_ID)
);

CREATE TABLE Refuges (
  Scientific_Name       VARCHAR(40),
  Refuge_ID             VARCHAR(10),
  PRIMARY KEY(Scientific_Name, Refuge_ID),
  FOREIGN KEY(Scientific_Name) REFERENCES Species(Scientific_Name) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(Refuge_ID) REFERENCES Refuge(Refuge_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

LLOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/UnlistedSpecies-small.csv'
INTO TABLE DelistedSpecies
FIELDS TERMINATED BY ',';

OAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/ListedSpecies-small.csv'
INTO TABLE Species
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/DelistedSpecies-small.csv'
INTO TABLE DelistedSpecies
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/State.csv'
INTO TABLE States
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/CurrentRange-small.csv'
INTO TABLE CurrentRange
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Conservation-small.csv'
INTO TABLE Conservation
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Planned-small.csv'
INTO TABLE Planned
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Refuge-small.csv'
INTO TABLE Refuge
FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Refuges-small.csv'
INTO TABLE Refuges
FIELDS TERMINATED BY ',';
