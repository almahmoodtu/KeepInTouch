
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Frequencies

CREATE VIEW [dbo].[vw_Frequency_All]
AS

	------------------------------------------
	SELECT
		P.PersonID,
		P.Name,
		P.Relation,
		F.PersonFrequencyID,
		F.FrequencyStandard,
		F.FrequencyEdited,
		F.FrequencyIDFinal,
		F.FrequencyFinal,
		F.MonthsPerYearFinal
	FROM [dbo].[tf_Persons]() AS P
		INNER JOIN [dbo].[tf_Frequencies]() AS F
		ON F.PersonID = P.PersonID
	------------------------------------------

