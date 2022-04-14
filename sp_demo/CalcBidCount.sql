-- CalcBidCount
-- Given an item number, will determine the number of bids made on that item

DELIMITER //

DROP FUNCTION IF EXISTS CalcBidCount //

CREATE FUNCTION CalcBidCount(item VARCHAR(10))
RETURNS INTEGER
BEGIN
      RETURN (SELECT COUNT(buyerNum) FROM Bid WHERE itemID = item);
END; //

DELIMITER ;
