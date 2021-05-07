

-- KeepInTouch
-- CREATING SCALAR FUNCTION
------------------------------------
-- Get all Frequencies

CREATE FUNCTION [dbo].[tf_Frequencies] ()   

RETURNS TABLE 
AS
RETURN 
(

	------------------------------------------
	SELECT
		PF.PersonFrequencyID,
		P.PersonID,
		F1.Frequency AS FrequencyStandard,
		F2.Frequency AS FrequencyEdited,
		CASE
			WHEN F2.Frequency IS NULL
			THEN F1.FrequencyID
			ELSE F2.FrequencyID
			END AS 'FrequencyIDFinal',
		CASE
			WHEN F2.Frequency IS NULL
			THEN F1.Frequency
			ELSE F2.Frequency
			END AS 'FrequencyFinal',
		CASE
			WHEN F2.Frequency IS NULL
			THEN F1.MonthsPerYear
			ELSE F2.MonthsPerYear
			END AS 'MonthsPerYearFinal'
	FROM
		dbo.tb_Person AS P
			INNER JOIN dbo.tb_Relation AS R
				ON P.RelationID = R.RelationID 
			INNER JOIN dbo.tb_Frequency AS F1
				ON R.FrequencyID = F1.FrequencyID 
			LEFT OUTER JOIN dbo.tb_PersonFrequency AS PF
				ON P.PersonID = PF.PersonID
			LEFT OUTER JOIN dbo.tb_Frequency AS F2
				ON PF.FrequencyID = F2.FrequencyID
	------------------------------------------

)
