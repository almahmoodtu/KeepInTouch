
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Events

CREATE VIEW [dbo].[vw_Event_All]
AS

	------------------------------------------
	SELECT
		P.PersonID,
		P.Name,
		P.Relation,
		E.PersonEventID,
		E.EventID,
		E.Event,
		E.Day,
		E.Month,
		E.Year,
		E.Selected
	FROM [dbo].[tf_Persons]() AS P
		INNER JOIN [dbo].[tf_Events]() AS E
		ON E.PersonID = P.PersonID
	------------------------------------------

