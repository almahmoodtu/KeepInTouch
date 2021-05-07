

-- KeepInTouch
-- CREATING SCALAR FUNCTION
------------------------------------
-- Get all Months

CREATE FUNCTION [dbo].[tf_Months]()

RETURNS TABLE 
AS
RETURN 
(
	------------------------------------------
	SELECT
		PM.PersonMonthID,
		PM.PersonID,
		PM.MonthID,
		M.Month,
		PM.Description

	FROM tb_PersonMonth AS PM
		INNER JOIN tb_Month AS M
		ON PM.MonthID = M.MonthID
	------------------------------------------
)

