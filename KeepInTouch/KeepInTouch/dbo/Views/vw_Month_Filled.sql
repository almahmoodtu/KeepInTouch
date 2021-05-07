
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Months

CREATE VIEW [dbo].[vw_Month_Filled]
AS

	------------------------------------------
	SELECT *
	FROM [vw_Month_All]
	WHERE Description <> ''
	------------------------------------------

