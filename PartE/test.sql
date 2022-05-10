DELIMITER //

DROP PROCEDURE IF EXISTS test //
CREATE PROCEDURE test(IN var VARCHAR(100))
BEGIN

SELECT S.Tax_Group, COUNT(S.Species_id)
FROM Species AS S JOIN CurrentRange AS C JOIN States AS T 
ON S.Species_ID = C.Species_ID AND C.State_Code = T.State_Code
WHERE T.State_Code = var OR T.State_Name = var OR T.Region = var OR T.Division = var
GROUP BY S.Tax_Group
ORDER BY COUNT(S.Species_id) DESC;

END; //


DELIMITER ;
