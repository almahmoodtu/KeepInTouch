

-- KeepInTouch
-- CREATING SCALAR FUNCTION
------------------------------------
-- Get all Events

CREATE FUNCTION [dbo].[tf_Events] ()   

RETURNS TABLE 
AS
RETURN 
(

	------------------------------------------
	SELECT
		PE.PersonEventID,
		PE.PersonID,
		PE.EventID,
		ETY.Event, 
		ETY.Day, 
		ETY.Month, 
		ETY.Year,
		PE.Selected
	FROM
		dbo.tb_PersonEvent AS PE
			INNER JOIN dbo.[tf_EventsThisYear]() AS ETY
				ON PE.EventID = ETY.EventID
	------------------------------------------

)
