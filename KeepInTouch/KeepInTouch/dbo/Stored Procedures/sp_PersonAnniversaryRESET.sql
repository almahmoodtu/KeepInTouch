
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- Reset table tb_PersonAnniversary

CREATE PROCEDURE [dbo].[sp_PersonAnniversaryRESET]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	DELETE FROM tb_PersonAnniversary;
	--------------------------------------------------

END
