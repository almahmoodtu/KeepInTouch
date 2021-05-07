
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Events this year

CREATE VIEW [dbo].[vw_EventsThisYear_Incomplete]
AS

	------------------------------------------
	SELECT *
	FROM [dbo].[vw_EventsThisYear_All]
	WHERE Day IS NULL OR Month IS NULL
	------------------------------------------

