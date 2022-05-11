DROP PROCEDURE IF EXISTS DeleteProcedure;
DELIMITER //

CREATE PROCEDURE DeleteProcedure(IN speciesID VARCHAR(5))
-- CREATE PROCEDURE DeleteProcedure(IN speciesID VARCHAR(5), OUT ret VARCHAR(5))
BEGIN
  IF EXISTS ( SELECT Species_ID FROM Species WHERE Species_ID = speciesID) THEN
    DELETE FROM Species WHERE Species_ID = speciesID;
    -- SET ret = 0; -- deleted!
  -- ELSE 
    -- SET ret = 1; -- already absent
  END IF;
END; 
//
DELIMITER ;
