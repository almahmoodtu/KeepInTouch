
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_PersonMonth
-- AUTOMATICALLY SET "M" in TB_PERSONMONTH where MONTHSPERYEAR = 12 and does not contain SYSTEM EVENT/ANNIVERSARY
-- and remove M where MONTHSPERYEAR = 0

CREATE PROCEDURE [dbo].[sp_PersonMonthAutosetM]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	DECLARE @PersonID AS INT;
	DECLARE @TotalPersons AS INT;
	DECLARE @MonthsPerYear AS INT;

	SET @PersonID = 1;
	SELECT @TotalPersons = MAX(PersonID) FROM tb_Person;

	--------------------------------------------------
	WHILE(@PersonID <= @TotalPersons)
	BEGIN
		SELECT @MonthsPerYear = MonthsPerYear FROM vw_Month_Tr WHERE @PersonID = PersonID

		IF @MonthsPerYear = 12
			BEGIN
				UPDATE tb_PersonMonth
				SET Description = CASE WHEN Description LIKE '/%' THEN Description ELSE 'M' END
				WHERE PersonID = @PersonID
			END

		IF @MonthsPerYear = 0
		BEGIN
			UPDATE tb_PersonMonth
			SET Description = NULL
			WHERE PersonID = @PersonID AND Description = 'M';
		END

		SET @PersonID = @PersonID  + 1
	END;
	--------------------------------------------------

END
