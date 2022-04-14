-- Stored Procedure Demo Code Testing

-- List the various procedures and functions we've already defined
SHOW PROCEDURE STATUS;
SHOW FUNCTION STATUS;

-- Call a stored procedure using CALL
CALL ShowBidHistory('44455');
CALL ShowBidHistory('33455');

-- CALL a function using SELECT
SELECT CalcBidCount('44455') AS BidCount;
SELECT CalcBidCount('33455') AS BidCount;

-- Remove specific procedure or function definitions
DROP PROCEDURE IF EXISTS ShowBidHistory;
DROP FUNCTION IF EXISTS CalcBidCount;

-- Useful to see what definition is loaded; better directly on dbase
SHOW CREATE PROCEDURE ShowBidHistory;


