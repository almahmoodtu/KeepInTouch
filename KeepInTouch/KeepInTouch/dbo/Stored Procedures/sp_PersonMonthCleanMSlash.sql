
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_PersonMonth
-- AUTOMATICALLY REMOVE "M" in TB_PERSONMONTH in cases like M/Birthday

CREATE PROCEDURE [dbo].[sp_PersonMonthCleanMSlash]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	UPDATE tb_PersonMonth
	SET Description = CASE WHEN Description LIKE 'M/%' THEN RIGHT(Description, LEN(Description) - 1) ELSE Description END;
	--------------------------------------------------

END
