
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Anniversaries

CREATE VIEW [dbo].[vw_Anniversary_All]
AS

	------------------------------------------
	SELECT
		P.PersonID,
		P.Name,
		P.Relation,
		A.PersonAnniversaryID,
		A.AnniversaryID,
		A.Anniversary,
		A.Day,
		A.Month,
		A.Year,
		A.Age
	FROM [dbo].[tf_Persons]() AS P
		INNER JOIN [dbo].[tf_Anniversaries]() AS A
		ON A.PersonID = P.PersonID
	------------------------------------------

