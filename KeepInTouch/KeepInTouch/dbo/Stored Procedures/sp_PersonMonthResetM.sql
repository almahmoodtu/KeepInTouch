
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_PersonMonth
-- AUTOMATICALLY REMOVE "M" in TB_PERSONMONTH for all rows

CREATE PROCEDURE [dbo].[sp_PersonMonthResetM]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	UPDATE tb_PersonMonth
	SET Description = NULL
	WHERE Description = 'M';
	--------------------------------------------------

END
