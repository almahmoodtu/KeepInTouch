
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Persons

CREATE VIEW [dbo].[vw_Person_All]
AS

	------------------------------------------
	SELECT
		*
	FROM [dbo].[tf_Persons] () AS P
	------------------------------------------

