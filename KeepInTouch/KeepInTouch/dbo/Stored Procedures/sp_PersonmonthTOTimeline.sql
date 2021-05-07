
-- KeepInTouch
-- CREATING PROCEDURE
------------------------------------
-- tb_TIMELINE
-- ADD NEW RECORDS based on tb_Person
------------------ triggered by INSERT in tb_Person

CREATE PROCEDURE [dbo].[sp_PersonmonthTOTimeline]

AS
BEGIN

	SET NOCOUNT ON;

	---------------------------------------------------
	-- delete everything first
	DELETE FROM tb_Timeline;

	---------------------------------------------------
	-- create person rows
	INSERT INTO tb_Timeline (PersonID)
	SELECT P.PersonID FROM tb_Person AS P
	WHERE NOT EXISTS (
		SELECT T.PersonID
		FROM tb_Timeline AS T
		WHERE T.PersonID = P.PersonID
		);

	---------------------------------------------------
	-- insert data
	MERGE tb_Timeline AS target
		USING vw_Month_Tr AS source
		ON source.PersonID = target.PersonID
		
	WHEN MATCHED THEN
		UPDATE SET
		Jan = source.Jan,
		Feb = source.Feb,
		Mar = source.Mar,
		Apr = source.Apr,
		May = source.May,
		Jun = source.Jun,
		Jul = source.Jul,
		Aug = source.Aug,
		Sep = source.Sep,
		Oct = source.Oct,
		Nov = source.Nov,
		Dec = source.Dec,
		MonthsPerYear = source.MonthsPerYear,
		Deficit = source.Deficit

	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([PersonID],[Jan],[Feb],[Mar],[Apr],[May],[Jun],[Jul],[Aug],[Sep],[Oct],[Nov],[Dec],[MonthsPerYear],[Deficit])
		VALUES (source.PersonID,source.Jan,source.Feb,source.Mar,source.Apr,source.May,source.Jun,source.Jul,source.Aug,source.Sep,source.Oct,source.Nov,source.Dec, source.MonthsPerYear, source.Deficit);
	---------------------------------------------------

END
