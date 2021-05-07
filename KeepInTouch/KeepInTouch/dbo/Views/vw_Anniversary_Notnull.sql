
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Anniversaries

CREATE VIEW [dbo].[vw_Anniversary_Notnull]
AS

	------------------------------------------
	SELECT *
	FROM vw_Anniversary_All
	WHERE Year IS NOT NULL
	------------------------------------------

