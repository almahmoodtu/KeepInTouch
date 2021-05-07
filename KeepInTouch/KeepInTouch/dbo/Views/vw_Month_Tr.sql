
-- KeepInTouch
-- CREATING VIEW
------------------------------------
-- Month transposed

CREATE VIEW [dbo].[vw_Month_Tr]
AS

	------------------------------------------
	SELECT
		P.PersonID,
		P.Name,
		P.Relation,
		P.FrequencyFinal AS Frequency,
		P.MonthsPerYearFinal AS MonthsPerYear,

		D.Jan, D.Feb, D.Mar, D.Apr, D.May, D.Jun, D.Jul, D.Aug, D.Sep, D.Oct, D.Nov, D.Dec,

		S.FilledSystem, S.FilledManual, S.FilledTotal,

		P.MonthsPerYearFinal - S.FilledTotal AS Deficit
	FROM
		vw_Frequency_All AS P
		LEFT JOIN vw_Month_Tr_Description AS D
			ON P.PersonID = D.PersonID
		LEFT JOIN vw_Month_Tr_Summary AS S
			ON P.PersonID = S.PersonID
	------------------------------------------

