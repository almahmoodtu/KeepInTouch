

-- KeepInTouch
-- CREATING SCALAR FUNCTION
------------------------------------
-- Get all Persons including Relations

CREATE FUNCTION [dbo].[tf_Persons]()

RETURNS TABLE 
AS
RETURN 
(
	------------------------------------------
	SELECT
		P.PersonID,
		P.Name, 
		R.Relation
	FROM
		dbo.tb_Person AS P
		INNER JOIN dbo.tb_Relation AS R
			ON P.RelationID = R.RelationID
	------------------------------------------
)
