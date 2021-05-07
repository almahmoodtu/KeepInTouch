
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Month transposed

CREATE VIEW [dbo].[vw_Month_Tr_COMPLETE]
AS

	------------------------------------------
	SELECT *
	FROM vw_Month_Tr
	WHERE MonthsPerYear NOT IN (0, 12) AND Deficit = 0;
	------------------------------------------

