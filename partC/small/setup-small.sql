DROP TABLE IF EXISTS Species;
DROP TABLE IF EXISTS DelistedSpecies;
DROP TABLE IF EXISTS States;
DROP TABLE IF EXISTS CurrentRange;
DROP TABLE IF EXISTS Conservation;
DROP TABLE IF EXISTS Planned;
DROP TABLE IF EXISTS Refuge;
DROP TABLE IF EXISTS Refuges;

CREATE TABLE Species (
  Common_Name           VARCHAR(40),
  Scientific_Name       VARCHAR(40),
  Esa_Listing_Status    VARCHAR(40),
  Is_Foreign            VARCHAR(10),
  Tax_Kingdom           VARCHAR(20),
  Tax_Group             VARCHAR(20),
  Tax_Family            VARCHAR(20),
  PRIMARY KEY(Scientific_Name)
);
  
  CREATE TABLE DelistedSpecies (
  Common_Name           VARCHAR(40),
  Scientific_Name       VARCHAR(40),
  Esa_Listing_Status    VARCHAR(40),
  Is_Foreign            VARCHAR(10),
  Tax_Kingdom           VARCHAR(20),
  Tax_Group             VARCHAR(20),
  Tax_Family            VARCHAR(20),
  Delisting_Date        DATETIME,
  Delisting_Reason      VARCHAR(100),
  PRIMARY KEY(Scientific_Name)
);

LOAD DATA LOCAL INFILE '/home/ddang8/DB_sp22/DB_Project/partC/small/Species-small.csv'
INTO TABLE Species
FIELDS TERMINATED BY ',';
