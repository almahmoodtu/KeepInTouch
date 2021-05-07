
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Frequencies

CREATE VIEW [dbo].[vw_Frequency_NotEdited]
AS

	------------------------------------------
	SELECT *
	FROM [dbo].[vw_Frequency_All]
	WHERE PersonFrequencyID IS NULL
	------------------------------------------

