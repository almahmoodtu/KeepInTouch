
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_YearEvent
-- ADD NEW RECORDS based on tb_Year, tb_Event
------------------ triggered by INSERT in tb_Year, tb_Event

CREATE PROCEDURE [dbo].[sp_YearEventADD]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	INSERT INTO tb_YearEvent (YearID, EventID, Day, Month)

	SELECT Y.YearID, E.EventID, E.Day, E.Month
	FROM tb_Year AS Y
	CROSS JOIN tb_Event AS E

	WHERE NOT EXISTS (
		SELECT YE.YearID, YE.EventID
		FROM tb_YearEvent AS YE
		WHERE YE.YearID = Y.YearID AND YE.EventID = E.EventID
		);
	--------------------------------------------------

END
