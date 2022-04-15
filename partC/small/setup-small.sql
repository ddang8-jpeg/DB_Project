--setup-small.sql
--sets up tables using small .csv files

DROP TABLE IF EXISTS Species-small;
DROP TABLE IF EXISTS DelistedSpecies-small;
DROP TABLE IF EXISTS States;
DROP TABLE IF EXISTS CurrentRange-small;
DROP TABLE IF EXISTS Conservation-small;
DROP TABLE IF EXISTS Planned-small;
DROP TABLE IF EXISTS Refuge-small;
DROP TABLE IF EXISTS Refuges-small;

CREATE TABLE Species-small (
  Common_Name           VARCHAR(40),
  Scientific_Name       VARCHAR(40),
  Esa_Listing_Status    VARCHAR(40),
  Is_Foreign            VARCHAR(10),
  Tax_Kingdom           VARCHAR(20),
  Tax_Group             VARCHAR(20),
  Tax_Family            VARCHAR(20),
  PRIMARY KEY(Scientific_Name)
);
  
  CREATE TABLE DelistedSpecies-small (
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

USE Species-small
APPEND FROM ./Species-small.csv TYPE DELIMITED;

