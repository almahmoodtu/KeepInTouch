
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Events this year

CREATE VIEW [dbo].[vw_EventsThisYear_All]
AS

	------------------------------------------
	SELECT *
	FROM [dbo].[tf_EventsThisYear]()
	------------------------------------------

