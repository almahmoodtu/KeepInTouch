
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Months

CREATE VIEW [dbo].[vw_Month_All]
AS

	------------------------------------------
	SELECT
		P.PersonID,
		P.Name,
		P.Relation,
		M.PersonMonthID,
		M.MonthID,
		M.Month,
		M.Description
	FROM [dbo].[tf_Persons]() AS P
		INNER JOIN [dbo].[tf_Months]() AS M
		ON M.PersonID = P.PersonID
	------------------------------------------

