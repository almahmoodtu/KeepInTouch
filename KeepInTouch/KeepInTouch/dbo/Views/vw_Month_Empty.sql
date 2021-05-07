
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Months

CREATE VIEW [dbo].[vw_Month_Empty]
AS

	------------------------------------------
	SELECT *
	FROM [vw_Month_All]
	WHERE Description = '' OR Description IS NULL
	------------------------------------------

