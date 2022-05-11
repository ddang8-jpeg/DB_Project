DELIMITER //
DROP PROCEDURE IF EXISTS InsertProcedure //
CREATE PROCEDURE InsertProcedure(IN speciesID VARCHAR(5),  IN commonName VARCHAR(100), IN sciName VARCHAR(150), IN esaStatus VARCHAR(100), IN isForeign VARCHAR(10), IN family VARCHAR(100), IN grp VARCHAR(100), IN kingdom VARCHAR(100))
BEGIN
   IF NOT EXISTS ( SELECT Species_ID FROM Species WHERE Species_ID = speciesID) THEN
      INSERT INTO Species
      VALUES (speciesID, commonName, sciName, esaStatus, isForeign, family, grp, kingdom);
   END IF;
END 
//
DELIMITER ;
