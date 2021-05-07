
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- Reset table tb_PersonFrequency

CREATE PROCEDURE [dbo].[sp_PersonFrequencyRESET]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	DELETE FROM tb_PersonFrequency;
	--------------------------------------------------

END
