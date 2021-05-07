

-- KeepInTouch
-- CREATING SCALAR FUNCTION
------------------------------------
-- Get this year's events

CREATE FUNCTION [dbo].[tf_EventsThisYear] () 

RETURNS TABLE 
AS
RETURN 
(

	------------------------------------------
	SELECT
		YE.YearEventID, 
		YE.EventID, 
		E.Event, 
		YE.Day, 
		YE.Month, 
		Y.Year

	FROM
		dbo.tb_YearEvent AS YE
			INNER JOIN dbo.tb_Year AS Y
				ON YE.YearID = Y.YearID 
			INNER JOIN dbo.tb_Event AS E
				ON YE.EventID = E.EventID

	WHERE Year = YEAR(GETDATE())
	------------------------------------------

)
