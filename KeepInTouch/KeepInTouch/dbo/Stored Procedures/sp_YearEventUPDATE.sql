
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_YearEvent
-- UPDATE RECORDS based on tb_Event
------------------ triggered by UPDATE in tb_Event

CREATE PROCEDURE [dbo].[sp_YearEventUPDATE]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	DECLARE @YearID int;
	SELECT @YearID = YearID from tb_Year WHERE Year =  YEAR(GETDATE())

	MERGE tb_YearEvent AS target
		USING tb_Event AS source
		ON source.EventID = target.EventID
		
		WHEN MATCHED AND YearID = @YearID THEN
		UPDATE SET Day = source.Day, Month = source.Month;
	--------------------------------------------------

END
