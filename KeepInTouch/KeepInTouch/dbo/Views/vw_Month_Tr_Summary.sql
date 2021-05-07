
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Month transposed - WORK FILE

CREATE VIEW [dbo].[vw_Month_Tr_Summary]
AS

	------------------------------------------
	SELECT 
		PE.PersonID,
		(SELECT COUNT(Description) FROM vw_Month_All WHERE PersonID = PE.PersonID AND Description LIKE '/%') AS FilledSystem,
		(SELECT COUNT(Description) FROM vw_Month_All WHERE PersonID = PE.PersonID AND Description LIKE 'M%') AS FilledManual,
		(SELECT COUNT(Description) FROM vw_Month_All WHERE PersonID = PE.PersonID) AS FilledTotal
	FROM vw_Month_All AS PE
	GROUP BY PersonID;
	------------------------------------------

