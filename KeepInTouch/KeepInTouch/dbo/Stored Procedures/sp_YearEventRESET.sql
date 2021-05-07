
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- Reset table tb_YearEvent

CREATE PROCEDURE [dbo].[sp_YearEventRESET]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	DELETE FROM tb_YearEvent;
	--------------------------------------------------

END
