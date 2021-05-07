
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_PERSONMONTH
-- ADD NEW RECORDS based on tb_Timeline

CREATE PROCEDURE [dbo].[sp_TimelineTOPersonmonth]

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------
	DECLARE @PersonID AS INT;
	DECLARE @TotalPersons AS INT;
	DECLARE @Description AS NVARCHAR(MAX);

	SET @PersonID = 1;
	SELECT @TotalPersons = MAX(PersonID) FROM tb_Person;

	--------------------------------------------------
	WHILE(@PersonID <= @TotalPersons)
	BEGIN
		
		SELECT @Description = Jan FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 1 END	
			SET @Description = '';
		
		SELECT @Description = Feb FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 2 END	
			SET @Description = '';

		SELECT @Description = Mar FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 3 END	
			SET @Description = '';

		SELECT @Description = Apr FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 4 END	
			SET @Description = '';

		SELECT @Description = May FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 5 END	
			SET @Description = '';

		SELECT @Description = Jun FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 6 END	
			SET @Description = '';

		SELECT @Description = Jul FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 7 END	
			SET @Description = '';

		SELECT @Description = Aug FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 8 END	
			SET @Description = '';

		SELECT @Description = Sep FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 9 END	
			SET @Description = '';

		SELECT @Description = Oct FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 10 END	
			SET @Description = '';

		SELECT @Description = Nov FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 11 END	
			SET @Description = '';

		SELECT @Description = Dec FROM tb_Timeline WHERE PersonID = @PersonID
		IF @Description = 'M'
			BEGIN UPDATE tb_PersonMonth SET Description = 'M' WHERE PersonID = @PersonID AND MonthID = 12 END	
			SET @Description = '';

		SET @PersonID = @PersonID  + 1
	END;
	--------------------------------------------------
END
