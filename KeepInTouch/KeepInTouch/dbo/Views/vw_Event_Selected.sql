
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Events

CREATE VIEW [dbo].[vw_Event_Selected]
AS

	------------------------------------------
	SELECT *
	FROM [dbo].[vw_Event_All]
	WHERE Selected = 1
	------------------------------------------

