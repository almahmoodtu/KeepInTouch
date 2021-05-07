
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Events

CREATE VIEW [dbo].[vw_Event_NotSelected]
AS

	------------------------------------------
	SELECT *
	FROM [dbo].[vw_Event_All]
	WHERE Selected = 0
	------------------------------------------

