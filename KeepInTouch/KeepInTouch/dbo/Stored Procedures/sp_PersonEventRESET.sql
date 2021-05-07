
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- Reset table tb_PersonEvent

CREATE PROCEDURE [dbo].[sp_PersonEventRESET]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	UPDATE tb_PersonEvent
	SET Selected = 0
	--------------------------------------------------

END
