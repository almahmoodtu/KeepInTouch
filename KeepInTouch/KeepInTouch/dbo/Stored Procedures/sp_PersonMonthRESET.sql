
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- Reset table tb_PersonMonth

CREATE PROCEDURE [dbo].[sp_PersonMonthRESET]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	DELETE FROM tb_PersonMonth;
	--------------------------------------------------

END
