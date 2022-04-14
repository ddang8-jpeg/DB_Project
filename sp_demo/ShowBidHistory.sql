-- ShowBidHistory.sql
-- Reports list of bids on item with specified number

DELIMITER //

DROP PROCEDURE IF EXISTS ShowBidHistory //

CREATE PROCEDURE ShowBidHistory(IN item VARCHAR(10))
BEGIN
--    IF EXISTS(SELECT * FROM Bid WHERE itemID = item) THEN
   IF CalcBidCount(item) > 0 THEN
      SELECT buyerNum, bidTime, amount
      FROM Bid
      WHERE itemID = item
      ORDER BY bidTime;
   ELSE
       SELECT 'ERROR: Specified item does not have bids' AS buyerNum;
   END IF;
END; //

DELIMITER ;
