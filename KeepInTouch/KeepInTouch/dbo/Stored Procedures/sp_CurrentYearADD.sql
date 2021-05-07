
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- Add current year to system IF does not exist

CREATE PROCEDURE [dbo].[sp_CurrentYearADD]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	BEGIN
	   IF NOT EXISTS 
		(SELECT * 
		FROM tb_Year 
		WHERE Year = YEAR(GETDATE())
		)

		BEGIN
			INSERT INTO tb_Year (Year)
			VALUES (YEAR(GETDATE()))
		END
	END
	--------------------------------------------------

END
