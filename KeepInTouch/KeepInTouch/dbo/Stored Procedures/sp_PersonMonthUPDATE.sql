
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_PersonMonth
-- UPDATE RECORDS based on tb_PersonEvent, tb_PersonAnniversary
------------------ triggered by UPDATE/DELETE in tb_PersonEvent, tb_PersonAnniversary

CREATE PROCEDURE [dbo].[sp_PersonMonthUPDATE]

	@PersonID as int, -->> TAKE INPUT
	@MonthID as int, -->> TAKE INPUT
	@Reference as int, -->> TAKE INPUT
	@Table as bit, -->> TAKE INPUT ... 1 means Anniversary, 0 means Event
	@Task as bit -->> TAKE INPUT ... 1 means ADD/EDIT, 0 means DELETE

AS
BEGIN

	SET NOCOUNT ON;

	--------------------------------------------------------------Check which table to work on
	DECLARE @Description as nvarchar(500);
	IF @Table = 1 -->> 1 means Anniversary
		BEGIN
		SELECT @Description = Anniversary FROM tb_Anniversary WHERE AnniversaryID = @Reference
		END
	IF @Table = 0 -->> 0 means Event
		BEGIN
		SELECT @Description = Event, @MonthID = Month FROM tf_EventsThisYear() WHERE EventID = @Reference;
		END	

	--------------------------------------------------------------Check whether to Add/Edit or Delete
	-- CONCAT
	-- triggered by UPDATE in tb_PersonEvent, tb_PersonAnniversary
	IF @Task = 1
		BEGIN
		UPDATE tb_PersonMonth SET Description = CONCAT(Description, '/', @Description) WHERE PersonID = @PersonID AND MonthID = @MonthID
		END

	-- REPLACE
	-- triggered by DELETE in tb_PersonEvent, tb_PersonAnniversary
	IF @Task = 0
		BEGIN
		SET @Description = '/' + @Description
		UPDATE tb_PersonMonth SET Description = REPLACE(Description, @Description, '') WHERE PersonID = @PersonID AND MonthID = @MonthID
		END
	--------------------------------------------------

END
